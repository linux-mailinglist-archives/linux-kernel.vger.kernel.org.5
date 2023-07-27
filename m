Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D137657E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbjG0Plg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjG0Plb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:41:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDE01FFC;
        Thu, 27 Jul 2023 08:41:30 -0700 (PDT)
Received: from umang.jainideasonboard.com (unknown [103.86.18.216])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 903F76CA;
        Thu, 27 Jul 2023 17:40:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690472429;
        bh=BDEv4ub6oRoAX2k1GMn7Rl/lTFLNwL13RFTFqaLGTNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V150NDySO+XDhSx04d9obOMgG9FVlD7ESDPN5WE+uSmZOojmx+s3m0KcRdwBWdUni
         coWaVlL7ecy8AwsaX1pcYRXT6ARxkkYcyppFWM9aGvqRMUb3GyrMibK+CfWZ7aonXD
         PVMuy7LfwcatIFQjqoBnj+Uroi9OZCAusNKOlZlw=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Lee Jackson <lee.jackson@arducam.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        kieran.bingham@ideasonboard.com,
        Marco Felsch <m.felsch@pengutronix.de>,
        jacopo.mondi@ideasonboard.com,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 1/2] media: dt-bindings: imx519: Add IMX519 DT bindings
Date:   Thu, 27 Jul 2023 21:11:07 +0530
Message-Id: <20230727154108.308320-2-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230727154108.308320-1-umang.jain@ideasonboard.com>
References: <20230727154108.308320-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lee Jackson <lee.jackson@arducam.com>

Add YAML device tree binding documentation for IMX519 CMOS
image sensor.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../bindings/media/i2c/sony,imx519.yaml       | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml
new file mode 100644
index 000000000000..6f38b09890d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/imx519.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sony 1/2.5-Inch 16Mpixel CMOS Digital Image Sensor
+
+maintainers:
+  - Lee Jackson <lee.jackson@arducam.com>
+
+description: |-
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
+    description: I2C device address
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  VDIG-supply:
+    description:
+      Digital I/O voltage supply, 1.05 volts
+
+  VANA-supply:
+    description:
+      Analog voltage supply, 2.8 volts
+
+  VDDL-supply:
+    description:
+      Digital core voltage supply, 1.8 volts
+
+  reset-gpios:
+    description: |-
+      Reference to the GPIO connected to the xclr pin, if any.
+      Must be released (set high) after all supplies and INCK are applied.
+
+  # See ../video-interfaces.txt for more details
+  port:
+    type: object
+    properties:
+      endpoint:
+        type: object
+        properties:
+          data-lanes:
+            description: |-
+              The sensor supports either two-lane, or four-lane operation.
+              For two-lane operation the property must be set to <1 2>.
+            items:
+              - const: 1
+              - const: 2
+
+          clock-noncontinuous:
+            type: boolean
+            description: |-
+              MIPI CSI-2 clock is non-continuous if this property is present,
+              otherwise it's continuous.
+
+          link-frequencies:
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint64-array
+            description:
+              Allowed data bus frequencies.
+
+        required:
+          - link-frequencies
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - VANA-supply
+  - VDIG-supply
+  - VDDL-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        imx519: sensor@1a {
+            compatible = "sony,imx519";
+            reg = <0x1a>;
+            clocks = <&imx519_clk>;
+            VANA-supply = <&imx519_vana>;   /* 2.8v */
+            VDIG-supply = <&imx519_vdig>;   /* 1.05v */
+            VDDL-supply = <&imx519_vddl>;   /* 1.8v */
+
+            port {
+                imx519_0: endpoint {
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
-- 
2.39.1

