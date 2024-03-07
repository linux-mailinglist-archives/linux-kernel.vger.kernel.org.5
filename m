Return-Path: <linux-kernel+bounces-95483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A901874E28
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00DB1F23A80
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40A112FF93;
	Thu,  7 Mar 2024 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rzPy4O7F"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D6D12A170;
	Thu,  7 Mar 2024 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811946; cv=none; b=hXQH0tQrdTsKvqB+EE8N5XuDKIKld9WUB28f/OhoqDDt0wmjCKrqVesAw3HZRuJc5XwbLRmyixoxkEArJOINdRingS+dsG+pmc9zemT5d5zu3aU1YqRQUBfjF6Cx942DFj4+ow1i1zxbawTSIsGUfkV29g2Ic/d1iffiLTZt3wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811946; c=relaxed/simple;
	bh=Jpx8HKm9BGBUo/aktxdkRyrJGYDFjXNdMQ+YMjx31sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=el5+fpHP+Y2EpoWg7ktRoxUbNfFWZOkq5UmqYErcI39Joqz9Je2kM5144lUTnZPpEmRagKvzJ6Q1P2JmzjvviHqYwcf78+0nskYe9Q/D041y+ajlTrvBnd/xQNGgzQwwdUm8C3+SDnJOv0tkjhokqOhxvyCT0hKvdOzG6lcXDtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rzPy4O7F; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709811943;
	bh=Jpx8HKm9BGBUo/aktxdkRyrJGYDFjXNdMQ+YMjx31sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rzPy4O7FFib+GXCU0T6moiZzufkarJUjBZ3jFGUbwm4ujlC2bT3TRwHng10reERTP
	 c11943Znel7Bq2EtZefNIOcgRLApJuSN4cYoOowyzL7c2tx/mkumivES6PRwejprQi
	 fvzZ+XdMZiQHDPtMDVNisyiwG6x/RAJatnRqkGWiUDs5uV8IspStqJKY0w+4kaq8Fg
	 XWLeSTDpHem6k1Akla2LXE6h6mopVd89NZhUdPJHy7lHqJ0sNKn0CHjZw048fzFu4n
	 K275ateORnFYuF1K9CJktQIpB1FxtT6Gjc2K09NO/hSZYPjnq0jvFK5PO02TfdO0gk
	 xXZKqiSI+IHbw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D4A2B37820EA;
	Thu,  7 Mar 2024 11:45:40 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: broonie@kernel.org
Cc: wenst@chromium.org,
	lgirdwood@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	trevor.wu@mediatek.com,
	maso.huang@mediatek.com,
	xiazhengqiao@huaqin.corp-partner.google.com,
	arnd@arndb.de,
	kuninori.morimoto.gx@renesas.com,
	shraash@google.com,
	amergnat@baylibre.com,
	nicolas.ferre@microchip.com,
	u.kleine-koenig@pengutronix.de,
	dianders@chromium.org,
	frank.li@vivo.com,
	allen-kh.cheng@mediatek.com,
	eugen.hristev@collabora.com,
	claudiu.beznea@tuxon.dev,
	jarkko.nikula@bitmer.com,
	jiaxin.yu@mediatek.com,
	alpernebiyasak@gmail.com,
	ckeepax@opensource.cirrus.com,
	zhourui@huaqin.corp-partner.google.com,
	nfraprado@collabora.com,
	alsa-devel@alsa-project.org,
	shane.chien@mediatek.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 21/22] arm64: dts: mediatek: mt8195-cherry: Specify sound DAI links and routing
Date: Thu,  7 Mar 2024 12:44:44 +0100
Message-ID: <20240307114445.196981-22-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307114445.196981-1-angelogioacchino.delregno@collabora.com>
References: <20240307114445.196981-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The drivers and bindings acquired support for specifying audio hardware
and links in device tree: describe and link the sound related HW of this
machine.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index f94c07f8b933..e405e226e449 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -240,6 +240,7 @@ adsp_device_mem: memory@60e80000 {
 	spk_amplifier: rt1019p {
 		compatible = "realtek,rt1019p";
 		label = "rt1019p";
+		#sound-dai-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&rt1019p_pins_default>;
 		sdb-gpios = <&pio 100 GPIO_ACTIVE_HIGH>;
@@ -334,6 +335,7 @@ &disp_pwm0 {
 &dp_tx {
 	status = "okay";
 
+	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&dptx_pin>;
 
@@ -404,6 +406,7 @@ audio_codec: codec@1a {
 		/* Realtek RT5682i or RT5682s, sharing the same configuration */
 		reg = <0x1a>;
 		interrupts-extended = <&pio 89 IRQ_TYPE_EDGE_BOTH>;
+		#sound-dai-cells = <0>;
 		realtek,jd-src = <1>;
 
 		AVDD-supply = <&mt6359_vio18_ldo_reg>;
@@ -1130,6 +1133,48 @@ &sound {
 		"AFE_SOF_DL2", "AFE_SOF_DL3", "AFE_SOF_UL4", "AFE_SOF_UL5";
 	pinctrl-names = "default";
 	pinctrl-0 = <&aud_pins_default>;
+
+	audio-routing =
+		"Headphone", "HPOL",
+		"Headphone", "HPOR",
+		"IN1P", "Headset Mic",
+		"Ext Spk", "Speaker";
+
+	mm-dai-link {
+		link-name = "ETDM1_IN_BE";
+		mediatek,clk-provider = "cpu";
+	};
+
+	hs-playback-dai-link {
+		link-name = "ETDM1_OUT_BE";
+		mediatek,clk-provider = "cpu";
+		codec {
+			sound-dai = <&audio_codec>;
+		};
+	};
+
+	hs-capture-dai-link {
+		link-name = "ETDM2_IN_BE";
+		mediatek,clk-provider = "cpu";
+		codec {
+			sound-dai = <&audio_codec>;
+		};
+	};
+
+	spk-playback-dai-link {
+		link-name = "ETDM2_OUT_BE";
+		mediatek,clk-provider = "cpu";
+		codec {
+			sound-dai = <&spk_amplifier>;
+		};
+	};
+
+	displayport-dai-link {
+		link-name = "DPTX_BE";
+		codec {
+			sound-dai = <&dp_tx>;
+		};
+	};
 };
 
 &spi0 {
-- 
2.44.0


