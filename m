Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBC27D2BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjJWHy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjJWHy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:54:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1297D66
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:54:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32d9b507b00so2202228f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698047692; x=1698652492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rMaoOLDHikI/5IuDdtds8W/NDUxXAWyZGF/MMCXM2nA=;
        b=Qoh9O+JbkgbFprxHO4DK4IVKmT9nfkQXK+tfqQVxOFFbn39fh6K70lJNIRSSFT1sHO
         z685AYRG8Oz0Ing3Qa/TcGr1vQyY8nVhioU8x9lZSAke6FN0mSGOiCNVTBiY/F6uoO8s
         rYN/CQfmkLTjHsEzgVpXHTHHgHrgCzU48EyT9h06/L0bzVHFGSriUhIQSt+Ogyj5fcQl
         mbSW9oYE8ylI0nEtRtEGCm1bJafHzbSoaCRDkZ2QGD+fKB26c/6rZHYAtDetm5vmj3Nb
         J4P9pyIXjci/wLGRqgpkHJyFDbGyn48mQRXNRAw9/s6TwXAdQHPAeGBqgmtBRhexthC4
         GR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698047692; x=1698652492;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rMaoOLDHikI/5IuDdtds8W/NDUxXAWyZGF/MMCXM2nA=;
        b=fsh44FK3jv9LsGl6dcW0zBUoGEvd6JU5ijEbDy/9cu2ZM6PcqfC9p/qHLYbkX2Tcbk
         4OP6CDfAeAK2VAOVucu/afmlSUKkFqFSpC51PSB3oiAgizv6R3bhKx1EXM0XF7O2Di8s
         UAac2d+7qYLCaQa2wN5oqbON3dQolqas3feL8a4Q6Le06wEAegrlbStHg0moaGQnEHrg
         yEMHGcyatAEsGGcuGV9IamjfAAwviMKNHIP/TK2bQ0pxGTDC8mg8PprzXfKpK8EYdB+W
         QBwxa251w0tSpXbREDpjTM60OwE/G/mhPBBw14uzilH9ZTAVCSS5BmVDejPyPIgUSW1J
         +vOg==
X-Gm-Message-State: AOJu0Yz+1qlho+wakt573p08Umc3t7Sx2WloP3xFpE6KTXWOY5u+HUcY
        471FCck0fFVDhlggu8Sex/YpFA==
X-Google-Smtp-Source: AGHT+IEkteDAolzqk7c1xG62bF49OpbK8KsUBZfD4/K3b2DSE56KTe0ex5sjw+KyfZnzIGJV6K8LDQ==
X-Received: by 2002:adf:ea4e:0:b0:319:7c0f:d920 with SMTP id j14-20020adfea4e000000b003197c0fd920mr6426606wrn.57.1698047692077;
        Mon, 23 Oct 2023 00:54:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d4291000000b0032da87e32e2sm7230065wrq.4.2023.10.23.00.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 00:54:51 -0700 (PDT)
Message-ID: <3df06d79-ea51-4202-8cc8-468f741603bf@linaro.org>
Date:   Mon, 23 Oct 2023 09:54:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: clock: brcm,kona-ccu: convert to YAML
Content-Language: en-US
To:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Weber <aweber.kernel@gmail.com>
References: <ZTUIJrTc6KKyT4xj@standask-GA-A55M-S2HP>
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
In-Reply-To: <ZTUIJrTc6KKyT4xj@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2023 13:31, Stanislav Jakubek wrote:
> Convert Broadcom Kona family clock controller unit (CCU) bindings
> to DT schema.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

Thank you for your patch. There is something to discuss/improve.

> +description:
> +  Broadcom "Kona" style clock control unit (CCU) is a clock provider that
> +  manages a set of clock signals.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,bcm11351-aon-ccu
> +      - brcm,bcm11351-hub-ccu
> +      - brcm,bcm11351-master-ccu
> +      - brcm,bcm11351-root-ccu
> +      - brcm,bcm11351-slave-ccu
> +      - brcm,bcm21664-aon-ccu
> +      - brcm,bcm21664-master-ccu
> +      - brcm,bcm21664-root-ccu
> +      - brcm,bcm21664-slave-ccu
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  clock-output-names:
> +    minItems: 1
> +    maxItems: 10
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - brcm,bcm11351-aon-ccu
> +              - brcm,bcm11351-hub-ccu
> +              - brcm,bcm11351-master-ccu
> +              - brcm,bcm11351-root-ccu
> +              - brcm,bcm11351-slave-ccu
> +    then:
> +      properties:
> +        clock-output-names:
> +          description: |
> +            The following table defines the set of CCUs and clock specifiers
> +            for BCM281XX family clocks.
> +            These clock specifiers are defined in:
> +                "include/dt-bindings/clock/bcm281xx.h"
> +
> +            CCU     Clock        Type  Index  Specifier
> +            ---     -----        ----  -----  ---------
> +            root    frac_1m      peri    0    BCM281XX_ROOT_CCU_FRAC_1M
> +
> +            aon     hub_timer    peri    0    BCM281XX_AON_CCU_HUB_TIMER
> +            aon     pmu_bsc      peri    1    BCM281XX_AON_CCU_PMU_BSC
> +            aon     pmu_bsc_var  peri    2    BCM281XX_AON_CCU_PMU_BSC_VAR
> +
> +            hub     tmon_1m      peri    0    BCM281XX_HUB_CCU_TMON_1M
> +
> +            master  sdio1        peri    0    BCM281XX_MASTER_CCU_SDIO1
> +            master  sdio2        peri    1    BCM281XX_MASTER_CCU_SDIO2
> +            master  sdio3        peri    2    BCM281XX_MASTER_CCU_SDIO3
> +            master  sdio4        peri    3    BCM281XX_MASTER_CCU_SDIO4
> +            master  dmac         peri    4    BCM281XX_MASTER_CCU_DMAC
> +            master  usb_ic       peri    5    BCM281XX_MASTER_CCU_USB_IC
> +            master  hsic2_48m    peri    6    BCM281XX_MASTER_CCU_HSIC_48M
> +            master  hsic2_12m    peri    7    BCM281XX_MASTER_CCU_HSIC_12M
> +
> +            slave   uartb        peri    0    BCM281XX_SLAVE_CCU_UARTB
> +            slave   uartb2       peri    1    BCM281XX_SLAVE_CCU_UARTB2
> +            slave   uartb3       peri    2    BCM281XX_SLAVE_CCU_UARTB3
> +            slave   uartb4       peri    3    BCM281XX_SLAVE_CCU_UARTB4
> +            slave   ssp0         peri    4    BCM281XX_SLAVE_CCU_SSP0
> +            slave   ssp2         peri    5    BCM281XX_SLAVE_CCU_SSP2
> +            slave   bsc1         peri    6    BCM281XX_SLAVE_CCU_BSC1
> +            slave   bsc2         peri    7    BCM281XX_SLAVE_CCU_BSC2
> +            slave   bsc3         peri    8    BCM281XX_SLAVE_CCU_BSC3
> +            slave   pwm          peri    9    BCM281XX_SLAVE_CCU_PWM

I don't really understand why this is in the binding schema. I guess you
wanted to copy it from the old binding, but, unless there is real reason
for it, don't. The clock IDs should be in the header file and that's it.
Nothing here.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - brcm,bcm21664-aon-ccu
> +              - brcm,bcm21664-master-ccu
> +              - brcm,bcm21664-root-ccu
> +              - brcm,bcm21664-slave-ccu
> +    then:
> +      properties:
> +        clock-output-names:
> +          maxItems: 8
> +          description: |
> +            The following table defines the set of CCUs and clock specifiers
> +            for BCM21664 family clocks.
> +            These clock specifiers are defined in:
> +                "include/dt-bindings/clock/bcm21664.h"
> +
> +            CCU     Clock         Type  Index  Specifier
> +            ---     -----         ----  -----  ---------
> +            root    frac_1m       peri    0    BCM21664_ROOT_CCU_FRAC_1M
> +
> +            aon     hub_timer     peri    0    BCM21664_AON_CCU_HUB_TIMER
> +
> +            master  sdio1         peri    0    BCM21664_MASTER_CCU_SDIO1
> +            master  sdio2         peri    1    BCM21664_MASTER_CCU_SDIO2
> +            master  sdio3         peri    2    BCM21664_MASTER_CCU_SDIO3
> +            master  sdio4         peri    3    BCM21664_MASTER_CCU_SDIO4
> +            master  sdio1_sleep   peri    4    BCM21664_MASTER_CCU_SDIO1_SLEEP
> +            master  sdio2_sleep   peri    5    BCM21664_MASTER_CCU_SDIO2_SLEEP
> +            master  sdio3_sleep   peri    6    BCM21664_MASTER_CCU_SDIO3_SLEEP
> +            master  sdio4_sleep   peri    7    BCM21664_MASTER_CCU_SDIO4_SLEEP
> +
> +            slave   uartb         peri    0    BCM21664_SLAVE_CCU_UARTB
> +            slave   uartb2        peri    1    BCM21664_SLAVE_CCU_UARTB2
> +            slave   uartb3        peri    2    BCM21664_SLAVE_CCU_UARTB3
> +            slave   uartb4        peri    3    BCM21664_SLAVE_CCU_UARTB4
> +            slave   bsc1          peri    4    BCM21664_SLAVE_CCU_BSC1
> +            slave   bsc2          peri    5    BCM21664_SLAVE_CCU_BSC2
> +            slave   bsc3          peri    6    BCM21664_SLAVE_CCU_BSC3
> +            slave   bsc4          peri    7    BCM21664_SLAVE_CCU_BSC4

Same comments.

In any case, allOf: goes after required: block.

> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +  - clock-output-names
> +
> +additionalProperties: false
> +
Best regards,
Krzysztof

