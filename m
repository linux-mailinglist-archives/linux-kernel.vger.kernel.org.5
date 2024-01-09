Return-Path: <linux-kernel+bounces-21395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4F0828E8E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F08286961
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12093D986;
	Tue,  9 Jan 2024 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIJnFxBP"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6D53D969;
	Tue,  9 Jan 2024 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d4f5d902dso35904415e9.2;
        Tue, 09 Jan 2024 12:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704832625; x=1705437425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdWUbuCryuBzkETyxwx5DgJICOofU12TcqcdHyGb0nk=;
        b=LIJnFxBPlvfaLBMKAvq6S2nzZU5e4Iv8pGEhMjJu4+xLrRWy9RJ/meNTGSXoqB18Lq
         Uv/f+XKD7VJJuyemXj/b7so5g7G5j2wSIOhS3GVo6QjZ1VXKU8gIVyATKl4fvhb9ddCE
         Lr/kPrKIBWQQnRq90Y0L0BgPzUKLAriKunhWJyr4xxEVGYLXDqmdDtzAIdMu8fSZcNyp
         jRGWEX+ASrhFsVTcW/JJbJhnh/5j57HoWrPGWYLr/qKmZNGnGLgD4o6IaP7XWPjjiDTj
         7OVzYXdh4Dq/opEryBQdZk7+dg3TV4Yz0eQ1N1mfuuS1+bdEoCd+b/AlhVFvuoET7DxH
         adOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704832625; x=1705437425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdWUbuCryuBzkETyxwx5DgJICOofU12TcqcdHyGb0nk=;
        b=mgAC2gpju1FbBzDdRjIEUsNO5X+B8tw7CH7LN5wQ/f55UK0fQJkG/s/4Ze/zZTMSaT
         8VrueyQiY3n0TwoB/UISjd3WSgtcPFsdVWnbi6azHG79IyVly4ad3wyamdnAnDb+weA9
         zxExTULoYVNGIklRylSAGBcQN5UncL2qhKXErZQ1ITj2V3cxbIeYtI83xSTvzjehfC1F
         9ZVrvPIIpSv9HXc6GwhB84+qM83GrE0YnqAid89At3j8OLc3H+XRq7BlSoApiWXXzNd2
         8Ll/2nl1sDGac7VActxmO+rQ71hdCvEr4THnkIJLs6khMFO1mokCqsTkXpyg7q5KClHR
         QONQ==
X-Gm-Message-State: AOJu0YxHDUoO9yLfC6bH6NQlLFqfAlFPCyoNQdGWA5uc4dJu/e3MFemS
	zcLG6q4PPBlhcb55ypE7N5C7Zp4sl0iBKQ==
X-Google-Smtp-Source: AGHT+IFa6RH0RM3pLXtY72NJd4E9Ba3aaEp/G+E99fidynnC2fN//sg4O+VSGkloGBYqzsE9MTwnmg==
X-Received: by 2002:a05:600c:3b8d:b0:40e:5136:9c1b with SMTP id n13-20020a05600c3b8d00b0040e51369c1bmr725835wms.171.1704832624605;
        Tue, 09 Jan 2024 12:37:04 -0800 (PST)
Received: from jernej-laptop.localnet (213-161-3-116.dynamic.telemach.net. [213.161.3.116])
        by smtp.gmail.com with ESMTPSA id be10-20020a05600c1e8a00b0040e49994116sm6598367wmb.14.2024.01.09.12.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 12:37:04 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>, Icenowy Zheng <uwu@icenowy.me>,
 Jisheng Zhang <jszhang@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 2/2] arm64: dts: allwinner: h616: Add Sipeed Longan SoM 3H and Pi
 3H board support
Date: Tue, 09 Jan 2024 21:37:03 +0100
Message-ID: <2589997.Lt9SDvczpP@jernej-laptop>
In-Reply-To: <20231228145647.1470-3-jszhang@kernel.org>
References:
 <20231228145647.1470-1-jszhang@kernel.org>
 <20231228145647.1470-3-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Jisheng,

Andre gave you thorough review already, so just one additional comment
below.

Dne =C4=8Detrtek, 28. december 2023 ob 15:56:47 CET je Jisheng Zhang napisa=
l(a):
> The Sipeed Longan SoM 3H is a system on module based on the Allwinner
> H618 SoC. The SoM features:
>=20
> - Four ARM Cortex-A53 cores, Mali-G31 MP2 GPU
> - 2/4 GiB LPDDR4 DRAM SoMs
> - AXP313a PMIC
> - eMMC
>=20
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
>=20
> Add the devicetree file describing the currently supported features,
> namely PMIC, LEDs, UART, SD card, eMMC, USB and Ethernet.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../sun50i-h618-longan-module-3h.dtsi         |  82 +++++++++++
>  .../dts/allwinner/sun50i-h618-longanpi-3h.dts | 133 ++++++++++++++++++
>  3 files changed, 216 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-longan-modu=
le-3h.dtsi
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h=
=2Edts
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts=
/allwinner/Makefile
> index 3aca6787a167..00db504a9b8c 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -42,4 +42,5 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreetech-c=
b1-manta.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreetech-pi.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-orangepi-zero2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-x96-mate.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h618-longanpi-3h.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h618-orangepi-zero3.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.d=
tsi b/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
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
> +
> +#include "sun50i-h616.dtsi"
> +
> +/ {
> +	model =3D "Sipeed Longan Module 3H";
> +	compatible =3D "sipeed,longan-module-3h", "allwinner,sun50i-h618";
> +};
> +
> +&mmc2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mmc2_pins>;
> +	vmmc-supply =3D <&reg_dldo1>;
> +	vqmmc-supply =3D <&reg_aldo1>;
> +	bus-width =3D <8>;
> +	non-removable;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;

I think above is superfluous if hs200 is also defined.

Best regards,
Jernej

> +	mmc-hs200-1_8v;
> +	status =3D "okay";
> +};
> +
> +&r_i2c {
> +	status =3D "okay";
> +
> +	axp313: pmic@36 {
> +		compatible =3D "x-powers,axp313a";
> +		reg =3D <0x36>;
> +
> +		regulators {
> +			/* Supplies VCC-PLL, so needs to be always on. */
> +			reg_aldo1: aldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <1800000>;
> +				regulator-name =3D "vcc1v8";
> +			};
> +
> +			/* Supplies VCC-IO, so needs to be always on. */
> +			reg_dldo1: dldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <3300000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-name =3D "vcc3v3";
> +			};
> +
> +			reg_dcdc1: dcdc1 {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <810000>;
> +				regulator-max-microvolt =3D <990000>;
> +				regulator-name =3D "vdd-gpu-sys";
> +			};
> +
> +			reg_dcdc2: dcdc2 {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <810000>;
> +				regulator-max-microvolt =3D <1100000>;
> +				regulator-name =3D "vdd-cpu";
> +			};
> +
> +			reg_dcdc3: dcdc3 {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <1100000>;
> +				regulator-max-microvolt =3D <1100000>;
> +				regulator-name =3D "vdd-dram";
> +			};
> +		};
> +	};
> +};
> +
> +&pio {
> +	vcc-pc-supply =3D <&reg_dldo1>;
> +	vcc-pf-supply =3D <&reg_dldo1>;
> +	vcc-pg-supply =3D <&reg_aldo1>;
> +	vcc-ph-supply =3D <&reg_dldo1>;
> +	vcc-pi-supply =3D <&reg_dldo1>;
> +};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts b/=
arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts
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
> +	model =3D "Sipeed Longan Pi 3H";
> +	compatible =3D "sipeed,longan-pi-3h", "sipeed,longan-module-3h", "allwi=
nner,sun50i-h618";
> +
> +	aliases {
> +		ethernet0 =3D &emac0;
> +		serial0 =3D &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +
> +		led-0 {
> +			color =3D <LED_COLOR_ID_ORANGE>;
> +			function =3D LED_FUNCTION_INDICATOR;
> +			function-enumerator =3D <0>;
> +			gpios =3D <&pio 6 2 GPIO_ACTIVE_LOW>; /* PG2 */
> +		};
> +
> +		led-1 {
> +			color =3D <LED_COLOR_ID_ORANGE>;
> +			function =3D LED_FUNCTION_INDICATOR;
> +			function-enumerator =3D <1>;
> +			gpios =3D <&pio 6 4 GPIO_ACTIVE_LOW>; /* PG4 */
> +		};
> +	};
> +
> +	reg_vcc5v: vcc5v {
> +		/* board wide 5V supply directly from the USB-C socket */
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc-5v";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +&axp313 {
> +	vin1-supply =3D <&reg_vcc5v>;
> +	vin2-supply =3D <&reg_vcc5v>;
> +	vin3-supply =3D <&reg_vcc5v>;
> +};
> +
> +&ehci1 {
> +	status =3D "okay";
> +};
> +
> +&ohci1 {
> +	status =3D "okay";
> +};
> +
> +&ehci2 {
> +	status =3D "okay";
> +};
> +
> +&ohci2 {
> +	status =3D "okay";
> +};
> +
> +&ehci3 {
> +	status =3D "okay";
> +};
> +
> +&ohci3 {
> +	status =3D "okay";
> +};
> +
> +&emac0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&ext_rgmii_pins>;
> +	phy-mode =3D "rgmii";
> +	phy-handle =3D <&ext_rgmii_phy>;
> +	allwinner,rx-delay-ps =3D <3100>;
> +	allwinner,tx-delay-ps =3D <700>;
> +	phy-supply =3D <&reg_dldo1>;
> +	status =3D "okay";
> +};
> +
> +&mdio0 {
> +	ext_rgmii_phy: ethernet-phy@1 {
> +		compatible =3D "ethernet-phy-ieee802.3-c22";
> +		reg =3D <1>;
> +	};
> +};
> +
> +&mmc0 {
> +	bus-width =3D <4>;
> +	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_HIGH>;	/* PF6 */
> +	vmmc-supply =3D <&reg_dldo1>;
> +	status =3D "okay";
> +};
> +
> +&uart0 {
> +	status =3D "okay";
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
> +	dr_mode =3D "peripheral";
> +	status =3D "okay";
> +};
> +
> +&usbphy {
> +	usb1_vbus-supply =3D <&reg_vcc5v>;
> +	status =3D "okay";
> +};
>=20





