Return-Path: <linux-kernel+bounces-32532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BAC835CC4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54BAA1C21121
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D578364A0;
	Mon, 22 Jan 2024 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/nHb0tV"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCCA2110B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912651; cv=none; b=Bc8R0c7vCQFKh84Ea5DwUE2qrcwL9s12JniPMvuKR6cgUCjazvqAzl/ZjouLncr52R81rt/26FTLdR9U91zgjkPSRqIap9d9JlV/+cj96lHfIVLjq2c2EIFa6dWxl+D80+kE95bsJSAdUHmdE4s7B8k6xzLKhgZBlHCnXppCUX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912651; c=relaxed/simple;
	bh=50VnyOQ5yU0OvmhTui00lfaV6jIlkxhVrH3tn6U37kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udHozwdqQUkJ6Y3Ku9pHES7ItWIvsQjoTNzi+ZI7m9PDbup0eL6NvZO+dXEt34wT7sVtuHS19Ip/bmkDVgFPPaUcL8NEzrNsq3jRzzZqk74N9n08GmAs8MhmwOoA8y2IW0/YNwwktmsokCgAAq6z/7pyieS8unrvLaOPHxkkizY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F/nHb0tV; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cef994d4e6so9242371fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 00:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705912648; x=1706517448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sUhLxvQpB2444R2OwanB1oURS4LSeIrP1mx21iy3zi4=;
        b=F/nHb0tVP449PH9sWdLy8KERT3NSwI7P5HMIH/OlH2YThUOVM9fOfiPJuDoV9msrpw
         60dEnBNZML5PiAP4tH+u/0FTusyKKITkRxo0+ZDGdLVMsF4NQSpwmkbTERBpV1EOnIne
         7wVda/4Jd/ldiSxqzkv+apNDI6SNcNhDV6DJT+J/U1HybGc2kXrOgp+vauMMHW+xONEN
         tozgnw4CpwxahytgDC7G4LqrSm0ghKeVpny12XgFHnDMEhODA6rXhcg80GhirnSd/FgZ
         4QlQDUCTY6n1p3wHaxn3T3LLw1ADaSZC9dU2oQshzGXNdl1bhwuYmbuAWLMdlMCuYi6b
         cz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705912648; x=1706517448;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sUhLxvQpB2444R2OwanB1oURS4LSeIrP1mx21iy3zi4=;
        b=QzaxIL7XUGgymDtGyElk9iqE+toOUhbvHEFI9pdgb7vOYtmbcsZRY3IKlEj8xtOFsx
         kiArDHFDkMUjVkIR/+v7DGtoM4KkEE/eHBNCsztjyQn4eZEWTmtdedGZDWDydNuXKfm7
         iCbRx6ZKE1BsV65I/NJgKtpmwrpZ1TPOgDBd0JmDDw0QBvV8QJUQLncF+EekCD3lU8I9
         VaMiYQsVPbpj62cTxOMb+0DRdwCk7JEj9B/cu2FE2sCLnwVdCtLqxfFLdNFVposUsQyr
         smWJWmGramoSC8CUTbwM0CFrq6IzvQ5vrGUGyL1hPd+gaSwwb9acWgbjKqkrqBdGk/BC
         WFRg==
X-Gm-Message-State: AOJu0YyqzGsqmgQMzxaeL/sdWFbiLyaG9A4EExj10IKeNF1XAPPIcPk+
	uK0kD62pdmwZSuUDzEluXBjxc/M4ulIpX1dwhOpNv5Ou/szT5watEvs3niqihqE=
X-Google-Smtp-Source: AGHT+IEUJOQf4Ld0srroyNXWH3OQiDWPRqtkiPiCuP69Ymdllv/sFpV9ONm/e4QkT1gx5Ahl5reJJw==
X-Received: by 2002:a2e:9d99:0:b0:2cc:78be:9551 with SMTP id c25-20020a2e9d99000000b002cc78be9551mr1222957ljj.2.1705912647781;
        Mon, 22 Jan 2024 00:37:27 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id q6-20020a5d6586000000b0033921f48044sm7892690wru.55.2024.01.22.00.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 00:37:27 -0800 (PST)
Message-ID: <fcd64bbb-9f3c-4e62-96a4-84cb1e3ac59d@linaro.org>
Date: Mon, 22 Jan 2024 09:37:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
Content-Language: en-US
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, chao.wei@sophgo.com, unicorn_wang@outlook.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 dlan@gentoo.org
References: <20240122080631.2880-1-qiujingbao.dlmu@gmail.com>
 <20240122081722868bdda5@mail.local>
 <CAJRtX8QU8iHY1oQJ1uDN3YOmCeN7SH+vPC8nD29WS5+2DT1oKQ@mail.gmail.com>
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
In-Reply-To: <CAJRtX8QU8iHY1oQJ1uDN3YOmCeN7SH+vPC8nD29WS5+2DT1oKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/01/2024 09:34, Jingbao Qiu wrote:
> On Mon, Jan 22, 2024 at 4:17 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
>>
>> On 22/01/2024 16:06:30+0800, Jingbao Qiu wrote:
>>> Implement the RTC driver for CV1800, which able to provide time alarm
>>> and calibrate functionality.
>>>
>>> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
>>> ---
>>>
>>> Depends on https://lore.kernel.org/all/IA1PR20MB4953C774D41EDF1EADB6EC18BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com/
>>
>> What is the dependency?
>>
> 
> Thank you, this driver requires support from the CLK driver.

How? This is really unusual. Just to remind: we talk about build
dependencies. Other do not matter for new drivers, right? Otherwise what
is being broken and how it could be even broken?


Best regards,
Krzysztof


