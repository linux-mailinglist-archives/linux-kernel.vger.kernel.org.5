Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17A57C4C4C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjJKHup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjJKHuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:50:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5AF92;
        Wed, 11 Oct 2023 00:50:39 -0700 (PDT)
X-UUID: db7142e0680a11eea33bb35ae8d461a2-20231011
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=P5JM1/wrQBmccE0zOhCn8sdA72w5RjiESxn0FFMljNE=;
        b=szkl1O1E5GdvTxP89TQeQBN2r6JtwHXpboupFa7pvf7qkztJ17DDAtaOrPNfpb7eZh17z5AetdeeEbAR04xlh50xtM+43LEGP4bAGnWYqbykpqVZX631mS56TBbh7OgXv7shj97+9261aDCEkenztwdu3LDe1gDXhntXOwd4AKM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:6dc7a16f-f6e1-4920-84c6-243c49189e1c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:73cce614-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: db7142e0680a11eea33bb35ae8d461a2-20231011
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 260589970; Wed, 11 Oct 2023 15:50:33 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 11 Oct 2023 15:50:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 11 Oct 2023 15:50:32 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     "Nancy . Lin" <nancy.lin@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v7 1/3] arm64: dts: mediatek: mt8183: correct MDP3 DMA-related nodes
Date:   Wed, 11 Oct 2023 15:50:29 +0800
Message-ID: <20231011075031.30660-2-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231011075031.30660-1-moudy.ho@mediatek.com>
References: <20231011075031.30660-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to generalize the node names, the DMA-related nodes
corresponding to MT8183 MDP3 need to be corrected.

Fixes: 60a2fb8d202a ("arm64: dts: mt8183: add MediaTek MDP3 nodes")
Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 5169779d01df..bab68c233792 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1781,7 +1781,7 @@
 			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
 		};
 
-		mdp3-rdma0@14001000 {
+		dma-controller0@14001000 {
 			compatible = "mediatek,mt8183-mdp3-rdma";
 			reg = <0 0x14001000 0 0x1000>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x1000 0x1000>;
@@ -1793,6 +1793,7 @@
 			iommus = <&iommu M4U_PORT_MDP_RDMA0>;
 			mboxes = <&gce 20 CMDQ_THR_PRIO_LOWEST 0>,
 				 <&gce 21 CMDQ_THR_PRIO_LOWEST 0>;
+			#dma-cells = <1>;
 		};
 
 		mdp3-rsz0@14003000 {
@@ -1813,7 +1814,7 @@
 			clocks = <&mmsys CLK_MM_MDP_RSZ1>;
 		};
 
-		mdp3-wrot0@14005000 {
+		dma-controller@14005000 {
 			compatible = "mediatek,mt8183-mdp3-wrot";
 			reg = <0 0x14005000 0 0x1000>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
@@ -1822,6 +1823,7 @@
 			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
 			clocks = <&mmsys CLK_MM_MDP_WROT0>;
 			iommus = <&iommu M4U_PORT_MDP_WROT0>;
+			#dma-cells = <1>;
 		};
 
 		mdp3-wdma@14006000 {
-- 
2.18.0

