Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C94B7EA712
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 00:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjKMXgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 18:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjKMXgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 18:36:17 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A0210EC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:36:07 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c6cb4a79deso54774851fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699918566; x=1700523366; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wc+Wq7sqd6cor2r5WAdGrmvNaWx96k7C6JDLjLbdJqE=;
        b=C8bdZCJcexlqB4ZQ5RjViELydZYyJRb0q5C2ONuZ7Vn/22FGgI4cHZNDzhYGCozT1i
         MgYXsoPl01vdXeN1xyZmEzXa6EIIwbCZTgyViY9Bb/yB7fCXnP6TAvZsKdyvI9TvxYH3
         wJWaxZvDeylVRcvCQBesFrIv7EOMh0C7/GhDquMxM+Bi4tNe/525IHiIbN4McC8rX13b
         m1AKhFZg6ku+5tKGQReTfvpscasQVR4hyMBIcBle1RNqN90HXjwBdZ6xOzy++4zt/H1W
         RXnGpuvqspKV6YqRCKSKJHv0ndEkVT2UQNb5Ha1ffmYj3/BSESJIiJV3iILQVqO/l/vO
         hRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699918566; x=1700523366;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wc+Wq7sqd6cor2r5WAdGrmvNaWx96k7C6JDLjLbdJqE=;
        b=o6rJbPkOUaZrBI5zd/o75Z9zgv7Jr8aceyPIqynparfxuVZsNSz36Toi9yGFumMifP
         7QIxwJBPh+HytybTiCzPsR2AP2PziUp96OpOmgyHJ5qEgoiDd1Oa/6WJTSjxbMS7WRex
         TNrXGttlwISIo6rkYLw1umVjccgGtlIDpVMDDfRGscTa5wTcN+77FAguNeEOSQZvhDrW
         xqOwbEknW0uYzfAae1WqTpXEIN6jCvvShqzU9GEwaLsEAKLPy0vXrWkTPtwV17R1WFV1
         eoaCeC1DRXN0Sk6008yIpFJyDsC0IJXy7eNixBBzkdUGSPr9Cks2U6cNUPQtCiinVYna
         9Zfg==
X-Gm-Message-State: AOJu0YzNwGl9y81G+5hzaNNHnJiK/3OmRmuoMrJwY/9KHXnpj1OR9R0I
        Zn1AyeUs7AJis8riZETAKpfyLw==
X-Google-Smtp-Source: AGHT+IG4Cj5m1hC6xB7TsQYZze+Ywj04f7LA/6FAjfEo+HYtHB1lh+d3McvkWwQMVejVkOZu0H07IQ==
X-Received: by 2002:a2e:9042:0:b0:2c3:c4b8:19ec with SMTP id n2-20020a2e9042000000b002c3c4b819ecmr192115ljg.18.1699918565731;
        Mon, 13 Nov 2023 15:36:05 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 17-20020a2e0611000000b002b70a8478ddsm1202859ljg.44.2023.11.13.15.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 15:36:05 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 00:36:02 +0100
Subject: [PATCH net-next v8 7/9] dt-bindings: marvell: Rewrite MV88E6xxx in
 schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-marvell-88e6152-wan-led-v8-7-50688741691b@linaro.org>
References: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
In-Reply-To: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
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
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/net/dsa/marvell,mv88e6xxx.yaml        | 337 +++++++++++++++++++++
 .../devicetree/bindings/net/dsa/marvell.txt        | 109 -------
 MAINTAINERS                                        |   2 +-
 3 files changed, 338 insertions(+), 110 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
new file mode 100644
index 000000000000..19f15bdd1c97
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
@@ -0,0 +1,337 @@
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
+  by Marvell since at least 2008. The switch has a few compatibles which
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
+        description: |
+          marvell,mv88e6085: This switch uses base address 0x10.
+            This switch and its siblings will be autodetected from
+            ID registers found in the switch, so only "marvell,mv88e6085" should be
+            specified. This includes the following list of MV88Exxxx switches:
+            6085, 6095, 6097, 6123, 6131, 6141, 6161, 6165, 6171, 6172, 6175, 6176,
+            6185, 6240, 6320, 6321, 6341, 6350, 6351, 6352
+          marvell,mv88e6190: This switch uses base address 0x00.
+            This switch and its siblings will be autodetected from
+            ID registers found in the switch, so only "marvell,mv88e6190" should be
+            specified. This includes the following list of MV88Exxxx switches:
+            6190, 6190X, 6191, 6290, 6361, 6390, 6390X
+          marvell,mv88e6250: This switch uses base address 0x08 or 0x18.
+            This switch and its siblings will be autodetected from
+            ID registers found in the switch, so only "marvell,mv88e6250" should be
+            specified. This includes the following list of MV88Exxxx switches:
+            6220, 6250
+      - items:
+          - const: marvell,turris-mox-mv88e6085
+          - const: marvell,mv88e6085
+      - items:
+          - const: marvell,turris-mox-mv88e6190
+          - const: marvell,mv88e6190
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
+    description: Marvell MV88E6xxx switches have an varying combination of
+      internal and external MDIO buses, in some cases a combined bus that
+      can be used both internally and externally. This node is for the
+      primary bus, used internally and sometimes also externally.
+
+  mdio-external:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    description: Marvell MV88E6xxx switches that have a separate external
+      MDIO bus use this port to access external components on the MDIO bus.
+
+    properties:
+      compatible:
+        const: marvell,mv88e6xxx-mdio-external
+
+    required:
+      - compatible
+
+allOf:
+  - $ref: dsa.yaml#/$defs/ethernet-ports
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
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-switch@0 {
+            compatible = "marvell,mv88e6085";
+            reg = <0>;
+            reset-gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                sw_phy0: ethernet-phy@0 {
+                    reg = <0x0>;
+                };
+
+                sw_phy1: ethernet-phy@1 {
+                    reg = <0x1>;
+                };
+
+                sw_phy2: ethernet-phy@2 {
+                    reg = <0x2>;
+                };
+
+                sw_phy3: ethernet-phy@3 {
+                    reg = <0x3>;
+                };
+            };
+
+            ethernet-ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                ethernet-port@0 {
+                    reg = <0>;
+                    label = "lan4";
+                    phy-handle = <&sw_phy0>;
+                    phy-mode = "internal";
+                };
+
+                ethernet-port@1 {
+                    reg = <1>;
+                    label = "lan3";
+                    phy-handle = <&sw_phy1>;
+                    phy-mode = "internal";
+                };
+
+                ethernet-port@2 {
+                    reg = <2>;
+                    label = "lan2";
+                    phy-handle = <&sw_phy2>;
+                    phy-mode = "internal";
+                };
+
+                ethernet-port@3 {
+                    reg = <3>;
+                    label = "lan1";
+                    phy-handle = <&sw_phy3>;
+                    phy-mode = "internal";
+                };
+
+                ethernet-port@5 {
+                    reg = <5>;
+                    ethernet = <&fec>;
+                    phy-mode = "rgmii-id";
+
+                    fixed-link {
+                        speed = <1000>;
+                        full-duplex;
+                    };
+                };
+            };
+        };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-switch@0 {
+            compatible = "marvell,mv88e6190";
+            #interrupt-cells = <2>;
+            interrupt-controller;
+            interrupt-parent = <&gpio1>;
+            interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+            pinctrl-0 = <&switch_interrupt_pins>;
+            pinctrl-names = "default";
+            reg = <0>;
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                switch0phy1: ethernet-phy@1 {
+                    reg = <0x1>;
+                };
+
+                switch0phy2: ethernet-phy@2 {
+                    reg = <0x2>;
+                };
+
+                switch0phy3: ethernet-phy@3 {
+                    reg = <0x3>;
+                };
+
+                switch0phy4: ethernet-phy@4 {
+                    reg = <0x4>;
+                };
+
+                switch0phy5: ethernet-phy@5 {
+                    reg = <0x5>;
+                };
+
+                switch0phy6: ethernet-phy@6 {
+                    reg = <0x6>;
+                };
+
+                switch0phy7: ethernet-phy@7 {
+                    reg = <0x7>;
+                };
+
+                switch0phy8: ethernet-phy@8 {
+                    reg = <0x8>;
+                };
+            };
+
+            mdio-external {
+                compatible = "marvell,mv88e6xxx-mdio-external";
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                phy1: ethernet-phy@b {
+                    reg = <0xb>;
+                    compatible = "ethernet-phy-ieee802.3-c45";
+                };
+
+                phy2: ethernet-phy@c {
+                    reg = <0xc>;
+                    compatible = "ethernet-phy-ieee802.3-c45";
+                };
+            };
+
+            ethernet-ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                ethernet-port@0 {
+                    ethernet = <&eth0>;
+                    phy-mode = "rgmii";
+                    reg = <0>;
+
+                    fixed-link {
+                        full-duplex;
+                        pause;
+                        speed = <1000>;
+                    };
+                };
+
+                ethernet-port@1 {
+                    label = "lan1";
+                    phy-handle = <&switch0phy1>;
+                    reg = <1>;
+                };
+
+                ethernet-port@2 {
+                    label = "lan2";
+                    phy-handle = <&switch0phy2>;
+                    reg = <2>;
+                };
+
+                ethernet-port@3 {
+                    label = "lan3";
+                    phy-handle = <&switch0phy3>;
+                    reg = <3>;
+                };
+
+                ethernet-port@4 {
+                    label = "lan4";
+                    phy-handle = <&switch0phy4>;
+                    reg = <4>;
+                };
+
+                ethernet-port@5 {
+                    label = "lan5";
+                    phy-handle = <&switch0phy5>;
+                    reg = <5>;
+                };
+
+                ethernet-port@6 {
+                    label = "lan6";
+                    phy-handle = <&switch0phy6>;
+                    reg = <6>;
+                };
+
+                ethernet-port@7 {
+                    label = "lan7";
+                    phy-handle = <&switch0phy7>;
+                    reg = <7>;
+                };
+
+                ethernet-port@8 {
+                    label = "lan8";
+                    phy-handle = <&switch0phy8>;
+                    reg = <8>;
+                };
+
+                ethernet-port@9 {
+                    /* 88X3310P external phy */
+                    label = "lan9";
+                    phy-handle = <&phy1>;
+                    phy-mode = "xaui";
+                    reg = <9>;
+                };
+
+                ethernet-port@a {
+                    /* 88X3310P external phy */
+                    label = "lan10";
+                    phy-handle = <&phy2>;
+                    phy-mode = "xaui";
+                    reg = <0xa>;
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

