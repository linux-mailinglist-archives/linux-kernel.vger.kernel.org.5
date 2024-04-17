Return-Path: <linux-kernel+bounces-148591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B9E8A84D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A251C2098F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7155140380;
	Wed, 17 Apr 2024 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="hhPr0E0l"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4945313F449;
	Wed, 17 Apr 2024 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360980; cv=none; b=CiIt2kNm0B7YXX6UgRhOBE1T1qA/U1DGYZFxGb7L6oouRwndH6Ao7AZ+pBdKV4sBQaAPEzHUL9lcnCTbF+c3dXwFwvAIXD+2N69IwPdlKMDY+7+Ra3xA3cZebjh8YerC7WDMCNxEpFOvy/H0/1EpFX9rVQBakUL46ascIElDwFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360980; c=relaxed/simple;
	bh=5G8pe7MP76r9XFSp6obY0JufOD1w28dhrg0c/jHU/4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2yMMqjZGniYSj++xq+KPGJzczzYSVCbZcUcC+KJq31HQsK8JGNJ6/c5zBODgbwsoM5Cw1WxOraQ+mUps/K1UvzdlBVSc8UuHeASwneJdsEuQ0TDYcpYM6cUeiMU2rfd+2rolzPuIJKjB4hfXQkJno4xUkL0V/AFRSWYzKoaAek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=hhPr0E0l; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HCiwkp020736;
	Wed, 17 Apr 2024 15:35:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=selector1; bh=snhd86so2C8glVh9gr9S
	qBVtFEYqqmDhCpWp72NXfrU=; b=hhPr0E0lBRJznAI3Jfnv+h1rtaZkgjaRK/f/
	hmLSHX8SGZe7jT2AMmPPnLvqpUCKG05h0BLsU9FB+kS8DZETSnJeP8AeySPZwg9s
	kCbrf/BdJYwPujXZAZXkWr4HF5++izv45k+7J0pMUDslpUrVmcn+C2M1l5dEPV8f
	VhhLZPbObzTx+xbAaDCa540W68yS/MrXblT8+o70Ohk0DGvTcpkzo/y22FpZKYQy
	P8mxCk0HSixrX+vRA4MgBYK9hJV5b0A0SVSv8jPDE+qK/aIUKpA4cdgRpTjJVpvG
	d6IJ9/sDEquSax3oWfccFMZ2yi7UKArsXZVuD5hewTstg+haOg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg3m0qys3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 15:35:59 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 70D0D4002D;
	Wed, 17 Apr 2024 15:35:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B6AFD216831;
	Wed, 17 Apr 2024 15:35:26 +0200 (CEST)
Received: from localhost (10.130.72.242) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 17 Apr
 2024 15:35:26 +0200
From: Sylvain Petinot <sylvain.petinot@foss.st.com>
To: <benjamin.mugnier@foss.st.com>, <sylvain.petinot@foss.st.com>,
        <mchehab@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] media: dt-bindings: Add ST VD56G3 camera sensor binding
Date: Wed, 17 Apr 2024 15:34:52 +0200
Message-ID: <20240417133453.17406-2-sylvain.petinot@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240417133453.17406-1-sylvain.petinot@foss.st.com>
References: <20240417133453.17406-1-sylvain.petinot@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_10,2024-04-16_01,2023-05-22_02

Add devicetree bindings Documentation for ST VD56G3 & ST VD66GY camera
sensors. Update MAINTAINERS file.

Signed-off-by: Sylvain Petinot <sylvain.petinot@foss.st.com>
---
 .../bindings/media/i2c/st,st-vd56g3.yaml      | 143 ++++++++++++++++++
 MAINTAINERS                                   |   9 ++
 2 files changed, 152 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/st,st-vd56g3.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/st,st-vd56g3.yaml b/Documentation/devicetree/bindings/media/i2c/st,st-vd56g3.yaml
new file mode 100644
index 000000000000..6792c02fea5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/st,st-vd56g3.yaml
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (c) 2024 STMicroelectronics SA.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/st,st-vd56g3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics VD56G3 Global Shutter Image Sensor
+
+maintainers:
+  - Benjamin Mugnier <benjamin.mugnier@foss.st.com>
+  - Sylvain Petinot <sylvain.petinot@foss.st.com>
+
+description: |-
+  The STMicroelectronics VD56G3 is a 1.5 M pixel global shutter image sensor
+  with an active array size of 1124 x 1364 (portrait orientation).
+  It is programmable through I2C, the address is fixed to 0x10.
+  The sensor output is available via CSI-2, which is configured as either 1 or
+  2 data lanes.
+  The sensor provides 8 GPIOS that can be used for either
+    - frame synchronization (Master: out-sync or Slave: in-sync)
+    - external LED signal (synchronized with sensor integration periods)
+
+properties:
+  compatible:
+    enum:
+      - st,st-vd56g3
+      - st,st-vd66gy
+    description:
+      Two variants are availables; VD56G3 is a monochrome sensor while VD66GY
+      is a colour variant.
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  VCORE-supply:
+    description: Digital core power supply (1.15V)
+
+  VDDIO-supply:
+    description: Digital IO power supply (1.8V)
+
+  VANA-supply:
+    description: Analog power supply (2.8V)
+
+  reset-gpios:
+    description: Sensor reset active low GPIO (XSHUTDOWN)
+    maxItems: 1
+
+  st,leds:
+    description:
+      Sensor's GPIOs used for external LED control.
+      Signal being the enveloppe of the integration time.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 8
+    items:
+      minimum: 0
+      maximum: 7
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
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
+          link-frequencies:
+            minItems: 1
+            maxItems: 1
+            items:
+              enum: [402000000, 750000000]
+
+          lane-polarities:
+            minItems: 1
+            maxItems: 3
+            items:
+              enum: [0, 1]
+            description: Any lane can be inverted or not.
+
+        required:
+          - clock-lanes
+          - data-lanes
+          - link-frequencies
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - VCORE-supply
+  - VDDIO-supply
+  - VANA-supply
+  - reset-gpios
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
+        vd56g3: camera-sensor@10 {
+            compatible = "st,st-vd56g3";
+            reg = <0x10>;
+
+            clocks = <&camera_clk_12M>;
+
+            VCORE-supply = <&camera_vcore_v1v15>;
+            VDDIO-supply = <&camera_vddio_v1v8>;
+            VANA-supply = <&camera_vana_v2v8>;
+
+            reset-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
+            st,leds = <6>;
+
+            port {
+                vd56g3_ep: endpoint {
+                    clock-lanes = <0>;
+                    data-lanes = <1 2>;
+                    link-frequencies =
+                      /bits/ 64 <402000000>;
+                    remote-endpoint = <&csiphy0_ep>;
+                };
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 7c121493f43d..991e65627e18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20868,6 +20868,15 @@ S:	Maintained
 F:	Documentation/hwmon/stpddc60.rst
 F:	drivers/hwmon/pmbus/stpddc60.c
 
+ST VD56G3 DRIVER
+M:	Benjamin Mugnier <benjamin.mugnier@foss.st.com>
+M:	Sylvain Petinot <sylvain.petinot@foss.st.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/i2c/st,st-vd56g3.yaml
+F:	drivers/media/i2c/st-vd56g3.c
+
 ST VGXY61 DRIVER
 M:	Benjamin Mugnier <benjamin.mugnier@foss.st.com>
 M:	Sylvain Petinot <sylvain.petinot@foss.st.com>
-- 
2.17.1


