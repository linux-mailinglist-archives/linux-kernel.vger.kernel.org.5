Return-Path: <linux-kernel+bounces-62178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88105851CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141572847FA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF59C3FE2B;
	Mon, 12 Feb 2024 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="YEasuRxn"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DB340BE0;
	Mon, 12 Feb 2024 18:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762537; cv=none; b=fRlQxaLWsMgaz8ziZSWR2HAIHnzpfF7hsTp2aH10m2jSOC7fnpp/hgOP9021WhXiJkXt8XbiuEoB8FKcyhfPm5Q2MKmYXV2ecYDoxwAvvVAtgVQjRb3i+QgccAet/NWoXItnLv6HwY3zP9vdDsYEZmAwHp4cmYiL4OFY0KQKCzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762537; c=relaxed/simple;
	bh=LpudjD+lpuCqBJajm53UPKdQDRtAnUxmuetQzRE+AQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mM9LfZlP4SySzSsSmRubwYejKRE9zhG3nJhxAfU+F5Nl1E1TDr16a6r201V05Ez1TCytrUTPLRbys+CIb+w9zrbvIxaLhucTiGZysQetdZdiPHPh1OXTY5OpvBu49d3MXkAtbA5rmAIOvGJbPs7k6NznE36y8SwNNc58XdfMYEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=YEasuRxn; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1707762518; x=1708367318; i=wahrenst@gmx.net;
	bh=LpudjD+lpuCqBJajm53UPKdQDRtAnUxmuetQzRE+AQ4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=YEasuRxnU8e3s9zUElw3+yJql/uaeDxUOVDEBYSU0oIhM4BnmF7VtzUooO/ZzjAA
	 H6+p9dFlfG5Q66Sfws6iR/q9tQYkoletvn1cbe3xgonFsF98G2SYfGPCRAKU/5WSO
	 Hg7eUbtJuD1g1msMeR7BxrMqp26KJtOrCYL1NFu9z0OeMdlC3ryNMeKSP71qgpybr
	 PKKzbVDQ9HEzo4R73M/mp7Pc/ju+cqKjFKKn4QmA9wBTKx3Etz6eBY1JhJSqfKgZx
	 sXyLbjXTfUzqmxfnxKa5+Tc+LqxbzMtdJsHP1hk2DZpHX6VEUSF711TL/tYHMU0mU
	 sXAZGZpsUFYrdu56Vw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPogF-1rM4EI3dBb-00Msyf; Mon, 12
 Feb 2024 19:28:37 +0100
Message-ID: <c38e7c68-e725-4174-aa0a-0594a55c8d56@gmx.net>
Date: Mon, 12 Feb 2024 19:28:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/14] ARM: dts: imx6ull-uti260b: Add board
Content-Language: en-US
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240210012114.489102-1-sre@kernel.org>
 <20240210012114.489102-15-sre@kernel.org>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240210012114.489102-15-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c5VKWE6hflMXQlXN/6TTdFqRmDuxE/gvmdmcDu81apxLxddWs+a
 BKnRV5ppwdnFry+J/+pv/LTEFb4dYOatMWvEac4Monq5Ocjv26F4AXX4gQepZM2rwgq9rlj
 kv8uOMZldhgAA+mVaJXUvCTLDU6ZgimSqVbOXRtGS9SVO4elOewbhX4e3uoH6/qTylx5P8K
 zQd82jGPu2tgeqNa7tkVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PlaWpC3rTSM=;mhGfFz4fJLaAFF0WXu9Z7tkIIvH
 a4yAwr65CAF0T8vurm/Thgf04QxiUQYL1m68aizRhpPA6GNPRQ7rx3MtgbSU26cc/uebsesY6
 JsO1TANeezDubHDeFeHVYuPAKsK51P2Ndm3b4w3Ljkmjjfn21G0SPTCTDIPAatAcQ0b52vtVs
 hscdLmjURTOZrPs7ZZV6u13QX4SBC/2GO23/IpRJbWeSWnXeHkmx7F3uoOnQrVeElBynrRgGv
 a8EAjTHdhqm2X/ixWjcRJIlGTuYfi4oGV7bRJCcw7NbZFMwR9zP7o9VPfZ9oWB3X1dBKo7uXY
 HRE/54U5tHmGKPrH9spdMydihRqxkiYhVl3SSvG4emcHPlmmPwrnayuNoGg0p8T/dOyghfkyN
 tGpQVgyPLOzBK+ynfIJTi3YUVP4BDbZbWcPhtfvTKDEAiv5VSmjEn6e6IWYJRMfSyjTSQXNdB
 L5jV6TaZUZJ/lRaHn8/TMvUWzuxLbI2wNaMHuHSBZxMLIN2VkwL4YsYbxL36VSP6rg/AYyZJh
 yJ9oF36+KpA8p0jyXh2PO6OW1ilabOT7TG3HnN2agmts74da4uZwmnZeyziFv/MoFD8bONIim
 pBGbPcDzWy2tM0u9dQvG1es4gd9yfONg995hJj8bVHBuz/6u6cZnZb83hcybtOO49ES2kOLYM
 XLjL+Mf7b45YySz+AwrNk77RsenxxV4YnqLzYlqUxQmN16Eh+zNAlUlaVxqz1Q90mrnxOsluQ
 Lu3CtdkKJo1uqwn/q/mjilNymLQWzA8h6/zIQNfs1BUQoZpaeMJ1166UudHByJL3IeZ5Ao/53
 238A/3zdILLzpSrc8KaFEjOqk6QwKcwexDWOrzMVIIatY=

Hi Sebastian,

Am 10.02.24 um 02:18 schrieb Sebastian Reichel:
> Add UNI-T UTi260b thermal camera board.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>   arch/arm/boot/dts/nxp/imx/Makefile            |   1 +
>   arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts | 564 ++++++++++++++++++
>   2 files changed, 565 insertions(+)
>   create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts
>
> diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/=
imx/Makefile
> index a724d1a7a9a0..47350cf3ddeb 100644
> --- a/arch/arm/boot/dts/nxp/imx/Makefile
> +++ b/arch/arm/boot/dts/nxp/imx/Makefile
> @@ -349,6 +349,7 @@ dtb-$(CONFIG_SOC_IMX6UL) +=3D \
>   	imx6ull-tarragon-slavext.dtb \
>   	imx6ull-tqma6ull2-mba6ulx.dtb \
>   	imx6ull-tqma6ull2l-mba6ulx.dtb \
> +	imx6ull-uti260b.dtb \
>   	imx6ulz-14x14-evk.dtb \
>   	imx6ulz-bsh-smm-m2.dtb
>   dtb-$(CONFIG_SOC_IMX7D) +=3D \
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts b/arch/arm/bo=
ot/dts/nxp/imx/imx6ull-uti260b.dts
> new file mode 100644
> index 000000000000..336727895fa4
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts
> @@ -0,0 +1,564 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +// Copyright (C) 2022 Sebastian Reichel <sre@kernel.org>
2024 ?
> +
> +/dts-v1/;
> +#include "imx6ull.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/clock/imx6ul-clock.h>
> +
> +/ {
> +	model =3D "UNI-T UTi260B Thermal Camera";
> +	compatible =3D "uni-t,imx6ull-uti260b", "fsl,imx6ull";
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	memory@80000000 {
> +		device_type =3D "memory";
> +		reg =3D <0x80000000 0x20000000>;
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&mux_led_ctrl>;
> +
> +		led {
> +			label =3D "led";
The label property is deprecated, please use color and function instead.
> +			gpios =3D <&gpio2 2 GPIO_ACTIVE_HIGH>;
> +			default-state =3D "off";
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible =3D "gpio-keys";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&mux_gpio_keys>;
> +		autorepeat;
> +
> +		up-key {
> +			label =3D "Up";
> +			gpios =3D <&gpio2 11 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_UP>;
> +		};
> +
> +		down-key {
> +			label =3D "Down";
> +			gpios =3D <&gpio2 12 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_DOWN>;
> +		};
> +
> +		left-key {
> +			label =3D "Left";
> +			gpios =3D <&gpio2 13 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_LEFT>;
> +		};
> +
> +		right-key {
> +			label =3D "Right";
> +			gpios =3D <&gpio2 10 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_RIGHT>;
> +		};
> +
> +		ok-key {
> +			label =3D "Ok";
> +			gpios =3D <&gpio2 9 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_ENTER>;
> +		};
> +
> +		return-key {
> +			label =3D "Return";
> +			gpios =3D <&gpio2 15 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_ESC>;
> +		};
> +
> +		play-key {
> +			label =3D "Media";
> +			gpios =3D <&gpio2 8 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_MEDIA>;
> +		};
> +
> +		trigger-key {
> +			label =3D "Trigger";
> +			gpios =3D <&gpio2 14 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <BTN_TRIGGER>;
> +		};
> +
> +		power-key {
> +			label =3D "Power";
> +			gpios =3D <&gpio2 3 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_POWER>;
> +		};
> +
> +		light-key {
> +			label =3D "Light";
> +			gpios =3D <&gpio2 1 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_LIGHTS_TOGGLE>;
> +		};
> +	};
> +
> +	panel_backlight: backlight {
> +		compatible =3D "pwm-backlight";
> +		brightness-levels =3D <0 4 8 16 32 64 128 255>;
> +		default-brightness-level =3D <6>;
> +		enable-gpios =3D <&gpio1 9 GPIO_ACTIVE_LOW>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&mux_backlight_enable>;
> +		power-supply =3D <&reg_vsd>;
> +		pwms =3D <&pwm1 0 50000 0>;
> +	};
> +
> +	reg_vsd: regulator-vsd {
i think the node name should be just "regulator"
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "VSD_3V3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +	};
> +
> +	reg_vref: regulator-vref-4v2 {
dito
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "VREF_4V2";
> +		regulator-min-microvolt =3D <4200000>;
> +		regulator-max-microvolt =3D <4200000>;
> +	};
> +
> +	tp5000: charger {
> +		compatible =3D "gpio-charger";
> +		charger-type =3D "usb-sdp";
> +		gpios =3D <&gpio1 1 GPIO_ACTIVE_LOW>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&mux_charger_stat1>;
> +	};
> +
> +	battery: battery {
> +		compatible =3D "simple-battery";
> +		/* generic 26650 battery */
> +		device-chemistry =3D "lithium-ion";
> +		charge-full-design-microamp-hours =3D <5000000>;
> +		voltage-max-design-microvolt =3D <4200000>;
> +		voltage-min-design-microvolt =3D <3300000>;
> +	};
> +
> +	fuel-gauge {
> +		compatible =3D "adc-battery";
> +		charged-gpios =3D <&gpio1 2 GPIO_ACTIVE_LOW>;
> +		io-channel-names =3D "voltage";
> +		io-channels =3D <&adc1 7>;
> +		monitored-battery =3D <&battery>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&mux_charger_stat2>;
> +		power-supplies =3D <&tp5000>;
> +	};
> +
> +	poweroff {
> +		compatible =3D "gpio-poweroff";
> +		gpios =3D <&gpio2 4 GPIO_ACTIVE_LOW>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&mux_poweroff>;
> +	};
> +};
> +
> +&gpio1 {
> +	ir-reset-hog {
> +		gpio-hog;
> +		gpios =3D <3 GPIO_ACTIVE_LOW>;
> +		line-name =3D "ir-reset-gpio";
> +		output-low;
> +		pinctrl-0 =3D <&mux_ir_reset>;
Doesn't this miss pinctrl-names =3D "default" ?
> +	};
> +};
> +
> +&gpio2 {
> +	/* configuring this to output-high results in poweroff */
> +	power-en-hog {
> +		gpio-hog;
> +		gpios =3D <6 GPIO_ACTIVE_HIGH>;
> +		line-name =3D "power-en-gpio";
> +		output-low;
> +		pinctrl-0 =3D <&mux_poweroff2>;
> +	};
> +};
> +
> +&ecspi3 {
> +	cs-gpios =3D <&gpio1 20 GPIO_ACTIVE_LOW>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mux_spi3>, <&mux_spi3_cs>;
> +	status =3D "okay";
> +
> +	panel@0 {
> +		compatible =3D "inanbo,t28cp45tn89-v17";
> +		reg =3D <0>;
> +		backlight =3D <&panel_backlight>;
> +		power-supply =3D <&reg_vsd>;
> +		spi-cpha;
> +		spi-cpol;
> +		spi-max-frequency =3D <100000>;
This seems slow to me. Is this a limitation of the display?
> +		spi-rx-bus-width =3D <0>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint =3D <&display_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&uart1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mux_uart>;
> +	status =3D "okay";
> +};
> +
> +&pwm1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mux_pwm>;
> +	status =3D "okay";
> +};
> +
> +&i2c1 {
> +	clock-frequency =3D <100000>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mux_i2c1>;
> +	status =3D "okay";
> +
> +	camera@21 {
> +		compatible =3D "galaxycore,gc0308";
> +		reg =3D <0x21>;
> +		clocks =3D <&clks IMX6UL_CLK_CSI>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&mux_gc0308>;
> +		powerdown-gpios =3D <&gpio1 5 GPIO_ACTIVE_HIGH>;
> +		reset-gpios =3D <&gpio1 6 GPIO_ACTIVE_LOW>;
> +		vdd28-supply =3D <&reg_vsd>;
> +
> +		port {
> +			gc0308_to_parallel: endpoint {
> +				remote-endpoint =3D <&parallel_from_gc0308>;
> +				bus-width =3D <8>;
> +				data-shift =3D <2>; /* lines 9:2 are used */
> +				hsync-active =3D <1>; /* active high */
> +				vsync-active =3D <1>; /* active high */
> +				data-active =3D <1>; /* active high */
> +				pclk-sample =3D <1>; /* sample on rising edge */
> +			};
> +		};
> +	};
> +};
> +
> +&csi {
> +	status =3D "okay";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mux_csi>;
> +
> +	port {
> +		parallel_from_gc0308: endpoint {
> +			remote-endpoint =3D <&gc0308_to_parallel>;
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency =3D <100000>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mux_i2c2>;
> +	status =3D "okay";
> +
> +	rtc@51 {
> +		compatible =3D "nxp,pcf8563";
> +		reg =3D <0x51>;
> +	};
> +};
> +
> +&lcdif {
> +	assigned-clocks =3D <&clks IMX6UL_CLK_LCDIF_PRE_SEL>;
> +	assigned-clock-parents =3D <&clks IMX6UL_CLK_PLL5_VIDEO_DIV>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mux_lcd_data>, <&mux_lcd_ctrl>;
> +	status =3D "okay";
> +
> +	port {
> +		display_out: endpoint {
> +			remote-endpoint =3D <&panel_in>;
> +		};
> +	};
> +};
> +
> +&usdhc1 {
Would be nice to place a comment above this, which mentions the intended
use case: eMMC, SD card, ...
> +	cd-gpios =3D <&gpio1 19 GPIO_ACTIVE_LOW>;
> +	keep-power-in-suspend;
> +	no-1-8-v;
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 =3D <&mux_sdhc1>, <&mux_sdhc1_cd>;
> +	pinctrl-1 =3D <&mux_sdhc1_100mhz>, <&mux_sdhc1_cd>;
> +	pinctrl-2 =3D <&mux_sdhc1_200mhz>, <&mux_sdhc1_cd>;
> +	wakeup-source;
> +	vmmc-supply =3D <&reg_vsd>;
> +	status =3D "okay";
> +};
> +
> +&usdhc2 {
dito

Best regards
> +	keep-power-in-suspend;
> +	no-1-8-v;
> +	non-removable;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mux_sdhc2>;
> +	wakeup-source;
> +	status =3D "okay";
> +};
> +
> +&wdog1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mux_wdog>;
> +};
> +
> +&adc1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mux_adc>;
> +	vref-supply =3D <&reg_vref>;
> +	#io-channel-cells =3D <1>;
> +	status =3D "okay";
> +};
> +
>

