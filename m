Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D797660C1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjG1A3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjG1A3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:29:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 514A1E75;
        Thu, 27 Jul 2023 17:29:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 102D02F4;
        Thu, 27 Jul 2023 17:29:47 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6725A3F5A1;
        Thu, 27 Jul 2023 17:29:02 -0700 (PDT)
Date:   Fri, 28 Jul 2023 01:27:57 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Matthew Croughan <matthew.croughan@nix.how>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] arm64: dts: allwinner: h616: Add Mango Pi
 MQ-Quad DTS
Message-ID: <20230728012757.25062cf5@slackpad.lan>
In-Reply-To: <20230719172551.3248166-2-matthew.croughan@nix.how>
References: <20230719172551.3248166-1-matthew.croughan@nix.how>
        <20230719172551.3248166-2-matthew.croughan@nix.how>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Wed, 19 Jul 2023 18:25:39 +0100
Matthew Croughan <matthew.croughan@nix.how> wrote:

Hi Matthew,

thanks for the changes, looks much better now. Something left:

> Mango Pi MQ Quad is a H616 based SBC, add basic support for the board
> and its peripherals
> 
> Signed-off-by: Matthew Croughan <matthew.croughan@nix.how>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../allwinner/sun50i-h616-mangopi-mq-quad.dts | 183 ++++++++++++++++++
>  2 files changed, 184 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-mangopi-mq-quad.dts
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> index 6a96494a2e0a..06c5b97dbfc3 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -38,5 +38,6 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-mangopi-mq-quad.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-mangopi-mq-quad.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-mangopi-mq-quad.dts
> new file mode 100644
> index 000000000000..dc1b88e0adae
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-mangopi-mq-quad.dts
> @@ -0,0 +1,183 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> + * Copyright (C) 2020 Arm Ltd.
> + *
> + * Copyright (C) 2023 Matthew Croughan <matthew.croughan@nix.how>
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
> +	model = "MangoPi MQ-Quad";
> +	compatible = "widora,mangopi-mq-quad", "allwinner,sun50i-h616";
> +
> +	aliases {
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
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&pio 2 13 GPIO_ACTIVE_HIGH>; /* PC13 */
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
> +
> +	reg_vcc3v3: vcc3v3 {
> +		/* board wide 3V3 supply directly from SY8008 regulator */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	wifi_pwrseq: wifi-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&pio 6 18 GPIO_ACTIVE_LOW>; /* PG18 */
> +	};
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&pio {
> +	vcc-pc-supply = <&reg_vcc3v3>;
> +	vcc-pg-supply = <&reg_vcc3v3>;
> +	vcc-pi-supply = <&reg_vcc3v3>;
> +};
> +
> +/* USB 2 & 3 are on headers only. */
> +
> +&mmc0 {
> +	vmmc-supply = <&reg_vcc3v3>;
> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&mmc1 {
> +	bus-width = <4>;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	non-removable;
> +	vmmc-supply = <&reg_vcc3v3>;
> +	vqmmc-supply = <&reg_vcc3v3>;
> +	pinctrl-0 = <&mmc1_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	rtl8723ds: wifi@1 {
> +		reg = <1>;
> +		interrupt-parent = <&pio>;
> +		interrupts = <6 15 IRQ_TYPE_LEVEL_LOW>; /* PG15 */
> +		interrupt-names = "host-wake";
> +	};
> +};
> +
> +
> +&uart1 {
> +	uart-has-rtscts;
> +	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "realtek,rtl8723ds-bt";
> +		device-wake-gpios = <&pio 6 17 GPIO_ACTIVE_HIGH>; /* PG17 */
> +		enable-gpios = <&pio 6 19 GPIO_ACTIVE_HIGH>; /* PG19 */
> +		host-wake-gpios = <&pio 6 16 GPIO_ACTIVE_HIGH>; /* PG16 */
> +	};
> +};
> +
> +&ohci1 {
> +	status = "okay";
> +};
> +
> +&r_i2c {
> +	status = "okay";
> +
> +	axp313a: pmic@36 {
> +		compatible = "x-powers,axp313a";
> +		reg = <0x36>;

dt-validate complains that the interrupt (and the two related
properties "interrupt-controller;" and "#interrupt-cells" is missing.
The schematic assigns the net name "IRQ" to the PMIC's IRQ pin, but
doesn't reference this anywhere. Do you know if the IRQ pin is
connected to some SoC GPIO? Does the BSP code give some hint?
If the IRQ pin is not connected, we should fix the binding to mark this
for the AXP313 optional as well.

> +    /* ALDO1 is feeding both VCC-PLL and VCC-DCXO, always-on is required,
> +     * as removing power would cut the 1.8v supply for the RAM */

Please move this comment down, just before reg_aldo1, and also align it
horizontally with this line. And use the proper multi-line commenting
style, with puts both "/*" and "*/" on a line of their own.

Otherwise the patch looks good, thanks for fixing the issues I
mentioned last time.

Cheers,
Andre

> +		regulators {
> +			reg_aldo1: aldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc-1v8";
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
> +				regulator-min-microvolt = <1500000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-name = "vdd-dram";
> +			};
> +
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_ph_pins>;
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
> +	status = "okay";
> +};

