Return-Path: <linux-kernel+bounces-13293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FD582031B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 01:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE8B3B22425
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 00:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E262800;
	Sat, 30 Dec 2023 00:06:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C4BEA8;
	Sat, 30 Dec 2023 00:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EDBF2F4;
	Fri, 29 Dec 2023 15:56:56 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D92EF3F641;
	Fri, 29 Dec 2023 15:56:07 -0800 (PST)
Date: Fri, 29 Dec 2023 23:55:43 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Icenowy Zheng <uwu@icenowy.me>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: h616: Add Sipeed Longan SoM
 3H and Pi 3H board support
Message-ID: <20231229235543.7548cafa@minigeek.lan>
In-Reply-To: <20231228145647.1470-3-jszhang@kernel.org>
References: <20231228145647.1470-1-jszhang@kernel.org>
	<20231228145647.1470-3-jszhang@kernel.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Dec 2023 22:56:47 +0800
Jisheng Zhang <jszhang@kernel.org> wrote:

Hi,

> The Sipeed Longan SoM 3H is a system on module based on the Allwinner
> H618 SoC. The SoM features:
> 
> - Four ARM Cortex-A53 cores, Mali-G31 MP2 GPU
> - 2/4 GiB LPDDR4 DRAM SoMs
> - AXP313a PMIC
> - eMMC
> 
> The Sipeed Longan PI 3H is a development board based on the above SoM.
> The board features:
> - Longan SoM 3H
> - Raspberry-Pi-1 compatible GPIO header
> - 2 USB 2.0 host port
> - 1 USB 2.0 type C port (power supply + OTG)
> - MicroSD slot
> - 1Gbps Ethernet port (via RTL8211 PHY)
> - HDMI port
> - WiFi/BT chip
> 
> Add the devicetree file describing the currently supported features,
> namely PMIC, LEDs, UART, SD card, eMMC, USB and Ethernet.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../sun50i-h618-longan-module-3h.dtsi         |  82 +++++++++++
>  .../dts/allwinner/sun50i-h618-longanpi-3h.dts | 133 ++++++++++++++++++
>  3 files changed, 216 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> index 3aca6787a167..00db504a9b8c 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -42,4 +42,5 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-manta.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-pi.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-longanpi-3h.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-orangepi-zero3.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
> new file mode 100644
> index 000000000000..88a7d287b73c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +/dts-v1/;

I don't see how the SoM could be used on its own, without a hosting
board. So we don't need the dts version tag in the .dtsi, that would
just be double when we are going to compile any actual .dtb.

> +
> +#include "sun50i-h616.dtsi"
> +
> +/ {
> +	model = "Sipeed Longan Module 3H";
> +	compatible = "sipeed,longan-module-3h", "allwinner,sun50i-h618";

Same here, any model or compatible string would only be overwritten by
the board versions, so you don't need those two in the SoM .dtsi.
Compare the SoPine and BTT CB1 .dtsi files.

> +};
> +
> +&mmc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc2_pins>;

Can you please add the DS pin here? At the moment the sunxi Linux
driver doesn't support HS-400, but that can a) change and b) doesn't
affect the DT anyway, since that describes the hardware. The connection
is definitely there, according to the schematics.

> +	vmmc-supply = <&reg_dldo1>;
> +	vqmmc-supply = <&reg_aldo1>;
> +	bus-width = <8>;
> +	non-removable;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	status = "okay";
> +};
> +
> +&r_i2c {
> +	status = "okay";
> +
> +	axp313: pmic@36 {
> +		compatible = "x-powers,axp313a";

According to the bindings you need:

	interrupt-controller;
	#interrupt-cells = <1>;

Even without the IRQ line connected. dt-validate complains about that.

Actually, do you know of any reason why it is not connected? I see it on
the SoM pins, is the idea that any *board* could dedicate a GPIO pin for
it, if needed?

> +		reg = <0x36>;
> +
> +		regulators {
> +			/* Supplies VCC-PLL, so needs to be always on. */
> +			reg_aldo1: aldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc1v8";

Can you please use "vcc-1v8-pll" instead? Then you don't need the
comment.

> +			};
> +
> +			/* Supplies VCC-IO, so needs to be always on. */
> +			reg_dldo1: dldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc3v3";

Same here, "vcc-3v3-io" is the name we used lately, to avoid the
comment.

> +			};
> +
> +			reg_dcdc1: dcdc1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <810000>;
> +				regulator-max-microvolt = <990000>;
> +				regulator-name = "vdd-gpu-sys";
> +			};
> +
> +			reg_dcdc2: dcdc2 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <810000>;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-name = "vdd-cpu";
> +			};
> +
> +			reg_dcdc3: dcdc3 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-name = "vdd-dram";
> +			};
> +		};
> +	};
> +};
> +
> +&pio {
> +	vcc-pc-supply = <&reg_dldo1>;
> +	vcc-pf-supply = <&reg_dldo1>;
> +	vcc-pg-supply = <&reg_aldo1>;
> +	vcc-ph-supply = <&reg_dldo1>;
> +	vcc-pi-supply = <&reg_dldo1>;
> +};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts
> new file mode 100644
> index 000000000000..245583881549
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h618-longan-module-3h.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model = "Sipeed Longan Pi 3H";
> +	compatible = "sipeed,longan-pi-3h", "sipeed,longan-module-3h", "allwinner,sun50i-h618";
> +
> +	aliases {
> +		ethernet0 = &emac0;
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			color = <LED_COLOR_ID_ORANGE>;
> +			function = LED_FUNCTION_INDICATOR;
> +			function-enumerator = <0>;
> +			gpios = <&pio 6 2 GPIO_ACTIVE_LOW>; /* PG2 */
> +		};
> +
> +		led-1 {
> +			color = <LED_COLOR_ID_ORANGE>;
> +			function = LED_FUNCTION_INDICATOR;
> +			function-enumerator = <1>;
> +			gpios = <&pio 6 4 GPIO_ACTIVE_LOW>; /* PG4 */
> +		};
> +	};
> +
> +	reg_vcc5v: vcc5v {
> +		/* board wide 5V supply directly from the USB-C socket */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};

According to the schematic, there is a discrete 5V->3.3V regulator, can
you please describe this here as well?

> +};
> +
> +&axp313 {
> +	vin1-supply = <&reg_vcc5v>;
> +	vin2-supply = <&reg_vcc5v>;
> +	vin3-supply = <&reg_vcc5v>;
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&ohci1 {
> +	status = "okay";
> +};
> +
> +&ehci2 {
> +	status = "okay";
> +};
> +
> +&ohci2 {
> +	status = "okay";
> +};
> +

Maybe worth adding a comment here that there is a USB WiFi chip
connected to those pins.

> +&ehci3 {
> +	status = "okay";
> +};
> +
> +&ohci3 {
> +	status = "okay";
> +};
> +
> +&emac0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ext_rgmii_pins>;
> +	phy-mode = "rgmii";
> +	phy-handle = <&ext_rgmii_phy>;
> +	allwinner,rx-delay-ps = <3100>;
> +	allwinner,tx-delay-ps = <700>;
> +	phy-supply = <&reg_dldo1>;

If I get the schematic correctly, the PHY is powered from the discrete
3.3V regulator? In fact, the 3V3-DLDO-OUT/1V8-ALDO-OUT pins on the SoM
do not seem to be connected, so anything using 3.3V or 1.8V on the
board needs to be fed from this regulator, and everything on the SoM is
supplied by the AXP?

> +	status = "okay";
> +};
> +
> +&mdio0 {
> +	ext_rgmii_phy: ethernet-phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <1>;
> +	};
> +};
> +
> +&mmc0 {
> +	bus-width = <4>;
> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;	/* PF6 */
> +	vmmc-supply = <&reg_dldo1>;

According to the schematic, the SD card is supplied by the discrete
3.3V regulator on the board.

> +	status = "okay";
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	/*
> +	 * PHY0 pins are connected to a USB-C socket, but a role switch
> +	 * is not implemented: both CC pins are pulled to GND.
> +	 * The VBUS pins power the device, so a fixed peripheral mode
> +	 * is the best choice.
> +	 * The board can be powered via GPIOs, in this case port0 *can*
> +	 * act as a host (with a cable/adapter ignoring CC), as VBUS is
> +	 * then provided by the GPIOs. Any user of this setup would
> +	 * need to adjust the DT accordingly: dr_mode set to "host",
> +	 * enabling OHCI0 and EHCI0.
> +	 */
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> +
> +&usbphy {
> +	usb1_vbus-supply = <&reg_vcc5v>;

The same seems to be true for USB2 as well, and the WiFi chip on USB3 is
powered by the discrete 3.3V regulator. But I think we don't need these
properties at all if it's directly connected to the input and so always
powered. Or maybe we should do this anyway, and be it to make it clear
where the bus power is coming from?

Cheers,
Andre

P.S. I saw some U-Boot patches on some github. Most of them are
merged, but feel free to post the DT (same ones as here) and the
defconfig to the U-Boot list as well. You can use "make savedefconfig"
when you have configured the board, this will create a file "defconfig"
in the build directory that contains the minimal items, this can be
directly used as a defconfig.

> +	status = "okay";
> +};


