Return-Path: <linux-kernel+bounces-65010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8228A854692
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A748F1C21839
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AC714270;
	Wed, 14 Feb 2024 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vnQc++Ui"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36111643A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904419; cv=none; b=Nn+TwRgsTDmIFdsB8J7CwC1QvkMGSdoSThi2sLwZqwJKEByvdDxT7WlQL3s/jPdPPb0TijvJ9mtHVX3ChaVUIhjt15X3JpaTPKdGEnJTCIvYsLKVbE43HCDWC9oz7hcNqPI3ph0QgRriLG/bSMD11UQvJdbhAfQ7uY9w16mzt9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904419; c=relaxed/simple;
	bh=EU3ABdr8K5hm1pH5imG0GpRTGaP6fx8XbrQr3yoLOM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPoB77OQU852hNxCTVKGMfnArVlF7LzIp60TZJss1/vBl6zmtBYN9ElFe7Vv+7J6qKIPjHJ/T08Wg+iWsTs26p3KVfAPiK7cCaq5eQTWvGUkGfBrcpnR0GTpXSE7gA5JXbq5sREnR+2DFVH3xKWX6xbilb3NGdiPY0SwKR15eAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vnQc++Ui; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3cb228b90bso316069866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707904414; x=1708509214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EaUjppUgiZAPCVE885hL282NkwF8fm6ZDFZemDPWHzs=;
        b=vnQc++UiRPOKRuxAo6s8l75QZFzbIFI9d9brXsVpOxPRSGeSa6RTyYaCoExixFwQN2
         Zyz4Ecf00CY6f2zCKkwPD2dGn3gfp/c1hgQ/I0cfFOSypx/vm7i2+5T0dQ88AkAOzmoX
         YU93uH5tCkQiD/ZHWolxsOAHSHHDFCWGPEQcFCjyY7nNCbViUHMnEqsUqR9UPk3ltU5Z
         VxJcSdEIdrF8AbwUYsazX3pd5N/MlfPq4Npq+shddkCzlqmF9cfgYegX/aBHgmxtFUpP
         fjNAxMtm+cP0zV2TCMzEN5wQQd+Dt5h/pZKTef7hkbNBn7lSaR+wkcYLOy9jxAx6p21j
         dujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707904414; x=1708509214;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EaUjppUgiZAPCVE885hL282NkwF8fm6ZDFZemDPWHzs=;
        b=mqeYrxOrOV6rMCFUXuYzjgJRJbeLWFKIBP5hLXwJqzj91uSx4PlOHmmoyLYej9c5TA
         Tr/MMBeSJArrqG/V3yVks0NWOCJ+emUdbzR0q2fLM1irrd8npjfOZOc2O8tS6liTdOh3
         Xptva9vcQUJl/kYVBwW3pKC3lSBuPl8xt/Ftv/MMPb1IlLFZkUTWqYPlXRJ+lXsWgp/6
         KRH0IthFlD1j6B7YRz1XaDUybkmNQNP4+RhUUhAB+Oiopzpj+qPtbr5dh3O/WCx5b2XU
         M/MIvLAZhTc99KZGbG6LXnRnWPoZs0/UoEHZ0NJD3uR926djk/OVLYL0Nr341cCv3WYq
         fNzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgjt1P/NFS65d4fbm3qdbn5jFZP9fHI8Kda5e0bZrpk8jhXNwbYb2RDmz8pbEe3FXQmHfXg6lY68UnOgSFhpx/Viihx9vl1XIMxnRr
X-Gm-Message-State: AOJu0YwQzh027NdMvoLR7VcADGWdeRLqbkeWpIvtti+j1KtyE+BNHV4J
	6zv2muQ4ja7w59URScQMHm/XVp0H8HMhcCNbhFCDGzbkHYcGlH1anHfoK88w6/o=
X-Google-Smtp-Source: AGHT+IHUD7IopZjbxD8lEAJpguq89fNC7GXCm2nTCf0GUa5tnbfVhf0QZ0UYSyTxXbaUiG4GWvlugA==
X-Received: by 2002:a17:906:ccd2:b0:a3d:6592:a7e with SMTP id ot18-20020a170906ccd200b00a3d65920a7emr21284ejb.37.1707904413927;
        Wed, 14 Feb 2024 01:53:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHWykznHAKiQeCk2JWDJoDpwem6lshIoVSZOgUBdVG8iZb9VmTYPODLgX8OQxj8tR0kJ4OtjD0fxSc0+ebR3Cz79J6Ku12QeDik7HtGEdWTkpeGJjD3EAQB8hu5s/JRQwNNZcgWsFdn1kXhhT7j9bBlUk+x3XBxwz8w5vJ7YOObhPNLYebG9L+MFxXvKIvtxK5xsRHwd6TRTjh4DFe/KcZ11IA+zpDOdLAHYAy0WSIMqZo0a5m+xIfpFvSnwT8sn/RmUMnxbj86KE+GC1TOMtsic5uPXnTxKzNCMjLxU7pOZICVj9ZCnshWQmhBQCUSkg/Bya5iLMaaNft4ORp1DHkTLfRSlX9eE3isN1OCyKPiysU6ulCZOZ0xI3/nzYIdqPCHIgVD0/M1HS/rScP+puMadMbBsuhtrbbO4l42L+oQMObzJrzaBsKX4TpkpZcnBInSHuxu61oZjQHNPN7S2eQDZl21Px5vLstqvw3fZAyzcnEA6NKpizqE8Wp03JKTUN4wQ5evHazQkyymSSjZUsrWtMsq/ra8Y2sUP+spbE2YSjfFdD1ze5wKzw2WAaZUBHu1rWBHjRUiKowpf3+oVlaoiX5Fxa2bqMYr7CM4dFzx9vRc6a7ZrhBH4zBcgVialZZjDDSQX5DTh1dHagf4lj7Cffp/eKVbY913MkhZesbaYuXlPBl
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id o7-20020a1709061d4700b00a3d6395156esm43228ejh.168.2024.02.14.01.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 01:53:33 -0800 (PST)
Message-ID: <630b892e-a948-4683-97bd-5633fc81f917@linaro.org>
Date: Wed, 14 Feb 2024 10:53:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add eSPI device driver (flash channel)
Content-Language: en-US
To: Manojkiran Eda <manojkiran.eda@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 jk@codeconstruct.com.au, Patrick Rudolph <patrick.rudolph@9elements.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, openbmc@lists.ozlabs.org,
 zev@bewilderbeest.net
References: <20240213-espi_driver-v1-1-92741c812843@gmail.com>
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
In-Reply-To: <20240213-espi_driver-v1-1-92741c812843@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2024 15:36, Manojkiran Eda wrote:
> This patch adds the driver support for the eSPI controller of
> Aspeed 5/6th generation SoCs. This controller is a slave device
> communicating with a master over Enhanced Serial Peripheral
> Interface (eSPI).
> 
> eSPI supports 4 channels, namely peripheral, virtual wire,
> out-of-band, and flash, and operates at max frequency of 66MHz.
> 
> But at the moment, this patch set only supports the flash channel.
> 
> Signed-off-by: Manojkiran Eda <manojkiran.eda@gmail.com>
> ---
> Hello everyone,
> 
> I'm presenting a revised version of the eSPI device driver patch series found at the following link:
> 
> https://lore.kernel.org/openbmc/20220516005412.4844-1-chiawei_wang@aspeedtech.com/ 

What changed? Please provide changelog and continue with versioning.


> 
> This update addresses the issues identified during the review process.
> 
> While the previous patch series attempted to incorporate support for all four different channels of eSPI,
> this new series focuses on upstreaming the flash channel initially, ensuring that all review comments are
> duly addressed, before progressing further.
> 
> Results:
> 
> Successfully conducted a flash update via eSPI.
> 
> Note:
> 
> This marks my inaugural endeavor in contributing code to the kernel subsystem. I kindly request reviewers
> to incorporate as many details as possible in the review comments.
> ---
>  .../devicetree/bindings/soc/aspeed/espi.yaml       | 125 ++++++
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |  16 +-

These are all separatge patches.

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

>  drivers/mtd/mtdcore.c                              |   2 +-
>  drivers/soc/aspeed/Kconfig                         |  10 +
>  drivers/soc/aspeed/Makefile                        |   3 +
>  drivers/soc/aspeed/aspeed-espi-ctrl.c              | 197 +++++++++
>  drivers/soc/aspeed/aspeed-espi-ctrl.h              | 169 ++++++++
>  drivers/soc/aspeed/aspeed-espi-flash.c             | 466 +++++++++++++++++++++
>  drivers/soc/aspeed/aspeed-espi-flash.h             |  45 ++
>  include/uapi/linux/espi/aspeed-espi-ioc.h          | 103 +++++
>  10 files changed, 1134 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/aspeed/espi.yaml b/Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> new file mode 100644
> index 000000000000..6521a351d18d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# # Copyright (c) 2021 Aspeed Technology Inc.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/aspeed/espi.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

Not reviewing further. Test your code....

Best regards,
Krzysztof


