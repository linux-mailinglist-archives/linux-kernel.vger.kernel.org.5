Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553EA75E1C2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 14:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjGWMVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 08:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGWMVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 08:21:30 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F60D10CB
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 05:21:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9924ac01f98so600284166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 05:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690114887; x=1690719687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B1cLgNIedT+Ie5WRuhcdVecy9d3P0WoWQ2Awyt4JKTE=;
        b=LsR0LoW4j6rFuLgFzAJ5cUItzRvVYwVX9JGvaQXZ5WKEould38X3LYJqUwgTV91tnZ
         78PYxRbDF7LHj6/8mqaFf9eS2e1du7QWs3voDpiGoQCbPO0Rz982r4tHH/idYywuFv5t
         Yl6ZiTKC5sitknY/63qqQOvbIxUP1jV4FRkCTQe8aORKwVVwEm7IiWdLDK/wqhsJG8Q3
         /6TyviPmdtlfkWzZuIzd0/3RQk6Wiq9IrIIDfbb76CWPd6I/nFBCx3ypLapmhL3VzDGB
         87VrxWq3J4e3h5rIRAvfSDKKOOVk3rxXvd9b0vGiTAdxU1YwQpi8Y9mnWvwIpr3JfQK+
         skAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690114887; x=1690719687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1cLgNIedT+Ie5WRuhcdVecy9d3P0WoWQ2Awyt4JKTE=;
        b=hJd+CMvo4Ux0UyFrti1Pb2Fi7LpxMOGikuAC+Qa187lbblW5j17pr41/Gj1TypfiBe
         IuIkH+QnVWHj4hnjk5OuuqubsfON2dwBE3iTtN0VQnKryq3dXXkw6xxRvnFWi5WRXeY4
         P8mNqWcM37hrtMEOs8vNOjIZtd+lMRQCY6MTcpWcUiJzAWToPmI+ctSOpGHmgrieyCdw
         VGOwlOX1p6H+nyH5rXAvFh9SXwumZca6WoTySGHN6rhPtmv7NFaaVzoYqe2nA1v4jUJv
         kMWllJ9rLASVbL63MitCGAF3ypo/P9dz/XSrKLB4K3IT8vU6goeaFOie3xqszqYGzMJY
         /hkw==
X-Gm-Message-State: ABy/qLawDmhOSBKpN5upuDyip+linS+edrQpzlHY4PU1rsQtbSUqf9R4
        lkFn1U965msJRn7UQysHEjCqE/L/VNnJu2DGT6c=
X-Google-Smtp-Source: APBJJlHw1xaAYBtf/cFybFyC/ORL7p8ztHiTibZ0nO9ky8H1Ld4nQvyj1cUOSsCa9DPq40vfHLmC7A==
X-Received: by 2002:a17:907:2715:b0:993:e691:6dd5 with SMTP id w21-20020a170907271500b00993e6916dd5mr7109642ejk.7.1690114887354;
        Sun, 23 Jul 2023 05:21:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id q16-20020a170906b29000b00992316f0690sm5105282ejz.74.2023.07.23.05.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 05:21:26 -0700 (PDT)
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
Subject: [PATCH] regulator: dt-bindings: dlg,slg51000: Convert to DT schema
Date:   Sun, 23 Jul 2023 14:21:21 +0200
Message-Id: <20230723122121.69908-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the bindings for Dialog Semiconductor SLG51000 Voltage Regulator
to DT schema.  Changes during conversion: do not require the supplies,
because existing DTS does not provide all of them.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/regulator/dlg,slg51000.yaml      | 132 ++++++++++++++++++
 .../bindings/regulator/slg51000.txt           |  88 ------------
 MAINTAINERS                                   |   2 +-
 3 files changed, 133 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/dlg,slg51000.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/slg51000.txt

diff --git a/Documentation/devicetree/bindings/regulator/dlg,slg51000.yaml b/Documentation/devicetree/bindings/regulator/dlg,slg51000.yaml
new file mode 100644
index 000000000000..b7042a3d8d2d
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
+      Input supply for ldo3
+
+  vin4-supply:
+    description:
+      Input supply for ldo4
+
+  vin5-supply:
+    description:
+      Input supply for ldo5
+
+  vin6-supply:
+    description:
+      Input supply for ldo6
+
+  vin7-supply:
+    description:
+      Input supply for ldo7
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
index 6e5d3ba62d99..4b299e39111d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6039,7 +6039,7 @@ F:	Documentation/devicetree/bindings/mfd/da90*.txt
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

