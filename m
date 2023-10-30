Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD42F7DB6AE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjJ3Ju3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjJ3Jtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:49:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A01C119;
        Mon, 30 Oct 2023 02:48:46 -0700 (PDT)
X-UUID: 82cf5bb4770911ee8051498923ad61e6-20231030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DcsRahRXlpgXJNgFDiJDmFyqzwhSpa3T2aMPFIBbnvQ=;
        b=OJNb//KkYpLLMgOqVMgvTwcdj3TDbLMqS4qauvBuYGTgvbVHGeQcd8m1RHixskG4MjruoK59MZzkKA+GzYgJvlWNE2OOhGxDQEV+PY3rJzdoBegv0I6DlxLACq8dyUm4EFErWz0FuK9Meen3zClLxzx/6Vj7elDHfSmPbfuRrww=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:bbbdf514-6c53-4673-87f4-16d1ed0dda7b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:fbf97ad7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 82cf5bb4770911ee8051498923ad61e6-20231030
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 775224783; Mon, 30 Oct 2023 17:48:42 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 30 Oct 2023 17:48:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 30 Oct 2023 17:48:41 +0800
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
Subject: [PATCH v8 2/3] arm64: dts: mediatek: mt8195: revise VDOSYS RDMA node name
Date:   Mon, 30 Oct 2023 17:48:39 +0800
Message-ID: <20231030094840.2479-3-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231030094840.2479-1-moudy.ho@mediatek.com>
References: <20231030094840.2479-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.418000-8.000000
X-TMASE-MatchedRID: clk929UbYNd+dq81W9lAv1Pjo7D4SFg44qmzKarUU9tcKZwALwMGs0fp
        kQx2u0Ks2nmqyvuSOj3ijpjet3oGSMJjog0sYBeSngIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPIcSq
        bxBgG0w5aWRzvlJwrtOoMugaMWeXJnbHQMTrpnW93gHs+OTnVBl+LOjqtKatlX2XeLMvAdPGxNU
        AjaY1ZB1Ep3ZS6j/Vay2k41Y+AjdJ5lSmbrC6fdtr/To2FgNrjDLMIOOVTHz12N6Rg5qIpOg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.418000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 5C1E6A8869D7A021C208376EBD2BC03DAE0706E2A4C322BD92141702C94630E02000:8
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA-related nodes have their own standardized naming. Therefore,
the MT8195 VDOSYS RDMA has been unified and corrected.
Additionally, these modifications will facilitate the further
integration of bindings.

Fixes: 92d2c23dc269 ("arm64: dts: mt8195: add display node for vdosys1")
Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 54c674c45b49..a360fb785bb6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -2869,7 +2869,7 @@
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
 		};
 
-		vdo1_rdma0: rdma@1c104000 {
+		vdo1_rdma0: dma-controller@1c104000 {
 			compatible = "mediatek,mt8195-vdo1-rdma";
 			reg = <0 0x1c104000 0 0x1000>;
 			interrupts = <GIC_SPI 495 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -2877,9 +2877,10 @@
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
 			iommus = <&iommu_vdo M4U_PORT_L2_MDP_RDMA0>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0x4000 0x1000>;
+			#dma-cells = <1>;
 		};
 
-		vdo1_rdma1: rdma@1c105000 {
+		vdo1_rdma1: dma-controller@1c105000 {
 			compatible = "mediatek,mt8195-vdo1-rdma";
 			reg = <0 0x1c105000 0 0x1000>;
 			interrupts = <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -2887,9 +2888,10 @@
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
 			iommus = <&iommu_vpp M4U_PORT_L3_MDP_RDMA1>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0x5000 0x1000>;
+			#dma-cells = <1>;
 		};
 
-		vdo1_rdma2: rdma@1c106000 {
+		vdo1_rdma2: dma-controller@1c106000 {
 			compatible = "mediatek,mt8195-vdo1-rdma";
 			reg = <0 0x1c106000 0 0x1000>;
 			interrupts = <GIC_SPI 497 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -2897,9 +2899,10 @@
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
 			iommus = <&iommu_vdo M4U_PORT_L2_MDP_RDMA2>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0x6000 0x1000>;
+			#dma-cells = <1>;
 		};
 
-		vdo1_rdma3: rdma@1c107000 {
+		vdo1_rdma3: dma-controller@1c107000 {
 			compatible = "mediatek,mt8195-vdo1-rdma";
 			reg = <0 0x1c107000 0 0x1000>;
 			interrupts = <GIC_SPI 498 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -2907,9 +2910,10 @@
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
 			iommus = <&iommu_vpp M4U_PORT_L3_MDP_RDMA3>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0x7000 0x1000>;
+			#dma-cells = <1>;
 		};
 
-		vdo1_rdma4: rdma@1c108000 {
+		vdo1_rdma4: dma-controller@1c108000 {
 			compatible = "mediatek,mt8195-vdo1-rdma";
 			reg = <0 0x1c108000 0 0x1000>;
 			interrupts = <GIC_SPI 499 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -2917,9 +2921,10 @@
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
 			iommus = <&iommu_vdo M4U_PORT_L2_MDP_RDMA4>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0x8000 0x1000>;
+			#dma-cells = <1>;
 		};
 
-		vdo1_rdma5: rdma@1c109000 {
+		vdo1_rdma5: dma-controller@1c109000 {
 			compatible = "mediatek,mt8195-vdo1-rdma";
 			reg = <0 0x1c109000 0 0x1000>;
 			interrupts = <GIC_SPI 500 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -2927,9 +2932,10 @@
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
 			iommus = <&iommu_vpp M4U_PORT_L3_MDP_RDMA5>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0x9000 0x1000>;
+			#dma-cells = <1>;
 		};
 
-		vdo1_rdma6: rdma@1c10a000 {
+		vdo1_rdma6: dma-controller@1c10a000 {
 			compatible = "mediatek,mt8195-vdo1-rdma";
 			reg = <0 0x1c10a000 0 0x1000>;
 			interrupts = <GIC_SPI 501 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -2937,9 +2943,10 @@
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
 			iommus = <&iommu_vdo M4U_PORT_L2_MDP_RDMA6>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0xa000 0x1000>;
+			#dma-cells = <1>;
 		};
 
-		vdo1_rdma7: rdma@1c10b000 {
+		vdo1_rdma7: dma-controller@1c10b000 {
 			compatible = "mediatek,mt8195-vdo1-rdma";
 			reg = <0 0x1c10b000 0 0x1000>;
 			interrupts = <GIC_SPI 502 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -2947,6 +2954,7 @@
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
 			iommus = <&iommu_vpp M4U_PORT_L3_MDP_RDMA7>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0xb000 0x1000>;
+			#dma-cells = <1>;
 		};
 
 		merge1: vpp-merge@1c10c000 {
-- 
2.18.0

