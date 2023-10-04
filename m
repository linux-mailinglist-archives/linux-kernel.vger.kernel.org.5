Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4313C7B83D6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242972AbjJDPkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjJDPkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:40:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEDFDD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:40:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a9f139cd94so388496166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696434016; x=1697038816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQbYtMW4LCkkodck3ws9wSHy7JaPhEuzh7xdIxRiRYU=;
        b=mYJpxuoggHefGQNhBe6eWYs5N4K5BV2YQHpuqsQGnzNJW87AY1HxSJKtKfVqzWozF6
         9ZERc2kdF10ahaGL5CxhrITT9qYsV+bBQ2UYBgcQM7u2FRk7kbQfE410kDZ5pty8Hl1I
         a+RUCnliQEmrrIJOcEa0y5Z9dm/C4FYrrDktLBhXBndUec2csryR9s0/458cHvod4bow
         SJeyBuH/vllrPZIhx1+jv+LN5PbF6nnXfuFwKZnlEORqWRklDIEIYmriqUGB+t+e5xNH
         fqsZMZdgUETYEb8rk1q1th7SNKrRoKKSdyDxdA/JdhlAdkisK6N3ktXXyMEq7FjjFU+b
         7iEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696434016; x=1697038816;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQbYtMW4LCkkodck3ws9wSHy7JaPhEuzh7xdIxRiRYU=;
        b=Ga7r5MI+AGYG4CYoPtUHpd2FpOJfUCtzkX7MXdCZcfWxk6KLt+LdEt+rqvaqNnK30a
         cOFbqmiFipyC+mCHLlU3U74m7Ysi7PV7w92l1dTQ+Orb/xhp7/q09V40xDDnFTqW2kwF
         /+FTrJGwesxGV+eP/+b14IwJm7XsytH1Be8C5h9X+Nbqxj7CKExr3yLZSuDLRHoZkDQZ
         wad0PFYfoe69BlKIeeeyIPaTsWl7TnAXDZiDtHE2OdVRVzSNWzy8SYMmR+qNHiXZlnzL
         m0/Zf6ZnYXaN4hMgLy5sm9KPNg54lL2pXdA4Se/M8Qc8Od7pOtj7AhzhiyHsiXaMYQBm
         FbdQ==
X-Gm-Message-State: AOJu0Yy0HuZsx6dI47rP/8nztzgJ5oEqkHUvQeArxprPhGcJ9Bika6WL
        K41vRAMvVW93QcLFEyVHy9Q9hg==
X-Google-Smtp-Source: AGHT+IHFk5kTObQeRMXLn9pv2SjxDecaH/q9uIjkh4pwphDKprs9rR9sRcZS+tCR6MYUCBqRoFuLAg==
X-Received: by 2002:a17:906:100e:b0:9b3:47f:1c05 with SMTP id 14-20020a170906100e00b009b3047f1c05mr2161562ejm.64.1696434016002;
        Wed, 04 Oct 2023 08:40:16 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id pk13-20020a170906d7ad00b0098f99048053sm3069748ejb.148.2023.10.04.08.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 08:40:15 -0700 (PDT)
Message-ID: <1b96bf8f-30c9-4bb1-93a0-0a498a04f5f0@linaro.org>
Date:   Wed, 4 Oct 2023 17:40:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: dts: omap4-embt2ws: Add Bluetooth
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231004070309.2408745-1-andreas@kemnade.info>
 <8e37d1ff-be19-4f70-a1a6-9a013a61782b@linaro.org>
 <20231004165314.1a9fb486@aktux> <20231004170021.36b32465@aktux>
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
In-Reply-To: <20231004170021.36b32465@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2023 17:00, Andreas Kemnade wrote:
> On Wed, 4 Oct 2023 16:53:14 +0200
> Andreas Kemnade <andreas@kemnade.info> wrote:
> 
>> Hi,
>>
>> On Wed, 4 Oct 2023 09:59:59 +0200
>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>
>> [...]
>>>> diff --git a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
>>>> index 46a80eacf771..6a790124bcf5 100644
>>>> --- a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
>>>> +++ b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
>>>> @@ -447,10 +447,12 @@ &uart2 {
>>>>  	interrupts-extended = <&wakeupgen GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH
>>>>  			       &omap4_pmx_core OMAP4_UART2_RX>;
>>>>  
>>>> -	/*
>>>> -	 * BT + GPS in WL1283 in WG7500 requiring CLK32KAUDIO of pmic
>>>> -	 * which does not have a driver
>>>> -	 */
>>>> +	bluetooth-gnss {    
>>>
>>> If you changed the bindings, please share a link. If not, this is not
>>> currently accepted and dtbs_check should point it out.
>>>   
>>
>> according to dtbs_check:
>>
>> good:
>> - bluetooth-gnss
>> - bluettooth-gnss
>>
>> bad:
>> - bluettooth-gnnss
>> - tiwi (still there in pandaboards)
>>
> The only authoritative source I find here:
>  Documentation/devicetree/bindings/serial/serial.yaml:
> patternProperties:
>   "^bluetooth|gnss|gps|mcu$":

Yes, it's about this one.

> 
> It allows:
>  everything starting with bluetooth
>  everything containing gnss
>  everything containing gps
>  everything ending with mcu
> 
> bluetooth-gnss starts with bluetooth, so it is allowed.
> Do you have anything else forbidding bluetooth-gnss?

Heh, the pattern is wrong. This should be originally:
"^(bluetooth|gnss|gps|mcu)$":

I can fix it and also allow your use case.

Best regards,
Krzysztof

