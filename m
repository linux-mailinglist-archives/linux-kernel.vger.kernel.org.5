Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665AC76E871
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbjHCMiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjHCMhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:37:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE4392D42;
        Thu,  3 Aug 2023 05:37:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BFE6113E;
        Thu,  3 Aug 2023 05:38:35 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29FDD3F6C4;
        Thu,  3 Aug 2023 05:37:49 -0700 (PDT)
Date:   Thu, 3 Aug 2023 13:37:46 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Martin Botka <martin@biqu3d.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/6] arm64: dts: allwinner: h616: Add BigTreeTech CB1
 SoM & boards support
Message-ID: <20230803133746.20cd7b04@donnerap.manchester.arm.com>
In-Reply-To: <85E425AED000D34C+20230802220309.163804-6-martin@biqu3d.com>
References: <20230802220309.163804-1-martin@biqu3d.com>
        <85E425AED000D34C+20230802220309.163804-6-martin@biqu3d.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Aug 2023 00:02:38 +0200
Martin Botka <martin@biqu3d.com> wrote:

Hi Martin,

thanks for sending this!
There are some whitespace errors in here, some leading tabs in the first
section. "git show" should print them in red.

> From: Martin Botka <martin.botka@somainline.org>
> 
> CB1 is Compute Module style board that plugs into Rpi board style adapter or
> Manta 3D printer boards (M4P/M8P).
> 
> The SoM features:
>   - H616 SoC
>   - 1GiB of RAM
>   - AXP313A PMIC
>   - RTL8189FTV WiFi
> 
> Boards feature:
>   - 4x USB via USB2 hub (usb1 on SoM).
>   - SDcard slot for loading images.
>   - Ethernet port wired to the internal PHY. (100M)
>   - 2x HDMI 2.0. (Only 1 usable on CB1)
>   - Power and Status LEDs. (Only Status LED usable on CB1)
>   - 40 pin GPIO header
> 
> Currently working:
>   - Booting
>   - USB
>   - UART
>   - MMC
>   - Status LED
>   - WiFi (RTL8189FS via out of tree driver)
> 
> I didnt want to duplicate things so the manta DTS can also be used on BTT pi4b adapter.
> CB1 SoM has its own DTSI file in case other boards shows up that accept this SoM.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../sun50i-h616-bigtreetech-cb1-manta.dts     |  20 +++
>  .../sun50i-h616-bigtreetech-cb1.dtsi          | 164 ++++++++++++++++++
>  3 files changed, 185 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> index 6a96494a2e0a..7b386428510b 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -38,5 +38,6 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-manta.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
> new file mode 100644
> index 000000000000..dff5b592a97a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2023 Martin Botka <martin.botka@somainline.org>.
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616-bigtreetech-cb1.dtsi"
> +
> +/ {
> +	compatible = "bigtreetech,cb1-manta", "bigtreetech,cb1", "allwinner,sun50i-h616";
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&ohci1 {
> +	status = "okay";
> +};

So how is the STM32 connected? Via SPI? If yes, you should activate the SPI
node and specify the pinctrl.
Even if this requires a patch cable to connect the SPI header coming from
the CB1 to the SPI pins on the STM (does it?), it might be worth stating
the pins used. I don't know for sure if we enable interfaces that are
routed to fixed function header pins, but it might be worth doing so here,
since this is some very obvious use case (I guess you wouldn't buy the M8P
if you don't plan to use all of its goodies).

And what's the USB-C connector doing? Is that an alternative power supply?
Ann does it connect the port0 D-/D+ pins, so can be used for OTG? If yes,
please enable the usb_otg node here.

> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
> new file mode 100644
> index 000000000000..e630114f0ce4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
> @@ -0,0 +1,164 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2023 Martin Botka <martin.botka@somainline.org>.
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model = "BigTreeTech CB1";
> +	compatible = "bigtreetech,cb1", "allwinner,sun50i-h616";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		ethernet0 = &rtl8189ftv;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};

I think stdout-path belongs into the board .dts.

> +	
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
> +		};
> +	};
> +
> +	reg_vcc5v: regulator-vcc5v {
> +		/* board wide 5V supply directly from the USB-C socket */

I guess this "regulator" is still valid, but please adjust the comment,
since there is certainly no USB-C socket on the SoM. I guess it's multiple
pins on the SoM connector that supply the incoming base voltage?

> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_usb1_vbus: regulator-usb1-vbus {

So is this regulator really on the SoM? Or is it just PC16 on the SoM
connector, and the actual regulator chip is on the respective carrier
boards?

> +		compatible = "regulator-fixed";
> +		regulator-name = "usb1-vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&reg_vcc5v>;
> +		enable-active-high;
> +		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>; /* PC16 */
> +	};
> +	
> +	reg_vcc33_wifi: vcc33-wifi {
> +		/* Always on 3.3V regulator for WiFi and BT */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc33-wifi";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		vin-supply = <&reg_vcc5v>;
> +	};
> +	
> +	reg_vcc_wifi_io: vcc-wifi-io {
> +		/* Always on 1.8V/300mA regulator for WiFi and BT IO */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-wifi-io";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		vin-supply = <&reg_vcc33_wifi>;
> +	};
> +
> +	wifi_pwrseq: wifi-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		clocks = <&rtc 1>;
> +		clock-names = "ext_clock";
> +		reset-gpios = <&pio 6 18 GPIO_ACTIVE_LOW>;  /* PG18 */
> +		post-power-on-delay-ms = <200>;
> +	};
> +};
> +
> +&mmc0 {
> +	vmmc-supply = <&reg_dldo1>;
> +	broken-cd;

Is there no card detect switch or is it not wired up, or is it really
"broken"? Might be good to have a comment explaining that.
And yeah, I also forgot to do this in my Orange Pi Zero3 .dts ;-)

> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&mmc1 {
> +	vmmc-supply = <&reg_vcc33_wifi>;
> +	vqmmc-supply = <&reg_vcc_wifi_io>;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	bus-width = <4>;
> +	non-removable;
> +	mmc-ddr-1_8v;
> +	status = "okay";
> +
> +	rtl8189ftv: sdio_wifi@1 {
> +		reg = <1>;
> +	};
> +};
> +
> +&r_i2c {
> +	status = "okay";
> +
> +	axp313a: pmic@36 {
> +		compatible = "x-powers,axp313a";
> +		reg = <0x36>;
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +
> +		regulators{
> +			reg_dcdc1: dcdc1 {
> +				regulator-name = "vdd-gpu";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <3400000>;

So those are the ranges of the PMIC rail, but if this is really connected
to VDD_GPU on the H616, you should limit it to between 0.81V and 0.99V, as
described in the H616 datasheet. Otherwise this risks frying the SoC, I
guess.

> +				regulator-always-on;

So is this connected to something else as well, like VDD_SYS? Please
either mention this as a comment, to justify the always-on, or name the
regulator accordingly, like "vdd-gpu-sys".
 
> +			};
> +
> +			reg_dcdc2: dcdc2 {
> +				regulator-name = "vdd-cpu";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1540000>;

Same limit problem here, VDD_CPU must be between 0.81V and 1.1V.

> +				regulator-ramp-delay = <200>;
> +				regulator-always-on;
> +			};
> +
> +			reg_dcdc3: dcdc3 {
> +				regulator-name = "vcc-dram";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1840000>;

Is that DDR3 or DDR3L DRAM here? I don't think there is any runtime
adjustments here, so just specify the respective voltage required, with the
same value for both min and max.

> +				regulator-always-on;
> +			};
> +
> +			reg_aldo1: aldo1 {
> +				regulator-name = "vcc-1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;

Please mention what this supplies that justifies always-on.

> +			};
> +
> +			reg_dldo1: dldo1 {
> +				regulator-name = "vcc-3v3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;

Please mention what this supplies that justifies always-on.

> +			};
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_ph_pins>;
> +	status = "okay";
> +};

This belongs into the board .dts, since the connector/UART bridge is
there.

Cheers,
Andre

> +
> +&usbphy {
> +	usb1_vbus-supply = <&reg_usb1_vbus>;
> +	status = "okay";
> +};

