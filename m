Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84777B437E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 22:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjI3U16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 16:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjI3U14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 16:27:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4070C4;
        Sat, 30 Sep 2023 13:27:53 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 59A366607285;
        Sat, 30 Sep 2023 21:27:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696105672;
        bh=vBPXts/10rHhZZHSHLn5C+++W3GY6yquJg0wHec64Fk=;
        h=From:To:Cc:Subject:Date:From;
        b=eSlMYhWbqsPcx8l9nyEvIwhYSeXCerr2DRUdmz/nf8xe6r57WirHp5v/K2AWfu8S9
         96ik/0Ni5aFkJzdGnA9bmEXd4/E2dUbBZBas1D20/Ap5zCVsaoGa6eMRiMmigkfxcN
         zTjBdH5ChR1mlsiADn/h5rzRS1rnRQhrDP9V+R0Vl69NvS8moI+xeEwwmE+zTJscWc
         yYLbUmonX9FM0gdwqmsUPnMQhkoedUy0BEY2pTZLZqvtvgzGWlWUhQe8PSgUeWiyiG
         oncYm4qZpJGJSCfhLEFwYlJnGwdHwdBAFebl/8lpjBsfH39L4ByAC8Aduvy94nn6+H
         1XWLxC71ZKbOA==
Received: by mercury (Postfix, from userid 1000)
        id 83AFE10603F9; Sat, 30 Sep 2023 22:27:49 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v3] dt-bindings: power: mfd: max8925: Convert to DT schema format
Date:   Sat, 30 Sep 2023 22:27:43 +0200
Message-Id: <20230930202743.214631-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the binding to DT schema format.

The sub-functions of this MFD device do not have their own compatible
string and are thus described directly in the MFD binding document
after being converted to YAML.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Changes since PATCHv2:
 * https://lore.kernel.org/all/20230922233142.1479677-1-sebastian.reichel@collabora.com/
 * Add unevaluatedProperties: false to regulators subnode (Krzysztof Kozlowski)
 * Use "pmic" for nodename (Krzysztof Kozlowski)

Changes since PATCHv1:
 * https://lore.kernel.org/all/20210413153407.GA1707829@robh.at.kernel.org/
 * Update License to GPL OR BSD
 * Add missing type references pointed out by Rob
---
 .../leds/backlight/max8925-backlight.txt      |  10 --
 .../devicetree/bindings/mfd/max8925.txt       |  64 --------
 .../bindings/mfd/maxim,max8925.yaml           | 145 ++++++++++++++++++
 .../bindings/power/supply/max8925_battery.txt |  18 ---
 4 files changed, 145 insertions(+), 92 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/max8925-backlight.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/max8925.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max8925.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/max8925_battery.txt

diff --git a/Documentation/devicetree/bindings/leds/backlight/max8925-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/max8925-backlight.txt
deleted file mode 100644
index b4cffdaa4137..000000000000
--- a/Documentation/devicetree/bindings/leds/backlight/max8925-backlight.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-88pm860x-backlight bindings
-
-Optional properties:
-  - maxim,max8925-dual-string: whether support dual string
-
-Example:
-
-	backlights {
-		maxim,max8925-dual-string = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/mfd/max8925.txt b/Documentation/devicetree/bindings/mfd/max8925.txt
deleted file mode 100644
index 4f0dc6638e5e..000000000000
--- a/Documentation/devicetree/bindings/mfd/max8925.txt
+++ /dev/null
@@ -1,64 +0,0 @@
-* Maxim max8925 Power Management IC
-
-Required parent device properties:
-- compatible : "maxim,max8925"
-- reg : the I2C slave address for the max8925 chip
-- interrupts : IRQ line for the max8925 chip
-- interrupt-controller: describes the max8925 as an interrupt
-  controller (has its own domain)
-- #interrupt-cells : should be 1.
-	- The cell is the max8925 local IRQ number
-
-Optional parent device properties:
-- maxim,tsc-irq: there are 2 IRQ lines for max8925, one is indicated in
-  interrupts property, the other is indicated here.
-
-max8925 consists of a large and varied group of sub-devices:
-
-Device			 Supply Names	 Description
-------			 ------------	 -----------
-max8925-onkey		:		: On key
-max8925-rtc		:		: RTC
-max8925-regulator	:		: Regulators
-max8925-backlight	:		: Backlight
-max8925-touch		:		: Touchscreen
-max8925-power		:		: Charger
-
-Example:
-
-	pmic: max8925@3c {
-		compatible = "maxim,max8925";
-		reg = <0x3c>;
-		interrupts = <1>;
-		interrupt-parent = <&intcmux4>;
-		interrupt-controller;
-		#interrupt-cells = <1>;
-		maxim,tsc-irq = <0>;
-
-		regulators {
-			SDV1 {
-				regulator-min-microvolt = <637500>;
-				regulator-max-microvolt = <1425000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			LDO1 {
-				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <3900000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-		};
-		backlight {
-			maxim,max8925-dual-string = <0>;
-		};
-		charger {
-			batt-detect = <0>;
-			topoff-threshold = <1>;
-			fast-charge = <7>;
-			no-temp-support = <0>;
-			no-insert-detect = <0>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/mfd/maxim,max8925.yaml b/Documentation/devicetree/bindings/mfd/maxim,max8925.yaml
new file mode 100644
index 000000000000..bcb76aae5f5a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max8925.yaml
@@ -0,0 +1,145 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/maxim,max8925.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MAX8925 PMIC from Maxim Integrated.
+
+maintainers:
+  - Lee Jones <lee.jones@linaro.org>
+
+properties:
+  compatible:
+    const: maxim,max8925
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+    description:
+      The cell is the IRQ number
+
+  maxim,tsc-irq:
+    description: second interrupt from max8925
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  regulators:
+    type: object
+
+    patternProperties:
+      "^SDV[1-3]$|^LDO[1-9]$|^LDO1[0-9]$|^LDO20$":
+        description: regulator configuration for SDV1-3 and LDO1-20
+        $ref: /schemas/regulator/regulator.yaml
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+  backlight:
+    type: object
+    properties:
+      maxim,max8925-dual-string:
+        description: set to 1 to support dual string
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1]
+        default: 0
+
+    additionalProperties: false
+
+  charger:
+    type: object
+    properties:
+      batt-detect:
+        description: set to 1 if battery detection via ID pin is supported
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1]
+        default: 0
+
+      topoff-threshold:
+        description: charging current in topoff mode, configures bits 5-6 in CHG_CNTL1
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 3
+        default: 0
+
+      fast-charge:
+        description: set charging current in fast mode, configures bits 0-3 in CHG_CNTL1
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 7
+        default: 0
+
+      no-temp-support:
+        description: set to 1 if temperature sensing is not supported
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1]
+        default: 0
+
+      no-insert-detect:
+        description: set to 1 if AC detection is not supported
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1]
+        default: 0
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@3c {
+            compatible = "maxim,max8925";
+            reg = <0x3c>;
+            interrupts = <1>;
+            interrupt-parent = <&intcmux4>;
+            interrupt-controller;
+            #interrupt-cells = <1>;
+            maxim,tsc-irq = <0>;
+
+            regulators {
+                SDV1 {
+                    regulator-min-microvolt = <637500>;
+                    regulator-max-microvolt = <1425000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                LDO1 {
+                    regulator-min-microvolt = <750000>;
+                    regulator-max-microvolt = <3900000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+            };
+
+            backlight {
+                maxim,max8925-dual-string = <0>;
+            };
+
+            charger {
+                batt-detect = <0>;
+                topoff-threshold = <1>;
+                fast-charge = <7>;
+                no-temp-support = <0>;
+                no-insert-detect = <0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/max8925_battery.txt b/Documentation/devicetree/bindings/power/supply/max8925_battery.txt
deleted file mode 100644
index d7e3e0c0f71d..000000000000
--- a/Documentation/devicetree/bindings/power/supply/max8925_battery.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-max8925-battery bindings
-~~~~~~~~~~~~~~~~
-
-Optional properties :
- - batt-detect: whether support battery detect
- - topoff-threshold: set charging current in topoff mode
- - fast-charge: set charging current in fast mode
- - no-temp-support: whether support temperature protection detect
- - no-insert-detect: whether support insert detect
-
-Example:
-	charger {
-		batt-detect = <0>;
-		topoff-threshold = <1>;
-		fast-charge = <7>;
-		no-temp-support = <0>;
-		no-insert-detect = <0>;
-	};
-- 
2.40.1

