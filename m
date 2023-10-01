Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F5E7B47BD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjJANwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbjJANws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:52:48 -0400
Received: from smtprelay05.ispgateway.de (smtprelay05.ispgateway.de [80.67.18.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71EF91;
        Sun,  1 Oct 2023 06:52:44 -0700 (PDT)
Received: from [92.206.139.21] (helo=note-book.lan)
        by smtprelay05.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1qmwsE-0004h3-1S; Sun, 01 Oct 2023 15:52:42 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Date:   Sun, 01 Oct 2023 15:52:12 +0200
Subject: [PATCH v5 1/2] dt-bindings: leds: Add Kinetic KTD2026/2027 LED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231001-ktd202x-v5-1-f544a1d0510d@apitzsch.eu>
References: <20231001-ktd202x-v5-0-f544a1d0510d@apitzsch.eu>
In-Reply-To: <20231001-ktd202x-v5-0-f544a1d0510d@apitzsch.eu>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Kinetic KTD2026/2027 LED driver devicetree bindings.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 .../devicetree/bindings/leds/kinetic,ktd202x.yaml  | 171 +++++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/kinetic,ktd202x.yaml b/Documentation/devicetree/bindings/leds/kinetic,ktd202x.yaml
new file mode 100644
index 000000000000..832c030a5acf
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/kinetic,ktd202x.yaml
@@ -0,0 +1,171 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/kinetic,ktd202x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kinetic KTD2026/7 RGB/White LED Driver
+
+maintainers:
+  - André Apitzsch <git@apitzsch.eu>
+
+description: |
+  The KTD2026/7 is a RGB/White LED driver with I2C interface.
+
+  The data sheet can be found at:
+    https://www.kinet-ic.com/uploads/KTD2026-7-04h.pdf
+
+properties:
+  compatible:
+    enum:
+      - kinetic,ktd2026
+      - kinetic,ktd2027
+
+  reg:
+    maxItems: 1
+
+  vin-supply:
+    description: Regulator providing power to the "VIN" pin.
+
+  vio-supply:
+    description: Regulator providing power for pull-up of the I/O lines.
+      Note that this regulator does not directly connect to KTD2026, but is
+      needed for the correct operation of the status ("ST") and I2C lines.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  multi-led:
+    type: object
+    $ref: leds-class-multicolor.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^led@[0-3]$":
+        type: object
+        $ref: common.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            description: Index of the LED.
+            minimum: 0
+            maximum: 3
+
+        required:
+          - reg
+          - color
+
+    required:
+      - "#address-cells"
+      - "#size-cells"
+
+patternProperties:
+  "^led@[0-3]$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        description: Index of the LED.
+        minimum: 0
+        maximum: 3
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@30 {
+            compatible = "kinetic,ktd2026";
+            reg = <0x30>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            vin-supply = <&pm8916_l17>;
+            vio-supply = <&pm8916_l6>;
+
+            led@0 {
+                reg = <0>;
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_RED>;
+            };
+
+            led@1 {
+                reg = <1>;
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_GREEN>;
+            };
+
+            led@2 {
+                reg = <2>;
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_BLUE>;
+            };
+        };
+    };
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@30 {
+            compatible = "kinetic,ktd2026";
+            reg = <0x30>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            vin-supply = <&pm8916_l17>;
+            vio-supply = <&pm8916_l6>;
+
+            multi-led {
+                color = <LED_COLOR_ID_RGB>;
+                function = LED_FUNCTION_STATUS;
+
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    color = <LED_COLOR_ID_RED>;
+                };
+
+                led@1 {
+                    reg = <1>;
+                    color = <LED_COLOR_ID_GREEN>;
+                };
+
+                led@2 {
+                    reg = <2>;
+                    color = <LED_COLOR_ID_BLUE>;
+                };
+            };
+        };
+    };

-- 
2.42.0

