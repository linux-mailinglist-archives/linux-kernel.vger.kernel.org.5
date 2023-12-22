Return-Path: <linux-kernel+bounces-9476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BB181C636
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562FC283117
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D5DD301;
	Fri, 22 Dec 2023 08:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OD1ddckt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDFEC13B;
	Fri, 22 Dec 2023 08:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2f5610e2a0a111eeba30773df0976c77-20231222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=TG5YNHKAkRWVrkYlv/OzsBvwG1g8SCQSol5QW/b7HEA=;
	b=OD1ddcktcWy+gYINBwSHTuvS9d1NUZzdMY+QUMix5xFUuTz9PoHjvKqvzieLlbKjdgwPcfaj6iNVJC/o8v6xUApCUbLga9L4Vvgd+QgITkGi6IwgIE+WVHVj8CZNYRuIux6XB7asJf3h1//fQB1ERgnDLmfDjfMfB/I8gqZZsqg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:a8c2bd55-62d6-412c-b513-3f172ea5c529,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:e1cd758d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2f5610e2a0a111eeba30773df0976c77-20231222
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <william-tw.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2022994429; Fri, 22 Dec 2023 16:07:43 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Dec 2023 16:07:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Dec 2023 16:07:42 +0800
From: William-tw Lin <william-tw.lin@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	William-tw Lin <william-tw.lin@mediatek.com>
Subject: [PATCH v4 1/3] arm64: dts: mediatek: Add socinfo efuses to MT8173/83/96/92/95 SoCs
Date: Fri, 22 Dec 2023 16:07:37 +0800
Message-ID: <20231222080739.21706-2-william-tw.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231222080739.21706-1-william-tw.lin@mediatek.com>
References: <20231222080739.21706-1-william-tw.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add efuse nodes for socinfo retrieval for MT8173, MT8183, MT8186,
MT8192 and MT8195.

Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 9 +++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 9 +++++++++
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 8 ++++++++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 3 +++
 5 files changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index c47d7d900f28..0f4aab80d5e4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -590,6 +590,15 @@
 			reg = <0 0x10206000 0 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			socinfo-data1@40 {
+				reg = <0x040 0x4>;
+			};
+
+			socinfo-data2@44 {
+				reg = <0x044 0x4>;
+			};
+
 			thermal_calibration: calib@528 {
 				reg = <0x528 0xc>;
 			};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 976dc968b3ca..1fe351b710ed 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1585,6 +1585,15 @@
 			reg = <0 0x11f10000 0 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			socinfo-data1@4c {
+				reg = <0x04c 0x4>;
+			};
+
+			socinfo-data2@60 {
+				reg = <0x060 0x4>;
+			};
+
 			thermal_calibration: calib@180 {
 				reg = <0x180 0xc>;
 			};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index df0c04f2ba1d..7dd0ae965ee0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -1672,6 +1672,10 @@
 				reg = <0x59c 0x4>;
 				bits = <0 3>;
 			};
+
+			socinfo-data1@7a0 {
+				reg = <0x7a0 0x4>;
+			};
 		};
 
 		mipi_tx0: dsi-phy@11cc0000 {
diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 69f4cded5dbb..85f2c49be6fc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -1120,6 +1120,14 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			socinfo-data1@44 {
+				reg = <0x044 0x4>;
+			};
+
+			socinfo-data2@50 {
+				reg = <0x050 0x4>;
+			};
+
 			lvts_e_data1: data1@1c0 {
 				reg = <0x1c0 0x58>;
 			};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index e0ac2e9f5b72..520f7b649cb2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1686,6 +1686,9 @@
 			lvts_efuse_data2: lvts2-calib@1d0 {
 				reg = <0x1d0 0x38>;
 			};
+			socinfo-data1@7a0 {
+				reg = <0x7a0 0x4>;
+			};
 		};
 
 		u3phy2: t-phy@11c40000 {
-- 
2.18.0


