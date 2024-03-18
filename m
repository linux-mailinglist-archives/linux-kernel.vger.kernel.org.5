Return-Path: <linux-kernel+bounces-106084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4785187E8C8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9421F23C21
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D048E374FB;
	Mon, 18 Mar 2024 11:43:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15609364DA;
	Mon, 18 Mar 2024 11:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762184; cv=none; b=p07gQu7OfSPOVpmvJM9tPcYFgP0iWqGLkrMfyDP157cBA71aHjWTuFrXWtbVo8FdgF9wLjDwsOurRrmadSXYIXELwXfB0l413Z1ZVCmMKnTojIT4Vh0kkmbj0zaVACP/YK5xufb4lwHyAXyOFCi76pkCGfKQGwJQbDzPQgTGj+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762184; c=relaxed/simple;
	bh=u3IBIGiwMrtIsxvZh/YvI9+XCRfa0ixwSyRVrL93rCc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCuy+Ow3hPqvr9+PAflr8Ku9USxqboti5KgFoAaJIEGEAkNoowUral862WRMPVF2E8Xog+P+JXinpX+S3eFqAsbhTZ/3sEyeRoFZ89ErLpLqFH56CAxcNJZGR676pkuojbASPh/KmkLe/xBMxeNeeRaYUMocmVISA1vOB3AhPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B7C1DA7;
	Mon, 18 Mar 2024 04:43:36 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E73D23F762;
	Mon, 18 Mar 2024 04:42:59 -0700 (PDT)
Date: Mon, 18 Mar 2024 11:42:57 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Kamil Kasperski <ressetkk@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 3/3] arm64: dts: allwinner: h616: add support for T95
 tv boxes
Message-ID: <20240318114257.46667aef@donnerap.manchester.arm.com>
In-Reply-To: <20240317-add-t95-axp313-support-v3-3-0d63f7c23d37@gmail.com>
References: <20240317-add-t95-axp313-support-v3-0-0d63f7c23d37@gmail.com>
	<20240317-add-t95-axp313-support-v3-3-0d63f7c23d37@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Mar 2024 20:44:51 +0100
Kamil Kasperski <ressetkk@gmail.com> wrote:

Hi Kamil,

thanks a lot for putting together those patches and sending them
for upstream inclusion!

> Add dtsi file for T95 tv boxes and add initial support for T95 5G AXP313A
> variant with a board name H616-T95MAX-AXP313A-v3.0 Internal storage is not
> accessible due to lack of support for H616 NAND controller.

Them using raw NAND is really unfortunate. I think the original T95 box
used eMMC?

> 
> Signed-off-by: Kamil Kasperski <ressetkk@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
>  arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi | 109 +++++++++++++++++++++
>  .../dts/allwinner/sun50i-h616-t95max-axp313.dts    |  85 ++++++++++++++++
>  3 files changed, 195 insertions(+)
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
> index 000000000000..815cf2dac24b
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
> +	wifi_pwrseq: wifi-pwrseq {

Krzysztof recently sent a patch to just use "pwrseq" as the node name,
so can you do the same here?

https://lore.kernel.org/linux-sunxi/20240317184130.157695-2-krzysztof.kozlowski@linaro.org/T/#u

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

So does the WiFi work with mainline drivers? IIUC the BCM43342 is not
supported by the existing Broadcom drivers?

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

Similar question here, what is the Bluetooth situation in mainline? I
guess it's not supported, since you didn't put a BT node in here?

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
> index 000000000000..c8650aca2407
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95max-axp313.dts
> @@ -0,0 +1,85 @@
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
> +		interrupt-parent = <&pio>;

I don't think you need interrupt-parent unless you also actually specify
an interrupt line.
(But please keep #interrupt-cells and interrupt-controller.)

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
> +	vcc-pg-supply = <&reg_dldo1>;

So if vqmmc-supply for MMC1 is at the 1.8V from ALDO1, that must mean that
the whole of PortG is at 1.8V, right? So I think this would need to be
reg_aldo1 here.

Apart from those minor things it looks good to me.

Cheers,
Andre

> +	vcc-ph-supply = <&reg_dldo1>;
> +	vcc-pi-supply = <&reg_dldo1>;
> +};
> 

