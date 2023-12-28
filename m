Return-Path: <linux-kernel+bounces-12506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4767F81F5D3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC8D6B225DB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEF053B4;
	Thu, 28 Dec 2023 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sPmxTK+B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DEB440D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3367632ce7bso5126020f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 00:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703750792; x=1704355592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yS4I0BY87/ZpLOavCpuQTaflDJ5vpJelsFkK9bAx5JM=;
        b=sPmxTK+BYpYexMNvYh0ACk53PZQANjkBhZFgzGlI+p7Rud9pQ6B7OvdhkK3cpxAiUD
         +yn6iB7K0tBt3fi0kxfBYCFD3NKyRgw89jeljtt9Frj3sFwnI3Ec85zwRe81SF5cjdr/
         sozn2xE7tMTizuKRPMu2uUB/7xrK9eV9XdS+ICKng1VFbyQZjsBKO2ebUMRfZlU1di6Q
         8OTzmb0y9YjyDRrLkWnUG+Vk1AiPuUDbEXTpZYgW6QT7OCbO/CmyvUcCfaaet+vKzddP
         X/6/kTn7gzHd7Xw/TkJHDSPqI8GhuELWl4yYA5aU1LGesPkj0apj2I3sPnH5T9WR3eNj
         DCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703750792; x=1704355592;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yS4I0BY87/ZpLOavCpuQTaflDJ5vpJelsFkK9bAx5JM=;
        b=BWAOEtJYLGyW5gHTNwdENZsDnvwg1ghHGvQoNVQ1T2Hev8hw1MCOadHzTUy+X4B4A/
         YM2MfVNFs8e/OL6iJIR1vyOwk0R37z+W5zeqKr3bju+2ygAas82vFCkYD8Y4m/9me/o/
         j2V+lf4nCU7Bhz+jJ/plvzPmUONFUEZqNQ1SGRqYLtkPinFUoBY1xoCBlx7G3LH8Dxa4
         H2w+gLAZbXJCr89pK+/2heFz4mk8DbdD95EUlGswh6cmWFEKw8ailrsnzjNHw4zvgOaN
         c9de+7sCcYOeMBCfLSJbo9x+Z2UIo+F51KVQkY419NmIpncYZea1zUg5bmWiDZ5iULPc
         8mpw==
X-Gm-Message-State: AOJu0Yx0G4DUA7cQzH4ltsSeifS35aWUE4TL8OFbWheFWAhDk3OUMVle
	NfwsMbaLD/AT+RAl5i0iqMiTEK4u4fzt2w==
X-Google-Smtp-Source: AGHT+IEHS2yiK8QWCDx03AHzF1VAt5q7LTLP0mhUicvFvtNIm+9vPgbZPmhXgezE5u4bWREaxi1vJw==
X-Received: by 2002:a05:6000:1e87:b0:337:9e8:f578 with SMTP id dd7-20020a0560001e8700b0033709e8f578mr418791wrb.37.1703750792632;
        Thu, 28 Dec 2023 00:06:32 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id c9-20020a056000104900b003368849129dsm15745551wrx.15.2023.12.28.00.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Dec 2023 00:06:32 -0800 (PST)
Message-ID: <7a193550-749a-4d96-89e9-aee10c468b7b@linaro.org>
Date: Thu, 28 Dec 2023 09:06:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: rtq6056: add support for the
 whole RTQ6056 family
To: ChiYuan Huang <cy_huang@richtek.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1703562468-29052-1-git-send-email-cy_huang@richtek.com>
 <1703562468-29052-2-git-send-email-cy_huang@richtek.com>
 <9715ed9d-7edf-430c-808c-00e7748bc59a@linaro.org>
 <20231226111921.GA22684@linuxcarl2.richtek.com>
 <0f1f0991-9ad9-4216-afc8-8340eddb1ad9@linaro.org>
 <20231228031929.GA32046@linuxcarl2.richtek.com>
 <e1036e63-1914-4412-8c55-40ae206d56d0@linaro.org>
 <20231228075824.GA16067@linuxcarl2.richtek.com>
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
In-Reply-To: <20231228075824.GA16067@linuxcarl2.richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/12/2023 08:58, ChiYuan Huang wrote:
> On Thu, Dec 28, 2023 at 08:09:35AM +0100, Krzysztof Kozlowski wrote:
>> On 28/12/2023 04:19, ChiYuan Huang wrote:
>>> On Tue, Dec 26, 2023 at 01:12:50PM +0100, Krzysztof Kozlowski wrote:
>>>> On 26/12/2023 12:19, ChiYuan Huang wrote:
>>>>> On Tue, Dec 26, 2023 at 10:18:47AM +0100, Krzysztof Kozlowski wrote:
>>>>>> On 26/12/2023 04:47, cy_huang@richtek.com wrote:
>>>>>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>>>>>
>>>>>>> Add compatible support for RTQ6053 and RTQ6059.
>>>>>>>
>>>>>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>>>>>>> ---
>>>>>>>  .../devicetree/bindings/iio/adc/richtek,rtq6056.yaml         | 5 ++++-
>>>>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
>>>>>>> index 88e008629ea8..d1e1f36d1972 100644
>>>>>>> --- a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
>>>>>>> @@ -25,7 +25,10 @@ description: |
>>>>>>>  
>>>>>>>  properties:
>>>>>>>    compatible:
>>>>>>> -    const: richtek,rtq6056
>>>>>>> +    enum:
>>>>>>> +      - richtek,rtq6053
>>>>>>> +      - richtek,rtq6056
>>>>>>
>>>>>> Aren't these devices compatible? Your driver change says they are, so
>>>>>> express compatibility with list here (and oneOf).
>>>>>>
>>>>> Thanks, I try to take other binding as the reference. One more question.
>>>>> If rtq6053 is compatible with rtq6056, there's only chip package type difference.
>>>>> Do I need to seperate it into a dedicated enum element?
>>>>> Or just put it into one item and said this part number is compatible with rtq6056? 
>>>>
>>>> See example-schema. You need enum and items, both in oneOf:.
>>>>
>>> After reading the 'example-schema', I Still cannot understand what the special case items
>>> means.
>>
>> What is "special case items"?
>>
> I may misunderstand something. The special case is the 'fallback' that you mentaioned in
> the last.
>>>
>>> But in my case, is the below change correct?
>>> [Diff]
>>> properties:
>>>    compatible:
>>> -    enum:
>>> -      - richtek,rtq6053
>>> -      - richtek,rtq6056
>>> -      - richtek,rtq6059
>>> +    oneOf:
>>> +      - items:
>>> +          - enum:
>>> +              - richtek,rtq6053
>>> +              - richtek,rtq6056
>>> +              - richtek,rtq6059
>>
>> This changes nothing, you still have just one item. The example-schema
>> has exactly that case, so why you are coding it differently?
>>
>> Anyway, test your DTS with the fallback, you will see that above does
>> not work.
>>
> I rewrite the below one and tested. it seems correct.
> 
> [Diff]
>    compatible:
> -    enum:
> -      - richtek,rtq6053
> -      - richtek,rtq6056
> -      - richtek,rtq6059
> +    oneOf:
> +      - enum:
> +          - richtek,rtq6053
> +          - richtek,rtq6059
> +      - items:
> +          - const: richtek,rtq6056

You still need two items here to express compatibility. What is
compatible with what? It must be rtq6053 compatible with rtq6056,
because you cannot break the ABI, can you?

> 
> Just one more question. If rtq6053 is fully compatibie with rtq6056, does it need to be put
> into oneOf enum or be just put into items enum and use the 'fallback' mechanism?

The fallback is just a term. The point is to have a list of two
compatibles. See: Devicetree specification, writing-bindings and
numerous presentations about writing DTS.

> 
> If so, the 'richtek,rtq6053' in of_device_id match can be removed. Though it just remove
> one line, but less-changed would be better.

The device using fallback should be removed the driver of_device_id, so
6053 goes away.


Best regards,
Krzysztof


