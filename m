Return-Path: <linux-kernel+bounces-11842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5094A81EC67
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF101F22B46
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45BA539C;
	Wed, 27 Dec 2023 06:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NcxIVVNS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC02363AA;
	Wed, 27 Dec 2023 06:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a24991aca47d11ee9e680517dc993faa-20231227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=NGljdjksTJl7cSSu9XYy7FO8kYtRZge6sNRdb6feXL4=;
	b=NcxIVVNS0IdJpB5IsuQktbnvfJasN0mYmtFKHPu1rBiCeDvV3SiZytfUSH5h1xgy9sEI/DdeJPzUSwFLoqeYDjmGLqSiV383PR+fR6aXS6HSJEANYRpZIGDXQsCdGu7Z1ZH+3EU7/i3F4f3o/kLEht5lz+X2d0SIUsg1WelQyIg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:59444eab-01a9-4c50-a5d2-b27ae2a07c76,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:5d391d7,CLOUDID:e2489d8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a24991aca47d11ee9e680517dc993faa-20231227
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 171561098; Wed, 27 Dec 2023 14:03:19 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Dec 2023 14:03:17 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Dec 2023 14:03:17 +0800
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Chunfeng Yun <chunfeng.yun@mediatek.com>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, "Mathias
 Nyman" <mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Eddie Hung
	<eddie.hung@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>
Subject: [PATCH v4 1/3] dt-bindings: usb: mtk-xhci: add a property for Gen1 isoc-in transfer issue
Date: Wed, 27 Dec 2023 14:03:14 +0800
Message-ID: <20231227060316.8539-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.698500-8.000000
X-TMASE-MatchedRID: G4NbPPbBCbo28LK855iUisp9Bgr5ONKhXxT5cg8K/td+YesuCgkiXKLs
	GdYIe0oEWB8Rur00SOpx/Hv6BudnAqB/4ZSHyd2lsyNb+yeIRApRnscLnNAC7BjQD3m2MCf7FWo
	Asts4LpWPqQJ9fQR1ziV2YP+J+E56aACC67qZQKpsG7r4Qh7N3DNzwULQwTBPVzOmd/bB9b6uoc
	zUog5jKJR0/TJZAy/xoJY+2TrDFLUdpD3DKTh+QJ4CIKY/Hg3AGdQnQSTrKGPEQdG7H66TyH4gK
	q42LRYkmKjeD7ZgQXRJ1fYQaQSqLhehi1q7el9sGHUWvrwT/1d+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.698500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 9363BDB1CBB7952FF72435AEDE0989D1A860F3E2E01C0BACAFCA187C3CADDD0C2000:8
X-MTK: N

For Gen1 isoc-in endpoint on controller before about SSUSB IPM v1.6.0, it
still send out unexpected ACK after receiving a short packet in burst
transfer, this will cause an exception on connected device, specially for
a 4k camera.
Add a quirk property "rx-fifo-depth" to work around this hardware issue,
prefer to use 3k bytes;
The side-effect is that may cause performance drop about 10%, including
bulk transfer.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v4: change rx-fifo size in bytes
v3: add fifo depth unit, change the value range from 0-3 to 1-4
v2: change 'mediatek,rxfifo-depth' to 'rx-fifo-depth'
---
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index e9644e333d78..9f621f2209df 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -124,6 +124,17 @@ properties:
       defined in the xHCI spec on MTK's controller.
     default: 5000
 
+  rx-fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      It is a quirk used to work around Gen1 isoc-in endpoint transfer issue
+      that still send out unexpected ACK after device finish the burst transfer
+      with a short packet and cause an exception, specially on a 4K camera
+      device, it happens on controller before about IPM v1.6.0; the side-effect
+      is that may cause performance drop about 10%, include bulk transfer,
+      prefer to use 3k here. The size is in bytes.
+    enum: [1024, 2048, 3072, 4096]
+
   # the following properties are only used for case 1
   wakeup-source:
     description: enable USB remote wakeup, see power/wakeup-source.txt
-- 
2.18.0


