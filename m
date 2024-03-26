Return-Path: <linux-kernel+bounces-120064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B09988D119
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B2332201B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A7913D8B2;
	Tue, 26 Mar 2024 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2JoGDaR"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFBA13DDA4;
	Tue, 26 Mar 2024 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492653; cv=none; b=PV1Ho6xL6GXwqzc3ngwgtUI+UIg3o6rWWsESuao98JVGI4AqLJNo11VeAJ31/C13a1zsyjRcGLgf5WfcpdqM/FXXm2e2V+ZtRKpAHpTJC0mpH0PO/sGxU/eoRLHo8hYUQ3v1lzryEzlVtp1Qd9wl5TlkYox9zLgHJb4+E9DL64E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492653; c=relaxed/simple;
	bh=4yoVptj1UWplyDzAq7Tjl/TVNzbjsEvuyOqlRXRE7k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pcgPTtS8dTRWE6y0MspN425bFPq/mOzD12i/ewTbdb/1YFnRb1ydV4shYjoXRAh6EUfttLDnOXxLaLqraIoZdhQRRvx2ru/NMq3fTIUdgEGJfqKd6gqmE6bvoZSouT6F61MpEINxOJU2k0U944quyUM3Iv93/wN9Y+Fihhexksk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2JoGDaR; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d0486cf91aso131633739f.1;
        Tue, 26 Mar 2024 15:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711492650; x=1712097450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SA/GLZl3h7HpI8vEB/ZyUsu3mvxu5V+a+bI3pQOrjds=;
        b=D2JoGDaRQ5wUcLKWRnFPl2dwLRcr2zEfR7jf+c67L12ldw3OVKEscIjM3AP5zryz47
         +yoCd++nJSVmv9eaoxVE6dm9tYk7pwNK04Un28Nene33Z/eaJT5N/di00+ohKGRuDk92
         ZOGIWAfAK//kt1zXdJ1bVApGrYsW1MbGA8VY0jt1kc+WzrEtMLeWQbLFjRnaIIkydubo
         fBh2IoqzmD8tpxHC5iTujRS2cz2A6vLEmP/bd8RSd06LYLg8olfRl1aKlDrwYKFl5kJS
         uXP109P/eneanuBzpkxbDnHFNDKRpuVI2vPD2ePJUpNPws0G+7Epk4luVcEM/e9vvA8P
         /XNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711492650; x=1712097450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SA/GLZl3h7HpI8vEB/ZyUsu3mvxu5V+a+bI3pQOrjds=;
        b=c50WwUz8t/cPGeSdF1Ltlsll8dIcdCM+9yMRxkY/zbWvPJngJ01hU5yxOj1YQDBQ8Q
         v5I1ymBf7DdoDisgwKr0xY/ivmzWTmyJHTtIHwIU4ugTksM072IjaOJPw63xrLlkDoLN
         DZDBIr8Jj7kmfdPTjHQndBYvg6tJj1s0/bmBX67spfLw6P20JXa9a8eBYszOoEGdlxU3
         IQA2vU9c1t26l3NmKnG+waXHExqkxE9MuIJ9P6UresN6ZhtVq0OKaCOT9+kVdJ1imN+Z
         kNiFl14LPAE9SLa/eBDgL1XrEqWdws8SJnoFr3uG5XlIt6jStR70vEX9ek3Suhq0hkjo
         t0mw==
X-Forwarded-Encrypted: i=1; AJvYcCW8XyhZhzH8WCzdlRXI00s7B5KVpSCCgFhRC4R4xMI+Otd2i+Cd96FllmRT63lLxdmUXkogYm9QP3b+AoKnNC0mBd5jlVyo4C3tepxnFGx2WYPMDAhxMlSyYw61KVoCfy2+thP2xerhAw==
X-Gm-Message-State: AOJu0YzStrzeItEVs9LPeN4i66FTG6S11blLpKbP750qWd5NQanW7TQx
	UFocLahCLnS6olHBGLox0tJ4sPz8v+7Nx8Yov5kfpNTkd6CvWnoI
X-Google-Smtp-Source: AGHT+IEsZu1f6Tc3oBDcbNx9nMtrh3Lz5apUbtKBHtrG7Zi1dBfQ06ge4SOqm91WZkV/knfGjfY5oQ==
X-Received: by 2002:a05:6602:1d54:b0:7d0:5735:c460 with SMTP id hi20-20020a0566021d5400b007d05735c460mr7502224iob.3.1711492650493;
        Tue, 26 Mar 2024 15:37:30 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id it21-20020a056638859500b0047436275c32sm2950406jab.1.2024.03.26.15.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:37:30 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Denis Burkov <hitechshell@mail.ru>
Cc: Denis Burkov <hitechshell@mail.ru>
Subject: Re: [PATCH v2 2/2] ARM: dts: sun5i: Add PocketBook 614 Plus support
Date: Tue, 26 Mar 2024 23:37:26 +0100
Message-ID: <1959471.PYKUYFuaPT@jernej-laptop>
In-Reply-To: <20240317083445.4668-2-hitechshell@mail.ru>
References:
 <20240317083445.4668-1-hitechshell@mail.ru>
 <20240317083445.4668-2-hitechshell@mail.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 17. marec 2024 ob 09:34:45 CET je Denis Burkov napisal(a):
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

led-0 is preferred by the DT binding. Please also add function and color
properties.

Please run DT check with W=2 to catch andy other potential issues.

Best regards,
Jernej

> +			gpios = <&pio 4 8 GPIO_ACTIVE_LOW>; /* PE8 */
> +			default-state = "on";
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		key-right {

Key node names should contain key-[number], starting with 0.

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





