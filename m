Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F5777A09E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjHLPF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHLPF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:05:56 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D801984;
        Sat, 12 Aug 2023 08:05:57 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA44EFF803;
        Sat, 12 Aug 2023 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691852756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aQDSabRD7xA27UAMUSCHZ6V2Ta8hOfZNMT3kjidlCoM=;
        b=DhfU3vSudsa2Oa9Lp4tVbZ84oQXWADUtLXyuQi2+E2ZS//gqPj1EW+FfgGGqlwsy3EPPD3
        6aMDtJ6InyOyScVGBjP3qklxCASE22QvpFGINjtD6mMeWAjQiYeuRSlkiLOw4J+Yod8Zuc
        C6ENwuGVoeni5cwKMDRb+9Z9OOzB5pcLkSLt1iWiQG0C99q/uCBpOYgxy8gfCQ86VrPfS+
        ZeNOgmOoba8BaELyyefeNrY5AxUvA3YCFEPEEUbkSJFcBroTSUjX+cq5BTHrHt+MIYLje5
        8AW4+a3fDueh9KULphsNMgNE3KwnPdwrmWGmUin5jNM1AESknjMwDcNvrVOXNA==
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
Subject: Re: [PATCH 1/2] ARM: dts: marvell: armada: drop incorrect reg in
 fixed regulators
In-Reply-To: <20230726070254.103661-1-krzysztof.kozlowski@linaro.org>
References: <20230726070254.103661-1-krzysztof.kozlowski@linaro.org>
Date:   Sat, 12 Aug 2023 17:05:55 +0200
Message-ID: <87pm3sti5o.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> Fixed regulators are not in some bus and bindings do not allow a "reg"
> property.  Move them out of "regulators" node to top-level.
>
>   armada-370-dlink-dns327l.dtb: regulator@1: Unevaluated properties are not allowed ('reg' was unexpected)
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied on mvebu/dt

Thanks,

Gregory
> ---
>  .../dts/marvell/armada-370-dlink-dns327l.dts  |  83 ++++++--------
>  .../marvell/armada-370-seagate-nas-4bay.dts   |  43 ++++---
>  .../marvell/armada-370-seagate-nas-xbay.dtsi  |  46 ++++----
>  ...armada-370-seagate-personal-cloud-2bay.dts |  21 ++--
>  .../armada-370-seagate-personal-cloud.dtsi    |  43 +++----
>  .../marvell/armada-370-synology-ds213j.dts    |  54 ++++-----
>  .../dts/marvell/armada-xp-synology-ds414.dts  | 105 +++++++++---------
>  7 files changed, 177 insertions(+), 218 deletions(-)
>
> diff --git a/arch/arm/boot/dts/marvell/armada-370-dlink-dns327l.dts b/arch/arm/boot/dts/marvell/armada-370-dlink-dns327l.dts
> index 561195b749eb..d4c4efabd254 100644
> --- a/arch/arm/boot/dts/marvell/armada-370-dlink-dns327l.dts
> +++ b/arch/arm/boot/dts/marvell/armada-370-dlink-dns327l.dts
> @@ -105,54 +105,45 @@ led-backup {
>  		};
>  	};
>  
> -	regulators {
> -		compatible = "simple-bus";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> +	usb_power: regulator-1 {
> +		compatible = "regulator-fixed";
> +		pinctrl-0 = <&xhci_pwr_pin>;
> +		pinctrl-names = "default";
> +		regulator-name = "USB3.0 Port Power";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		gpio = <&gpio0 13 GPIO_ACTIVE_HIGH>;
> +	};
>  
> -		usb_power: regulator@1 {
> -			compatible = "regulator-fixed";
> -			reg = <1>;
> -			pinctrl-0 = <&xhci_pwr_pin>;
> -			pinctrl-names = "default";
> -			regulator-name = "USB3.0 Port Power";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			enable-active-high;
> -			regulator-boot-on;
> -			regulator-always-on;
> -			gpio = <&gpio0 13 GPIO_ACTIVE_HIGH>;
> -		};
> +	sata_r_power: regulator-2 {
> +		compatible = "regulator-fixed";
> +		pinctrl-0 = <&sata_r_pwr_pin>;
> +		pinctrl-names = "default";
> +		regulator-name = "SATA-R Power";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		startup-delay-us = <2000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		gpio = <&gpio1 22 GPIO_ACTIVE_HIGH>;
> +	};
>  
> -		sata_r_power: regulator@2 {
> -			compatible = "regulator-fixed";
> -			reg = <2>;
> -			pinctrl-0 = <&sata_r_pwr_pin>;
> -			pinctrl-names = "default";
> -			regulator-name = "SATA-R Power";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			startup-delay-us = <2000000>;
> -			enable-active-high;
> -			regulator-always-on;
> -			regulator-boot-on;
> -			gpio = <&gpio1 22 GPIO_ACTIVE_HIGH>;
> -		};
> -
> -		sata_l_power: regulator@3 {
> -			compatible = "regulator-fixed";
> -			reg = <3>;
> -			pinctrl-0 = <&sata_l_pwr_pin>;
> -			pinctrl-names = "default";
> -			regulator-name = "SATA-L Power";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			startup-delay-us = <4000000>;
> -			enable-active-high;
> -			regulator-always-on;
> -			regulator-boot-on;
> -			gpio = <&gpio1 24 GPIO_ACTIVE_HIGH>;
> -		};
> +	sata_l_power: regulator-3 {
> +		compatible = "regulator-fixed";
> +		pinctrl-0 = <&sata_l_pwr_pin>;
> +		pinctrl-names = "default";
> +		regulator-name = "SATA-L Power";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		startup-delay-us = <4000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		gpio = <&gpio1 24 GPIO_ACTIVE_HIGH>;
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/marvell/armada-370-seagate-nas-4bay.dts b/arch/arm/boot/dts/marvell/armada-370-seagate-nas-4bay.dts
> index 9cb69999b1db..370ca9c43247 100644
> --- a/arch/arm/boot/dts/marvell/armada-370-seagate-nas-4bay.dts
> +++ b/arch/arm/boot/dts/marvell/armada-370-seagate-nas-4bay.dts
> @@ -46,29 +46,26 @@ pca9554: pca9554@21 {
>  		};
>  	};
>  
> -	regulators {
> -		regulator@3 {
> -			compatible = "regulator-fixed";
> -			reg = <3>;
> -			regulator-name = "SATA2 power";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			enable-active-high;
> -			regulator-always-on;
> -			regulator-boot-on;
> -			gpio = <&pca9554 6 GPIO_ACTIVE_HIGH>;
> -		};
> -		regulator@4 {
> -			compatible = "regulator-fixed";
> -			reg = <4>;
> -			regulator-name = "SATA3 power";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			enable-active-high;
> -			regulator-always-on;
> -			regulator-boot-on;
> -			gpio = <&pca9554 7 GPIO_ACTIVE_HIGH>;
> -		};
> +	regulator-3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SATA2 power";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		gpio = <&pca9554 6 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	regulator-4 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SATA3 power";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		gpio = <&pca9554 7 GPIO_ACTIVE_HIGH>;
>  	};
>  
>  	gpio-leds {
> diff --git a/arch/arm/boot/dts/marvell/armada-370-seagate-nas-xbay.dtsi b/arch/arm/boot/dts/marvell/armada-370-seagate-nas-xbay.dtsi
> index 822f10734946..ffb3179033e7 100644
> --- a/arch/arm/boot/dts/marvell/armada-370-seagate-nas-xbay.dtsi
> +++ b/arch/arm/boot/dts/marvell/armada-370-seagate-nas-xbay.dtsi
> @@ -70,34 +70,26 @@ rtc@6f {
>  
>  	};
>  
> -	regulators {
> -		compatible = "simple-bus";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		pinctrl-names = "default";
> +	regulator-1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SATA0 power";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		gpio = <&gpio1 18 GPIO_ACTIVE_HIGH>;
> +	};
>  
> -		regulator@1 {
> -			compatible = "regulator-fixed";
> -			reg = <1>;
> -			regulator-name = "SATA0 power";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			enable-active-high;
> -			regulator-always-on;
> -			regulator-boot-on;
> -			gpio = <&gpio1 18 GPIO_ACTIVE_HIGH>;
> -		};
> -		regulator@2 {
> -			compatible = "regulator-fixed";
> -			reg = <2>;
> -			regulator-name = "SATA1 power";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			enable-active-high;
> -			regulator-always-on;
> -			regulator-boot-on;
> -			gpio = <&gpio1 22 GPIO_ACTIVE_HIGH>;
> -		};
> +	regulator-2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SATA1 power";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		gpio = <&gpio1 22 GPIO_ACTIVE_HIGH>;
>  	};
>  
>  	gpio-fan {
> diff --git a/arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud-2bay.dts b/arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud-2bay.dts
> index 5ee572dc9242..45d8ec5dfeb7 100644
> --- a/arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud-2bay.dts
> +++ b/arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud-2bay.dts
> @@ -32,17 +32,14 @@ sata@a0000 {
>  		};
>  	};
>  
> -	regulators {
> -		regulator@2 {
> -			compatible = "regulator-fixed";
> -			reg = <2>;
> -			regulator-name = "SATA1 power";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			enable-active-high;
> -			regulator-always-on;
> -			regulator-boot-on;
> -			gpio = <&gpio1 22 GPIO_ACTIVE_HIGH>;
> -		};
> +	regulator-2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SATA1 power";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		gpio = <&gpio1 22 GPIO_ACTIVE_HIGH>;
>  	};
>  };
> diff --git a/arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud.dtsi b/arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud.dtsi
> index 124a8ba279e3..054124857235 100644
> --- a/arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud.dtsi
> +++ b/arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud.dtsi
> @@ -53,32 +53,25 @@ usb@50000 {
>  		};
>  	};
>  
> -	regulators {
> -		compatible = "simple-bus";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> +	regulator-0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "USB Power";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		gpio = <&gpio1 27 GPIO_ACTIVE_LOW>;
> +	};
>  
> -		regulator@0 {
> -			compatible = "regulator-fixed";
> -			reg = <0>;
> -			regulator-name = "USB Power";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			regulator-always-on;
> -			regulator-boot-on;
> -			gpio = <&gpio1 27 GPIO_ACTIVE_LOW>;
> -		};
> -		regulator@1 {
> -			compatible = "regulator-fixed";
> -			reg = <1>;
> -			regulator-name = "SATA0 power";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			enable-active-high;
> -			regulator-always-on;
> -			regulator-boot-on;
> -			gpio = <&gpio1 18 GPIO_ACTIVE_HIGH>;
> -		};
> +	regulator-1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SATA0 power";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		gpio = <&gpio1 18 GPIO_ACTIVE_HIGH>;
>  	};
>  
>  	gpio-keys {
> diff --git a/arch/arm/boot/dts/marvell/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/marvell/armada-370-synology-ds213j.dts
> index f0893cc06607..b07d11d1f124 100644
> --- a/arch/arm/boot/dts/marvell/armada-370-synology-ds213j.dts
> +++ b/arch/arm/boot/dts/marvell/armada-370-synology-ds213j.dts
> @@ -142,38 +142,32 @@ disk2-led-amber {
>  		};
>  	};
>  
> -	regulators {
> -		compatible = "simple-bus";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		pinctrl-0 = <&sata1_pwr_pin &sata2_pwr_pin>;
> +	sata1_regulator: sata1-regulator-1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SATA1 Power";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		startup-delay-us = <2000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&sata1_pwr_pin>;
>  		pinctrl-names = "default";
> +	};
>  
> -		sata1_regulator: sata1-regulator@1 {
> -			compatible = "regulator-fixed";
> -			reg = <1>;
> -			regulator-name = "SATA1 Power";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			startup-delay-us = <2000000>;
> -			enable-active-high;
> -			regulator-always-on;
> -			regulator-boot-on;
> -			gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
> -		};
> -
> -		sata2_regulator: sata2-regulator@2 {
> -			compatible = "regulator-fixed";
> -			reg = <2>;
> -			regulator-name = "SATA2 Power";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			startup-delay-us = <4000000>;
> -			enable-active-high;
> -			regulator-always-on;
> -			regulator-boot-on;
> -			gpio = <&gpio1 30 GPIO_ACTIVE_HIGH>;
> -		};
> +	sata2_regulator: sata2-regulator-2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SATA2 Power";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		startup-delay-us = <4000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		gpio = <&gpio1 30 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&sata2_pwr_pin>;
> +		pinctrl-names = "default";
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/marvell/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/marvell/armada-xp-synology-ds414.dts
> index 5551bac1962c..1b65059794bf 100644
> --- a/arch/arm/boot/dts/marvell/armada-xp-synology-ds414.dts
> +++ b/arch/arm/boot/dts/marvell/armada-xp-synology-ds414.dts
> @@ -109,65 +109,60 @@ ethernet@74000 {
>  		};
>  	};
>  
> -	regulators {
> -		compatible = "simple-bus";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		pinctrl-0 = <&sata1_pwr_pin &sata2_pwr_pin
> -			     &sata3_pwr_pin &sata4_pwr_pin>;
> +	sata1_regulator: sata1-regulator-1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SATA1 Power";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		startup-delay-us = <2000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		gpio = <&gpio1 10 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&sata1_pwr_pin>;
>  		pinctrl-names = "default";
> +	};
>  
> -		sata1_regulator: sata1-regulator@1 {
> -			compatible = "regulator-fixed";
> -			reg = <1>;
> -			regulator-name = "SATA1 Power";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			startup-delay-us = <2000000>;
> -			enable-active-high;
> -			regulator-always-on;
> -			regulator-boot-on;
> -			gpio = <&gpio1 10 GPIO_ACTIVE_HIGH>;
> -		};
> +	sata2_regulator: sata2-regulator-2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SATA2 Power";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		startup-delay-us = <4000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&sata2_pwr_pin>;
> +		pinctrl-names = "default";
> +	};
>  
> -		sata2_regulator: sata2-regulator@2 {
> -			compatible = "regulator-fixed";
> -			reg = <2>;
> -			regulator-name = "SATA2 Power";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			startup-delay-us = <4000000>;
> -			enable-active-high;
> -			regulator-always-on;
> -			regulator-boot-on;
> -			gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> -		};
> +	sata3_regulator: sata3-regulator-3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SATA3 Power";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		startup-delay-us = <6000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		gpio = <&gpio1 13 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&sata3_pwr_pin>;
> +		pinctrl-names = "default";
> +	};
>  
> -		sata3_regulator: sata3-regulator@3 {
> -			compatible = "regulator-fixed";
> -			reg = <3>;
> -			regulator-name = "SATA3 Power";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			startup-delay-us = <6000000>;
> -			enable-active-high;
> -			regulator-always-on;
> -			regulator-boot-on;
> -			gpio = <&gpio1 13 GPIO_ACTIVE_HIGH>;
> -		};
> -
> -		sata4_regulator: sata4-regulator@4 {
> -			compatible = "regulator-fixed";
> -			reg = <4>;
> -			regulator-name = "SATA4 Power";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			startup-delay-us = <8000000>;
> -			enable-active-high;
> -			regulator-always-on;
> -			regulator-boot-on;
> -			gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
> -		};
> +	sata4_regulator: sata4-regulator-4 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SATA4 Power";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		startup-delay-us = <8000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&sata4_pwr_pin>;
> +		pinctrl-names = "default";
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
