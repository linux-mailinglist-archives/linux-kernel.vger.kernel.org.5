Return-Path: <linux-kernel+bounces-11505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD19281E764
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 444A9B217D0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 12:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521054E636;
	Tue, 26 Dec 2023 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fH+2QEOm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BC54EB33
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a26db4e9676so250162566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 04:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703593379; x=1704198179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a3QQxuF84yooCYQHBDDDVtlHdCmOBOFmeeu1k+m7XAU=;
        b=fH+2QEOmKhiNKl/uWrDvOu2c+QLX5gQ1WPZ4AqXfHKyxVVKdDAUK8RQ0IFGFGHg+ko
         eJ4DCVv7lbuOK5WW6Tw88ejRkcihltTC+WVIQsOU/TsSL8di3d04LpRlMhK8QLdrGtYE
         ZnvosvLEap+aGq6nOZIfxG9zL57K3903QqV8VVT0pHo5WtL/fNcmXZIp/hn22K6olbS6
         5epaj8seaMVYdTFx/1hANGW9pyftPuTr7RQaBCU+ca45YD3y60Dihw3Vo9eZPzyskBtw
         Jz4fbanhH3/BmIG9cbXNjTwnxuKYci8xzFukt2N0hAtXeBM6xzFFTMhJVsSOl5SsUl5P
         +u+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703593379; x=1704198179;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3QQxuF84yooCYQHBDDDVtlHdCmOBOFmeeu1k+m7XAU=;
        b=wuCCFaTIm+dzaXAEHP/6/pnCiR/AJzjmLMbjCt33r9wIr0NdjhGo2lyNf3yByNspJZ
         tiNW+n8wWwzuK094yT+JBnNEQTO/5xG7bqTZoalU9AC6Etbz23jQtpmLuUa6B2JTrGKH
         SGO/hvZyGxyZ4WlJY3KHT06/K1HBAGGRYDQ+k2wHWUyASrVuW/Q7vxPxcqItyiycs8nS
         DeI01H/wP2BYMjwLkHl8Py0/CaGyrwpaZ8BLRzaYOjUziU4ktmTYszvTthrMb81ZPosl
         BgZtAaT7mCdaJpzwmXShJ4pM4VAxIeBtHjVM91PY8kBXQTvLYSCuIopVYxhxjInnhhvg
         02FQ==
X-Gm-Message-State: AOJu0YwSgBI+bLTZFlswgVSuDBEWjk8Okym+Ehgayqy6069Ps3EZL5gp
	Z4QW4vQC7pFphCm0cvnZ6tGkZfDHiGsfQ0qJwlJWYDXFM4c=
X-Google-Smtp-Source: AGHT+IG+As1JYOYeLHOD3BxQ8syuWnpXKHJk95EyQsjnA1fXVch09Ht8we05+807eD4/IRG1vqMUXA==
X-Received: by 2002:a17:906:782:b0:a26:e493:3c79 with SMTP id l2-20020a170906078200b00a26e4933c79mr878433ejc.23.1703593379321;
        Tue, 26 Dec 2023 04:22:59 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id z27-20020a17090674db00b00a26aa045d48sm5225353ejl.117.2023.12.26.04.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Dec 2023 04:22:58 -0800 (PST)
Message-ID: <efdf2923-4669-409f-b5c4-d5b95009309f@linaro.org>
Date: Tue, 26 Dec 2023 13:22:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 binding
Content-Language: en-US
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Wesley Cheng <quic_wcheng@quicinc.com>, Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, quic_ppratap@quicinc.com,
 quic_jackp@quicinc.com, Andy Gross <agross@kernel.org>
References: <20231222063648.11193-1-quic_kriskura@quicinc.com>
 <20231222063648.11193-2-quic_kriskura@quicinc.com>
 <e6419898-0d77-4286-a04b-7240eb90d8df@linaro.org>
 <268f9f54-8b2a-42bb-9a5d-10bd930cb282@quicinc.com>
 <55c478c7-abcc-4487-b81c-479df47d5666@linaro.org>
 <67c7c84c-c631-468e-ae67-1c31d41a605b@quicinc.com>
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
In-Reply-To: <67c7c84c-c631-468e-ae67-1c31d41a605b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/12/2023 11:03, Krishna Kurapati PSSNV wrote:
>>>>>      - if:
>>>>> @@ -460,11 +422,13 @@ allOf:
>>>>>            compatible:
>>>>>              contains:
>>>>>                enum:
>>>>> +              - qcom,ipq5332-dwc3
>>>>>                  - qcom,sc8280xp-dwc3
>>>>>                  - qcom,x1e80100-dwc3
>>>>>        then:
>>>>>          properties:
>>>>>            interrupts:
>>>>> +          minItems: 3
>>>>
>>>> Hm, why? This commit is unmanageable. Your commit msg is already huge
>>>> but still does not explain this. Are you sure you are fixing only one
>>>> logical thing per patch? Does not look like.
>>>>
>>>
>>> This is reordering the targets based on interrupts they have. I put it
>>> in one commit because splitting this into multiple patches breaks one
>>> thing or other. Also once I am defining permutations, I have to group
>>> targets into these combinations in the same patch. I know this is a big
>>> commit but it solves the interrupt cleanup and defines a way for future
>>> targets.
>>
>>
>> This does not answer why, you sc8280xp and x1e80100 not get one optional
>> interrupt. I asked "why" you are doing this change. Why do you need it?
>> What is the rationale?
>>
>> Then I grunted about unmanageable commit, because all my troubles to
>> review it are the effect of it: it is very difficult to read. It is also
>> difficult for you, because you keep making here mistakes. So if you
>> cannot write this commit properly and I cannot review it, then it is way
>> over-complicated, don't you think? But this is still second problem
>> here, don't ignore the fist - "why?"
> 
> HI Krzysztof,
> 
>   Thanks for the review.
>   To answer the question,
> 
> "why ?" : The interrupts have been mis-interpreted on many platforms or 
> many interrupts are missing.

I asked about these two specific platforms. Please explain these
changes. Above is so generic that tells me nothing.

> 
> Now, if I am adding the missing interrupts, I need to segregate targets 
> also into respective buckets in the same patch and that is what making 
> this patch a little complicated. Is it possible / acceptable to split 
> this into two patches if this is the case. Can you help with suggestions 
> from your end ? Or may be I am understanding your question wrong ? 😅

Split the patch into manageable chunks.

Best regards,
Krzysztof


