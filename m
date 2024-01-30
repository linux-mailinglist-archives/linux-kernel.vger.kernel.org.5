Return-Path: <linux-kernel+bounces-44085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63689841D27
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B87228880A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3208A54736;
	Tue, 30 Jan 2024 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nqccetSU"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3893A56458
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706601838; cv=none; b=KVBeXyvznv20RgRIFaxjcrT2+vds7vZSGxnjXd2vcJrH1aTeFyR2p0+pTSTN7jPQ6esPayareOaZOkExN3EDAHtqkFNATKgM1XVb90NOI+jFPgVFzuSczg5PyuW6eIHRTmFPx6MMYf/AUTPJkpf6XqmH1x3BH6ZQqyNYpfiBU3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706601838; c=relaxed/simple;
	bh=AXEnRn6uuC0ylZxXmV079bKsOQui39FdQnUlVEW1+iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYREPJX/F7jYJxTZWktja4zbQW8vVGiXS21wWqbaCXjXn7YaUD5HpgStL1JTbQYmGOLXwCqsf7roPi7uChR7WwmdkCFg53P/qXolS7VigyFwDsTC4ug/Ls40bUsYgCAUckkO2XA4PzKoOI3/YrQ2B5vI3hxaxU3GweRgh/4lQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nqccetSU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55f15762840so1543842a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706601833; x=1707206633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cjBz2sDHD9qmDzJiGaVXVB9yXjr7XeyDRf+P0XXT9D0=;
        b=nqccetSURt+JEC+QbIXuk4AYEtYEz8Qafa7y53piJtWqZ6ym4aZxtrWKNYwJ5+pS3l
         8zdAdAsdTKNgrXcnlaa/48EGcFFVFh2gp24AXw5C72t2uOG8gTgPWtFWmxVspwVYio/y
         Jz9KhGGA0NM5UYXh0s7zLfVHfwG6fgqBU5sfGQJOSYD2rYFdbVkcD7Fg2pF+UCGNUh+F
         b+gT7BWR+Ffm9g/wkIN44Xa7Lz+wVOtlhwyJu4yBRKAXMEypWy1EXiE6pilArnt0DYcL
         79TPCAfWqlMJizHUe8Uzox7+E3zV+FnFrscVi2MmWZS8V/lr7v0jhSZGY9hjpB9HBuIV
         ESAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706601833; x=1707206633;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cjBz2sDHD9qmDzJiGaVXVB9yXjr7XeyDRf+P0XXT9D0=;
        b=DSWog9UO1h8PeN1av9ZgYIQDP/GUhT15Cuh1jjkZTUfbCWbNkqLIE2wJwQqkJb8jX+
         XV5KAnQtkUyjHDP2DDk5T2QRvg90wT4ulXhgiiznaMW48qQoTN7AGMnMnTFXo0a2v6R/
         Ss8hZQRDvDYyR4NLSzwvJpHZiyW57zZPEq49ATZ6Lnw9fmZU1jG7iUwjD0XxaibkmTrO
         o4bZkt2owqpcCOcKxWYgtkavBcUvN0L8g4fL8XL/OBeV+lA1c2rqma4PxJLuR7tKrkHK
         nFDAH1Hy6KcPoEMjlWV8WwKnT54YrrVs0np1oAocIpob/MMuw+e6tnwa6CZaGgkW+HOF
         NtPQ==
X-Gm-Message-State: AOJu0YzFNcqVHHPN8evlijUYeYOdr2rjX3N+apW7ux15wZW3CJzY+Srq
	sXJPg3CqiOvXGYPHwFUjTv6ooOJLysUIck1yQwzPplu5oRIU74472PaHUX1X1X8=
X-Google-Smtp-Source: AGHT+IHLHe/NBesm3AFRLUXuR10/PosXK7SnfYv0WqKDIp7i9AkVZ4aZpvPhaqzFNFX3CkCiaFm1cg==
X-Received: by 2002:a17:906:3642:b0:a31:2119:90d7 with SMTP id r2-20020a170906364200b00a31211990d7mr6555133ejb.38.1706601832667;
        Tue, 30 Jan 2024 00:03:52 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id j9-20020a170906254900b00a311685890csm4825575ejb.22.2024.01.30.00.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 00:03:51 -0800 (PST)
Message-ID: <81dab1b6-cf40-4c9a-a806-48aafc8a72ea@linaro.org>
Date: Tue, 30 Jan 2024 09:03:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: imx8dxl-evk: add i2c3 and its children
 nodes
Content-Language: en-US
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20240129221458.250492-1-Frank.Li@nxp.com>
 <20240129221458.250492-2-Frank.Li@nxp.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240129221458.250492-2-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2024 23:14, Frank Li wrote:
> Add i2c3 bus node. Add i2c gpio expandor pca6416 and i2c mux pca9548.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> index b972658efb176..d313cf1dd79d5 100644
> --- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> @@ -261,6 +261,61 @@ i2c@6 {
>  	};
>  };
>  
> +&i2c3 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	pca6416_3: gpio@20 {
> +		compatible = "ti,tca6416";
> +		reg = <0x20>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-parent = <&lsio_gpio2>;
> +		interrupts = <5 IRQ_TYPE_EDGE_RISING>;
> +	};
> +
> +	pca9548_2: i2c-mux@70 {
> +		compatible = "nxp,pca9548";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x70>;

reg is always the second property.

https://www.kernel.org/doc/html/latest/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node



Best regards,
Krzysztof


