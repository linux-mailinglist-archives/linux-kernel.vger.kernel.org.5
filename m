Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A9B76C127
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 01:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjHAXlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 19:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjHAXlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 19:41:18 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FDD1BCC;
        Tue,  1 Aug 2023 16:41:16 -0700 (PDT)
Received: from fabio-Precision-3551.. (unknown [IPv6:2804:14c:485:4b61:339d:323b:fee1:9781])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D9BF186A8A;
        Wed,  2 Aug 2023 01:41:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1690933275;
        bh=aRUq6hR3JhEPlpA5cAQbwwhze3SCHMdIOmmYmYYGtlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Is9WNu7vMU0zU50LNoN+mm+6GwaFH6vAqqEhEf10ox6APsQGNl9d5HQ11SEiePeP2
         cp4s3aj9WhaZFTeTzHNlOSDTRwl34yHoGzWkCbx9y3TCE3wzxSwYRc36buVlAPSIOv
         TvPsROWrG+8CpPPR0QddsY/Bzu0FIH5UspVV3/EgWaHhmWnaofwWl5rCETxR0/eEjK
         SYcBaB0Et/tV4ludZS/qCnFavKVbQCGCHoJG05hzAF2XxPf+4quyGzYhvVVf/ZS2co
         rMpzM9H3sowfAV38c8deXeQBW/Qgc9yAtkNYcdwDHPnWYi3eixGh4eSIlr9Zr75IRs
         PRyta1ejBd6kg==
From:   Fabio Estevam <festevam@denx.de>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 2/2] dt-bindings: media: Add OV5642
Date:   Tue,  1 Aug 2023 20:40:47 -0300
Message-Id: <20230801234047.136099-2-festevam@denx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801234047.136099-1-festevam@denx.de>
References: <20230801234047.136099-1-festevam@denx.de>
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

Add DT bindings for OmniVision OV5642 Image Sensor.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Introduce ov5642.yaml (Conor).

 .../bindings/media/i2c/ovti,ov5642.yaml       | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5642.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5642.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5642.yaml
new file mode 100644
index 000000000000..585b4fcf01b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5642.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: GPL-2.0-only
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
-- 
2.34.1

