Return-Path: <linux-kernel+bounces-104876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AA287D4EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB91283C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD8C54913;
	Fri, 15 Mar 2024 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bw/zx9d5"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2766F548F0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710534025; cv=none; b=QdW9ZPm11W8LtecIm5AjZRxfveJwirRJqUhMH3xKp8Sb9NhecDIMS3FrNlrBnL8luedNWpxhq1s8eyQYmTPBE/GZVDbreveZF44ONFpa4zpYpDSAP42Racv58s0nWQF9i1GAne1HJ4/RuPNwIE2trWR57rqX53TrzEDqCdYMJ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710534025; c=relaxed/simple;
	bh=+DQR2nBjMja+TfZ2yPy4DXsIISRqnSqU9Q45HRAC0dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PkZuh1hTph5j8GOLHxoo1346bO+3X/ZCY2G2UcYdxSSjoIreHBLZGFGhIyJMGw2W+EudGuiASk0VtmvgmrhZJecidQLbePVeC3aJlCYSuyu6vidK7+v4I6qC8E40jmA7o++iz9wn2yvqJHSvXp4GZ1PXeIaq8H2GOLZx/5mREV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bw/zx9d5; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5131a9b3d5bso2940007e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 13:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710534019; x=1711138819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nFLXmRhGh05ZQ+tNAE5GDIqilWlaMO+4VWUU/gtzhg8=;
        b=bw/zx9d5pLTFtgM+jIgD1W6PkTxrRwSDgPaDA1ik7DXtygaXNmDDW3hDCJQvCAJQa6
         R+MMdHTx4OlOvWdyM0ufX1ncZNQihyQUV6aW0F/bkJW2g0vv0GF2avfRMPP8EnZLdy7k
         KrvE6vEjXWpkChheC0sf8wgp5L+JRZZNyr+IP7hU8LIk0bWCPb9fEw8c8my+kB2igTdK
         rs3C3aUXoDKwAibfOA0JUt/a+tgd7uBk/0e6Ps5QK7sdKNiWHFXZAfhYXta5yXEhEAGa
         UrfaaWQ+1j9CR/GPiYZ4sLhQk853+dWHg8RVda3C6IwAH0/jpvDobzFwAkDomHzRCETl
         78MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710534019; x=1711138819;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFLXmRhGh05ZQ+tNAE5GDIqilWlaMO+4VWUU/gtzhg8=;
        b=WFRwsUvAjBdkYQwX+vvM4vc15vsBrI0qQDRFvn4QbtD5NS8KNexbmXarAj2t6CNC0s
         z0TxTsrUHfeLNwJjjvsX/CNqkesDxWos+vrKf+AJrKBdBs+kmluYeyJbOd3vLVbE+4Ru
         tlRLME4SZuFO+i20tjc+yYfV8/RhHunDKfCb3FVcuyhC5bxcZ+FfGCidukhNuBjbRiZr
         PCo7NYXiWWJedmayGaDaKRFOagODH0+vmJA34A+zJwGVeBUVSme2SLnGqfgWepR57OCX
         Z2vdo/5p/u5wBIXZ4ODWBtsfBDdvewAn/wqFOAqiff4c7fDsv71wzAzfoSgcmAwQdg2Q
         nFxA==
X-Forwarded-Encrypted: i=1; AJvYcCWERgwqt/1S3Oo10VEj93QHtTIWXqwT31KqFBO1KZUcGEaKi5/ay2UDCNLlqm2r8PlEc9s/xlwxvvmvbbIzrXiUvYc6+R342E6d7FQb
X-Gm-Message-State: AOJu0YzIMO317czwZClPQDHSnjPeW9+4X4Z/tZ9ar7i+a2Qae7xbdx4T
	OxqkSpO8b6MEFuzuXnXnBwMBrll6UJDHBXp9ALGkXRqKNNvKnVnxLJoU8cepX+Y=
X-Google-Smtp-Source: AGHT+IF4vTBppgdKLxPs0gyXIFUHd6EcJY0uvVQJV5qIJs0T7dA0+OeqNjD+A2cte5EpHKfHfRAhuQ==
X-Received: by 2002:a05:6512:2815:b0:513:a39e:ae45 with SMTP id cf21-20020a056512281500b00513a39eae45mr5383892lfb.62.1710534019273;
        Fri, 15 Mar 2024 13:20:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id u8-20020a5d4688000000b0033e3c4e600asm3953082wrq.7.2024.03.15.13.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 13:20:18 -0700 (PDT)
Message-ID: <b2e76011-8645-445f-b92d-54ce9cef3c3f@linaro.org>
Date: Fri, 15 Mar 2024 21:20:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] dts: ti: k3-am625-beagleplay: Add mikroBUS
Content-Language: en-US
To: Ayush Singh <ayushdevel1325@gmail.com>, linux-kernel@vger.kernel.org
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 Vaishnav M A <vaishnav@beagleboard.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jiri Slaby <jirislaby@kernel.org>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, greybus-dev@lists.linaro.org
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
 <20240315184908.500352-9-ayushdevel1325@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240315184908.500352-9-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/03/2024 19:49, Ayush Singh wrote:
> Add mikroBUS connector support for Beagleplay.
> 
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> ---
>  .../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 76 +++++++++++++++++--
>  1 file changed, 68 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> index a34e0df2ab86..886308f99d1a 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> @@ -29,6 +29,7 @@ aliases {
>  		i2c3 = &main_i2c3;
>  		i2c4 = &wkup_i2c0;
>  		i2c5 = &mcu_i2c0;
> +		mikrobus0 = &mikrobus0;
>  		mmc0 = &sdhci0;
>  		mmc1 = &sdhci1;
>  		mmc2 = &sdhci2;
> @@ -230,6 +231,33 @@ simple-audio-card,codec {
>  		};
>  	};
>  
> +	mikrobus0: linux-mikrobus {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


mikrobus {

> +		compatible = "mikrobus-connector";
> +		pinctrl-names = "default", "pwm_default", "pwm_gpio",
> +				"uart_default", "uart_gpio", "i2c_default",
> +				"i2c_gpio", "spi_default", "spi_gpio";
> +		pinctrl-0 = <&mikrobus_gpio_pins_default>;
> +		pinctrl-1 = <&mikrobus_pwm_pins_default>;
> +		pinctrl-2 = <&mikrobus_pwm_pins_gpio>;
> +		pinctrl-3 = <&mikrobus_uart_pins_default>;
> +		pinctrl-4 = <&mikrobus_uart_pins_gpio>;
> +		pinctrl-5 = <&mikrobus_i2c_pins_default>;
> +		pinctrl-6 = <&mikrobus_i2c_pins_gpio>;
> +		pinctrl-7 = <&mikrobus_spi_pins_default>;
> +		pinctrl-8 = <&mikrobus_spi_pins_gpio>;
> +		i2c-adapter = <&main_i2c3>;
> +		spi-controller = <&main_spi2>;
> +		spi-cs = <0 1>;
> +		uart = <&main_uart5>;
> +		pwms = <&ecap2 0 500000 0>;
> +		mikrobus-gpios =
> +		<&main_gpio1 11 GPIO_ACTIVE_HIGH>, <&main_gpio1 9 GPIO_ACTIVE_HIGH>,

Join with previous line.
> +		<&main_gpio1 24 GPIO_ACTIVE_HIGH>, <&main_gpio1 25 GPIO_ACTIVE_HIGH>,

Fix indentation. See DTS coding style.

> +		<&main_gpio1 22 GPIO_ACTIVE_HIGH>, <&main_gpio1 23 GPIO_ACTIVE_HIGH>,
> +		<&main_gpio1 7 GPIO_ACTIVE_HIGH>, <&main_gpio1 8 GPIO_ACTIVE_HIGH>,
> +		<&main_gpio1 14 GPIO_ACTIVE_HIGH>, <&main_gpio1 13 GPIO_ACTIVE_HIGH>,
> +		<&main_gpio1 12 GPIO_ACTIVE_HIGH>, <&main_gpio1 10 GPIO_ACTIVE_HIGH>;
> +	};
>  };
>  

>  
>  &main_spi2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&mikrobus_spi_pins_default>;
>  	status = "okay";
>  };
>  
> @@ -875,9 +932,8 @@ &main_uart1 {
>  };
>  
>  &main_uart5 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&mikrobus_uart_pins_default>;
>  	status = "okay";
> +	force-empty-serdev-controller;

NAK. Don't add undocumented properties. That's a clear no go.

Best regards,
Krzysztof


