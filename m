Return-Path: <linux-kernel+bounces-86928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E6B86CCFD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658E11C20C46
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9EB1419A6;
	Thu, 29 Feb 2024 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QuyzOGmR"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5421419A9
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220576; cv=none; b=TtWTMg5wv6OlWPlZTteKZ2wPCYXCtOGEel3omt4XEyFyW1wjRmJyIbLv/IqQ7UldmS1ihjh8Zr7aHCZ5+ZAQ1m3N50rWJbrYD+xKH0FCbNfeOVCxawDPBrcPp2mfmmIVUSNUXQxvTPPEo77+8qqe5dp8gxaTE8BbPLClgkKiXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220576; c=relaxed/simple;
	bh=fXVxODgA2ixfiucAm8ghxEYEC7FGBQeI4d5yd8894+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUabbiWdmaQFV7Q5e8TyBQ+iafwpwBR9f6hxxSqrGk5Ug8JNOE2VlKCUwNtirQmYq6RnotS8Pn4eBzIaQ7Z7jcX7h6TmHLgSpjukQlkhojrX9LYvYeWa9WWqVdAepoc3yzLEV1ld5zW8KUiypkyV/IIaJTiNmGhyoX4+fT9zGcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QuyzOGmR; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28a6cef709so167477966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709220573; x=1709825373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QMxqOZsH5DLRx/KCv1pnjf11BDEABi2ibjaW1z9c95Y=;
        b=QuyzOGmRwxTBKdIw8cSAtEETFV4dKvObrxxf68/KxFhrKaxdYneojDZklkVC2JQzJo
         WKtwwmG6WQs9jy0AMe+2pQlM2z9L/+2rf0EjNvkGstvh4zRRbQA0HcuM006fm78kF2vT
         biIK86QVtt4o1bgJYPThiQ1eryOamjkMlx1QD4MLjAHA9qV/n70lxI2l5t2/wLaVYz3j
         FnE3rUDba/uUTgWlLwp4QW+fe+rM/eWwPrWkUxXynZ/lfeJ0eo7SgIkw8yqwUWXBWDSu
         FHn81k8ipWe9wvrrFVpZNMEE0AYjBeZYHmlDw3pbN3K/MT5IJql/+dPI9P2bK4ePle/2
         NafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709220573; x=1709825373;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMxqOZsH5DLRx/KCv1pnjf11BDEABi2ibjaW1z9c95Y=;
        b=lm1xDIwetijII6uo+WT6rkZjvE22/wB4UGXS/7jLXUeKtPmB43yP+7+SVFHLlIVkm2
         3kUPFAcrPqs/EpQTqv/iT2+IA+vj3AjPzfyk4XkhSmg2MWranUdOiaaggyRu8Fwf5BvN
         XOXyluq1gzM40Pcnp9nn/gVnI8UODubglCQ3rMajva6TsW6KMHShRkh21jPfL+cB/NKa
         5A+hkJCAvIZoA8tfxT49y9jfe3fzbzZZt+fbkyy3rgNeuesLJum2iGD4SwfxPB/SshR1
         8Ei2z4cRkFRuv3kfpVHkTokxFZvnonuKFfcyX33/v0FFREqDF/4M+ihRuHGjh6+LUuON
         1NtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbvAR8AKFg3nsAqHNyeJXFR7/VL/iLkQj+xs4f9USN4sPyy/SuamzIximIwJw4ZZ7ukySECrUyFBSKo47eM1Py++JjtEPdwWngDnnP
X-Gm-Message-State: AOJu0YyQfjPXFHLXj5m8q7r4G1kWZlr3bwp5xwODUH3clMZicygbteIU
	KeoqNvj/8a4WXalCLCMXh/xcIW7o3kgOxoS44+0kaZvz7D+E2J2/uItH5Mo+shY=
X-Google-Smtp-Source: AGHT+IFHvzUGBa1W+Ku5tr+KjcOyzY8BsHA660zQLQqhB/quvthLaDx+33IZZjKERKw4YHma1uiSJg==
X-Received: by 2002:a17:906:7f12:b0:a3f:da1c:ae4c with SMTP id d18-20020a1709067f1200b00a3fda1cae4cmr1975746ejr.54.1709220573113;
        Thu, 29 Feb 2024 07:29:33 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id y1-20020a1709060bc100b00a43aa27b5f2sm788345ejg.94.2024.02.29.07.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 07:29:32 -0800 (PST)
Message-ID: <44fcf7d0-9399-42d9-81b0-e744bc37a831@linaro.org>
Date: Thu, 29 Feb 2024 16:29:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: add ad7944 ADCs
Content-Language: en-US
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240228-ad7944-mainline-v3-0-781b922334af@baylibre.com>
 <20240228-ad7944-mainline-v3-1-781b922334af@baylibre.com>
 <06235b66-6948-49b3-b881-198443a421df@linaro.org>
 <CAMknhBHhrNc-6qggSD1pt8djc9cv93dyNON8c_np6RwqT3yzig@mail.gmail.com>
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
In-Reply-To: <CAMknhBHhrNc-6qggSD1pt8djc9cv93dyNON8c_np6RwqT3yzig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/02/2024 15:35, David Lechner wrote:
>>>
>>> v2 changes:
>>> - Removed default 'multi' value from adi,spi-mode property. This simplifies
>>>   things a bit by not having to check for two possible conditions (absence of
>>>   property or explicit default value). Now, only absence of property is valid to
>>>   indicate the default mode. Constraints that depend on this property are
>>>   updated accordingly.
>>> - Fixed spelling of 'conventional'.
>>> - Expanded description to call out potential confusion of '3-wire' mode being
>>>   unrelated to the standard spi-3wire property.
>>> - Added standard '#daisy-chained-devices' property for chain mode.
>>> - Relaxed requirement of cnv-gpios since it was determined that an active high
>>>   CS could actually be used in chain mode.
>>
>> ? Please don't edit patches manually... Use git or git+b4. Or quilt?
>>
>> Best regards,
>> Krzysztof
>>
> 
> Oh geez, yeah really dumb mistake. Will resend. I do use b4 but it
> doesn't handle per-patch changelogs that I know of.

Per-patch changelog is the job for git.

Best regards,
Krzysztof


