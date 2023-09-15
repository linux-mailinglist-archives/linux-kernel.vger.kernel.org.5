Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9977A2253
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbjIOP0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbjIOP0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:26:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BB9E7F;
        Fri, 15 Sep 2023 08:26:30 -0700 (PDT)
X-UUID: 3a82520853dc11ee8051498923ad61e6-20230915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ayjTBw9SUMzwI9y+pFFSZ5QeOsb/Yitc7WAaF4WzbUE=;
        b=UMso3/9/wC+EddZeWeCRad/A2f8xRO+4u9OJU7lCff39OWaqFk7c82c2X/HIYCZ74fhhDtXeeuG9ZNChTVFQNy0CXHdjheqvyd48rpmQZhZWINgTSGOAy8KjCDIcVd390lgHGMN/lQRIJfZMIxzseM1TCOlUxmaMdkDJRhdV9Mw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:9ebb409c-b46c-42c2-9934-3615665d01d7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:7b27e3be-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3a82520853dc11ee8051498923ad61e6-20230915
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <william-tw.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 146541698; Fri, 15 Sep 2023 23:26:23 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Sep 2023 23:26:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Sep 2023 23:26:21 +0800
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
Subject: [PATCH v2 1/3] arm64: dts: Add node for chip info driver
Date:   Fri, 15 Sep 2023 23:26:05 +0800
Message-ID: <20230915152607.18116-2-william-tw.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230915152607.18116-1-william-tw.lin@mediatek.com>
References: <20230915152607.18116-1-william-tw.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.485700-8.000000
X-TMASE-MatchedRID: cAwOsowI+VJbbwmb1mOeyx+WEMjoO9WWTJDl9FKHbrkUtdRZTmEaId3Z
        0ElDaJ9X4vM1YF6AJbbCCfuIMF6xLcK21zBg2KlfD12T7q2dIUsyhzfPOvCngZwAmEUTn8WLHvE
        +nnZyoJ4qoAEUxaAvfg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.485700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: EBC19D5A9B5547D23D75391669BDC015A5C50DADB4553DE91B5ECEF8B5B584312000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dts node for socinfo retrieval for the following projects:
MT8173, MT8183, MT8186, MT8192, MT8195

Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 15 +++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 15 +++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 10 ++++++++++
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi |  9 +++++++++
 5 files changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index c47d7d900f28..8cac18ed7833 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -590,6 +590,15 @@
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
@@ -1520,4 +1529,10 @@
 			power-domains = <&spm MT8173_POWER_DOMAIN_VENC_LT>;
 		};
 	};
+
+	socinfo {
+		compatible = "mediatek,socinfo";
+		nvmem-cells = <&socinfo_data1 &socinfo_data2>;
+		nvmem-cell-names = "socinfo-data1", "socinfo-data2";
+	};
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 5169779d01df..b17af0edb198 100644
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
@@ -2105,4 +2114,10 @@
 			power-domains = <&spm MT8183_POWER_DOMAIN_CAM>;
 		};
 	};
+
+	socinfo {
+		compatible = "mediatek,socinfo";
+		nvmem-cells = <&socinfo_data1 &socinfo_data2>;
+		nvmem-cell-names = "socinfo-data1", "socinfo-data2";
+	};
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index f04ae70c470a..860559d239a0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -1660,6 +1660,10 @@
 				reg = <0x59c 0x4>;
 				bits = <0 3>;
 			};
+
+			socinfo_data1: socinfo-data1 {
+				reg = <0x7a0 0x4>;
+			};
 		};
 
 		mipi_tx0: dsi-phy@11cc0000 {
@@ -2083,4 +2087,10 @@
 			power-domains = <&spm MT8186_POWER_DOMAIN_IPE>;
 		};
 	};
+
+	socinfo {
+		compatible = "mediatek,socinfo";
+		nvmem-cells = <&socinfo_data1>;
+		nvmem-cell-names = "socinfo-data1";
+	};
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 5e94cb4aeb44..3e1315da3b56 100644
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
@@ -1901,4 +1909,10 @@
 			power-domains = <&spm MT8192_POWER_DOMAIN_MDP>;
 		};
 	};
+
+	socinfo {
+		compatible = "mediatek,socinfo";
+		nvmem-cells = <&socinfo_data1 &socinfo_data2>;
+		nvmem-cell-names = "socinfo-data1", "socinfo-data2";
+	};
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 48b72b3645e1..17c4805d7963 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1683,6 +1683,9 @@
 			lvts_efuse_data2: lvts2-calib@1d0 {
 				reg = <0x1d0 0x38>;
 			};
+			socinfo_data1: socinfo-data1 {
+				reg = <0x7a0 0x4>;
+			};
 		};
 
 		u3phy2: t-phy@11c40000 {
@@ -3519,4 +3522,10 @@
 			};
 		};
 	};
+
+	socinfo {
+		compatible = "mediatek,socinfo";
+		nvmem-cells = <&socinfo_data1>;
+		nvmem-cell-names = "socinfo-data1";
+	};
 };
-- 
2.18.0

