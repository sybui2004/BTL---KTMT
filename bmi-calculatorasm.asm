.MODEL SMALL
.STACK 100H
.DATA 
  MSA DB '==================== WELCOME TO OUR PROJECT ====================$' 
  MSB DB 13, 10, '******************** BMI CALCULATOR ********************$'
  
  MSD DB 13, 10, ' Input your height in cm: $'
  MSE DB 13, 10, ' Input your weight in kg: $'
  
  MSOver DB 13, 10, ' You are now over weight! $'
  MSPerfect DB 13, 10, ' Your weight is perfect! $'
  MSUnder DB 13, 10, ' You are now under weight! $'
  
  MSUnder1 DB 13, 10, ' 1.Eat more and sleep 8 hours a day.$'
  MSUnder2 DB 13, 10, ' 2.Absorb high calorie food (potato, brown rice, chicken breast, check peas, almond, sweet potato etc.)$'
  MSUnder3 DB 13, 10, ' 3.Drink at least 3 liters water per day.$'
  MSUnder4 DB 13, 10, ' 4.Eat vegetables and 1 glass of milk and 1 whole egg each day.$'
  
  MSOver1 DB 13, 10, ' 1.Try to follow a low calorie healthy diet mode.$'
  MSOver2 DB 13, 10, ' 2.Eat high protein, vegetables and avoid fast food.$'
  MSOver3 DB 13, 10, ' 3.Do some workout for weight lose (walking, running, ropping, swimming).$' 
  
  MSPer  DB 13, 10, ' Congratulation..! Always eat and exercise moderately to keep your health.$'
  
  MSM1 DB 13, 10, ' Press 1 to RECALCULATE.$'  
  
  MSM2 DB 13, 10, ' Press 2 to EXIT.$'
   
  MSM3 DB 13, 10, '          ********THANK YOU********$'
  MSM4 DB 13, 10, ' Thank you for using BMI calculator!$'
  So10 EQU 10
  CRLF DB 13, 10, '$'
  
  USER_HEIGHT DD ?
  USER_WEIGHT DD ?
.CODE               
    COUT MACRO P1
        LEA DX, P1
        MOV AH, 9
        INT 21H
    ENDM
    
    MAIN PROC       
        MOV AX,@DATA
        MOV DS,AX
    
        COUT MSA
        COUT MSB
    
        START:
            COUT CRLF
    
            COUT MSD
           
            MOV BX, 0
            MOV CX, 0
            MOV DX, 10
            MOV USER_HEIGHT, 0
            MOV USER_WEIGHT, 0
         
        HEIGHT:
        
            MOV AX, 0
            MOV AH, 1
            INT 21H   
        
            CMP AL,13 
            JE END_HEIGHT
       
            MOV AH, 0
            SUB AL, '0'
            PUSH AX
            MOV AX, 10
            MUL BX
            MOV BX, AX
            POP AX
            ADD BX, AX   
       
            JMP HEIGHT
    
        END_HEIGHT:
            COUT CRLF
            COUT MSE
    
            MOV USER_HEIGHT,BX
            MOV BX, 0
            MOV AX, 0
     
        WEIGHT:
            MOV AH,1
            INT 21H
    
            CMP AL, 13
            JE END_WEIGHT
    
            MOV AH, 0
            SUB AL, '0'
            PUSH AX
            MOV AX, 10
            MUL BX
            MOV BX,AX
            POP AX
            ADD BX,AX
    
            JMP WEIGHT
     
        END_WEIGHT:
            MOV AX, BX; AX la W
            MOV BX, 100 ; BX = 100
            MUL BX ; AX = W * 100
            MOV CX, AX ;CX = W * 100
            MOV AX, USER_HEIGHT
            MUL USER_HEIGHT ; AX la H ^ 2
            DIV BX  ; AX = H^2 / 100
            MOV BX, AX; BX = H^2 / 100
            MOV AX, CX; AX = W * 100
            MOV DX, 10; DX = 10 
            MUL DX    ; AX = W * 1000
            DIV BX    ; AX = W * 1000 / (H^2/100) =10 *  W / H^2   (Vi luc nay H da doi tu cm sang m)
            
            CMP AX, 250
            JGE OVER   
            
            CMP AX, 185
            JLE UNDER
            
            JMP PERFECT
    
        OVER:
            COUT CRLF
            COUT MSOver
            COUT MSOver1
            COUT MSOver2
            COUT MSOver3
            JMP EXIT
    
        PERFECT:
            COUT CRLF
            COUT MSPerfect
            COUT MSPer
            JMP EXIT
     
        UNDER:
            COUT CRLF
            COUT MSUnder
            COUT MSUnder1
            COUT MSUnder2
            COUT MSUnder3
            JMP EXIT
    
        EXIT:
            MOV AX,0
            COUT CRLF
            COUT MSM4 
            COUT MSM1
            COUT MSM2
            COUT CRLF
    
            MOV AH,1
            INT 21H
    
            CMP AL,'1'
            JE START
            COUT CRLF
    
            COUT MSM3
     
            MOV AH,4CH
            INT 21H
             
    MAIN ENDP 
END MAIN