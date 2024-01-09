Return-Path: <linux-kernel+bounces-20532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DD682803F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CBA1F27CD5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E5713FE7;
	Tue,  9 Jan 2024 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYeFoAxL"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31874EAC8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55642663ac4so2956085a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 00:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704788121; x=1705392921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tWyG23Ws+pJkmRC2s/Hf6/Y0DxAuq5n6msc+OYifnxM=;
        b=RYeFoAxLjtccKISqJrLDvTKU7E8qvFxA65tHaJVJH9dhV2IvIE/IeHBf52aBZNs+sw
         1irCSx88jHf0XszpyJ7BKNAEYNgOMyr0MA2Z30y7ckxsqMbErDjmbbq1k0+Wu8jG+iXQ
         c1MQWUaQ5AQxcFvbndF+MqfFrZ4QTqAQXAprFDCskskCe5mTTHi6S/ROfXRq1Zo0BsTw
         VyaDoljx9Vl+MRvaz8Ue9DnsLZuwARV1r4WA0YNdLwwiscYKUccOIEIMaUHNBu3Mv+/h
         nn60S0Y0qvNHNs8Gtftw6tOz0dPU6qAF2na0MvcgZPGjqNbGMlJ7nm9RDviR0cRSViaj
         h6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704788121; x=1705392921;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tWyG23Ws+pJkmRC2s/Hf6/Y0DxAuq5n6msc+OYifnxM=;
        b=YSPU6BjEbr2xvzUr5NCph3QyqvFm92gyvk967FIChdtfJlDV5hSS3gPRV0A5vKzVd6
         bqhZ2UkZzhdWkl4nsW2CbW68efxREnkJ5a/tpPtoXg4Rgostin5bBMTlFJbxy6KO1koL
         +lEZeZ/H1447hXhESP5mz3oxbb3af/bgo/1O9baLB6Tz8w6e5iq0n9OGB9jybEthosIg
         ey9dAWAMqUNp0moGDhm5zuASrOxjJI6QUdu2B6YBNZTR2DB9CBuOXAFyhfkMeRnWMV96
         Cr92aL7l+J0y6LffK1auf+h94ZOWSDUbAMabplYx5Q0ivF0dL+fy4sGuYfPIvbuy7QGn
         9WbA==
X-Gm-Message-State: AOJu0YxtI0UPhDaGQDG59FvngsYqiWpY5nVYq5YX4N8pLJeHj6HCwLgV
	nuv+YKIu7mE8/mh+ncjycB7rwI85ZHyqdA==
X-Google-Smtp-Source: AGHT+IG1Wvl3DDlx3IZ8O4K3QFQ3v+ch2dDWpKS8ot0EI8y8w7PYQ4kaM9NsFhYq7mu0tGptNBDw2g==
X-Received: by 2002:aa7:d7c9:0:b0:54c:4837:9a9f with SMTP id e9-20020aa7d7c9000000b0054c48379a9fmr2220286eds.70.1704788121445;
        Tue, 09 Jan 2024 00:15:21 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id h15-20020aa7c94f000000b00557c6778b88sm676290edt.53.2024.01.09.00.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 00:15:20 -0800 (PST)
Message-ID: <e88205a2-f8b6-42c7-82cc-bfc08a680f3d@linaro.org>
Date: Tue, 9 Jan 2024 09:15:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: fpga: Convert bridge binding to yaml
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, kishore Manne <nava.kishore.manne@amd.com>,
 "open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
References: <3100bbc4723643ec1ec7d4548e9ab353c856b564.1704470663.git.michal.simek@amd.com>
 <ab6a9a0e-ab03-4d35-9e43-c90c22dbcb1d@linaro.org>
 <4bcac34b-72a0-464e-91cd-d9e924073619@amd.com>
 <ZZzDHxnMPTuraS4D@yilunxu-OptiPlex-7050>
 <bd356c60-7681-47e4-b45f-d25e70068b65@linaro.org>
 <3bfaab38-6831-41f8-8a7b-9f1f434e0f9c@amd.com>
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
In-Reply-To: <3bfaab38-6831-41f8-8a7b-9f1f434e0f9c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/01/2024 09:06, Michal Simek wrote:
> 
> 
> On 1/9/24 09:00, Krzysztof Kozlowski wrote:
>> On 09/01/2024 04:53, Xu Yilun wrote:
>>> On Mon, Jan 08, 2024 at 10:16:17AM +0100, Michal Simek wrote:
>>>>
>>>>
>>>> On 1/8/24 10:09, Krzysztof Kozlowski wrote:
>>>>> On 05/01/2024 17:04, Michal Simek wrote:
>>>>>> Convert the generic fpga bridge DT binding to json-schema.
>>>>>>
>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>
>>>>>> +$id: http://devicetree.org/schemas/fpga/fpga-bridge.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: FPGA Bridge
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Michal Simek <michal.simek@amd.com>
>>>>>> +
>>>>>> +properties:
>>>>>> +  $nodename:
>>>>>> +    pattern: "^fpga-bridge(@.*)?$"
>>>>>
>>>>> Not sure, but maybe we need to allow fpga-bridge-1? Could we have more
>>>>> than one bridge on given system?
>>>>
>>>> Yilun: Any comment on this?
>>>
>>> We can have more bridges, but IIUC people use fpga-bridge@0, fpga-bridge@0
>>> to identify them. So the expression is OK to me.
>>
>> So you claim unit address thus reg with some sort of bus address is a
>> requirement? Then "?" is not correct in that pattern.
> 
> I expect it is about that people are using fpga-bridge@0 but bridge is not on 
> the bus. Yilun said that reg property in altr,socfpga-fpga2sdram-bridge.yaml is 
> optional which means no reg property no @XXX in node name.
> That's why I think that expression is correct. If there are more bridges without 
> reg property then I expect we need to get more examples to align expression.

If we allow node name without unit address, thus not being part of any
bus, then the only question is whether it is possible to have system
with more than two FPGA bridges. If the answer is "yes", which I think
is the case, then the pattern should already allow it:

(@[0-9a-f]+|-[0-9]+)?

Best regards,
Krzysztof


