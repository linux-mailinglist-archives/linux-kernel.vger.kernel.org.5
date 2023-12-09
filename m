Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60D680B4D0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 15:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjLIODG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 09:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLIODE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 09:03:04 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F068FED
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 06:03:10 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54ca43031d1so2779164a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 06:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702130589; x=1702735389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UrPZJasYLI9g+XbdVLz9ByZ468wwTcDJTH4exFvFl/Q=;
        b=xHujp9c4UIVjnb5btDdR/RsibGAAcFSzxuUG48OxjtfufDMpPvlFiu11T+3cBFEK/m
         5egN9dlFM6UBWpyovNb4FDFBJRd6TIjv8jEM8OCYnsdFQmO87Yq+/QWChh2b00VCdD+1
         WWlZ4HXLsREzzD+igRtf9iXDbbrYlMBdFxi7bbwvqTn8WHBlk7oU/PqjKP2lImuB6I7s
         oAG0DSX640dyXtC0RgNO77lLR57a+3FarQnrkci8+zJU+PTWdJV8s4/vyj/Noaux8rpc
         3RhBIMOZo2Lz8CYuGhaGJTxjynCEDqC0DgetWyKWSc6T9KhtDjr8YR3TzC+2jBULtQz7
         P5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702130589; x=1702735389;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UrPZJasYLI9g+XbdVLz9ByZ468wwTcDJTH4exFvFl/Q=;
        b=ZNaWvjH3IlRkvBsx/teHpH5Qhx9kf+4UzXdAdmkTdAy4fkqNGP4w2N3C/FI+M8MgaY
         O8YhhaDfS8WOAykpA2l3fNWdsiHhW0PTPvrQYGyhCE3hSkDqK8tMCZ+O9wiZaQfAYW26
         bpIeMrRnnG7qiqwscG8SW5tUOk/QEkokX0nUEDYCk4BG2JvkN5OE+tHLoXjtS696tET4
         UrYEQLDxUFAve8kcpD/7iYJDPdwkg11qlZb/J9yG0u+qGOdfaEDTHW6gJN/2FVPZsg3P
         xR2/DP8d9oEKRge6oS5VU/2wJSadZ7FiAMaWcaC0mZqOAJihNIlBLObhXpcYbCtzEX/+
         J0Qw==
X-Gm-Message-State: AOJu0Yw1WVNnSGiskWvHxU5TbdEWJ5eLAmFeYhs6MdvYi9gd9UCzHYzW
        1dpcVAliTi+Pp5DxZAHqXDAM3A==
X-Google-Smtp-Source: AGHT+IF9NGFZlyyhUsMjW4IHI4V4ebGpMKxQHpcNFLWHPdywe+Rxrrtw/u+6m8kMS6cRiiSxjQjncw==
X-Received: by 2002:a50:cb8b:0:b0:54c:4837:9035 with SMTP id k11-20020a50cb8b000000b0054c48379035mr1227268edi.45.1702130589438;
        Sat, 09 Dec 2023 06:03:09 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id c28-20020a50f61c000000b0054c5d3486e9sm1775741edn.76.2023.12.09.06.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 06:03:08 -0800 (PST)
Message-ID: <a019de0c-4f88-4016-b08c-9f4049f2b8d0@linaro.org>
Date:   Sat, 9 Dec 2023 15:03:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: rockchip: Add support for rk3588s based
 board CoolPi 4B
Content-Language: en-US
To:     Andy Yan <andyshrk@163.com>, heiko@sntech.de
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20231209103622.1568289-1-andyshrk@163.com>
 <20231209103802.1568552-1-andyshrk@163.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231209103802.1568552-1-andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2023 11:38, Andy Yan wrote:
> CoolPi 4B is a rk3588s based SBC.
> Specification:
> - Rockchip RK3588S
> - LPDDR4 2/4/8/16 GB
> - TF scard slot


> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
> +#include "rk3588s.dtsi"
> +
> +/ {
> +	model = "RK3588S CoolPi 4B";
> +	compatible = "CoolPi 4 Model B", "rockchip,rk3588s";

That's not a real compatible.

> +
> +	aliases {
> +		mmc0 = &sdhci;
> +		mmc1 = &sdio;
> +		mmc2 = &sdmmc;
> +		serial2 = &uart2;
> +	};
> +
> +	analog-sound {
> +		compatible = "audio-graph-card";
> +		label = "rk3588-es8316";
> +
> +		widgets = "Microphone", "Mic Jack",
> +			  "Headphone", "Headphones";
> +
> +		routing = "MIC2", "Mic Jack",
> +			  "Headphones", "HPOL",
> +			  "Headphones", "HPOR";
> +
> +		dais = <&i2s0_8ch_p0>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	leds: leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl- = <&gpio_leds>;
> +		status = "okay";

Drop

> +
> +		led0: led-green {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&gpio0 RK_PD0 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led1: led-red {
> +			color = <LED_COLOR_ID_RED>;
> +			function = LED_FUNCTION_WLAN;
> +			gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "phy0tx";
> +			default-state = "off";
> +		};
> +	};

...

> +
> +&i2c2 {
> +	status = "okay";
> +
> +	vdd_npu_s0: regulator@42 {
> +		compatible = "rockchip,rk8602";
> +		reg = <0x42>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_npu_s0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <550000>;
> +		regulator-max-microvolt = <950000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +

Stray blank line

> +};
> +
> +&i2s0_8ch {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2s0_lrck
> +		     &i2s0_mclk
> +		     &i2s0_sclk
> +		     &i2s0_sdi0
> +		     &i2s0_sdo0>;
> +	status = "okay";
> +
> +	i2s0_8ch_p0: port {
> +		i2s0_8ch_p0_0: endpoint {
> +			dai-format = "i2s";
> +			mclk-fs = <256>;
> +			remote-endpoint = <&es8316_p0_0>;
> +		};
> +	};
> +};
> +

...

> +
> +&hdmi0 {
> +	enable-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> +	pinctrl-0 = <&hdmim0_tx0_cec &hdmim0_tx0_hpd &hdmim0_tx0_scl &hdmim0_tx0_sda>;
> +	status = "okay";
> +};
> +
> +&i2c6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c6m3_xfer>;
> +	status = "okay";
> +
> +	hym8563: hym8563@51 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "hym8563";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hym8563_int>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> +		status = "okay";
> +	};
> +

Stray blank line

> +};



Best regards,
Krzysztof

