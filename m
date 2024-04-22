Return-Path: <linux-kernel+bounces-153100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0CD8AC919
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC4A1F21BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF1813CA90;
	Mon, 22 Apr 2024 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HmVXWdBU"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E38282893;
	Mon, 22 Apr 2024 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713778790; cv=none; b=btQDbNnVpmVp2BD7y6PjFZ39yxtx+pIDwCSYVeSJqOlbMjae1GUf+jueaLb6UbeASsCgtjQyfANq77cny/ccgRq0SHQIXAJpzt0XkPPJb6o0LqzkEcnIch4ndMRcW+RKtHzdNYJPt5t8NTKycWSjwy5NAdzZ3GZruLkSh/dw4WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713778790; c=relaxed/simple;
	bh=jJD45jtO+ooAQG9xIvSp5qqBFhfQ9ZlEAcB1IkTgIGU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZfhlA4OvOoeNgPSCajb6AFnWaxb1dawGhYydGmpefYetbAilwaw+cTctqW/njYizuhJAg2UQ9JPalINfBPbOqzGiDxNxJSU8JTpqyX4RuEPHr7oG61vdRGRF0CKb5CK/cAhWlMxVZ9slQXD5w+T93KDA2JN1Wkene08wDfUwwuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HmVXWdBU; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3dd490a8008c11efb8927bc1f75efef4-20240422
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=YW7vLNb1CooAswGdrq5C8QnFRuDupMcVgx5EZF4rBoI=;
	b=HmVXWdBU37fQhOjR6h+Sr0VbElNkXchfRDX56+17OFpm7h6lYjiwjV2Nydw6405xgeg+KqxHQIjY1NV3KfS+HlTuY5sugHqy4996r7JCY+4PTQWX1ssaThrX1+ZQhxHTS2GSEQq63wqDTYbZIA2HHbjWVvXsEXk/CUy5+YfQ7nc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:50fdc328-632f-4b65-862e-1f307de96503,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:82c5f88,CLOUDID:05def682-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3dd490a8008c11efb8927bc1f75efef4-20240422
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1552289964; Mon, 22 Apr 2024 17:39:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 22 Apr 2024 17:39:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 22 Apr 2024 17:39:37 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>, Yow-shin Liou
	<yow-shin.liou@mediatek.com>, Jason-ch Chen <Jason-ch.Chen@mediatek.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
Subject: [PATCH 1/3] arm64: dts: mediatek: mt8390-genio-700-evk: update regulator names
Date: Mon, 22 Apr 2024 17:39:24 +0800
Message-ID: <20240422093926.15392-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-1.155300-8.000000
X-TMASE-MatchedRID: he/3GKrlJcbeTJ7REvV1+1z+axQLnAVBzQQ2zkt0IfmWU8yr2LEGrk3v
	YK+4NwyrVlhEP3oQTmgwzEWv7JigN2UlOh2o2oTOdOc7KAdVCk4k227Ivqakhd9RlPzeVuQQYYS
	ydbbRt4Yli7b+tQ5fvzctK0KUOQ1lhUSj0P0iytKeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8it4J
	O7oSODmJ48frLn7nsy8kJcJpKwfYfvBgraGdIeD1sEmWjsdOweQwMWhhQpHvFF20N++tKwS5ZKk
	9ThZiYZftBGJ2jFfS3WcY8SsugGWhz+PhojlLUuev0YPTN868QBqq+/+aGCsQhzL04Or2eZWoC0
	8z/YUWKUTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-1.155300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 648AF09DEE9A84B80FD2E6BA3265B6882D50805966AE8EAA0AA76531D01680202000:8
X-MTK: N

Update regulator names to match schematics, replacing generic terms.
1. Add system wide 'reg_vsys' node for 4.2V power rail.
2. Add 'reg_vsys' node as 'vin-supply' for the following nodes
 - common_fixed_5v, edp_panel_fixed_3v3, gpio_fixed_3v3, sdio_fixed_3v3,
   touch0_fixed_3v3, usb_hub_fixed_3v3, usb_p0_vbus, and usb_p1_vbus.
3. Update regulator names according to the stable output name on
   schematics.
 - vdd_5v, vedp_3v3, ext_3v3, vio18_conn, wifi_3v3, vio33_tp1, vhub_3v3,
   vbus_p0, vbus_p1.
 - vcn18_pmu, vcn33_2_pmu, dvdd_proc_l, dvdd_core, vpa_pmu, dvdd_adsp,
   va12_abb2_pmu, vsim1_pmu, vufs18_pmu.
4. Remove usb_hub_reset_1v8. Use 'hub' node to probe USB HUB
   in subsequent patches.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../dts/mediatek/mt8390-genio-700-evk.dts     | 65 ++++++++++++-------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
index 6bb1d5d112ef..9b7ad046f193 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
@@ -87,103 +87,113 @@
 
 	common_fixed_5v: regulator-0 {
 		compatible = "regulator-fixed";
-		regulator-name = "5v_en";
+		regulator-name = "vdd_5v";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		gpio = <&pio 10 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-always-on;
+		vin-supply = <&reg_vsys>;
 	};
 
 	edp_panel_fixed_3v3: regulator-1 {
 		compatible = "regulator-fixed";
-		regulator-name = "edp_panel_3v3";
+		regulator-name = "vedp_3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		enable-active-high;
 		gpio = <&pio 15 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&edp_panel_3v3_en_pins>;
+		vin-supply = <&reg_vsys>;
 	};
 
 	gpio_fixed_3v3: regulator-2 {
 		compatible = "regulator-fixed";
-		regulator-name = "gpio_3v3_en";
+		regulator-name = "ext_3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&pio 9 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-always-on;
+		vin-supply = <&reg_vsys>;
 	};
 
+	/* system wide 4.2V power rail from charger */
+	reg_vsys: regulator-vsys {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	/* used by mmc2 */
 	sdio_fixed_1v8: regulator-3 {
 		compatible = "regulator-fixed";
-		regulator-name = "sdio_io";
+		regulator-name = "vio18_conn";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		enable-active-high;
 		regulator-always-on;
 	};
 
+	/* used by mmc2 */
 	sdio_fixed_3v3: regulator-4 {
 		compatible = "regulator-fixed";
-		regulator-name = "sdio_card";
+		regulator-name = "wifi_3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&pio 74 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-always-on;
+		vin-supply = <&reg_vsys>;
 	};
 
 	touch0_fixed_3v3: regulator-5 {
 		compatible = "regulator-fixed";
-		regulator-name = "touch_3v3";
+		regulator-name = "vio33_tp1";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&pio 119 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		vin-supply = <&reg_vsys>;
 	};
 
 	usb_hub_fixed_3v3: regulator-6 {
 		compatible = "regulator-fixed";
-		regulator-name = "usb_hub_3v3";
+		regulator-name = "vhub_3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&pio 112 GPIO_ACTIVE_HIGH>; /* HUB_3V3_EN */
 		startup-delay-us = <10000>;
 		enable-active-high;
+		vin-supply = <&reg_vsys>;
 	};
 
-	usb_hub_reset_1v8: regulator-7 {
-		compatible = "regulator-fixed";
-		regulator-name = "usb_hub_reset";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		gpio = <&pio 7 GPIO_ACTIVE_HIGH>; /* HUB_RESET */
-		vin-supply = <&usb_hub_fixed_3v3>;
-	};
-
-	usb_p0_vbus: regulator-8 {
+	usb_p0_vbus: regulator-7 {
 		compatible = "regulator-fixed";
-		regulator-name = "usb_p0_vbus";
+		regulator-name = "vbus_p0";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		gpio = <&pio 84 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		vin-supply = <&reg_vsys>;
 	};
 
-	usb_p1_vbus: regulator-9 {
+	usb_p1_vbus: regulator-8 {
 		compatible = "regulator-fixed";
-		regulator-name = "usb_p1_vbus";
+		regulator-name = "vbus_p1";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		gpio = <&pio 87 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		vin-supply = <&reg_vsys>;
 	};
 
-	usb_p2_vbus: regulator-10 {
+	/* used by ssusb2 */
+	usb_p2_vbus: regulator-9 {
 		compatible = "regulator-fixed";
-		regulator-name = "usb_p2_vbus";
+		regulator-name = "wifi_3v3";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
@@ -295,38 +305,47 @@
 };
 
 &mt6359_vcn18_ldo_reg {
+	regulator-name = "vcn18_pmu";
 	regulator-always-on;
 };
 
 &mt6359_vcn33_2_bt_ldo_reg {
+	regulator-name = "vcn33_2_pmu";
 	regulator-always-on;
 };
 
 &mt6359_vcore_buck_reg {
+	regulator-name = "dvdd_proc_l";
 	regulator-always-on;
 };
 
 &mt6359_vgpu11_buck_reg {
+	regulator-name = "dvdd_core";
 	regulator-always-on;
 };
 
 &mt6359_vpa_buck_reg {
+	regulator-name = "vpa_pmu";
 	regulator-max-microvolt = <3100000>;
 };
 
 &mt6359_vpu_buck_reg {
+	regulator-name = "dvdd_adsp";
 	regulator-always-on;
 };
 
 &mt6359_vrf12_ldo_reg {
+	regulator-name = "va12_abb2_pmu";
 	regulator-always-on;
 };
 
 &mt6359_vsim1_ldo_reg {
+	regulator-name = "vsim1_pmu";
 	regulator-enable-ramp-delay = <480>;
 };
 
 &mt6359_vufs_ldo_reg {
+	regulator-name = "vufs18_pmu";
 	regulator-always-on;
 };
 
@@ -871,10 +890,10 @@
 &xhci1 {
 	status = "okay";
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
-	vbus-supply = <&usb_hub_reset_1v8>;
 };
 
 &xhci2 {
 	status = "okay";
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	vbus-supply = <&sdio_fixed_3v3>; /* wifi_3v3 */
 };
-- 
2.18.0


