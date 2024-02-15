Return-Path: <linux-kernel+bounces-67450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB8D856BB0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47BC1F21020
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0521384BF;
	Thu, 15 Feb 2024 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="jO5XMIFR"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3D4137C5D;
	Thu, 15 Feb 2024 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019730; cv=none; b=Nfto9zvQZnb7lWATx6lHnXLO/MUXiDWn8tu4s+Yn4eAlOJ02YssTC5BArn2+6DazZjXxymH7zbb6HFbfTYNX51HiayRNXxRtaAL5o2rZmOb6s/DHTWKal8AJRhoKy1violnbaWSXlMolbY2x73rp6i3+f5Wnl/Pp8QxSCCv6lBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019730; c=relaxed/simple;
	bh=XBMqKKVFrZC2Z+GFYFdDf5Cs4O7glg8RjqbDu2ptbEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSKXX361rlUISzyxv3K/3B80HNVhqnf24xSMRXUUxv/asonWTXATR0oZmXiRKhEFDDKU3IyTvZK01N5JQD5XhJvOwUw4BUjYogDaXUz8neBTEzQD1amJCvW3iY68ySoNLFV7KnTftH43RddX5RB8T9AHbtX2hEe55EVeklhqaes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=jO5XMIFR; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1708019725; bh=XBMqKKVFrZC2Z+GFYFdDf5Cs4O7glg8RjqbDu2ptbEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jO5XMIFRiWwORLdruTVC3gmt8gr7cMiX5p88ZdIMgDt8tCNldBqYW1zA3n3YzRJy6
	 ED0pRg4aZQWTGywhS2YZLt4ZpQuD0MrCyJ0d4SD6zK6cB1viEwTZtuE6ItsQifnJMG
	 UXvsjmCxgF7doSJw9mcCO91I3qU7nAkLUlRn8w04=
From: Luca Weiss <luca@z3ntu.xyz>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bryant Mairs <bryant@mai.rs>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>
Subject:
 Re: [PATCH v2 2/2] ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 8.0
 Wi-Fi
Date: Thu, 15 Feb 2024 18:55:24 +0100
Message-ID: <5756684.DvuYhMxLoT@z3ntu.xyz>
In-Reply-To: <20240215172617.115307-3-bryant@mai.rs>
References:
 <20240215172617.115307-1-bryant@mai.rs>
 <20240215172617.115307-3-bryant@mai.rs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 15. Februar 2024 18:19:49 CET Bryant Mairs wrote:
> Add support for this tablet based on the MSM8226 SoC, codenamed
> "milletwifi".
>=20
> Signed-off-by: Bryant Mairs <bryant@mai.rs>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

afaik Acked-by should come before Signed-off-by (in other words your S-o-b=
=20
should be the last tag when you send patches)

> ---
>  arch/arm/boot/dts/qcom/Makefile               |   1 +
>  .../qcom/qcom-apq8026-samsung-milletwifi.dts  | 568 ++++++++++++++++++
>  2 files changed, 569 insertions(+)
>  create mode 100644
> arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts
>=20
> diff --git a/arch/arm/boot/dts/qcom/Makefile
> b/arch/arm/boot/dts/qcom/Makefile index 9cc1e14e6cd0..730d98c2c715 100644
> --- a/arch/arm/boot/dts/qcom/Makefile
> +++ b/arch/arm/boot/dts/qcom/Makefile
> @@ -5,6 +5,7 @@ dtb-$(CONFIG_ARCH_QCOM) +=3D \
>  	qcom-apq8026-huawei-sturgeon.dtb \
>  	qcom-apq8026-lg-lenok.dtb \
>  	qcom-apq8026-samsung-matisse-wifi.dtb \
> +	qcom-apq8026-samsung-milletwifi.dtb \
>  	qcom-apq8060-dragonboard.dtb \
>  	qcom-apq8064-cm-qs600.dtb \
>  	qcom-apq8064-ifc6410.dtb \
> diff --git a/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts
> b/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts new file mode
> 100644
> index 000000000000..a9c38bc8aa01
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts
> @@ -0,0 +1,568 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, Matti Lehtim=E4ki <matti.lehtimaki@gmail.com>
> + * Copyright (c) 2023, Bryant Mairs <bryant@mai.rs>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/power/summit,smb347-charger.h>
> +#include "qcom-msm8226.dtsi"
> +#include "pm8226.dtsi"
> +
> +/delete-node/ &adsp_region;
> +/delete-node/ &smem_region;
> +
> +/ {
> +	model =3D "Samsung Galaxy Tab 4 8.0 Wi-Fi";
> +	compatible =3D "samsung,milletwifi", "qcom,apq8026";
> +	chassis-type =3D "tablet";
> +
> +	aliases {
> +		display0 =3D &framebuffer0;
> +		mmc0 =3D &sdhc_1; /* SDC1 eMMC slot */
> +		mmc1 =3D &sdhc_2; /* SDC2 SD card slot */
> +	};
> +
> +	chosen {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges;
> +
> +		stdout-path =3D "display0";
> +
> +		framebuffer0: framebuffer@3200000 {
> +			compatible =3D "simple-framebuffer";
> +			reg =3D <0x03200000 0x800000>;
> +			width =3D <800>;
> +			height =3D <1280>;
> +			stride =3D <(800 * 3)>;
> +			format =3D "r8g8b8";
> +		};
> +	};
> +
> +	gpio-hall-sensor {
> +		compatible =3D "gpio-keys";
> +
> +		event-hall-sensor {
> +			label =3D "Cover";
> +			gpios =3D <&tlmm 37 GPIO_ACTIVE_LOW>;
> +			linux,input-type =3D <EV_SW>;
> +			linux,code =3D <SW_LID>;
> +			debounce-interval =3D <15>;
> +			linux,can-disable;
> +			wakeup-source;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible =3D "gpio-keys";
> +		autorepeat;
> +
> +		key-home {
> +			label =3D "Home";
> +			gpios =3D <&tlmm 108 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_HOMEPAGE>;
> +			debounce-interval =3D <15>;
> +		};
> +
> +		key-volume-down {
> +			label =3D "Volume Down";
> +			gpios =3D <&tlmm 107 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_VOLUMEDOWN>;
> +			debounce-interval =3D <15>;
> +		};
> +
> +		key-volume-up {
> +			label =3D "Volume Up";
> +			gpios =3D <&tlmm 106 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_VOLUMEUP>;
> +			debounce-interval =3D <15>;
> +		};
> +	};
> +
> +	i2c-backlight {
> +		compatible =3D "i2c-gpio";
> +		sda-gpios =3D <&tlmm 20 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +		scl-gpios =3D <&tlmm 21 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +
> +		pinctrl-0 =3D <&backlight_i2c_default_state>;
> +		pinctrl-names =3D "default";
> +
> +		i2c-gpio,delay-us =3D <4>;
> +
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		backlight@2c {
> +			compatible =3D "ti,lp8556";
> +			reg =3D <0x2c>;
> +			enable-supply =3D <&reg_backlight_vddio>;
> +
> +			dev-ctrl =3D /bits/ 8 <0x80>;
> +			init-brt =3D /bits/ 8 <0x3f>;
> +
> +			/*
> +			 * Change transition duration: 200ms, Change=20
transition strength: heavy,
> +			 * PWM hysteresis: 1-bit w/ 8-bit resolution
> +			 */
> +			rom-a3h {
> +				rom-addr =3D /bits/ 8 <0xa3>;
> +				rom-val =3D /bits/ 8 <0x5e>;
> +			};
> +
> +			/*
> +			 * PWM phase configuration: 3-phase/3 drivers=20
(0, 120deg, 240deg, -, -,
> -), +			 * PWM frequency: 9616Hz (10-bit)
> +			 */
> +			rom-a5h {
> +				rom-addr =3D /bits/ 8 <0xa5>;
> +				rom-val =3D /bits/ 8 <0x34>;
> +			};
> +
> +			/* Enable LED drivers 2 & 3, Boot inductor=20
current limit: 1.5A/2.6A */
> +			rom-a7h {
> +				rom-addr =3D /bits/ 8 <0xa7>;
> +				rom-val =3D /bits/ 8 <0xfa>;
> +			};
> +		};
> +	};
> +
> +	reg_backlight_vddio: regulator-backlight-vddio {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "backlight_vddio";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +
> +		gpio =3D <&tlmm 74 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&backlight_vddio_default_state>;

Use this order:

pinctrl-0
pinctrl-names

Also applies a few more times below.

> +	};
> +
> +	reg_tsp_1p8v: regulator-tsp-1p8v {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "tsp_1p8v";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +
> +		gpio =3D <&tlmm 114 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&tsp_en1_default_state>;
> +	};
> +
> +	reg_tsp_3p3v: regulator-tsp-3p3v {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "tsp_3p3v";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +
> +		gpio =3D <&tlmm 31 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&tsp_en_default_state>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges;
> +
> +		framebuffer@3200000 {
> +			reg =3D <0x03200000 0x800000>;
> +			no-map;
> +		};
> +
> +		mpss_region: mpss@8400000 {
> +			reg =3D <0x08400000 0x1f00000>;
> +			no-map;
> +		};
> +
> +		mba_region: mba@a300000 {
> +			reg =3D <0x0a300000 0x100000>;
> +			no-map;
> +		};
> +
> +		reserved@cb00000 {
> +			reg =3D <0x0cb00000 0x700000>;
> +			no-map;
> +		};
> +
> +		wcnss_region: wcnss@d200000 {
> +			reg =3D <0x0d200000 0x700000>;
> +			no-map;
> +		};
> +
> +		adsp_region: adsp@d900000 {
> +			reg =3D <0x0d900000 0x1800000>;
> +			no-map;
> +		};
> +
> +		venus@f100000 {
> +			reg =3D <0x0f100000 0x500000>;
> +			no-map;
> +		};
> +
> +		smem_region: smem@fa00000 {
> +			reg =3D <0x0fa00000 0x100000>;
> +			no-map;
> +		};
> +
> +		reserved@fb00000 {
> +			reg =3D <0x0fb00000 0x260000>;
> +			no-map;
> +		};
> +
> +		rfsa@fd60000 {
> +			reg =3D <0x0fd60000 0x20000>;
> +			no-map;
> +		};
> +
> +		rmtfs@fd80000 {
> +			compatible =3D "qcom,rmtfs-mem";
> +			reg =3D <0x0fd80000 0x180000>;
> +			no-map;
> +
> +			qcom,client-id =3D <1>;
> +		};
> +	};
> +};
> +
> +&blsp1_i2c2 {
> +	status =3D "okay";
> +
> +	accelerometer@1d {
> +		compatible =3D "st,lis2hh12";
> +		reg =3D <0x1d>;
> +
> +		interrupts-extended =3D <&tlmm 54 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		pinctrl-0 =3D <&accel_int_default_state>;
> +		pinctrl-names =3D "default";
> +
> +		st,drdy-int-pin =3D <1>;

This should move lower in this node if I read the style guide correctly :)

"Vendor-specific properties"
https://www.kernel.org/doc/html/next/devicetree/bindings/dts-coding-style.h=
tml#order-of-properties-in-device-node

Rest looks fine, so with that fixed you can add my:

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

> +
> +		vdd-supply =3D <&pm8226_l19>;
> +		vddio-supply =3D <&pm8226_lvs1>;
> +
> +		mount-matrix =3D "0", "1", "0",
> +			       "-1", "0", "0",
> +			       "0", "0", "1";
> +	};
> +};
> +
> +&blsp1_i2c3 {
> +	status =3D "okay";
> +
> +	charger@6a {
> +		compatible =3D "summit,smb358";
> +		reg =3D <0x6a>;
> +
> +		interrupts-extended =3D <&tlmm 115 IRQ_TYPE_EDGE_FALLING>;
> +
> +		pinctrl-0 =3D <&charger_int_default_state>;
> +		pinctrl-names =3D "default";
> +
> +		summit,enable-usb-charging;
> +		summit,enable-charge-control =3D <SMB3XX_CHG_ENABLE_SW>;
> +		summit,fast-voltage-threshold-microvolt =3D <3000000>;
> +		summit,chip-temperature-threshold-celsius =3D <130>;
> +		summit,usb-current-limit-microamp =3D <1500000>;
> +	};
> +};
> +
> +&blsp1_i2c4 {
> +	status =3D "okay";
> +
> +	muic: usb-switch@25 {
> +		compatible =3D "siliconmitus,sm5502-muic";
> +		reg =3D <0x25>;
> +
> +		interrupts-extended =3D <&tlmm 67 IRQ_TYPE_EDGE_FALLING>;
> +
> +		pinctrl-0 =3D <&muic_int_default_state>;
> +		pinctrl-names =3D "default";
> +	};
> +};
> +
> +&blsp1_i2c5 {
> +	status =3D "okay";
> +
> +	touchscreen@48 {
> +		compatible =3D "melfas,mms252", "melfas,mms114";
> +		reg =3D <0x48>;
> +		interrupts-extended =3D <&tlmm 17 IRQ_TYPE_EDGE_FALLING>;
> +		touchscreen-size-x =3D <800>;
> +		touchscreen-size-y =3D <1280>;
> +		avdd-supply =3D <&reg_tsp_3p3v>;
> +		vdd-supply =3D <&reg_tsp_1p8v>;
> +		linux,keycodes =3D <KEY_APPSELECT KEY_BACK>;
> +
> +		pinctrl-0 =3D <&tsp_int_rst_default_state>;
> +		pinctrl-names =3D "default";
> +	};
> +};
> +
> +&rpm_requests {
> +	regulators {
> +		compatible =3D "qcom,rpm-pm8226-regulators";
> +
> +		pm8226_s3: s3 {
> +			regulator-min-microvolt =3D <1200000>;
> +			regulator-max-microvolt =3D <1300000>;
> +		};
> +
> +		pm8226_s4: s4 {
> +			regulator-min-microvolt =3D <1800000>;
> +			regulator-max-microvolt =3D <1800000>;
> +		};
> +
> +		pm8226_s5: s5 {
> +			regulator-min-microvolt =3D <1150000>;
> +			regulator-max-microvolt =3D <1150000>;
> +		};
> +
> +		pm8226_l1: l1 {
> +			regulator-min-microvolt =3D <1225000>;
> +			regulator-max-microvolt =3D <1225000>;
> +		};
> +
> +		pm8226_l2: l2 {
> +			regulator-min-microvolt =3D <1200000>;
> +			regulator-max-microvolt =3D <1200000>;
> +		};
> +
> +		pm8226_l3: l3 {
> +			regulator-min-microvolt =3D <750000>;
> +			regulator-max-microvolt =3D <1337500>;
> +			regulator-always-on;
> +		};
> +
> +		pm8226_l4: l4 {
> +			regulator-min-microvolt =3D <1200000>;
> +			regulator-max-microvolt =3D <1200000>;
> +		};
> +
> +		pm8226_l5: l5 {
> +			regulator-min-microvolt =3D <1200000>;
> +			regulator-max-microvolt =3D <1200000>;
> +		};
> +
> +		pm8226_l6: l6 {
> +			regulator-min-microvolt =3D <1800000>;
> +			regulator-max-microvolt =3D <1800000>;
> +			regulator-always-on;
> +		};
> +
> +		pm8226_l7: l7 {
> +			regulator-min-microvolt =3D <1850000>;
> +			regulator-max-microvolt =3D <1850000>;
> +		};
> +
> +		pm8226_l8: l8 {
> +			regulator-min-microvolt =3D <1800000>;
> +			regulator-max-microvolt =3D <1800000>;
> +			regulator-always-on;
> +		};
> +
> +		pm8226_l9: l9 {
> +			regulator-min-microvolt =3D <2050000>;
> +			regulator-max-microvolt =3D <2050000>;
> +		};
> +
> +		pm8226_l10: l10 {
> +			regulator-min-microvolt =3D <1800000>;
> +			regulator-max-microvolt =3D <1800000>;
> +		};
> +
> +		pm8226_l12: l12 {
> +			regulator-min-microvolt =3D <1800000>;
> +			regulator-max-microvolt =3D <1800000>;
> +		};
> +
> +		pm8226_l14: l14 {
> +			regulator-min-microvolt =3D <2750000>;
> +			regulator-max-microvolt =3D <2750000>;
> +		};
> +
> +		pm8226_l15: l15 {
> +			regulator-min-microvolt =3D <1800000>;
> +			regulator-max-microvolt =3D <3300000>;
> +		};
> +
> +		pm8226_l16: l16 {
> +			regulator-min-microvolt =3D <3000000>;
> +			regulator-max-microvolt =3D <3350000>;
> +		};
> +
> +		pm8226_l17: l17 {
> +			regulator-min-microvolt =3D <2950000>;
> +			regulator-max-microvolt =3D <2950000>;
> +
> +			regulator-system-load =3D <200000>;
> +			regulator-allow-set-load;
> +			regulator-always-on;
> +		};
> +
> +		pm8226_l18: l18 {
> +			regulator-min-microvolt =3D <2950000>;
> +			regulator-max-microvolt =3D <2950000>;
> +		};
> +
> +		pm8226_l19: l19 {
> +			regulator-min-microvolt =3D <2850000>;
> +			regulator-max-microvolt =3D <3000000>;
> +		};
> +
> +		pm8226_l20: l20 {
> +			regulator-min-microvolt =3D <3075000>;
> +			regulator-max-microvolt =3D <3075000>;
> +		};
> +
> +		pm8226_l21: l21 {
> +			regulator-min-microvolt =3D <1800000>;
> +			regulator-max-microvolt =3D <2950000>;
> +		};
> +
> +		pm8226_l22: l22 {
> +			regulator-min-microvolt =3D <1800000>;
> +			regulator-max-microvolt =3D <3000000>;
> +		};
> +
> +		pm8226_l23: l23 {
> +			regulator-min-microvolt =3D <1800000>;
> +			regulator-max-microvolt =3D <3300000>;
> +		};
> +
> +		pm8226_l24: l24 {
> +			regulator-min-microvolt =3D <1300000>;
> +			regulator-max-microvolt =3D <1350000>;
> +		};
> +
> +		pm8226_l25: l25 {
> +			regulator-min-microvolt =3D <1775000>;
> +			regulator-max-microvolt =3D <2125000>;
> +		};
> +
> +		pm8226_l26: l26 {
> +			regulator-min-microvolt =3D <1225000>;
> +			regulator-max-microvolt =3D <1300000>;
> +		};
> +
> +		pm8226_l27: l27 {
> +			regulator-min-microvolt =3D <1800000>;
> +			regulator-max-microvolt =3D <1800000>;
> +		};
> +
> +		pm8226_l28: l28 {
> +			regulator-min-microvolt =3D <1800000>;
> +			regulator-max-microvolt =3D <2950000>;
> +		};
> +
> +		pm8226_lvs1: lvs1 {};
> +	};
> +};
> +
> +&sdhc_1 {
> +	vmmc-supply =3D <&pm8226_l17>;
> +	vqmmc-supply =3D <&pm8226_l6>;
> +
> +	bus-width =3D <8>;
> +	non-removable;
> +
> +	status =3D "okay";
> +};
> +
> +&sdhc_2 {
> +	vmmc-supply =3D <&pm8226_l18>;
> +	vqmmc-supply =3D <&pm8226_l21>;
> +
> +	bus-width =3D <4>;
> +	cd-gpios =3D <&tlmm 38 GPIO_ACTIVE_LOW>;
> +
> +	pinctrl-0 =3D <&sdhc2_default_state>, <&sdc2_cd_default_state>;
> +	pinctrl-names =3D "default";
> +
> +	status =3D "okay";
> +};
> +
> +&tlmm {
> +	accel_int_default_state: accel-int-default-state {
> +		pins =3D "gpio54";
> +		function =3D "gpio";
> +		drive-strength =3D <2>;
> +		bias-disable;
> +	};
> +
> +	backlight_i2c_default_state: backlight-i2c-default-state {
> +		pins =3D "gpio20", "gpio21";
> +		function =3D "gpio";
> +		drive-strength =3D <2>;
> +		bias-disable;
> +	};
> +
> +	backlight_vddio_default_state: backlight-vddio-default-state {
> +		pins =3D "gpio74";
> +		function =3D "gpio";
> +		drive-strength =3D <2>;
> +		bias-disable;
> +	};
> +
> +	charger_int_default_state: charger-int-default-state {
> +		pins =3D "gpio115";
> +		function =3D "gpio";
> +		drive-strength =3D <2>;
> +		bias-disable;
> +	};
> +
> +	muic_int_default_state: muic-int-default-state {
> +		pins =3D "gpio67";
> +		function =3D "gpio";
> +		drive-strength =3D <2>;
> +		bias-disable;
> +	};
> +
> +	sdc2_cd_default_state: sdc2-cd-default-state {
> +		pins =3D "gpio38";
> +		function =3D "gpio";
> +		drive-strength =3D <2>;
> +		bias-disable;
> +	};
> +
> +	tsp_en_default_state: tsp-en-default-state {
> +		pins =3D "gpio31";
> +		function =3D "gpio";
> +		drive-strength =3D <2>;
> +		bias-disable;
> +	};
> +
> +	tsp_en1_default_state: tsp-en1-default-state {
> +		pins =3D "gpio114";
> +		function =3D "gpio";
> +		drive-strength =3D <2>;
> +		bias-disable;
> +	};
> +
> +	tsp_int_rst_default_state: tsp-int-rst-default-state {
> +		pins =3D "gpio17";
> +		function =3D "gpio";
> +		drive-strength =3D <10>;
> +		bias-pull-up;
> +	};
> +};
> +
> +&usb {
> +	extcon =3D <&muic>, <&muic>;
> +	status =3D "okay";
> +};
> +
> +&usb_hs_phy {
> +	extcon =3D <&muic>;
> +	v1p8-supply =3D <&pm8226_l10>;
> +	v3p3-supply =3D <&pm8226_l20>;
> +};





