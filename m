Return-Path: <linux-kernel+bounces-125704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3662892ADD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8678A283063
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0729D2E63C;
	Sat, 30 Mar 2024 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MCFC22ex"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8824426AD5
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711798592; cv=none; b=RrxaVQlEHffQlnzPENY2gfk+d1Q5hW+k5+DMnCNtiqBzwlo4AouCyy/J5V0xd8WHTNsUyQqVI1ObRANKKKlLEVOnoQsitnJVba+3TpD6jkDoXiERtEjLY3kkeHEP5s4lp5yxhi0+HTEgPSE3W2swbBtphi0r5oQ3Qzoyz6wR4UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711798592; c=relaxed/simple;
	bh=LNx37uHQwjk4CXCpeMldzKdo6/MfLSJgg9p4MIj3Q+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRI+mw3SGIRwUS2Cx9oR3wm0bHDSk3gmsEmlb2X74wZtDCb8IIuRSbQOIalX3yWL0Fjv2wpUXJXP9DC3vBw8mJMMFt2rw8dNQhD+Vu0DogKx+m+bStAo9ZMi4Fi/BWQIzmDpiAOd2AKEBzEK6qJSHlBltPJpuvaSuxhY9wibDxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MCFC22ex; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-415573263bfso3552255e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 04:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711798589; x=1712403389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ofiMaV1qQl+WdOcuiQTraRnMr9+nFnl9Caq6scwirk8=;
        b=MCFC22ex9xK5nX69/9pSxlA7YHs2iVP6pAPE77AJfk2u8TkdSlfner4oPn3RD/vMIq
         I5KRLhszyNNjzpWNhc9p6iltNJMOzhJmxkjAb1hwaUrbBGQOkg2MIRWE9dE/gVvwbs6/
         e6oCwNnVIDGXFtugxrJe0p/gBfpnD2sW3oQa3OVtP08fxIA3ODgji/bqhSnxFz9b+WMp
         1/aV4qKZ06B41BemCrhf3C7XkrSODoKNQEoFCt6lq5paqxAnaScgzKc+7XeChqi+WGZ9
         bnq35B3XExuabQJeftjFFSJZUVtiN1lhcvLTnU5yg5VnqOtiKDckUT3aVAfi62uiEUg/
         82oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711798589; x=1712403389;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofiMaV1qQl+WdOcuiQTraRnMr9+nFnl9Caq6scwirk8=;
        b=MaKauMXUpNFW0ZJbUvmtnLIlW9wUGjnNDTbJU0ePzLuoCAAdxYSOUVtlvgFdBPXKu1
         m4F+zstpPETx/pfUk1VfB6JdfYk3cHObFmfhue/juMcDabBl0M5MMMwnTObTEhS60w1O
         Uvw2TolQPrEgVhxeA5f4Mrwnsp+7JOneS7XGeGbUUkJ00dEJhw0zts7N7TtKv+Bt1q4k
         9rg9/Tad+RcW7UiFpui/CR2rv/eQlLmYTWHzw5RRQ7CnEhqdt7AlVUwv6SF9Owm5ojfG
         ZtME1l5dsktGKuFZdALQt0u/99azpYJglYmWFrvy7nKXbAYde6VQ6b4BzYg+wuXnI9VE
         7oqg==
X-Forwarded-Encrypted: i=1; AJvYcCXBiUfbj6p8gz0yd6gXlqVLxiEjOsZLQe9e7iwltyyCEfOUj4DODiZCz5ruuZjw/IUBH2ags1RYu9hERTbxT4YIAToBNi1fUjsTP9xZ
X-Gm-Message-State: AOJu0YxaR5TcKqEc3txbEzCJEjP6FEbnF8jSoQocBd+40IcDN3XKqJA0
	ClkxvYACmfWz1+t56vEujCZuzVagh7feNWQXuZZilBZpfukjlJ9jgdIC6dgki1M=
X-Google-Smtp-Source: AGHT+IEC/vVAtWZ3Fjn4ZZwnP/8WXo5SvYfoUjgMrzoX1GnrOfy3xaNdPfytoMSDSHyrXCvBJ7VUsA==
X-Received: by 2002:a05:600c:4f0c:b0:414:85f:1f72 with SMTP id l12-20020a05600c4f0c00b00414085f1f72mr2899896wmq.6.1711798588857;
        Sat, 30 Mar 2024 04:36:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d4884000000b0033e7603987dsm6271860wrq.12.2024.03.30.04.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 04:36:28 -0700 (PDT)
Message-ID: <df98ce20-23ce-420a-9807-1329deb01d4b@linaro.org>
Date: Sat, 30 Mar 2024 12:36:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] driver: spi: cadence: Add ACPI support
To: Witold Sadowski <wsadowski@marvell.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc: broonie@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, pthombar@cadence.com,
 Piyush Malgujar <pmalgujar@marvell.com>
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240329194849.25554-5-wsadowski@marvell.com>
Content-Language: en-US
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
In-Reply-To: <20240329194849.25554-5-wsadowski@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/03/2024 20:48, Witold Sadowski wrote:
> From: Piyush Malgujar <pmalgujar@marvell.com>
> 
> These changes enables to read the configs from ACPI tables as
> required for successful probing in ACPI uefi environment.
> In case of ACPI disabled/dts based environment, it will continue to
> read configs from dts as before.
> 

Random subjects... Please use subject prefixes matching the subsystem.
You can get them for example with `git log --oneline --
DIRECTORY_OR_FILE` on the directory your patch is touching.

>  }
>  
> +static const struct acpi_device_id cdns_xspi_acpi_match[] = {
> +	{"cdns,xspi-nor", 0},
> +	{"mrvl,xspi-nor", 0},

How is this ACPI?

> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, cdns_xspi_acpi_match);
> +#ifdef CONFIG_OF

This was never compiled. I could understand not testing bindings,
because it is something relatively new - like 5 or 6 years. But not
compiling code is less understandable.

Best regards,
Krzysztof


