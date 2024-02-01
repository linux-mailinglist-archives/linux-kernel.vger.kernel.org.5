Return-Path: <linux-kernel+bounces-48213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2A58458A4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0EA41C25D09
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99A153368;
	Thu,  1 Feb 2024 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5QYqlOg"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208FF86627
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793400; cv=none; b=gazHS83S+0dz1dJmaQULIcfbvdIeTzcxlVcPDwIbUyuz9ZcjhBPQaYCL0kwu1RHF8JhhnYr1ENee0wz3hrzZfQT6nmqVvQsd7dU3rnc95VMlHCDh0ffb7VPy1QZ3tG4yAfjQox+lRl4roYT85rXQ66q+uvbJ8MlA2zJ29YRLwEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793400; c=relaxed/simple;
	bh=jt6uwfPJoe0wq9bQzNnr2HwOF1cCYDzfEqSyn40vmLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFkPqkwRQwOszHc5p5LiyFlddpA1ZpYxcTz03MewneFqjyyTeJxRa3zXuZAjT5N8HM9Ou+vqd8qckW8iGreIfGdDEP4QYD/IcytJVkyqwbUdKp0PNVt37mj27ESxxs4spnCKo+q/Ok8uSIlYQCnBKU60roRZD7xkA35mdn6RriI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q5QYqlOg; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so1277277a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 05:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706793397; x=1707398197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YUhFYTlLab5T6jUIS091F3j7Zvj1LwtCr7XI50W9+t0=;
        b=Q5QYqlOgrL5wlKzRI0auJyXiDcR2rmZ+558tE1aPmaD1+5O9VvQ7qz7Piy4nPh1Sog
         AT49xWDu1tAzSs5asc/XEPWQRmwTbMR0YbO7rRira0myosevCQY/H6T5S0ZVCBNy/2zu
         UkG8XyHABLei+76VdbV9Yf9Rj2UIOKPZAKsORToch3WDZDom71L3IO6hKJmaVgW8mgUI
         ACqkn3D5DKvI7pVspqNdFvzrHQ+7qzJhvtE4ehF+KVgiMpMtchmBpNMGI6SuqPqKkAw1
         4FMMSiPSKpbL5FKFbncYC8kkO7xTZ20cizk5hjei6/Aj7hsni7rh0OULEDhgA8cIklpx
         f9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706793397; x=1707398197;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUhFYTlLab5T6jUIS091F3j7Zvj1LwtCr7XI50W9+t0=;
        b=obQ9hGCAdpadsXvUSf5tocc86kvtJmo7x6E1siUflDDhd/Q28/ehR/lFDlExsZgkwH
         HHv2pnGbOTZj35vEgPUMQ7gdGheBJcPr+Tqj5Oj1ewC7x3PaboqmVZE5/LI4BmQGCf7H
         VF4qFxefJfeQyfr0p4PY6lGw1pGioRlApGNpSwivABtlK7AWLrwjujvCjclwqA5/rfZR
         QOfo5KtUfV17z9dWEgEjjSM+s9Hri1tWHpenTY+1YM9PlS+XG4kMhyYJCAtCbRMJhxgQ
         XQmft9GdLG8p7J0XNYjqn3kQkvuHx5x6NbRx0G9imTF6nJcKOFlpfWxSlTtBzIsXPlAu
         IRmg==
X-Gm-Message-State: AOJu0YzPYfG2wIs/kPFHby3XaF4lWcylmEq/LEaLg/j8HBh4ljiHLFNj
	Bidx6Ed8dxz+CA5MnKYWhslMzaRRdNk92SWr3mAWhktDBN2HL/0hekGjnHEZBYE=
X-Google-Smtp-Source: AGHT+IGFiy+LW25nu8PNACWZCIqAGTz/j4yf8x4/qczq6L9q3baZrSomlduAwqq+mwWyMm1ORJl/eg==
X-Received: by 2002:a17:906:22c8:b0:a2d:60a:2ae9 with SMTP id q8-20020a17090622c800b00a2d060a2ae9mr3942370eja.52.1706793397203;
        Thu, 01 Feb 2024 05:16:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXsz2zh9zlYCHCASSDGUxgivCeg7IMmv5j96GjZ//fhgErntgbdaUXfUJ2pNw/u0xNacWyYtPUkysb5+JBTIGtfPAdIgHOunRqEQ4zCGOcav/UXOopRHZoRZCapI35W+4fCyaY=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id lz13-20020a170906fb0d00b00a317ca8b422sm5915076ejb.92.2024.02.01.05.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 05:16:36 -0800 (PST)
Message-ID: <dfccb849-67b6-489b-8e83-3df1f9b29877@linaro.org>
Date: Thu, 1 Feb 2024 14:16:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] arm: topology: Fix missing clock-frequency
 property warning
Content-Language: en-US
To: Stefan Wiehler <stefan.wiehler@nokia.com>,
 Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240201123605.3037829-2-stefan.wiehler@nokia.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240201123605.3037829-2-stefan.wiehler@nokia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 13:36, Stefan Wiehler wrote:
> If the clock-frequency property is not set in the cpu node but in the
> parent /cpus node, the following warning is emitted:
> 
>   /cpus/cpu@X missing clock-frequency property
> 
> The devicetree specification in section 3.8 however specifies that
> "properties that have identical values across cpu nodes may be placed in
> the /cpus node instead.  A client program must first examine a specific cpu
> node, but if an expected property is not found then it should look at the
> parent /cpus node."
> 
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> ---
>  arch/arm/kernel/topology.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index ef0058de432b..32fc1c8d9d11 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -85,15 +85,24 @@ static bool cap_from_dt = true;
>  static void __init parse_dt_topology(void)
>  {
>  	const struct cpu_efficiency *cpu_eff;
> -	struct device_node *cn = NULL;
> +	struct device_node *pcn = NULL, *cn = NULL;
>  	unsigned long min_capacity = ULONG_MAX;
>  	unsigned long max_capacity = 0;
>  	unsigned long capacity = 0;
>  	int cpu = 0;
> +	const __be32 *common_rate;
> +	int common_rate_len;
>  
>  	__cpu_capacity = kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
>  				 GFP_NOWAIT);
>  
> +	pcn = of_find_node_by_path("/cpus");
> +	if (!pcn) {
> +		pr_err("missing CPU root device node\n");
> +		return;
> +	}
> +	common_rate = of_get_property(pcn, "clock-frequency", &common_rate_len);

Aren't you adding new property? Is it already documented in the
bindings? After a quick look I think this is not documented.

Best regards,
Krzysztof


