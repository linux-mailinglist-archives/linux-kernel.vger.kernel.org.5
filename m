Return-Path: <linux-kernel+bounces-103614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5D087C1EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832ED282C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ECB745DC;
	Thu, 14 Mar 2024 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPBGqvyS"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9B86E610;
	Thu, 14 Mar 2024 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436495; cv=none; b=YBOUz1BbIZnAHi8jTewZwIDcMuJZnoDK/+dW5+SHwhHEUO7uKUPoCbiV1/Gm+ebBz0rwWH51sldiIOXzg2OWglGMi1w6gnCgmd7oOCGwzWs//YbowXeAB52rxn41TLHPgXW3UsCjBfoGGH9LSG65hmbdVY1K30dtd8M7diWZITg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436495; c=relaxed/simple;
	bh=Mk+rfA5+jt08mXa/s62cSWewQqyfYwi9QnmHD0NZdQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aM2RmctST99KCP8UKo2fycRnMNMiJbQFDhiuYhSRDMsa3+0zZWIhYfG/yXSNUxiFaKBQetMxQgMThK7ksndxA4i7OicgBa1qaeRH6/jdoG84XnGnl+nNSJ1piYl2Uv/FoVwwlErAEzi8yh93kQUAi8xn91t0vd0QBs8/pQqqj1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPBGqvyS; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5689b7e8387so1582592a12.2;
        Thu, 14 Mar 2024 10:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710436491; x=1711041291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyQuvyZvWkNkevJje/qZfohSPwJGSD6MP76YZ0DXqFI=;
        b=iPBGqvySqSZJneP3fo3HehzCAEKZElSEVCDbfzcWlBBMDc3cCc7pTQEjXjsHCYeQ9W
         4l/1Hpe68808FozWCK3vHNRTPX1TZ8GkW8Iv5f66VKDjFJ6R7lyZpd6xw+ZMbLSKmK1Z
         /jKsp78ZaYM6B8EC78Yi92Ij7Yf5hhUdKmu/z83fMxqHyvD27x9xxYictsWyOVx1X35l
         CX9mKBDu6UwthFhv4iOembOseAaMp5CWKHHzoydbjRiqOcZYxe5gfTPKOWern2npKFuc
         muNvmOnjf1rrjD5PVVUSXNc83jt+i346fKXCn+gMjwogXRNisS6q9i7HL6uniBI2Vvcv
         uqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710436491; x=1711041291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyQuvyZvWkNkevJje/qZfohSPwJGSD6MP76YZ0DXqFI=;
        b=HU8o9Td3NkqMKWPysoGqCN3iHG9SRjIwwrayj1bUQVKOIvxEjqHg9oUaKaGZJBWUVv
         QRAm2DO9k24+pUESj2ohJoPM4/3qCUJmG2QvvkmPg0AESHvYkDKylUxoK8JvXHduQ1gA
         NlHOvXjviDHZUYjoi3IQ3AM4TQXDIZsomkU5nhdt/8OurgyWv4J5HaxZn20yMiyUpL5K
         CGAC/4ZP+pPPMNi7NTI0hf3j72fMEI/EHqUhHZlh6wbjrMZDC+LPbeyB8fwaxcNq4gse
         A03AAMHECPjvsPR3C0MUlVVQBWEF8QnGAC5pGdOqCSDONb678q3HCs1b2tSV+vSgmGNy
         NYDw==
X-Forwarded-Encrypted: i=1; AJvYcCWhPilnlI9ODMBJGY0RCWD1f76q8IoFrmLlT/Wzg5HdimbbRPJ8pXt3CWOhw+CyzRG9BamuOtntgYN/7C5211xTdD6IsX/PbU84xdHB5YD8xyM1Wftzblc5+g1wNoFlju/vksy2p+B+/g==
X-Gm-Message-State: AOJu0YwiEtTmfb5kMwisv0rqKn2oQXIbvoViUmMYBp5gAgz3c0CEdPKD
	DQhCnGRcrf4H6ned1tNpnU8WFlfc+b9urENfGKOFICp7kFH2F0kN
X-Google-Smtp-Source: AGHT+IEMOp7WlFT+9NeLjuuuolSPGS9gEn8HXwALS4uZ7Hqf/VM5cxQ581uVXE7EOsb4JtgAAKOXNA==
X-Received: by 2002:a17:906:ecfc:b0:a46:6557:716f with SMTP id qt28-20020a170906ecfc00b00a466557716fmr977154ejb.20.1710436490523;
        Thu, 14 Mar 2024 10:14:50 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id p25-20020a1709061b5900b00a461d8335f2sm866369ejg.45.2024.03.14.10.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 10:14:49 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Denis Burkov <hitechshell@mail.ru>
Cc: Denis Burkov <hitechshell@mail.ru>
Subject: Re: [PATCH 2/2] ARM: dts: sun5i: Add PocketBook 614 Plus support
Date: Thu, 14 Mar 2024 18:14:48 +0100
Message-ID: <2451572.jE0xQCEvom@jernej-laptop>
In-Reply-To: <20240314155306.11521-2-hitechshell@mail.ru>
References:
 <20240314155306.11521-1-hitechshell@mail.ru>
 <20240314155306.11521-2-hitechshell@mail.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Denis!

Dne =C4=8Detrtek, 14. marec 2024 ob 16:53:06 CET je Denis Burkov napisal(a):
> What works:
>=20
> - Serial console
> - mmc0, mmc2 (both microSD card slots on the board)
> - All buttons (gpio and lradc based)
> - Power LED
> - PMIC
> - RTC
> - USB OTG/gadgets mode
>=20
> Signed-off-by: Denis Burkov <hitechshell@mail.ru>
> ---
>  arch/arm/boot/dts/allwinner/Makefile          |   2 +
>  .../sun5i-a13-pocketbook-614-plus.dts         | 254 ++++++++++++++++++
>  2 files changed, 256 insertions(+)
>  create mode 100644 arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-=
plus.dts
>=20
> diff --git a/arch/arm/boot/dts/allwinner/Makefile b/arch/arm/boot/dts/all=
winner/Makefile
> index 2d26c3397f14..fe321865beed 100644
> --- a/arch/arm/boot/dts/allwinner/Makefile
> +++ b/arch/arm/boot/dts/allwinner/Makefile
> @@ -61,6 +61,7 @@ dtb-$(CONFIG_MACH_SUN5I) +=3D \
>  	sun5i-a13-olinuxino.dtb \
>  	sun5i-a13-olinuxino-micro.dtb \
>  	sun5i-a13-pocketbook-touch-lux-3.dtb \
> +	sun5i-a13-pocketbook-614-plus.dtb \
>  	sun5i-a13-q8-tablet.dtb \
>  	sun5i-a13-utoo-p66.dtb \
>  	sun5i-gr8-chip-pro.dtb \
> @@ -82,6 +83,7 @@ dtb-$(CONFIG_MACH_SUN5I) +=3D \
>  	sun5i-a13-olinuxino.dtb \
>  	sun5i-a13-olinuxino-micro.dtb \
>  	sun5i-a13-pocketbook-touch-lux-3.dtb \
> +	sun5i-a13-pocketbook-614-plus.dtb \
>  	sun5i-a13-q8-tablet.dtb \
>  	sun5i-a13-utoo-p66.dtb \
>  	sun5i-gr8-chip-pro.dtb \

This merge artefact. Can you add patch before this one and remove duplicate=
 definitions?

> diff --git a/arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dt=
s b/arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts
> new file mode 100644
> index 000000000000..89898fa16ff7
> --- /dev/null
> +++ b/arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts
> @@ -0,0 +1,254 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 Denis Burkov <hitechshell@mail.ru>
> + */
> +
> +/dts-v1/;
> +#include "sun5i-a13.dtsi"
> +#include "sunxi-common-regulators.dtsi"

Extra empty line here.

> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	model =3D "PocketBook 614 Plus";
> +	compatible =3D "pocketbook,614-plus", "allwinner,sun5i-a13";
> +
> +	aliases {
> +		serial0 =3D &uart1;
> +		i2c0 =3D &i2c0;
> +		i2c1 =3D &i2c1;
> +		i2c2 =3D &i2c2;
> +		rtc0 =3D &pcf8563;

Please drop aliases except serial0.

> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&led_pins_pocketbook>;

Drop pinctrl nodes. GPIOs don't need them.

> +
> +		led {
> +			gpios =3D <&pio 4 8 GPIO_ACTIVE_LOW>; /* PE8 */
> +			default-state =3D "on";

Add additional properties, like function and color.

> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible =3D "gpio-keys";
> +		autorepeat;

Why is autorepeat needed?

> +		label =3D "GPIO Keys";

I guess label is self evident and not needed?

> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pocketbook_btn_pins>;

Again, GPIOs don't need pinctrl nodes. I know that you specified pull up, b=
ut
please try without. Other boards have same design and it's not needed.

> +
> +		key-right {
> +			label =3D "Right";
> +			linux,code =3D <KEY_NEXT>;
> +			gpios =3D <&pio 6 9 GPIO_ACTIVE_LOW>; /* PG9 */
> +		};
> +
> +		key-left {
> +			label =3D "Left";
> +			linux,code =3D <KEY_PREVIOUS>;
> +			gpios =3D <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 */
> +		};
> +	};
> +
> +	reg_3v3_mmc0: regulator-mmc0 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vdd-mmc0";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pocketbook_reg_mmc0_pins>;

again, pinctrl not needed.

> +		gpio =3D <&pio 4 4 GPIO_ACTIVE_LOW>; /* PE4 */
> +		vin-supply =3D <&reg_vcc3v3>;
> +	};
> +};
> +
> +&cpu0 {
> +	cpu-supply =3D <&reg_dcdc2>;
> +};
> +
> +&ehci0 {
> +	status =3D "okay";
> +};
> +
> +&i2c0 {
> +	status =3D "okay";
> +
> +	axp209: pmic@34 {
> +		compatible =3D "x-powers,axp209";
> +		reg =3D <0x34>;
> +		interrupts =3D <0>;
> +	};
> +};
> +
> +#include "axp209.dtsi"
> +
> +&i2c1 {
> +	status =3D "okay";
> +
> +	pcf8563: rtc@51 {
> +		compatible =3D "nxp,pcf8563";
> +		reg =3D <0x51>;
> +		#clock-cells =3D <0>;
> +	};
> +};
> +
> +&i2c2 {
> +	status =3D "okay";
> +
> +	/* Touchpanel is connected here. */

Any reason why don't you specify touch panel device here?

> +};
> +
> +&lradc {
> +	vref-supply =3D <&reg_ldo2>;
> +	status =3D "okay";
> +
> +	button-300 {
> +		label =3D "Down";
> +		linux,code =3D <KEY_DOWN>;
> +		channel =3D <0>;
> +		voltage =3D <300000>;
> +	};
> +
> +	button-700 {
> +		label =3D "Up";
> +		linux,code =3D <KEY_UP>;
> +		channel =3D <0>;
> +		voltage =3D <700000>;
> +	};
> +
> +	button-1000 {
> +		label =3D "Left";
> +		linux,code =3D <KEY_LEFT>;
> +		channel =3D <0>;
> +		voltage =3D <1000000>;
> +	};
> +
> +	button-1200 {
> +		label =3D "Menu";
> +		linux,code =3D <KEY_MENU>;
> +		channel =3D <0>;
> +		voltage =3D <1200000>;
> +	};
> +
> +	button-1500 {
> +		label =3D "Right";
> +		linux,code =3D <KEY_RIGHT>;
> +		channel =3D <0>;
> +		voltage =3D <1500000>;
> +	};
> +};
> +
> +&mmc0 {
> +	vmmc-supply =3D <&reg_3v3_mmc0>;
> +	bus-width =3D <4>;
> +	cd-gpios =3D <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
> +	status =3D "okay";
> +};
> +
> +&mmc2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mmc2_4bit_pc_pins>;
> +	vmmc-supply =3D <&reg_vcc3v3>;
> +	bus-width =3D <4>;
> +	non-removable;
> +	status =3D "okay";
> +};
> +
> +&ohci0 {
> +	status =3D "okay";
> +};
> +
> +&otg_sram {
> +	status =3D "okay";
> +};
> +
> +&pio {
> +	led_pins_pocketbook: led-pin {
> +		pins =3D "PE8";
> +		function =3D "gpio_out";
> +	};
> +	pocketbook_btn_pins: btn-pins {
> +		pins =3D "PG9", "PG10";
> +		function =3D "gpio_in";
> +		bias-pull-up;
> +	};
> +	pocketbook_reg_mmc0_pins: reg-mmc0-pins {
> +		pins =3D "PE4";
> +		function =3D "gpio_out";
> +	};
> +};

Whole PIO node can be dropped.

Best regards,
Jernej

> +
> +&reg_dcdc2 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <1000000>;
> +	regulator-max-microvolt =3D <1500000>;
> +	regulator-name =3D "vdd-cpu";
> +};
> +
> +&reg_dcdc3 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <1000000>;
> +	regulator-max-microvolt =3D <1400000>;
> +	regulator-name =3D "vdd-int-dll";
> +};
> +
> +&reg_ldo1 {
> +	regulator-name =3D "vdd-rtc";
> +};
> +
> +&reg_ldo2 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <3000000>;
> +	regulator-max-microvolt =3D <3000000>;
> +	regulator-name =3D "avcc";
> +};
> +
> +&reg_ldo3 {
> +	regulator-min-microvolt =3D <3300000>;
> +	regulator-max-microvolt =3D <3300000>;
> +	regulator-name =3D "vcc-wifi";
> +};
> +
> +&reg_usb0_vbus {
> +	status =3D "okay";
> +	gpio =3D <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
> +};
> +
> +&reg_usb1_vbus {
> +	gpio =3D <&pio 6 11 GPIO_ACTIVE_HIGH>; /* PG11 */
> +	status =3D "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart1_pg_pins>;
> +	status =3D "okay";
> +};
> +
> +&usb_otg {
> +	dr_mode =3D "otg";
> +	status =3D "okay";
> +};
> +
> +&usb_power_supply {
> +	status =3D "okay";
> +};
> +
> +&battery_power_supply {
> +	status =3D "okay";
> +};
> +
> +&usbphy {
> +	usb0_id_det-gpios =3D <&pio 6 2 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* =
PG2 */
> +	usb0_vbus_det-gpios =3D <&axp_gpio 1 GPIO_ACTIVE_HIGH>;
> +	usb0_vbus-supply =3D <&reg_usb0_vbus>;
> +	usb1_vbus-supply =3D <&reg_usb1_vbus>;
> +	status =3D "okay";
> +};
>=20





