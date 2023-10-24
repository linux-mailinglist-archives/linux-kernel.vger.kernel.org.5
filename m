Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A801F7D5164
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjJXNU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbjJXNUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:20:42 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8930510C2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:20:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a0907896so6646794e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698153638; x=1698758438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hapr2uWvv+4H11PFrbXw7XKmhdz7N96RSJjEZL4j0Q=;
        b=w4ZqCAIRH75mU3ik37t48gOn/o4zWrrOwljBcVMjvuUd+GajgJJ8ctmq0uBO7DRumf
         UCDmeZF1b403sCN3IFDPo6WdhBfDaKXG8V/Bu4guncN3Vu6Lfp0kQUpO/KSmLK+vBuYA
         b0D7Ar2WGnZqpz7NC3NyZFS0lACZApIN5+9NaNO4OWXceDrMHjHGc/bl0dYNO0jqtbqw
         1LAjDbol3C0Dj3FpjQKcXC9nQ7LfGQ1QlFP7k3I3S2PVV7JOYbPXCjdjIlga5JMwu5rU
         ernf6x2wsixX7f0x9XXKvTUcrP3BkOyTg8bIzsN2Xbv8PsQLDquzmRe5N8BgXC6TXBrV
         UBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698153638; x=1698758438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hapr2uWvv+4H11PFrbXw7XKmhdz7N96RSJjEZL4j0Q=;
        b=BZnbGc6Ai5QX957IPf0KfTO3yp91pK8akLevCNcto+aE33Z2ygDTF7JQrynRXE7jeH
         PJMQgGB5pmQu0A3/E6ZoqbcwA5B4lNvzAkY25Xvj/24c13LUJWJYIpxBpF4WRZXZN0bl
         ypBhJb6iRWJubFU/GMTOEPlgQJVkX0qXE6p4+8WuvkHMWGtdqEa80VebI91r3z/KOMTW
         EatAnuVwTgHqUZSehK3kVDRm2hEDk6Pj0o/1U39M07Js1FhjcErItQaeIWjaxFocC5HQ
         RMaMKE31dTI4p71dAODfyGRqAeQ5t0ux6KZ09CxEbb+vJelJsYYFYqvm00v5sfEkjB8B
         q7gw==
X-Gm-Message-State: AOJu0Yz0nhLva8Ob/gAzmksgEanw06svPLBHa4KDQiLeo9F4ivA02MmF
        awvQArg8mvJgWlma6ZFk1GmA9g==
X-Google-Smtp-Source: AGHT+IFrYQrNj7JAd+oY+sckwJ7mW1bZD6BzrQPu93nTRooKFdLzrRlDqTLdz75PkhPbYu7jPQ84BA==
X-Received: by 2002:a05:6512:ac3:b0:4f9:5426:6622 with SMTP id n3-20020a0565120ac300b004f954266622mr10673383lfu.69.1698153637678;
        Tue, 24 Oct 2023 06:20:37 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id d5-20020a193845000000b00507ab956ab9sm2147365lfj.147.2023.10.24.06.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 06:20:37 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 Oct 2023 15:20:32 +0200
Subject: [PATCH net-next v7 6/7] dt-bindings: marvell: Rewrite MV88E6xxx in
 schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-marvell-88e6152-wan-led-v7-6-2869347697d1@linaro.org>
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
In-Reply-To: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
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
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/net/dsa/marvell,mv88e6xxx.yaml        | 330 +++++++++++++++++++++
 .../devicetree/bindings/net/dsa/marvell.txt        | 109 -------
 MAINTAINERS                                        |   2 +-
 3 files changed, 331 insertions(+), 110 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
new file mode 100644
index 000000000000..34d8561a2187
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
@@ -0,0 +1,330 @@
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
+    enum:
+      - marvell,mv88e6085
+      - marvell,mv88e6190
+      - marvell,mv88e6250
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

