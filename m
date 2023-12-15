Return-Path: <linux-kernel+bounces-525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9C1814276
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6744B284101
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3D510949;
	Fri, 15 Dec 2023 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IuNcTckm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A613D535;
	Fri, 15 Dec 2023 07:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 65d7f52a9b1c11eea5db2bebc7c28f94-20231215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+M5H9LZDjB4Gr0VbOYbLmnpUdU+OSS0M0aKqqzvm/n4=;
	b=IuNcTckm88kscxNXDpmu8lCTMrFbnRrnDpv8CvohOVo1WjhDO9zIsFqJSyrkeoJNat/ZTKzLeo3PGmjDo9IrFxKeVDsNEbIq9qJ8tK1MYdXvkrGva+RtcBAGsqo/QRBAqgPjNoThcie9vkQFhXrENZFCm0jfn9CtCA1OMv+/L+E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:48ef63f1-dc5d-4ff7-9e65-f0adc70ca935,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:8b1cd373-1bd3-4f48-b671-ada88705968c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 65d7f52a9b1c11eea5db2bebc7c28f94-20231215
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 686694639; Fri, 15 Dec 2023 15:34:36 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Dec 2023 15:34:35 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Dec 2023 15:34:34 +0800
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Chunfeng Yun <chunfeng.yun@mediatek.com>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, "Mathias
 Nyman" <mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Macpaul Lin
	<macpaul.lin@mediatek.com>, Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH v2 3/3] arm64: dts: mediatek: mt8195: Add 'rx-fifo-depth' for cherry
Date: Fri, 15 Dec 2023 15:34:31 +0800
Message-ID: <20231215073431.8512-3-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215073431.8512-1-chunfeng.yun@mediatek.com>
References: <20231215073431.8512-1-chunfeng.yun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-2.228900-8.000000
X-TMASE-MatchedRID: SmKlVN5gTYOLwgJA7qJvFEf49ONH0RaSGSqdEmeD/nUQVRHC3B6FYFfe
	kLFvP8UVQt2470g7vecqScZQsLRFpMBMY+N44zjMsyNb+yeIRApdbaVmBOzqbN9RlPzeVuQQvY7
	h2n/VF9/i8zVgXoAltsYlDcGKIsCCC24oEZ6SpSmb4wHqRpnaDltH4i4943sOplq7dpcYh22JNH
	vktzo2RZp/wp2NBZeVWvGJ+zF5IOKEPS7K8ncBJaIGIL3b97hRPiWqg5y7R3BU52lAwkS22fI2n
	uDg9d7QFezHPq6MHFSrV/xdKQcFSY0leYQxW8u2mJ2Ady5u17E=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-2.228900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 69A3CD59A0556046AF55792D357EF196CCC2DA0401934A0138F8CFA0D68014D32000:8
X-MTK: N

Add the quirk property "rx-fifo-depth" to work around Gen1 isoc-in
transfer issue which send out unexpected ACK even after device
already finished the burst transfer with a short patcket, specially
for a 4K camera device.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: use 'rx-fifo-depth' property
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index dd5b89b73190..132baeab675e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -1185,6 +1185,7 @@
 
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	vbus-supply = <&usb_vbus>;
+	rx-fifo-depth = <2>;
 };
 
 &xhci1 {
@@ -1192,6 +1193,7 @@
 
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	vbus-supply = <&usb_vbus>;
+	rx-fifo-depth = <2>;
 };
 
 &xhci2 {
-- 
2.18.0


