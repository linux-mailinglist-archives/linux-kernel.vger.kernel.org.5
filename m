Return-Path: <linux-kernel+bounces-82761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A348686892D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435EF1F26476
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68332535B3;
	Tue, 27 Feb 2024 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PYI3FfcP"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFC953388
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709016546; cv=none; b=NI1uIiSBjCxR0x2q9fjglWEAzl3Anc17SY2kW73l2oEmUo6VwlqV+u7s1AlZ5dZrt83Tr+WB5bzD6k6wfVzyNT4TMEgJCTIUncBqVcPM7n386jR28AFBKAEh5oTUL50bBtUlAcQ8Sgb06Y1THVY6Ov4C9dAWQpVQzS6zaeJxp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709016546; c=relaxed/simple;
	bh=I/d0eMnYNaKxnQ9oXD2YJWd3h2CUwLNVAGEaDralJhg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=DU5dn0Bd4DxECmA2iQi1eoQZ82DHkMOourr90KCzhhsq24taplLyCT8emmuKdjRqfxJZiSz/ASBRHv/5P8DR/YNpYT3dhtFfiy0IxCtVv+Q1iBvIDTyq3bEhv0dwbzomymeL0Ff5ncrIwdE1qYw7OVdER4/zDaQ/5qt5Kij0CJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PYI3FfcP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3f1bf03722so408657766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709016543; x=1709621343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ftppbX4prfipbrJE2dRlWG+6CjMRbjIGhcz5uRsqIR0=;
        b=PYI3FfcPo4pywsNIFXbkB1k0haaq+mHQl6e/NMb80CdwLUJeDOo9CY6izHf0mEQsWJ
         6f9SKuzM/XwsngWjUyI0oIUMLkyyp20AUDq68M6W2LXidSirqR9nQnkbM3PL0rApGT9z
         wkTYA9a5Kx/iIxfF6Fclf57nb4Zs8wDNAHmeH5Huftkp3N78XJfHWSZNVMsqNuwMqWDK
         YuDop771IoAlX5iZmo1zDqgK6KFESQq+XT1Fa105nsHzJp1lErihiBD1u/JalDVD8h6c
         nmUvC5hn5cGHA48rsnoXS709mddpSr7JViKuMT7MIy0PPRX+p8fu1KpmdObqcZMr3TGp
         Vb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709016543; x=1709621343;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftppbX4prfipbrJE2dRlWG+6CjMRbjIGhcz5uRsqIR0=;
        b=wREN+aCcpi0iFutT+VcHWGgi14YTVsVsXV1rU1g3AA8Is59+hgs0UXuj+iRXa1fo0J
         A+SGQzoZjnomG+6B17IDgA7Xnyacf6S9Dd8TjoAqluVQ/JTSVIZm0bb1rlK/nZ7+qPfg
         uDmtbeC4SKsSO2vwUXp4R4T58s/nMZUtqfiI+4HqtPGkrVXbBiulih+z3bUw19nkbkpW
         m+junhtiFWfMrdAEjcOnPqyYz+UV71UC6LAj0G/G6hPJoX5VsysfZMEmf1UL8O1z1Yza
         QTo7YGcHGtaTLtfaVu+zFloZDtrcT1sb7+oNFnCDLulxVTcuIhY4Cj8a852M762W7WPM
         nu4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWns1gBijKobcKCedjLRR5W6wyXI9TijAC4VPdGMrU2xpYCRlz7oJGQSIASguy1r1cfVN71iLVcyeCV9JOow9en3UHqzW4wr96Lmc3Z
X-Gm-Message-State: AOJu0Yws/V1eZSiYhVjT0hfiia3rBvorGttJcnN51kFnf9ZKcQxbKya5
	NMwDQZeofTqXNa0yYkjWdL1480rdYGfGhImms+zTkKWyEk9vaseD5TbBMV5K/FE=
X-Google-Smtp-Source: AGHT+IFyUFbqRik0WxKEMrK61br7bRoBs9dysbrmk6zhOHxcrwDwAtYvRFr0QLbw4Etr9K3s5DLDpw==
X-Received: by 2002:a17:906:a1d3:b0:a3f:5104:dabb with SMTP id bx19-20020a170906a1d300b00a3f5104dabbmr5716010ejb.63.1709016543469;
        Mon, 26 Feb 2024 22:49:03 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id m13-20020a1709066d0d00b00a430da5de71sm448236ejr.152.2024.02.26.22.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 22:49:03 -0800 (PST)
Message-ID: <bc9f5dc6-dea3-4e1e-9c23-00fefb5f5439@linaro.org>
Date: Tue, 27 Feb 2024 07:49:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: input: allwinner,sun4i-a10-lrad: drop
 redundant type from label
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240226122934.89257-1-krzysztof.kozlowski@linaro.org>
 <3207352.5fSG56mABF@jernej-laptop>
 <907d61f3-4c9e-42b6-b314-927fd77e0b94@linaro.org>
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
In-Reply-To: <907d61f3-4c9e-42b6-b314-927fd77e0b94@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/02/2024 07:48, Krzysztof Kozlowski wrote:
> On 26/02/2024 18:31, Jernej Škrabec wrote:
>> Dne ponedeljek, 26. februar 2024 ob 13:29:34 CET je Krzysztof Kozlowski napisal(a):
>>> dtschema defines label as string, so $ref in other bindings is
>>> redundant.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>>
>> I already send PR for 6.9. Do you mind if it waits on next cycle?
> 
> Yes.

Damn English. I don't mind, but as Rob pointed this is patch for input.

Best regards,
Krzysztof


