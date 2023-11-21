Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046B27F2F42
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbjKUNvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUNvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:51:31 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBCCD6A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 05:51:25 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso766283966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 05:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700574684; x=1701179484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wDIPScNOhQgHt38LsO0B0cG2vktuRay/6L9Ve7qh5S4=;
        b=hk4lcqx01jkdK5ayzhye5MwWL0zxuH8tCRqNgjm/gPysRvJg/g48OEdzu2rQzMlMzD
         7bsVfeCQVm08RbgJYUJwyFlqMTB0qowY1XcoLkxpMf3BLMvx0dNPkkgP9yET+/pCnhGL
         vEosO+tgubI6oYEX6lxYcpDy9s1teCH0D2L5fQekgpW+AhWfpVLTCud9ahfS3H8UMHI0
         fgxo4dvJlyX/LPXpR7XqKCtQFGzTgc1IdMurRv4dCTbX9rBC1X/RjCPa89UG/1953fGy
         nzxoC09+lxaYbN5zYrapRN2Km0E0adAhD45Sexunfv0N4qv2zvPi9XkLB8CT/Wmb/Avk
         YM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700574684; x=1701179484;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDIPScNOhQgHt38LsO0B0cG2vktuRay/6L9Ve7qh5S4=;
        b=KStqfYnd2OM96HngJMFfF0gUyN8ioXGFeS8w7yTv9zkTAP3jEi5mGJHyAYVXfGFm+g
         1Pk4ld/l80HkvLOd9/zc+rKoaxl/VkCDDWp/DeOVLfg0Q3mWfD7SD9IMyw7VAbHGHw2N
         miXOV/Vqx7mhNBD12A87aBRwgwUewzztKYUI3eTixlk2/gEJ5lSXk1S0P1joIvp6wSk5
         eJHmCOy3dkpBhODRKj0osl0BGU6Rz/DCn+SGJO3koiOiLpKYQE5UwY7jc6GK6fyOCCI8
         I1B8BC89tfm3h8wLbfmsuZSMvU81WO0z8byxOymRa0+c04mmuZG8/QiyE9tboF0OZjo0
         y2SA==
X-Gm-Message-State: AOJu0YwVmGcWQk+Yv0I9tIUSdDtfK0UtzWao+alWctqOWF5C5eyt4i6o
        gG+Zz6ExrkpUHOGMv4Deym/R/g==
X-Google-Smtp-Source: AGHT+IEiOEQRCCIIsEJWqvDWAnsZhFnAjvHgM81TfVQZ0BAQVqwSHAo5qQS47cbQLnp3B2WkNiRo6g==
X-Received: by 2002:a17:906:2254:b0:9bd:f155:eb54 with SMTP id 20-20020a170906225400b009bdf155eb54mr7451774ejr.6.1700574683829;
        Tue, 21 Nov 2023 05:51:23 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id y4-20020a170906470400b009fc54390966sm3314766ejq.145.2023.11.21.05.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 05:51:23 -0800 (PST)
Message-ID: <8d4e3fcb-2e4a-4580-9aa2-5acbed961c3f@linaro.org>
Date:   Tue, 21 Nov 2023 14:51:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] pinctrl: samsung: add exynosautov920 pinctrl
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231115095609.39883-1-jaewon02.kim@samsung.com>
 <CGME20231115095856epcas2p1c3ee85750828bec2ee4ab0adeaeaff28@epcas2p1.samsung.com>
 <20231115095609.39883-11-jaewon02.kim@samsung.com>
 <62b7176d-f99c-49f6-a287-17a6b3604c1c@linaro.org>
 <f0f6a7af-2170-89a2-1eea-dfb9d8440321@samsung.com>
 <6a5610e0-e60d-4ab7-8708-6f77a38527b7@linaro.org>
 <926ea5c5-20ac-5e63-16ea-6f0c20e2db0a@samsung.com>
 <0fdb7bec-9ea4-454f-a0fb-d450f27ebc6b@linaro.org>
 <ab17d61e-f645-9b76-962c-4ba2849c5f42@samsung.com>
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
In-Reply-To: <ab17d61e-f645-9b76-962c-4ba2849c5f42@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2023 08:43, Jaewon Kim wrote:
> 
> On 23. 11. 17. 19:48, Krzysztof Kozlowski wrote:
>> On 17/11/2023 08:36, Jaewon Kim wrote:
>>>>> The reason why I chose variable name 'combine' is that EINT registers was
>>>>> separated from gpio control address. However, in exynosautov920 EINT
>>>>> registers combined with GPx group. So I chose "combine" word.
>>>> What does it mean "the GPx group"? Combined means the same place, the
>>>> same register. I could imagine offset is 0x4, what I wrote last time.
>>>>
>>>> Is the offset 0x4?
> 
> If you are asking about the offset of GPIO control register and EINT 
> control register, 0x4 is correct.
> 
> There is no empty space between the two register.
> 
> 
> 0x0 CON
> 
> 0x4 DAT
> 
> 0x8 PUD
> 
> 0xc DRV
> 
> 0x10 CONPDN
> 
> 0x14 PUDPDN
> 
> 0x18 EINT_CON
> 
> 0x1c EINT_FLTCON
> 
> 0x20 or 0x24 EINT_MASK (The size of FLTCON register depending on the 
> number of gpio)
> 
> 0x24 or 0x28 EINT_PEND
> 
> 
>>>>
>>>>
>>>>> Is another reasonable word, I will change it.
>>>> Why you cannot store the offset?
>>>>
>>>>> EINT registers related to the entire group(e.g SVC) were at the end of
>>>>> the GPIO block and are now moved to 0xf000.
>>>> So not in the same register, not combined?
>>>>
>>> Okay,
>>>
>>> Instead of the word combine, I will think of a better word in next version.
>> I want to know answer to:
>>
>> "Why you cannot store the offset?"
>>
> I did not understand exactly what you said, but if i guess,,
> 
> you want to get rid of the offs because the value of the offs is always 
> the same?
> 
> #define EXYNOSV920_PIN_BANK_EINTG(pins, reg, id, offs, mask_offs, pend_offs)

I meant that it looks possible to store the offset and use it directly,
instead of storing bool telling that offset is different.

Best regards,
Krzysztof

