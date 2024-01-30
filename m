Return-Path: <linux-kernel+bounces-43992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9795B841BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB1E2B21C14
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34FB383A1;
	Tue, 30 Jan 2024 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVmUGSad"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3A8381DA;
	Tue, 30 Jan 2024 06:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706596016; cv=none; b=ksEhBWr3DmwBnzXUcjuPa4zrWd3HJHXiLezbff5cIku8oYLPw13b0KCK6zdf8RIwH+PimM/p9+u9bwihtT9qwm9AR4SYzP+e7+6WXlJlybI2dsoulukYdSlUt/p+Oc2Df+f4j/p3nWD9NTK8l8oxExSa6C1910W5D27DpfCtkpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706596016; c=relaxed/simple;
	bh=G2H09HbRT8UUC7XVD9zqeo3oMqIO8alWBLi2zEm9YfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ogqB8Np0RDkFAETPZ1L/rJ+WrAwtZLWnDNSJRWcdrjzEdtky5jyZdGPnjMnzDy5Av1qIL18jR5/fm4/jdHcuAMRiaZDXTyMjckCTgMUn07hHJUeSiTqtd2fnPIV+kiY8Af8ANqR8v43L0Or7ehqozu/x00ZhixInW5hLGWw1EL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVmUGSad; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3be9e11ee59so30543b6e.1;
        Mon, 29 Jan 2024 22:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706596013; x=1707200813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GImDz5i38hz7JEhUDVGxtycDpAZ5nzC1980oJpg3sA8=;
        b=bVmUGSadTjkT4JIMOS0VgpJVEpyy/oGsHl2G3Xy23G4VsvylZX4O9l6u1N1Rcjnnm1
         M7IGaSO83HcWureFMPUBxA0STWTYFroP5JCbpp8WdlqqizNdkAD5j6lynihOZ/vRFvbV
         n7DmM7k+Y1JunXPRchZ38wTnnDBAr+9358+TCcBYFgv4CsmfUZq2e3OtcFUmSYNV1Tz5
         BI8K4hREONLABuLKQAiWA5aW4BGs/SEm5D6Z9qpi4duAvr8Wv6SPqJkecFxG+UJqqwJg
         jJSZiIffp3qPQIUGOlWuC/v8KppE7mhC0BiRfzhZeVz5QiDuBS4KjTAF0zruvA7wAnnI
         vWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706596013; x=1707200813;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GImDz5i38hz7JEhUDVGxtycDpAZ5nzC1980oJpg3sA8=;
        b=rr82K14Hz1Kd7p6j6rOqnB0+mlbPTd6jWZfwyBoOY+nEVrCrTwcjTHnmLBzwKfVzAz
         U1zSXh93bmE5SKDT+4LeyAbUDNxf/BezgIS+Ad12mxCudrKnKmwbaoK7HYG91le0MB8N
         7zeeWK1KfSl91hB8+/k0+Ct+koCiUkd7jzbtKTpjEVvNfBUJFLP0EN5KuDIl0KZ6PEdP
         iGArBX2xgacGgQN3uANp7oF32iXvWzOkIi6fNafcB0lWnTO5zrhyFIWHju7Xya4HGd7P
         K2bEOjzFxyUeg6lI3HUiHKpKF11mLDCx6ubNmSswqhNwjrnHwDTlnkkXAKlJuywcMGVQ
         3WTg==
X-Gm-Message-State: AOJu0YwUmJVQulZQVQ40OyenjPFUgD1+X9sB3595sBz7QI3Qul8KnmGF
	XGi9JkVHhvX8nZmHAZ1jMJlYDgFrAlcJRiHPQR1MYmj3f9iWNJET
X-Google-Smtp-Source: AGHT+IEy53pi0RbR8AMV6653iDgAfcpn/6UteGHZoIL0l7mHNLWYwkNPjTd+pbpeY+PyFXR1HXTgIw==
X-Received: by 2002:a05:6808:ecc:b0:3be:685e:b209 with SMTP id q12-20020a0568080ecc00b003be685eb209mr2571227oiv.35.1706596013369;
        Mon, 29 Jan 2024 22:26:53 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x129-20020a626387000000b006ddda3d854bsm7239672pfb.79.2024.01.29.22.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 22:26:52 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b1798b8a-5794-4c79-a1d3-50259fa3ba81@roeck-us.net>
Date: Mon, 29 Jan 2024 22:26:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] soc: samsung: exynos-pmu: Add regmap support for
 SoCs that protect PMU regs
Content-Language: en-US
To: Peter Griffin <peter.griffin@linaro.org>, arnd@arndb.de,
 krzysztof.kozlowski@linaro.org, wim@linux-watchdog.org,
 alim.akhtar@samsung.com, jaewon02.kim@samsung.com, semen.protsenko@linaro.org
Cc: kernel-team@android.com, tudor.ambarus@linaro.org,
 andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com,
 linux-fsd@tesla.com, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
References: <20240129211912.3068411-1-peter.griffin@linaro.org>
 <20240129211912.3068411-2-peter.griffin@linaro.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240129211912.3068411-2-peter.griffin@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/24 13:19, Peter Griffin wrote:
> Some Exynos based SoCs like Tensor gs101 protect the PMU registers for
> security hardening reasons so that they are only accessible in el3 via an
> SMC call.
> 
> As most Exynos drivers that need to write PMU registers currently obtain a
> regmap via syscon (phys, pinctrl, watchdog). Support for the above usecase
> is implemented in this driver using a custom regmap similar to syscon to
> handle the SMC call. Platforms that don't secure PMU registers, get a mmio
> regmap like before. As regmaps abstract out the underlying register access
> changes to the leaf drivers are minimal.
> 
> A new API exynos_get_pmu_regmap_by_phandle() is provided for leaf drivers
> that currently use syscon_regmap_lookup_by_phandle(). This also handles
> deferred probing.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
[ ... ]

> +/**
> + * exynos_get_pmu_regmap
> + * Find the pmureg previously configured in probe() and return regmap property.
> + * Return: regmap if found or error if not found.
> + */
>   struct regmap *exynos_get_pmu_regmap(void)
>   {
>   	struct device_node *np = of_find_matching_node(NULL,
>   						      exynos_pmu_of_device_ids);
>   	if (np)
> -		return syscon_node_to_regmap(np);
> +		return exynos_get_pmu_regmap_by_phandle(np, NULL);
>   	return ERR_PTR(-ENODEV);
>   }
>   EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap);
>   
> +/**
> + * exynos_get_pmu_regmap_by_phandle
> + * Find the pmureg previously configured in probe() and return regmap property.
> + * Return: regmap if found or error if not found.
> + *
> + * @np: Pointer to device's Device Tree node
> + * @property: Device Tree property name which references the pmu
> + */
> +struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
> +						const char *property)
> +{
> +	struct device *dev;
> +	struct exynos_pmu_context *ctx;
> +	struct device_node *pmu_np;
> +
> +	if (property)
> +		pmu_np = of_parse_phandle(np, property, 0);
> +	else
> +		pmu_np = np;
> +
> +	if (!pmu_np)
> +		return ERR_PTR(-ENODEV);
> +
> +	dev = driver_find_device_by_of_node(&exynos_pmu_driver.driver,
> +					    (void *)pmu_np);
> +	of_node_put(pmu_np);
> +	if (!dev)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	ctx = dev_get_drvdata(dev);
> +
> +	return ctx->pmureg;
> +}
> +EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap_by_phandle);
> +

I think there should be a detailed comment explaining why the complexity
is necessary instead of just returning pmu_context->pmureg.

Thanks,
Guenter


