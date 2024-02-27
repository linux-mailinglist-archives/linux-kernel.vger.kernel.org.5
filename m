Return-Path: <linux-kernel+bounces-82899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5A7868B84
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E571F21725
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AB1135A7D;
	Tue, 27 Feb 2024 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WAFouEi6"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635573D68;
	Tue, 27 Feb 2024 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024572; cv=none; b=PTCj2ETBuA1eFDKbpOYNx8iphj24UWTLml4yuSE9Q7SRYz9gb8o87Q028EoJCEMtKpGIRkFJEVYm9BPOqyy59SO8O+caZ/8bfF2qymG6/9OL1qL3kdHxSojVrpW2ue0g6ZaCrJASheil3ALY/OjVaX8Qt9hB9vYoPlxhqrFP/v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024572; c=relaxed/simple;
	bh=MDyB7kN9fLzkF3IUaQuVq2aN3lZtwp94JqS0ur3aaFs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qHmSgrSg888Zxfh9Q/be5oTVhQWGakRx2fFjl9+NtUSCigK9/c9+qQywvfiuSJ/dOTpK/OBN9DL6AxDBJ+VySIjJDkczSA5nbl6NZ2UOrCthGladAYkQMy8Zsspvq7Wc/0qk9OlGVzD6AGAWR6EY+yKaye0cel7DbvnfIQGjzmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WAFouEi6; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f4540afcd54e11eea4ad694c3f9da370-20240227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=tmj8YPmmqvqYG5v+SWsXq/apQfPyzcxQHhDN/sTXgcQ=;
	b=WAFouEi6N11te0IuPXOLm7Qkrqqo6ImhICnKtq1D242RoaWBlb2dmarCmNDEuFetCup64fQY0hftU6hiXCydE550XhE72iU5tiZ2n6TA77NVTPD5typFHmA4nuSDAk8/kjTHdDoNIXHQawuA4wQS9Tx/sEExNuODCWDz/zsf8WY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:b09291ff-bcba-45e1-b45a-14aa6171dcbb,IP:0,U
	RL:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6f543d0,CLOUDID:e3775e84-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f4540afcd54e11eea4ad694c3f9da370-20240227
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1368438755; Tue, 27 Feb 2024 17:02:37 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 27 Feb 2024 17:02:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 27 Feb 2024 17:02:36 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Kaehlcke <mka@chromium.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <linux-usb@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>, Yow-shin Liou
	<yow-shin.liou@mediatek.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
Subject: [PATCH 1/2] dt-bindings: usb: Add binding for TI USB8020B hub controller
Date: Tue, 27 Feb 2024 17:02:27 +0800
Message-ID: <20240227090228.22156-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

The TI USB8020B is a USB 3.0 hub controller with 2 ports.

This initial version of the binding only describes USB related aspects
of the USB8020B, it does not cover the option of connecting the controller
as an i2c slave.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../devicetree/bindings/usb/ti,usb8020b.yaml  | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,usb8020b.yaml

diff --git a/Documentation/devicetree/bindings/usb/ti,usb8020b.yaml b/Documentation/devicetree/bindings/usb/ti,usb8020b.yaml
new file mode 100644
index 000000000000..8ef117793e11
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,usb8020b.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ti,usb8020b.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI USB8020B USB 3.0 hub controller
+
+maintainers:
+  - Macpaul Lin <macpaul.lin@mediatek.com>
+
+allOf:
+  - $ref: usb-device.yaml#
+
+properties:
+  compatible:
+    enum:
+      - usb451,8025
+      - usb451,8027
+
+  reg: true
+
+  reset-gpios:
+    items:
+      - description: GPIO specifier for GRST# pin.
+
+  vdd-supply:
+    description:
+      VDD power supply to the hub
+
+  peer-hub:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the peer hub on the controller.
+
+required:
+  - compatible
+  - reg
+  - peer-hub
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    usb {
+        dr_mode = "host";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* 2.0 hub on port 1 */
+        hub_2_0: hub@1 {
+          compatible = "usb451,8027";
+          reg = <1>;
+          peer-hub = <&hub_3_0>;
+          reset-gpios = <&pio 7 GPIO_ACTIVE_HIGH>;
+          vdd-supply = <&usb_hub_fixed_3v3>;
+        };
+
+        /* 3.0 hub on port 2 */
+        hub_3_0: hub@2 {
+          compatible = "usb451,8025";
+          reg = <2>;
+          peer-hub = <&hub_2_0>;
+          reset-gpios = <&pio 7 GPIO_ACTIVE_HIGH>;
+          vdd-supply = <&usb_hub_fixed_3v3>;
+        };
+    };
-- 
2.18.0


