Return-Path: <linux-kernel+bounces-47844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D986284539C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE05284BC4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD1915A4B1;
	Thu,  1 Feb 2024 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCjBhpjU"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E779315B0E8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779043; cv=none; b=deyvET9c7q/boXIYGHclxgNNt7auj7QOtZir73B18MVc5ny3CLyIpQ2Nf5CvhKKqO0EYFTZmV7ukoqwvlT2dQ2TZAvHNBPh1Q5WWCXQWv0E7zCeJYTDyXQjc7gCjrcQAvlzRAD855iT/NK3MUk7Uv9oOcbnZ2ZS79YJsBwsYKj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779043; c=relaxed/simple;
	bh=45isAhMd6LLtdHd+BAk/CV6skOw9K0fbKtLkRQ7WK/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4bOlTj9PHX/MUwP6TgMJDlKDMtKkD/Ub+nQVDKtGVsXgHvyEviXOBsWGO5T2C2uGygnzBaZCLaytVYUFR/C50CNqHvBYo1neSfCnkrgrX0nxp6aJOLdrK0pGuHert1Qkq1NzEj0UcfxqX+NbQq+aRAWkoYxkRmXj1I0Ko3ZiS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CCjBhpjU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso812473a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 01:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706779040; x=1707383840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ovtqlZzW1K6QjRjoiFhCbDbH7IJm7gi9GodRSIczQu8=;
        b=CCjBhpjUzN9sZr2UXXItbCDxiR+xlBi0y3i59fiBbbS4Vz+7pZf+4MahHAgheAk2E0
         ldihy+io75iLksgs5y16HRdvwKwQooqiONyWfiKwTeEPpqFuackP1yYoOjXFywHfPMLM
         FcHeFiaRjFHFYnJletwzNCNdvDpHS8YwZN3iMycHWWz+UeLgiXzylOhW+J/sNB6xAVqO
         gOxkpv3E37uKEv27q/CNMygD3SL2LmSCZvQu0Vm9OflMC5G47xyn09QJcjVnpIeqL3Q1
         aHWQzkWYUNOR539GgloQwfk3sQfNJkutClwF5SQBJ97SgGQkKLOHs0V4BRGxO284ELJZ
         7Vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706779040; x=1707383840;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovtqlZzW1K6QjRjoiFhCbDbH7IJm7gi9GodRSIczQu8=;
        b=jwlEqSKad4Bbo85ZaNuAenQ2E4KdSR8XhDi87E6dExaGr8ZaXrRS48Vomxebx+AXnW
         5rk7XFuKGL+TkrmDC7s5evNLGvxVD9ddDztQyNEFWaSBLYD2o3H+xrEVEpv6ivRoGPiR
         rZYUdwOOI6M5tefcmIqslbPdY13gEY3oGqyr/3hzzvRxtevLBrgZvkEjAajZORL6UkCJ
         +2GIU9LfoPOIyr9s3cntplIG7RyRVXjCouJQ1v5zIQqrOdPyL9Yc3d6LGeVziNLb4HZF
         mIUtP6wArH8izxbLU0ufNlptYADS5gN28McjaYa7CIOJqLix+9BEY+exTG02PaV8IM/f
         7ZaA==
X-Gm-Message-State: AOJu0YwmSAZ955HR3Ev1/r9F4kdqFaZ2EM2NP21AA5avi9JxwK2/mW6M
	bVipsyinrBGaeqz0jAk1R6NHh8MyV3d89pqbL7xgnSQE21JRD4z9u4sqdi4ike4uyq18Fpmv3/v
	1
X-Google-Smtp-Source: AGHT+IFC6569HGBWzP2B/TwqCI5rloTd6lRmSg2vLEMmdbFMbGczsyCQb1eiCmQHKLRD+gvTFL7sgQ==
X-Received: by 2002:a50:8ad8:0:b0:55d:1eae:1e9f with SMTP id k24-20020a508ad8000000b0055d1eae1e9fmr3213477edk.15.1706779039954;
        Thu, 01 Feb 2024 01:17:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVO7HD/NtVkpUQUZar+ejLYECBb+ZqRvIivRHQN62ZRvi1TFwQMJtBtKDhjlLlZOUx3n8kFUdgp+xahFGQlk7DBZqbOvYFnTFhWYcgOilnE1ss0Ek1fmnPuiy21if6ULy9ruapFvn6Rh/y1/WsWFjRXMwHOQqsaKWReMvhnRcKOV/xRn0F1lebvfc6xtfsklMjX31gMJg1oYqh5OeEXxThveUBGKCf0QYIF5g65SJPbx4LX1BPRL6olGnI99M7r+fcET4k284NQMWnaL/IGfglHRFR2zHOsptVronrE9Y6Ac8GLsZyCR2ke6kpuYgp60/vCWic/6pwcuZg99FNTWWaqQuuLCqDwm4CdwjlYEAWtZiz3TVv176MPLtBwJ1AmIH1KkY1zbWve/GSoHYrbz5mdj+jEKtDAsN6hcvl4c7p1v98NvRNWM24vHH9XaGBZ7bMipwlktE+tVUc4ItHjWcrHfXg+UBQZdleWXUZ0i2GvqOvVPSQAE3Ja
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id c17-20020a056402101100b0055ef8318e97sm4152325edu.46.2024.02.01.01.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 01:17:19 -0800 (PST)
Message-ID: <4d50b0a1-4dbf-4a6f-bec9-07b8b3f92829@linaro.org>
Date: Thu, 1 Feb 2024 10:17:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/15] dt-bindings: mfd: syscon: Document EyeQ5 OLB
Content-Language: en-US
To: Gregory CLEMENT <gregory.clement@bootlin.com>,
 Paul Burton <paulburton@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240118155252.397947-1-gregory.clement@bootlin.com>
 <20240118155252.397947-11-gregory.clement@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240118155252.397947-11-gregory.clement@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/01/2024 16:52, Gregory CLEMENT wrote:
> Document Mobileye EyeQ5 compatibles for OLB registers that are
> miscellaneous SoC related registers.
> 
> It is used to expose SoC specific configuration such as for example
> reset, clock or pinctrl.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

No, please drop.

> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 084b5c2a2a3c2..c90633460eeca 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -55,6 +55,7 @@ properties:
>                - mediatek,mt8135-pctl-a-syscfg
>                - mediatek,mt8135-pctl-b-syscfg
>                - mediatek,mt8365-syscfg
> +              - mobileye,eyeq5-olb

Please work with your colleague to avoid posting contradictory patches.

This is something else.

NAK

Best regards,
Krzysztof


