Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814397A2F9A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 13:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbjIPLOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 07:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239251AbjIPLOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:14:04 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E419CC4;
        Sat, 16 Sep 2023 04:13:27 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D9AD240002;
        Sat, 16 Sep 2023 11:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694862806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h68im17ZsTltgdDllQ9qqFghqW30sH1nXTjgiWPgu0s=;
        b=IeqUdIOdP7dL0pkj13xi7r0fav2LpFGMHvYeKgZRvrtBvaacK1H7M4o7C8dKW6qwvCP0YZ
        ZvUacH0ocJcOymCzkAmr9aekHHCHGGmd4p4uaSs/kRMhWWwiBaW5pA292yIgOp61DqDO0t
        TyKuwDpFxoxEmqsiNOUT0mzbXXdGnNnQ9VW/Y9QVRvb3ecfazZ0cGB5PYhamopOr3kG1zw
        fJGHsVySyaMn1mDhrl1x8ltUOzpBqM7QHk7n0cf5xjGap074q3tAaOF8R/KkKZCQipePUL
        SreJ1h+gAhCmCsIeDBeoa9qs58h/0LJqTIw8AWk7TrrMOuK2a74MUrsa46yJ3A==
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        George McCollister <george.mccollister@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Marek Vasut <marex@denx.de>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Crispin <john@phrozen.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     Woojung Huh <Woojung.Huh@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v2 08/10] dt-bindings: net: dsa: marvell: convert to json-schema
Date:   Sat, 16 Sep 2023 14:09:00 +0300
Message-Id: <20230916110902.234273-9-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230916110902.234273-1-arinc.unal@arinc9.com>
References: <20230916110902.234273-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the document for Marvell ethernet switches to json-schema.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../devicetree/bindings/net/dsa/marvell.txt   | 109 ----------
 .../devicetree/bindings/net/dsa/marvell.yaml  | 204 ++++++++++++++++++
 2 files changed, 204 insertions(+), 109 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/dsa/marvell.txt
 create mode 100644 Documentation/devicetree/bindings/net/dsa/marvell.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/marvell.txt b/Documentation/devicetree/bindings/net/dsa/marvell.txt
deleted file mode 100644
index 6ec0c181b6db..000000000000
--- a/Documentation/devicetree/bindings/net/dsa/marvell.txt
+++ /dev/null
@@ -1,109 +0,0 @@
-Marvell DSA Switch Device Tree Bindings
----------------------------------------
-
-WARNING: This binding is currently unstable. Do not program it into a
-FLASH never to be changed again. Once this binding is stable, this
-warning will be removed.
-
-If you need a stable binding, use the old dsa.txt binding.
-
-Marvell Switches are MDIO devices. The following properties should be
-placed as a child node of an mdio device.
-
-The properties described here are those specific to Marvell devices.
-Additional required and optional properties can be found in dsa.txt.
-
-The compatibility string is used only to find an identification register,
-which is at a different MDIO base address in different switch families.
-- "marvell,mv88e6085"	: Switch has base address 0x10. Use with models:
-			  6085, 6095, 6097, 6123, 6131, 6141, 6161, 6165,
-			  6171, 6172, 6175, 6176, 6185, 6240, 6320, 6321,
-			  6341, 6350, 6351, 6352
-- "marvell,mv88e6190"	: Switch has base address 0x00. Use with models:
-			  6190, 6190X, 6191, 6290, 6361, 6390, 6390X
-- "marvell,mv88e6250"	: Switch has base address 0x08 or 0x18. Use with model:
-			  6220, 6250
-
-Required properties:
-- compatible		: Should be one of "marvell,mv88e6085",
-			  "marvell,mv88e6190" or "marvell,mv88e6250" as
-			  indicated above
-- reg			: Address on the MII bus for the switch.
-
-Optional properties:
-
-- reset-gpios		: Should be a gpio specifier for a reset line
-- interrupts		: Interrupt from the switch
-- interrupt-controller	: Indicates the switch is itself an interrupt
-			  controller. This is used for the PHY interrupts.
-#interrupt-cells = <2>	: Controller uses two cells, number and flag
-- eeprom-length		: Set to the length of an EEPROM connected to the
-			  switch. Must be set if the switch can not detect
-			  the presence and/or size of a connected EEPROM,
-			  otherwise optional.
-- mdio			: Container of PHY and devices on the switches MDIO
-			  bus.
-- mdio?		: Container of PHYs and devices on the external MDIO
-			  bus. The node must contains a compatible string of
-			  "marvell,mv88e6xxx-mdio-external"
-
-Example:
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-
-		switch0: switch@0 {
-			compatible = "marvell,mv88e6085";
-			reg = <0>;
-			reset-gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
-
-			mdio {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				switch1phy0: switch1phy0@0 {
-					reg = <0>;
-					interrupt-parent = <&switch0>;
-					interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
-				};
-			};
-		};
-	};
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-
-		switch0: switch@0 {
-			compatible = "marvell,mv88e6190";
-			reg = <0>;
-			reset-gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
-
-			mdio {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				switch1phy0: switch1phy0@0 {
-					reg = <0>;
-					interrupt-parent = <&switch0>;
-					interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
-				};
-			};
-
-			mdio1 {
-				compatible = "marvell,mv88e6xxx-mdio-external";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				switch1phy9: switch1phy0@9 {
-					reg = <9>;
-				};
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/net/dsa/marvell.yaml b/Documentation/devicetree/bindings/net/dsa/marvell.yaml
new file mode 100644
index 000000000000..45756b8d74d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/marvell.yaml
@@ -0,0 +1,204 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/marvell.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Ethernet Switches
+
+$ref: dsa.yaml#/$defs/ethernet-ports
+
+maintainers:
+  - Andrew Lunn <andrew@lunn.ch>
+  - Arınç ÜNAL <arinc.unal@arinc9.com>
+
+description:
+  Marvell ethernet switches are MDIO devices.
+
+properties:
+  compatible:
+    oneOf:
+      - description: |
+          Switch has base address 0x10. Use with models:
+          6085, 6095, 6097, 6123, 6131, 6141, 6161, 6165, 6171, 6172, 6175,
+          6176, 6185, 6240, 6320, 6321, 6341, 6350, 6351, 6352
+        const: marvell,mv88e6085
+
+      - description: |
+          Switch has base address 0x00. Use with models:
+          6190, 6190X, 6191, 6290, 6361, 6390, 6390X
+        const: marvell,mv88e6190
+
+      - description: |
+          Switch has base address 0x08 or 0x18. Use with models:
+          6220, 6250
+        const: marvell,mv88e6250
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description: GPIO to be used to reset the whole device
+    maxItems: 1
+
+  "#interrupt-cells":
+    const: 2
+
+  interrupt-controller: true
+
+  interrupts:
+    maxItems: 1
+
+  eeprom-length:
+    description:
+      Set to the length of an EEPROM connected to the switch. Must be set if the
+      switch can not detect the presence and/or size of a connected EEPROM,
+      otherwise optional.
+
+  mdio:
+    description:
+      The optional node for the MDIO bus of the switch. The bus will be
+      registered non-OF-based if this is not defined.
+    $ref: /schemas/net/mdio.yaml#
+
+  mdio-external:
+    description: The externally reachable MDIO bus of the 6390 family switches
+    $ref: /schemas/net/mdio.yaml#
+
+    properties:
+      compatible:
+        const: marvell,mv88e6xxx-mdio-external
+
+    required:
+      - compatible
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - marvell,mv88e6085
+            - marvell,mv88e6250
+    then:
+      properties:
+        mdio-external: false
+
+  - if:
+      required: [ mdio ]
+    then:
+      patternProperties:
+        "^(ethernet-)?ports$":
+          patternProperties:
+            "^(ethernet-)?port@[0-9]+$":
+              $ref: /schemas/net/ethernet-controller.yaml#/$defs/phylink
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        switch@0 {
+            compatible = "marvell,mv88e6085";
+            reg = <0>;
+            reset-gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
+
+            ethernet-ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    phy-mode = "rmii";
+                    ethernet = <&fec1>;
+
+                    fixed-link {
+                        speed = <100>;
+                        full-duplex;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    label = "swp1";
+                };
+            };
+        };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        switch: switch@0 {
+            compatible = "marvell,mv88e6190";
+            reg = <0>;
+            reset-gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
+            interrupt-parent = <&gpio3>;
+            interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+
+            ethernet-ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    phy-mode = "rmii";
+                    ethernet = <&fec1>;
+
+                    fixed-link {
+                        speed = <100>;
+                        full-duplex;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    label = "swp1";
+                    phy-handle = <&ethphy1>;
+                };
+
+                port@2 {
+                    reg = <2>;
+                    label = "swp2";
+                    phy-handle = <&ext_ethphy0>;
+                };
+            };
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                ethphy1: ethernet-phy@1 {
+                    reg = <1>;
+                    interrupt-parent = <&switch>;
+                    interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+                };
+            };
+
+            mdio-external {
+                compatible = "marvell,mv88e6xxx-mdio-external";
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                ext_ethphy0: ethernet-phy@0 {
+                    reg = <0>;
+                    compatible = "ethernet-phy-ieee802.3-c45";
+                };
+            };
+        };
+    };
-- 
2.39.2

