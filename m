Return-Path: <linux-kernel+bounces-105264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EF687DB2F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 19:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F9B5B21166
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B6F1BF3B;
	Sat, 16 Mar 2024 18:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3DyflbR"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18CA1BC58;
	Sat, 16 Mar 2024 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710612417; cv=none; b=fYBuNFNjWUHm9aZYq1Dff5ZrKgj9S7nYM6ln5eUbAMU3KQQKkmMtZrevTSDkEdUfVnuiR9KDhQIKOFp2r6YIyW1LDpp1FMIWa6fcIdafjlFlCpLeU/HD4I7N9oWp/Uz44TmlqkNXuNdkpPHuRHduYvdowycScpVmj7UEXAycmNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710612417; c=relaxed/simple;
	bh=delWo0oqBSbnhRxxlbFP9+D2zHCWYl3h/XBpmVNOOtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUYTlXUFzSLNivrUK9SNKpTMmMVf0DTzqJlLTLvq/YJBAzI/LvQmCEz8i02ZvTJKGIGnWoIpWnRfNyijEVDxJ1mk69NwUqqNZt+2w8Ow9364Yw9PVCOcCHayXKp/VNwC+f6jKk08qlHM939/5+zK8tbyuKu6cqqEc9clhnJ3Yro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3DyflbR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41409fa3dc5so1783175e9.2;
        Sat, 16 Mar 2024 11:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710612414; x=1711217214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkXOvUv3CSNMR4S1kVhCPDF0jvEWGHLqB/wYYzvRGeA=;
        b=k3DyflbRZRQ6js+r6LBN5bFNkfUwT3tuMdIWaNAV4FYkwc85Dbf1o5Bo2NDnHPF9x0
         6z+obVgpa/W9Mn9Ri5A5cwRa6zKZ/VVT4KnaeOWThIEMvWoIOajD6hegq/edPuJg5uft
         6ZCiT8fNhWmpkjck7ZZyYjuzDlz0aJzbckcPkkGQ+R+uR/6KDdtIzW7bzw8mUXb1VRmB
         HdvNx9aJjmYI3nOhG32op3gVMCgrdfu9BM6HyyMChwbRmq8YEPCaUnpmVGBYIoVZbM+D
         Z5mMDNyBuHuwWaGwZ5poGVoeSRy5zWVer6OqqYAlaldIWDS8ekkw8bXMXFh27j4naoVJ
         OCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710612414; x=1711217214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkXOvUv3CSNMR4S1kVhCPDF0jvEWGHLqB/wYYzvRGeA=;
        b=CW3qAT6muzEk754v+U/Pirr6dJPx8hXpwuAr12yK+FjDXtCIU12tvIAYnkcoK4PLyO
         0n/JE7Tr26rTjM0/Tk7D0iP+B/oQjOuQyzp8b/LB/lpUoM4yfcW1rfv1t7nE52briU96
         fFgrvTjMHYptkR5+yKPP44JgjAIC0K2n3IMGH2uDQ26Zx6g9iX9JihcyuieNEPYBuaoP
         ovEGkGZosrUnf8oBfEThKw4/gyJ28/S0Dzd11f6RobfAhmWsvPrXZEHVlwEID/kpNtB9
         SyMjGJwymGa8fUwMLBHe7lFlg3tjYHXJsnijtXllfISCZMfbcDbBc+G8Ka5i4AI+9mwY
         tTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7VczoBD6v7ExrVuGtIQhxK3+bVrJ1AcbPbwVUReMTZDuveC2bOqW9GXg+onUtBw0icb65lXQfwYIfCUGCdXIz4iOHuo+oUVFH/ma0FQHWCAhtta3iGhiQsWy60k3uhElJ7sxXU2dwNw==
X-Gm-Message-State: AOJu0YzguFescODNT5sWW7SN9hjm8lrX6TVeFHy6o17TZGt+tfZZXLRl
	g6jt9ZTpjxK8sSqGFVBYDJNK6lGlgXwv5IB6MwW3I28Rk251rY9s
X-Google-Smtp-Source: AGHT+IGSc8+4gLqhuW2+RC7eeLKzM/1sXFmJ44RO3jrxC607yA6pvzIwN0uty2HMBlnpP8E4Y5aOXQ==
X-Received: by 2002:a5d:5412:0:b0:33e:c539:977d with SMTP id g18-20020a5d5412000000b0033ec539977dmr4764352wrv.22.1710612413685;
        Sat, 16 Mar 2024 11:06:53 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d694f000000b0033ec6a1b37esm5911643wrw.8.2024.03.16.11.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 11:06:53 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Denis Burkov <hitechshell@mail.ru>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Denis Burkov <hitechshell@mail.ru>
Subject: Re: [PATCH v2] ARM: dts: sun5i: Add PocketBook 614 Plus support
Date: Sat, 16 Mar 2024 19:06:51 +0100
Message-ID: <4874817.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <20240316144429.12529-1-hitechshell@mail.ru>
References:
 <4203654.1IzOArtZ34@jernej-laptop>
 <20240316144429.12529-1-hitechshell@mail.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Denis!

Before I review, please resend this series properly. It shouldn't be sent as
response to old series, but as a new thread. Also, it has to be complete, in
this case with first patch, with review/ack tags where applicable.

Best regards,
Jernej

Dne sobota, 16. marec 2024 ob 15:39:18 CET je Denis Burkov napisal(a):
> What works:
> 
> - Serial console
> - mmc0, mmc2 (both microSD card slots on the board)
> - All buttons (gpio and lradc based)
> - Power LED
> - PMIC
> - RTC
> - USB OTG/gadgets mode
> 
> Signed-off-by: Denis Burkov <hitechshell@mail.ru>
> ---
>  arch/arm/boot/dts/allwinner/Makefile          |   1 +
>  .../sun5i-a13-pocketbook-614-plus.dts         | 215 ++++++++++++++++++
>  2 files changed, 216 insertions(+)
>  create mode 100644 arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts
> 
> diff --git a/arch/arm/boot/dts/allwinner/Makefile b/arch/arm/boot/dts/allwinner/Makefile
> index 5fbb44ddacd0..6209243ad975 100644
> --- a/arch/arm/boot/dts/allwinner/Makefile
> +++ b/arch/arm/boot/dts/allwinner/Makefile
> @@ -61,6 +61,7 @@ dtb-$(CONFIG_MACH_SUN5I) += \
>  	sun5i-a13-olinuxino.dtb \
>  	sun5i-a13-olinuxino-micro.dtb \
>  	sun5i-a13-pocketbook-touch-lux-3.dtb \
> +	sun5i-a13-pocketbook-614-plus.dtb \
>  	sun5i-a13-q8-tablet.dtb \
>  	sun5i-a13-utoo-p66.dtb \
>  	sun5i-gr8-chip-pro.dtb \
> diff --git a/arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts b/arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts
> new file mode 100644
> index 000000000000..b5449301789a
> --- /dev/null
> +++ b/arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 Denis Burkov <hitechshell@mail.ru>
> + */
> +
> +/dts-v1/;
> +#include "sun5i-a13.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	model = "PocketBook 614 Plus";
> +	compatible = "pocketbook,614-plus", "allwinner,sun5i-a13";
> +
> +	aliases {
> +		serial0 = &uart1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led {
> +			gpios = <&pio 4 8 GPIO_ACTIVE_LOW>; /* PE8 */
> +			default-state = "on";
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		key-right {
> +			label = "Right";
> +			linux,code = <KEY_NEXT>;
> +			gpios = <&pio 6 9 GPIO_ACTIVE_LOW>; /* PG9 */
> +		};
> +
> +		key-left {
> +			label = "Left";
> +			linux,code = <KEY_PREVIOUS>;
> +			gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 */
> +		};
> +	};
> +
> +	reg_3v3_mmc0: regulator-mmc0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd-mmc0";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&pio 4 4 GPIO_ACTIVE_LOW>; /* PE4 */
> +		vin-supply = <&reg_vcc3v3>;
> +	};
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&reg_dcdc2>;
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	axp209: pmic@34 {
> +		compatible = "x-powers,axp209";
> +		reg = <0x34>;
> +		interrupts = <0>;
> +	};
> +};
> +
> +#include "axp209.dtsi"
> +
> +&i2c1 {
> +	status = "okay";
> +
> +	pcf8563: rtc@51 {
> +		compatible = "nxp,pcf8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +	};
> +};
> +
> +&lradc {
> +	vref-supply = <&reg_ldo2>;
> +	status = "okay";
> +
> +	button-300 {
> +		label = "Down";
> +		linux,code = <KEY_DOWN>;
> +		channel = <0>;
> +		voltage = <300000>;
> +	};
> +
> +	button-700 {
> +		label = "Up";
> +		linux,code = <KEY_UP>;
> +		channel = <0>;
> +		voltage = <700000>;
> +	};
> +
> +	button-1000 {
> +		label = "Left";
> +		linux,code = <KEY_LEFT>;
> +		channel = <0>;
> +		voltage = <1000000>;
> +	};
> +
> +	button-1200 {
> +		label = "Menu";
> +		linux,code = <KEY_MENU>;
> +		channel = <0>;
> +		voltage = <1200000>;
> +	};
> +
> +	button-1500 {
> +		label = "Right";
> +		linux,code = <KEY_RIGHT>;
> +		channel = <0>;
> +		voltage = <1500000>;
> +	};
> +};
> +
> +&mmc0 {
> +	vmmc-supply = <&reg_3v3_mmc0>;
> +	bus-width = <4>;
> +	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
> +	status = "okay";
> +};
> +
> +&mmc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc2_4bit_pc_pins>;
> +	vmmc-supply = <&reg_vcc3v3>;
> +	bus-width = <4>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&ohci0 {
> +	status = "okay";
> +};
> +
> +&otg_sram {
> +	status = "okay";
> +};
> +
> +&reg_dcdc2 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <1000000>;
> +	regulator-max-microvolt = <1500000>;
> +	regulator-name = "vdd-cpu";
> +};
> +
> +&reg_dcdc3 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <1000000>;
> +	regulator-max-microvolt = <1400000>;
> +	regulator-name = "vdd-int-dll";
> +};
> +
> +&reg_ldo1 {
> +	regulator-name = "vdd-rtc";
> +};
> +
> +&reg_ldo2 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <3000000>;
> +	regulator-max-microvolt = <3000000>;
> +	regulator-name = "avcc";
> +};
> +
> +&reg_usb0_vbus {
> +	status = "okay";
> +	gpio = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
> +};
> +
> +&reg_usb1_vbus {
> +	gpio = <&pio 6 11 GPIO_ACTIVE_HIGH>; /* PG11 */
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pg_pins>;
> +	status = "okay";
> +};
> +
> +&usb_otg {
> +	dr_mode = "otg";
> +	status = "okay";
> +};
> +
> +&usb_power_supply {
> +	status = "okay";
> +};
> +
> +&battery_power_supply {
> +	status = "okay";
> +};
> +
> +&usbphy {
> +	usb0_id_det-gpios = <&pio 6 2 GPIO_ACTIVE_HIGH>; /* PG2 */
> +	usb0_vbus_det-gpios = <&axp_gpio 1 GPIO_ACTIVE_HIGH>;
> +	usb0_vbus-supply = <&reg_usb0_vbus>;
> +	usb1_vbus-supply = <&reg_usb1_vbus>;
> +	status = "okay";
> +};
> 





