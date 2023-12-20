Return-Path: <linux-kernel+bounces-6305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844D38196FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24F7AB210F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79996C2D8;
	Wed, 20 Dec 2023 02:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ynb0LHKc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDABC8813;
	Wed, 20 Dec 2023 02:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b22afad89ee311eeba30773df0976c77-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gPP+fjrilrhAMP+i+QG0Lq7aDVFhTO7O157PxOkEVns=;
	b=Ynb0LHKcGtrjwSmrumhJm1XdN2iVnH31F9gAlvsKZOsUDaOG9RQihvw5FuGaApuzCUri1cykrR2g5rZ50+DPVe+xrlO531X9GwJ8wCcCkvjSabZ0oCeWxVDMPsSbiHTFIYSoUymujn9hYV5Box9thW1dzldALFC5mdEftEJwdgM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:5a9439a7-ed8e-4153-b482-3bc7d0b00079,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:915be117-1474-414b-9c9f-6d23a122e796,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b22afad89ee311eeba30773df0976c77-20231220
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 617115450; Wed, 20 Dec 2023 10:58:47 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Dec 2023 10:58:46 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Dec 2023 10:58:45 +0800
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
Subject: [PATCH v3 3/3] arm64: dts: mediatek: mt8195: Add 'rx-fifo-depth' for cherry
Date: Wed, 20 Dec 2023 10:58:42 +0800
Message-ID: <20231220025842.7082-3-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231220025842.7082-1-chunfeng.yun@mediatek.com>
References: <20231220025842.7082-1-chunfeng.yun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-1.858000-8.000000
X-TMASE-MatchedRID: SmKlVN5gTYOLwgJA7qJvFEf49ONH0RaSGSqdEmeD/nUQVRHC3B6FYFfe
	kLFvP8UVQt2470g7vecqScZQsLRFpMBMY+N44zjMwCZxkTHxcclQCOsAlaxN70C0ozeEMMB8gK6
	qCGa1Z9f+L7hkgxmjCYAy6p60ZV62fJ5/bZ6npdiujVRFkkVsm1M3J2vm0mJ+yiHX4eBbTmTLpk
	uFSwPGnqV24iXBtxcDn3OZvch5THViXwsLBqINMwd+1FkBk2L+Hkqld9LmJfhrhj/zqKQQB21Rj
	oup2VCcWve+eVz4Pp5Vk5utmQ1VlGVF3+d9rnox6EMj9/eK3+Y=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-1.858000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	0892C9BC451D3DB96D076D71859C99E1D706F4D7315969C0460307EB121A3B6F2000:8
X-MTK: N

Add the quirk property "rx-fifo-depth" to work around Gen1 isoc-in
transfer issue which send out unexpected ACK even after device
already finished the burst transfer with a short patcket, specially
for a 4K camera device.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3: change value according to binding
v2: use 'rx-fifo-depth' property
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index dd5b89b73190..58593348b810 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -1185,6 +1185,7 @@
 
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	vbus-supply = <&usb_vbus>;
+	rx-fifo-depth = <3>;
 };
 
 &xhci1 {
@@ -1192,6 +1193,7 @@
 
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	vbus-supply = <&usb_vbus>;
+	rx-fifo-depth = <3>;
 };
 
 &xhci2 {
-- 
2.18.0


