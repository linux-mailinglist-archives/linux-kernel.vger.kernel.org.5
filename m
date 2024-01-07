Return-Path: <linux-kernel+bounces-18834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA368263C3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 11:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA511C20BFF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 10:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E5512B97;
	Sun,  7 Jan 2024 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BfUhE9NC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFED12B96
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so91114266b.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 02:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704623650; x=1705228450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WIe1BBB7vFKwCN3Qcq4fcZ44bbCcrLCDMm9KDGSJ3OU=;
        b=BfUhE9NCUoahvynofj5kE5ChtXxL5U0Jyqwu4brpTXuMxknMmtHcdHpnY1q5/N9Xib
         yvTgjlH6G4HQKnL+z8do40rUP0whfOhLm+7b2NcopfKzhF3m6SGx9o4w1ma05RAd0nNF
         NOHD10nJSU4S9SFhaJVXqLDajWwkuSUQC+/yepm+0qJz4nrCJR/WG5hNlLveWWDbISug
         QxPVmXhZjzJ2SoHFb2sxuARC3u0J5FnkpaeuuqLeqEzXWALTb0ck4dP4m9sSn2TOVNoT
         xNeZyale1CY7U/OuqLN5zaqkp2yAaRNuOnkt8rgJhaF2tDV5HGA1gwB5I0p52JLHjbC3
         l4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704623650; x=1705228450;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIe1BBB7vFKwCN3Qcq4fcZ44bbCcrLCDMm9KDGSJ3OU=;
        b=XMHNSeU8y2ftrHfrKDlPNRu2UxtLLJs45/FFDWqzOBAGibt9WHeTurrPqhii8a9X8O
         hFT6W64gCktN1zqnbaHrGZxLRn1VyWfv15yYRm2H7IznXVlmj0NOGsmNBCFw+qr6Cw3w
         EVrx2Smg14E1GrNm4Ehb7U57oB38MIfa+UIVjrEaGFdVJMo6MzQByC1d2dXtIannfr6p
         ZoKuneREiAMc46wHYcGP6dpR2dc2USQfIDJexCUuw2wMyZydGeocWgTQ3D7d9Dn3sKVn
         ito+pAy+rOqDxI4LONQxrEhTciVDnEzeLp6yeTKYg3a4ei/Niy2cEUk3jR85hawW4f6I
         0XFg==
X-Gm-Message-State: AOJu0YxT/7t16gWhPjbGN8lEhvqMSLPeuKrsL8+FcHJcBORWuGcHvCD0
	hfjf4nOplJC89wiKlVg9XOp8JesrwsLAFA==
X-Google-Smtp-Source: AGHT+IGDlGObzuh3cJV9HUAqXOkFaaZXK3J+pWxIMpIyeM0BXWBHLH6ilRBIHL6FqEdg/buvd2/Pqw==
X-Received: by 2002:a17:906:1746:b0:a27:91fc:19a7 with SMTP id d6-20020a170906174600b00a2791fc19a7mr634202eje.161.1704623650166;
        Sun, 07 Jan 2024 02:34:10 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id o18-20020a1709064f9200b00a28ace8fb17sm2870616eju.206.2024.01.07.02.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 02:34:09 -0800 (PST)
Message-ID: <89fab5fd-34ce-4196-b246-b5c3e4c7e201@linaro.org>
Date: Sun, 7 Jan 2024 11:34:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] regulator: add 88pm88x regulators driver
Content-Language: en-US
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>, Mark Brown <broonie@kernel.org>
Cc: Karel Balej <balejk@matfyz.cz>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz>
 <20231228100208.2932-5-karelb@gimli.ms.mff.cuni.cz>
 <008ee9d6-6259-43df-9af3-2dc9877cfe94@sirena.org.uk>
 <CY8DP6O8C72H.2XTJT3P7XZAKE@gimli.ms.mff.cuni.cz>
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
In-Reply-To: <CY8DP6O8C72H.2XTJT3P7XZAKE@gimli.ms.mff.cuni.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/01/2024 10:49, Karel Balej wrote:
> Mark,
> 
> On Fri Jan 5, 2024 at 4:18 PM CET, Mark Brown wrote:
>> On Thu, Dec 28, 2023 at 10:39:13AM +0100, Karel Balej wrote:
>>
>>> @@ -68,6 +68,21 @@ static struct mfd_cell pm886_devs[] = {
>>>  		.num_resources = ARRAY_SIZE(pm88x_onkey_resources),
>>>  		.resources = pm88x_onkey_resources,
>>>  	},
>>> +	{
>>> +		.name = "88pm88x-regulator",
>>> +		.id = PM88X_REGULATOR_ID_LDO2,
>>> +		.of_compatible = "marvell,88pm88x-regulator",
>>> +	},
>>
>> Why are we adding an of_compatible here?  It's redundant, the MFD split
>> is a feature of Linux internals not of the hardware, and the existing
>> 88pm8xx MFD doesn't use them.
> 
> in a feedback to my MFD series, Rob Herring pointed out that there is no
> need to have a devicetree node for a subdevice if it only contains
> "compatible" as the MFD driver can instantiate subdevices itself. I
> understood that this is what he was referring to, but now I suspect that
> it is sufficient for the mfd_cell.name to be set to the subdevice driver
> name for this - is that correct?

I think Rob was only referring to "no need to have a devicetree node".
But you added here a devicetree node, plus probably undocumented compatible.

Does it even pass the checkpatch?

Best regards,
Krzysztof


