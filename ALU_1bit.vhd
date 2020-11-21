library ieee;
use ieee.std_logic_1164.all;

entity ALU_1bit is
port( op: in std_logic_vector(1 downto 0);
      a: in std_logic;
      b: in std_logic;
      binv: in std_logic;
      cin: in std_logic;
      cout: out std_logic;
      result: out std_logic
     );
end ALU_1bit;


architecture struct of ALU_1bit is

   --use previously designed subcomponents
   component AND_gate is
   port( a: in std_logic;
         b: in std_logic;
         c: out std_logic
        );
   end component;

   component OR_gate is
   port( a: in std_logic;
         b: in std_logic;
         c: out std_logic
        );
   end component;

   component NOT_gate is
    port( a: in std_logic;
          b: out std_logic
         );
   end component;
   
   component MUX_2x1 is
   port( a: in std_logic;
         b: in std_logic;
         sel: in std_logic;
         c: out std_logic
        );
   end component;

   component FULLADDER is
   port( x1: in std_logic;
         x2: in std_logic;
         cin: in std_logic;
         sum: out std_logic;
         cout: out std_logic
        );
    end component;


    component MUX_4x1 is
    port( op: in std_logic_vector(1 downto 0);
      a: in std_logic;
      b: in std_logic;
      c: in std_logic;
      d: in std_logic;
      result: out std_logic
     );
     end component;

   signal temp1: std_logic;
   signal temp2: std_logic;
   signal temp3: std_logic;
   signal temp4: std_logic;
   signal notB: std_logic;

begin
   
   --map signals of the outer component to subcomponents - idea of parameter passing

   map_NOT_gate: NOT_gate port map (b, notB);
   map_MUX_2x1: MUX_2x1 port map (b, notB, binv, temp4); --need to check
   map_AND_gate: AND_gate port map (a, temp4, temp1);
   
   map_OR_gate: OR_gate port map (a, temp4, temp2);
   map_FULLADDER: FULLADDER port map (a, temp4, cin, temp3, cout); --Might need to check

   map_MUX_4x1: MUX_4x1 port map (op, temp1, temp2, temp3, '0', result);

end struct;