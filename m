Return-Path: <linux-kernel+bounces-161641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25FB8B4EF1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781612822CE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CD21118E;
	Mon, 29 Apr 2024 00:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lK0nYpp+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D7710A1D;
	Mon, 29 Apr 2024 00:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714350425; cv=none; b=hSWN9lQbrxf895pe1qMDribQ27cM+hgoimVWpMyfhF7OQmCH/1yqUiq5+c9O42Hrn+Dgobdmx2NKrnmr87wcjhswK72hLc3nBQTgcekxjGqtQuWNxt/AYQ0JHWQGPOUrsgrkYUVUNQ0wh49+quIR2YfuCCSEfh+JB/0xWAuKvNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714350425; c=relaxed/simple;
	bh=F5mQt543eIxBcudqnZ4KxKSg+PVA3WTuQCE85YgXcIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kaex+u3Ql4es/BnZ7efWxm5F0UhCCR3U/5WhXbe51Jq/+S5mUUiLiZpghy5fWVnusAnD16vaHG4HtHrfbNHrmy0O7klZ5lnnWvTARkw4a7DrhXsaJKj7BU2b9xxaYflMsMMYvy0Fi7f3dtqM04Xe0wicYLj2WG/tDG4bbcjpIQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lK0nYpp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F97CC4AF1A;
	Mon, 29 Apr 2024 00:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714350425;
	bh=F5mQt543eIxBcudqnZ4KxKSg+PVA3WTuQCE85YgXcIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lK0nYpp+fyZ01Wb+mioRzNID6KUbk/PvH9mz9H9YUR/ckyUFk68938DapCuOdllwN
	 64ez6cldIRWlN8Gl+QCAADAkpEeRVrCWKiPvshOF9eTqnSmWzUiyRulPp2F+7g7dNt
	 aoFpyhQpPo6AZ9tOr3Ykp148OYBqtT4YZDhRHHUL81I8nuBaucmWIr7nQL33NFYiab
	 cM+oMGSOE0sfIvwzM3WZOttQmsD5nzpzyo+yMNP83ITIBqmQLqjX9rPJcobqJ5+ups
	 kIOa5/tUH/KgunHTXbYG0x/j4XIE+XSzmolW5tl5IkBMzyYbY+52ZbJIWsUP7xG3eq
	 8a4fB398X2z2w==
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <kernel@esmil.dk>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/8] riscv: dts: starfive: introduce a common board dtsi for jh7110 based boards
Date: Mon, 29 Apr 2024 08:13:16 +0800
Message-ID: <20240429001317.432-8-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429001317.432-1-jszhang@kernel.org>
References: <20240429001317.432-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to prepare for Milkv Mars board dts support in the following
patch. Let's factored out common part into .dtsi.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../boot/dts/starfive/jh7110-common.dtsi      | 599 ++++++++++++++++++
 .../jh7110-starfive-visionfive-2.dtsi         | 585 +----------------
 2 files changed, 600 insertions(+), 584 deletions(-)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-common.dtsi

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
new file mode 100644
index 000000000000..8ff6ea64f048
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -0,0 +1,599 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
+ */
+
+/dts-v1/;
+#include "jh7110.dtsi"
+#include "jh7110-pinfunc.h"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	aliases {
+		ethernet0 = &gmac0;
+		i2c0 = &i2c0;
+		i2c2 = &i2c2;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0x1 0x0>;
+	};
+
+	gpio-restart {
+		compatible = "gpio-restart";
+		gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
+		priority = <224>;
+	};
+
+	pwmdac_codec: audio-codec {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "StarFive-PWMDAC-Sound-Card";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		simple-audio-card,dai-link@0 {
+			reg = <0>;
+			format = "left_j";
+			bitclock-master = <&sndcpu0>;
+			frame-master = <&sndcpu0>;
+
+			sndcpu0: cpu {
+				sound-dai = <&pwmdac>;
+			};
+
+			codec {
+				sound-dai = <&pwmdac_codec>;
+			};
+		};
+	};
+};
+
+&cpus {
+	timebase-frequency = <4000000>;
+};
+
+&dvp_clk {
+	clock-frequency = <74250000>;
+};
+
+&gmac0_rgmii_rxin {
+	clock-frequency = <125000000>;
+};
+
+&gmac0_rmii_refin {
+	clock-frequency = <50000000>;
+};
+
+&gmac1_rgmii_rxin {
+	clock-frequency = <125000000>;
+};
+
+&gmac1_rmii_refin {
+	clock-frequency = <50000000>;
+};
+
+&hdmitx0_pixelclk {
+	clock-frequency = <297000000>;
+};
+
+&i2srx_bclk_ext {
+	clock-frequency = <12288000>;
+};
+
+&i2srx_lrck_ext {
+	clock-frequency = <192000>;
+};
+
+&i2stx_bclk_ext {
+	clock-frequency = <12288000>;
+};
+
+&i2stx_lrck_ext {
+	clock-frequency = <192000>;
+};
+
+&mclk_ext {
+	clock-frequency = <12288000>;
+};
+
+&osc {
+	clock-frequency = <24000000>;
+};
+
+&rtc_osc {
+	clock-frequency = <32768>;
+};
+
+&tdm_ext {
+	clock-frequency = <49152000>;
+};
+
+&camss {
+	assigned-clocks = <&ispcrg JH7110_ISPCLK_DOM4_APB_FUNC>,
+			  <&ispcrg JH7110_ISPCLK_MIPI_RX0_PXL>;
+	assigned-clock-rates = <49500000>, <198000000>;
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+		};
+
+		port@1 {
+			reg = <1>;
+
+			camss_from_csi2rx: endpoint {
+				remote-endpoint = <&csi2rx_to_camss>;
+			};
+		};
+	};
+};
+
+&csi2rx {
+	assigned-clocks = <&ispcrg JH7110_ISPCLK_VIN_SYS>;
+	assigned-clock-rates = <297000000>;
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			/* remote MIPI sensor endpoint */
+		};
+
+		port@1 {
+			reg = <1>;
+
+			csi2rx_to_camss: endpoint {
+				remote-endpoint = <&camss_from_csi2rx>;
+			};
+		};
+	};
+};
+
+&gmac0 {
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&i2c0 {
+	clock-frequency = <100000>;
+	i2c-sda-hold-time-ns = <300>;
+	i2c-sda-falling-time-ns = <510>;
+	i2c-scl-falling-time-ns = <510>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	i2c-sda-hold-time-ns = <300>;
+	i2c-sda-falling-time-ns = <510>;
+	i2c-scl-falling-time-ns = <510>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+	status = "okay";
+};
+
+&i2c5 {
+	clock-frequency = <100000>;
+	i2c-sda-hold-time-ns = <300>;
+	i2c-sda-falling-time-ns = <510>;
+	i2c-scl-falling-time-ns = <510>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins>;
+	status = "okay";
+
+	axp15060: pmic@36 {
+		compatible = "x-powers,axp15060";
+		reg = <0x36>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		regulators {
+			vcc_3v3: dcdc1 {
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc_3v3";
+			};
+
+			vdd_cpu: dcdc2 {
+				regulator-always-on;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1540000>;
+				regulator-name = "vdd-cpu";
+			};
+
+			emmc_vdd: aldo4 {
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "emmc_vdd";
+			};
+		};
+	};
+};
+
+&i2c6 {
+	clock-frequency = <100000>;
+	i2c-sda-hold-time-ns = <300>;
+	i2c-sda-falling-time-ns = <510>;
+	i2c-scl-falling-time-ns = <510>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c6_pins>;
+	status = "okay";
+};
+
+&mmc0 {
+	max-frequency = <100000000>;
+	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
+	assigned-clock-rates = <50000000>;
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	cap-mmc-hw-reset;
+	post-power-on-delay-ms = <200>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&emmc_vdd>;
+	status = "okay";
+};
+
+&mmc1 {
+	max-frequency = <100000000>;
+	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
+	assigned-clock-rates = <50000000>;
+	bus-width = <4>;
+	no-sdio;
+	no-mmc;
+	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	cap-sd-highspeed;
+	post-power-on-delay-ms = <200>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	status = "okay";
+};
+
+&pwmdac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwmdac_pins>;
+	status = "okay";
+};
+
+&qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	nor_flash: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		cdns,read-delay = <5>;
+		spi-max-frequency = <12000000>;
+		cdns,tshsl-ns = <1>;
+		cdns,tsd2d-ns = <1>;
+		cdns,tchsh-ns = <1>;
+		cdns,tslch-ns = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			spl@0 {
+				reg = <0x0 0x80000>;
+			};
+			uboot-env@f0000 {
+				reg = <0xf0000 0x10000>;
+			};
+			uboot@100000 {
+				reg = <0x100000 0x400000>;
+			};
+			reserved-data@600000 {
+				reg = <0x600000 0xa00000>;
+			};
+		};
+	};
+};
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_pins>;
+	status = "okay";
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>;
+	status = "okay";
+
+	spi_dev0: spi@0 {
+		compatible = "rohm,dh2228fv";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+	};
+};
+
+&sysgpio {
+	i2c0_pins: i2c0-0 {
+		i2c-pins {
+			pinmux = <GPIOMUX(57, GPOUT_LOW,
+					      GPOEN_SYS_I2C0_CLK,
+					      GPI_SYS_I2C0_CLK)>,
+				 <GPIOMUX(58, GPOUT_LOW,
+					      GPOEN_SYS_I2C0_DATA,
+					      GPI_SYS_I2C0_DATA)>;
+			bias-disable; /* external pull-up */
+			input-enable;
+			input-schmitt-enable;
+		};
+	};
+
+	i2c2_pins: i2c2-0 {
+		i2c-pins {
+			pinmux = <GPIOMUX(3, GPOUT_LOW,
+					     GPOEN_SYS_I2C2_CLK,
+					     GPI_SYS_I2C2_CLK)>,
+				 <GPIOMUX(2, GPOUT_LOW,
+					     GPOEN_SYS_I2C2_DATA,
+					     GPI_SYS_I2C2_DATA)>;
+			bias-disable; /* external pull-up */
+			input-enable;
+			input-schmitt-enable;
+		};
+	};
+
+	i2c5_pins: i2c5-0 {
+		i2c-pins {
+			pinmux = <GPIOMUX(19, GPOUT_LOW,
+					      GPOEN_SYS_I2C5_CLK,
+					      GPI_SYS_I2C5_CLK)>,
+				 <GPIOMUX(20, GPOUT_LOW,
+					      GPOEN_SYS_I2C5_DATA,
+					      GPI_SYS_I2C5_DATA)>;
+			bias-disable; /* external pull-up */
+			input-enable;
+			input-schmitt-enable;
+		};
+	};
+
+	i2c6_pins: i2c6-0 {
+		i2c-pins {
+			pinmux = <GPIOMUX(16, GPOUT_LOW,
+					      GPOEN_SYS_I2C6_CLK,
+					      GPI_SYS_I2C6_CLK)>,
+				 <GPIOMUX(17, GPOUT_LOW,
+					      GPOEN_SYS_I2C6_DATA,
+					      GPI_SYS_I2C6_DATA)>;
+			bias-disable; /* external pull-up */
+			input-enable;
+			input-schmitt-enable;
+		};
+	};
+
+	mmc0_pins: mmc0-0 {
+		 rst-pins {
+			pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-pull-up;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		mmc-pins {
+			pinmux = <PINMUX(64, 0)>,
+				 <PINMUX(65, 0)>,
+				 <PINMUX(66, 0)>,
+				 <PINMUX(67, 0)>,
+				 <PINMUX(68, 0)>,
+				 <PINMUX(69, 0)>,
+				 <PINMUX(70, 0)>,
+				 <PINMUX(71, 0)>,
+				 <PINMUX(72, 0)>,
+				 <PINMUX(73, 0)>;
+			bias-pull-up;
+			drive-strength = <12>;
+			input-enable;
+		};
+	};
+
+	mmc1_pins: mmc1-0 {
+		clk-pins {
+			pinmux = <GPIOMUX(10, GPOUT_SYS_SDIO1_CLK,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-pull-up;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		mmc-pins {
+			pinmux = <GPIOMUX(9, GPOUT_SYS_SDIO1_CMD,
+					     GPOEN_SYS_SDIO1_CMD,
+					     GPI_SYS_SDIO1_CMD)>,
+				 <GPIOMUX(11, GPOUT_SYS_SDIO1_DATA0,
+					      GPOEN_SYS_SDIO1_DATA0,
+					      GPI_SYS_SDIO1_DATA0)>,
+				 <GPIOMUX(12, GPOUT_SYS_SDIO1_DATA1,
+					      GPOEN_SYS_SDIO1_DATA1,
+					      GPI_SYS_SDIO1_DATA1)>,
+				 <GPIOMUX(7, GPOUT_SYS_SDIO1_DATA2,
+					     GPOEN_SYS_SDIO1_DATA2,
+					     GPI_SYS_SDIO1_DATA2)>,
+				 <GPIOMUX(8, GPOUT_SYS_SDIO1_DATA3,
+					     GPOEN_SYS_SDIO1_DATA3,
+					     GPI_SYS_SDIO1_DATA3)>;
+			bias-pull-up;
+			drive-strength = <12>;
+			input-enable;
+			input-schmitt-enable;
+			slew-rate = <0>;
+		};
+	};
+
+	pwmdac_pins: pwmdac-0 {
+		pwmdac-pins {
+			pinmux = <GPIOMUX(33, GPOUT_SYS_PWMDAC_LEFT,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>,
+				 <GPIOMUX(34, GPOUT_SYS_PWMDAC_RIGHT,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			drive-strength = <2>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm_pins: pwm-0 {
+		pwm-pins {
+			pinmux = <GPIOMUX(46, GPOUT_SYS_PWM_CHANNEL0,
+					      GPOEN_SYS_PWM0_CHANNEL0,
+					      GPI_NONE)>,
+				 <GPIOMUX(59, GPOUT_SYS_PWM_CHANNEL1,
+					      GPOEN_SYS_PWM0_CHANNEL1,
+					      GPI_NONE)>;
+			bias-disable;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
+	spi0_pins: spi0-0 {
+		mosi-pins {
+			pinmux = <GPIOMUX(52, GPOUT_SYS_SPI0_TXD,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+		};
+
+		miso-pins {
+			pinmux = <GPIOMUX(53, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_SPI0_RXD)>;
+			bias-pull-up;
+			input-enable;
+			input-schmitt-enable;
+		};
+
+		sck-pins {
+			pinmux = <GPIOMUX(48, GPOUT_SYS_SPI0_CLK,
+					      GPOEN_ENABLE,
+					      GPI_SYS_SPI0_CLK)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+		};
+
+		ss-pins {
+			pinmux = <GPIOMUX(49, GPOUT_SYS_SPI0_FSS,
+					      GPOEN_ENABLE,
+					      GPI_SYS_SPI0_FSS)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+		};
+	};
+
+	uart0_pins: uart0-0 {
+		tx-pins {
+			pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
+					     GPOEN_ENABLE,
+					     GPI_NONE)>;
+			bias-disable;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		rx-pins {
+			pinmux = <GPIOMUX(6, GPOUT_LOW,
+					     GPOEN_DISABLE,
+					     GPI_SYS_UART0_RX)>;
+			bias-disable; /* external pull-up */
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-enable;
+			slew-rate = <0>;
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
+
+&usb0 {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&U74_1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&U74_2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&U74_3 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&U74_4 {
+	cpu-supply = <&vdd_cpu>;
+};
diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index e19f26628054..9d70f21c86fc 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -5,188 +5,11 @@
  */
 
 /dts-v1/;
-#include "jh7110.dtsi"
-#include "jh7110-pinfunc.h"
-#include <dt-bindings/gpio/gpio.h>
+#include "jh7110-common.dtsi"
 
 / {
 	aliases {
-		ethernet0 = &gmac0;
 		ethernet1 = &gmac1;
-		i2c0 = &i2c0;
-		i2c2 = &i2c2;
-		i2c5 = &i2c5;
-		i2c6 = &i2c6;
-		mmc0 = &mmc0;
-		mmc1 = &mmc1;
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x0 0x40000000 0x1 0x0>;
-	};
-
-	gpio-restart {
-		compatible = "gpio-restart";
-		gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
-		priority = <224>;
-	};
-
-	pwmdac_codec: audio-codec {
-		compatible = "linux,spdif-dit";
-		#sound-dai-cells = <0>;
-	};
-
-	sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "StarFive-PWMDAC-Sound-Card";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		simple-audio-card,dai-link@0 {
-			reg = <0>;
-			format = "left_j";
-			bitclock-master = <&sndcpu0>;
-			frame-master = <&sndcpu0>;
-
-			sndcpu0: cpu {
-				sound-dai = <&pwmdac>;
-			};
-
-			codec {
-				sound-dai = <&pwmdac_codec>;
-			};
-		};
-	};
-};
-
-&cpus {
-	timebase-frequency = <4000000>;
-};
-
-&dvp_clk {
-	clock-frequency = <74250000>;
-};
-
-&gmac0_rgmii_rxin {
-	clock-frequency = <125000000>;
-};
-
-&gmac0_rmii_refin {
-	clock-frequency = <50000000>;
-};
-
-&gmac1_rgmii_rxin {
-	clock-frequency = <125000000>;
-};
-
-&gmac1_rmii_refin {
-	clock-frequency = <50000000>;
-};
-
-&hdmitx0_pixelclk {
-	clock-frequency = <297000000>;
-};
-
-&i2srx_bclk_ext {
-	clock-frequency = <12288000>;
-};
-
-&i2srx_lrck_ext {
-	clock-frequency = <192000>;
-};
-
-&i2stx_bclk_ext {
-	clock-frequency = <12288000>;
-};
-
-&i2stx_lrck_ext {
-	clock-frequency = <192000>;
-};
-
-&mclk_ext {
-	clock-frequency = <12288000>;
-};
-
-&osc {
-	clock-frequency = <24000000>;
-};
-
-&rtc_osc {
-	clock-frequency = <32768>;
-};
-
-&tdm_ext {
-	clock-frequency = <49152000>;
-};
-
-&camss {
-	assigned-clocks = <&ispcrg JH7110_ISPCLK_DOM4_APB_FUNC>,
-			  <&ispcrg JH7110_ISPCLK_MIPI_RX0_PXL>;
-	assigned-clock-rates = <49500000>, <198000000>;
-	status = "okay";
-
-	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		port@0 {
-			reg = <0>;
-		};
-
-		port@1 {
-			reg = <1>;
-
-			camss_from_csi2rx: endpoint {
-				remote-endpoint = <&csi2rx_to_camss>;
-			};
-		};
-	};
-};
-
-&csi2rx {
-	assigned-clocks = <&ispcrg JH7110_ISPCLK_VIN_SYS>;
-	assigned-clock-rates = <297000000>;
-	status = "okay";
-
-	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		port@0 {
-			reg = <0>;
-
-			/* remote MIPI sensor endpoint */
-		};
-
-		port@1 {
-			reg = <1>;
-
-			csi2rx_to_camss: endpoint {
-				remote-endpoint = <&camss_from_csi2rx>;
-			};
-		};
-	};
-};
-
-&gmac0 {
-	phy-handle = <&phy0>;
-	phy-mode = "rgmii-id";
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "snps,dwmac-mdio";
-
-		phy0: ethernet-phy@0 {
-			reg = <0>;
-		};
 	};
 };
 
@@ -206,412 +29,6 @@ phy1: ethernet-phy@1 {
 	};
 };
 
-&i2c0 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <510>;
-	i2c-scl-falling-time-ns = <510>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
-	status = "okay";
-};
-
-&i2c2 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <510>;
-	i2c-scl-falling-time-ns = <510>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
-	status = "okay";
-};
-
-&i2c5 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <510>;
-	i2c-scl-falling-time-ns = <510>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c5_pins>;
-	status = "okay";
-
-	axp15060: pmic@36 {
-		compatible = "x-powers,axp15060";
-		reg = <0x36>;
-		interrupt-controller;
-		#interrupt-cells = <1>;
-
-		regulators {
-			vcc_3v3: dcdc1 {
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcc_3v3";
-			};
-
-			vdd_cpu: dcdc2 {
-				regulator-always-on;
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1540000>;
-				regulator-name = "vdd-cpu";
-			};
-
-			emmc_vdd: aldo4 {
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "emmc_vdd";
-			};
-		};
-	};
-};
-
-&i2c6 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <510>;
-	i2c-scl-falling-time-ns = <510>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c6_pins>;
-	status = "okay";
-};
-
 &mmc0 {
-	max-frequency = <100000000>;
-	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
-	assigned-clock-rates = <50000000>;
-	bus-width = <8>;
-	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
 	non-removable;
-	cap-mmc-hw-reset;
-	post-power-on-delay-ms = <200>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
-	vmmc-supply = <&vcc_3v3>;
-	vqmmc-supply = <&emmc_vdd>;
-	status = "okay";
-};
-
-&mmc1 {
-	max-frequency = <100000000>;
-	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
-	assigned-clock-rates = <50000000>;
-	bus-width = <4>;
-	no-sdio;
-	no-mmc;
-	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
-	disable-wp;
-	cap-sd-highspeed;
-	post-power-on-delay-ms = <200>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins>;
-	status = "okay";
-};
-
-&pwmdac {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pwmdac_pins>;
-	status = "okay";
-};
-
-&qspi {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	status = "okay";
-
-	nor_flash: flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		cdns,read-delay = <5>;
-		spi-max-frequency = <12000000>;
-		cdns,tshsl-ns = <1>;
-		cdns,tsd2d-ns = <1>;
-		cdns,tchsh-ns = <1>;
-		cdns,tslch-ns = <1>;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			spl@0 {
-				reg = <0x0 0x80000>;
-			};
-			uboot-env@f0000 {
-				reg = <0xf0000 0x10000>;
-			};
-			uboot@100000 {
-				reg = <0x100000 0x400000>;
-			};
-			reserved-data@600000 {
-				reg = <0x600000 0xa00000>;
-			};
-		};
-	};
-};
-
-&pwm {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pwm_pins>;
-	status = "okay";
-};
-
-&spi0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pins>;
-	status = "okay";
-
-	spi_dev0: spi@0 {
-		compatible = "rohm,dh2228fv";
-		reg = <0>;
-		spi-max-frequency = <10000000>;
-	};
-};
-
-&sysgpio {
-	i2c0_pins: i2c0-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(57, GPOUT_LOW,
-					      GPOEN_SYS_I2C0_CLK,
-					      GPI_SYS_I2C0_CLK)>,
-				 <GPIOMUX(58, GPOUT_LOW,
-					      GPOEN_SYS_I2C0_DATA,
-					      GPI_SYS_I2C0_DATA)>;
-			bias-disable; /* external pull-up */
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	i2c2_pins: i2c2-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(3, GPOUT_LOW,
-					     GPOEN_SYS_I2C2_CLK,
-					     GPI_SYS_I2C2_CLK)>,
-				 <GPIOMUX(2, GPOUT_LOW,
-					     GPOEN_SYS_I2C2_DATA,
-					     GPI_SYS_I2C2_DATA)>;
-			bias-disable; /* external pull-up */
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	i2c5_pins: i2c5-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(19, GPOUT_LOW,
-					      GPOEN_SYS_I2C5_CLK,
-					      GPI_SYS_I2C5_CLK)>,
-				 <GPIOMUX(20, GPOUT_LOW,
-					      GPOEN_SYS_I2C5_DATA,
-					      GPI_SYS_I2C5_DATA)>;
-			bias-disable; /* external pull-up */
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	i2c6_pins: i2c6-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(16, GPOUT_LOW,
-					      GPOEN_SYS_I2C6_CLK,
-					      GPI_SYS_I2C6_CLK)>,
-				 <GPIOMUX(17, GPOUT_LOW,
-					      GPOEN_SYS_I2C6_DATA,
-					      GPI_SYS_I2C6_DATA)>;
-			bias-disable; /* external pull-up */
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	mmc0_pins: mmc0-0 {
-		 rst-pins {
-			pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
-					      GPOEN_ENABLE,
-					      GPI_NONE)>;
-			bias-pull-up;
-			drive-strength = <12>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-
-		mmc-pins {
-			pinmux = <PINMUX(64, 0)>,
-				 <PINMUX(65, 0)>,
-				 <PINMUX(66, 0)>,
-				 <PINMUX(67, 0)>,
-				 <PINMUX(68, 0)>,
-				 <PINMUX(69, 0)>,
-				 <PINMUX(70, 0)>,
-				 <PINMUX(71, 0)>,
-				 <PINMUX(72, 0)>,
-				 <PINMUX(73, 0)>;
-			bias-pull-up;
-			drive-strength = <12>;
-			input-enable;
-		};
-	};
-
-	mmc1_pins: mmc1-0 {
-		clk-pins {
-			pinmux = <GPIOMUX(10, GPOUT_SYS_SDIO1_CLK,
-					      GPOEN_ENABLE,
-					      GPI_NONE)>;
-			bias-pull-up;
-			drive-strength = <12>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-
-		mmc-pins {
-			pinmux = <GPIOMUX(9, GPOUT_SYS_SDIO1_CMD,
-					     GPOEN_SYS_SDIO1_CMD,
-					     GPI_SYS_SDIO1_CMD)>,
-				 <GPIOMUX(11, GPOUT_SYS_SDIO1_DATA0,
-					      GPOEN_SYS_SDIO1_DATA0,
-					      GPI_SYS_SDIO1_DATA0)>,
-				 <GPIOMUX(12, GPOUT_SYS_SDIO1_DATA1,
-					      GPOEN_SYS_SDIO1_DATA1,
-					      GPI_SYS_SDIO1_DATA1)>,
-				 <GPIOMUX(7, GPOUT_SYS_SDIO1_DATA2,
-					     GPOEN_SYS_SDIO1_DATA2,
-					     GPI_SYS_SDIO1_DATA2)>,
-				 <GPIOMUX(8, GPOUT_SYS_SDIO1_DATA3,
-					     GPOEN_SYS_SDIO1_DATA3,
-					     GPI_SYS_SDIO1_DATA3)>;
-			bias-pull-up;
-			drive-strength = <12>;
-			input-enable;
-			input-schmitt-enable;
-			slew-rate = <0>;
-		};
-	};
-
-	pwmdac_pins: pwmdac-0 {
-		pwmdac-pins {
-			pinmux = <GPIOMUX(33, GPOUT_SYS_PWMDAC_LEFT,
-					      GPOEN_ENABLE,
-					      GPI_NONE)>,
-				 <GPIOMUX(34, GPOUT_SYS_PWMDAC_RIGHT,
-					      GPOEN_ENABLE,
-					      GPI_NONE)>;
-			bias-disable;
-			drive-strength = <2>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-	};
-
-	pwm_pins: pwm-0 {
-		pwm-pins {
-			pinmux = <GPIOMUX(46, GPOUT_SYS_PWM_CHANNEL0,
-					      GPOEN_SYS_PWM0_CHANNEL0,
-					      GPI_NONE)>,
-				 <GPIOMUX(59, GPOUT_SYS_PWM_CHANNEL1,
-					      GPOEN_SYS_PWM0_CHANNEL1,
-					      GPI_NONE)>;
-			bias-disable;
-			drive-strength = <12>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-	};
-
-	spi0_pins: spi0-0 {
-		mosi-pins {
-			pinmux = <GPIOMUX(52, GPOUT_SYS_SPI0_TXD,
-					      GPOEN_ENABLE,
-					      GPI_NONE)>;
-			bias-disable;
-			input-disable;
-			input-schmitt-disable;
-		};
-
-		miso-pins {
-			pinmux = <GPIOMUX(53, GPOUT_LOW,
-					      GPOEN_DISABLE,
-					      GPI_SYS_SPI0_RXD)>;
-			bias-pull-up;
-			input-enable;
-			input-schmitt-enable;
-		};
-
-		sck-pins {
-			pinmux = <GPIOMUX(48, GPOUT_SYS_SPI0_CLK,
-					      GPOEN_ENABLE,
-					      GPI_SYS_SPI0_CLK)>;
-			bias-disable;
-			input-disable;
-			input-schmitt-disable;
-		};
-
-		ss-pins {
-			pinmux = <GPIOMUX(49, GPOUT_SYS_SPI0_FSS,
-					      GPOEN_ENABLE,
-					      GPI_SYS_SPI0_FSS)>;
-			bias-disable;
-			input-disable;
-			input-schmitt-disable;
-		};
-	};
-
-	uart0_pins: uart0-0 {
-		tx-pins {
-			pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
-					     GPOEN_ENABLE,
-					     GPI_NONE)>;
-			bias-disable;
-			drive-strength = <12>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-
-		rx-pins {
-			pinmux = <GPIOMUX(6, GPOUT_LOW,
-					     GPOEN_DISABLE,
-					     GPI_SYS_UART0_RX)>;
-			bias-disable; /* external pull-up */
-			drive-strength = <2>;
-			input-enable;
-			input-schmitt-enable;
-			slew-rate = <0>;
-		};
-	};
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins>;
-	status = "okay";
-};
-
-&usb0 {
-	dr_mode = "peripheral";
-	status = "okay";
-};
-
-&U74_1 {
-	cpu-supply = <&vdd_cpu>;
-};
-
-&U74_2 {
-	cpu-supply = <&vdd_cpu>;
-};
-
-&U74_3 {
-	cpu-supply = <&vdd_cpu>;
-};
-
-&U74_4 {
-	cpu-supply = <&vdd_cpu>;
 };
-- 
2.43.0


