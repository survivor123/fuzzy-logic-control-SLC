clear all;
close all;
clc; 
%----------------------- RANGE OF INPUT/OUTPUT MEASUREMENT-----------------------
xx = 0:90;
yy = 0:18;
zz = 0:100;
bb = 0:100;
cc = 0:100;
%----------------------- MEMBRESY FUNCTION OF TEMPERATURE---------------------------------
as = 0.7;
cs = 20;
sigmoide1 = 1 ./ ( 1+( exp(-as.*(xx-cs)) ) );
sigmoide11 = 1 - sigmoide1;

as2 = 10.7;
cs2 = 35;
sigmoide2 =  exp(-(xx-cs2).^2./(2*as2^2) );

as2 = 0.7;
cs2 = 65;
sigmoide21 = 1 ./ ( 1+( exp(-as2.*(xx-cs2)) ) );
%------------------MEMBRESY FUNCTION OF LEVEL WATER --------------------------
as3 = 2.2;
cs3 = 3;
sigmoide3 = 1 ./ ( 1+( exp(-as3.*(yy-cs3)) ) );
sigmoide33 = 1 - sigmoide3;
as4 = 2.2;
cs4 = 8;
sigmoide4 = exp(-(yy-cs4).^2./(2*as4^2) );
as4 = 2.2;
cs4 = 15;
sigmoide42 = 1 ./ ( 1+( exp(-as4.*(yy-cs4)) ) );
%------------------MEN¿MBRESY FUNCTION OF VALVE OPENNING--------------------------------
as5 = 0.7;
cs5 = 30;
sigmoide5 = 1 ./ ( 1+( exp(-as5.*(zz-cs5)) ) );
sigmoide55 = 1 - sigmoide5;
as6 = 10.2;
cs6 = 50;
sigmoide6 = exp(-(zz-cs6).^2./(2*as6^2) );
as7 = 0.7;
cs7 = 70;
sigmoide63 = 1 ./ ( 1+( exp(-as7.*(bb-cs7)) ) );
%------------------MEMBRESY FUNCTION OF PUMP--------------------------------
as8 = 0.7;
cs8 = 30;
sigmoide7 = 1 ./ ( 1+( exp(-as8.*(bb-cs8)) ) );
sigmoide77 = 1 - sigmoide7;
as9 = 10.2;
cs9 = 50;
sigmoide8 = exp(-(bb-cs9).^2./(2*as9^2) );
as10 = 0.7;
cs10 = 70;
sigmoide84 = 1 ./ ( 1+( exp(-as10.*(bb-cs10)) ) );
%------------------MEMBRESY FUNCTION OF HEATER--------------------------------
as11 = 0.07;
cs11 = 20;
sigmoide9 = exp(-(cc-cs11).^2./(2*as11^2) );
as12 = 0.07;
cs12 = 80;
sigmoide10 = exp(-(cc-cs12).^2./(2*as12^2) );

%-------------------- PLOTTING FUZZIFICATION FUNCTIONS --------------------------
%input--------------------------------------------------------------------
figure(1);
subplot(2,1,1);  
plot(xx, sigmoide11, xx, sigmoide2,xx, sigmoide21);            
title('Temperatura');   
ylabel('Grado membresia');
xlabel('º'); 
ylim([-.1 1.1]);
xlim([0 90]);
lgd = legend('A1','A2','A3');
grid on;
subplot(2,1,2);
plot(yy, sigmoide33, yy, sigmoide4, yy, sigmoide42);            
title('Nivel');   
ylabel('Grado membresia');
xlabel('m'); 
ylim([-.1 1.1]);
xlim([0 18]);
lgd = legend('B1','B2','B3');
grid on;
%Output--------------------------------------------------------------------
figure(2);
subplot(3,1,1);    
plot(zz, sigmoide55, zz, sigmoide6, zz, sigmoide63);            
title('Valvula');   
ylabel('Grado membresia');
xlabel('%'); 
ylim([-.1 1.1]);
lgd = legend('C1','C2','C3');
grid on;
subplot(3,1,2);    
plot(bb, sigmoide77, bb, sigmoide8, bb, sigmoide84);            
title('Blower');   
ylabel('Grado membresia');
xlabel('%'); 
ylim([-.1 1.1]);
lgd = legend('D1','D2','D3');
grid on;
subplot(3,1,3);    
plot(cc, sigmoide9, cc, sigmoide10);            
title('Resistencia');   
ylabel('Grado membresia');
xlabel('on/off'); 
ylim([-.1 1.1]);
lgd = legend('E1','E2','E3');
grid on;
%
%-------------------------- LOOP FOR FUZZY LOGIC -------------------------
conta = 1;
conta1 = 1;
conta2 = 1;
for x = 1:90
    for y = 1:18
        xsurfx(conta) = x;
        ysurfy(conta) = y;
        valorx1 = sigmoide11(x);
        valorx2 = sigmoide2(x);  
        valorx3 = sigmoide21(x);
        valory1 = sigmoide33(y); 
        valory2 = sigmoide4(y);  
        valory3 = sigmoide42(y);
        %------------------------------------------------------------------
        %RULES
        w1 = min(valorx1,valory1); %A1 Y B1 , C1
        w2 = min(valorx1,valory2); %A1 Y B2 , C2
        w21 = min(valorx1,valory3);
        
        w3 = min(valorx2,valory1); %A2 Y B1 , C1
        w4 = min(valorx2,valory2); %A2 Y B2 , C1
        w41 = min(valorx2,valory3);
        
        w5 = min(valorx3,valory1);
        w6 = min(valorx3,valory2);
        w61 = min(valorx3,valory3);
%--------------------  DEFUZIFICATION - VALVE --------------------------- 
%------------------------------------------------------------------------
        rangox = .85;
        ran = 101;    
        ii = 0;
        for i= 1:ran
             z1 = sigmoide55(i);
             if (w1 <= z1+(z1*rangox) && w1 >= z1-(z1*rangox))
                 ii = i;
                 break;
             end
        end
        z1 = ii; 
        
        ii = 0;
        for i= 1:ran
             z2 = sigmoide6(i);
             if (w2 <= z2+(z2*rangox) && w2 >= z2-(z2*rangox))
                 ii = i;
                 break;
             end
        end
        z2 = ii; 
     
         ii = 0;
        for i= 1:ran
             z21 = sigmoide63(i);
             if (w21 <= z21+(z21*rangox) && w21 >= z21-(z21*rangox))
                 ii = i;
                 break;
             end   
        end
        z21 = ii; 
 %---------------------------------------------------------------       
        ii = 0;
        for i= 1:ran
             z3 = sigmoide55(i);
             if (w3 <= z3+(z3*rangox) && w3 >= z3-(z3*rangox))
                 ii = i;
                 break;
             end
        end
        z3 = ii; 
        
        ii = 0;
        for i= 1:ran
             z4 = sigmoide6(i);
             if (w4 <= z4+(z4*rangox) && w4 >= z4-(z4*rangox))
                 ii = i;
                 break;
             end
        end
        z4 = ii;        
      
         ii = 0;
        for i= 1:ran
             z41 = sigmoide63(i);
             if (w41 <= z41+(z41*rangox) && w41 >= z41-(z41*rangox))
                 ii = i;
                 break;
             end
        end
        z41 = ii; 
%--------------------------------------------------------        
        ii = 0;
        for i= 1:ran
             z5 = sigmoide55(i);
             if (w5 <= z5+(z5*rangox) && w5 >= z5-(z5*rangox))
                 ii = i;
                 break;
             end
        end
        z5 = ii; 
        
        ii = 0;
        for i= 1:ran
             z6 = sigmoide6(i);
             if (w6 <= z6+(z6*rangox) && w6 >= z6-(z6*rangox))
                 ii = i;
                 break;
             end
        end
        z6 = ii; 
  
         ii = 0;
        for i= 1:ran
             z61 = sigmoide63(i);
             if (w61 <= z61+(z61*rangox) && w61 >= z61-(z61*rangox))
                 ii = i;
                 break;
             end
        end
        z61 = ii; 
 %---------------------------------------------------------------               
        zsum = ((w1.*z1)+(w2.*z2)+(w21.*z21)+(w3.*z3)+(w4.*z4)+(w41.*z41)+(w5.*z5)+(w6.*z6)+(w61.*z61))./(w1+w2+w21+w3+w4+w41+w5+w6+w61);
        zsurfz(conta)= zsum;
        conta = conta + 1;
        
%--------------------  DEFUZIFICATION - PUMP --------------------------- 
%------------------------------------------------------------------------
        rangox = .95;
        ran = 101;    
        ii = 0;
        for i= 1:ran
             z1 = sigmoide77(i);
             if (w1 <= z1+(z1*rangox) && w1 >= z1-(z1*rangox))
                 ii = i;
                 break;
             end
        end
        z1 = ii; 
        
        ii = 0;
        for i= 1:ran
             z2 = sigmoide77(i);
             if (w2 <= z2+(z2*rangox) && w2 >= z2-(z2*rangox))
                 ii = i;
                 break;
             end
        end
        z2 = ii; 
        
         ii = 0;
        for i= 1:ran
             z21 = sigmoide77(i);
             if (w21 <= z21+(z21*rangox) && w21 >= z21-(z21*rangox))
                 ii = i;
                 break;
             end
        end
        z21 = ii; 
 %---------------------------------------------------------------              
        ii = 0;
        for i= 1:ran
             z3 = sigmoide77(i);
             if (w3 <= z3+(z3*rangox) && w3 >= z3-(z3*rangox))
                 ii = i;
                 break;
             end
        end
        z3 = ii; 
        
        ii = 0;
        for i= 1:ran
             z4 = sigmoide77(i);
             if (w4 <= z4+(z4*rangox) && w4 >= z4-(z4*rangox))
                 ii = i;
                 break;
             end
        end
        z4 = ii;        
        
         ii = 0;
        for i= 1:ran
             z41 = sigmoide8(i);
             if (w41 <= z41+(z41*rangox) && w41 >= z41-(z41*rangox))
                 ii = i;
                 break;
             end
        end
        z41 = ii; 
%--------------------------------------------------------        
        ii = 0;
        for i= 1:ran
             z5 = sigmoide84(i);
             if (w5 <= z5+(z5*rangox) && w5 >= z5-(z5*rangox))
                 ii = i;
                 break;
             end
        end
        z5 = ii; 
        
        ii = 0;
        for i= 1:ran
             z6 = sigmoide84(i);
             if (w6 <= z6+(z6*rangox) && w6 >= z6-(z6*rangox))
                 ii = i;
                 break;
             end
        end
        z6 = ii; 
        
         ii = 0;
        for i= 1:ran
             z61 = sigmoide84(i);
             if (w61 <= z61+(z61*rangox) && w61 >= z61-(z61*rangox))
                 ii = i;
                 break;
             end
        end
        z61 = ii; 
 %---------------------------------------------------------------          
        zsum = ((w1.*z1)+(w2.*z2)+(w21.*z21)+(w3.*z3)+(w4.*z4)+(w41.*z41)+(w5.*z5)+(w6.*z6)+(w61.*z61))./(w1+w2+w21+w3+w4+w41+w5+w6+w61);
        zsurfz1(conta1)= zsum;
        conta1 = conta1 + 1;
    
%--------------------  DEFUZIFICATION - resistencia ----------------------- 
%--------------------------------------------------------------------------
        rangox = .95;
        ran = 101;    
        ii = 0;
        for i= 1:ran
             z1 = sigmoide9(i);
             if (w1 <= z1+(z1*rangox) && w1 >= z1-(z1*rangox))
                 ii = i;
                 break;
             end
        end
        z1 = ii; 
        
        ii = 0;
        for i= 1:ran
             z2 = sigmoide10(i);
             if (w2 <= z2+(z2*rangox) && w2 >= z2-(z2*rangox))
                 ii = i;
                 break;
             end
        end
        z2 = ii; 
   
         ii = 0;
        for i= 1:ran
             z21 = sigmoide10(i);
             if (w21 <= z21+(z21*rangox) && w21 >= z21-(z21*rangox))
                 ii = i;
                 break;
             end
        end
        z21 = ii; 
 %---------------------------------------------------------------             
        ii = 0;
        for i= 1:ran
             z3 = sigmoide9(i);
             if (w3 <= z3+(z3*rangox) && w3 >= z3-(z3*rangox))
                 ii = i;
                 break;
             end
        end
        z3 = ii; 
        
        ii = 0;
        for i= 1:ran
             z4 = sigmoide9(i);
             if (w4 <= z4+(z4*rangox) && w4 >= z4-(z4*rangox))
                 ii = i;
                 break;
             end
        end
        z4 = ii;        
      
         ii = 0;
        for i= 1:ran
             z41 = sigmoide10(i);
             if (w41 <= z41+(z41*rangox) && w41 >= z41-(z41*rangox))
                 ii = i;
                 break;
             end
        end
        z41 = ii; 
%--------------------------------------------------------        
        ii = 0;
        for i= 1:ran
             z5 = sigmoide9(i);
             if (w5 <= z5+(z5*rangox) && w5 >= z5-(z5*rangox))
                 ii = i;
                 break;
             end
        end
        z5 = ii; 
        
        ii = 0;
        for i= 1:ran
             z6 = sigmoide9(i);
             if (w6 <= z6+(z6*rangox) && w6 >= z6-(z6*rangox))
                 ii = i;
                 break;
             end
        end
        z6 = ii; 
     
         ii = 0;
        for i= 1:ran
             z61 = sigmoide10(i);
             if (w61 <= z61+(z61*rangox) && w61 >= z61-(z61*rangox))
                 ii = i;
                 break;
             end
        end
        z61 = ii; 
 %---------------------------------------------------------------          
        zsum = ((w1.*z1)+(w2.*z2)+(w21.*z21)+(w3.*z3)+(w4.*z4)+(w41.*z41)+(w5.*z5)+(w6.*z6)+(w61.*z61))./(w1+w2+w21+w3+w4+w41+w5+w6+w61);
        zsurfz2(conta2)= zsum;
        conta2 = conta2 + 1;
    end
end
%---------------------- GRAPHICS-------------------------------------
figure(3)
zzzx = zsurfz;
tri = delaunay(xsurfx,ysurfy);
trisurf(tri,xsurfx,ysurfy,zzzx);
trisurf(tri,xsurfx,ysurfy,zzzx);
xlabel('Temperature');
ylabel('Level');
zlabel('Valve');
title('Valve Control');

figure(4)
zzzx1 = zsurfz1;
tri1 = delaunay(xsurfx,ysurfy); %x,y,z column vectors
trisurf(tri1,xsurfx,ysurfy,zzzx1);
xlabel('Temperature');
ylabel('level');
zlabel('Pump');
title('Pump Control')

figure(5)
zzzx2 = zsurfz2;
tri2 = delaunay(xsurfx,ysurfy); %x,y,z column vectors
trisurf(tri2,xsurfx,ysurfy,zzzx2);
xlabel('Temperature');
ylabel('Level');
zlabel('Heater');
title('Heater Control')
%--------------------------------------------------------------------------