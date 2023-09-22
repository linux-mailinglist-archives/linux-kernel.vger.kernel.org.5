Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352297AA94E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjIVGuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjIVGuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:50:35 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76793114;
        Thu, 21 Sep 2023 23:50:25 -0700 (PDT)
X-UUID: 4bd37b76591411eea33bb35ae8d461a2-20230922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1YUv6D009i++A1133uaR6ICMHxvugqXrRPp2ZoSgGGw=;
        b=RvcfTl153pqvNiLmJ31Idk/LtFjK8EPQzikxX8hNIepeIwtcLjtaseGOSbzXLZCFKvY45R4PVd5hUXNYTmP7wunZdg/C8D7l01HDZiYSXk7zULWZDc0rcJiSBPuycRyu4U3dd7ItUk8juvuJ35zltZi+UHjwlGKGdMBqipDKCCE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:e901ca41-a84c-4eac-99eb-219c391aac04,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:fd2a00f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4bd37b76591411eea33bb35ae8d461a2-20230922
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 534965272; Fri, 22 Sep 2023 14:50:20 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Sep 2023 14:50:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Sep 2023 14:50:18 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v6 2/2] arm64: dts: mediatek: mt8195: add MDP3 nodes
Date:   Fri, 22 Sep 2023 14:50:17 +0800
Message-ID: <20230922065017.10357-3-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230922065017.10357-1-moudy.ho@mediatek.com>
References: <20230922065017.10357-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.986800-8.000000
X-TMASE-MatchedRID: k8Cd32tj8sGuhCBFl/b63kfhraIl1XgxkUtSee+57IFAtKM3hDDAfGb6
        PphVtfZgTPeZkapFnH8kAzbREWz9my2w9y+uUSpWCz1WR8KHe4B3Bf9JIqsoeKkp8F/qKdS/o8W
        MkQWv6iXBcIE78YqRWo6HM5rqDwqtjj4YbMVy5eTpc/bTWgP1PgI0JuAvZeXuFJT7e5MiFS67sH
        9dSDhp1w==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.986800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 30AC287EC04FD40ACA1105414F4A6B61C208B07CAB8000E43BE3DD52D45AFA272000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device nodes for Media Data Path 3 (MDP3) modules.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 388 +++++++++++++++++++++++
 1 file changed, 388 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 4dbbf8fdab75..cf61ba7b8956 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1960,6 +1960,114 @@
 			#clock-cells = <1>;
 		};
 
+		dma-controller@14001000 {
+			compatible = "mediatek,mt8195-mdp3-rdma";
+			reg = <0 0x14001000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x1000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VPP0_MDP_RDMA_SOF>,
+					      <CMDQ_EVENT_VPP0_MDP_RDMA_FRAME_DONE>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+			iommus = <&iommu_vpp M4U_PORT_L4_MDP_RDMA>;
+			clocks = <&vppsys0 CLK_VPP0_MDP_RDMA>;
+			mboxes = <&gce1 12 CMDQ_THR_PRIO_1>,
+				 <&gce1 13 CMDQ_THR_PRIO_1>,
+				 <&gce1 14 CMDQ_THR_PRIO_1>,
+				 <&gce1 21 CMDQ_THR_PRIO_1>,
+				 <&gce1 22 CMDQ_THR_PRIO_1>;
+			#dma-cells = <1>;
+		};
+
+		display@14002000 {
+			compatible = "mediatek,mt8195-mdp3-fg";
+			reg = <0 0x14002000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x2000 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_MDP_FG>;
+		};
+
+		display@14003000 {
+			compatible = "mediatek,mt8195-mdp3-stitch";
+			reg = <0 0x14003000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x3000 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_STITCH>;
+		};
+
+		display@14004000 {
+			compatible = "mediatek,mt8195-mdp3-hdr";
+			reg = <0 0x14004000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x4000 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_MDP_HDR>;
+		};
+
+		display@14005000 {
+			compatible = "mediatek,mt8195-mdp3-aal";
+			reg = <0 0x14005000 0 0x1000>;
+			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x5000 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_MDP_AAL>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
+		display@14006000 {
+			compatible = "mediatek,mt8183-mdp3-rsz";
+			reg = <0 0x14006000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x6000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VPP0_MDP_RSZ_IN_RSZ_SOF>,
+					      <CMDQ_EVENT_VPP0_MDP_RSZ_FRAME_DONE>;
+			clocks = <&vppsys0 CLK_VPP0_MDP_RSZ>;
+		};
+
+		display@14007000 {
+			compatible = "mediatek,mt8195-mdp3-tdshp";
+			reg = <0 0x14007000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x7000 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_MDP_TDSHP>;
+		};
+
+		display@14008000 {
+			compatible = "mediatek,mt8195-mdp3-color";
+			reg = <0 0x14008000 0 0x1000>;
+			interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x8000 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_MDP_COLOR>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
+		display@14009000 {
+			compatible = "mediatek,mt8195-mdp3-ovl";
+			reg = <0 0x14009000 0 0x1000>;
+			interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x9000 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_MDP_OVL>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+			iommus = <&iommu_vpp M4U_PORT_L4_MDP_OVL>;
+		};
+
+		display@1400a000 {
+			compatible = "mediatek,mt8195-mdp3-pad";
+			reg = <0 0x1400a000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0xa000 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_PADDING>;
+		};
+
+		display@1400b000 {
+			compatible = "mediatek,mt8195-mdp3-tcc";
+			reg = <0 0x1400b000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0xb000 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_MDP_TCC>;
+		};
+
+		dma-controller@1400c000 {
+			compatible = "mediatek,mt8183-mdp3-wrot";
+			reg = <0 0x1400c000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0xc000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VPP0_MDP_WROT_SOF>,
+					      <CMDQ_EVENT_VPP0_MDP_WROT_VIDO_WDONE>;
+			clocks = <&vppsys0 CLK_VPP0_MDP_WROT>;
+			iommus = <&iommu_vpp M4U_PORT_L4_MDP_WROT>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+			#dma-cells = <1>;
+		};
+
 		mutex@1400f000 {
 			compatible = "mediatek,mt8195-vpp-mutex";
 			reg = <0 0x1400f000 0 0x1000>;
@@ -2107,6 +2215,286 @@
 			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
 		};
 
+		display@14f06000 {
+			compatible = "mediatek,mt8195-mdp3-split";
+			reg = <0 0x14f06000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0x6000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_VPP_SPLIT>,
+				 <&vppsys1 CLK_VPP1_HDMI_META>,
+				 <&vppsys1 CLK_VPP1_VPP_SPLIT_HDMI>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f07000 {
+			compatible = "mediatek,mt8195-mdp3-tcc";
+			reg = <0 0x14f07000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0x7000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_TCC>;
+		};
+
+		dma-controller@14f08000 {
+			compatible = "mediatek,mt8195-mdp3-rdma";
+			reg = <0 0x14f08000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0x8000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP1_MDP_RDMA_SOF>,
+					      <CMDQ_EVENT_VPP1_SVPP1_MDP_RDMA_FRAME_DONE>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_RDMA>;
+			iommus = <&iommu_vdo M4U_PORT_L5_SVPP1_MDP_RDMA>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+			#dma-cells = <1>;
+		};
+
+		dma-controller@14f09000 {
+			compatible = "mediatek,mt8195-mdp3-rdma";
+			reg = <0 0x14f09000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0x9000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP2_MDP_RDMA_SOF>,
+					      <CMDQ_EVENT_VPP1_SVPP2_MDP_RDMA_FRAME_DONE>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_RDMA>;
+			iommus = <&iommu_vdo M4U_PORT_L5_SVPP2_MDP_RDMA>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+			#dma-cells = <1>;
+		};
+
+		dma-controller@14f0a000 {
+			compatible = "mediatek,mt8195-mdp3-rdma";
+			reg = <0 0x14f0a000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0xa000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP3_MDP_RDMA_SOF>,
+					      <CMDQ_EVENT_VPP1_SVPP3_MDP_RDMA_FRAME_DONE>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_RDMA>;
+			iommus = <&iommu_vpp M4U_PORT_L6_SVPP3_MDP_RDMA>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+			#dma-cells = <1>;
+		};
+
+		display@14f0b000 {
+			compatible = "mediatek,mt8195-mdp3-fg";
+			reg = <0 0x14f0b000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0xb000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_FG>;
+		};
+
+		display@14f0c000 {
+			compatible = "mediatek,mt8195-mdp3-fg";
+			reg = <0 0x14f0c000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0xc000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_FG>;
+		};
+
+		display@14f0d000 {
+			compatible = "mediatek,mt8195-mdp3-fg";
+			reg = <0 0x14f0d000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0xd000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_FG>;
+		};
+
+		display@14f0e000 {
+			compatible = "mediatek,mt8195-mdp3-hdr";
+			reg = <0 0x14f0e000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0xe000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_HDR>;
+		};
+
+		display@14f0f000 {
+			compatible = "mediatek,mt8195-mdp3-hdr";
+			reg = <0 0x14f0f000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0xf000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_HDR>;
+		};
+
+		display@14f10000 {
+			compatible = "mediatek,mt8195-mdp3-hdr";
+			reg = <0 0x14f10000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_HDR>;
+		};
+
+		display@14f11000 {
+			compatible = "mediatek,mt8195-mdp3-aal";
+			reg = <0 0x14f11000 0 0x1000>;
+			interrupts = <GIC_SPI 617 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x1000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_AAL>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f12000 {
+			compatible = "mediatek,mt8195-mdp3-aal";
+			reg = <0 0x14f12000 0 0x1000>;
+			interrupts = <GIC_SPI 618 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x2000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_AAL>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f13000 {
+			compatible = "mediatek,mt8195-mdp3-aal";
+			reg = <0 0x14f13000 0 0x1000>;
+			interrupts = <GIC_SPI 619 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x3000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_AAL>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f14000 {
+			compatible = "mediatek,mt8183-mdp3-rsz";
+			reg = <0 0x14f14000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x4000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP1_MDP_RSZ_SOF>,
+					      <CMDQ_EVENT_VPP1_SVPP1_MDP_RSZ_FRAME_DONE>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_RSZ>;
+		};
+
+		display@14f15000 {
+			compatible = "mediatek,mt8183-mdp3-rsz";
+			reg = <0 0x14f15000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x5000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP2_MDP_RSZ_SOF>,
+					      <CMDQ_EVENT_VPP1_SVPP2_MDP_RSZ_FRAME_DONE>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_RSZ>;
+		};
+
+		display@14f16000 {
+			compatible = "mediatek,mt8183-mdp3-rsz";
+			reg = <0 0x14f16000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x6000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP3_MDP_RSZ_SOF>,
+					      <CMDQ_EVENT_VPP1_SVPP3_MDP_RSZ_FRAME_DONE>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_RSZ>;
+		};
+
+		display@14f17000 {
+			compatible = "mediatek,mt8195-mdp3-tdshp";
+			reg = <0 0x14f17000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x7000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_TDSHP>;
+		};
+
+		display@14f18000 {
+			compatible = "mediatek,mt8195-mdp3-tdshp";
+			reg = <0 0x14f18000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x8000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_TDSHP>;
+		};
+
+		display@14f19000 {
+			compatible = "mediatek,mt8195-mdp3-tdshp";
+			reg = <0 0x14f19000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x9000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_TDSHP>;
+		};
+
+		display@14f1a000 {
+			compatible = "mediatek,mt8195-mdp3-merge";
+			reg = <0 0x14f1a000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0xa000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP2_VPP_MERGE>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f1b000 {
+			compatible = "mediatek,mt8195-mdp3-merge";
+			reg = <0 0x14f1b000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0xb000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP3_VPP_MERGE>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f1c000 {
+			compatible = "mediatek,mt8195-mdp3-color";
+			reg = <0 0x14f1c000 0 0x1000>;
+			interrupts = <GIC_SPI 628 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0xc000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_COLOR>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f1d000 {
+			compatible = "mediatek,mt8195-mdp3-color";
+			reg = <0 0x14f1d000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0xd000 0x1000>;
+			interrupts = <GIC_SPI 629 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_COLOR>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f1e000 {
+			compatible = "mediatek,mt8195-mdp3-color";
+			reg = <0 0x14f1e000 0 0x1000>;
+			interrupts = <GIC_SPI 630 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0xe000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_COLOR>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f1f000 {
+			compatible = "mediatek,mt8195-mdp3-ovl";
+			reg = <0 0x14f1f000 0 0x1000>;
+			interrupts = <GIC_SPI 631 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0xf000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_OVL>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+			iommus = <&iommu_vdo M4U_PORT_L5_SVPP1_MDP_OVL>;
+		};
+
+		display@14f20000 {
+			compatible = "mediatek,mt8195-mdp3-pad";
+			reg = <0 0x14f20000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f2XXXX 0 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_VPP_PAD>;
+		};
+
+		display@14f21000 {
+			compatible = "mediatek,mt8195-mdp3-pad";
+			reg = <0 0x14f21000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f2XXXX 0x1000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP2_VPP_PAD>;
+		};
+
+		display@14f22000 {
+			compatible = "mediatek,mt8195-mdp3-pad";
+			reg = <0 0x14f22000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f2XXXX 0x2000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP3_VPP_PAD>;
+		};
+
+		dma-controller@14f23000 {
+			compatible = "mediatek,mt8183-mdp3-wrot";
+			reg = <0 0x14f23000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f2XXXX 0x3000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP1_MDP_WROT_SOF>,
+					      <CMDQ_EVENT_VPP1_SVPP1_MDP_WROT_FRAME_DONE>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_WROT>;
+			iommus = <&iommu_vdo M4U_PORT_L5_SVPP1_MDP_WROT>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+			#dma-cells = <1>;
+		};
+
+		dma-controller@14f24000 {
+			compatible = "mediatek,mt8183-mdp3-wrot";
+			reg = <0 0x14f24000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f2XXXX 0x4000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP2_MDP_WROT_SOF>,
+					<CMDQ_EVENT_VPP1_SVPP2_MDP_WROT_FRAME_DONE>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_WROT>;
+			iommus = <&iommu_vdo M4U_PORT_L5_SVPP2_MDP_WROT>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+			#dma-cells = <1>;
+		};
+
+		dma-controller@14f25000 {
+			compatible = "mediatek,mt8183-mdp3-wrot";
+			reg = <0 0x14f25000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f2XXXX 0x5000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP3_MDP_WROT_SOF>,
+					<CMDQ_EVENT_VPP1_SVPP3_MDP_WROT_FRAME_DONE>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_WROT>;
+			iommus = <&iommu_vpp M4U_PORT_L6_SVPP3_MDP_WROT>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+			#dma-cells = <1>;
+		};
+
 		imgsys: clock-controller@15000000 {
 			compatible = "mediatek,mt8195-imgsys";
 			reg = <0 0x15000000 0 0x1000>;
-- 
2.18.0

