Return-Path: <linux-kernel+bounces-63492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0829853054
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5ED1F242BA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515053C486;
	Tue, 13 Feb 2024 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T5Tdd+aB"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0608737715
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826604; cv=none; b=p3M5M+pyH7mnhyyMYixwT0qFkdHXc+mf+IBeMgG+3UMtZW3lWJU5cBQQi9rtCkuz2zQFQyKIwj+R+JyfJD7tv0HBCtgzPhRSVUrB7mYZD1l/0t53ZgFqtqkUV+dNzH3BSVU/YveMkcbHFDbypvNpQT0c7O1wYNPChRD6TpfkINE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826604; c=relaxed/simple;
	bh=eQKcWv8ehomvZXrP5QdQtoxuR9kXHOHCFhwzoLoKSiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WleqcLutkTUdfGCvu3dq3pDxYUk/gFNbi79IrlAFvXRhG/+7obgkXmcUOzdg/Qa5pOlXrvyjpvSFWqBeKWuLYUQ8xPcwgtKYE/00NaDKTG3JJX12ZXmm+5H1ZCPQ9zlGUE5kE34xPzbjvyMLUmB4LzZzKjPBfoRen4Pis44eeLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T5Tdd+aB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-411bf7e5c6bso3451815e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 04:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707826600; x=1708431400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XvutVI4vhckb36wRv9xQ3G85CklqzEdmIVWxR5pe3EM=;
        b=T5Tdd+aBgV7PDEPUUivUXEJwLN6joe58TZWugAiqNFKTuf7WjaxgA+eZrScbGzgtKW
         bLEAbgw/zeY5+C/9LWNqS0ZMxWlqayxxFnGGlQpSqRyF06NMgA17pg6AsHHYBGqXTKK8
         5yPDBGP0FqY+QulGWR//iA9jzn2y0gDSvUci4PHZx1TohRlmuDouOWFN75WVdRr/l2Xa
         rINAJJ+N9fugxvDTlyCD+K89p/wHAqin+o1InXb89ddxr88NSR64bahYlHp9zjMZA7Yf
         GHoU6isioriws34HpeOSi8cySL9BhQZRj9dkzOCbMXVltYFmqv8Kxs/0uiJEcc785TTS
         nrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707826600; x=1708431400;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XvutVI4vhckb36wRv9xQ3G85CklqzEdmIVWxR5pe3EM=;
        b=bR2pw9Iljj5bjRt9gJTlfA9VUsOpPcfj4I/SbeVyLNOSMYTTJMoSNMzTDlnjS2SvwK
         ATvo72+Jf7Xf6WOOvGmBkxMHSbsYFem4hr3PtrNdXIaNSOL7HJAPlxL3Zc+JRyWtuALJ
         vYR44lSkC5C8+IMKa6S5DiXyLoQEPiTVQsV0H5IcN52B1I8qP0xfao6JdMSpeVWtYDfp
         ZOTmcqU746eYQ92T1EcqMLLtb7J7VceGjKLNg0RsIq5n/mcfKf2Q3a+OgCy+moMEm68O
         F7nd+dgFQWtHvJsxQLhJratJ37oSBLuhUBtabZSV3YmX+NqrIAnJXGPcvWR/yWKh/Bh8
         jb4Q==
X-Gm-Message-State: AOJu0YzAdZ7FrneUNLpHiFAxFxQnExot6GwNpTPlvflpFEyRfnesh4lZ
	SklewcKHI+nDZa0O9avpR/JR18fb2dkzFhNxpdKtbi4KM0OXc4FZmCsTXPkTilQ=
X-Google-Smtp-Source: AGHT+IEtHfBXMOT9CM9N7oyWHcsHOKqjjg//DUpPNnRVSpiHzVrxZ1PrkDoSJkMd+7Z1+eVvtutukQ==
X-Received: by 2002:a05:600c:474d:b0:40e:55ca:5a48 with SMTP id w13-20020a05600c474d00b0040e55ca5a48mr7875172wmo.16.1707826600210;
        Tue, 13 Feb 2024 04:16:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyRO2lA00i33UiEjlwdueBFo8tkoN7ppioYMbPi4QR8dt3QSQdQl5NIU0j6eDZ/7RcTnZD1LUH7vaLHfwpCvSpvRjVCvN3rdsS1ISEgJoimoyd5V8rHa7KYW68QlJ6O711+ar2Nu9kw/z8iBz5rWjrHVWPZMDcBjK0NcRVGcMLQj+CxrHYJC0DGMYh+S7m+7WjlR5nKIgF6SUZyhohhcZWtbZDLtmQ3y+W3PwBo7Apwf1nTc4N8YwM5N0qKForrwYUNTegBObGNppFsBxvhaqXOY/OtaYxlsLcLuZpPItDu8JapHUVIXhyGcdtKtEWuwATIKsrx0wpZ6vQXBHl0Onx4ZNXFbfO8D5/wnadezMvxYnXexD7zlQWV5TY0G9l+BygwvaXx5qFHEJ4uM6pKAlSrrlp78KgeRIvAbLLNgIWyZuPtM2766o1
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b00410709fa0d3sm11781414wmq.33.2024.02.13.04.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 04:16:39 -0800 (PST)
Message-ID: <1895b682-288c-4645-bc8e-2e4c364e7de1@linaro.org>
Date: Tue, 13 Feb 2024 13:16:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: microchip: sama7g54_curiosity: Add initial
 device tree of the board
Content-Language: en-US
To: Mihai Sain <mihai.sain@microchip.com>, claudiu.beznea@tuxon.dev,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 andre.przywara@arm.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cristian.birsan@microchip.com
References: <20240213085614.26804-1-mihai.sain@microchip.com>
 <20240213085614.26804-4-mihai.sain@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240213085614.26804-4-mihai.sain@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2024 09:56, Mihai Sain wrote:
> Add initial device tree of the SAMA7G54 Curiosity board.
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> ---
>  arch/arm/boot/dts/microchip/Makefile          |   4 +-
>  .../dts/microchip/at91-sama7g54_curiosity.dts | 491 ++++++++++++++++++
>  2 files changed, 494 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts
> 
> diff --git a/arch/arm/boot/dts/microchip/Makefile b/arch/arm/boot/dts/microchip/Makefile
> index efde9546c8f4..29b2a788748f 100644
> --- a/arch/arm/boot/dts/microchip/Makefile
> +++ b/arch/arm/boot/dts/microchip/Makefile
> @@ -12,6 +12,7 @@ DTC_FLAGS_at91-sama5d3_eds := -@
>  DTC_FLAGS_at91-sama5d3_xplained := -@
>  DTC_FLAGS_at91-sama5d4_xplained := -@
>  DTC_FLAGS_at91-sama7g5ek := -@
> +DTC_FLAGS_at91-sama7g54_curiosity := -@
>  dtb-$(CONFIG_SOC_AT91RM9200) += \
>  	at91rm9200ek.dtb \
>  	mpa1600.dtb
> @@ -87,7 +88,8 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
>  	at91-sama5d4ek.dtb \
>  	at91-vinco.dtb
>  dtb-$(CONFIG_SOC_SAMA7G5) += \
> -	at91-sama7g5ek.dtb
> +	at91-sama7g5ek.dtb \
> +	at91-sama7g54_curiosity.dtb
>  
>  dtb-$(CONFIG_SOC_LAN966) += \
>  	lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb \
> diff --git a/arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts
> new file mode 100644
> index 000000000000..c2955a170658
> --- /dev/null
> +++ b/arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts
> @@ -0,0 +1,491 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * at91-sama7g54_curiosity.dts - Device Tree file for SAMA7G54 Curiosity Board
> + *
> + * Copyright (C) 2024 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Mihai Sain <mihai.sain@microchip.com>
> + *
> + */
> +/dts-v1/;
> +#include "sama7g5-pinfunc.h"
> +#include "sama7g5.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/mfd/atmel-flexcom.h>
> +#include <dt-bindings/pinctrl/at91.h>
> +
> +/ {
> +	model = "Microchip SAMA7G54 Curiosity";
> +	compatible = "microchip,sama7g54-curiosity", "microchip,sama7g5", "microchip,sama7";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 root=/dev/mmcblk1p2 rw rootwait";

What if user wants root from other place? What if mmc number changes,
which is actually happening all the time (hint: use partuuid)? Drop
root, it's not that helpful.

You also do not need console, so drop entire bootargs.


> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	aliases {
> +		serial0 = &uart3;
> +		i2c0 = &i2c10;
> +	};
> +
> +	clocks {
> +		slow_xtal {

No underscores in node names. Generic node names, so at least generic
prefix or suffix. Anyway you should override your properties via
phandle/label style.


> +			clock-frequency = <32768>;
> +		};
> +
> +		main_xtal {
> +			clock-frequency = <24000000>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_key_gpio_default>;
> +
> +		button-user {
> +			label = "user-button";
> +			gpios = <&pioA PIN_PD19 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_PROG1>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_led_gpio_default>;
> +		status = "okay";

Why do you need it? Was it disabled anywhere?

> +
> +		led-red {
> +			label = "red";

Use color and function instead.

> +			gpios = <&pioA PIN_PD13 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		led-green {
> +			label = "green";

Use color and function instead.

> +			gpios = <&pioA PIN_PD14 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		led-blue {
> +			label = "blue";

Use color and function instead.

> +			gpios = <&pioA PIN_PB15 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	memory@60000000 {
> +		device_type = "memory";
> +		reg = <0x60000000 0x10000000>; // 256 MiB DDR3L-1066 16-bit
> +	};
> +};
> +
> +&adc {
> +	vddana-supply = <&vddout25>;
> +	vref-supply = <&vddout25>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_mikrobus1_an_default &pinctrl_mikrobus2_an_default>;
> +	status = "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vddcpu>;
> +};
> +
> +&dma0 {
> +	status = "okay";
> +};
> +
> +&dma1 {
> +	status = "okay";
> +};
> +
> +&dma2 {
> +	status = "okay";
> +};
> +
> +&ebi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_nand_default>;
> +	status = "okay";
> +
> +	nand_controller: nand-controller {
> +		status = "okay";
> +
> +		nand@3 {
> +			reg = <0x3 0x0 0x800000>;
> +			atmel,rb = <0>;
> +			nand-bus-width = <8>;
> +			nand-ecc-mode = "hw";
> +			nand-ecc-strength = <8>;
> +			nand-ecc-step-size = <512>;
> +			nand-on-flash-bbt;
> +			label = "nand";
> +			status = "okay";

Was it disabled anywhere?

> +
> +			partitions {
> +				compatible = "fixed-partitions";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				at91bootstrap@0 {
> +					label = "nand: at91bootstrap";
> +					reg = <0x0 0x40000>;
> +				};
> +
> +				bootloader@40000 {
> +					label = "nand: u-boot";
> +					reg = <0x40000 0x100000>;
> +				};
> +
> +				bootloaderenv@140000 {
> +					label = "nand: u-boot env";
> +					reg = <0x140000 0x40000>;
> +				};
> +
> +				dtb@180000 {
> +					label = "nand: device tree";
> +					reg = <0x180000 0x80000>;
> +				};
> +
> +				kernel@200000 {
> +					label = "nand: kernel";
> +					reg = <0x200000 0x600000>;
> +				};
> +
> +				rootfs@800000 {
> +					label = "nand: rootfs";
> +					reg = <0x800000 0x1f800000>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&flx3 {
> +	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
> +	status = "okay";
> +
> +	uart3: serial@200 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_flx3_default>;
> +		status = "okay";
> +	};
> +};
> +
> +&flx10 {
> +	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
> +	status = "okay";
> +
> +	i2c10: i2c@600 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_flx10_default>;
> +		i2c-analog-filter;
> +		i2c-digital-filter;
> +		i2c-digital-filter-width-ns = <35>;
> +		status = "okay";
> +
> +		adc@1f {
> +			compatible = "microchip,pac1934";
> +			reg = <0x1f>;
> +		};
> +
> +		eeprom@51 {
> +			compatible = "atmel,24c02";
> +			reg = <0x51>;
> +			pagesize = <16>;
> +			size = <256>;
> +			status = "okay";

Was it disabled anywhere?

> +		};
> +
> +		mcp16502@5b {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +			compatible = "microchip,mcp16502";
> +			reg = <0x5b>;
> +			status = "okay";

Was it disabled anywhere?

> +
> +			regulators {
> +				vdd_3v3: VDD_IO {
> +					regulator-name = "VDD_IO";
> +					regulator-min-microvolt = <3300000>;
> +					regulator-max-microvolt = <3300000>;
> +					regulator-initial-mode = <2>;
> +					regulator-allowed-modes = <2>, <4>;
> +					regulator-always-on;
> +
> +					regulator-state-standby {
> +						regulator-on-in-suspend;
> +						regulator-suspend-microvolt = <3300000>;
> +						regulator-mode = <4>;
> +					};
> +
> +					regulator-state-mem {
> +						regulator-off-in-suspend;
> +						regulator-mode = <4>;
> +					};
> +				};
> +
> +				vddioddr: VDD_DDR {
> +					regulator-name = "VDD_DDR";
> +					regulator-min-microvolt = <1350000>;
> +					regulator-max-microvolt = <1350000>;
> +					regulator-initial-mode = <2>;
> +					regulator-allowed-modes = <2>, <4>;
> +					regulator-always-on;
> +
> +					regulator-state-standby {
> +						regulator-on-in-suspend;
> +						regulator-suspend-microvolt = <1350000>;
> +						regulator-mode = <4>;
> +					};
> +
> +					regulator-state-mem {
> +						regulator-on-in-suspend;
> +						regulator-suspend-microvolt = <1350000>;
> +						regulator-mode = <4>;
> +					};
> +				};
> +
> +				vddcore: VDD_CORE {
> +					regulator-name = "VDD_CORE";
> +					regulator-min-microvolt = <1150000>;
> +					regulator-max-microvolt = <1150000>;
> +					regulator-initial-mode = <2>;
> +					regulator-allowed-modes = <2>, <4>;
> +					regulator-always-on;
> +
> +					regulator-state-standby {
> +						regulator-on-in-suspend;
> +						regulator-suspend-voltage = <1150000>;
> +						regulator-mode = <4>;
> +					};
> +
> +					regulator-state-mem {
> +						regulator-off-in-suspend;
> +						regulator-mode = <4>;
> +					};
> +				};
> +
> +				vddcpu: VDD_OTHER {
> +					regulator-name = "VDD_OTHER";
> +					regulator-min-microvolt = <1050000>;
> +					regulator-max-microvolt = <1250000>;
> +					regulator-initial-mode = <2>;
> +					regulator-allowed-modes = <2>, <4>;
> +					regulator-ramp-delay = <3125>;
> +					regulator-always-on;
> +
> +					regulator-state-standby {
> +						regulator-on-in-suspend;
> +						regulator-suspend-voltage = <1050000>;
> +						regulator-mode = <4>;
> +					};
> +
> +					regulator-state-mem {
> +						regulator-off-in-suspend;
> +						regulator-mode = <4>;
> +					};
> +				};
> +
> +				vldo1: LDO1 {
> +					regulator-name = "LDO1";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +
> +					regulator-state-standby {
> +						regulator-suspend-voltage = <1800000>;
> +						regulator-on-in-suspend;
> +					};
> +
> +					regulator-state-mem {
> +						regulator-off-in-suspend;
> +					};
> +				};
> +
> +				vldo2: LDO2 {
> +					regulator-name = "LDO2";
> +					regulator-min-microvolt = <3300000>;
> +					regulator-max-microvolt = <3300000>;
> +					regulator-always-on;
> +
> +					regulator-state-standby {
> +						regulator-suspend-voltage = <3300000>;
> +						regulator-on-in-suspend;
> +					};
> +
> +					regulator-state-mem {
> +						regulator-off-in-suspend;
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&qspi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_qspi1_default>;
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0x0>;
> +		spi-max-frequency = <100000000>;
> +		spi-tx-bus-width = <4>;
> +		spi-rx-bus-width = <4>;
> +		m25p,fast-read;
> +		status = "okay";

Was it disabled anywhere?



Best regards,
Krzysztof


