Return-Path: <linux-kernel+bounces-107004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7994C87F69A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807361C21789
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB534436A;
	Tue, 19 Mar 2024 05:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M4TtL8EU"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CE240853
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 05:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710825430; cv=none; b=ZCrzgqhAT4jRskMRRnwKEy0rG3hjZ5aB9FSKhN7csSRl1W5W5GwevOMGdO2xUE2LhAZDLL4OQ8w+6XfD0fNlXCfIkSfVCB8wThXW/Oeic3xZE2kZRqgTYL0f8q6RMLQYm8BOa25LAHfsxwKTYMpd3Y8YEnuZ68qS45UpmSHfrEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710825430; c=relaxed/simple;
	bh=vMYOcFp28SYyP2tvNAU0IH+DCWd0/H20pM8Uz7RyXyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h105+qHKcYAh5QveXGjz97mg7+TE2eAxA5/SvM4kTcb6lyZmEwUwIy+UguTL9K8CDkfhMf8f5C2lcvgSez+bbBAvEmI6NMvjuxwzsiAYTrRuQcZ14V+XyNlWjr/5SJs6Ex77GDCtiU1ttW+J5mxEuLspP/iyEccBJhDpbIoyAnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M4TtL8EU; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a46ba1a05e0so245143566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710825427; x=1711430227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A6dmZujj3rrpeCLhV31DevVs1siyY1p4z7CzCm28mJ8=;
        b=M4TtL8EUv7kLw2Jep7jp6doZAKjLLc6ec8TXCsuEQ77s6SRGQR0Z1k9Gx2ec9E6/d6
         lGeGrM9RccgLhs7DZoFyfTn/Aobots0GfZMsiaN9TsVHwUqoE5Qta9jw3+LArugI6jCZ
         WLeHhiT6LdOdj5ILgs0G5co9YnO1AM4hYKjGrWa43eQsVb4W2Gb3FDE0VcN6i1It7J1a
         8iI69YOJy89WQ3AZkRt6QseLt9a1hKv7mSz/KOectCvwnDQj2CPn+wdMP0IaTf5+p5hL
         mNwpT/qWnRnFBidjPNW1VcriV8Im5U50raU9zMwv2r1Cg2J/Ao+4JW4ERTX35TPoOmf/
         BuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710825427; x=1711430227;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6dmZujj3rrpeCLhV31DevVs1siyY1p4z7CzCm28mJ8=;
        b=WGhL/6s1HGmpK0pFayEWAgEGVaadqVMwGNlb3jVAgv4L6pWNZl8M2rj5otzi8Wct4O
         VY5PNDkJnp/EZ0K+JB8zN4+d45/FYd1vdHofT4Ksz6yH9BQK9kDRYqQu9756IxYwLBfN
         HiiR8wIIDGpGDAkpaAvapJ9Vb3fQ6XihHVq52xizB73tTV+FMuzczFsQnotiZopty8gU
         EKaR+rvoLWaLVaU460ws9v6BNiy9ZgqetAIwCavALmdjVApEQz63smLqAX4SWo+GWxd8
         xZCNnG+l9q73+lkkk+ut0iBqigLrabIP597wfxwypnU1yy6zZJyamMR4lAc6imm5DNK/
         FD0g==
X-Forwarded-Encrypted: i=1; AJvYcCXZ1b86kKQj3cdAzVTb58DizlgvqrUtXzkZTFB3/d6EkFe+1MtMv5NkfBhP/GUCMu/PdjrOMG9kIKA+LWnN9uCLIXB6Pc00LhQ8Kfsf
X-Gm-Message-State: AOJu0YwW2cQ5XyGI6Bs7ma8enmkpUdrgL212W6lvuRWpwh0/sp/MVfLT
	6Cd6sjXcSfIPcUKW/UW09Ig3+a7A0USHztQE5XsoROhimNZi6fBFcjd9phg5lt0=
X-Google-Smtp-Source: AGHT+IEmNGvabBJ6k+gmhVzndKnI6ZiE6h4BbtVDtsDUU3kYdiaT5WpmQM/PfthEbTFQJrgj5cSwbQ==
X-Received: by 2002:a17:906:88d:b0:a46:b1b3:aba0 with SMTP id n13-20020a170906088d00b00a46b1b3aba0mr778832eje.17.1710825427121;
        Mon, 18 Mar 2024 22:17:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id dm18-20020a170907949200b00a45200fe2b5sm5566916ejc.224.2024.03.18.22.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 22:17:06 -0700 (PDT)
Message-ID: <4b8564e1-0342-4682-a963-bc32ff69622c@linaro.org>
Date: Tue, 19 Mar 2024 06:17:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/25] ASoC: dt-bindings: meson: axg-pdm: document
 'sysrate' property
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-gpio@vger.kernel.org
Cc: kernel@salutedevices.com
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-14-jan.dakinevich@salutedevices.com>
 <ca80caab-2664-4797-a222-e14537eea440@linaro.org>
 <827c4f17-043e-4e09-aea6-0fee22d1b234@salutedevices.com>
 <16a22924-054d-4d50-9f32-cc07c0bbbdf4@linaro.org>
 <54e924ae-4d45-4337-aeae-32eebe773b63@salutedevices.com>
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
In-Reply-To: <54e924ae-4d45-4337-aeae-32eebe773b63@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/03/2024 17:35, Jan Dakinevich wrote:
> 
> 
> On 3/17/24 19:27, Krzysztof Kozlowski wrote:
>> On 17/03/2024 16:55, Jan Dakinevich wrote:
>>>
>>>
>>> On 3/15/24 13:00, Krzysztof Kozlowski wrote:
>>>> On 15/03/2024 00:21, Jan Dakinevich wrote:
>>>>> This option allow to redefine the rate of DSP system clock.
>>>>
>>>> And why is it suitable for bindings? Describe the hardware, not what you
>>>> want to do in the driver.
>>>>
>>>
>>> What do you mean? I am adding some new property and should describe it
>>> in dt-bindinds. Isn't it?
>>
>> No, if the property is not suitable for bindings, you should not add it
>> in the first place. So again: explain what sort of hardware, not driver,
>> problem you are solving here, so we can understand why do you need new
>> property. Otherwise use existing properties or no properties, because we
>> do not define all possible clocks in the bindings.
>>
>> Let's be clear: with such commit msg explanation as you have, my answer
>> is: no, driver should set clock frequency and you do not need this
>> property at all.
>>
> 
> Could you please take a look on answer to "Jerome Brunet
> <jbrunet@baylibre.com>"'s message on the same thread. There, I am trying
> to explain what I am solving by this commit.

How is this answer here? You asked "What do you mean", so apparently you
did not understand why I am responding and why you cannot just document
whatever you wish, because that "whatever you wish" is not correct. I
explained that but now you respond that I should read other part of
emails. Really?

So again, do you understand that commit msg should provide rationale why
you think this describes hardware and why this is suitable for bindings?


Best regards,
Krzysztof


