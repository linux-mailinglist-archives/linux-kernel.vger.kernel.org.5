Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E65A7D4884
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjJXH2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjJXH2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:28:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13AA128
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:28:29 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso6445282a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698132508; x=1698737308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZnZkVrsoY7zwDrGLoc+7S+JxSd/YvHNPT4sbpJbAdmQ=;
        b=dDsUthjjtHEOMi5I2il5N0gd2FTSGgy8UJIt0hWaRx0noKuwF9hFIsfHPsP9xRJC/i
         tmY07UGLg2wS8TSnzxT9Tvpdp/qnd7scRR1uCRwvi0o+aAdsm/jgWMdlRXII66U6PV3F
         A5mJnkDhqWyTNWiBCXArdLYr1zGYAV2yPDM6cD+6f01h9YLKdH6FOur/Kw51/VDUJqOX
         5KYAohzbVfjbz7oWGhN81gbuhHCbLHeeHqOsTa5pCSf1JOFRByY3nnJlXX4ocNaAmzWx
         sqcPoVEx4pNFqLHg2jFA/4Wxd4yNpW1bOrAnbBiiWYErpmuPQpjeq/XQ9bmc47jn36cd
         CQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698132508; x=1698737308;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnZkVrsoY7zwDrGLoc+7S+JxSd/YvHNPT4sbpJbAdmQ=;
        b=XDQUCQncKxmDzhfbiYshjLGlpJzL4gwIqptnCODCmnB+hR9gd8Xb/JkBNUUWXwKlrA
         idUmcrT1rIuVCE13ULI2RfHhqLvjsJfw7IIcdz3cFe++HvaTleAhfKBBdmbd7ooBdd4/
         ntqt6ElJ1sKZ8pw9oW9PRvuc5IgnSTQOsas7u8FHxZP9mVGePXIty7ti22zsZ0KfvOs3
         bRXN9W9mOweBt1cZ3xICHyyM1LLmWf+DUuCZzvovSuIvgQZVwsCSJmBdS+6zgPUL5++T
         rBGaN1vgrSuYT6on3s9/k6o/skYqVMmXIN/1rem/2swzZiTmy8YKc8X/BdKODx8Gno8o
         JajA==
X-Gm-Message-State: AOJu0YzLGVJRoFhiCoNmtvRukXLcolwkxgfsVeNfuNcw9Z8PfY1I3j7l
        SHJDw0AZqbLAc94SdVacNjT3+g==
X-Google-Smtp-Source: AGHT+IFRlwdu+2MJ0YreEpllmOwZWoeIxrBcI5UwTltE2GQbYThynHTGHulOhHfnuFsX0GObLJJulQ==
X-Received: by 2002:a50:d756:0:b0:53d:a1c0:410e with SMTP id i22-20020a50d756000000b0053da1c0410emr7399614edj.7.1698132508068;
        Tue, 24 Oct 2023 00:28:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id ec31-20020a0564020d5f00b00530a9488623sm7426096edb.46.2023.10.24.00.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 00:28:27 -0700 (PDT)
Message-ID: <958604e1-bfb0-4b9e-bf7c-a9345f3978ae@linaro.org>
Date:   Tue, 24 Oct 2023 09:28:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: clock: brcm,kona-ccu: convert to YAML
Content-Language: en-US
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Weber <aweber.kernel@gmail.com>
References: <ZTUIJrTc6KKyT4xj@standask-GA-A55M-S2HP>
 <3df06d79-ea51-4202-8cc8-468f741603bf@linaro.org>
 <ZTbU0rkGMhja+J24@standask-GA-A55M-S2HP>
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
In-Reply-To: <ZTbU0rkGMhja+J24@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2023 22:17, Stanislav Jakubek wrote:
> On Mon, Oct 23, 2023 at 09:54:49AM +0200, Krzysztof Kozlowski wrote:
>> On 22/10/2023 13:31, Stanislav Jakubek wrote:
>>> Convert Broadcom Kona family clock controller unit (CCU) bindings
>>> to DT schema.
>>>
>>> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>> +description:
>>> +  Broadcom "Kona" style clock control unit (CCU) is a clock provider that
>>> +  manages a set of clock signals.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - brcm,bcm11351-aon-ccu
>>> +      - brcm,bcm11351-hub-ccu
>>> +      - brcm,bcm11351-master-ccu
>>> +      - brcm,bcm11351-root-ccu
>>> +      - brcm,bcm11351-slave-ccu
>>> +      - brcm,bcm21664-aon-ccu
>>> +      - brcm,bcm21664-master-ccu
>>> +      - brcm,bcm21664-root-ccu
>>> +      - brcm,bcm21664-slave-ccu
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  '#clock-cells':
>>> +    const: 1
>>> +
>>> +  clock-output-names:
>>> +    minItems: 1
>>> +    maxItems: 10
>>> +
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - brcm,bcm11351-aon-ccu
>>> +              - brcm,bcm11351-hub-ccu
>>> +              - brcm,bcm11351-master-ccu
>>> +              - brcm,bcm11351-root-ccu
>>> +              - brcm,bcm11351-slave-ccu
>>> +    then:
>>> +      properties:
>>> +        clock-output-names:
>>> +          description: |
>>> +            The following table defines the set of CCUs and clock specifiers
>>> +            for BCM281XX family clocks.
>>> +            These clock specifiers are defined in:
>>> +                "include/dt-bindings/clock/bcm281xx.h"
>>> +
>>> +            CCU     Clock        Type  Index  Specifier
>>> +            ---     -----        ----  -----  ---------
>>> +            root    frac_1m      peri    0    BCM281XX_ROOT_CCU_FRAC_1M
>>> +
>>> +            aon     hub_timer    peri    0    BCM281XX_AON_CCU_HUB_TIMER
>>> +            aon     pmu_bsc      peri    1    BCM281XX_AON_CCU_PMU_BSC
>>> +            aon     pmu_bsc_var  peri    2    BCM281XX_AON_CCU_PMU_BSC_VAR
>>> +
>>> +            hub     tmon_1m      peri    0    BCM281XX_HUB_CCU_TMON_1M
>>> +
>>> +            master  sdio1        peri    0    BCM281XX_MASTER_CCU_SDIO1
>>> +            master  sdio2        peri    1    BCM281XX_MASTER_CCU_SDIO2
>>> +            master  sdio3        peri    2    BCM281XX_MASTER_CCU_SDIO3
>>> +            master  sdio4        peri    3    BCM281XX_MASTER_CCU_SDIO4
>>> +            master  dmac         peri    4    BCM281XX_MASTER_CCU_DMAC
>>> +            master  usb_ic       peri    5    BCM281XX_MASTER_CCU_USB_IC
>>> +            master  hsic2_48m    peri    6    BCM281XX_MASTER_CCU_HSIC_48M
>>> +            master  hsic2_12m    peri    7    BCM281XX_MASTER_CCU_HSIC_12M
>>> +
>>> +            slave   uartb        peri    0    BCM281XX_SLAVE_CCU_UARTB
>>> +            slave   uartb2       peri    1    BCM281XX_SLAVE_CCU_UARTB2
>>> +            slave   uartb3       peri    2    BCM281XX_SLAVE_CCU_UARTB3
>>> +            slave   uartb4       peri    3    BCM281XX_SLAVE_CCU_UARTB4
>>> +            slave   ssp0         peri    4    BCM281XX_SLAVE_CCU_SSP0
>>> +            slave   ssp2         peri    5    BCM281XX_SLAVE_CCU_SSP2
>>> +            slave   bsc1         peri    6    BCM281XX_SLAVE_CCU_BSC1
>>> +            slave   bsc2         peri    7    BCM281XX_SLAVE_CCU_BSC2
>>> +            slave   bsc3         peri    8    BCM281XX_SLAVE_CCU_BSC3
>>> +            slave   pwm          peri    9    BCM281XX_SLAVE_CCU_PWM
>>
>> I don't really understand why this is in the binding schema. I guess you
>> wanted to copy it from the old binding, but, unless there is real reason
>> for it, don't. The clock IDs should be in the header file and that's it.
>> Nothing here.
> 
> Hi Krzysztof, you're correct that I just copied this from the old bindings.
> brcm,iproc-clocks.yaml has a similar table, so I thought this would be fine.
> I'm OK with dropping it, but how should I document the clock-output-names
> values then?

Your schema does not document them, so I don't understand what would you
loose.

> A bunch of if-then blocks (per compatible)? Or should I not even
> bother and just keep minItems/maxItems without documenting the values?

But what do you want to document exactly? Only number of items is
reasonable to constrain and it can be done with if:then blocks.


> 
>>
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - brcm,bcm21664-aon-ccu
>>> +              - brcm,bcm21664-master-ccu
>>> +              - brcm,bcm21664-root-ccu
>>> +              - brcm,bcm21664-slave-ccu
>>> +    then:
>>> +      properties:
>>> +        clock-output-names:
>>> +          maxItems: 8
> 
> I've also noticed that dtbs_check gives out warnings(?) like this for
> bcm21664 ccu nodes:
> 
> /arch/arm/boot/dts/broadcom/bcm21664-garnet.dtb:
>     root_ccu@35001000: clock-output-names: ['frac_1m'] is too short
>     from schema $id: http://devicetree.org/schemas/clock/brcm,kona-ccu.yaml#
> 
> and this maxItems:8 seems to me like the culprit (since the bcm11351 if-then
> doesn't have that). Seems to me like it also overrides the minItems to be 8
> as well. I don't understand why it would do that though.
> 
> I suppose just adding minItems: 1 would be the correct fix in this case?

https://elixir.bootlin.com/linux/v5.19-rc6/source/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml#L57


Best regards,
Krzysztof

