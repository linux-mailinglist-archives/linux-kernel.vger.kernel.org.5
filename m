Return-Path: <linux-kernel+bounces-51453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0247C848B70
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D36CB23D3A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 06:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC878BFC;
	Sun,  4 Feb 2024 06:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="c6mpVocr"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB91F6FA8;
	Sun,  4 Feb 2024 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707027359; cv=none; b=hKCY4vtE0OpJiUAxI8N5eg+n7JJFSuoh6FMw1i9LyWgACuEGC2b2RPsDNh3Ao695zgOQfwUn8njepGbkT8bxeRyrrar0Uj6eOUI6QnQRCiSkpJ4kOjAkJsT3xYWYRVU8huoZfyNpo4TOLhFQFhWVfyeBRCIdGQa+CuBxK6eJ6hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707027359; c=relaxed/simple;
	bh=YGzUZurQCcIfBoKHF951KIiK5wmeHO9cMp1/nuRHBLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJ0e/v/I3sLIfC0zRUmbxaHGNypWx6iT1UxOrMsEEpIR97CX6LqpuY58UaCv2Z6fu9k5f61b7NidViMkroPrtA5zG5SYPUw0mT1MQPxMlMDlaFLVtQIZbx0PnEKXMVg9mTfHxCndxlt3kLDzpUwlJvqhfmud7lvm6ZTbv60qrRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=c6mpVocr; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d87b7450c32411eea2298b7352fd921d-20240204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=H6oZdRQu02l28VKqNYqalgklkCiI6TUP7psr7KlmPLc=;
	b=c6mpVocrNb+Xn24+bXMLNfWkyqhKJNeAk9vscEKUJXhCGD0unwNBLEvo7618EfF9buxb0k+uYr2jdCnQFxDnBq8B2v3ix7s7t2SJmUjhNnJO/AJMe1ngtNC+XCdxGVINhKFJJ9jb6wWmkm9GQGUZG54xWdpA7d3vA1j17HeAi6c=;
X-CID-CACHE: Type:Local,Time:202402041411+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:cbc7b6b0-5fd5-4c64-b1b5-a65596b1aade,IP:0,U
	RL:25,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:7ec4fe8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d87b7450c32411eea2298b7352fd921d-20240204
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1712910203; Sun, 04 Feb 2024 14:15:51 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 4 Feb 2024 14:15:49 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 4 Feb 2024 14:15:48 +0800
From: Zhi Mao <zhi.mao@mediatek.com>
To: <mchehab@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <sakari.ailus@linux.intel.com>
CC: <laurent.pinchart@ideasonboard.com>, <shengnan.wang@mediatek.com>,
	<yaya.chang@mediatek.com>, <10572168@qq.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, <yunkec@chromium.org>,
	<conor+dt@kernel.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <jacopo.mondi@ideasonboard.com>,
	<zhi.mao@mediatek.com>, <hverkuil-cisco@xs4all.nl>, <heiko@sntech.de>,
	<jernej.skrabec@gmail.com>, <macromorgan@hotmail.com>,
	<linus.walleij@linaro.org>, <hdegoede@redhat.com>,
	<tomi.valkeinen@ideasonboard.com>, <gerald.loacker@wolfvision.net>,
	<andy.shevchenko@gmail.com>, <bingbu.cao@intel.com>,
	<dan.scally@ideasonboard.com>, <linux-media@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] media: dt-bindings: i2c: add GalaxyCore GC08A3 image sensor
Date: Sun, 4 Feb 2024 14:15:37 +0800
Message-ID: <20240204061538.2105-2-zhi.mao@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240204061538.2105-1-zhi.mao@mediatek.com>
References: <20240204061538.2105-1-zhi.mao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add YAML device tree binding for GC08A3 CMOS image sensor,
and the relevant MAINTAINERS entries.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
---
 .../bindings/media/i2c/galaxycore,gc08a3.yaml | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
new file mode 100644
index 000000000000..8c09e8c121e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (c) 2023 MediaTek Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/galaxycore,gc08a3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GalaxyCore gc08a3 1/4" 8M Pixel MIPI CSI-2 sensor
+
+maintainers:
+  - Zhi Mao <zhi.mao@mediatek.com>
+
+description:
+  The gc08a3 is a raw image sensor with an MIPI CSI-2 image data
+  interface and CCI (I2C compatible) control bus. The output format
+  is raw Bayer.
+
+properties:
+  compatible:
+    const: galaxycore,gc08a3
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  dovdd-supply: true
+
+  avdd-supply: true
+
+  dvdd-supply: true
+
+  reset-gpios:
+    description: Reference to the GPIO connected to the RESETB pin.
+    maxItems: 1
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    additionalProperties: false
+    description:
+      Output port node, single endpoint describing the CSI-2 transmitter.
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          data-lanes:
+            oneOf:
+              - items:
+                  - const: 1
+                  - const: 2
+                  - const: 3
+                  - const: 4
+              - items:
+                  - const: 1
+                  - const: 2
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
+  - dovdd-supply
+  - avdd-supply
+  - dvdd-supply
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
+        sensor@31 {
+            compatible = "galaxycore,gc08a3";
+            reg = <0x31>;
+
+            clocks = <&gc08a3_clk>;
+
+            reset-gpios = <&pio 19 GPIO_ACTIVE_HIGH>;
+
+            avdd-supply = <&gc08a3_avdd>;
+            dovdd-supply = <&gc08a3_dovdd>;
+            dvdd-supply = <&gc08a3_dvdd>;
+
+            port {
+                sensor_out: endpoint {
+                    data-lanes = <1 2 3 4>;
+                    link-frequencies = /bits/ 64 <336000000 207000000>;
+                    remote-endpoint = <&seninf_csi_port_0_in>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.25.1


