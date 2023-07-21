Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAE975BC84
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 04:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjGUCm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 22:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGUCmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 22:42:06 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D198F271F;
        Thu, 20 Jul 2023 19:42:00 -0700 (PDT)
X-UUID: 263e72a6277011eeb20a276fd37b9834-20230721
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=EgTVB8/wFgscxLDYs3qg9WMPyo6Fp8L2xH8FV1ZxS8Y=;
        b=stjO2kSrlH5yN7ghQSghcvkMnkGFjclZjPYwLU/f8UIjnKrlf4QzFPBYzt3oOaw+Uf6G7w/jAyQcKlnYRbXflIA0VLQO4INSBpsCqWAMuhkT4/I4xb54gHWu83KLo/x0jju8VRvp5ToVz66BsvEHrNUHP1FRvtNbGSgAv2WE1pQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:7e78c1bd-4272-481d-9215-3d85c954fb5a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:7b8df44c-06c1-468b-847d-5b62d44dbb9b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 263e72a6277011eeb20a276fd37b9834-20230721
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2134735775; Fri, 21 Jul 2023 10:41:52 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 21 Jul 2023 10:41:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 21 Jul 2023 10:41:51 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v15 13/13] arm64: dts: mediatek: mt8195: Add SCP 2nd core
Date:   Fri, 21 Jul 2023 10:41:32 +0800
Message-ID: <20230721024132.6548-14-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230721024132.6548-1-tinghan.shen@mediatek.com>
References: <20230721024132.6548-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite the MT8195 SCP device node as a cluster and
add the SCP 2nd core in it.

Since the SCP device node is changed to multi-core structure,
enable SCP cluster to enable probing SCP core 0.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      |  6 +++-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 34 ++++++++++++++-----
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 37a3e9de90ff..4584077d3a4c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -991,7 +991,11 @@
 	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
 };
 
-&scp {
+&scp_cluster {
+	status = "okay";
+};
+
+&scp_c0 {
 	status = "okay";
 
 	firmware-name = "mediatek/mt8195/scp.img";
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 48b72b3645e1..7809118f74fb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -922,14 +922,30 @@
 			clocks = <&infracfg_ao CLK_INFRA_AO_GCE2>;
 		};
 
-		scp: scp@10500000 {
-			compatible = "mediatek,mt8195-scp";
-			reg = <0 0x10500000 0 0x100000>,
-			      <0 0x10720000 0 0xe0000>,
-			      <0 0x10700000 0 0x8000>;
-			reg-names = "sram", "cfg", "l1tcm";
-			interrupts = <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH 0>;
+		scp_cluster: scp@10500000 {
+			compatible = "mediatek,mt8195-scp-dual";
+			reg = <0 0x10720000 0 0xe0000>, <0 0x10700000 0 0x8000>;
+			reg-names = "cfg", "l1tcm";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x10500000 0x100000>;
 			status = "disabled";
+
+			scp_c0: scp@0 {
+				compatible = "mediatek,scp-core";
+				reg = <0x0 0xa0000>;
+				reg-names = "sram";
+				interrupts = <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH 0>;
+				status = "disabled";
+			};
+
+			scp_c1: scp@a0000 {
+				compatible = "mediatek,scp-core";
+				reg = <0xa0000 0x20000>;
+				reg-names = "sram";
+				interrupts = <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH 0>;
+				status = "disabled";
+			};
 		};
 
 		scp_adsp: clock-controller@10720000 {
@@ -2374,7 +2390,7 @@
 
 		video-codec@18000000 {
 			compatible = "mediatek,mt8195-vcodec-dec";
-			mediatek,scp = <&scp>;
+			mediatek,scp = <&scp_c0>;
 			iommus = <&iommu_vdo M4U_PORT_L21_VDEC_MC_EXT>;
 			#address-cells = <2>;
 			#size-cells = <2>;
@@ -2540,7 +2556,7 @@
 				 <&iommu_vdo M4U_PORT_L19_VENC_REF_LUMA>,
 				 <&iommu_vdo M4U_PORT_L19_VENC_REF_CHROMA>;
 			interrupts = <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH 0>;
-			mediatek,scp = <&scp>;
+			mediatek,scp = <&scp_c0>;
 			clocks = <&vencsys CLK_VENC_VENC>;
 			clock-names = "venc_sel";
 			assigned-clocks = <&topckgen CLK_TOP_VENC>;
-- 
2.18.0

