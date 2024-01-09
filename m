Return-Path: <linux-kernel+bounces-20287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9B6827CE5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E06D1B234D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56974A3D;
	Tue,  9 Jan 2024 02:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PK2TVB2x"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E5D539F;
	Tue,  9 Jan 2024 02:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a5ccd5b4ae9611ee9e680517dc993faa-20240109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IWBQKwB30XTIPahwksFJPoGVYkx7lShr6C2cXwh84Ac=;
	b=PK2TVB2xPoesvwMCzsXqBWk5YSwsyM2fX1KwAI695s9MnRKWCD5frrQDJQHacV1FiULeRAHxA3Euf+MVD2DO224wNTKKJZSI9QIOuvh4aie2CRX/ZBJAc0DYQ+g4oC8ZKS9kLBdvbp1g+3CgkVHRhZnjSsbh69vhESDqJxy5KBc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:046a9fce-3de0-4599-b28d-53dd2ba62f34,IP:0,U
	RL:25,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:2722227f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a5ccd5b4ae9611ee9e680517dc993faa-20240109
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 188973960; Tue, 09 Jan 2024 10:27:34 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 9 Jan 2024 10:27:33 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 9 Jan 2024 10:27:32 +0800
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
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3 1/2] media: dt-bindings: media: i2c: Document GC08A3 bindings
Date: Tue, 9 Jan 2024 10:27:14 +0800
Message-ID: <20240109022715.30278-2-zhi.mao@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240109022715.30278-1-zhi.mao@mediatek.com>
References: <20240109022715.30278-1-zhi.mao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.662100-8.000000
X-TMASE-MatchedRID: y64C6oV0e4euhCBFl/b63gPZZctd3P4BWjWsWQUWzVoCsxyhR8y7CQaT
	alM8C773wvUxdKBGcQwRA4hwIn2MDY2WQSzu3zX3y7TSWcbz49bdqE4Lo/klA5tx6bI/EO4aj+J
	vxx0kMPmwXo1R/OtIAf8p52y+xvG8rpRH5+x/2gP7wup9zY+8A30tCKdnhB58hYfw868k05b3PD
	iXO/tFSfcUt5lc1lLgjMejjvPkBr5dZFyrSV9dqlvY06QABz+vln7DohCgcl3Wi3X7tgzki8dIc
	vrXhfFzBzrv263DKSByDapkHP3gaMPaDPSFXRxEeVx6tG2tmBgc/j4aI5S1Lnr9GD0zfOvEAaqv
	v/mhgrEIcy9ODq9nmVZca9RSYo/b
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.662100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 99F667DB78B9521C27F9144749DD084104FC86EEB4D04F9D33B9DCE1D53198D62000:8
X-MTK: N

Add YAML device tree binding for GC08A3 CMOS image sensor,
and the relevant MAINTAINERS entries.

Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
---
 .../bindings/media/i2c/galaxycore,gc08a3.yaml | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
new file mode 100644
index 000000000000..1246d3b4a767
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
+        sensor0@31 {
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
+                sensor0_out_2: endpoint {
+                    data-lanes = <1 2 3 4>;
+                    link-frequencies = /bits/ 64 <336000000 207000000>;
+                    remote-endpoint = <&seninf_csi_port_0_in_2>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.25.1



