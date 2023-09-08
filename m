Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145C379873F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 14:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243296AbjIHMoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 08:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjIHMoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:44:01 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DA719AB;
        Fri,  8 Sep 2023 05:43:57 -0700 (PDT)
Received: from www.ideasonboard.com (unknown [103.251.226.21])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 97CA310FE;
        Fri,  8 Sep 2023 14:42:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694176946;
        bh=v1UGzxWIKTDQJc9ycpQLKbWs/8ZE2HNPY8CGJjNasC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JHpAjuq5mt83UoHxvQHmPSP/djpXfpo1vNbkqGyamggI+qGiiDUAVnFcBgTQoV+ds
         ZbuIagalS6zzgKgxkp8OeSG9P3LvVqubIy1SQieDq26u6mib1YQwPwTnkE026ZqYv2
         AMn/7EGmNLr+JrBrLlheY64tqc1c4THoj0dbaUMU=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Lee Jackson <lee.jackson@arducam.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        kieran.bingham@ideasonboard.com, jacopo.mondi@ideasonboard.com,
        Umang Jain <umang.jain@ideasonboard.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/2] dt-bindings: media: i2c: Add IMX519 CMOS sensor
Date:   Fri,  8 Sep 2023 08:43:43 -0400
Message-ID: <20230908124344.171662-2-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908124344.171662-1-umang.jain@ideasonboard.com>
References: <20230908124344.171662-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lee Jackson <lee.jackson@arducam.com>

Add YAML device tree binding for IMX519 CMOS image sensor and
the relevant MAINTAINERS entries.

Signed-off-by: Lee Jackson <lee.jackson@arducam.com>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/media/i2c/sony,imx519.yaml       | 107 ++++++++++++++++++
 MAINTAINERS                                   |   8 ++
 2 files changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml
new file mode 100644
index 000000000000..4ba318581aa5
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/sony,imx519.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sony 1/2.5-Inch 16Mpixel CMOS Digital Image Sensor
+
+maintainers:
+  - Lee Jackson <lee.jackson@arducam.com>
+
+description:
+  The Sony IMX519 is a 1/2.5-inch CMOS active pixel digital image sensor
+  with an active array size of 4656H x 3496V. It is programmable through
+  I2C interface. The I2C address is fixed to 0x1A as per sensor data sheet.
+  Image data is sent through MIPI CSI-2, which is configured as either 2 or
+  4 data lanes.
+
+properties:
+  compatible:
+    const: sony,imx519
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  vdig-supply:
+    description:
+      Digital I/O voltage supply, 1.05 volts
+
+  vana-supply:
+    description:
+      Analog voltage supply, 2.8 volts
+
+  vddl-supply:
+    description:
+      Digital core voltage supply, 1.8 volts
+
+  reset-gpios:
+    description:
+      Reference to the GPIO connected to the xclr pin, if any.
+      Must be released (set high) after all supplies and INCK are applied.
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    additionalProperties: false
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          data-lanes:
+            anyOf:
+              - items:
+                  - const: 1
+                  - const: 2
+              - items:
+                  - const: 1
+                  - const: 2
+                  - const: 3
+                  - const: 4
+
+        required:
+          - data-lanes
+          - link-frequencies
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - vana-supply
+  - vdig-supply
+  - vddl-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        sensor@1a {
+            compatible = "sony,imx519";
+            reg = <0x1a>;
+            clocks = <&imx519_clk>;
+            vana-supply = <&imx519_vana>;   /* 2.8v */
+            vdig-supply = <&imx519_vdig>;   /* 1.05v */
+            vddl-supply = <&imx519_vddl>;   /* 1.8v */
+
+            port {
+                imx519_ep: endpoint {
+                    remote-endpoint = <&csi1_ep>;
+                    data-lanes = <1 2>;
+                    clock-noncontinuous;
+                    link-frequencies = /bits/ 64 <408000000>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 58f030fc19d4..bca8512c0439 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19898,6 +19898,14 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
 F:	drivers/media/i2c/imx415.c
 
+SONY IMX519 SENSOR DRIVER
+M:	Arducam Kernel Maintenance <info@arducam.com>
+M:	Lee Jackson <lee.jackson@arducam.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml
+
 SONY MEMORYSTICK SUBSYSTEM
 M:	Maxim Levitsky <maximlevitsky@gmail.com>
 M:	Alex Dubov <oakad@yahoo.com>
-- 
2.41.0

