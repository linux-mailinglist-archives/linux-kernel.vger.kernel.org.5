Return-Path: <linux-kernel+bounces-145899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 819158A5C89
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B101C211C6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5163156987;
	Mon, 15 Apr 2024 21:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dw28GtvE"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D26154452;
	Mon, 15 Apr 2024 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713214800; cv=none; b=aaTZ9VSipQ1FLo4AIINurRE5br0dvvF9OkIZSRag2zbwwPPTf82yarFEjvDAOoK/sbHQoC2Ed1kWIpeYTWK1i1Dv97mjtkCtvrgiS8w7UnaltGGelUCp8BWx3rk0DspBysCntSd4X4ASztOe+eiJZv7RzLhFjutrI9m4S8HlZOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713214800; c=relaxed/simple;
	bh=keE5gXK1XFIrGCoNiU9ypadSV5+vTDdVveV1QseHIM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upDpcaNl0MABvZuAh0yhvIBT4/UlRkpa7bvduMHuP8yNqYneG9RG0NL7V2C4GVJ8Pn20R45Ur/tFDlmqO3r2SRPM7hjBT2X3Jj0M+I0tQeBvPY9SsXdmXvS8aV5u8v2tHfWmLidUH5Hhos5sRdiObjSKwdTFNx269VoFYKhkfdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dw28GtvE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-343d7ff2350so2661508f8f.0;
        Mon, 15 Apr 2024 13:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713214796; x=1713819596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIujiiQ5KBMmQZ0xSWh9oPvw+odeP026KffyQO/ahy4=;
        b=Dw28GtvEi4nM+YcyqqPqbQrMxTWJ65y0R7L3Y77ABLT4VJrv3MuS34um36Hg4zugG+
         IW0HRiVGYd8Ye1hn+epH40TR7qP20S/3vVjgMCrJWIq5rwhLrdxrqipKqg9qDzH9d8vw
         Cat8Qb2++yPucnsuAFlxTo+pR4kFcROB6alN5BCkcF84hpR1TA8bCYxrbZKzvmSq+KVW
         EJ4rNVqvBZQsV6kIssQg97XqZKc1SDl6kjykgOUod0vBg9W57jB5Xezofn4Ja3b2yaij
         oNH9FMc5fI0MKCKqk5HsmeevCp4YgrtyoHWUTAcZhIlqtT3Z46eDZ/mr93ExHUf9gI0r
         PaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713214796; x=1713819596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIujiiQ5KBMmQZ0xSWh9oPvw+odeP026KffyQO/ahy4=;
        b=k1pQdA1qlOzmH3hT1CG4tULdWalmdv3cmSDbWFzybco+HTloXnOBoOsgNelQ4mUvRC
         MGUAHboP03FCB7AG7u8D4/s0jbVQNoHtp5iO41Z2K6aXaEuenqepUjeKYhVkuNeGjSH8
         kjftx4bQMOF/0p6FelhJHhmFsjVlnKJCa/2OSPj3UJheg8c+qQ2hpX+ZCwkd+Axa/gWX
         PUvZxOwIw1QHa4ViqB/q4e2Pi7SmqhaWsz0Yi1ByokEtrFIOhgiIlsvHhkkF6ceIfost
         s/qv6fe4HFnnR2pULSGj+NPibuy9U90/TQdYCGRs/2vvwlRzqvDX1ybz0nivVaPITGpU
         7l0A==
X-Forwarded-Encrypted: i=1; AJvYcCVuDJIWeUyJNpVYDnjbGF9QyHnWVVQ9vJmt62vPQSbOybpDxoBBhbtY7xDQpcaRgUmLDM+iWUDfjaD21uGzrSVoshB2mDYbXIk9Ghbrtc/EwzHeTkQFo1Y7+q41aqGgESUUvBjJPBSdrQ==
X-Gm-Message-State: AOJu0YwS2CtBffP0pjLqftfybwj+zPt69BYtJbMsWpVakPnrcggsItGj
	n3lHtZ8RDgvsq2pPzq6dnZATH+ATc60+UOFjsg8JnLzM/3VCX6w6
X-Google-Smtp-Source: AGHT+IHLt75Hbddgm1n0rfPGmNATVpDEyp3DLt4Oh+UEnPfrQwWDQqwHqZKyKiUIUtDQczSdsXcfIA==
X-Received: by 2002:a05:6000:1150:b0:343:a117:7d2 with SMTP id d16-20020a056000115000b00343a11707d2mr6499005wrx.71.1713214796199;
        Mon, 15 Apr 2024 13:59:56 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id d15-20020adffbcf000000b0034720354152sm9450736wrs.117.2024.04.15.13.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 13:59:55 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Denis Burkov <hitechshell@mail.ru>
Cc: Denis Burkov <hitechshell@mail.ru>
Subject: Re: [RESEND v3 2/2] ARM: dts: sun5i: Add PocketBook 614 Plus support
Date: Mon, 15 Apr 2024 22:59:54 +0200
Message-ID: <2178156.irdbgypaU6@jernej-laptop>
In-Reply-To: <20240415173416.13838-2-hitechshell@mail.ru>
References:
 <20240415173416.13838-1-hitechshell@mail.ru>
 <20240415173416.13838-2-hitechshell@mail.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 15. april 2024 ob 19:34:16 GMT +2 je Denis Burkov napisal(a):
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

You haven't provided changelog for v3.

Checkpatch doesn't complain, so:
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm/boot/dts/allwinner/Makefile          |   1 +
>  .../sun5i-a13-pocketbook-614-plus.dts         | 218 ++++++++++++++++++
>  2 files changed, 219 insertions(+)
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
> index 000000000000..ab8d138dc11d
> --- /dev/null
> +++ b/arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614-plus.dts
> @@ -0,0 +1,218 @@
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
> +#include <dt-bindings/leds/common.h>
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
> +		led-0 {
> +			color = <LED_COLOR_ID_WHITE>;
> +			function = LED_FUNCTION_POWER;
> +			linux,default-trigger = "default-on";
> +			gpios = <&pio 4 8 GPIO_ACTIVE_LOW>; /* PE8 */
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		key-0 {
> +			label = "Right";
> +			linux,code = <KEY_NEXT>;
> +			gpios = <&pio 6 9 GPIO_ACTIVE_LOW>; /* PG9 */
> +		};
> +
> +		key-1 {
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





