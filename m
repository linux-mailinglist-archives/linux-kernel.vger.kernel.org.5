Return-Path: <linux-kernel+bounces-153099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1068AC918
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6195E1C211B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694A813C3C5;
	Mon, 22 Apr 2024 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="K9ea48KW"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1505644B;
	Mon, 22 Apr 2024 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713778789; cv=none; b=WqLDO0wOmeu4w+jhUNWF526r6GEmZrFb3049eiQGfGcF02mK1i9xBDoOkXWPL1bOppJKDn38pD7e+tirFORiyy+6jR68ME98zMrNyK4XCpdiUZflxQXnA1MyCNCFmnf4kKUGDg3kBnqOm981yOhMPoalbxEJ5CFAnzJPT0lqwMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713778789; c=relaxed/simple;
	bh=OFmtNyDRWRTJbSwNl7zHtwOGFumsrsvtRsqG2bz4Bn8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uILUq89KCvgXA8e63QOVYK3CgnMfKZ7ilK7ldgOtdOg79rDfq/vSDCCFJH+Uhg5CxIjMUbjtGXg1CicPfrDKn8M7o/Es6vBcb3UrOSGCArY1hAqY9MeDhS7v32pZLck0daIoFhjdYajEEoevQUJRWJxAui+HsmHHDNh2Vg1+6h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=K9ea48KW; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3dd6783c008c11efb8927bc1f75efef4-20240422
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=2dUEnhw5xFiIc+XADgHYaBr/SM4VF5RqnflFunzIbLA=;
	b=K9ea48KWisxv7Tj3w51OarNJrbzwi6brHyqUqQxfgjM6EQD/lwHOHkUJgECBdi4vtigERHF5iOPPnFkUg4m2K23xj28LaujySgHy9rwrL9n9Eb5Ckq6kzg4xk6XwY2n0Ls0xBZ+mhHlWLAvxNZjqz+9hC6jNKO33/ykK7W/SCKs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:ad4d17ec-4049-49c7-97a9-da2ccd5a3c43,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:82c5f88,CLOUDID:b9857786-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3dd6783c008c11efb8927bc1f75efef4-20240422
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 681981777; Mon, 22 Apr 2024 17:39:40 +0800
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
Subject: [PATCH 2/3] arm64: dts: mediatek: mt8390-genio-700-evk: add IT5205, RT1715, and USB HUB
Date: Mon, 22 Apr 2024 17:39:25 +0800
Message-ID: <20240422093926.15392-2-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240422093926.15392-1-macpaul.lin@mediatek.com>
References: <20240422093926.15392-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-0.669200-8.000000
X-TMASE-MatchedRID: yvDAzrttxFUohE7hoJbtOAPZZctd3P4Bw8djaG0FrZuY5NBG7YIbV0d0
	Rzx07LDVXS+cZR9Lon+vfGA7KBLaSKENdydioT4ACz1WR8KHe4Cy4iyjvVWTog2Y8xyy93kWwl9
	GLHytwjokpovHHUzQSoAy6p60ZV62fJ5/bZ6npdiujVRFkkVsmz3yFinLOvkeMs51Y/gNb4oJoc
	1HDJTj2iNq14IwfLTSS4I2Vx3pKOAXu6myHc7R+Xdy7yJkALcTcTYnJ0lBa6CTL3doWSD6VG1Rj
	oup2VCcWve+eVz4Pp5Vk5utmQ1VlGVF3+d9rnox6EMj9/eK3+Y=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-0.669200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 8898A593C8B07133EB9E530053824434C66F07DBC80D11360B5EFBD2DD36794F2000:8
X-MTK: N

1. Add i2c to aliases.
2. Add MUX IT5205 support to i2c1.
3. Add TYPEC RT1715 support to i2c4.
4. Add PMIC_KEY setting.
5. Add USB HUB TUSB8020 to xhci1.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../dts/mediatek/mt8390-genio-700-evk.dts     | 56 ++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
index 9b7ad046f193..17f22b1836bf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
@@ -23,6 +23,15 @@
 		     "mediatek,mt8188";
 
 	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
 		serial0 = &uart0;
 	};
 
@@ -225,6 +234,16 @@
 	pinctrl-0 = <&i2c1_pins>;
 	clock-frequency = <400000>;
 	status = "okay";
+
+	typec-mux@48 {
+		compatible = "ite,it5205";
+		reg = <0x48>;
+
+		mode-switch;
+		orientation-switch;
+
+		vcc-supply = <&mt6359_vcn33_1_bt_ldo_reg>;
+	};
 };
 
 &i2c2 {
@@ -242,11 +261,19 @@
 };
 
 &i2c4 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "default";
 	pinctrl-0 = <&i2c4_pins>;
 	pinctrl-1 = <&rt1715_int_pins>;
 	clock-frequency = <1000000>;
 	status = "okay";
+
+	rt1715@4e {
+		compatible = "richtek,rt1715";
+		reg = <0x4e>;
+		interrupts-extended = <&pio 12 IRQ_TYPE_LEVEL_LOW>;
+		vbus-supply = <&usb_p1_vbus>;
+		status = "okay";
+	};
 };
 
 &i2c5 {
@@ -836,6 +863,17 @@
 &pmic {
 	interrupt-parent = <&pio>;
 	interrupts = <222 IRQ_TYPE_LEVEL_HIGH>;
+
+	mt6359keys: keys {
+		compatible = "mediatek,mt6359-keys";
+		mediatek,long-press-mode = <1>;
+		power-off-time-sec = <0>;
+
+		power-key {
+			linux,keycodes = <KEY_POWER>;
+			wakeup-source;
+		};
+	};
 };
 
 &scp {
@@ -890,6 +928,22 @@
 &xhci1 {
 	status = "okay";
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+
+	hub_2_0: hub@1 {
+		compatible = "usb451,8025";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		reset-gpios = <&pio 7 GPIO_ACTIVE_HIGH>;
+		vdd-supply = <&usb_hub_fixed_3v3>;
+	};
+
+	hub_3_0: hub@2 {
+		compatible = "usb451,8027";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		reset-gpios = <&pio 7 GPIO_ACTIVE_HIGH>;
+		vdd-supply = <&usb_hub_fixed_3v3>;
+	};
 };
 
 &xhci2 {
-- 
2.18.0


