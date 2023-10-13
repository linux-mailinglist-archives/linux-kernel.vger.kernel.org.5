Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6527B7C806D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjJMIf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjJMIf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:35:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DA5D8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:35:52 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ae75ece209so296984866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697186151; x=1697790951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=grAXNyzj17V163hszU2PuUkW35ZyN7Jv6aHwdCjJTRE=;
        b=wc4zvkFtVEemWaccUpPqFi69q1NX5e8bcw2kpjxxpuw7Rk0+EufAOO7mjSWH0I3uvO
         i8cn+5vNuOkObisSTOYfF+lmICd5UEfTqJFJbrTMKeECs5ah6aj2EDgb7JcXbn7GyM1K
         ENy2aS2OFlq3/M7+AYGuwyW1n99+tPGWF7JhomEZtpDz8nScH6Ti34ASaFojb46Kf5ep
         HGnHfhr3nb58ZJNvXgOBlrvZF7oe8PR+tqUKB1qAKwkGUqq/pAjibg75V9vf0hX3ElGz
         Hi0WrBKYeZ+WGy+xFAlgQdyIBqZTvc8vSxN12JV9aLm5mOx9YqVakEUxOJVUkai8nQcX
         aSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697186151; x=1697790951;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grAXNyzj17V163hszU2PuUkW35ZyN7Jv6aHwdCjJTRE=;
        b=AMPnhO1V1nG/c/meOC3LxbVH8PbjDWMPluXN/X4uCvH6nWJ0SngyFFWL2UyzAktNtu
         Y6ry0ZDu6OIyOwmyp3DJOkO0wb6OFy2Rj7xY+o99cqTMgmBq2l5vfvc1SuCoeZg7oTo6
         bpCc2aMLqrMiwAnFdtnVG84YcDnGlw1JEgtH3Qgfb5dK/BVnysJ2dOcHRfXo900jBh4F
         j6/WCElf934r+0WW92HyCWkulkja2ek22fsi1AOZEoua1HMPTpJSB55fJ1WzIOuCN40z
         wuCeikDg1s1hjOpVleDfKQ9+cT0r4mN/nvtCXb8RxldhnOsfPpNQP4IvLegG9HOhYLAi
         HCvg==
X-Gm-Message-State: AOJu0YzBg11RWtxQP1UXtgNJr/y9Or4nT+ex+vS5o36/52TYBeb9kvdY
        izZOtME/xlwJ/Nt//hCtpdgdxA==
X-Google-Smtp-Source: AGHT+IGg28eJurm7V7gHx4DA0SLNZUEN0KN94ZRpgP3IJpAj3xNkaHLTKmv/yJpZLEohRje77iNvwA==
X-Received: by 2002:a17:907:75f7:b0:9a1:c9c5:5fa1 with SMTP id jz23-20020a17090775f700b009a1c9c55fa1mr23611892ejc.4.1697186150802;
        Fri, 13 Oct 2023 01:35:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id i11-20020a170906a28b00b009737b8d47b6sm12010902ejz.203.2023.10.13.01.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 01:35:50 -0700 (PDT)
Message-ID: <2eafa89c-7c95-4bc1-85cb-a6d7417dcea8@linaro.org>
Date:   Fri, 13 Oct 2023 10:35:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: adc: provide max34408/9 device tree
 binding document
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Ivan Mikhaylov <fr0st61te@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20231007234838.8748-1-fr0st61te@gmail.com>
 <20231007234838.8748-2-fr0st61te@gmail.com>
 <20231010154042.2ef667b2@jic23-huawei>
 <383064a5b0863a4a616cd60cff8d4bc18e397fd7.camel@gmail.com>
 <20231012084052.504ac930@jic23-huawei>
 <e7b74daa9d0131246fd10f47aa4128bc8f8f3177.camel@gmail.com>
 <20231013091952.00002573@Huawei.com>
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
In-Reply-To: <20231013091952.00002573@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2023 10:19, Jonathan Cameron wrote:
> On Thu, 12 Oct 2023 19:27:33 +0300
> Ivan Mikhaylov <fr0st61te@gmail.com> wrote:
> 
>> On Thu, 2023-10-12 at 08:40 +0100, Jonathan Cameron wrote:
>>> On Tue, 10 Oct 2023 23:22:48 +0300
>>> Ivan Mikhaylov <fr0st61te@gmail.com> wrote:
>>>   
>>>> On Tue, 2023-10-10 at 15:40 +0100, Jonathan Cameron wrote:  
>>>>> On Sun,  8 Oct 2023 02:48:37 +0300
>>>>> Ivan Mikhaylov <fr0st61te@gmail.com> wrote:
>>>>>     
>>>>>> The hardware binding for i2c current monitoring device with
>>>>>> overcurrent
>>>>>> control.
>>>>>>
>>>>>> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
>>>>>> ---
>>>>>>  .../bindings/iio/adc/maxim,max34408.yaml      | 141
>>>>>> ++++++++++++++++++
>>>>>>  1 file changed, 141 insertions(+)
>>>>>>  create mode 100644
>>>>>> Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
>>>>>>
>>>>>> diff --git
>>>>>> a/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
>>>>>> b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..9749f1fd1802
>>>>>> --- /dev/null
>>>>>> +++
>>>>>> b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
>>>>>> @@ -0,0 +1,141 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id:
>>>>>> http://devicetree.org/schemas/iio/adc/maxim,max34408.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: Two- and four-channel current monitors with overcurrent
>>>>>> control
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Ivan Mikhaylov <fr0st61te@gmail.com>
>>>>>> +
>>>>>> +description: |
>>>>>> +  The MAX34408/MAX34409 are two- and four-channel current
>>>>>> monitors
>>>>>> that are
>>>>>> +  configured and monitored with a standard I2C/SMBus serial
>>>>>> interface. Each
>>>>>> +  unidirectional current sensor offers precision high-side
>>>>>> operation with a
>>>>>> +  low full-scale sense voltage. The devices automatically
>>>>>> sequence
>>>>>> through
>>>>>> +  two or four channels and collect the current-sense samples
>>>>>> and
>>>>>> average them
>>>>>> +  to reduce the effect of impulse noise. The raw ADC samples
>>>>>> are
>>>>>> compared to
>>>>>> +  user-programmable digital thresholds to indicate overcurrent
>>>>>> conditions.
>>>>>> +  Overcurrent conditions trigger a hardware output to provide
>>>>>> an
>>>>>> immediate
>>>>>> +  indication to shut down any necessary external circuitry.
>>>>>> +
>>>>>> +  Specifications about the devices can be found at:
>>>>>> + 
>>>>>> https://www.analog.com/media/en/technical-documentation/data-sheets/MAX34408-MAX34409.pdf
>>>>>> +
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    enum:
>>>>>> +      - maxim,max34408
>>>>>> +      - maxim,max34409
>>>>>> +
>>>>>> +  "#address-cells":
>>>>>> +    const: 1
>>>>>> +
>>>>>> +  "#size-cells":
>>>>>> +    const: 0
>>>>>> +
>>>>>> +  reg:
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  interrupts:
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  powerdown-gpios:
>>>>>> +    description:
>>>>>> +      Shutdown Output. Open-drain output. This output
>>>>>> transitions
>>>>>> to high impedance
>>>>>> +      when any of the digital comparator thresholds are
>>>>>> exceeded
>>>>>> as long as the ENA
>>>>>> +      pin is high.
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  shtdn-enable-gpios:    
>>>>>
>>>>> I guess the review crossed with you sending v5.  There is some
>>>>> feedback on v4 you need
>>>>> to address here.    
>>>>
>>>> Jonathan, I thought I did, I've changed ena to powerdown-gpios from
>>>> Krzysztof's comments but about this one pin I'm still not sure, it
>>>> looks like *-enable-gpios (like in *-enable-gpios pins in
>>>> iio/frequency/adi,adf4377.yaml) pin or is it not? Or maybe any
>>>> other
>>>> suggestions about naming of this one?
>>>>
>>>> Thanks.  
>>>
>>> shutdown-gpios and make the sense (active high / low) such that
>>> setting
>>> it results in teh device being shut down.
>>> Or treat it as an enable and enable-gpios
>>>
>>> Something that indicates both shutdown and enable is confusing ;)
>>>
>>> Jonathan  
>>
>>
>> Jonathan, then I make these changes:
>>
>> powerdown-gpios: -> output-enable:
> Needs to retain the gpios bit as we want the standard gpio stuff to pick
> them up. I'm not that keen on output-enable-gpios though.  The activity
> here is very much 'shutdown because of error or not enabled' I think.
> So perhaps we flip the sense and document that it needs to be active low?
> 
>> shtdn-enable-gpios: -> enable-gpios:
>>
>> Is it ok?
> 
> Conor, Rob, Krzysztof - you probably have a better insight into this than
> I do.
> 

"enable-gpios" are for turning on a specific feature, not powering
on/off entire device. For example to enable regulator output.

"powerdown-gpios" are for turning device on/off.

I don't know what do you have in your device.

Best regards,
Krzysztof

