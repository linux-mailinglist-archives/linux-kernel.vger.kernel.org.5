Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CA67FB43D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344162AbjK1IeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344131AbjK1Id5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:33:57 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D615710F7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:33:36 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54a94e68fb1so10043580a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701160415; x=1701765215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=beuKnDEbxYCgBgZlHh69Mpboqm/CAyipXVehWzED37Q=;
        b=flWiWvdlUSROLLgXquh+jDmkuIoiNxU/Lr4jSsq6oNCNU7KXnDHAgWCNsAhY/AzKVc
         4PY05dFP1vdDydRbOgtV8m8I7pYq3PAk4ps7GyvX2wlNOr7pp3UV0DvnpH3SDZQhr+bo
         PW9icJN5cJnkXvhHigZiyXE14jyskYY6Uue+zpgXgwXLNDKVcup6z6ydsKPkESsZqcGZ
         L5fy4vP8miqxNTLYiSSviSIo8VZay/HEwP8Y07ms8mVSCG5+CGgwGX3YK9OViDYbE2k/
         R77TCvW9H13e8tTKA7eR1h7gsQeP2KDKTQdhU+9NFZKp0mvPEeCINZsDB7SA2+3+ouxH
         xBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701160415; x=1701765215;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=beuKnDEbxYCgBgZlHh69Mpboqm/CAyipXVehWzED37Q=;
        b=VzM8EOq8bdozucLYEMTfWHh58b+ITb43LEQbvMTdr7Vmiju/X9Ip8pFRR1Jm5r/KDw
         7M8rTSJtmit/luyC6siPuok489J12oAiRYy1gmBABXIY4M5ZB1qHIU0Fn/9fuICfrs7e
         6a3sHtmY/glEfo7zg7gV2kZGT8AG4WRgzvMWfuJY9DiMqsK2fwSkswAXiK0OEdrRuPpl
         CcR/QHJYrnjEd/lPDUfcaNB6X4dNLPdE3LHrACY2vv3yFapXIP4ThrJ2E5s5FiwV5+Sh
         QZEU1ErfpQB/3KM/icwwLzT/beeoG3u3a3jKyZ+AlG45Uosl1cRLGGcC9D4JZH6cX2RA
         PMng==
X-Gm-Message-State: AOJu0YyD59zzAabdTLiz+ncHzOOkO485TJHQGIZzXlc9wwMMfWvJjnnG
        e1ipGHo7yIjqcE1DQiWi+GeJIklLkXJ/52pPHzk=
X-Google-Smtp-Source: AGHT+IHZ7h3fBdqbkaUMhQr3fLfwMwmznB+VIde0DvTxBp6MMzMvYbZLubr4pFM2hdTX0GO279mqCQ==
X-Received: by 2002:a17:906:8d2:b0:9b2:be5e:3674 with SMTP id o18-20020a17090608d200b009b2be5e3674mr12233282eje.36.1701160415320;
        Tue, 28 Nov 2023 00:33:35 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id e27-20020a1709062c1b00b009fda627abd9sm6527706ejh.79.2023.11.28.00.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 00:33:34 -0800 (PST)
Message-ID: <5ac7f79a-68d3-49ef-9615-3c0076591d78@linaro.org>
Date:   Tue, 28 Nov 2023 09:33:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: pinctrl: Document nuvoton ma35d1 pin
 control
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ychuang3@nuvoton.com, schung@nuvoton.com
References: <20231128061118.575847-1-ychuang570808@gmail.com>
 <20231128061118.575847-3-ychuang570808@gmail.com>
 <7c24aaf8-8f93-4b93-b7e5-abc88e95682d@linaro.org>
 <ffbaad9b-9a30-4cdd-bb78-8fb7d6ff4e9f@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <ffbaad9b-9a30-4cdd-bb78-8fb7d6ff4e9f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2023 09:29, Jacky Huang wrote:
> Dear Krzysztof,
> 
> Thanks for your review.
> 
> 
> On 2023/11/28 下午 03:34, Krzysztof Kozlowski wrote:
>> On 28/11/2023 07:11, Jacky Huang wrote:
>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>
>>> Add documentation to describe nuvoton ma35d1 pin control and GPIO.
>>>
>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>> ---
>> Your changelog said:
>>
>>>    - Remove ma35d1-pinfunc.h which is unused after update definition of
>> 'nuvoton,pins'.
>>
>> You forgot to add:
>>
>> " - Do not test the bindings before sending"
>>
>> I assume none of the driver changes compile either.
> 
> It's my mistake. I forgot to remove 'ma35d1-pinfunc.h' from my local 
> copy, and as a consequence, the 'dt_binding_check' did not catch this 
> error. I will fix this.

But then git status would point you that tree is not clean and you did
not finish commiting.

..


>>> +
>>> +allOf:
>>> +  - $ref: pinctrl.yaml#
>> allOf goes before additionalProperties.
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - nuvoton,sys
>> This goes after patternProperties
> 
> I will fix the above two as:
> 
> allOf:
>    - $ref: pinctrl.yaml#

Look:

>> allOf goes before additionalProperties.

Open example-schema.

..

> 
>>> +      - $ref: pincfg-node.yaml#
>>> +
>>> +    properties:
>>> +      bias-disable: true
>> Drop this and other "true", why do you need them here?
> 
> We are following the conventions used in other pinctrl documents, such as
> 'realtek,rtd1315e-pinctrl.yaml' and 'xlnx,zynqmp-pinctrl.yaml'.

But they are quite different there.

> 
> After comparing various pinctrl documents, I noticed that they all express
> it as 'bias-disable: true'. Therefore, may I keep the current format?

No, you cannot copy pieces of other binding, selectively ignoring the
rest. Look how these other bindings are constructed - they have
additionalProperties, which you don't.

Drop all these true properties if the only reason of them being here is
they were copied.



Best regards,
Krzysztof

