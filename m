Return-Path: <linux-kernel+bounces-96267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E3787597F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D421F251E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850B813DB83;
	Thu,  7 Mar 2024 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gJXableY"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644C413B78E;
	Thu,  7 Mar 2024 21:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847670; cv=none; b=rSwExA78s7Ka3VnZFHp2PkoXMCXjemy2ZE37y1R4AN1IaEKJD8MInXa+7t+O3VRdzWezOI/BXXXvSeggZe/Ea3YnbDUAuI+qYSDsUxgJh0wBz7vHMV6yI/v81zGPXHKZANnmbRuCSxeMIUV/J26VqlAJ6iz7EALcv9z/Ir31L3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847670; c=relaxed/simple;
	bh=Yu4MN0Ny/lowOoUJbTsSB6h90wxtLg7yAU7NjO1ht1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRayY4vvj8YhPj3npnf0MO6UAkcdnWTEKlJ2WVE2itfNzMyHSPGmX4+AHNlqv9BtyWMJSqgbiJt21cR0G99ORa03RiqlIyvdI66+2kReayQEtSZuLZ5kf9HXMg0pGyHy+luNiNv/8MLvpVjFRsX0ietT11CYe8tl+HN80/AJ2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=gJXableY; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.251.226.70])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7D0501FB2;
	Thu,  7 Mar 2024 22:40:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709847647;
	bh=Yu4MN0Ny/lowOoUJbTsSB6h90wxtLg7yAU7NjO1ht1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gJXableYS+B10zqzWWLmJiU+2zKqBYVg+Ys0iXmPBAAjjyOmms39bTGBRk/hM+JE2
	 5qo3IBBrZPj0BPQiC7dsjod7afbgxT4UoA0CcPp6sj0JPLseVuXsiC5hL7cIij8xF2
	 Kai7DqYL1nbnHEajv1cDmQTq2jJZlrDhjcvB7udo=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	willl will <will@willwhang.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] media: dt-bindings: media: Add bindings for IMX283
Date: Fri,  8 Mar 2024 03:10:42 +0530
Message-ID: <20240307214048.858318-2-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240307214048.858318-1-umang.jain@ideasonboard.com>
References: <20240307214048.858318-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Add dt-bindings documentation for Sony IMX283 sensor driver
- Add MAINTAINERS entry for Sony IMX283 binding documentation

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../bindings/media/i2c/sony,imx283.yaml       | 107 ++++++++++++++++++
 MAINTAINERS                                   |   8 ++
 2 files changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx283.yaml

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
index 73d898383e51..32f790c3a5f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20368,6 +20368,14 @@ T:	git git://linuxtv.org/media_tree.git
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


