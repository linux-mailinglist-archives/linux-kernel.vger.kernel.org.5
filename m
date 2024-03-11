Return-Path: <linux-kernel+bounces-98709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199C8877E49
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8342E1F2104C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A81E37152;
	Mon, 11 Mar 2024 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xTOOVog9"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8933BB29
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710153721; cv=none; b=KW+wRfHstJ7kcSIPHfcE8i0uZ80TiRPelZbXj3fTkvGS29PF3aKjDBoO8gGiI7frwbRyt8VUZuT/srAVYPPU0/QXjmDDeIQhXIrNjQRIRJINKH4hugMTJUqRi88pZStBNG2Mo02GMaC+surPNGRUiXI/+y/nCfDvAs5pST/wypU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710153721; c=relaxed/simple;
	bh=et6D94mdf5IbFO5VCgJsMEQNnAvoLbUEsq4t5Pwu4w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3Q7+JlIOdZPpW/+nZGmA8VVX7T11C9onPW1/5VnwHvSYQaZEzmhGMCrzUSxujnevlTeOHMAPwP3s4/NOsCw0MglCm8T7dW5XOVErVZeZLaq9lmVUQ/XSAO8Qh6XqOeogY/0Gw284x5MZ4YWp58IQgsu8GqsPlNg0ikHYkwOuj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xTOOVog9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412f1961101so32224625e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 03:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710153716; x=1710758516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AQyzC1WPTXWjYhSQFz0zRBD57MnVVABdhNoOa0rY8dQ=;
        b=xTOOVog9qberFTbrDZeJN9Xv1ROAp6giBhHajZ03J/ysiF82AVIBDZd/TrDFskSlbJ
         /apL0jAeCnFJOxm8RkU5JxHlNkqI8cNg+cbzMHcm01++zFt+uM2QyUrly1H24ufUtNUU
         mCgrijd28laK5IDKhZdYAVU9swmg3XJSL6DC1pQUb6zey7VU2BvvwdAd2i9FtdecknIJ
         T8Eq2lZjkUtEjCDAL4+saEtxaUHoiVK3MYiQFMEF+rWOXAxNCZ7JeIpb+Q6Jhhgo2he7
         T22I3+rFcAnJV8eKsazqm71/CTkzEtU6GyDqflAoOPcVc5BRdKpNFpe74/GLKbgOC2mA
         B5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710153716; x=1710758516;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQyzC1WPTXWjYhSQFz0zRBD57MnVVABdhNoOa0rY8dQ=;
        b=HACi7qgf6tceYqp37OskI7fXoAG27jm2BF9wLMziqsidLy5NkoHbovtBcI9lBZe6+A
         O6Fau/EMY1Tj7mA93GvG7159FxRR9WadQH+KTeyTm57nfAsggB/m7Mks0sG21xbMbAxw
         THXJYyRii/AEhZpFiljO0VoBD38B6/kJkXKIGtGG9dNpxKc3UvcDXNbkACkzfObynpAg
         EQyJP0X0GSzpFooKm1eNk5KXOjaQN5cca+Cca9EPpTJCQ0os3A1yFLQNzg9oj+IngeS5
         4AlSHAbPy0cwK8GcIWLYOYNy7lq2Qk9uumvuasupgJ1RMjswn+CJdcTrKeKt66PvaOZe
         7OCA==
X-Forwarded-Encrypted: i=1; AJvYcCWaBeiYcPupFSHU5lC433hrKqz47LSD1zKHYUlwA4OSr31JbXIY0HLLAXcBa/rm5ciuCiDQqI3KI9/GI3eyIpPaFmDZNDMFmGApxc4+
X-Gm-Message-State: AOJu0YzHoztoarBnaKtqBLSp1PP/AJCdU4PiIHtyNfNSn4KwCdp+abPD
	zAwO/qh284p2y+0z28gaPC1Vr4FrhPFiE/Nz0bEV9SoEBICDZg4Jb3Wrp1CKL9s=
X-Google-Smtp-Source: AGHT+IFT03qszUVNn4EMvc9bfZpRC1OJms3x/bryvZ634XRq/o92hf1cWh+g5Ncbuqp0DqnkRyye0Q==
X-Received: by 2002:a05:600c:538c:b0:413:7b2:284d with SMTP id hg12-20020a05600c538c00b0041307b2284dmr4579612wmb.36.1710153716297;
        Mon, 11 Mar 2024 03:41:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id c18-20020a5d4152000000b0033e745176f5sm6102234wrq.110.2024.03.11.03.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 03:41:55 -0700 (PDT)
Message-ID: <ce1cac6f-afb9-4388-b709-bfaee0feb525@linaro.org>
Date: Mon, 11 Mar 2024 11:41:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 4/5] input: add onkey driver for Marvell 88PM886
 PMIC
Content-Language: en-US
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20240303101506.4187-1-karelb@gimli.ms.mff.cuni.cz>
 <20240303101506.4187-5-karelb@gimli.ms.mff.cuni.cz>
 <ZeTgEmjJc_VhYpLm@google.com>
 <CZL8ZSZAVEBI.349BV2Y6AKIPN@gimli.ms.mff.cuni.cz>
 <ZeZxI_spu4vwxrs7@google.com>
 <CZQ1EP61IDOC.1PPYGMIOINGND@gimli.ms.mff.cuni.cz>
 <3601a374-4161-40e1-8a80-9bbfdae5bd8a@linaro.org>
 <CZQUKBQF1GZ9.3RSNW5WQBU9L6@gimli.ms.mff.cuni.cz>
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
In-Reply-To: <CZQUKBQF1GZ9.3RSNW5WQBU9L6@gimli.ms.mff.cuni.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/03/2024 11:26, Karel Balej wrote:
> Krzysztof Kozlowski, 2024-03-10T21:35:36+01:00:
>> On 10/03/2024 12:35, Karel Balej wrote:
>>> Dmitry Torokhov, 2024-03-04T17:10:59-08:00:
>>>> On Mon, Mar 04, 2024 at 09:28:45PM +0100, Karel Balej wrote:
>>>>> Dmitry,
>>>>>
>>>>> Dmitry Torokhov, 2024-03-03T12:39:46-08:00:
>>>>>> On Sun, Mar 03, 2024 at 11:04:25AM +0100, Karel Balej wrote:
>>>>>>> From: Karel Balej <balejk@matfyz.cz>
>>>>>>>
>>>>>>> Marvell 88PM886 PMIC provides onkey among other things. Add client
>>>>>>> driver to handle it. The driver currently only provides a basic support
>>>>>>> omitting additional functions found in the vendor version, such as long
>>>>>>> onkey and GPIO integration.
>>>>>>>
>>>>>>> Signed-off-by: Karel Balej <balejk@matfyz.cz>
>>>>>>> ---
>>>>>>>
>>>>>>> Notes:
>>>>>>>     RFC v3:
>>>>>>>     - Drop wakeup-source.
>>>>>>>     RFC v2:
>>>>>>>     - Address Dmitry's feedback:
>>>>>>>       - Sort includes alphabetically.
>>>>>>>       - Drop onkey->irq.
>>>>>>>       - ret -> err in irq_handler and no initialization.
>>>>>>>       - Break long lines and other formatting.
>>>>>>>       - Do not clobber platform_get_irq error.
>>>>>>>       - Do not set device parent manually.
>>>>>>>       - Use input_set_capability.
>>>>>>>       - Use the wakeup-source DT property.
>>>>>>>       - Drop of_match_table.
>>>>>>
>>>>>> I only said that you should not be using of_match_ptr(), but you still
>>>>>> need to have of_match_table set and have MODULE_DEVICE_TABLE() for the
>>>>>> proper module loading support.
>>>>>
>>>>> I removed of_match_table because I no longer need compatible for this --
>>>>> there are no device tree properties and the driver is being instantiated
>>>>> by the MFD driver.
>>>>>
>>>>> Is the MODULE_DEVICE_TABLE() entry needed for the driver to probe when
>>>>> compiled as module? If that is the case, given what I write above, am I
>>>>> correct that MODULE_DEVICE_TABLE(platform,...) would be the right thing
>>>>> to use here?
>>>>
>>>> Yes, if uevent generated for the device is "platform:<name>" then
>>>> MODULE_DEVICE_TABLE(platform,...) will suffice. I am not sure how MFD
>>>> sets it up (OF modalias or platform), but you should be able to check
>>>> the format looking at the "uevent" attribute for your device in sysfs
>>>> (/sys/devices/bus/platform/...). 
>>>
>>> The uevent is indeed platform.
>>>
>>> But since there is only one device, perhaps having a device table is
>>> superfluous and using `MODULE_ALIAS("platform:88pm886-onkey")` is more
>>> fitting?
>>
>> Adding aliases for standard IDs and standard cases is almost never
>> correct. If you need module alias, it means your ID table is wrong (or
>> missing, which is usually wrong).
>>
>>>
>>> Although I don't understand why this is even necessary when the driver
>>> name is such and the module is registered using
>>> `module_platform_driver`...
>>
>> ID table and MODULE_DEVICE_TABLE() are necessary for modprobe to work.
> 
> I think I understand the practical reasons. My point was that I would
> expect the alias to be added automatically even in the case that the
> device table is absent based solely on the driver name and the
> registration method (*module*_*platform*_driver). Why is that not the
> case? Obviously the driver name matching the mfd_cell name is sufficient

You mean add it automatically by macro-magic based on presence of
id_table and/or of_match_table?

That's a good question. I cannot find answer why not, except that maybe
no one ever wrote it...


> for the driver to probe when it is built in so the name does seem to
> serve as some identification for the device just as a device table entry
> would.
> 
> Furthermore, drivers/input/serio/ioc3kbd.c does not seem to have an ID
> table either, nor a MODULE_ALIAS -- is that a mistake? If not, what
> mechanism causes the driver to probe when compiled as a module? It seems

You are now mixing two different things: probing of driver (so bind) and
module auto-loading. Probing is done also by driver name. Auto-loading,
not sure, maybe by name as well? However it is also likely that
auto-loading is broken. Several drivers had such issues in the past.

Best regards,
Krzysztof


