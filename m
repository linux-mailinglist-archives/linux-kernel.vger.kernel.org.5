Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664CB77A0A0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjHLPGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHLPGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:06:10 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E566F1984;
        Sat, 12 Aug 2023 08:06:11 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D1D8A20004;
        Sat, 12 Aug 2023 15:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691852770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LoAaVhVy0qLu2UIidV/2RKuvvjg2wk/gITqz6y98m3Q=;
        b=pZ+GFez631+mShPkhsB93KVm+av4nO8WGaOvJRdCq79ZNke1eQ3M3K9pa1UwY6JNfg708p
        pWwnGenTLlM8f4YKBiEtY1C6HK7NR0n3mFRGpQA23lJKrUwnBAztiKrGQfb3PPWMG7ahbd
        6rqG6kT4Xzm+t2pKGyD08ru7tAugAL/OpzbPj0hMmZ7rupd/dkjw+/SyTLjL8F1bQDcegV
        37VGMdpvA4AwtvB3M5Yd4YOX1JWTV1NA5cE16T3wn7STDG4M7MiL2s/yvix+hb1fg+VLKz
        wHfCbEypy3ZG6EiqRAwkbhe+EC9f0NqEDRuFJ4cAPIN6OaX8LeliWL9dD9DbLA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/2] ARM: dts: marvell: dove: drop incorrect reg in
 fixed regulators
In-Reply-To: <20230726070254.103661-2-krzysztof.kozlowski@linaro.org>
References: <20230726070254.103661-1-krzysztof.kozlowski@linaro.org>
 <20230726070254.103661-2-krzysztof.kozlowski@linaro.org>
Date:   Sat, 12 Aug 2023 17:06:08 +0200
Message-ID: <87msywti5b.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> Fixed regulators are not in some bus and bindings do not allow a "reg"
> property.  Move them out of "regulators" node to top-level.
>
>   dove-cubox.dtb: regulator@1: Unevaluated properties are not allowed ('reg' was unexpected)
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied on mvebu/dt

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/marvell/dove-cm-a510.dtsi | 18 +++++--------
>  arch/arm/boot/dts/marvell/dove-cubox.dts    | 29 ++++++++-------------
>  arch/arm/boot/dts/marvell/dove-d3plug.dts   | 29 ++++++++-------------
>  arch/arm/boot/dts/marvell/dove-sbc-a510.dts | 28 +++++++++-----------
>  4 files changed, 41 insertions(+), 63 deletions(-)
>
> diff --git a/arch/arm/boot/dts/marvell/dove-cm-a510.dtsi b/arch/arm/boot/dts/marvell/dove-cm-a510.dtsi
> index 1082fdfbfe60..621cb145a8f6 100644
> --- a/arch/arm/boot/dts/marvell/dove-cm-a510.dtsi
> +++ b/arch/arm/boot/dts/marvell/dove-cm-a510.dtsi
> @@ -108,18 +108,12 @@ led-system {
>  		};
>  	};
>  
> -	regulators {
> -		compatible = "simple-bus";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		wifi_power: regulator@1 {
> -			compatible = "regulator-fixed";
> -			regulator-name = "WiFi Power";
> -			regulator-min-microvolt = <3300000>;
> -			regulator-max-microvolt = <3300000>;
> -			gpio = <&gpio2 7 GPIO_ACTIVE_HIGH>;
> -		};
> +	wifi_power: regulator-1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "WiFi Power";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio2 7 GPIO_ACTIVE_HIGH>;
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/marvell/dove-cubox.dts b/arch/arm/boot/dts/marvell/dove-cubox.dts
> index dbba0c8cdab1..bfde99486a87 100644
> --- a/arch/arm/boot/dts/marvell/dove-cubox.dts
> +++ b/arch/arm/boot/dts/marvell/dove-cubox.dts
> @@ -28,24 +28,17 @@ led-power {
>  		};
>  	};
>  
> -	regulators {
> -		compatible = "simple-bus";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		usb_power: regulator@1 {
> -			compatible = "regulator-fixed";
> -			reg = <1>;
> -			regulator-name = "USB Power";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			enable-active-high;
> -			regulator-always-on;
> -			regulator-boot-on;
> -			gpio = <&gpio0 1 0>;
> -			pinctrl-0 = <&pmx_gpio_1>;
> -			pinctrl-names = "default";
> -		};
> +	usb_power: regulator-1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "USB Power";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		gpio = <&gpio0 1 0>;
> +		pinctrl-0 = <&pmx_gpio_1>;
> +		pinctrl-names = "default";
>  	};
>  
>  	clocks {
> diff --git a/arch/arm/boot/dts/marvell/dove-d3plug.dts b/arch/arm/boot/dts/marvell/dove-d3plug.dts
> index 5aa5d4a7d51d..a451fd576990 100644
> --- a/arch/arm/boot/dts/marvell/dove-d3plug.dts
> +++ b/arch/arm/boot/dts/marvell/dove-d3plug.dts
> @@ -37,24 +37,17 @@ led-status {
>  		};
>  	};
>  
> -	regulators {
> -		compatible = "simple-bus";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		usb_power: regulator@1 {
> -			compatible = "regulator-fixed";
> -			reg = <1>;
> -			regulator-name = "USB Power";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			enable-active-high;
> -			regulator-always-on;
> -			regulator-boot-on;
> -			gpio = <&gpio0 8 0>;
> -			pinctrl-0 = <&pmx_gpio_8>;
> -			pinctrl-names = "default";
> -		};
> +	usb_power: regulator-1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "USB Power";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		gpio = <&gpio0 8 0>;
> +		pinctrl-0 = <&pmx_gpio_8>;
> +		pinctrl-names = "default";
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/marvell/dove-sbc-a510.dts b/arch/arm/boot/dts/marvell/dove-sbc-a510.dts
> index df021f9b0117..8585ee5533bf 100644
> --- a/arch/arm/boot/dts/marvell/dove-sbc-a510.dts
> +++ b/arch/arm/boot/dts/marvell/dove-sbc-a510.dts
> @@ -76,22 +76,20 @@ chosen {
>  		stdout-path = &uart0;
>  	};
>  
> -	regulators {
> -		usb0_power: regulator@2 {
> -			compatible = "regulator-fixed";
> -			regulator-name = "USB Power";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			gpio = <&gpio_ext 0 GPIO_ACTIVE_HIGH>;
> -		};
> +	usb0_power: regulator-2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "USB Power";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio_ext 0 GPIO_ACTIVE_HIGH>;
> +	};
>  
> -		mmc_power: regulator@3 {
> -			compatible = "regulator-fixed";
> -			regulator-name = "MMC Power";
> -			regulator-min-microvolt = <3300000>;
> -			regulator-max-microvolt = <3300000>;
> -			gpio = <&gpio_ext 13 GPIO_ACTIVE_HIGH>;
> -		};
> +	mmc_power: regulator-3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "MMC Power";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio_ext 13 GPIO_ACTIVE_HIGH>;
>  	};
>  };
>  
> -- 
> 2.34.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
