Return-Path: <linux-kernel+bounces-163988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133EB8B76DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3900283CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A807172794;
	Tue, 30 Apr 2024 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="q3WE5xmA"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C740E171668;
	Tue, 30 Apr 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483235; cv=none; b=BC/UL6O4519XEBhvZu4p88UH/35jvJR9JmTchm0GUi1OPP9pDOX0+5jwM1D+CnerCMo0cZVGQOI9PG7ziJXa9Ct3WIFIeLSft4yQtBltBkCmVrL4bPwvBAdLD3/ky5XBr/p2wlbnppLcWOlQm9TLyaa198BWxP5WLXyUzFRbeiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483235; c=relaxed/simple;
	bh=voQCEBZHmym6NYAzHkS5ZCFDtC8rUCLKGC3bt56hgdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kroVJHl68IFj4rIm9+XGNriVqTTZjEsK5l+NziSTYP37cb51FYGHsFmZefcUSEu9kOBqimDRAa3/qW7PqaZP4s66OkzCkY3lQVMql/6Gbnu61B7sUlybm3VZhz79E6zImkiUVS97g8GSPB3nwxnqGZp9rwWUGFez6j5/7Rm2+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=q3WE5xmA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714483232;
	bh=voQCEBZHmym6NYAzHkS5ZCFDtC8rUCLKGC3bt56hgdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3WE5xmAc37+27fIqHPT+eTX6BPnpfRMC72p7vV7yXJPa64zpEAZezaQbV/XbTVMY
	 QgYypHV14CLpWfl40J8YfXjYllEg8Kxc/ocpiNMUtS4EZVp8GaIxgAlG2I8RgPj7MA
	 suW3oTvfvkBssz2Y+fs5VKf1J5KrJHi/TWeuTNKxC6vcWXeZJM2MVtisnpLWhhvqao
	 fQTVbunpa4nBEK6TRd+t0gfr+dcBwETPgRvzVOIt+FD3lQI8LG1syLhLBDusZFxWZH
	 J8kqmfvxv2oIH+ZcLQ6Z6KkAr4HMGwYQUUT/ROb8PhMRfo1+8sraFVJ70ErYnwJkkC
	 CzsB6RkEnrkCQ==
Received: from apertis.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 82A0C3782059;
	Tue, 30 Apr 2024 13:20:31 +0000 (UTC)
From: Julien Massot <julien.massot@collabora.com>
To: linux-media@vger.kernel.org,
	sakari.ailus@iki.fi
Cc: devicetree@vger.kernel.org,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Julien Massot <julien.massot@collabora.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 1/5] dt-bindings: media: add Maxim MAX96717 GMSL2 Serializer
Date: Tue, 30 Apr 2024 15:19:27 +0200
Message-ID: <20240430131931.166012-2-julien.massot@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430131931.166012-1-julien.massot@collabora.com>
References: <20240430131931.166012-1-julien.massot@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT bindings for Maxim MAX96717 GMSL2 Serializer.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
Change since v6:
 - Remove mention to C-PHY therefore remove the bus-type property
   since the device only D-PHY.
Change since v5:
 - Reverse the fallback MAX96717 can fallback to MAX96717F
 - Use const instead of enum for MAX96717F compatible
 
Change since v4:
 - Add compatible for MAX96717 and use it as a fallback for MAX96717F
 - Remove extra '|' for decriptions
 - Reference 'i2c-gate' instead of 'i2c-controller'

Change since v3:
 - Renamed file to maxim,max96717.yaml dropped the 'f' suffix
 - Added lane-polarities and bus type properties to the CSI endpoint

Change since v2:
 - remove reg description
 - add data lanes min/maxItems
 - Use generic node name 
---
 .../bindings/media/i2c/maxim,max96717.yaml    | 157 ++++++++++++++++++
 1 file changed, 157 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml b/Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml
new file mode 100644
index 000000000000..d1e8ba6e368e
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml
@@ -0,0 +1,157 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2024 Collabora Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/maxim,max96717.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MAX96717 CSI-2 to GMSL2 Serializer
+
+maintainers:
+  - Julien Massot <julien.massot@collabora.com>
+
+description:
+  The MAX96717 serializer converts MIPI CSI-2 D-PHY formatted input
+  into GMSL2 serial outputs. The device allows the GMSL2 link to
+  simultaneously transmit bidirectional control-channel data while forward
+  video transmissions are in progress. The MAX96717 can connect to one
+  remotely located deserializer using industry-standard coax or STP
+  interconnects. The device cans operate in pixel or tunnel mode. In pixel mode
+  the MAX96717 can select the MIPI datatype, while the tunnel mode forward all the MIPI
+  data received by the serializer.
+  The MAX96717 supports Reference Over Reverse (channel),
+  to generate a clock output for the sensor from the GMSL reverse channel.
+
+  The GMSL2 serial link operates at a fixed rate of 3Gbps or 6Gbps in the
+  forward direction and 187.5Mbps in the reverse direction.
+  MAX96717F only supports a fixed rate of 3Gbps in the forward direction.
+
+properties:
+  compatible:
+    oneOf:
+      - const: maxim,max96717f
+      - items:
+          - enum:
+              - maxim,max96717
+          - const: maxim,max96717f
+
+  '#gpio-cells':
+    const: 2
+    description:
+      First cell is the GPIO pin number, second cell is the flags. The GPIO pin
+      number must be in range of [0, 10].
+
+  gpio-controller: true
+
+  '#clock-cells':
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: CSI-2 Input port
+
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+
+              lane-polarities:
+                minItems: 1
+                maxItems: 5
+
+            required:
+              - data-lanes
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        unevaluatedProperties: false
+        description: GMSL Output port
+
+    required:
+      - port@1
+
+  i2c-gate:
+    $ref: /schemas/i2c/i2c-gate.yaml
+    unevaluatedProperties: false
+    description:
+      The MAX96717 will forward the I2C requests from the
+      incoming GMSL2 link. Therefore, it supports an i2c-gate
+      subnode to configure a sensor.
+
+required:
+  - compatible
+  - reg
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/media/video-interfaces.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        serializer: serializer@40 {
+            compatible = "maxim,max96717f";
+            reg = <0x40>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            #clock-cells = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    max96717f_csi_in: endpoint {
+                        data-lanes = <1 2 3 4>;
+                        remote-endpoint = <&sensor_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    max96917f_gmsl_out: endpoint {
+                        remote-endpoint = <&deser_gmsl_in>;
+                    };
+                };
+            };
+
+            i2c-gate {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                sensor@10 {
+                    compatible = "st,st-vgxy61";
+                    reg = <0x10>;
+                    reset-gpios = <&serializer 0 GPIO_ACTIVE_LOW>;
+                    clocks = <&serializer>;
+                    VCORE-supply = <&v1v2>;
+                    VDDIO-supply = <&v1v8>;
+                    VANA-supply = <&v2v8>;
+                    port {
+                        sensor_out: endpoint {
+                            data-lanes = <1 2 3 4>;
+                            remote-endpoint = <&max96717f_csi_in>;
+                        };
+                    };
+                };
+            };
+        };
+    };
+...
-- 
2.44.0


