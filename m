Return-Path: <linux-kernel+bounces-49468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA11846AB7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0BA1C24930
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C50A18028;
	Fri,  2 Feb 2024 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1RLAhIb"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE86217C76
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862529; cv=none; b=H4pyA4lKFDrf3NsP4+q9Ur8PHaoj4QovWFJsoSShQkBFb8gPSQLf3KX9ipWw8GxDmji3ZHxX6jpX69rkt6Hkpby5z+EF0i7tyEVNpsAJA7523hwinpEVReuWeTTzc4XnpcQoVpTpY05H2WvxEEkQA5raP2tJQghqOTXdsgItnTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862529; c=relaxed/simple;
	bh=H2Ip4I0OKn4QzwZ+GDIjeumETwkgKdR9Mjst3hifn0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uaEyU5lBpqElN7UrA+DGpLiZOIWT5HTDggk+D92spKgDKTlYzoQl1xMQxXmi0heGKBuelrRT0HkyUEMa+P2TOc5tuuPWuYCZxucxk36hjcqSrgBKH8cQ4K4w5K8tD2x0DZiLWxVxpycy4aGqnwH+VkI7600dPvuDhMhefH58maY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a1RLAhIb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40ef6da20feso2671295e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706862526; x=1707467326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1vTFHQe8p478/9bd/zpnB4V+92xBhSJMyKzBeBC5ycg=;
        b=a1RLAhIbN7Pk6jiirQztcnAAzTwSjriAszbv1taJMfD3S0+rBxTYczZ1K1SZU6rjlP
         m1Cxo+g2ZAWdk6gvVVTL6ULx86tNuJodAbolfqaj/dGTVypRhuai3XtSfkGLOBn6zu+8
         MtPnXf4VPJKCziVVABh57o65RuEivXTHmqz3y7d950lYHtlpncu6zvwfeLSYe4qkzpTc
         UElTd3D+mtwz/FxmFPzGCfA0SWOHUBkyg2tGDTQMl1SkdJNI1N4SXsfsv42qM8rgishB
         v0eQMa7YvhLmHaiZhOXNAquz1c1mP9U+xOGSoXEIYxty2mc5A9hq5qlIBL20vEbwtI8F
         TJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706862526; x=1707467326;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1vTFHQe8p478/9bd/zpnB4V+92xBhSJMyKzBeBC5ycg=;
        b=p/vxmGP+iwqasOff5RN1C0c8D8/1gS8a4BMQCDXy9MpcmIkEgwDJds1kX5meG/wPmW
         fuD2pYYSjmOsqYA84t/fFb7Q6m7lPbya3qHaaT7Wab69+sS7cmKQk4cfXhcnEoXwrNNZ
         /Z/7ZzuO7nmLWgkPjslH23s6RTXYnrkqVi5yK7CxyoJhWGC7A+nIMi/rKuiY3vwRIq3c
         onJO9c/EszBkVkR3aEm6TX2DXnYjl5M1FXPY5paLi79vmWj2TSiQ6NlRxGLdV7nGDOwI
         jPGJjmSfk7+KMS/U4sB0GJSx2Yo9Jxgv7xGRA+QpZ56oAzkoCwdHRfWmoG4WKjiwGb8K
         jjiw==
X-Gm-Message-State: AOJu0YwZrFWmiQcSoRdyLTjrujLSpRXF3LXIQ0+zF/gkxNCATXrsoGjg
	LlFUP2WDN0D5nYz8REoMN+ZH9W/rX+jYtoPB6uJaGN4gkKgYnbZmyO6oqggBgF8=
X-Google-Smtp-Source: AGHT+IFlII8txzoFRYTZBdsdUufaJtBCd6i7XIDYBkyUq0dgO2EQ5RFE7FtWMq+a4LjzMTfm/WSYUw==
X-Received: by 2002:a05:600c:4f14:b0:40f:ba24:77 with SMTP id l20-20020a05600c4f1400b0040fba240077mr1020120wmq.7.1706862526188;
        Fri, 02 Feb 2024 00:28:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXQWaYHt61sIz5/q8JdunL0BDAQM8u97VIZgkwUc3sdn4xVP+sQrUTzc1WaxLU6u19KRsDLE5PFUMnb4oxJjAS/aZ/KjAyPm5tKWTHqMeEqRhvF7MZ8asuvVFhQCA3CBhL0jy6YEp5esjanRuAq1dEaGT/IFLaLFeGc1j27+c5pFfjfX6IE1SXJxLPkAWsEY3N99RuMq5MYX6CJ3sYF35N/0p57nPnFA4MVyeBjnXriCsC+oQLcaQxYmhsF4sQ1DjNC+HwM1a2DbRSkiOVug5XtBc7qUdyhHhUzozn1e7eyayZcAjb+1nyNn15I/Uv3aSxAmMarzqT7NyxvNTi+jiZ1IU8jxDhy5H5SVd1tH0dbMgNpco4xk7jhRu0JARSp+yehoWTfuO+ZBG2KzUyT57CAElyZZT0TVa6NWfZyYCmA6RFbe1d2they2Iq2+mZD18V+EieGD7YRIaYao3v+yG0P1hhI6243rLtfybw8MPjdn+UdGGJKxmlETZbNt/gcKuYqdfYT
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id p2-20020a05600c1d8200b0040fc771c864sm1026255wms.14.2024.02.02.00.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 00:28:45 -0800 (PST)
Message-ID: <aecd80a3-a017-405f-b77d-6deda67ef704@linaro.org>
Date: Fri, 2 Feb 2024 09:28:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] dt-bindings: rtc: add max313xx RTCs
Content-Language: en-US
To: Chris Packham <chris.packham@alliedtelesis.co.nz>,
 alexandre.belloni@bootlin.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jdelvare@suse.com,
 linux@roeck-us.net, antoniu.miclaus@analog.com, noname.nuno@gmail.com
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
References: <20240202025241.834283-1-chris.packham@alliedtelesis.co.nz>
 <20240202025241.834283-3-chris.packham@alliedtelesis.co.nz>
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
In-Reply-To: <20240202025241.834283-3-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/02/2024 03:52, Chris Packham wrote:
> From: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> 
> Devicetree binding documentation for Analog Devices MAX313XX RTCs
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---

..

> +  clocks:
> +    description:
> +      RTC uses this clock for clock input when supplied. Clock has to provide
> +      one of these four frequencies - 1Hz, 50Hz, 60Hz or 32.768kHz.
> +    maxItems: 1
> +
> +  adi,tc-diode:
> +    description:
> +      Select the diode configuration for the trickle charger.
> +      schottky - Schottky diode in series.
> +      standard+schottky - standard diode + Schottky diode in series.
> +    enum: [schottky, standard+schottky]
> +
> +  trickle-resistor-ohms:
> +    description: Selected resistor for trickle charger.
> +    enum: [3000, 6000, 11000]

Please remind us and document in commit msg, why this cannot be part of
max31335 binding? Looks exactly the same.

> +
> +required:
> +  - compatible
> +  - reg



Best regards,
Krzysztof


