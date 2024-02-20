Return-Path: <linux-kernel+bounces-72180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CADF85B088
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC931F2185B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA97D25616;
	Tue, 20 Feb 2024 01:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Okc34UvM"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E1A210E2;
	Tue, 20 Feb 2024 01:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708392375; cv=none; b=VFX3ZjY6NkSQGCGaN++1JjAV4LV2EcBESXUM/JmYvqn2XYNBFWrbHXGivaD0Nazn09XN0igGVJXUgy9nFJP266pQ74RcXi1MVoWA2vyjUnAOHeKfFwszJ6CqiGpcMo9+juZ6UxkgkQJzFn9TlSn8EBBEaUhxy2COUQX+VgCv0mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708392375; c=relaxed/simple;
	bh=HVDBBL/3JWqvC0r68ICiHb3lyWXf2L4NhzUal3snxks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxKJRf8aqfg5hJN1DW2Be1S3PJBBgJgClRrGILe4LksKsWxiE5mrSru6c3ZHsxOj5Z7enx3UWCD/ZH0GUjfSid8oXxvLBFRVjNHIoeQfab4pV7LPrOtFy4MBvWTMCpKkXRGDI2uj6f5LQjEAeIBPLZW48rxzj7dStmG57Nv/RMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Okc34UvM; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 054e6066cf8f11eea2298b7352fd921d-20240220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0bRDwS7PBvuQdYZ5dgFryXT71V4ywxCPzpwNBZamc5g=;
	b=Okc34UvMSQz5maXz0BE9vvOXxKAth1bF5tiir/Z+wszghZJcgaLwYXmvELpTB7w2gh8wHHDPPzNI2Hwlmxr3rEwX0fWV0wodTOwxhcyF4OM5VxEqpo2Y86hflev7NxEM6XSq/IwqwC/ZihGJUWYaqrgxtqL7Gp1TEo1Rtltd3i4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:86337aa4-04b9-47c8-8ed3-337c2fdc323e,IP:0,U
	RL:25,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:42aa9380-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 054e6066cf8f11eea2298b7352fd921d-20240220
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1959251277; Tue, 20 Feb 2024 09:26:07 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 20 Feb 2024 09:26:05 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 20 Feb 2024 09:26:04 +0800
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
Subject: [PATCH v5 1/2] media: dt-bindings: i2c: add GalaxyCore GC08A3 image sensor
Date: Tue, 20 Feb 2024 09:25:39 +0800
Message-ID: <20240220012540.10607-2-zhi.mao@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240220012540.10607-1-zhi.mao@mediatek.com>
References: <20240220012540.10607-1-zhi.mao@mediatek.com>
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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


