Return-Path: <linux-kernel+bounces-108230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03DA880823
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479E31F22C41
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1975FB8E;
	Tue, 19 Mar 2024 23:23:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EF840862;
	Tue, 19 Mar 2024 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710890590; cv=none; b=SLDBYAmmMqNC40hkq5fxddUc68nyTBdWjNm5fRXj8pRjuae8GUP7NxmJ+tUJntyRkf0nSw7NLfODxarYJN3Ub4evYd7Ad+IuegpMbAuBDhOfb2/95ZquLN4WknGpVaEqGDrty5Bt02S9pF1EJzFJwU3K6okHCEJm452kixqO6T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710890590; c=relaxed/simple;
	bh=yrlZMq/8a6OpqwAjP+SPbR0zmWdd7MeQKJCj93VHfLU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xao9wYSmkERbbSkP12wl3l7hac0+1EYsKhPrtNvzC4lHCgDjItqjYcaWmIKvw84wG5RL2iBPvfjKN4cDvzjrT6OlAV9m/XSBnIRjTtEjgLUNPzMtfncToAYzHe0WuQh0NlXrosgPyw1PECC5LPOZVAUJ/xK4sTSADJWxna3LkNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 614F2106F;
	Tue, 19 Mar 2024 16:23:36 -0700 (PDT)
Received: from minigeek.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E4263F67D;
	Tue, 19 Mar 2024 16:22:59 -0700 (PDT)
Date: Tue, 19 Mar 2024 23:22:36 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Kamil Kasperski <ressetkk@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 3/3] arm64: dts: allwinner: h616: add support for T95
 tv boxes
Message-ID: <20240319232236.07007592@minigeek.lan>
In-Reply-To: <20240319-add-t95-axp313-support-v4-3-6204b6d23229@gmail.com>
References: <20240319-add-t95-axp313-support-v4-0-6204b6d23229@gmail.com>
	<20240319-add-t95-axp313-support-v4-3-6204b6d23229@gmail.com>
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

On Tue, 19 Mar 2024 18:50:24 +0100
Kamil Kasperski <ressetkk@gmail.com> wrote:

Hi Kamil,

> Add dtsi file for T95 tv boxes and add initial support for T95 5G AXP313A
> variant with a board name H616-T95MAX-AXP313A-v3.0 Internal storage is not
> accessible due to lack of support for H616 NAND controller.
> 
> Signed-off-by: Kamil Kasperski <ressetkk@gmail.com>

thanks for the changes, looks good now, although a bit minimal ;-)

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Please can you wait till the -rc1 release on Sunday, and send a rebased
version next week? There is a small merge conflict in the dts Makefile
as of now.

Cheers,
Andre


> ---
>  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
>  arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi | 109 +++++++++++++++++++++
>  .../dts/allwinner/sun50i-h616-t95max-axp313.dts    |  84 ++++++++++++++++
>  3 files changed, 194 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> index 21149b346a60..294921f12b73 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -42,6 +42,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-manta.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-pi.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-t95max-axp313.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-longanpi-3h.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-orangepi-zero2w.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi
> new file mode 100644
> index 000000000000..4c02408733bc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2024 Kamil Kasperski <ressetkk@gmail.com>
> + *
> + * Common DT nodes for H616-based T95 TV boxes
> + * There are two versions reported with different PMIC variants.
> + */
> +
> +#include "sun50i-h616.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	aliases {
> +		ethernet1 = &sdio_wifi;
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	reg_vcc5v: vcc5v {
> +		/* board wide 5V supply directly from the DC input */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_vcc3v3: vcc3v3 {
> +		/* discrete 3.3V regulator */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	wifi_pwrseq: pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		clocks = <&rtc CLK_OSC32K_FANOUT>;
> +		clock-names = "ext_clock";
> +		pinctrl-0 = <&x32clk_fanout_pin>;
> +		pinctrl-names = "default";
> +		reset-gpios = <&pio 6 18 GPIO_ACTIVE_LOW>; /* PG18 */
> +	};
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ehci2 {
> +	status = "okay";
> +};
> +
> +&ir {
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	cd-gpios = <&pio 8 16 GPIO_ACTIVE_LOW>;	/* PI16 */
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&mmc1 {
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	bus-width = <4>;
> +	non-removable;
> +	status = "okay";
> +
> +	sdio_wifi: wifi@1 {
> +		reg = <1>;
> +	};
> +};
> +
> +&ohci0 {
> +	status = "okay";
> +};
> +
> +&ohci2 {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_ph_pins>;
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	dr_mode = "host";	/* USB A type receptable */
> +	status = "okay";
> +};
> +
> +&usbphy {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-t95max-axp313.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95max-axp313.dts
> new file mode 100644
> index 000000000000..08a6b4fcc235
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95max-axp313.dts
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2024 Kamil Kasperski <ressetkk@gmail.com>
> + *
> + * Configuration for T95 TV box with board label H616-T95MAX-AXP313A-v3.0
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616-t95.dtsi"
> +
> +/ {
> +	model = "T95 5G (AXP313)";
> +	compatible = "t95,t95max-axp313", "allwinner,sun50i-h616";
> +};
> +
> +&mmc0 {
> +	vmmc-supply = <&reg_dldo1>;
> +};
> +
> +&mmc1 {
> +	vmmc-supply = <&reg_dldo1>;
> +	vqmmc-supply = <&reg_aldo1>;
> +};
> +
> +&r_i2c {
> +	status = "okay";
> +
> +	axp313: pmic@36 {
> +		compatible = "x-powers,axp313a";
> +		reg = <0x36>;
> +		#interrupt-cells = <1>;
> +		interrupt-controller;
> +
> +		vin1-supply = <&reg_vcc5v>;
> +		vin2-supply = <&reg_vcc5v>;
> +		vin3-supply = <&reg_vcc5v>;
> +
> +		regulators {
> +			reg_aldo1: aldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc1v8";
> +			};
> +
> +			reg_dldo1: dldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc3v3";
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
> +		};
> +	};
> +};
> +
> +&pio {
> +	vcc-pc-supply = <&reg_aldo1>;
> +	vcc-pf-supply = <&reg_dldo1>;
> +	vcc-pg-supply = <&reg_aldo1>;
> +	vcc-ph-supply = <&reg_dldo1>;
> +	vcc-pi-supply = <&reg_dldo1>;
> +};
> 


