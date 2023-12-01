Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676DD800524
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377780AbjLAIEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjLAIEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:04:32 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0805A10F8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:04:39 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bbb4de875so2538973e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 00:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701417877; x=1702022677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LnMmC4OxC8/yl5Iv63kraQCqLS5wg0ARkey8Doj6j5M=;
        b=wsHL9YAZAczPROHzhE/YMRRcLIUNb18eIOZJ35fh5lJlu0kZBPBOAk5aTo8+PmrNwA
         aeB4Dibm7vibxNMxzU3iIVv0BXoNFZWHOHsjy2/UXuO6GRTScuPDGXBjPRZGEtSyWSPw
         ynby0nc+nEwnOBtM/HADIqwTCV+60M6kv6WQqudgxspI3LV+y1yOAXfnu1Qx2LOaemHl
         Y/RqEiTp0z1I/uIo+niAR8RNMVwMjb28ybf0Ah8xAUOUsrB8/bQ0W2I2OG3mOvWhlrui
         YYmyUDPCmpOy2/k3fsUukW5ZWloSp80Cl+3mqwPK858XdX2kqcDl5GpEPL9RkwrwERSh
         fkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701417877; x=1702022677;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnMmC4OxC8/yl5Iv63kraQCqLS5wg0ARkey8Doj6j5M=;
        b=MbxXzVd1NPuntWkrdtWjfX64pgrW0E4XKvv6A2Qr730loauUX/IzbVQ+R+2MLur0eS
         HpEBX2I6SgElBM7hel+85HNLsjOnjW4c7a5euFuqpCxEVYcBvYntUpNYz7p6aKf8etak
         Tke3JTzMAHctZ5KEWGWjJCfgRM5KJbmiHREIcp37AC2Dcgl9FdlvGmZyXx2WPsvy9ijz
         xPg6QxefSnEeO2MxPagQT+Mg5w1vVwKfnUKLnoGxfRe78L99qIooylJLIHqcHMrkwAR6
         NslsePxYuZVRVvCXTFSpUlqfq7ltN5GBkIIxZpxad8e77HnNxv9/7I6S4rg62P6fgiod
         r4qA==
X-Gm-Message-State: AOJu0YxaDaSJRt5CvpwUKREPUmQvv54/rfN7lkrMJqojTz9d8MnhF4tK
        skMxLW/keGsBagn0pk7mLB3tKA==
X-Google-Smtp-Source: AGHT+IGZyPAdP7LWnrBUQtc0Ne0rcesCeo1b8I3tC2M14VSOYkhsyvMIK+alG+bjNk3fNZODOwluIg==
X-Received: by 2002:a05:6512:ea8:b0:50b:d764:64ba with SMTP id bi40-20020a0565120ea800b0050bd76464bamr658382lfb.111.1701417877260;
        Fri, 01 Dec 2023 00:04:37 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c4e8f00b0040b3632e993sm8204509wmq.46.2023.12.01.00.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 00:04:36 -0800 (PST)
Message-ID: <b6a18d66-6022-4947-9616-53cfbb17e759@linaro.org>
Date:   Fri, 1 Dec 2023 09:04:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: Add sony,cronos-cpld
Content-Language: en-US
To:     Shawn Anastasio <sanastasio@raptorengineering.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Georgy Yakovlev <Georgy.Yakovlev@sony.com>
Cc:     Timothy Pearson <tpearson@raptorengineering.com>
References: <cover.1701203916.git.sanastasio@raptorengineering.com>
 <27ac3bf6e5fecd62918eb096a88503a13a1f0b9c.1701203916.git.sanastasio@raptorengineering.com>
 <c50e5224-7acd-4470-b18e-f223f150ba5b@linaro.org>
 <eb29a877-8c71-498c-b5a1-320315b84cc7@raptorengineering.com>
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
In-Reply-To: <eb29a877-8c71-498c-b5a1-320315b84cc7@raptorengineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2023 00:03, Shawn Anastasio wrote:
>>> +properties:
>>> +  compatible:
>>> +    const: sony,cronos-cpld
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  leds:
>>> +    type: object
>>> +    description: Cronos Platform Status LEDs
>>
>> Missing ref to LEDs common bindings.
>>
> 
> Will fix.
> 
>>> +
>>> +    properties:
>>> +      compatible:
>>> +        const: sony,cronos-leds
>>> +
>>> +      sony,led-mask:
>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>
>> Why aren't you using LEDs bindings? A node for one property is otherwise
>> quite useless. I already commented on this last time.
>>
> 
> Our driver as-is doesn't support any of the properties in the LEDs
> common bindings, but it doesn't seem like there's anything that would
> preclude support in hardware, so this can be fixed.

Driver does not matter. We talk here about bindings, so about hardware,
not driver.

You must describe here hardware fully, not the driver.

> 
> Will use the LED bindings in v3.
> 
>>> +        minimum: 0x0
>>> +        maximum: 0x7fff
>>> +        description: |
>>> +          A bitmask that specifies which LEDs are present and can be controlled
>>> +          by the Cronos CPLD. Bits 0-5 correspond to platform Status LEDs, bits
>>> +          6-10 correspond to Link LEDs, and bits 11-14 correspond to the Power
>>> +          State LEDs. All other bits are unused. The default value is 0x7fff
>>> +          (all possible LEDs enabled).
>>> +
>>> +    additionalProperties: false
>>> +
>>> +  watchdog:
>>> +    type: object
>>> +    description: Cronos Platform Watchdog Timer
>>
>>
>>> +
>>> +    properties:
>>> +      compatible:
>>> +        const: sony,cronos-watchdog
>>> +
>>> +      sony,default-timeout:
>>
>> No, you must use existing bindings. Missing ref to watchdog and drop all
>> duplicated properties like this one.
>>
> 
> In this case the existing watchdog binding allows for arbitrary timeout
> values to be set, but the hardware only tolerates one of a few fixed
> values, enumerated below, which is why I felt it was appropriate to use
> a vendor-specific binding that documents the supported values.

You can narrow the accepted values.

> 
> Would you still prefer we ref to watchdog and just handle unsupported
> values in the driver by e.g. rounding or rejecting unsupported values?

It's not preference, it's a must.

Best regards,
Krzysztof

