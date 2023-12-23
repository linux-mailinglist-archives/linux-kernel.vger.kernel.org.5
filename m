Return-Path: <linux-kernel+bounces-10544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AD781D5FC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 19:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4378AB22A17
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 18:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA582837A;
	Sat, 23 Dec 2023 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="r24UaKmH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F7A225A6;
	Sat, 23 Dec 2023 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3a82dd08a1c111eea5db2bebc7c28f94-20231224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9Q8RSiyjSUfHILmoW4urj0AJtB2OmdXHTaWG7QUm9as=;
	b=r24UaKmH/FI/yIQky0l3ENlyXwCdAlVWFVRxAcU2CFEM6HPhL/NkoBDSrdO5hKb/R02Uxz3llbrDowVx7hdZEd1tQRz9jbjy+QBWFtlO2u4tWGXoF3o+Z55VjNf1Ioruchc4PanXjxC5hkc4U3qs0xmXga9tsQ/1A2YPUdlhhlU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:932576f9-4e5a-4c83-9471-840984a4b0bd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:ba5d7f8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3a82dd08a1c111eea5db2bebc7c28f94-20231224
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1170136593; Sun, 24 Dec 2023 02:29:37 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 24 Dec 2023 02:29:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 24 Dec 2023 02:29:35 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<dri-devel@lists.freedesktop.org>, <linux-media@vger.kernel.org>,
	<linaro-mm-sig@lists.linaro.org>, Jason-ch Chen <jason-ch.chen@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, "Nancy
 Lin" <nancy.lin@mediatek.com>, Shawn Sung <shawn.sung@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jeffrey Kardatzke
	<jkardatzke@google.com>
Subject: [PATCH v3 11/11] arm64: dts: mt8195: Add secure mbox settings for vdosys
Date: Sun, 24 Dec 2023 02:29:32 +0800
Message-ID: <20231223182932.27683-12-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231223182932.27683-1-jason-jh.lin@mediatek.com>
References: <20231223182932.27683-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.491300-8.000000
X-TMASE-MatchedRID: hnk2xlnUc9YCNMj/7qB/g11tpWYE7Ops31GU/N5W5BDOb3+o8TfeDuLz
	NWBegCW2wgn7iDBesS0nRE+fI6etkuizN9J3NgBH8RJ/GoffvHkPcq5zA38+/6zzbOcnWu8Z9mP
	29bcY/jAyNkLr5kiba29MNrHNAnxNgFAkt5cKyJCWOeeZGiKp5ICE5xpCtDRTUbJFyh4XXyqYo/
	TPOlMB4bCh3zE4wqa8DUCRr8oin+k=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.491300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	717D133535D00CDDC830E6143AA284E0754963BD2A23C955C3A4D68E41B2C6A02000:8
X-MTK: N

Add a secure mailbox channel to support secure video path on
vdosys0 and vdosys1.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index e0ac2e9f5b72..416d575be123 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -2621,7 +2621,8 @@
 		vdosys0: syscon@1c01a000 {
 			compatible = "mediatek,mt8195-vdosys0", "mediatek,mt8195-mmsys", "syscon";
 			reg = <0 0x1c01a000 0 0x1000>;
-			mboxes = <&gce0 0 CMDQ_THR_PRIO_4>;
+			mboxes = <&gce0 0 CMDQ_THR_PRIO_4>,
+				 <&gce0 8 CMDQ_THR_PRIO_4>; /* secure mbox */
 			#clock-cells = <1>;
 		};
 
@@ -2806,7 +2807,8 @@
 		vdosys1: syscon@1c100000 {
 			compatible = "mediatek,mt8195-vdosys1", "syscon";
 			reg = <0 0x1c100000 0 0x1000>;
-			mboxes = <&gce0 1 CMDQ_THR_PRIO_4>;
+			mboxes = <&gce0 1 CMDQ_THR_PRIO_4>,
+				 <&gce0 9 CMDQ_THR_PRIO_4>; /* secure mbox */;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0x0000 0x1000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
-- 
2.18.0


