Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A1F764EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjG0JK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjG0JKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:10:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A74210FC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:54:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5221f193817so893953a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690448082; x=1691052882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4zFidkvpiaBnsj/3sbwZ3aVjcWlOMu2Or6nmeidN1j0=;
        b=pPi+Y4SMHAl+xf5iH2Ya1h6XD5Tmjp0NMKDioa0Jr5hSr6Tpokic8WYvuAr4jCmtZl
         7DT+PS8t0TJmHZw8x2SnyBXY0SYinp62tpqzpfZs5Xe75UvFqzo8BFRylTj+g2GMdBTM
         l/xN0S3adnkDJLaKkyVr8KUxvdTUEyv1b/+XSZEUqclbzkIsz1PdMBDdWu+xs2dyCJ7g
         A6ZtvexK5CelK0jNnqMUmqKcozHJbY2xvYCCnbPfErASO/dYfjT961yyqVzgmk+t3Rn6
         TEBB9QQdHHgWNwqteR8SSqSLHcewaPeCZZjBVozObOhg62w6OaPvEnu4TueBrOn0CdlU
         qSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690448082; x=1691052882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4zFidkvpiaBnsj/3sbwZ3aVjcWlOMu2Or6nmeidN1j0=;
        b=aZ3MiInfOHcTW/KZpXmS+s1CcpRmySaRcakhJFNNmLGr0WmPBRMsoKzLx9rbbRBFUV
         Sv6fQQOxcNNdttQgpEhZ8Eo+B5Ai0bG7rjtX/aFlvPi27PWv9VGX5Dgiv+YHUFQ+gSXw
         Zo+s7tvs9MCPpEagYaCHLPEEzhGnUfoNvrCIq2eKAO7jvZvDJGunvHt80vvmu/cSNOLj
         vLetvfrsRUVXkDQImJ/v5F0cOMmBTF98058OmviK3U2j7J/ELar8VywNGDv9I3a7JXHM
         jcrMikloTxJs76UhvTvhswZhKHZmLXEeyVAg1XuYe6tLrJfpGro0jbMcevMw8s+HlVaC
         6lpw==
X-Gm-Message-State: ABy/qLaFKPdysif/EXEBAHxGxBjMbOT3YDrnmu1P+wQubA2EeINmmUKh
        AfLh0yOw+pvT7xUVv+ZHItYZGg==
X-Google-Smtp-Source: APBJJlEbn0yzom06E5Cay0i6NfMSg5ILA5LvSBS9SqCQV1Z32UDhAFJTgWqw4r7n9lmFd1zj5xg6TA==
X-Received: by 2002:a17:906:29a:b0:994:554b:7f27 with SMTP id 26-20020a170906029a00b00994554b7f27mr1461333ejf.2.1690448082053;
        Thu, 27 Jul 2023 01:54:42 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id g24-20020a1709064e5800b0099316c56db9sm504002ejw.127.2023.07.27.01.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:54:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Eric Jeong <eric.jeong.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3] regulator: dt-bindings: dlg,slg51000: Convert to DT schema
Date:   Thu, 27 Jul 2023 10:54:34 +0200
Message-Id: <20230727085434.16596-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the bindings for Dialog Semiconductor SLG51000 Voltage Regulator
to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. Correct typo "regulatoris".

Changes in v2:
1. Mention that supplies are required, if given regulator is enabled,
   which matches exactly original wording of old binding.
---
 .../bindings/regulator/dlg,slg51000.yaml      | 132 ++++++++++++++++++
 .../bindings/regulator/slg51000.txt           |  88 ------------
 MAINTAINERS                                   |   2 +-
 3 files changed, 133 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/dlg,slg51000.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/slg51000.txt

diff --git a/Documentation/devicetree/bindings/regulator/dlg,slg51000.yaml b/Documentation/devicetree/bindings/regulator/dlg,slg51000.yaml
new file mode 100644
index 000000000000..bad140418e49
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/dlg,slg51000.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/dlg,slg51000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dialog Semiconductor SLG51000 Voltage Regulator
+
+maintainers:
+  - Eric Jeong <eric.jeong.opensource@diasemi.com>
+  - Support Opensource <support.opensource@diasemi.com>
+
+properties:
+  compatible:
+    const: dlg,slg51000
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  dlg,cs-gpios:
+    maxItems: 1
+    description:
+      GPIO for chip select
+
+  vin3-supply:
+    description:
+      Input supply for ldo3, required if regulator is enabled
+
+  vin4-supply:
+    description:
+      Input supply for ldo4, required if regulator is enabled
+
+  vin5-supply:
+    description:
+      Input supply for ldo5, required if regulator is enabled
+
+  vin6-supply:
+    description:
+      Input supply for ldo6, required if regulator is enabled
+
+  vin7-supply:
+    description:
+      Input supply for ldo7, required if regulator is enabled
+
+  regulators:
+    type: object
+    additionalProperties: false
+
+    patternProperties:
+      "^ldo[1-7]$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          enable-gpios:
+            maxItems: 1
+
+        required:
+          - regulator-name
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
+    #include <dt-bindings/regulator/dlg,da9121-regulator.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@75 {
+            compatible = "dlg,slg51000";
+            reg = <0x75>;
+            dlg,cs-gpios = <&tlmm 69 GPIO_ACTIVE_HIGH>;
+            vin5-supply = <&vreg_s1f_1p2>;
+            vin6-supply = <&vreg_s1f_1p2>;
+
+            regulators {
+                ldo1 {
+                    regulator-name = "slg51000_b_ldo1";
+                    regulator-min-microvolt = <2400000>;
+                    regulator-max-microvolt = <3300000>;
+                };
+
+                ldo2 {
+                    regulator-name = "slg51000_b_ldo2";
+                    regulator-min-microvolt = <2400000>;
+                    regulator-max-microvolt = <3300000>;
+                };
+
+                ldo3 {
+                    regulator-name = "slg51000_b_ldo3";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <3750000>;
+                };
+
+                ldo4 {
+                    regulator-name = "slg51000_b_ldo4";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <3750000>;
+                };
+
+                ldo5 {
+                    regulator-name = "slg51000_b_ldo5";
+                    regulator-min-microvolt = <500000>;
+                    regulator-max-microvolt = <1200000>;
+                };
+
+                ldo6 {
+                    regulator-name = "slg51000_b_ldo6";
+                    regulator-min-microvolt = <500000>;
+                    regulator-max-microvolt = <1200000>;
+                };
+
+                ldo7 {
+                    regulator-name = "slg51000_b_ldo7";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <3750000>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/regulator/slg51000.txt b/Documentation/devicetree/bindings/regulator/slg51000.txt
deleted file mode 100644
index aa0733e49b90..000000000000
--- a/Documentation/devicetree/bindings/regulator/slg51000.txt
+++ /dev/null
@@ -1,88 +0,0 @@
-* Dialog Semiconductor SLG51000 Voltage Regulator
-
-Required properties:
-- compatible : Should be "dlg,slg51000" for SLG51000
-- reg : Specifies the I2C slave address.
-- xxx-supply: Input voltage supply regulator for ldo3 to ldo7.
-  These entries are required if regulators are enabled for a device.
-  An absence of these properties can cause the regulator registration to fail.
-  If some of input supply is powered through battery or always-on supply then
-  also it is required to have these parameters with proper node handle of always
-  on power supply.
-    vin3-supply: Input supply for ldo3
-    vin4-supply: Input supply for ldo4
-    vin5-supply: Input supply for ldo5
-    vin6-supply: Input supply for ldo6
-    vin7-supply: Input supply for ldo7
-
-Optional properties:
-- interrupt-parent : Specifies the reference to the interrupt controller.
-- interrupts : IRQ line information.
-- dlg,cs-gpios : Specify a valid GPIO for chip select
-
-Sub-nodes:
-- regulators : This node defines the settings for the regulators.
-  The content of the sub-node is defined by the standard binding
-  for regulators; see regulator.txt.
-
-  The SLG51000 regulators are bound using their names listed below:
-    ldo1
-    ldo2
-    ldo3
-    ldo4
-    ldo5
-    ldo6
-    ldo7
-
-Optional properties for regulators:
-- enable-gpios : Specify a valid GPIO for platform control of the regulator.
-
-Example:
-	pmic: slg51000@75 {
-		compatible = "dlg,slg51000";
-		reg = <0x75>;
-
-		regulators {
-			ldo1 {
-			        regulator-name = "ldo1";
-			        regulator-min-microvolt = <2400000>;
-			        regulator-max-microvolt = <3300000>;
-			};
-
-			ldo2 {
-			        regulator-name = "ldo2";
-			        regulator-min-microvolt = <2400000>;
-			        regulator-max-microvolt = <3300000>;
-			};
-
-			ldo3 {
-			        regulator-name = "ldo3";
-			        regulator-min-microvolt = <1200000>;
-			        regulator-max-microvolt = <3750000>;
-			};
-
-			ldo4 {
-			        regulator-name = "ldo4";
-			        regulator-min-microvolt = <1200000>;
-			        regulator-max-microvolt = <3750000>;
-			};
-
-			ldo5 {
-			        regulator-name = "ldo5";
-			        regulator-min-microvolt = <500000>;
-			        regulator-max-microvolt = <1200000>;
-			};
-
-			ldo6 {
-			        regulator-name = "ldo6";
-			        regulator-min-microvolt = <500000>;
-			        regulator-max-microvolt = <1200000>;
-			};
-
-			ldo7 {
-			        regulator-name = "ldo7";
-			        regulator-min-microvolt = <1200000>;
-			        regulator-max-microvolt = <3750000>;
-			};
-		};
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index df54d6eee746..0efb378621eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6038,7 +6038,7 @@ F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/mfd/dlg,da90*.yaml
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/dlg,da9*.yaml
-F:	Documentation/devicetree/bindings/regulator/slg51000.txt
+F:	Documentation/devicetree/bindings/regulator/dlg,slg51000.yaml
 F:	Documentation/devicetree/bindings/sound/da[79]*.txt
 F:	Documentation/devicetree/bindings/thermal/da90??-thermal.txt
 F:	Documentation/devicetree/bindings/watchdog/da90??-wdt.txt
-- 
2.34.1

