Return-Path: <linux-kernel+bounces-103131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA89687BB67
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1604282B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E836F07E;
	Thu, 14 Mar 2024 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="s4aPRkEn"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F06EB45;
	Thu, 14 Mar 2024 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412553; cv=none; b=gCIzNqMtytKQ25B5ysHIsWBOMQ4IJgqT/2dUe6aqArzdkSEyEezADnLCqD5J5P90SfCCBamphDGlS82PBl6Gnt+hqf5a+HEnBBqX9uFYWLOv2ayJTI9e05C6vEA9U3B6WHCL9r/JThLSGe4YMcN7dKZH5wYIZM3zMt+oNXH1v3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412553; c=relaxed/simple;
	bh=PAcMexfqwBWbLZd/LVY9KnzueSvjkoUiTVkXsqRNZvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phQEse3tueZu5idpAIR8BRD1DK97gloPA+A9A5ALeFacLaIaQMgqnqJsVlxPAYMyDQgaqhqaRal9XXu2FZlcHoZBX/ItpyXvUSwiaXKm5QQUq9IVOgjBZSjchFEMjDYxFkR4e6YkJerlDnfEbvP/QKA5rio+ddrEUwdkaPEuy98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=s4aPRkEn; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710412550;
	bh=PAcMexfqwBWbLZd/LVY9KnzueSvjkoUiTVkXsqRNZvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s4aPRkEnoi0FIACES1g3GTlSgksGqTvqAD/tWr/IY2YO+y6MCcO4INqTGjn/27bTa
	 oxrYzRPK5lAJrU69bwizZE7cF/fhWX/P8QbyYahyS20gK5XTqdJyirtDOy14PXCb6l
	 zesuUDIVssdWiowwq6YM/BiIayU8G5pJRRXLtNO28Hvmlb8xGL5bUsL9UzkSyS3t2p
	 C/nGyQUMzqNgXiD22swGkwixeWBV0ygdnd/dqz2T4bO/m/La2K54um6U1D+oysFvyJ
	 oesf7JkBXB9qJ9qAgzIKGxrt+LsV3WrYao0VE+KSHZ0cYzckD2qn+FhYt/t8/7L6W2
	 1MLh4CMY0baMQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 23EEE37820F5;
	Thu, 14 Mar 2024 10:35:49 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	wenst@chromium.org,
	jenneron@protonmail.com,
	kernel@collabora.com
Subject: [PATCH 2/2] arm64: mediatek: mt8195-cherry: Introduce the MT8195 Dojo Chromebook
Date: Thu, 14 Mar 2024 11:35:00 +0100
Message-ID: <20240314103500.93158-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240314103500.93158-1-angelogioacchino.delregno@collabora.com>
References: <20240314103500.93158-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a devicetree for the Cherry Dojo (HP Chromebook x360 13b-ca0002sa)
convertible type machine.

Differences with the already supported Tomato machines include:
 - Different speaker amplifiers (Dual MAX98380, one per channel)
 - I2C Touchscreen is on a different address (though still a HID device)
 - Has NVMe storage on the PCIe0 controller
 - Slightly different keyboard top row keymap

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../dts/mediatek/mt8195-cherry-dojo-r1.dts    | 114 ++++++++++++++++++
 .../boot/dts/mediatek/mt8195-cherry.dtsi      |   5 +
 3 files changed, 120 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 37b4ca3a87c9..91853402e0da 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -69,6 +69,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r5-sku2.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r4.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-dojo-r1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r2.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r3.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dts
new file mode 100644
index 000000000000..b3f86179bfff
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dts
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+/dts-v1/;
+#include "mt8195-cherry.dtsi"
+
+/ {
+	model = "HP Dojo (sku 1, 3, 5, 7) board";
+	chassis-type = "convertible";
+	compatible = "google,dojo-sku7", "google,dojo-sku5",
+		     "google,dojo-sku3", "google,dojo-sku1",
+		     "google,dojo", "mediatek,mt8195";
+};
+
+&audio_codec {
+	compatible = "realtek,rt5682s";
+	realtek,amic-delay-ms = <250>;
+};
+
+&i2c2 {
+	spk_r_amp: amplifier@38 {
+		compatible = "maxim,max98390";
+		reg = <0x38>;
+		reset-gpios = <&pio 100 GPIO_ACTIVE_LOW>;
+		sound-name-prefix = "Right";
+		#sound-dai-cells = <0>;
+	};
+
+	spk_l_amp: amplifier@39 {
+		compatible = "maxim,max98390";
+		reg = <0x39>;
+		sound-name-prefix = "Left";
+		#sound-dai-cells = <0>;
+	};
+};
+
+&i2c4 {
+	touchscreen@15 {
+		compatible = "hid-over-i2c";
+		reg = <0x15>;
+		hid-descr-addr = <0x0001>;
+		interrupts-extended = <&pio 92 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+		post-power-on-delay-ms = <10>;
+		vdd-supply = <&pp3300_s3>;
+	};
+};
+
+&keyboard_controller {
+	linux,keymap = <
+		CROS_STD_MAIN_KEYMAP
+
+		MATRIX_KEY(0x00, 0x02, KEY_BACK)
+		MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
+		MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
+		MATRIX_KEY(0x01, 0x02, KEY_SCALE)
+		MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
+		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
+		MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
+		MATRIX_KEY(0x02, 0x09, KEY_KBDILLUMTOGGLE)
+		MATRIX_KEY(0x01, 0x09, KEY_PLAYPAUSE)
+		MATRIX_KEY(0x00, 0x04, KEY_MICMUTE)
+		MATRIX_KEY(0x00, 0x01, KEY_MUTE)
+		MATRIX_KEY(0x01, 0x05, KEY_VOLUMEDOWN)
+		MATRIX_KEY(0x03, 0x05, KEY_VOLUMEUP)
+	>;
+};
+
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_pins_default>;
+	status = "okay";
+};
+
+&pciephy {
+	status = "okay";
+};
+
+&pio_default {
+	pins-low-power-hdmi-disable {
+		pinmux = <PINMUX_GPIO31__FUNC_GPIO31>,
+			 <PINMUX_GPIO32__FUNC_GPIO32>,
+			 <PINMUX_GPIO33__FUNC_GPIO33>,
+			 <PINMUX_GPIO34__FUNC_GPIO34>,
+			 <PINMUX_GPIO35__FUNC_GPIO35>;
+		input-enable;
+		bias-pull-down;
+	};
+};
+
+&sound {
+	compatible = "mediatek,mt8195_mt6359_max98390_rt5682";
+	model = "m8195_m98390_5682s";
+
+	audio-routing =
+		"Headphone", "HPOL",
+		"Headphone", "HPOR",
+		"IN1P", "Headset Mic",
+		"Right Spk", "Right BE_OUT",
+		"Left Spk", "Left BE_OUT";
+
+	spk-playback-dai-link {
+		codec {
+			sound-dai = <&spk_r_amp>, <&spk_l_amp>;
+		};
+	};
+};
+
+&spk_amplifier {
+	/* Disable RT1019P, not present on Dojo */
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 843771078794..86d283ffe807 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -1404,6 +1404,11 @@ MATRIX_KEY(0x01, 0x04, 0)	/* T7 */
 		MATRIX_KEY(0x02, 0x09, 0)	/* T8 */
 		MATRIX_KEY(0x01, 0x09, 0)	/* T9 */
 		MATRIX_KEY(0x00, 0x04, 0)	/* T10 */
+
+		/* T11 to T13 are present only on Dojo */
+		MATRIX_KEY(0x00, 0x01, 0)	/* T11 */
+		MATRIX_KEY(0x01, 0x05, 0)	/* T12 */
+		MATRIX_KEY(0x03, 0x05, 0)	/* T13 */
 	>;
 
 	linux,keymap = <
-- 
2.44.0


