Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0F680B247
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 06:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjLIF4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 00:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjLIF4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 00:56:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1726A10F1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 21:56:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BD5C433C9;
        Sat,  9 Dec 2023 05:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702101372;
        bh=uuoD3H22vWn21TrrgCc1sSk7u/rIE8eHUMfeeffNbF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZH9eLeyp/v+aC9wYHUlgVoZASh8I9avWwTsaxA6vyFDE0WqaPpdLLzxK4QjV14i/9
         eiLkTVfx+xYCZ+PMRv15wDJhd0jGtXgeVRf+6ggdoOLFw72sQmQvh1pSBLcqJHivFU
         b6C1PHXg9pEijSi+l+CGib9WPJhrxRjnlAPapN0x8suh9j5lW/Wfr6nIxhNrEkBZVS
         6WQWEpAeS++dywAXH3JMBPNOON1s4zinJg66GE1EYVanuaHzMbs6Pi185MgxzHUZeI
         b3H6cTBgE/VgEDpayzCPRFhxOlX8Djv5OsM4iXDTnpPdkpBYMbw1fYRHCEtaBNmCyD
         kAF+ELU/ombxQ==
Received: by mercury (Postfix, from userid 1000)
        id 29ECB106CC74; Sat,  9 Dec 2023 00:19:49 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Alain Volmat <alain.volmat@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/3] media: dt-bindings: gc0308: add binding
Date:   Sat,  9 Dec 2023 00:18:17 +0100
Message-ID: <20231208231933.284277-2-sre@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208231933.284277-1-sre@kernel.org>
References: <20231208231933.284277-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding for GalaxyCore GC0308 camera sensor.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../bindings/media/i2c/galaxycore,gc0308.yaml | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,gc0308.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc0308.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc0308.yaml
new file mode 100644
index 000000000000..f81e7daed67b
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc0308.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/galaxycore,gc0308.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Galaxycore GC0308 and GC0309 Image Sensors
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+description: |
+  The GalaxyCore GC0308 (1/6.5") and GC0309 (1/9") are 640x480 VGA sensors
+  programmable through an I2C interface and connected via parallel bus.
+  They include an ISP capable of auto exposure and auto white balance.
+
+allOf:
+  - $ref: ../video-interface-devices.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: galaxycore,gc0308
+      - items:
+          - const: galaxycore,gc0309
+          - const: galaxycore,gc0308
+
+  reg:
+    const: 0x21
+
+  clocks:
+    description: Reference to the xclk clock.
+    maxItems: 1
+
+  reset-gpios:
+    description: GPIO descriptor for the reset pin.
+    maxItems: 1
+
+  powerdown-gpios:
+    description: GPIO descriptor for the powerdown pin.
+    maxItems: 1
+
+  vdd28-supply:
+    description: 2.8V supply
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    description: |
+      Video output port.
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          bus-width: true
+          data-shift: true
+          hsync-active: true
+          vsync-active: true
+          data-active: true
+          pclk-sample: true
+
+        required:
+          - bus-width
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - powerdown-gpios
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        camera-sensor@21 {
+            compatible = "galaxycore,gc0308";
+            reg = <0x21>;
+            clocks = <&camera_clk>;
+            powerdown-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+            vdd28-supply = <&vdd28>;
+
+            port {
+                gc0308_ep: endpoint {
+                    remote-endpoint = <&parallel_from_gc0308>;
+                    bus-width = <8>;
+                    data-shift = <2>; /* lines 9:2 are used */
+                    hsync-active = <1>; /* active high */
+                    vsync-active = <1>; /* active high */
+                    data-active = <1>; /* active high */
+                    pclk-sample = <1>; /* sample on rising edge */
+                };
+            };
+        };
+    };
+
+...
-- 
2.42.0

