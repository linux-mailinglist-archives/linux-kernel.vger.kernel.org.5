Return-Path: <linux-kernel+bounces-163989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A62EF8B76DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB9D1F2319F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D312172BCD;
	Tue, 30 Apr 2024 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yycm5S8P"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FB2171669;
	Tue, 30 Apr 2024 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483236; cv=none; b=b6MClbROBGHqs3DOmBuKdx+CA91HB9qqtrwl3Mu6+AlK6XAgiKhXhr+fN72Ae8k1KgFrjWnsT7LVeff1CvMYDznYDsXU8jFvQiLbXuCKL8vDs2xSJvAZ5+x9JMEwwGV//heeLmNedfb/qtHn/VcphfRV5fOekvy9jRL1Xw7oauE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483236; c=relaxed/simple;
	bh=qZaK9Bh1M+ODKzlAgLfpqqh3JU5aWG2Nd+I6gy9XSPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxHa/K3PUrxCHuPhBn4Tm3nlJaON1/OCpMxcFz7kGNO6aNTfBlxqRg/tAGm0a4s6FI/FIOKyJPAcRfeH26Yeyl4Iv1N7xdfO0WvbUb1IZc4/apilmrAW3AcXXdMLyYcReY0fkqm5p8ncXcpfoVdTPzF3r+l5OwZQAB4KhsnGoJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yycm5S8P; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714483233;
	bh=qZaK9Bh1M+ODKzlAgLfpqqh3JU5aWG2Nd+I6gy9XSPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yycm5S8PTxTSiCEBtX2p1TWV7scRFLvJ4vaxqkRv13Lndw8vdwtxWyLKah86dYkX8
	 LHzVTKJ8NR5PNlBZoDVGPl3pN/nulpyszkom6JIeMAVxU746BS0V5JxdpDYs56J+KA
	 ZVQ+ypxPvIj8tSVs2E7tDaQligBrTZJvFOD0ppqsLhA3rddqT3ce3zdgsql/uITmOD
	 IbgjrWaMBmiJw+WWkzmK2W2r4W9OoUo7ntzHDD/N7GygNf0EIO8bctrj56AOPpg2AV
	 CRPjnD9Wy1fqYkrPm2DEZVDFMZdOAqemdPGoCwu+2AOdpyH3k9MApPpw2oA3CmVmYB
	 2lKCl0omM0EEQ==
Received: from apertis.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5FAAF378205B;
	Tue, 30 Apr 2024 13:20:32 +0000 (UTC)
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
Subject: [PATCH v7 2/5] dt-bindings: media: add Maxim MAX96714 GMSL2 Deserializer
Date: Tue, 30 Apr 2024 15:19:28 +0200
Message-ID: <20240430131931.166012-3-julien.massot@collabora.com>
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

Add DT bindings for Maxim MAX96714 GMSL2 Deserializer.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
Change since v6:
- Remove 'bus-type' serializer property in the example

Change since v5:
 - Reverse the fallback MAX96714 can fallback to MAX96714F
 - Use const instead of enum for MAX96714F compatible

Change since v4:
 - Add compatible for MAX96714 and use it as a fallback for MAX96714F
 - Remove extra '|' for decriptions
 - Reference 'i2c-gate' instead of 'i2c-controller'

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
 .../bindings/media/i2c/maxim,max96714.yaml    | 174 ++++++++++++++++++
 1 file changed, 174 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml b/Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml
new file mode 100644
index 000000000000..3ace50e11921
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml
@@ -0,0 +1,174 @@
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
+description:
+  The MAX96714 deserializer converts GMSL2 serial inputs into MIPI
+  CSI-2 D-PHY formatted output. The device allows the GMSL2 link to
+  simultaneously transmit bidirectional control-channel data while forward
+  video transmissions are in progress. The MAX96714 can connect to one
+  remotely located serializer using industry-standard coax or STP
+  interconnects. The device cans operate in pixel or tunnel mode. In pixel mode
+  the MAX96714 can select individual video stream, while the tunnel mode forward all
+  the MIPI data received by the serializer.
+
+  The GMSL2 serial link operates at a fixed rate of 3Gbps or 6Gbps in the
+  forward direction and 187.5Mbps in the reverse direction.
+  MAX96714F only supports a fixed rate of 3Gbps in the forward direction.
+
+properties:
+  compatible:
+    oneOf:
+      - const: maxim,max96714f
+      - items:
+          - enum:
+              - maxim,max96714
+          - const: maxim,max96714f
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
+    $ref: /schemas/i2c/i2c-gate.yaml
+    unevaluatedProperties: false
+    description:
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


