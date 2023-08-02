Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2DC76D33B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbjHBQDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbjHBQDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:03:45 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266681981;
        Wed,  2 Aug 2023 09:03:44 -0700 (PDT)
Received: from fabio-Precision-3551.. (unknown [IPv6:2804:14c:485:4b61:2f8f:bd6c:fc72:9ea8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B40328686A;
        Wed,  2 Aug 2023 18:03:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1690992222;
        bh=stsIjxq9S++0PLJnDOzwLCJ+2e49dPweR6ZLwENhcQw=;
        h=From:To:Cc:Subject:Date:From;
        b=ti1awV4eem1BWH3AsgUHnXFNYBEMNvc5GwJ+6Zb+5oTj9riwaYyUlohFLY0DGTI9d
         MxOefi4o50u+MCX+5pBCa+MlGRlvpFtVFbFT6tLBKp3zH057iELNz/OMrKappz8q/Z
         A+BZ4Cosk2SF7zAc0zPnjFI82VNK8su850J5sJlUBV1lqygIwn+c0C0pggmYT/G65H
         gTECzLj/95UcaEcG+gDWFObvnk5GEkYDfxziAZYmhFq/CVsbdEQCEFe1B3Y672O2AG
         le3rjayy5M7zBoidz1MxJMmJcXwi7/ZUkTsadl02pX/wFSmrvCzU0JL7hTw8+myJYw
         pgBOYFZeCArWQ==
From:   Fabio Estevam <festevam@denx.de>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3] dt-bindings: media: Add OV5642
Date:   Wed,  2 Aug 2023 13:03:26 -0300
Message-Id: <20230802160326.293420-1-festevam@denx.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As explained in the description text from trivial-devices.yaml:

"This is a list of trivial I2C and SPI devices that have simple device tree
bindings, consisting only of a compatible field, an address and possibly an
interrupt line."

A camera device does not fall into this category as it needs other
properties such as regulators, reset and powerdown GPIOs, clocks,
media endpoint.

Remove the OV5642 entry from trivial-devices.yaml and add its own
ovti,ov5642.yaml.

Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes since v2:
- Made ovti,ov5642.yaml dual-licensed (Conor)
- Fixed whitespace warning (Conor)
- Squased both patches (Conor)
- Added Conor's Reviewed-by tag.
- Added linux-media on Cc.

 .../bindings/media/i2c/ovti,ov5642.yaml       | 118 ++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |   2 -
 2 files changed, 118 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5642.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5642.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5642.yaml
new file mode 100644
index 000000000000..b48f1bc6aca4
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5642.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/ovti,ov5642.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OmniVision OV5642 Image Sensor
+
+maintainers:
+  - Fabio Estevam <festevam@gmail.com>
+
+allOf:
+  - $ref: /schemas/media/video-interface-devices.yaml#
+
+properties:
+  compatible:
+    const: ovti,ov5642
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: XCLK Input Clock
+
+  clock-names:
+    const: xclk
+
+  AVDD-supply:
+    description: Analog voltage supply, 2.8V.
+
+  DVDD-supply:
+    description: Digital core voltage supply, 1.5V.
+
+  DOVDD-supply:
+    description: Digital I/O voltage supply, 1.8V.
+
+  powerdown-gpios:
+    maxItems: 1
+    description: Reference to the GPIO connected to the powerdown pin, if any.
+
+  reset-gpios:
+    maxItems: 1
+    description: Reference to the GPIO connected to the reset pin, if any.
+
+  rotation:
+    enum:
+      - 0
+      - 180
+
+  port:
+    description: Digital Output Port
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    additionalProperties: false
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          clock-lanes:
+            const: 0
+
+          data-lanes:
+            minItems: 1
+            maxItems: 2
+            items:
+              enum: [1, 2]
+
+          bus-width:
+            enum: [8, 10]
+
+          data-shift:
+            enum: [0, 2]
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+      #include <dt-bindings/gpio/gpio.h>
+
+      i2c {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          camera@3c {
+              compatible = "ovti,ov5642";
+              pinctrl-names = "default";
+              pinctrl-0 = <&pinctrl_ov5642>;
+              reg = <0x3c>;
+              clocks = <&clk_ext_camera>;
+              clock-names = "xclk";
+              DOVDD-supply = <&vgen4_reg>;
+              AVDD-supply = <&vgen3_reg>;
+              DVDD-supply = <&vgen2_reg>;
+              powerdown-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
+              reset-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
+
+              port {
+                  /* Parallel bus endpoint */
+                  ov5642_to_parallel: endpoint {
+                      remote-endpoint = <&parallel_from_ov5642>;
+                      bus-width = <8>;
+                      data-shift = <2>; /* lines 9:2 are used */
+                      hsync-active = <0>;
+                      vsync-active = <0>;
+                      pclk-sample = <1>;
+                  };
+              };
+          };
+      };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 40bc475ee7e1..ab1423a4aa7f 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -313,8 +313,6 @@ properties:
           - nuvoton,w83773g
             # OKI ML86V7667 video decoder
           - oki,ml86v7667
-            # OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with OmniBSI and Embedded TrueFocus
-          - ovti,ov5642
             # 48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
           - plx,pex8648
             # Pulsedlight LIDAR range-finding sensor
-- 
2.34.1

