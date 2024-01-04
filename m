Return-Path: <linux-kernel+bounces-16338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F14B823D06
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DF7280D88
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ADC200B7;
	Thu,  4 Jan 2024 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZiCNCzIP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F3D20312
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5542a7f1f3cso270507a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 23:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704354871; x=1704959671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UHn9Ugkqr+y3vge4PYMFpoXgKhGknBDSsMB7++3Vp1I=;
        b=ZiCNCzIPWrpEinps2J/J2X4+Hzpae9zvlSm+VX6TYTgN+Dr4wpERU1nkvhiaA5x/KH
         eSS6ufV9bGY0l9QH5osgPR5QsLWkSOn3IdIGjr/65b0uZeYgcEgvRzYSy8W8d3/zdafy
         4G3Ycw9knfxjFBuDu4Lzm2DC9hkcHOxfrJSejNhsmRMEAtAcSjPlnmSSG2gymDU2D9O3
         3BHiVW6Z7jZAibAeDaCVLFhBQndRM7TFoyfjd3zniDGrXm7Eck2wb+8P4a6oz6NP9T0b
         VkCgQfx3Zf1DUpEJ//rewCzLLQi0pT0h/m2qN1j4wTJmkwhYcdi2XFc9CSz9jZw5iktc
         SZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704354871; x=1704959671;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHn9Ugkqr+y3vge4PYMFpoXgKhGknBDSsMB7++3Vp1I=;
        b=Ou9iUE3JvkeZPaG6TwYVijslel3aSRndPA02Bf+7Pcc3bTUJIFMRrdRO+7uxgLPCAP
         d5JiddWonvcWX2g0qc0iKixqt4ipaDuA4GFqF0MW08pxZmC/QTkdE+o9cv0WIewl23PH
         kwm7suhkfkWXD4/NKgbBachTWAPnUslEoJGscdFDnPcI8/jjOMgZgG4cO9nEddPgssTe
         3axuXGN44TOtATfk8VJxiPl6NBV6UAWg0omFcVvNtScksrm2qGuGced4FDxNaR1hSjG8
         GnsehWyRcoQ3I3LJxxwxAoxmlOQmNa2vAd3hV4nx90YhtRMAXWf+E7GCuZoPfmu5ESVJ
         xilw==
X-Gm-Message-State: AOJu0Yx4f4v/h9EsjipQ6jtDdSpVTuWBUqGHh4pez77SL0wOJQtG9Ktw
	VbJnpj3rioY/pYoPi2Ud11x00qM2y/oRng==
X-Google-Smtp-Source: AGHT+IHXVXa0hGta0md8FJ5WJOO0weIqbPnzglTnZv5g2qsy+yP+W9rIIVLgm/YEKRFBIJwIn2zLxQ==
X-Received: by 2002:a05:6402:886:b0:556:f8dc:5f69 with SMTP id e6-20020a056402088600b00556f8dc5f69mr114215edy.83.1704354870927;
        Wed, 03 Jan 2024 23:54:30 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id t15-20020a056402020f00b005534057c72dsm18301480edv.18.2024.01.03.23.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 23:54:30 -0800 (PST)
Message-ID: <eb90f92f-de58-42b2-8eb1-9d78e1fd7a60@linaro.org>
Date: Thu, 4 Jan 2024 08:54:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: add description for solidrun am642 som
 and evaluation board
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240103-add-am64-som-v1-0-dda1f9227aef@solid-run.com>
 <20240103-add-am64-som-v1-2-dda1f9227aef@solid-run.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240103-add-am64-som-v1-2-dda1f9227aef@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/01/2024 12:27, Josua Mayer wrote:
> Add description for the SolidRun AM642 SoM, and HummingBoard-T
> evaluation board.
> 
> The SoM features:
> - 1x cpsw ethernet with phy
> - 2x pru ethernet with phy
> - eMMC
> - spi flash (assembly option)
> 
> Additionally microSD and usb-2.0 otg are included in the SoM
> description as they are supported boot sources for the SOC boot-rom.
> 
> The Carrier provides:
> - 3x RJ45 connector
> - 2x M.2 connector
> - USB-2.0 Hub
> - USB-A Connector
> - LEDs
> - 2x CAN transceiver
> - 1x RS485 transceiver
> - sensors
> 
> The M.2 connectors support either USB-3.1 or PCI-E depending on status
> of a mux. By default the mux is switched off.
> 
> RFC: dtbs_check reports:
> 
> - error in pru ethernet:
> 
>   arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dtb: icssg1-eth: dmas: [[12, 49664, 15], [12, 49665, 15], [12, 49666, 15], [12, 49667, 15], [12, 49668, 15], [12, 49669, 15], [12, 49670, 15], [12, 49671, 15], [12, 16896, 15], [12, 16897, 15], [12, 16898, 0], [12, 16899, 0]] is too long
>   from schema $id: http://devicetree.org/schemas/net/ti,icssg-prueth.yaml#
>   arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dtb: icssg1-eth: Unevaluated properties are not allowed ('dmas' was unexpected)
>   from schema $id: http://devicetree.org/schemas/net/ti,icssg-prueth.yaml#
> 
>   It is caused by definint 12 dmas, when ti,icssg-prueth.yaml specifies a
>   maximum of 10. The pru ethernet on am64 mostly identical to am65 - see
>   e.g. arch/arm64/boot/dts/ti/k3-am654-idk.dtso which also defines 12 dma.
> 
>   At least for this revision I am skipping fixing the bindings, because
>   aside from raising the maximum to 12, dma-names also has just 10 entries
>   - and  don't know which names would be correct to add.
> 
> - undocumented compatible ti,bq25713 (battery charger)
> 
>   arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dtb: /bus@f4000/i2c@20000000/battery-charger@6a: failed to match any schema with compatible: ['ti,bq25713']
> 
>   This specific charger has no linux support yet, I am not sure where
>   (or whether) to document the new compatible.
>   The reference could also be dropped completely, since the charger is
>   not assebled by default.
> 
> - undocumented compatible for rtc: "abracon,abx80x"
> 
>   arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dtb: /bus@f4000/i2c@20010000/am1805aq@69: failed to match any schema with compatible: ['abracon,abx80x']
> 
>   It is actually documented in text format:
>   Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
> 
> - phy@0:cdns,phy-type:0:0: 0 is less than the minimum of 1
> 
>   arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dtb: serdes@f000000: phy@0:cdns,phy-type:0:0: 0 is less than the minimum of 1
>   from schema $id: http://devicetree.org/schemas/phy/phy-cadence-torrent.yaml#
> 
>   I used value 0 here on purpose (phy.h: #define PHY_NONE 0), however
>   maybe better to choose a specific protocol?
>   Or better to update binding and allow 0?
> 
> - interrupt properties not allowed for spi flash
> 
>   arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dtb: flash@0: Unevaluated properties are not allowed ('interrupt-parent', 'interrupts' were unexpected)
>   from schema $id: http://devicetree.org/schemas/mtd/jedec,spi-nor.yaml#
> 
>   The assembled flash memory "sh28hs512t" definitely has an interrupt
>   pin wired to a cpu gpio. Should interrupts be added to spi flash
>   binding?
> 
> - wrong names for pinctrl nodes
> 
>   arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dtb: pinctrl@f4000: 'ethernet-phy-pins-default', 'ethernet-phy0-pins-default', 'ethernet-phy1-pins-default', 'ethernet-phy2-pins-default', 'leds-pins-default', 'main-i2c0-pins-default', 'main-i2c0-pins-int-default', 'main-i2c1-int-pins-default', 'main-i2c1-pins-default', 'main-mcan0-pins-default', 'main-mcan1-pins-default', 'main-mmc1-pins-default', 'main-uart0-pins-default', 'main-uart3-pins-default', 'mdio0-pins-default', 'ospi0-flash0-pins-default', 'ospi0-pins-default', 'pcie0-pins-default', 'pru-rgmii1-pins-default', 'pru-rgmii2-pins-default', 'pru1-mdio0-pins-default', 'regulator-pcie-3v3-pins-default', 'regulator-vpp-1v8-pins-default', 'rgmii1-pins-default', 'serdes-mux-pins-default', 'usb0-pins-default' do not match any of the regexes: '-pins(-[0-9]+)?$|-pin$', 'pinctrl-[0-9]+'
> 
>   Other TI DTSs consistently end with *-pins-default. Should a different
>   naming convention be used?
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile                    |   1 +
>  arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts | 333 +++++++++++
>  arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi        | 638 +++++++++++++++++++++
>  3 files changed, 972 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 77a347f9f47d..041c3b71155e 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -32,6 +32,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
>  
>  # Boards with AM64x SoC
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts
> new file mode 100644
> index 000000000000..f7b48ada8ef3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
> + *
> + * DTS for SolidRun AM642 HummingBoard-T,
> + * running on Cortex A53.
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/phy/phy.h>
> +
> +#include "k3-am642.dtsi"
> +#include "k3-am642-sr-som.dtsi"
> +
> +/ {
> +	model = "SolidRun AM642 HummingBoard-T";
> +	compatible = "solidrun,am642-hummingboard-t", "solidrun,am642-sr-som", "ti,am642";
> +
> +	aliases {
> +		serial5 = &main_uart3;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&leds_pins_default>;
> +		status = "okay";

Where was it disabled?

> +
> +		/* D24 */
> +		led1: led-1 {
> +			label = "led1:green";

Use function and color instead.

> +			gpios = <&main_gpio0 29 GPIO_ACTIVE_HIGH>;
> +		};
> +
...

> +
> +&main_i2c0 {
> +	pinctrl-0 = <&main_i2c0_pins_default>, <&main_i2c0_int_pins_default>;
> +
> +	humidity-sensor@41 {
> +		compatible = "ti,hdc2010";
> +		reg = <0x41>;
> +		interrupt-parent = <&main_gpio0>;
> +		interrupts = <37 IRQ_TYPE_EDGE_FALLING>;
> +		status = "okay";

Where was it disabled?

> +	};
> +
> +	light-sensor@44 {
> +		compatible = "ti,opt3001";
> +		reg = <0x44>;
> +		interrupt-parent = <&main_gpio0>;
> +		interrupts = <37 IRQ_TYPE_EDGE_FALLING>;
> +		status = "okay";

Where was it disabled?

> +	};
> +
> +	battery-charger@6a {

charger@

> +		compatible = "ti,bq25713";
> +		reg = <0x6a>;
> +		status = "okay";

Where was it disabled?

> +	};
> +};
> +
> +&main_i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c1_pins_default>, <&main_i2c1_int_pins_default>;
> +	status = "okay";
> +
> +	rtc: am1805aq@69 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "abracon,abx80x";
> +		reg = <0x69>;
> +		abracon,tc-diode = "schottky";
> +		abracon,tc-resistor = <3>;
> +		interrupt-parent = <&main_gpio0>;
> +		interrupts = <44 IRQ_TYPE_EDGE_FALLING>;
> +		status = "okay";
Where was it disabled?

> +	};
> +};
> +

...

> +
> +&serdes0 {
> +	/*
> +	 * Serdes Signals are routed via mux to either m.2 connectors:
> +	 * - M1: USB-3.1
> +	 * - M2: PCI-E
> +	 */
> +	status = "okay";
> +
> +	serdes0_link: phy@0 {
> +		reg = <0>;
> +		cdns,num-lanes = <1>;
> +		#phy-cells = <0>;
> +		cdns,phy-type = <PHY_NONE>;
> +		resets = <&serdes_wiz0 1>;
> +		status = "okay";

Where was it disabled?

> +	};
> +};
> +
> +&usb0 {
> +	dr_mode = "host";
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
> new file mode 100644
> index 000000000000..952a262d6874
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
> @@ -0,0 +1,638 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
> + *
> + */
> +
> +#include <dt-bindings/net/ti-dp83869.h>
> +
> +/ {
> +	model = "SolidRun AM642 SoM";
> +	compatible = "solidrun,am642-sr-som", "ti,am642";
> +
> +	aliases {
> +		ethernet0 = &cpsw_port1;
> +		ethernet1 = &icssg1_emac0;
> +		ethernet2 = &icssg1_emac1;
> +		mmc0 = &sdhci0;
> +		mmc1 = &sdhci1;
> +		serial2 = &main_uart0;
> +	};
> +
> +	chosen {
> +		/* SoC default UART console */
> +		stdout-path = "serial2:115200n8";
> +		bootargs = "earlycon=ns16550a,mmio32,0x02800000";

Drop bootargs. earlycon is for debugging.



Best regards,
Krzysztof


