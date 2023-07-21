Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1751875CE3C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjGUQSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjGUQSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:18:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DD744A2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:17:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99364ae9596so339939666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689956235; x=1690561035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vQyjqKTp1BDLw2Mp5VaaQH9+nqnRArVDj6nb3BJ/DDU=;
        b=sIRLreLJqC6TbCbKGZnt+GF/L+n1U3ciCxhQp5iBhG36h9qyBtX3aXoX4sobxKLau4
         4jrrBfOE4XV8W84P3JVTadWUjINTgspdOzyVmxVu/Q1nU5+XyBhGxniRutQcy4XEMdgm
         6YdDs66+lN+1MuPBqPTw8OmSJjGMuJssNGW3KHicAU6ShCaw/TcNnzuRG+BOxR91AFNX
         7E81evRAZqhLeKhzQAKeAjvNOsL0VC4GTCDhP+B6Yl3vX/WwJfce/XIFtelZeGCz33nb
         gWF6QvGMYoTnEtv16H7vMNLresJRc7uuOdZhiisiFUaJMqur/LEtb8OreSH6tLOGNgbT
         T2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689956235; x=1690561035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQyjqKTp1BDLw2Mp5VaaQH9+nqnRArVDj6nb3BJ/DDU=;
        b=Zk4aWi2EVOCM3iNDPJL27YHKGZGf0d3PPtJcYEznHkJzQDObx8It8LHyogz8kVNa63
         nqlUiSStasW2j0TPVoFckMGuNkUq9APJKp9A6hESWS/F9lgy0ZgFD+Uk7eXm4KE1tTgx
         RQD3LlKUAuqncRp/GtvIcDLtb/uvBqNgniWB9FT+CG+aACi4SKz5mC9rc0FoWE6NMapf
         yocgoHaep1SPUtgcuw6tjDCba3F6gDe1+tSQtceIAHtcUTW3ZqipZERe8c7yFW3MLyyp
         0LN6AmVVvaU5AbuT8oJCHnjmdA+t3p5YpFb0iXxKnSZ7kowJhvX5wm4GqX84WhK2uoLH
         LyNQ==
X-Gm-Message-State: ABy/qLbdTbfP9BZmvANumuRYXCr46orJ3Ob2hhLo9echUfWfe+x1ScLM
        HTW2cEQTiQvoOg5ncrZYx9SHQ3ad5TaBPe0LZWkw8w==
X-Google-Smtp-Source: APBJJlGQv9VIqv2Bt1Sh6XQG2IRixx6SlAaNdL8nQ3ry8osECNqi0nhRGWkJGs+AK0B6qiZjD5/V5g==
X-Received: by 2002:a17:906:e:b0:988:dced:f339 with SMTP id 14-20020a170906000e00b00988dcedf339mr2150918eja.31.1689956235135;
        Fri, 21 Jul 2023 09:17:15 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id b10-20020a170906038a00b009929ab17bdfsm2332117eja.168.2023.07.21.09.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:17:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: mfd: maxim,max8998: Convert to DT schema
Date:   Fri, 21 Jul 2023 18:17:12 +0200
Message-Id: <20230721161712.31767-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the bindings for Maxim MAX8998, National/TI LP3974 Power
Management IC to DT schema.  Adjust example to real DTS and make second
interrupt optional (like on s5pv210-aries.dtsi).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mfd/max8998.txt       | 125 -------
 .../bindings/mfd/maxim,max8998.yaml           | 324 ++++++++++++++++++
 2 files changed, 324 insertions(+), 125 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/max8998.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max8998.yaml

diff --git a/Documentation/devicetree/bindings/mfd/max8998.txt b/Documentation/devicetree/bindings/mfd/max8998.txt
deleted file mode 100644
index 4ed52184d081..000000000000
--- a/Documentation/devicetree/bindings/mfd/max8998.txt
+++ /dev/null
@@ -1,125 +0,0 @@
-* Maxim MAX8998, National/TI LP3974 multi-function device
-
-The Maxim MAX8998 is a multi-function device which includes voltage/current
-regulators, real time clock, battery charging controller and several
-other sub-blocks. It is interfaced using an I2C interface. Each sub-block
-is addressed by the host system using different i2c slave address.
-
-PMIC sub-block
---------------
-
-The PMIC sub-block contains a number of voltage and current regulators,
-with controllable parameters and dynamic voltage scaling capability.
-In addition, it includes a real time clock and battery charging controller
-as well. It is accessible at I2C address 0x66.
-
-Required properties:
-- compatible: Should be one of the following:
-    - "maxim,max8998" for Maxim MAX8998
-    - "national,lp3974" or "ti,lp3974" for National/TI LP3974.
-- reg: Specifies the i2c slave address of the pmic block. It should be 0x66.
-
-Optional properties:
-- interrupts: Interrupt specifiers for two interrupt sources.
-  - First interrupt specifier is for main interrupt.
-  - Second interrupt specifier is for power-on/-off interrupt.
-- max8998,pmic-buck1-dvs-gpios: GPIO specifiers for two host gpios used
-  for buck 1 dvs. The format of the gpio specifier depends on the gpio
-  controller.
-- max8998,pmic-buck2-dvs-gpio: GPIO specifier for host gpio used
-  for buck 2 dvs. The format of the gpio specifier depends on the gpio
-  controller.
-- max8998,pmic-buck1-default-dvs-idx: Default voltage setting selected from
-  the possible 4 options selectable by the dvs gpios. The value of this
-  property should be 0, 1, 2 or 3. If not specified or out of range,
-  a default value of 0 is taken.
-- max8998,pmic-buck2-default-dvs-idx: Default voltage setting selected from
-  the possible 2 options selectable by the dvs gpios. The value of this
-  property should be 0 or 1. If not specified or out of range, a default
-  value of 0 is taken.
-- max8998,pmic-buck-voltage-lock: If present, disallows changing of
-  preprogrammed buck dvfs voltages.
-
-Additional properties required if max8998,pmic-buck1-dvs-gpios is defined:
-- max8998,pmic-buck1-dvs-voltage: An array of 4 voltage values in microvolts
-  for buck1 regulator that can be selected using dvs gpio.
-
-Additional properties required if max8998,pmic-buck2-dvs-gpio is defined:
-- max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in microvolts
-  for buck2 regulator that can be selected using dvs gpio.
-
-Regulators: All the regulators of MAX8998 to be instantiated shall be
-listed in a child node named 'regulators'. Each regulator is represented
-by a child node of the 'regulators' node.
-
-	regulator-name {
-		/* standard regulator bindings here */
-	};
-
-Following regulators of the MAX8998 PMIC block are supported. Note that
-the 'n' in regulator name, as in LDOn or BUCKn, represents the LDO or BUCK
-number as described in MAX8998 datasheet.
-
-	- LDOn
-		  - valid values for n are 2 to 17
-		  - Example: LDO2, LDO10, LDO17
-	- BUCKn
-		  - valid values for n are 1 to 4.
-		  - Example: BUCK1, BUCK2, BUCK3, BUCK4
-
-	- ENVICHG: Battery Charging Current Monitor Output. This is a fixed
-		   voltage type regulator
-
-	- ESAFEOUT1: (ldo19)
-	- ESAFEOUT2: (ld020)
-
-	- CHARGER: main battery charger current control
-
-Standard regulator bindings are used inside regulator subnodes. Check
-  Documentation/devicetree/bindings/regulator/regulator.txt
-for more details.
-
-Example:
-
-	pmic@66 {
-		compatible = "maxim,max8998-pmic";
-		reg = <0x66>;
-		interrupt-parent = <&wakeup_eint>;
-		interrupts = <4 0>, <3 0>;
-
-		/* Buck 1 DVS settings */
-		max8998,pmic-buck1-default-dvs-idx = <0>;
-		max8998,pmic-buck1-dvs-gpios = <&gpx0 0 1 0 0>, /* SET1 */
-					       <&gpx0 1 1 0 0>; /* SET2 */
-		max8998,pmic-buck1-dvs-voltage = <1350000>, <1300000>,
-						 <1000000>, <950000>;
-
-		/* Buck 2 DVS settings */
-		max8998,pmic-buck2-default-dvs-idx = <0>;
-		max8998,pmic-buck2-dvs-gpio = <&gpx0 0 3 0 0>; /* SET3 */
-		max8998,pmic-buck2-dvs-voltage = <1350000>, <1300000>;
-
-		/* Regulators to instantiate */
-		regulators {
-			ldo2_reg: LDO2 {
-				regulator-name = "VDD_ALIVE_1.1V";
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
-				regulator-always-on;
-			};
-
-			buck1_reg: BUCK1 {
-				regulator-name = "VDD_ARM_1.2V";
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			charger_reg: CHARGER {
-				regulator-name = "CHARGER";
-				regulator-min-microamp = <90000>;
-				regulator-max-microamp = <800000>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/mfd/maxim,max8998.yaml b/Documentation/devicetree/bindings/mfd/maxim,max8998.yaml
new file mode 100644
index 000000000000..f3c3f64fd012
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max8998.yaml
@@ -0,0 +1,324 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/maxim,max8998.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX8998, National/TI LP3974 Power Management IC
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+description:
+  The Maxim MAX8998 is a Power Management IC which includes voltage/current
+  regulators, real time clock, battery charging controller and several other
+  sub-blocks. It is interfaced using an I2C interface. Each sub-block is
+  addressed by the host system using different i2c slave address.
+
+properties:
+  compatible:
+    enum:
+      - maxim,max8998
+      - national,lp3974
+      - ti,lp3974
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: Main interrupt
+      - description: Power-on/-off interrupt
+
+  max8998,pmic-buck1-dvs-gpios:
+    maxItems: 2
+    description:
+      Two host gpios used for buck1 DVS.
+
+  max8998,pmic-buck2-dvs-gpio:
+    maxItems: 1
+    description:
+      Host gpio used for buck2 DVS.
+
+  max8998,pmic-buck1-default-dvs-idx:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 0
+    description:
+      Default voltage setting selected from the possible 4 options selectable
+      by the DVS gpios.
+
+  max8998,pmic-buck2-default-dvs-idx:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    default: 0
+    description:
+      Default voltage setting selected from the possible 2 options selectable
+      by the DVS GPIOs.
+
+  max8998,pmic-buck-voltage-lock:
+    type: boolean
+    description:
+      If present, disallows changing of preprogrammed buck DVS voltages.
+
+  max8998,pmic-buck1-dvs-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 4
+    description:
+      Four voltage values in microvolts for buck1 regulator that can be
+      selected using DVS GPIO.
+
+  max8998,pmic-buck2-dvs-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 2
+    description:
+      Two voltage values in microvolts for buck2 regulator that can be
+      selected using DVS GPIO.
+
+  regulators:
+    type: object
+    additionalProperties: false
+
+    properties:
+      CHARGER:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+        description:
+          CHARGER is main battery charger current control, wrongly represented
+          as regulator.
+
+        properties:
+          regulator-min-microamp:
+            minimum: 90000
+            maximum: 800000
+
+          regulator-max-microamp:
+            minimum: 90000
+            maximum: 800000
+
+          regulator-min-microvolt: false
+          regulator-max-microvolt: false
+
+        required:
+          - regulator-name
+
+    patternProperties:
+      "^(LDO([2-9]|1[0-7])|BUCK[1-4])$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        required:
+          - regulator-name
+
+      "^(EN32KHz-AP|EN32KHz-CP|ENVICHG|ESAFEOUT[12])$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+        description: |
+          EN32KHz-AP and EN32KHz-CP are 32768 Hz clocks, wrongly represented as
+          regulators.
+          ENVICHG is a Battery Charging Current Monitor Output.
+
+        properties:
+          regulator-min-microvolt: false
+          regulator-max-microvolt: false
+
+        required:
+          - regulator-name
+
+dependencies:
+  max8998,pmic-buck1-dvs-gpios: [ "max8998,pmic-buck1-dvs-voltage" ]
+  max8998,pmic-buck2-dvs-gpio: [ "max8998,pmic-buck2-dvs-voltage" ]
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@66 {
+            compatible = "national,lp3974";
+            reg = <0x66>;
+            interrupts-extended = <&gpx0 7 IRQ_TYPE_LEVEL_LOW>,
+                                  <&gpx2 7 IRQ_TYPE_LEVEL_LOW>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&lp3974_irq>;
+
+            max8998,pmic-buck1-default-dvs-idx = <0>;
+            max8998,pmic-buck1-dvs-gpios = <&gpx0 5 GPIO_ACTIVE_HIGH>,
+                                           <&gpx0 6 GPIO_ACTIVE_HIGH>;
+            max8998,pmic-buck1-dvs-voltage = <1100000>, <1000000>,
+                                             <1100000>, <1000000>;
+            max8998,pmic-buck2-default-dvs-idx = <0>;
+            max8998,pmic-buck2-dvs-gpio = <&gpe2 0 GPIO_ACTIVE_HIGH>;
+            max8998,pmic-buck2-dvs-voltage = <1200000>, <1100000>;
+
+            regulators {
+                LDO2 {
+                    regulator-name = "VALIVE_1.2V";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <1200000>;
+                    regulator-always-on;
+                };
+
+                LDO3 {
+                    regulator-name = "VUSB+MIPI_1.1V";
+                    regulator-min-microvolt = <1100000>;
+                    regulator-max-microvolt = <1100000>;
+                    regulator-always-on;
+                };
+
+                LDO4 {
+                    regulator-name = "VADC_3.3V";
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <3300000>;
+                };
+
+                LDO5 {
+                    regulator-name = "VTF_2.8V";
+                    regulator-min-microvolt = <2800000>;
+                    regulator-max-microvolt = <2800000>;
+                };
+
+                LDO6 {
+                    regulator-name = "LDO6";
+                    regulator-min-microvolt = <2000000>;
+                    regulator-max-microvolt = <2000000>;
+                };
+
+                LDO7 {
+                    regulator-name = "VLCD+VMIPI_1.8V";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                };
+
+                LDO8 {
+                    regulator-name = "VUSB+VDAC_3.3V";
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-always-on;
+                };
+
+                LDO9 {
+                    regulator-name = "VCC_2.8V";
+                    regulator-min-microvolt = <2800000>;
+                    regulator-max-microvolt = <2800000>;
+                    regulator-always-on;
+                };
+
+                LDO10 {
+                    regulator-name = "VPLL_1.1V";
+                    regulator-min-microvolt = <1100000>;
+                    regulator-max-microvolt = <1100000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                LDO11 {
+                    regulator-name = "CAM_AF_3.3V";
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <3300000>;
+                };
+
+                LDO12 {
+                    regulator-name = "PS_2.8V";
+                    regulator-min-microvolt = <2800000>;
+                    regulator-max-microvolt = <2800000>;
+                };
+
+                LDO13 {
+                    regulator-name = "VHIC_1.2V";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <1200000>;
+                };
+
+                LDO14 {
+                    regulator-name = "CAM_I_HOST_1.8V";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                };
+
+                LDO15 {
+                    regulator-name = "CAM_S_DIG+FM33_CORE_1.2V";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <1200000>;
+                };
+
+                LDO16 {
+                    regulator-name = "CAM_S_ANA_2.8V";
+                    regulator-min-microvolt = <2800000>;
+                    regulator-max-microvolt = <2800000>;
+                };
+
+                LDO17 {
+                    regulator-name = "VCC_3.0V_LCD";
+                    regulator-min-microvolt = <3000000>;
+                    regulator-max-microvolt = <3000000>;
+                };
+
+                BUCK1 {
+                    regulator-name = "VINT_1.1V";
+                    regulator-min-microvolt = <750000>;
+                    regulator-max-microvolt = <1500000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                BUCK2 {
+                    regulator-name = "VG3D_1.1V";
+                    regulator-min-microvolt = <750000>;
+                    regulator-max-microvolt = <1500000>;
+                    regulator-boot-on;
+                };
+
+                BUCK3 {
+                    regulator-name = "VCC_1.8V";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-always-on;
+                };
+
+                BUCK4 {
+                    regulator-name = "VMEM_1.2V";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <1200000>;
+                    regulator-always-on;
+                };
+
+                EN32KHz-AP {
+                    regulator-name = "32KHz AP";
+                    regulator-always-on;
+                };
+
+                EN32KHz-CP {
+                    regulator-name = "32KHz CP";
+                };
+
+                ENVICHG {
+                    regulator-name = "VICHG";
+                };
+
+                ESAFEOUT1 {
+                    regulator-name = "SAFEOUT1";
+                };
+
+                ESAFEOUT2 {
+                    regulator-name = "SAFEOUT2";
+                    regulator-boot-on;
+                };
+            };
+        };
+    };
-- 
2.34.1

