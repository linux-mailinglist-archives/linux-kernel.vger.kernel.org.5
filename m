Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA20076F46E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjHCVGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjHCVGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:06:02 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E393A95;
        Thu,  3 Aug 2023 14:05:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-314172bac25so1176492f8f.3;
        Thu, 03 Aug 2023 14:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691096753; x=1691701553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0AXk0kphC+ZbJXuVp0/fkb3E0NLK+WciZiPvx+OG3c=;
        b=kMxxD1EJpKRc0W9OHC4Lh2xixqD1qm3kwzQZ8zxBF5AtuNK7k9AcELxXCi9zppznuW
         flhhPt6bteRUbifImODiEZpiu7QaFyUTWc/4KkC3jEcU2KW8poKtECEKBx1lAnxcnSFp
         QKtN1HaFXHilydk3FMRqn2iIjr07As7wdVjEmplE9aAW/tyaX6cpERfHwVUsvIzpE1FM
         bD/pj75W2R42x4JpwpveUKXcJL3YYQicCvqLQr0uCS/gUQljSqpKfpNjR7yEWKLbFy4X
         p7qkaB0vvkA8AyF9iHR5KHnVAqpMCS7OkIvtx8OrUjw1JKo7QhArBXWFpZg8i43+f58V
         ea4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691096753; x=1691701553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0AXk0kphC+ZbJXuVp0/fkb3E0NLK+WciZiPvx+OG3c=;
        b=g5uFztC2Jvqb7fPp7ZQFxsPs/+k9IXcMsc9PQ1yXrGFGBrbzjXtlfUh1RmcbAKsKPP
         YuugpAjgyJAU9cTkzTKD3qpf4YJX6tJYAFpNhdeH6IUQUjzmtd0MzULu5CkyWqs6iT9i
         vfw0ML0RsxGodhGYLEMBhY/EXVe7ygcKufsJuFpFn/uSi+mHZ+RI/4kCtUVJ9j7FsEWu
         bnsKkCKoHR4LsYoZ/Tlu8sQWXXZpA6xkKdsu9TE/I4io8lJZCMpGNGoAer38hv6rqsyd
         t15WFrfRKsLMxPOW9qYIdRXjNp8Kazrezp49CataKbKyuVTEx1+J19EP+2U7Ed9GAwy9
         Mlag==
X-Gm-Message-State: ABy/qLavQttBZYrLbRb05zsr+BuM/3tGXKwo2nrwgd25YEVhsAKCRQiZ
        OrwiiOjQ6nh7kKI/gBkdxrOgKtvYR8XRyQ==
X-Google-Smtp-Source: APBJJlGEl/ekVwr8fxoz7ofQLEEl9RpKwK5YaukHV/NAlVqqdD1qJngLMmxzDn2hJZ9OQdwL0Mqsyw==
X-Received: by 2002:a5d:4452:0:b0:314:3ad6:2327 with SMTP id x18-20020a5d4452000000b003143ad62327mr7515693wrr.12.1691096753073;
        Thu, 03 Aug 2023 14:05:53 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id x12-20020adfec0c000000b0031274a184d5sm747910wrn.109.2023.08.03.14.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 14:05:52 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Icenowy Zheng <uwu@icenowy.me>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: allwinner: h616: Split Orange Pi Zero 2 DT
Date:   Thu, 03 Aug 2023 23:05:51 +0200
Message-ID: <21964539.EfDdHjke4D@jernej-laptop>
In-Reply-To: <20230731011725.7228-2-andre.przywara@arm.com>
References: <20230731011725.7228-1-andre.przywara@arm.com>
 <20230731011725.7228-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 31. julij 2023 ob 03:17:23 CEST je Andre Przywara napisal(a):
> The Orange Pi Zero 2 got a successor (Zero 3), which shares quite some
> DT nodes with the Zero 2, but comes with a different PMIC.
> 
> Move the common parts (except the PMIC) into a new shared file, and
> include that from the existing board .dts file.
> 
> No functional change, the generated DTB is the same, except some phandle
> numbering differences.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../allwinner/sun50i-h616-orangepi-zero2.dts  | 119 +---------------
>  .../allwinner/sun50i-h616-orangepi-zerox.dtsi | 131 ++++++++++++++++++
>  2 files changed, 132 insertions(+), 118 deletions(-)
>  create mode 100644
> arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zerox.dtsi
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts index
> cb8600d0ea1ef..c786b170fb9a8 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> @@ -5,95 +5,19 @@
> 
>  /dts-v1/;
> 
> -#include "sun50i-h616.dtsi"
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/interrupt-controller/arm-gic.h>
> -#include <dt-bindings/leds/common.h>
> +#include "sun50i-h616-orangepi-zerox.dtsi"
> 
>  / {
>  	model = "OrangePi Zero2";
>  	compatible = "xunlong,orangepi-zero2", "allwinner,sun50i-h616";
> -
> -	aliases {
> -		ethernet0 = &emac0;
> -		serial0 = &uart0;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -
> -		led-0 {
> -			function = LED_FUNCTION_POWER;
> -			color = <LED_COLOR_ID_RED>;
> -			gpios = <&pio 2 12 GPIO_ACTIVE_HIGH>; /* 
PC12 */
> -			default-state = "on";
> -		};
> -
> -		led-1 {
> -			function = LED_FUNCTION_STATUS;
> -			color = <LED_COLOR_ID_GREEN>;
> -			gpios = <&pio 2 13 GPIO_ACTIVE_HIGH>; /* 
PC13 */
> -		};
> -	};
> -
> -	reg_vcc5v: vcc5v {
> -		/* board wide 5V supply directly from the USB-C socket 
*/
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc-5v";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		regulator-always-on;
> -	};
> -
> -	reg_usb1_vbus: regulator-usb1-vbus {
> -		compatible = "regulator-fixed";
> -		regulator-name = "usb1-vbus";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&reg_vcc5v>;
> -		enable-active-high;
> -		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>; /* PC16 */
> -	};
>  };
> 
> -&ehci1 {
> -	status = "okay";
> -};
> -
> -/* USB 2 & 3 are on headers only. */
> -
>  &emac0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&ext_rgmii_pins>;
> -	phy-mode = "rgmii";
> -	phy-handle = <&ext_rgmii_phy>;
>  	phy-supply = <&reg_dcdce>;
> -	allwinner,rx-delay-ps = <3100>;
> -	allwinner,tx-delay-ps = <700>;
> -	status = "okay";
> -};
> -
> -&mdio0 {
> -	ext_rgmii_phy: ethernet-phy@1 {
> -		compatible = "ethernet-phy-ieee802.3-c22";
> -		reg = <1>;
> -	};
>  };
> 
>  &mmc0 {
>  	vmmc-supply = <&reg_dcdce>;
> -	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> -	bus-width = <4>;
> -	status = "okay";
> -};
> -
> -&ohci1 {
> -	status = "okay";
>  };
> 
>  &r_rsb {
> @@ -211,44 +135,3 @@ &pio {
>  	vcc-ph-supply = <&reg_aldo1>;
>  	vcc-pi-supply = <&reg_aldo1>;
>  };
> -
> -&spi0  {
> -	status = "okay";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi0_pins>, <&spi0_cs0_pin>;
> -
> -	flash@0 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		compatible = "jedec,spi-nor";
> -		reg = <0>;
> -		spi-max-frequency = <40000000>;
> -	};
> -};
> -
> -&uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart0_ph_pins>;
> -	status = "okay";
> -};
> -
> -&usbotg {
> -	/*
> -	 * PHY0 pins are connected to a USB-C socket, but a role switch
> -	 * is not implemented: both CC pins are pulled to GND.
> -	 * The VBUS pins power the device, so a fixed peripheral mode
> -	 * is the best choice.
> -	 * The board can be powered via GPIOs, in this case port0 *can*
> -	 * act as a host (with a cable/adapter ignoring CC), as VBUS is
> -	 * then provided by the GPIOs. Any user of this setup would
> -	 * need to adjust the DT accordingly: dr_mode set to "host",
> -	 * enabling OHCI0 and EHCI0.
> -	 */
> -	dr_mode = "peripheral";
> -	status = "okay";
> -};
> -
> -&usbphy {
> -	usb1_vbus-supply = <&reg_usb1_vbus>;
> -	status = "okay";
> -};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zerox.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zerox.dtsi new file

If we go this route, choose some name without X in it. I guess "zero" by 
itself is enough since there is no H616 board with that name.

What do you think?

Best regards,
Jernej

> mode 100644
> index 0000000000000..56c7e1d87bd95
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zerox.dtsi
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2020 Arm Ltd.
> + */
> +
> +#include "sun50i-h616.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	aliases {
> +		ethernet0 = &emac0;
> +		serial0 = &uart0;
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
> +			function = LED_FUNCTION_POWER;
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&pio 2 12 GPIO_ACTIVE_HIGH>; /* PC12 
*/
> +			default-state = "on";
> +		};
> +
> +		led-1 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&pio 2 13 GPIO_ACTIVE_HIGH>; /* PC13 
*/
> +		};
> +	};
> +
> +	reg_vcc5v: vcc5v {
> +		/* board wide 5V supply directly from the USB-C socket 
*/
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_usb1_vbus: regulator-usb1-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb1-vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&reg_vcc5v>;
> +		enable-active-high;
> +		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>; /* PC16 */
> +	};
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +/* USB 2 & 3 are on headers only. */
> +
> +&emac0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ext_rgmii_pins>;
> +	phy-mode = "rgmii";
> +	phy-handle = <&ext_rgmii_phy>;
> +	allwinner,rx-delay-ps = <3100>;
> +	allwinner,tx-delay-ps = <700>;
> +	status = "okay";
> +};
> +
> +&mdio0 {
> +	ext_rgmii_phy: ethernet-phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <1>;
> +	};
> +};
> +
> +&mmc0 {
> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&ohci1 {
> +	status = "okay";
> +};
> +
> +&spi0  {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi0_pins>, <&spi0_cs0_pin>;
> +
> +	flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <40000000>;
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_ph_pins>;
> +	status = "okay";
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
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> +
> +&usbphy {
> +	usb1_vbus-supply = <&reg_usb1_vbus>;
> +	status = "okay";
> +};




