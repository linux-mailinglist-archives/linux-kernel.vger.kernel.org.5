Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D15811FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjLMUZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjLMUZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:25:03 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E404BD5;
        Wed, 13 Dec 2023 12:25:09 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c4846847eso36294925e9.1;
        Wed, 13 Dec 2023 12:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702499108; x=1703103908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBw6RwQKyvab353WCHCowyhIbZpg2AL1dkTtUhZYR/w=;
        b=fKtmSq4NLoUf0bP5eG0441mbIiU/DUlW4acDffFXhnV+U6ftJHAwgfEJ0iS2nApraz
         IMd4lWVflZJEHUCXZTzK8QORpSXpPqOqx6h9zcToxLeA7po2w2MBLJZYD9MwqWdH+a8i
         v38rmj8dvdDBsNs5kG9WF01/pfIui7WJi4UbUyE0Pmnr2CsCIzxaT896acTxnFkcRnjv
         wEaFOoC55C6fKkXmT/GFYklS3DCltG7YeEHY3w1GkrQ4hYnCG18c+hz9qBWzUzLkh/4p
         DiVBPhPd2C6m/zWKN0JP/3tRWlftvq2KOIT0NqKaUKVNccr7sbogp3B8O4h0pT1gxWDW
         c+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702499108; x=1703103908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBw6RwQKyvab353WCHCowyhIbZpg2AL1dkTtUhZYR/w=;
        b=v0pFCtMctoGez4PowOlNeZqQ7i6hcun67s75z+psvTBznj+yLglWWxTEMfWbOx3pTO
         r7x3OELWI+5r3FHM+cP6qBR7A5KIqaohfEhMxdb2KtZZulW6aH1tW9Ng/z5KnkN7alMh
         I8Gok+6egtAHgGnlfI6WdgsITf3i2VQ5pSTqPaZD6ERk/VXjKB2fm6+gypNjy6Jl8Ihk
         OKdtCF0teM6dbj6cgZrR6cPqAA+WoOT6e3dytfv5PwtR6FfWg3EtIVvAcXqGpwsD8PIb
         C0J9Ea0L8G22aWQOaZsWXjwJ6db6UYCPDThWqffMknf+G+GrXle4K7ElBxpBo5HsN9Fd
         Do0g==
X-Gm-Message-State: AOJu0YyihDGVdHTFIOG+abg2SbqzFFBxGlsYfXSHdqXoCystICHjiOWa
        NmJMApW/lOavZiMKg4fVsFFw/vOZjlk=
X-Google-Smtp-Source: AGHT+IGMJfezTktKT7qPOB4lTgQts74SBurQohWWXd09dJ/KV9sR7T5RT6n3lUUP60TNYauxrbskag==
X-Received: by 2002:a05:600c:3154:b0:40c:4c9a:7b02 with SMTP id h20-20020a05600c315400b0040c4c9a7b02mr2370491wmo.130.1702499108050;
        Wed, 13 Dec 2023 12:25:08 -0800 (PST)
Received: from archlinux.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id fl9-20020a05600c0b8900b0040b43da0bbasm21945141wmb.30.2023.12.13.12.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 12:25:07 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v7 6/7] ARM: dts: sun8i-a83t: Add BananaPi M3 OV5640 camera
 overlay
Date:   Wed, 13 Dec 2023 21:25:06 +0100
Message-ID: <22116368.EfDdHjke4D@archlinux>
In-Reply-To: <20231122141426.329694-7-paul.kocialkowski@bootlin.com>
References: <20231122141426.329694-1-paul.kocialkowski@bootlin.com>
 <20231122141426.329694-7-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul!

On Wednesday, November 22, 2023 3:14:24 PM CET Paul Kocialkowski wrote:
> Add an overlay supporting the OV5640 from the BananaPi Camera v3
> peripheral board. The board has two sensors (OV5640 and OV8865)
> which cannot be supported in parallel as they share the same reset
> pin and the kernel currently has no support for this case.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  arch/arm/boot/dts/allwinner/Makefile          |   1 +
>  .../sun8i-a83t-bananapi-m3-camera-ov5640.dtso | 117 ++++++++++++++++++
>  2 files changed, 118 insertions(+)
>  create mode 100644 arch/arm/boot/dts/allwinner/sun8i-a83t-bananapi-m3-camera-ov5640.dtso
> 
> diff --git a/arch/arm/boot/dts/allwinner/Makefile b/arch/arm/boot/dts/allwinner/Makefile
> index eebb5a0c873a..a0a9aa6595e4 100644
> --- a/arch/arm/boot/dts/allwinner/Makefile
> +++ b/arch/arm/boot/dts/allwinner/Makefile
> @@ -277,6 +277,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>  	sun8i-a33-sinlinx-sina33.dtb \
>  	sun8i-a83t-allwinner-h8homlet-v2.dtb \
>  	sun8i-a83t-bananapi-m3.dtb \
> +	sun8i-a83t-bananapi-m3-camera-ov5640.dtbo \
>  	sun8i-a83t-cubietruck-plus.dtb \
>  	sun8i-a83t-tbs-a711.dtb \
>  	sun8i-h2-plus-bananapi-m2-zero.dtb \
> diff --git a/arch/arm/boot/dts/allwinner/sun8i-a83t-bananapi-m3-camera-ov5640.dtso b/arch/arm/boot/dts/allwinner/sun8i-a83t-bananapi-m3-camera-ov5640.dtso
> new file mode 100644
> index 000000000000..5868ef11bdee
> --- /dev/null
> +++ b/arch/arm/boot/dts/allwinner/sun8i-a83t-bananapi-m3-camera-ov5640.dtso
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0 OR X11
> +/*
> + * Copyright 2022 Bootlin
> + * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/clock/sun8i-a83t-ccu.h>
> +#include <dt-bindings/gpio/gpio.h>

I think you should tie this overlay to BananaPi M3 board by specifying its
compatible here, like:

/ {
	compatible = "sinovoip,bpi-m3";
};

> +
> +&{/} {
> +	/*
> +	 * These regulators actually have DLDO4 tied to their EN pin, which is
> +	 * described as input supply here for lack of a better representation.
> +	 * Their actual supply is PS, which is always-on.
> +	 */
> +
> +	ov5640_avdd: ov5640-avdd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "ov5640-avdd";
> +		regulator-min-microvolt = <2800000>;
> +		regulator-max-microvolt = <2800000>;
> +		vin-supply = <&reg_dldo4>;
> +	};
> +
> +	ov5640_dovdd: ov5640-dovdd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "ov5640-dovdd";
> +		regulator-min-microvolt = <2800000>;
> +		regulator-max-microvolt = <2800000>;
> +		vin-supply = <&reg_dldo4>;
> +	};
> +
> +	ov5640_dvdd: ov5640-dvdd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "ov5640-dvdd";
> +		regulator-min-microvolt = <1500000>;
> +		regulator-max-microvolt = <1500000>;
> +		vin-supply = <&reg_dldo4>;
> +	};
> +};
> +
> +&csi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&csi_8bit_parallel_pins>;
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +
> +			csi_in_ov5640: endpoint {
> +				remote-endpoint = <&ov5640_out_csi>;
> +				bus-width = <8>;
> +				data-shift = <2>;
> +				hsync-active = <1>;
> +				vsync-active = <1>;
> +				pclk-sample = <1>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pe_pins>;
> +	status = "okay";
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	ov5640: camera@3c {
> +		compatible = "ovti,ov5640";
> +		reg = <0x3c>;
> +
> +		clocks = <&ccu CLK_CSI_MCLK>;
> +		clock-names = "xclk";
> +		assigned-clocks = <&ccu CLK_CSI_MCLK>;
> +		assigned-clock-parents = <&osc24M>;
> +		assigned-clock-rates = <24000000>;

Are those really necessary? If so, can it be moved to the driver? Assigned
clock rates have no guarantee that they will stay at that rate. Additionally,
same sensor in pinetab doesn't need that. What's the difference?

> +
> +		AVDD-supply = <&ov5640_avdd>;
> +		DOVDD-supply = <&ov5640_dovdd>;
> +		DVDD-supply = <&ov5640_dvdd>;
> +
> +		powerdown-gpios = <&pio 3 15 GPIO_ACTIVE_HIGH>; /* PD15 */
> +		reset-gpios = <&pio 4 16 GPIO_ACTIVE_LOW>; /* PE16 */
> +
> +		rotation = <180>;
> +
> +		port {
> +			ov5640_out_csi: endpoint {
> +				remote-endpoint = <&csi_in_ov5640>;
> +				bus-width = <8>;
> +				data-shift = <2>;
> +				hsync-active = <1>; 
> +				vsync-active = <1>;
> +				pclk-sample = <1>;
> +			};
> +		};
> +	};
> +};
> +
> +&pio {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&csi_mclk_pin>;

This should be moved to ov5640 node.

Best regards,
Jernej

> +};
> +
> +&reg_dldo4 {
> +	regulator-min-microvolt = <2800000>;
> +	regulator-max-microvolt = <2800000>;
> +};
> 




