Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33877757A58
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjGRLWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjGRLWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:22:22 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E1B1732;
        Tue, 18 Jul 2023 04:22:10 -0700 (PDT)
X-UUID: 51c7ed4a255d11eeb20a276fd37b9834-20230718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LYVZcFdOa+vLBdw8dXkdvjjipS5D4yC942iy/7t6M80=;
        b=Q/9uJBuu7iMeMrHKhSdaHwf8Z1h98t8TxCIKEZpPJYVNQwfDh9VRI0hJ4rRLOLOVqpOwUFBY7AyLbAv0bwrq5QwCOBbd+vAtccxSm1bi6T9I9x8p+Q3mxRV59Dx2YJR6k6Jov333hLr8fZt76mN2biA9RD539W8CEkQlEiLcgG0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:71184003-3c33-45e2-a27f-80a322cb2c76,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.28,REQID:71184003-3c33-45e2-a27f-80a322cb2c76,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:176cd25,CLOUDID:6504d84c-06c1-468b-847d-5b62d44dbb9b,B
        ulkID:2307181922058XW8AZY6,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,
        TF_CID_SPAM_SDM
X-UUID: 51c7ed4a255d11eeb20a276fd37b9834-20230718
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <william-tw.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 856485582; Tue, 18 Jul 2023 19:22:02 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 18 Jul 2023 19:21:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 18 Jul 2023 19:21:54 +0800
From:   William-tw Lin <william-tw.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@kernel.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        William-tw Lin <william-tw.lin@mediatek.com>
Subject: [PATCH 3/3] arm64: dts: Add node for chip info driver
Date:   Tue, 18 Jul 2023 19:21:43 +0800
Message-ID: <20230718112143.14036-4-william-tw.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230718112143.14036-1-william-tw.lin@mediatek.com>
References: <20230718112143.14036-1-william-tw.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dts node for socinfo retrieval. This includes the following projects:
MT8173
MT8183
MT8186
MT8192
MT8195

Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 15 +++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 15 +++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 10 ++++++++++
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi |  9 +++++++++
 5 files changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index c47d7d900f28..115f907751c1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -590,11 +590,26 @@
 			reg = <0 0x10206000 0 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			socinfo_data1: socinfo-data1 {
+				reg = <0x040 0x4>;
+			};
+
+			socinfo_data2: socinfo-data2 {
+				reg = <0x044 0x4>;
+			};
+
 			thermal_calibration: calib@528 {
 				reg = <0x528 0xc>;
 			};
 		};
 
+		mtk_socinfo: mtk-socinfo {
+			compatible = "mediatek,mt8173-socinfo";
+			nvmem-cells = <&socinfo_data1 &socinfo_data2>;
+			nvmem-cell-names = "socinfo-data1", "socinfo-data2";
+		};
+
 		apmixedsys: clock-controller@10209000 {
 			compatible = "mediatek,mt8173-apmixedsys";
 			reg = <0 0x10209000 0 0x1000>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 5169779d01df..1035c6d7eb91 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1706,6 +1706,15 @@
 			reg = <0 0x11f10000 0 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			socinfo_data1: socinfo-data1 {
+				reg = <0x04C 0x4>;
+			};
+
+			socinfo_data2: socinfo-data2 {
+				reg = <0x060 0x4>;
+			};
+
 			thermal_calibration: calib@180 {
 				reg = <0x180 0xc>;
 			};
@@ -1719,6 +1728,12 @@
 			};
 		};
 
+		mtk_socinfo: mtk-socinfo {
+			compatible = "mediatek,mt8183-socinfo";
+			nvmem-cells = <&socinfo_data1 &socinfo_data2>;
+			nvmem-cell-names = "socinfo-data1", "socinfo-data2";
+		};
+
 		u3phy: t-phy@11f40000 {
 			compatible = "mediatek,mt8183-tphy",
 				     "mediatek,generic-tphy-v2";
diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index f04ae70c470a..e048e4d994e9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -1660,6 +1660,16 @@
 				reg = <0x59c 0x4>;
 				bits = <0 3>;
 			};
+
+			socinfo_data1: socinfo-data1 {
+				reg = <0x7a0 0x4>;
+			};
+		};
+
+		mtk_socinfo: socinfo {
+			compatible = "mediatek,mt8186-socinfo";
+			nvmem-cells = <&socinfo_data1>;
+			nvmem-cell-names = "socinfo-data1";
 		};
 
 		mipi_tx0: dsi-phy@11cc0000 {
diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 5e94cb4aeb44..80066faf2b2c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -1122,6 +1122,14 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			socinfo_data1: socinfo-data1 {
+				reg = <0x044 0x4>;
+			};
+
+			socinfo_data2: socinfo-data2 {
+				reg = <0x050 0x4>;
+			};
+
 			lvts_e_data1: data1@1c0 {
 				reg = <0x1c0 0x58>;
 			};
@@ -1131,6 +1139,12 @@
 			};
 		};
 
+		mtk_socinfo: mtk-socinfo {
+			compatible = "mediatek,mt8192-socinfo";
+			nvmem-cells = <&socinfo_data1 &socinfo_data2>;
+			nvmem-cell-names = "socinfo-data1", "socinfo-data2";
+		};
+
 		i2c3: i2c@11cb0000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11cb0000 0 0x1000>,
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 48b72b3645e1..ec8f2c8888cb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1683,6 +1683,15 @@
 			lvts_efuse_data2: lvts2-calib@1d0 {
 				reg = <0x1d0 0x38>;
 			};
+			socinfo_data1: socinfo-data1 {
+				reg = <0x7a0 0x4>;
+			};
+		};
+
+		mtk_socinfo: socinfo {
+			compatible = "mediatek,mt8195-socinfo";
+			nvmem-cells = <&socinfo_data1>;
+			nvmem-cell-names = "socinfo-data1";
 		};
 
 		u3phy2: t-phy@11c40000 {
-- 
2.18.0

