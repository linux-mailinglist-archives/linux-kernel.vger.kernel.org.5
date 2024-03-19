Return-Path: <linux-kernel+bounces-107323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E2887FB12
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59EC8B2178C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5CB7D3E2;
	Tue, 19 Mar 2024 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oUM2x827"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3BB1E536
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841808; cv=none; b=tO+yeeAwyvWtq1Qtu04uFLKPjEgZqx0SSITqdQpItudmgXkXRXs6VNS146aZKZTeuLfUhbCN0+fdrM/He4EzpQq9R9wCsYP6KIaVoJKCrhv6uj+kj8yOpx3OKqPm/ttHqk4SDc2zojTTuux4BHzuFeCtfGWAZPrSWF6uwAe/lU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841808; c=relaxed/simple;
	bh=tw6VpL6uUbF1l8qk/1ld/s+lWnYJuW351zygV2v0NuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OX3fy7iAUtEA89IYT5g0iLmJcr/kjLN1vZ85CcPP8rHFGcO2ii5UxcR4IsGpFRF5UkHIV6IhTAmEnUZ0aMbPp6V2zTxX//G+8/fmYawZpTfv2Vik/U1YiTZ6rdDlBAmrrlglwbzqizkaBVIvtGWEem1Un16RiT9gxGTZc2WJpjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oUM2x827; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a450bedffdfso645072366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710841805; x=1711446605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/3djFcV85FlUlQbj3yunmUo0E6cySmtvMQYg/G6jYmk=;
        b=oUM2x827h7PPer2IKdaeiZLAfCi1uemooXhxJMJef+UkaWn/Ej9EtXQTB5z4MLsT7S
         a7u5+DIJ4ey6iTDJdZRQD3krXSSbhHDYXlGt8W8ue6Fmx9f4CZBuvcCVAZF2hAh4uHhm
         KvbpgazJoldKym/JgVC80RF/DVwbjw8vcR1g4xfMU9WydLKsP0YI297ZJlLWgq5yyJzW
         CCMehCU7si+OZaJBuySmOzuL7RL1PH1vhhRvWqMBgUuobA//xfIRb5amVN/7niAH95s6
         lD2K2zClMppZYtoVQpBGuCKFkzbcAY1Sl+5LIsnjkeUbtOKoQDp8iKd/6cgj0l3/ZHqn
         BoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710841805; x=1711446605;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3djFcV85FlUlQbj3yunmUo0E6cySmtvMQYg/G6jYmk=;
        b=fvw2Q9NjUqIf3u7UjrB0AOShZ2014KUOWVoN4lHlVg1RBv7KuJQkhLzvkA9NkFd/e8
         k6WwQdpov74uQs0s1v5wQZu7NPkGXC1jtWkKyKSxf8lz2nMcVNk508sbIm6dilY0ROAb
         ZrrBcmgw2jN+LClN9PUb7/0CUrvWnRmAl/dg95RSPYqb8HPIqcgRBVrTcNvPQwmMKMK4
         FQFJdqiRGeoPrydWsVHm89LpyrfbmJsP7svqkkJvLQ2xmKucb2MPmZRafi6mV7XmnSuH
         jomR1ywet0OM4Xte8eb08pmeU7cWi3uA8vJvIcnrLonRFOI6vFjJ5lSsGivMXwt7te1G
         pslg==
X-Forwarded-Encrypted: i=1; AJvYcCU8fk5x3T1Qyfv7Kz39hifTsn8ScBPewylQxJV4v9G4igKtVXbt3jZRJR5rbMc6+3Nea6o+ceuPXkaQHb4sKqef5p5rZiWi19hIvYAY
X-Gm-Message-State: AOJu0YyAJpzpO1KvS7lWlZJ7ydkgRkc/9xg+gueWIwW0rJ38k5BCm9gs
	VD3+NLLa3h86utuEPYtGtTlCwmsiGX/ek3u2HikarP+qexLRrWsxuga+tokFUwI=
X-Google-Smtp-Source: AGHT+IHub3GerXpEi0+h2eEzC/rsUiII/Qbh7o0i096OhIsOQOgoPcmYiKDyB+SU92D5RtOm8jHkvA==
X-Received: by 2002:a17:906:5913:b0:a46:9cc5:c3b4 with SMTP id h19-20020a170906591300b00a469cc5c3b4mr5464869ejq.76.1710841805472;
        Tue, 19 Mar 2024 02:50:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id v15-20020a1709061dcf00b00a46cf83216csm1345710ejh.120.2024.03.19.02.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 02:50:05 -0700 (PDT)
Message-ID: <b238d70e-0361-4f3c-ae6a-4e6497b95d75@linaro.org>
Date: Tue, 19 Mar 2024 10:50:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] ARM: dts: aspeed: Add eSPI node
To: Manojkiran Eda <manojkiran.eda@gmail.com>, patrick.rudolph@9elements.com,
 chiawei_wang@aspeedtech.com, ryan_chen@aspeedtech.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 jk@codeconstruct.com.au, openbmc@lists.ozlabs.org
References: <20240319093405.39833-1-manojkiran.eda@gmail.com>
 <20240319093405.39833-4-manojkiran.eda@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240319093405.39833-4-manojkiran.eda@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 10:34, Manojkiran Eda wrote:
> This commit adds eSPI to the device tree for aspeed 5/6th
> generation SoCs.
> 
> Signed-off-by: Manojkiran Eda <manojkiran.eda@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 19 +++++++++++++++++++
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 20 ++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
> index 04f98d1dbb97..eaf7d82b6f46 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
> @@ -343,6 +343,25 @@ sdhci1: sdhci@200 {
>  					status = "disabled";
>  				};
>  			};
> +			espi: espi@1e6ee000 {

spi or syscon

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +				compatible = "aspeed,ast2500-espi", "simple-mfd", "syscon";
> +				reg = <0x1e6ee000 0x1000>;
> +
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0x0 0x1e6ee000 0x1000>;
> +
> +				espi_ctrl: espi-ctrl@0 {

What is this device? If parent is espi, then what is this?

Where is the binding?


Best regards,
Krzysztof


