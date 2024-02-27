Return-Path: <linux-kernel+bounces-83643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3997869CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039041C22AE1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860D14D9E9;
	Tue, 27 Feb 2024 16:47:25 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D2A200DB;
	Tue, 27 Feb 2024 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052444; cv=none; b=Rrdq47dwlUTcPJ7YuWQ1GHW9hHqkV4ewRMLNPx8GrZDjMprbofaXK0reHrOIvNlfbAB2wPd3nkMjqYeeKWMM2ea2sg/Ko+6QSLeS2kvKulmmqOzax3/MMqvAUumopHhKpSgj7vCJhjlRLCjHDI8/Uqv9ZH9t9PcM8/gS0HSjZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052444; c=relaxed/simple;
	bh=UeZjUsiTKcYCzP2F1s53IBwax22EOM05dQxjQiIM2ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psWargEGIK5vQ0j6iZ4+8vgGSoWKbrCMChMTSYvDkHTXmpRABGzRelzJxq8mBFn2cemP0OgTyURlzwuqgJpqcPvrpZDd8lY/wzDLNyfCGs1ihTwbBAsGBzelgUVQXk9RPFpeYuodbezBTtxWyS0nnFWZ18mIaNhnddY1SDuiq10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rf0bm-0006qV-3l; Tue, 27 Feb 2024 17:47:10 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	quentin.schulz@theobroma-systems.com,
	heiko@sntech.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 4/4] arm64: dts: rockchip: add Haikou baseboard with RK3588-Q7 SoM
Date: Tue, 27 Feb 2024 17:46:59 +0100
Message-Id: <20240227164659.705271-5-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227164659.705271-1-heiko@sntech.de>
References: <20240227164659.705271-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Haikou is a Qseven and μQseven baseboard featuring PCIe, USB3 and a
video connector for a MIPI-DSI/CSI adapter.

This dts is for usage with the RK3588-Q7 SoM Tiger.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3588-tiger-haikou.dts | 266 ++++++++++++++++++
 2 files changed, 267 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index a7b30e11beaf4..a44a9e15c9f62 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -110,6 +110,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-nanopc-t6.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-orangepi-5-plus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-quartzpro64.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-turing-rk1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-coolpi-4b.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-indiedroid-nova.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
new file mode 100644
index 0000000000000..c9340923dcb98
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023 Theobroma Systems Design und Consulting GmbH
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include "rk3588-tiger.dtsi"
+
+/ {
+	model = "Theobroma Systems RK3588-Q7 SoM on Haikou devkit";
+	compatible = "tsd,rk3588-tiger-haikou", "tsd,rk3588-tiger", "rockchip,rk3588";
+
+	aliases {
+		ethernet0 = &gmac0;
+		mmc1 = &sdmmc;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	dc_12v: dc-12v-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_12v";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&haikou_keys_pin>;
+
+		button-batlow-n {
+			label = "BATLOW#";
+			linux,code = <KEY_BATTERY>;
+			gpios = <&gpio3 RK_PB5 GPIO_ACTIVE_LOW>;
+		};
+
+		button-slp-btn-n {
+			label = "SLP_BTN#";
+			linux,code = <KEY_SLEEP>;
+			gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_LOW>;
+		};
+
+		button-wake-n {
+			label = "WAKE#";
+			linux,code = <KEY_WAKEUP>;
+			gpios = <&gpio3 RK_PC6 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+
+		switch-lid-btn-n {
+			label = "LID_BTN#";
+			linux,code = <SW_LID>;
+			linux,input-type = <EV_SW>;
+			gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	i2s3-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "Haikou,I2S-codec";
+		simple-audio-card,mclk-fs = <512>;
+		simple-audio-card,frame-master = <&sgtl5000_codec>;
+		simple-audio-card,bitclock-master = <&sgtl5000_codec>;
+
+		sgtl5000_codec: simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s3_2ch>;
+		};
+	};
+
+	sgtl5000_clk: sgtl5000-oscillator  {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24576000>;
+	};
+
+	vcc3v3_baseboard: vcc3v3-baseboard-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_baseboard";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vcc3v3_low_noise: vcc3v3-low-noise-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_low_noise";
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+
+	vcc5v0_baseboard: vcc5v0-baseboard-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_baseboard";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vcc5v0_usb: vcc5v0-usb-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vddd_audio_1v6: vddd-audio-1v6-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vddd_audio_1v6";
+		regulator-boot-on;
+		regulator-min-microvolt = <1600000>;
+		regulator-max-microvolt = <1600000>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+};
+
+&combphy2_psu {
+	status = "okay";
+};
+
+&gmac0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	eeprom@50 {
+		reg = <0x50>;
+		compatible = "atmel,24c01";
+		pagesize = <8>;
+		size = <128>;
+		vcc-supply = <&vcc3v3_baseboard>;
+	};
+};
+
+&i2c5 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	sgtl5000: codec@a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&sgtl5000_clk>;
+		#sound-dai-cells = <0>;
+		VDDA-supply = <&vcc3v3_low_noise>;
+		VDDIO-supply = <&vcc3v3_baseboard>;
+		VDDD-supply = <&vddd_audio_1v6>;
+	};
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2s3_2ch {
+	status = "okay";
+};
+
+&pcie30phy {
+	status = "okay";
+};
+
+&pcie3x4 {
+	vpcie3v3-supply = <&vcc3v3_baseboard>;
+	status = "okay";
+};
+
+&pinctrl {
+	haikou {
+		haikou_keys_pin: haikou-keys-pin {
+			rockchip,pins =
+				/* BATLOW# */
+				<3 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>,
+				/* SLP_BTN# */
+				<4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_up>,
+				/* WAKE# */
+				<3 RK_PC6 RK_FUNC_GPIO &pcfg_pull_up>,
+				/* LID_BTN */
+				<3 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&sdmmc {
+	/* while the same pin, sdmmc_det does not detect card changes */
+	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	pinctrl-0 = <&sdmmc_bus4 &sdmmc_cmd &sdmmc_clk>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3_baseboard>;
+	status = "okay";
+};
+
+&u2phy2 {
+	status = "okay";
+};
+
+&u2phy2_host {
+	status = "okay";
+};
+
+&u2phy3 {
+	status = "okay";
+};
+
+&u2phy3_host {
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-0 = <&uart2m2_xfer>;
+	status = "okay";
+};
+
+&uart5 {
+	rts-gpios = <&gpio3 RK_PB3 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+/* host0 on Q7_USB_P2, lower usb3 port */
+&usb_host0_ehci {
+	status = "okay";
+};
+
+/* host0 on Q7_USB_P2, lower usb3 port */
+&usb_host0_ohci {
+	status = "okay";
+};
+
+/* host1 on Q7_USB_P3, usb2 port */
+&usb_host1_ehci {
+	status = "okay";
+};
+
+/* host1 on Q7_USB_P3, usb2 port */
+&usb_host1_ohci {
+	status = "okay";
+};
+
+/* host2 on Q7_USB_P2, lower usb3 port */
+&usb_host2_xhci {
+	status = "okay";
+};
-- 
2.39.2


