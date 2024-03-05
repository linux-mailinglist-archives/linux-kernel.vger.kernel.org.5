Return-Path: <linux-kernel+bounces-92601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8080F8722BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4161F282D3B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA169128385;
	Tue,  5 Mar 2024 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ddhZ2/mj"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF551272C3;
	Tue,  5 Mar 2024 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652402; cv=none; b=iaAFANHa0ON1NZrjAj7uiSOjoSI/583nBYosbZ1Znuo/Bcyc509D0ETeZYgP/vwPper+jAiRIjHjtBd2kB4UV77eofJQKzsQ8NgJrmzfbzSqb9mGX0LKZpLJmb2MOHD8YRuDO5+AQoOB+WTUQz6LHvFUUILqAntqR++7lZacFvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652402; c=relaxed/simple;
	bh=Ew3eJSanO6mflhfmFVB/8j7aJcFlCh33obPaFaNEobo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMrEWKcK6CVm3dvkhybUnDURpL3PVQhKIOQN9ExLEMbSuJOREOsxlouJv3xDGpTom4KacsA3HD7dBh93PeDbN23OC5CNrBv1X/gRP6u2jzojxeuiQ9B0NnbasA9YvThpmdT4KjWC8Q//jz2QtDQI2l02GKdd4lKjT6KG6FOvzWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ddhZ2/mj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709652399;
	bh=Ew3eJSanO6mflhfmFVB/8j7aJcFlCh33obPaFaNEobo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ddhZ2/mjAk/IDvAss+FFUl0HNrGuaVdPPiwRLLskLApmw0HMp7chr8FRLb/YCW8ea
	 dNq7psjkZuLk1/EKViV9/pXW3r8sg36pZX/a7NGovr+g1Bh/W2HEf/DC21a8jv0EdP
	 yierL+bFvk06nT24Pgm8G1y4RoViwWmrQ/e/aNIBdWh46rbB1slWEhEt9eTm5sjX4T
	 jnKMirxeTrjK9D21i514THmSm1VE0LQAZVJVr1J9sG6Ss6jN2wBo8AZuNOFfiTGuls
	 3VxPq5QRlskRGhJTMXOr1lLey/HmFB4t8xMu4vXdPtWWiQPYPjgvO+mg4Z+UHEimP5
	 6Dacd0Enh51+Q==
Received: from stla-brain-8255-1.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C5A22378204B;
	Tue,  5 Mar 2024 15:26:38 +0000 (UTC)
From: Julien Massot <julien.massot@collabora.com>
To: linux-media@vger.kernel.org
Cc: kernel@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	sakari.ailus@iki.fi,
	Julien Massot <julien.massot@collabora.com>
Subject: [PATCH v4 2/4] dt-bindings: media: add Maxim MAX96714 GMSL2 Deserializer
Date: Tue,  5 Mar 2024 16:26:06 +0100
Message-ID: <20240305152608.287527-3-julien.massot@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305152608.287527-1-julien.massot@collabora.com>
References: <20240305152608.287527-1-julien.massot@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT bindings for Maxim MAX96714 GMSL2 Deserializer.

Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
Change since v3:
 - Renamed file to maxim,max96714.yaml dropped the 'f' suffix
 - Removed mention to C-PHY since it's not supported by MAX96714 deserializers
 - Removed bus-type requirement on CSI endpoint since the device only support D-PHY
 - Removed the clock-lanes property in the dt example

Change since v2:
 - remove reg description
 - rename enable gpio to powerdown
 - use generic node name: i2c, serializer, deserializer
---
---
 .../bindings/media/i2c/maxim,max96714.yaml    | 169 ++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml b/Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml
new file mode 100644
index 000000000000..d76a5213ef0f
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml
@@ -0,0 +1,169 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2024 Collabora Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/maxim,max96714.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX96714 GMSL2 to CSI-2 Deserializer
+
+maintainers:
+  - Julien Massot <julien.massot@collabora.com>
+
+description: |
+  The MAX96714F deserializer converts GMSL2 serial inputs into MIPI
+  CSI-2 D-PHY formatted output. The device allows the GMSL2 link to
+  simultaneously transmit bidirectional control-channel data while forward
+  video transmissions are in progress. The MAX96714F can connect to one
+  remotely located serializer using industry-standard coax or STP
+  interconnects. The device cans operate in pixel or tunnel mode. In pixel mode
+  the MAX96714F can select individual video stream, while the tunnel mode forward all
+  the MIPI data received by the serializer.
+
+  The GMSL2 serial link operates at a fixed rate of 3Gbps in the
+  forward direction and 187.5Mbps in the reverse direction.
+
+properties:
+  compatible:
+    const: maxim,max96714f
+
+  reg:
+    maxItems: 1
+
+  powerdown-gpios:
+    maxItems: 1
+    description:
+      Specifier for the GPIO connected to the PWDNB pin.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        unevaluatedProperties: false
+        description: GMSL Input
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+            description:
+              Endpoint for GMSL2-Link port.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: CSI-2 Output port
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
+              link-frequencies:
+                maxItems: 1
+
+            required:
+              - data-lanes
+
+    required:
+      - port@1
+
+  i2c-gate:
+    $ref: /schemas/i2c/i2c-controller.yaml
+    unevaluatedProperties: false
+    description: |
+      The MAX96714 will pass through and forward the I2C requests from the
+      incoming I2C bus over the GMSL2 link. Therefore it supports an i2c-gate
+      subnode to configure a serializer.
+
+  port0-poc-supply:
+    description: Regulator providing Power over Coax for the GMSL port
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
+
+        deserializer@28 {
+            compatible = "maxim,max96714f";
+            reg = <0x28>;
+            powerdown-gpios = <&main_gpio0 37 GPIO_ACTIVE_LOW>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                port@0 {
+                    reg = <0>;
+                    max96714_gmsl_in: endpoint {
+                        remote-endpoint = <&max96917f_gmsl_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    max96714_csi_out: endpoint {
+                        data-lanes = <1 2 3 4>;
+                        link-frequencies = /bits/ 64 <400000000>;
+                        remote-endpoint = <&csi_in>;
+                    };
+                };
+            };
+
+            i2c-gate {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                serializer@40 {
+                    compatible = "maxim,max96717f";
+                    reg = <0x40>;
+                    gpio-controller;
+                    #gpio-cells = <2>;
+                    #clock-cells = <0>;
+
+                    ports {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+
+                        port@0 {
+                            reg = <0>;
+                            max96717f_csi_in: endpoint {
+                                bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
+                                data-lanes = <1 2>;
+                                lane-polarities = <1 0 1>;
+                                remote-endpoint = <&sensor_out>;
+                            };
+                        };
+
+                        port@1 {
+                            reg = <1>;
+                            max96917f_gmsl_out: endpoint {
+                                remote-endpoint = <&max96714_gmsl_in>;
+                            };
+                        };
+                    };
+                };
+            };
+        };
+    };
+...
-- 
2.44.0


