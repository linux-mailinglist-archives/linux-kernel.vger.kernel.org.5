Return-Path: <linux-kernel+bounces-40245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4F283DD1B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 598BEB23F12
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8CC1CD3D;
	Fri, 26 Jan 2024 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z2eOLFKF"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754B61CA9C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281913; cv=none; b=P08jG/n+xhaxY3z1FZZrnarLd26pXuGBeu+apKWFY5fq4W/upqaL0BXJn6AxJrihBe7ncyxU9gB9qaLd8T/BKj3EOekZETapKJZ2yVgB/I9yGjvqmfZ4BEuKFvgbUGquhfwwNZQoxjWycMUr+3nIkQqwZcULND8O+g8IeN6hcx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281913; c=relaxed/simple;
	bh=xXdX+Dc78mot7kbcSoYt8oFsRKpIUc4HFhAMXUgfTto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flJk8B+reL1FhoEvk/Sbb1rfHyVp1Jh+5FcOUTe/pFZkbo/hE4AdUbng676/Dcp4RnmgLVI8RMvGSQfwranCSiyEHxNxllGCUKHrSmwDwcXbsAwIicAGl/F59LEwOnVReyEzMMc7z45g0MMW4Dzupu/c1+G8mmx35D7vGCXjM+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z2eOLFKF; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cddb2c2b54so4739811fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706281908; x=1706886708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TroYeDCfxxp0sdt/59BZMUINvcLvNwM6VbqLaCd2vEw=;
        b=Z2eOLFKF89WJ1MCjfFsYdEE4H1kJEmvv64BKCLypKl4QN5ZdMiKFI4u4JeeEekZA6y
         4OraIx9hMLlxwDsv9nCpXR1TAHPMFO5fjtouNYCRP4dyREakRhfzwgTYDgqcRAw6yED5
         W1TvuLQjvHdEAAXwEc3BdKgCpt/5X237767NwuTwP8j37CVhNyFS2STioxIV9oiusAOI
         0TslVVDSqtieJ6cD4oZgnmG5lSHo4pteU7/QK0J1ef6QdKkLUzNKPRjfLVFdsnjvsZpb
         2u9TMY7iq5wAQewINvgg7+0fuwKUGsdX7ts3CFUjWb3dBVEsZHjupZTXdkhphAZjkM8C
         QkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706281908; x=1706886708;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TroYeDCfxxp0sdt/59BZMUINvcLvNwM6VbqLaCd2vEw=;
        b=h4rebMtXUkq5poUlOht143WIew65EidOJsVRB0BMM68vPBTVHr/FiTLN+/mpw1ggz8
         aITuAAv3lfdScQQRgN6tHlLsXoQgIJCBptXripYFI4rcsvbBMq4/Nn2/h+YCIVzA8sCZ
         yZrrbaCPRUrQRoKhLX61y+2goD/o7rjDh8ftG+B6d2O9rHrdx9nrBl9s2ExWcKrGgIdJ
         QYz6tNIU9SKAjgbACDVY6XOcpF/HlsVufD6OXq0BmXfSjMylTHBDgAIDLBrME+oyGg5p
         uIrdV6fOliis5SBdn6ZMBsjyvgbCLXfkMvEFyAOILUfy+SdqFsRbkjyNHJSQQF1lMk/H
         zowQ==
X-Gm-Message-State: AOJu0YzNkgpxR/5E8cp8NhLK3I6ATJpibaXMzyFAk5OG0eSRs73payOE
	8n7CSg50JHhJwzYyAYWOL7RO5gEfaJ3gS70wTCi4OMCslQ/UOoFYoBp8UQxLqQM=
X-Google-Smtp-Source: AGHT+IFByrL//FyqNqJ63gAYPN9Ad0maBW8zW/JoGbIPFHpQoP/+j36zPZRqpDHL4SvWy+iR9QIpjg==
X-Received: by 2002:a2e:890e:0:b0:2cf:34ce:67ed with SMTP id d14-20020a2e890e000000b002cf34ce67edmr1872546lji.44.1706281908239;
        Fri, 26 Jan 2024 07:11:48 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id c14-20020a0564021f8e00b0055d81121180sm112820edc.38.2024.01.26.07.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 07:11:47 -0800 (PST)
Message-ID: <0bc7081f-f279-4741-b14e-198b2d00d5d0@linaro.org>
Date: Fri, 26 Jan 2024 16:11:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am62p: add the USB sub-system
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, nm@ti.com, vigneshr@ti.com
Cc: afd@ti.com, kristo@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, srk@ti.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240126125951.18585-1-rogerq@kernel.org>
 <20240126125951.18585-3-rogerq@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240126125951.18585-3-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/01/2024 13:59, Roger Quadros wrote:
> From: Vignesh Raghavendra <vigneshr@ti.com>
> 
> There are two USB instances available on the am62p5 starter kit. Include
> and enable them for use on the board.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 46 ++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62p5-sk.dts   | 67 +++++++++++++++++++++++
>  2 files changed, 113 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> index 4c51bae06b57..7e7cd749d9a5 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> @@ -560,6 +560,52 @@ sdhci2: mmc@fa20000 {
>  		status = "disabled";
>  	};
>  
> +	usbss0: dwc3-usb@f900000 {

usb@

> +		compatible = "ti,am62-usb";
> +		reg = <0x00 0x0f900000 0x00 0x800>;
> +		clocks = <&k3_clks 161 3>;
> +		clock-names = "ref";
> +		ti,syscon-phy-pll-refclk = <&usb0_phy_ctrl 0x0>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		power-domains = <&k3_pds 178 TI_SCI_PD_EXCLUSIVE>;
> +		ranges;
> +		status = "disabled";
> +
> +		usb0: usb@31000000 {
> +			compatible = "snps,dwc3";
> +			reg = <0x00 0x31000000 0x00 0x50000>;
> +			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
> +			<GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
> +			interrupt-names = "host", "peripheral";
> +			maximum-speed = "high-speed";
> +			dr_mode = "otg";
> +		};
> +	};
> +
> +	usbss1: dwc3-usb@f910000 {

usb@

> +		compatible = "ti,am62-usb";
> +		reg = <0x00 0x0f910000 0x00 0x800>;
> +		clocks = <&k3_clks 162 3>;
> +		clock-names = "ref";
> +		ti,syscon-phy-pll-refclk = <&usb1_phy_ctrl 0x0>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
> +		ranges;
> +		status = "disabled";
> +
> +		usb1: usb@31100000 {
> +			compatible = "snps,dwc3";
> +			reg = <0x00 0x31100000 0x00 0x50000>;
> +			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
> +			<GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
> +			interrupt-names = "host", "peripheral";
> +			maximum-speed = "high-speed";
> +			dr_mode = "otg";
> +		};
> +	};
> +
>  	fss: bus@fc00000 {
>  		compatible = "simple-bus";
>  		reg = <0x00 0x0fc00000 0x00 0x70000>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> index 1773c05f752c..7a16e7a8ac66 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> @@ -27,6 +27,8 @@ aliases {
>  		spi0 = &ospi0;
>  		ethernet0 = &cpsw_port1;
>  		ethernet1 = &cpsw_port2;
> +		usb0 = &usb0;
> +		usb1 = &usb1;
>  	};
>  
>  	chosen {
> @@ -297,6 +299,12 @@ AM62PX_IOPAD(0x01b0, PIN_OUTPUT, 2) /* (G20) MCASP0_ACLKR.UART1_TXD */
>  		bootph-all;
>  	};
>  
> +	main_usb1_pins_default: main-usb1-default-pins {
> +		pinctrl-single,pins = <
> +			AM62PX_IOPAD(0x0258, PIN_INPUT, 0) /* (G21) USB1_DRVVBUS */
> +		>;
> +	};
> +
>  	main_wlirq_pins_default: main-wlirq-default-pins {
>  		pinctrl-single,pins = <
>  			AM62PX_IOPAD(0x0128, PIN_INPUT, 7) /* (K25) MMC2_SDWP.GPIO0_72 */
> @@ -340,6 +348,36 @@ AM62PX_IOPAD(0x0124, PIN_INPUT, 7) /* (J25) MMC2_SDCD.GPIO0_71 */
>  	};
>  };
>  
> +&main_i2c0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c0_pins_default>;
> +	clock-frequency = <400000>;
> +
> +	typec_pd0: tps6598x@3f {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "ti,tps6598x";
> +		reg = <0x3f>;
> +
> +		connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			self-powered;
> +			data-role = "dual";
> +			power-role = "sink";
> +			ports {


Best regards,
Krzysztof


