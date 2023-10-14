Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214377C9650
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 22:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjJNUvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 16:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjJNUvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 16:51:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D7DDA
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 13:51:38 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5079f6efd64so1435210e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 13:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697316697; x=1697921497; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xcek1IExtexURMeKlMsRJspW07mCiJH38XQWX0Z5ASQ=;
        b=Ho/Ip+wQpanOLGx8D3hzsLV4Tar+92HUj1Gz3RrvpiKm7nrhMMprgjbrr9tviAYTwZ
         wy48pCICv5Ux6E1QBb7plk+9X79G/Q6gPcnDKpj9MPgZvlZy7yAP0/0xcDqogfXN/WsZ
         B8R2LnN0f5SV0NGPGhyw722BZTWB9cMvidX6zxZG4xbF+Ex+0SrIUO4mUucPSOJ7K5zD
         UnCo6XSyALVek5E1/UP/7BqhUIeK3/WMASl9xfBkm/OR8PxwL0V+GTAAfjm2VawdrR44
         hImgWHksD8aReeQ5yxMI83MNN3RbPcQ8r30huphq9JuL2ASnlMdY7Ogk5OCORhDmzCBQ
         1lvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697316697; x=1697921497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xcek1IExtexURMeKlMsRJspW07mCiJH38XQWX0Z5ASQ=;
        b=ifp3Ppc1slISiAbx79Bkfxt+CDeunmOJlXvfJAKgEStEQCUm5YxBMcLkNjdT/jGZqn
         BkrNKkjfysINK4W3cu9URz34cysV/XZPheqYr7troO/NSZK6KMe3SJoda6yPkcjVaiVZ
         polC7P33zG5Dg91+TT0pdZB20l9RJjkK0bkXZJWEy6x9Btsmc/TCibd4EoVjKzxJhU5b
         P0wuJR66p6hOj4LPEgpChDvN6d66g9293y5ke1PfMtOLsZ4FRiWSQyd+o17BL8jyeouu
         q0Rv/+sv6wsWAfjj9QMm/W8kYvOLhwTNKgHdN80JOwPP8WqREzpHOiXT52GxED1pqaVk
         Ql6Q==
X-Gm-Message-State: AOJu0YyalOFz/9Y3cI2/wGMZqAodkH7Kr+lGjqKOmYBSygNDKKMjTnhv
        bBk7Mc3gFh3xRg3JAW5twKzTNQ==
X-Google-Smtp-Source: AGHT+IFWoXuCIM9U+91E+u52ZglKN4DGR6vV6X5C3ttGMvevAUGWFRpQStXCC1OTmn0FFO1NbGVcKQ==
X-Received: by 2002:a19:4f09:0:b0:500:c534:3e4e with SMTP id d9-20020a194f09000000b00500c5343e4emr24511184lfb.60.1697316697262;
        Sat, 14 Oct 2023 13:51:37 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id o17-20020ac24e91000000b004ff96c09b47sm49926lfr.260.2023.10.14.13.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 13:51:36 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 14 Oct 2023 22:51:32 +0200
Subject: [PATCH net-next v2 1/5] dt-bindings: marvell: Rewrite MV88E6xxx in
 schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231014-marvell-88e6152-wan-led-v2-1-7fca08b68849@linaro.org>
References: <20231014-marvell-88e6152-wan-led-v2-0-7fca08b68849@linaro.org>
In-Reply-To: <20231014-marvell-88e6152-wan-led-v2-0-7fca08b68849@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an attempt to rewrite the Marvell MV88E6xxx switch bindings
in YAML schema.

The current text binding says:
  WARNING: This binding is currently unstable. Do not program it into a
  FLASH never to be changed again. Once this binding is stable, this
  warning will be removed.

Well that never happened before we switched to YAML markup,
we can't have it like this, what about fixing the mess?

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/net/dsa/marvell,mv88e6xxx.yaml        | 241 +++++++++++++++++++++
 .../devicetree/bindings/net/dsa/marvell.txt        | 109 ----------
 MAINTAINERS                                        |   2 +-
 3 files changed, 242 insertions(+), 110 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
new file mode 100644
index 000000000000..22ae844da2b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
@@ -0,0 +1,241 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell MV88E6xxx DSA switch family
+
+maintainers:
+  - Andrew Lunn <andrew@lunn.ch>
+
+description:
+  The Marvell MV88E6xxx switch series has been produced and sold
+  by Marvell since at least 2010. The switch has a few compatibles which
+  just indicate the base address of the switch, then operating systems
+  can investigate switch ID registers to find out which actual version
+  of the switch it is dealing with.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - marvell,mv88e6085
+          - marvell,mv88e6190
+          - marvell,mv88e6250
+    description: |
+      marvell,mv88e6085: This switch uses base address 0x10.
+        This switch and its siblings will be autodetected from
+        ID registers found in the switch, so only "marvell,mv88e6085" should be
+        specified. This includes the following list of MV88Exxxx switches:
+        6085, 6095, 6097, 6123, 6131, 6141, 6161, 6165, 6171, 6172, 6175, 6176,
+        6185, 6240, 6320, 6321, 6341, 6350, 6351, 6352
+      marvell,mv88e6190: This switch uses base address 0x00.
+        This switch and its siblings will be autodetected from
+        ID registers found in the switch, so only "marvell,mv88e6190" should be
+        specified. This includes the following list of MV88Exxxx switches:
+        6190, 6190X, 6191, 6290, 6361, 6390, 6390X
+      marvell,mv88e6250: This switch uses base address 0x08 or 0x18.
+        This switch and its siblings will be autodetected from
+        ID registers found in the switch, so only "marvell,mv88e6250" should be
+        specified. This includes the following list of MV88Exxxx switches:
+        6220, 6250
+
+  reg:
+    maxItems: 1
+
+  eeprom-length:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Set to the length of an EEPROM connected to the switch. Must be
+      set if the switch can not detect the presence and/or size of a connected
+      EEPROM, otherwise optional.
+
+  reset-gpios:
+    description:
+      GPIO to be used to reset the whole device
+    maxItems: 1
+
+  interrupts:
+    description: The switch provides an external interrupt line, but it is
+      not always used by target systems.
+    maxItems: 1
+
+  interrupt-controller:
+    description: The switch has an internal interrupt controller used by
+      the different sub-blocks.
+
+  '#interrupt-cells':
+    description: The internal interrupt controller only supports triggering
+      on active high level interrupts so the second cell must alway be set to
+      IRQ_TYPE_LEVEL_HIGH.
+    const: 2
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    description: Marvell MV88E6xxx switches have an internal mdio bus to
+      access switch ports, which is handled in this node.
+
+  mdio-external:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    description: Marvell MV88E6xxx switches have an external mdio bus to
+      access external PHYs connected to the switch ports.
+
+    properties:
+      compatible:
+        const: marvell,mv88e6xxx-mdio-external
+
+    required:
+      - compatible
+
+$ref: dsa.yaml#
+
+patternProperties:
+  "^(ethernet-)?ports$":
+    type: object
+    patternProperties:
+      "^(ethernet-)?port@[0-9]+$":
+        type: object
+        description: Ethernet switch ports
+
+        $ref: dsa-port.yaml#
+
+        unevaluatedProperties: false
+
+oneOf:
+  - required:
+      - ports
+  - required:
+      - ethernet-ports
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        switch0: switch@0 {
+            compatible = "marvell,mv88e6085";
+            reg = <0>;
+            reset-gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    label = "lan1";
+                };
+                port@1 {
+                    reg = <1>;
+                    label = "lan2";
+                };
+                port@2 {
+                    reg = <2>;
+                    label = "lan3";
+                };
+                port@3 {
+                    reg = <3>;
+                    label = "lan4";
+                };
+                port@4 {
+                    reg = <4>;
+                    label = "wan";
+                };
+
+                port@5 {
+                    reg = <5>;
+                    phy-mode = "sgmii";
+                    ethernet = <&eth2>;
+
+                    fixed-link {
+                        speed = <1000>;
+                        full-duplex;
+                    };
+                };
+            };
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                switch0phy0: switch0phy@0 {
+                    reg = <0>;
+                    interrupt-parent = <&switch0>;
+                    interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+                };
+            };
+        };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        switch1: switch@0 {
+            compatible = "marvell,mv88e6190";
+            reg = <0>;
+            reset-gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    label = "lan1";
+                };
+                port@1 {
+                    reg = <1>;
+                    label = "lan2";
+                };
+                port@2 {
+                    reg = <2>;
+                    label = "lan3";
+                };
+                port@3 {
+                    reg = <3>;
+                    label = "lan4";
+                };
+            };
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                switch1phy0: switch1phy@0 {
+                    reg = <0>;
+                    interrupt-parent = <&switch1>;
+                    interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+                };
+            };
+
+            mdio-external {
+                compatible = "marvell,mv88e6xxx-mdio-external";
+                #address-cells = <1>;
+                #size-cells = <0>;
+                switch1phy9: switch1phy@9 {
+                    reg = <9>;
+                };
+            };
+        };
+    };
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..1b4475254d27 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12625,7 +12625,7 @@ MARVELL 88E6XXX ETHERNET SWITCH FABRIC DRIVER
 M:	Andrew Lunn <andrew@lunn.ch>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/net/dsa/marvell.txt
+F:	Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
 F:	Documentation/networking/devlink/mv88e6xxx.rst
 F:	drivers/net/dsa/mv88e6xxx/
 F:	include/linux/dsa/mv88e6xxx.h

-- 
2.34.1

