Return-Path: <linux-kernel+bounces-16281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2F2823C27
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7C20B24DA2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C041A1CA98;
	Thu,  4 Jan 2024 06:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MDI5NjCf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE201DFE4;
	Thu,  4 Jan 2024 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d4e8107eaac811eea2298b7352fd921d-20240104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Uv6Gd2q3aQyxlXr8dcRbSBp3HzgyRoMe+zBqyZakg90=;
	b=MDI5NjCfP4Errl23R1XAW2WDx/6qx4SUUXEwNabSnL1bBR4eZ/0TB32ofe8xXwu4xp0v07k2VAoXI9DZMGYNlBXUW04N+rcZ3hIq954UPc7T6TR6wdKV62M/VvGZ/+0vt4q3GVxESsnVmkzjUyOdXYKl7BI/sMj0FA3NCIq5d9g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:0c9a84c3-1397-42c4-8b52-2dbef2424b11,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-35
X-CID-META: VersionHash:5d391d7,CLOUDID:9bacf97e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: d4e8107eaac811eea2298b7352fd921d-20240104
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 37036318; Thu, 04 Jan 2024 14:16:43 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 4 Jan 2024 14:16:42 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 4 Jan 2024 14:16:41 +0800
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Chunfeng Yun <chunfeng.yun@mediatek.com>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Mathias
 Nyman <mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Eddie Hung
	<eddie.hung@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/3] dt-bindings: usb: mtk-xhci: add a property for Gen1 isoc-in transfer issue
Date: Thu, 4 Jan 2024 14:16:38 +0800
Message-ID: <20240104061640.7335-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

For Gen1 isoc-in endpoint on controller before about SSUSB IPM v1.6.0, it
still send out unexpected ACK after receiving a short packet in burst
transfer, this will cause an exception on connected device, specially for
a 4k camera.
Add a quirk property "rx-fifo-depth" to work around this hardware issue,
prefer to use 3k bytes;
The side-effect is that it may cause performance drop about 10%, including
bulk transfer.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v5: fix typos, add acked-by and reviewed-by
v4: change rx-fifo size in bytes
v3: add fifo depth unit, change the value range from 0-3 to 1-4
v2: change 'mediatek,rxfifo-depth' to 'rx-fifo-depth'
---
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index e9644e333d78..924fd3d748a8 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -124,6 +124,17 @@ properties:
       defined in the xHCI spec on MTK's controller.
     default: 5000
 
+  rx-fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      It is a quirk used to work around Gen1 isoc-in endpoint transfer issue
+      that still send out unexpected ACK after device finishes the burst
+      transfer with a short packet and cause an exception, specially on a 4K
+      camera device, it happens on controller before about IPM v1.6.0;
+      the side-effect is that it may cause performance drop about 10%,
+      including bulk transfer, prefer to use 3k here. The size is in bytes.
+    enum: [1024, 2048, 3072, 4096]
+
   # the following properties are only used for case 1
   wakeup-source:
     description: enable USB remote wakeup, see power/wakeup-source.txt
-- 
2.18.0


