Return-Path: <linux-kernel+bounces-127693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F27A894F90
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71CD1F24A3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B33D5C8F4;
	Tue,  2 Apr 2024 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lgDQhM2c"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434265B5D3;
	Tue,  2 Apr 2024 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052490; cv=none; b=fkvA0w9KyX/HMFSpf5qeo9Ny0uPxjc8TOtQHxXaZmoVZe0drGahhm32KFj3MSytQVL/Px6lBoC/hTH+/kJTFZPLdrlFZl2tC/ZxEvhthqF/2K2GU8dRnsaYBQoEwtQo6KkVqJOQhpHiwOLzXUQp76EHX78HzZOWKfJ6pPFNbrg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052490; c=relaxed/simple;
	bh=JZ4HuL8RzgfCdNusE5xAG9ZebMy1iEu5iHgT0lgKWWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t8Et6asE8ccHwPC8mUoeDGNcIYVqI5MZu8BXjE4GZugazRgBJaL27UpoZ8sZir25OUoXgMt1XyEGY6roysIRnHpasg4k9Qai6jh9YYkFh9zip/IldT3EwvebsUcRk9McX+1S+mMV069L01YzagX7qW5AeQwHzbeP7TrtK19jwxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=lgDQhM2c; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.118] (unknown [103.86.18.232])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AFA3766F;
	Tue,  2 Apr 2024 12:07:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712052451;
	bh=JZ4HuL8RzgfCdNusE5xAG9ZebMy1iEu5iHgT0lgKWWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lgDQhM2c5u/7j4c6xpL+5ViUUdxMC33LqBZ1y/1YjiMN3LNmFWervyXx4cMDjACqr
	 ceQ+q6+HdHuTbbrKybU1ObYn4ba3UYGCnSz+6s/RRaQBguTeA45t921g7BhD5WhCSM
	 cypV4B2+5LJodaLj9JD3QkVAi48VApGLsRdNtcwk=
From: Umang Jain <umang.jain@ideasonboard.com>
Date: Tue, 02 Apr 2024 15:37:50 +0530
Subject: [PATCH v4 1/2] media: dt-bindings: media: Add bindings for IMX283
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-kernel-name-extraversion-v4-1-fb776893e4ec@ideasonboard.com>
References: <20240402-kernel-name-extraversion-v4-0-fb776893e4ec@ideasonboard.com>
In-Reply-To: <20240402-kernel-name-extraversion-v4-0-fb776893e4ec@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Umang Jain <umang.jain@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712052475; l=4151;
 i=umang.jain@ideasonboard.com; s=20240402; h=from:subject:message-id;
 bh=JZ4HuL8RzgfCdNusE5xAG9ZebMy1iEu5iHgT0lgKWWs=;
 b=gzOrzsiS2MQePSM0EnJtPmcX2JcyVmQWmMr14v03HdDPoabiTeFZowtoCO0qH7PSQunntC6Et
 cq5mkDpMA4jDBAYNpCv/HCg47tjpk9m3LE0BUncxBnIqbAUO9qGdApX
X-Developer-Key: i=umang.jain@ideasonboard.com; a=ed25519;
 pk=8K9qSAtc2dNF4Ax+jYC0w9dlfptU7wxPBQwOy0nxRoc=

- Add dt-bindings documentation for Sony IMX283 sensor driver
- Add MAINTAINERS entry for Sony IMX283 binding documentation

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../devicetree/bindings/media/i2c/sony,imx283.yaml | 107 +++++++++++++++++++++
 MAINTAINERS                                        |   8 ++
 2 files changed, 115 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx283.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx283.yaml
new file mode 100644
index 000000000000..e4f49f1435a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx283.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2024 Ideas on Board Oy
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/sony,imx283.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sony IMX283 Sensor
+
+maintainers:
+  - Kieran Bingham <kieran.bingham@ideasonboard.com>
+  - Umang Jain <umang.jain@ideasonboard.com>
+
+description:
+  IMX283 sensor is a Sony CMOS active pixel digital image sensor with an active
+  array size of 5472H x 3648V. It is programmable through I2C interface. The
+  I2C client address is fixed to 0x1a as per sensor data sheet. Image data is
+  sent through MIPI CSI-2.
+
+properties:
+  compatible:
+    const: sony,imx283
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: Clock frequency from 6 to 24 MHz.
+    maxItems: 1
+
+  vadd-supply:
+    description: Analog power supply (2.9V)
+
+  vdd1-supply:
+    description: Interface power supply (1.8V)
+
+  vdd2-supply:
+    description: Digital power supply (1.2V)
+
+  reset-gpios:
+    description: Sensor reset (XCLR) GPIO
+    maxItems: 1
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
+                  - const: 3
+                  - const: 4
+
+          link-frequencies: true
+
+        required:
+          - data-lanes
+          - link-frequencies
+
+    required:
+      - endpoint
+
+required:
+  - compatible
+  - reg
+  - clocks
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
+        camera@1a {
+            compatible = "sony,imx283";
+            reg = <0x1a>;
+            clocks = <&imx283_clk>;
+
+            assigned-clocks = <&imx283_clk>;
+            assigned-clock-parents = <&imx283_clk_parent>;
+            assigned-clock-rates = <12000000>;
+
+            vadd-supply = <&camera_vadd_2v9>;
+            vdd1-supply = <&camera_vdd1_1v8>;
+            vdd2-supply = <&camera_vdd2_1v2>;
+
+            port {
+                imx283: endpoint {
+                    remote-endpoint = <&cam>;
+                    data-lanes = <1 2 3 4>;
+                    link-frequencies = /bits/ 64 <360000000>;
+                };
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 1a89e0d2ac61..a2e164131650 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20367,6 +20367,14 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/i2c/sony,imx274.yaml
 F:	drivers/media/i2c/imx274.c
 
+SONY IMX283 SENSOR DRIVER
+M:	Kieran Bingham <kieran.bingham@ideasonboard.com>
+M:	Umang Jain <umang.jain@ideasonboard.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/i2c/sony,imx283.yaml
+
 SONY IMX290 SENSOR DRIVER
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-media@vger.kernel.org

-- 
2.43.0


