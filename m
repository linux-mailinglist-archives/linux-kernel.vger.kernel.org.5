Return-Path: <linux-kernel+bounces-47807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B62845321
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61C5285FA1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605EE15AACE;
	Thu,  1 Feb 2024 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="esb9YC4y"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF03315AAAF
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777417; cv=none; b=RIi2NzM7WGsLD+qHvcyIF4i1FFs0OEQcAgeVCBJ0oEmk+n6mYMISy7NYaOy2ZQKCBM4ACtlhu2z9AxNFaYWTt4sAsAKi38gxq6Q3viqGCE+7OX8iTgNZ0toCns1vGf5NWhQYUb6wkKvxUfAVtjtcCyZzf+IlLbw+6SOIS32lLaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777417; c=relaxed/simple;
	bh=DuXCuFYNJhHBLcY4f1qpPGoAd7Af5FzK4+eYGfoq3m0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYgHWP7HMa/iqjiqvaML4i+1JT+52GDIq4QaaL/BKd0yV0kKhJWN7QPlDeVDI8aqouj0tITnzngObUslyJJPlSq9GhIVx7MENmfzjRgIfXcwnf4WoJMU7iVYSKbbhnSsPDkMt4ymJ06JzBQOyVbGw8Tc4YrrDH6YK9y2Tri2vL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=esb9YC4y; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so1106457a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706777414; x=1707382214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+0W1coADRrc6NCCK1wAOqt+R3gqvTK2Vff6DnM2AMQ=;
        b=esb9YC4ymMAMTIhu+k1ubaLKBg8l1F4e8YCFYOmX2zwwKqIXOrbhv81JUXHDfzwT64
         9KdrPuojxEtXRK3CJt2IvIH15v7fZDR1fpa+RI9WvfJVdXvC+XUPTw6CsIBeq1HcB8sZ
         XjQWT4U9eI1pPXRV78cgml3WHITt2Reh8qf3OE6hsJDzuGDZctPtLP9NKAXoRkdgZxiX
         icxLMq/VjkTjPNHYLQkX9sVWjImtrrL/h/htgztEOQ+XuTrQgJVL4l0bw4i9JC3iXS00
         YZyRNkkjSM6nhjunMX/yepYHptkze8h7Gwa4xODoiLImKTOT9RdFeOAc17cZ33u5Gg1J
         DQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706777414; x=1707382214;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+0W1coADRrc6NCCK1wAOqt+R3gqvTK2Vff6DnM2AMQ=;
        b=wT7tnxWQojtYf849fH1r999GhrPcMjYX3Z8W0ZzLiBv7e/CmUJuMAumrb+HRxbuUDS
         8lbCcAwwWT9HgXIfZ8lUeK/FjEgyNrgzx4SraIrt43KK8rzTZoOo2kjuU/siNI6uDWLU
         7UeMjHxJ2kPCl61x89LH1OG35btBrbwAZ0P9Q5uGScdBrZiavXeU3LvYbJ25/UoWn3OW
         SPs4tkddaCgG6DfRQRRHYZVJu+g32AzMReeVVEvnJE5hQ+AfeOQE3B29yPioM1kMeyq3
         /5+aoaOVoOVhBbgBS47G7uADDuPhlAE6KU06VjvB3qvmeiBS5/J/sa/t/0vULnk/us5c
         QdOw==
X-Gm-Message-State: AOJu0YwAHXxlQULbZZKd5Vj2p9aSdCe1RjaQfzmT4H7B5ybhD1Tm3GWG
	iUMNT7GEBKies62AyicpuvZDaH95+tgQujoXRwTfAdwJhegLkzWWBXSlmR0iDt4=
X-Google-Smtp-Source: AGHT+IGmufUBvXu7yjtJQA/VoqO6xdB6gQShGIN28deYeT3cjtGburCBhBDouEH/AREOpJ2czLYyEw==
X-Received: by 2002:aa7:d987:0:b0:55f:c25:c2fc with SMTP id u7-20020aa7d987000000b0055f0c25c2fcmr6665313eds.11.1706777414153;
        Thu, 01 Feb 2024 00:50:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXvUXOB+uQvxdvzMH2buPm9d28wUK4rt5Fje4cjH9cNA3uVo+lKuMD5pMbsQMiueFjhatQ1/hKnxy+Y+OD6QwNOinRzMoU7aaQCVlFKeNtz+AiR7eIGIUp4Swi1ETxWhgjfnirK1kMUXLeAvnQ9PYF/5CYT/DnSNy1peoxX4lAuK9fxv0icyamEt8PiFi+Mg/aPWpEixmv5qZUmVkk0Y9tSi2aIeYk2swtbSIj+dWsIN7z7ONsw6AJOtPYpXwuMHzTHwcSj/mWn95YXG/vNsUOuIeT8gp/4utomcoSowpovxPplnWmIqzYCnK2aE/KUlhmpzqk1JDwkuGOTO5FlbXQSW6xtHawy6fV3d4r7Gy61XLlthIeVSB+UoWFj6ovK4IZt+gUmHYl/eC2jBg7oh/+8SdX2Ofy5
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id fe1-20020a056402390100b005598e3d6d23sm6551798edb.16.2024.02.01.00.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 00:50:13 -0800 (PST)
Message-ID: <059cd10e-0fa3-4edd-bb2b-521236e1a686@linaro.org>
Date: Thu, 1 Feb 2024 09:50:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] ARM: tegra: Add device-tree for LG Optimus Vu
 (P895)
Content-Language: en-US
To: Svyatoslav Ryhel <clamor95@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Kees Cook <keescook@chromium.org>, Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240131105153.8070-1-clamor95@gmail.com>
 <20240131105153.8070-4-clamor95@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240131105153.8070-4-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/01/2024 11:51, Svyatoslav Ryhel wrote:
> Add device-tree for LG Optimus Vu P895, which is a NVIDIA
> Tegra30-based smartphone, orignally running Android.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/boot/dts/nvidia/Makefile            |    1 +
>  arch/arm/boot/dts/nvidia/tegra30-lg-p895.dts |  496 +++++
>  arch/arm/boot/dts/nvidia/tegra30-lg-x3.dtsi  | 1821 ++++++++++++++++++
>  3 files changed, 2318 insertions(+)
>  create mode 100644 arch/arm/boot/dts/nvidia/tegra30-lg-p895.dts
>  create mode 100644 arch/arm/boot/dts/nvidia/tegra30-lg-x3.dtsi
> 
> diff --git a/arch/arm/boot/dts/nvidia/Makefile b/arch/arm/boot/dts/nvidia/Makefile
> index 60091bf7e48b..f66337e5d188 100644
> --- a/arch/arm/boot/dts/nvidia/Makefile
> +++ b/arch/arm/boot/dts/nvidia/Makefile
> @@ -39,5 +39,6 @@ dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += \
>  	tegra30-cardhu-a02.dtb \
>  	tegra30-cardhu-a04.dtb \
>  	tegra30-colibri-eval-v3.dtb \
> +	tegra30-lg-p895.dtb \
>  	tegra30-ouya.dtb \
>  	tegra30-pegatron-chagall.dtb
> diff --git a/arch/arm/boot/dts/nvidia/tegra30-lg-p895.dts b/arch/arm/boot/dts/nvidia/tegra30-lg-p895.dts
> new file mode 100644
> index 000000000000..7e7cfaabe56e
> --- /dev/null
> +++ b/arch/arm/boot/dts/nvidia/tegra30-lg-p895.dts
> @@ -0,0 +1,496 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +
> +#include "tegra30-lg-x3.dtsi"
> +
> +/ {
> +	model = "LG Optimus Vu P895";
> +	compatible = "lge,p895", "nvidia,tegra30";

This is lg, not lge.

Also, all over the file you have underscores in node names. They are not
allowed. Please consult DTS coding style document.

Best regards,
Krzysztof


