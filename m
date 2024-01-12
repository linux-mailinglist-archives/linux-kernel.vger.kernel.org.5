Return-Path: <linux-kernel+bounces-24357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D266282BB7F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F5C8B22486
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11145C90B;
	Fri, 12 Jan 2024 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v47CiPYb"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11085C8EA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 07:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-336dcebcdb9so5444861f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 23:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705043564; x=1705648364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VyQMqEIG9Yx6gN2E8r2qI5zcxsBITIFlZVoTq2jHXVY=;
        b=v47CiPYbMkhnBeojXW76dkV30Y7Lilm1bsFxao01bQlTzVQfdme1+79AlfQ2yfk6Wi
         zjkBotZbPk+hjVdiErAJi4Ab8GELQtt3HbVfMlPWKCta1d/tO7YnhStPyQzGT4MMMGKP
         H/20sumAxfDX0jDlBI+jnTA+j08T+K7mG3rlf4CE1FQzgI+LKYooWIHp4vX/NPzrA7pi
         CcaAeGATvqcSelCMHaf6tDeKhP404NmCuodlZMeAM2JiKGG8xBKBoO6VeqS7mDpHf1aA
         Cv7so9KFQW0WrXpDZsXKz0zzYcGrjfudpjGo3IUvXXLalN/wlhjz0ynmSzO+EQacZlAB
         I8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705043564; x=1705648364;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VyQMqEIG9Yx6gN2E8r2qI5zcxsBITIFlZVoTq2jHXVY=;
        b=ORu3DYI6ewH8VLavmLWN0c61bhJ7le3qHhXfHBz5rpJ+QSAz5RR1U5hXibqy5xbtYY
         DAIRzB21b2y4ZI86qdHnfGYE8q67AkTQoMuA65kaj1xxP7VKz8kIOcriY1xaX5RxAwoa
         03hnyDibTyFgoACMn1aycUD7Zl3G3e9UxW/4gfuHyAjTcUEcUGf/8yVKsZRVnvS4G0bt
         r2QTO5B49Sa5Jf29aPOvunZV2nqhuKGqUq6D0XEebGiF8ttMMYDqw5M/C5MhdlG7aoLe
         lIdjF2LCMLyIVR6O/z7c+eYRIgYDs7SPSTwiyReGixqq5mUPHwRiHMENPpYeglBhPc7B
         ahfQ==
X-Gm-Message-State: AOJu0YwadiEcRpmFCbiQOJh5h5kckyPRsw5R9I6sBpSJfohDeb35gIbD
	+t3QrItnkQEPwMnuYbhlQ4PUUJxQX2QblA==
X-Google-Smtp-Source: AGHT+IEpTwLxv+LKltiPvaNNkDGvlv8AuoLuKeXXzrwth5Tbq6VIxNHN0ViDsUulRQ7tDzRnp+ChgA==
X-Received: by 2002:a05:6000:1281:b0:336:67f4:7111 with SMTP id f1-20020a056000128100b0033667f47111mr229376wrx.129.1705043564109;
        Thu, 11 Jan 2024 23:12:44 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id f6-20020adfb606000000b00336aa190139sm3018880wre.5.2024.01.11.23.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 23:12:43 -0800 (PST)
Message-ID: <ad0a2f94-51a5-4533-9e20-e891c6083ad3@linaro.org>
Date: Fri, 12 Jan 2024 08:12:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] ARM64: dts: nuvoton: Add initial yosemitev4 device
 tree
Content-Language: en-US
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz,
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>,
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>,
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240112013654.1424451-1-Delphine_CC_Chiu@wiwynn.com>
 <20240112013654.1424451-3-Delphine_CC_Chiu@wiwynn.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240112013654.1424451-3-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/01/2024 02:36, Delphine CC Chiu wrote:
> Add linux device tree entry related to
> Yosemite 4 specific devices connected to BMC SoC.
> 

Prefix is arm64, not ARM64.

> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  arch/arm64/boot/dts/nuvoton/Makefile          |    1 +
>  .../dts/nuvoton/nuvoton-npcm845-yosemite4.dts | 1493 +++++++++++++++++
>  2 files changed, 1494 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-yosemite4.dts
> 
> diff --git a/arch/arm64/boot/dts/nuvoton/Makefile b/arch/arm64/boot/dts/nuvoton/Makefile
> index 3bc9787801a5..2b3c03083dc0 100644
> --- a/arch/arm64/boot/dts/nuvoton/Makefile
> +++ b/arch/arm64/boot/dts/nuvoton/Makefile
> @@ -2,3 +2,4 @@
>  dtb-$(CONFIG_ARCH_MA35) += ma35d1-iot-512m.dtb
>  dtb-$(CONFIG_ARCH_MA35) += ma35d1-som-256m.dtb
>  dtb-$(CONFIG_ARCH_NPCM) += nuvoton-npcm845-evb.dtb
> +dtb-$(CONFIG_ARCH_NPCM) += nuvoton-npcm845-yosemite4.dtb
> diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-yosemite4.dts b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-yosemite4.dts
> new file mode 100644
> index 000000000000..f6a6a47b1397
> --- /dev/null
> +++ b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-yosemite4.dts
> @@ -0,0 +1,1493 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2023 Facebook Inc.
> +
> +/dts-v1/;
> +#include "nuvoton-npcm845.dtsi"
> +#include "nuvoton-npcm845-pincfg-evb.dtsi"
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/ {
> +	model = "Facebook Yosemite 4 BMC";
> +	compatible = "facebook,yosemite4-n-bmc", "nuvoton,npcm845";
> +
> +	aliases {
> +		serial4 = &serial0;
> +		serial0 = &serial1;
> +		serial1 = &serial3;
> +		serial2 = &serial4;
> +		serial3 = &serial5;
> +		serial5 = &cpld_serial0;
> +		serial6 = &cpld_serial1;
> +		serial7 = &cpld_serial2;
> +		serial8 = &cpld_serial3;
> +		fiu0 = &fiu0;
> +
> +		i2c16 = &imux16;
> +		i2c17 = &imux17;
> +		i2c18 = &imux18;
> +		i2c19 = &imux19;
> +		i2c20 = &imux20;
> +		i2c21 = &imux21;
> +		i2c22 = &imux22;
> +		i2c23 = &imux23;
> +		i2c24 = &imux24;
> +		i2c25 = &imux25;
> +		i2c26 = &imux26;
> +		i2c27 = &imux27;
> +		i2c28 = &imux28;
> +		i2c29 = &imux29;
> +		i2c30 = &imux30;
> +		i2c31 = &imux31;
> +		i2c32 = &imux32;
> +		i2c33 = &imux33;
> +		i2c34 = &imux34;
> +		i2c35 = &imux35;
> +		i2c36 = &imux36;
> +		i2c37 = &imux37;
> +	};
> +
> +	chosen {
> +		stdout-path = &serial0;
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x40000000>;
> +	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
> +			<&adc 4>, <&adc 5>, <&adc 6>, <&adc 7>;
> +	};
> +
> +	firmware {
> +		optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +		};
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		tip_reserved: tip@0x0 {
> +			reg = <0x0 0x0 0x0 0x6200000>;
> +		};
> +	};
> +
> +	spi_gpio: spi-gpio {
> +		compatible = "spi-gpio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		gpio-sck = <&gpio0 19 GPIO_ACTIVE_HIGH>; // GPIO19
> +		gpio-mosi = <&gpio0 18 GPIO_ACTIVE_HIGH>; // GPIO18
> +		gpio-miso = <&gpio0 17 GPIO_ACTIVE_HIGH>; // GPIO17
> +		num-chipselects = <1>;
> +		cs-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>; // GPIO203
> +
> +		tpmdev@0 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +			compatible = "tcg,tpm_tis-spi";

Please base on ongoing work adding specific compatibles.

> +			spi-max-frequency = <33000000>;
> +			reg = <0>;

reg is always after compatible.

> +		};
> +	};
> +
> +	cpld_serial0: cpld_uart@f8000800 {

Eh... so again you make the same mistakes and send the same downstream
poor code with the same bad patterns we asked to fix.

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		device_type = "serial";

compatible is always first, reg is second. Why do you need this property
anyway?

> +		compatible = "ns16450";
> +		reg = <0x0 0xf8000800 0x0 0x200>;
> +		reg-shift = <0>;
> +		clocks = <&clk NPCM8XX_CLK_UART>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +
> +	cpld_serial1: cpld_uart@f8000a00 {
> +		device_type = "serial";
> +		compatible = "ns16450";
> +		reg = <0x0 0xf8000a00 0x0 0x200>;
> +		reg-shift = <0>;
> +		clocks = <&clk NPCM8XX_CLK_UART>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +
> +	cpld_serial2: cpld_uart@f8000c00 {
> +		device_type = "serial";
> +		compatible = "ns16450";
> +		reg = <0x0 0xf8000c00 0x0 0x200>;
> +		reg-shift = <0>;
> +		clocks = <&clk NPCM8XX_CLK_UART>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +
> +	cpld_serial3: cpld_uart@f8000e00 {
> +		device_type = "serial";
> +		compatible = "ns16450";
> +		reg = <0x0 0xf8000e00 0x0 0x200>;
> +		reg-shift = <0>;
> +		clocks = <&clk NPCM8XX_CLK_UART>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +};
> +
> +&serial0 {
> +	status = "okay";
> +};
> +
> +&serial1 {
> +	status = "okay";
> +};
> +
> +&serial3 {
> +	status = "okay";
> +};
> +
> +&serial4 {
> +	status = "okay";
> +};
> +
> +&serial5 {
> +	status = "okay";
> +};
> +
> +&watchdog1 {
> +	status = "okay";
> +};
> +
> +&watchdog2 {
> +	status = "okay";
> +};
> +
> +&gmac2 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&r1_pins
> +			&r1oen_pins>;
> +	use-ncsi;
> +};
> +
> +&gmac3 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&r2_pins
> +			&r2oen_pins>;
> +	use-ncsi;
> +};
> +
> +&fiu0 {
> +	status = "okay";
> +	spi-nor@0 {

NAK

I am not going review further. You keep repeating the same mistakes.

Best regards,
Krzysztof


