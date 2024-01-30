Return-Path: <linux-kernel+bounces-44402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E731842197
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18BBD1F2BD0D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BDE65BDC;
	Tue, 30 Jan 2024 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VRuD1JJ8"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B04065BD6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611157; cv=none; b=smFhYb8b7dTL/8Rf9aG21e/U8yIHicyoexU7cq2QZGC8/5ZYE0AAsJqRjP4SZXhPFAVc8HkklLod8a4hF2i78Zntc6kDMHLv7yBQ41yCTXYcMaUla08+iz7y5FU/vDph28i8+CSYAlqDzi9CxfeABxviJIPgHNmVPL+Y6DKeMnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611157; c=relaxed/simple;
	bh=VnDWiFHpz2n8V0VUwmo+AQRYan5MZPEGRdHiesftkBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOAaeF9bM35ziXlnXrJYmq+m3pW8sE0r8w7xnoHm2AZgYL+EjJaNjoloKOkjlKoWQ0pi9ILRULFPju9IGVKdE+4eUyGBkbuWOH5bR5NvtomubRgRHOUZWfToOfGDTS/X15sLjcbhIPDELEHWqKj7LZP0GZeQ78NP3ArSNu+KjkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VRuD1JJ8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so703540466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706611153; x=1707215953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iI8XXdvnoWJemP9DToiKSauxmbJohw7cN4JxFxUB3iE=;
        b=VRuD1JJ8DwvlkR3HxPsRQK96chSt96xuNzzxrUbzAuTo2TE6iMcdQaVwYehCpleMXC
         xzHYS6sm1yZUvtLWvZq6XYj+Wvyt8PBF21N3Wy2zqqQqhuqwjT44oztuM0m5J4AhFy77
         ts40Thad8teqDJ3zvePirVebL3Hjyq2w8ckkjm6D3h0xA+8rz4dIVG9+KzKgKqbOThNr
         kom344AcCKMMriiJd9UtSXKM5hVM5Q68aXQvutbpaBWUzKKes6L8pF2DPHqo/7UcCS2l
         FAOCUT97VmPIYjk4UxL9goOXjiba3eq5X/vpS7HO3HNRDqliS6utPHFSQtF1eFAs/MkX
         ijyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706611153; x=1707215953;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iI8XXdvnoWJemP9DToiKSauxmbJohw7cN4JxFxUB3iE=;
        b=VRaPYoKTUf9TUKBvzcaMz+mvE2L1ONPbaB9grdy62HdGy7zQcy2gvu2flr3Q0JmeIr
         izScKBT+coCq+QzvCji4uQdPAcnzzofFqD2EFbEsDF0d0fQTy/5jHTwo9IMAASCG5I3w
         chlmZaq7fJgpNBWYfjGb27wkXgNnWqNckyqtbTNKyEScoNBu4I8GdDqxBNuFZNSa2C1H
         Pp/wT55KjCm7NgSSym1fWOyPCTO5DXsRnMTsb1t9JtDH6yQUw3hZK5WMMgpZ0fZLQP7X
         LQbR25NktZw8TBaLB5K6MSs3tOuqRvW2CdK5Mlg6UFNROewT8iG7uobr1CTU2p3pTDr0
         J+/Q==
X-Gm-Message-State: AOJu0YxouYmgc6oIoAWjZLZqTFUUrXA5w1vgPHx/p19uSybCCjKw8gPj
	gVA5OrFFQRQQ/jRc5OuMhHNRKFpNJqfOtCOpLVu4vy26tcZUGZ3S6//6mKndbvc=
X-Google-Smtp-Source: AGHT+IHFz4sJS8u3gZPfFT21MsslMRQ0Iwt1epxf5+WdiLrb+GSO7O9spQsF2PvwrrZw/n/q8peIIw==
X-Received: by 2002:a17:906:12d0:b0:a29:b31d:1dc6 with SMTP id l16-20020a17090612d000b00a29b31d1dc6mr1165816ejb.6.1706611153198;
        Tue, 30 Jan 2024 02:39:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWyvgAVV+qVv5Xkf1nbj7K9p/Dzu4k4e6BuHg58UclAWr100BL5UbA4wbMWftIB4Iv7aMoztTURTfrsvtACeJRfHJo76LzDn73KESei2gZy/NLMIHWaczbtLU3C+1pa+ShEMqZ9rMT+h3DA215RXgA4YS+1/iLlNONBWRgRCjmQTUbcDZYgkT1VDKdoij52O8J1rrYIhD9YCEgjlux9Z5zUMaF/rf6lmEyx6g5Se6AzSY3inobvV9TF/HXu4zOcnKWPY0pZUNiOSOO7dtxDyhrKVWeo6D1zcSpL6U8Q1Or4PELLDdWJXhjW/YrMA7esqWo89fPIseCdUSZnPcYD5T0/IlSLgA2DNGhArpjavHsZwrfjRiDB1B0D
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id st14-20020a170907c08e00b00a35c5491b58sm1947720ejc.174.2024.01.30.02.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 02:39:12 -0800 (PST)
Message-ID: <3edf1a47-9f73-4e99-98ea-182248102346@linaro.org>
Date: Tue, 30 Jan 2024 11:39:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: aspeed: asus: Add ASUS X4TF BMC
Content-Language: en-US
To: Kelly Hung <ppighouse@gmail.com>, robh+dt@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kelly_hung@asus.com
References: <20240130085652.198010-1-Kelly_Hung@asus.com>
 <20240130085652.198010-2-Kelly_Hung@asus.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240130085652.198010-2-Kelly_Hung@asus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 09:56, Kelly Hung wrote:
> From: kelly1732000 <Kelly_Hung@asus.com>
> 
> This initial device-tree provides the necessary configuration for
> basic BMC functionality and work on ASUS X4TF production.
> 
> Signed-off-by: kelly1732000 <Kelly_Hung@asus.com>
> ---
>  .../boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts  | 828 ++++++++++++++++++
>  1 file changed, 828 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts

It's impossible to test this file. You miss Makefile.

> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
> new file mode 100644
> index 000000000000..723bbb33137f
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
> @@ -0,0 +1,828 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2023 ASUS Corp.
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +
> +/ {
> +	model = "ASUS-X4TF";
> +	compatible = "asus,x4tf", "aspeed,ast2600";
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200n8 earlycon";

earlycon is a debugging feature, not mainline. Also, move console to
stdout-path, so entire bootargs can be dropped.

> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x40000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		gfx_memory: framebuffer {
> +			size = <0x01000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +
> +		video_engine_memory: video {
> +			size = <0x04000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +
> +		rvas_memory: rvas {
> +			size = <0x04000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +
> +		bmc_dev_memory: bmc_dev_memory {

No underscores in node names. This applies everywhere.


> +			size = <0x00100000>;
> +			alignment = <0x00100000>;
> +			compatible = "shared-dma-pool";
> +			no-map;
> +		};
> +
> +		pci_msi_memory: pci_msi_memory {
> +			no-map;
> +			reg = <0x9e770000 0x100>;
> +			compatible = "shared-dma-pool";
> +		};
> +		/* 1GB memory */
> +		vga_memory: region@bf000000 {
> +			no-map;
> +			compatible = "shared-dma-pool";
> +			reg = <0xbf000000 0x01000000>;  /* 16M */
> +		};
> +		ssp_memory: ssp_memory {
> +			size = <0x02000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			no-map;
> +		};
> +	};
> +
> +	vcc_sdhci0: regulator-vcc-sdhci0 {
> +		compatible = "regulator-fixed";
> +		status = "disabled";

Why? It makes it entirely pointless.

> +		regulator-name = "SDHCI0 Vcc";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpios = <&gpio0 ASPEED_GPIO(V, 0) GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	vccq_sdhci0: regulator-vccq-sdhci0 {
> +		compatible = "regulator-gpio";
> +		status = "disabled";

Pointless node.

> +		regulator-name = "SDHCI0 VccQ";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpios = <&gpio0 ASPEED_GPIO(V, 1) GPIO_ACTIVE_HIGH>;
> +		gpios-states = <1>;
> +		states = <3300000 1>,
> +			 <1800000 0>;
> +	};
> +
> +	vcc_sdhci1: regulator-vcc-sdhci1 {
> +		compatible = "regulator-fixed";
> +		status = "disabled";

Pointless node.


> +		regulator-name = "SDHCI1 Vcc";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpios = <&gpio0 ASPEED_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	vccq_sdhci1: regulator-vccq-sdhci1 {
> +		compatible = "regulator-gpio";
> +		status = "disabled";

Pointless node.

> +		regulator-name = "SDHCI1 VccQ";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpios = <&gpio0 ASPEED_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
> +		gpios-states = <1>;
> +		states = <3300000 1>,
> +			 <1800000 0>;
> +	};

Missing blank line.

> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> +				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> +				<&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
> +				<&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
> +	};
> +> +	video-engine@1e700000 {

Wrong placement. Also tools would tell you that.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +		compatible = "aspeed,ast2600-video-engine";
> +		reg = <0x1e700000 0x20000>;
> +		clocks = <&syscon ASPEED_CLK_GATE_VCLK>, <&syscon ASPEED_CLK_GATE_ECLK>;
> +		clock-names = "vclk", "eclk";
> +		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +		memory-region = <&video_engine_memory>;
> +		//resets = <&syscon ASPEED_RESET_VIDEO>;

Dead code.

> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		heartbeat {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +		uid_led {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			gpios = <&gpio0 ASPEED_GPIO(P, 1) (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
> +			default-state = "off";
> +		};

Missing blank line, everywhere.

> +		status_Y {
> +			gpios = <&gpio1 ASPEED_GPIO(B, 1) GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		sys_boot_status {
> +			gpios = <&gpio1 ASPEED_GPIO(B, 0) GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +	};
> +	spigpio {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).


> +		status = "okay";

Why?

> +		compatible = "spi-gpio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		sck-gpios = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
> +		mosi-gpios = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
> +		miso-gpios = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
> +		num-chipselects = <1>;
> +		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_HIGH>;
> +	};
> +

Redundant blank line.

> +};
> +
> +&adc0 {
> +	vref = <2500>;
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
> +		&pinctrl_adc2_default &pinctrl_adc3_default
> +		&pinctrl_adc4_default &pinctrl_adc5_default
> +		&pinctrl_adc6_default &pinctrl_adc7_default>;
> +};
> +
> +&adc1 {
> +	vref = <2500>;
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
> +		&pinctrl_adc10_default &pinctrl_adc11_default
> +		&pinctrl_adc12_default &pinctrl_adc13_default
> +		&pinctrl_adc14_default &pinctrl_adc15_default>;
> +};
> +
> +&peci0 {
> +	status = "okay";
> +};
> +
> +&lpc_snoop {
> +	snoop-ports = <0x80>;
> +	status = "okay";
> +};
> +
> +

Redundant blank line. Clean this code before sending upstream from such
trivialities.

> +&mdio0 {
> +	status = "disabled";
> +};
> +
> +
> +&mdio1 {
> +	status = "disabled";
> +};
> +
> +&mdio2 {
> +	status = "okay";
> +
> +	ethphy2: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +	};
> +};
> +
> +&mdio3 {
> +	status = "okay";
> +
> +	ethphy3: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +	};
> +};
> +
> +&mac0 {
> +	status = "disabled";
> +};
> +
> +&mac1 {
> +	status = "disabled";
> +};
> +
> +//for X4TF
> +&mac2 {
> +	status = "okay";
> +	phy-mode = "rmii";
> +	#phy-handle = <&ethphy2>;
> +	use-ncsi;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii3_default>;
> +};
> +
> +

Ditto

> +&mac3 {
> +	status = "okay";
> +	phy-mode = "rmii";
> +	#phy-handle = <&ethphy3>;
> +	use-ncsi;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii4_default>;
> +};
> +
> +

Ditto

> +&syscon {
> +	uart-clock-high-speed;

That's a syscon property?

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +	status = "okay";
> +};
> +
> +&rtc {
> +	status = "disabled";
> +};
> +
> +&fmc {
> +	status = "okay";
> +	flash@0 {
> +		status = "okay";

Drop. Everywhere where it is not needed.


> +		m25p,fast-read;
> +		label = "bmc-spi";
> +		spi-max-frequency = <50000000>;
> +		spi-bus-width = <1>;
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			bmc@0 {
> +				label = "bmc";
> +				reg = <0x0 0x4000000>;
> +			};
> +			u-boot@0 {
> +				label = "u-boot";
> +				reg = <0x0 0x200000>;
> +			};
> +			u-boot-env@1f0000 {
> +				label = "u-boot-env";
> +				reg = <0x1f0000 0x10000>;
> +			};
> +			kernel@200000 {
> +				label = "kernel";
> +				reg = <0x200000 0xc00000>;
> +			};
> +			rofs@a00000 {
> +				label = "rofs";
> +				reg = <0xa00000 0x2a00000>;
> +			};
> +			rwfs@2a00000 {
> +				label = "rwfs";
> +				reg = <0x2a00000 0x43f0000>;
> +			};
> +		};
> +	};
> +};
> +
> +&spi1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi1_default>;
> +
> +	flash@0 {
> +		status = "okay";
> +		w25q256,fast-read;
> +		label = "bios-spi";
> +		spi-max-frequency = <50000000>;
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			biosfullimg@0 {
> +				reg = <0x0 0x2000000>; //  32768 *1024 = 0x2000000, 32 MB
> +				label = "biosfullimg";
> +			};
> +		};
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +	tmp75@48 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation



> +		compatible = "ti,tmp75";
> +		reg = <0x48>;
> +	};
> +	tmp75@49 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

I am going to skip the rest. Please fix all the trivialities and test
your patches with tools.

Best regards,
Krzysztof


