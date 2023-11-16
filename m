Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867D77EDF92
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345068AbjKPLVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjKPLVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:21:40 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F7F187
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:21:36 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7b9ba0c07f9so249834241.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700133695; x=1700738495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZXK5ljOmLC8q/n/ipRKG6UVSniFiXFzXWXMyxjThqVI=;
        b=F/AcvQJifR1jQGpSCsjNwD5QZy8mU+VREtwilmfgz9WNIZaR/ng3kUne2RIAD401+m
         1j7CftIYesdWGPeLsczuGhVoQkFkqJ6mGN1xV18as+GCvOVR025IY9QQcl9nUVFgt7V6
         rAcISyGBdQ7Pxrz0S5WSzOJYAxbAkVFVU2009uAf//CyTqNrU00KRvA8dffLhGgiZJFS
         WYW5Lr18hHuYP6fMVdV9vohQEZvbTgwJKgIKtSttgoyoD0SfxwZ4tC4rSSWMA5pMnZNB
         hEGmUPJ0ltwcDOWbuzSZZV+c9pIqWecBXXd1UDPSR9hj3JTTbw3oj+H8dkEiYV2SPBc2
         uKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700133695; x=1700738495;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXK5ljOmLC8q/n/ipRKG6UVSniFiXFzXWXMyxjThqVI=;
        b=nIEPBFlV6Z1KIE39SUsJPDnzsRezxKOTN6tUlw70pXjrxpPdQLOIclMml2WA0jPg5h
         /D+rXkRFC8ikyFDZBdGDqkz18S2Cc2Qxh/HW+VjydrGZqpFSWFVymigJUDGCqLwGwEK0
         oVhTW+gI7M4+BOKI1gTibFulkj4endZ4Komm6YWnVhS7blYHOawgEftABw5h5odnQvg3
         5DHDXPATyunXHSKOskM00WQC53yATnB3KnjUWcbp3PTBuvcyIyAMdwkmodEG6NHrwXzn
         Efs2S0/BI9dA3xvYsAhKU9bkvxdFxyJ7/ePqNkwEz9hhcgvYG39eveI0HxM8vG5AUScZ
         uhCQ==
X-Gm-Message-State: AOJu0YzJcVw7sRQbomu7jEXD7FSOLVUYgYLLTS5mB1S9Bvf4FESocpnX
        ZOllUFCIyT42j4nA7l8YxlSbfg==
X-Google-Smtp-Source: AGHT+IGEq7QmMxK+xmYgKsdLFgf/U0ydWvmWMWZbION2HcLqt3BLTJsUueI2WBlrlfRqlufK4qZfEw==
X-Received: by 2002:a05:6102:4702:b0:45c:d357:290d with SMTP id ei2-20020a056102470200b0045cd357290dmr9426103vsb.14.1700133695039;
        Thu, 16 Nov 2023 03:21:35 -0800 (PST)
Received: from [192.168.212.13] ([12.191.197.195])
        by smtp.gmail.com with ESMTPSA id a17-20020a0cc591000000b0065b21f1b687sm1287878qvj.80.2023.11.16.03.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 03:21:34 -0800 (PST)
Message-ID: <6a5610e0-e60d-4ab7-8708-6f77a38527b7@linaro.org>
Date:   Thu, 16 Nov 2023 12:21:33 +0100
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
In-Reply-To: <f0f6a7af-2170-89a2-1eea-dfb9d8440321@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2023 06:39, Jaewon Kim wrote:
> On 23. 11. 15. 21:28, Krzysztof Kozlowski wrote:
> 
>> On 15/11/2023 10:56, Jaewon Kim wrote:
>>> ExynosAutov920 GPIO has a different register structure.
>>> In the existing Exynos series, EINT control register enumerated after
>>> a specific offset (e.g EXYNOS_GPIO_ECON_OFFSET).
>>> However, in ExynosAutov920 SoC, the register that controls EINT belongs
>>> to each GPIO group, and each GPIO group has 0x1000 align.
>>>
>>> This is a structure to protect the GPIO group with S2MPU in VM environment,
>>> and will only be applied in ExynosAuto series SoCs.
>>>
>>> Example)
>>> -------------------------------------------------
>>> | original		| ExynosAutov920	|
>>> |-----------------------------------------------|
>>> | 0x0	GPIO_CON	| 0x0	GPIO_CON	|
>>> | 0x4	GPIO_DAT	| 0x4	GPIO_DAT	|
>>> | 0x8	GPIO_PUD	| 0x8	GPIO_PUD	|
>>> | 0xc	GPIO_DRV	| 0xc	GPIO_DRV	|
>>> | 0x700	EINT_CON	| 0x18	EINT_CON	|
>>> | 0x800	EINT_FLTCON	| 0x1c	EINT_FLTCON0	|
>>> | 0x900	EINT_MASK	| 0x20	EINT_FLTCON1	|
>>> | 0xa00	EINT_PEND	| 0x24	EINT_MASK	|
>>> |			| 0x28	EINT_PEND	|
>>> -------------------------------------------------
>>>
>>> Pinctrl data for ExynosAutoV920 SoC.
>>>   - GPA0,GPA1 (10): External wake up interrupt
>>>   - GPQ0 (2): SPMI (PMIC I/F)
>>>   - GPB0,GPB1,GPB2,GPB3,GPB4,GPB5,GPB6 (47): I2S Audio
>>>   - GPH0,GPH1,GPH2,GPH3,GPH4,GPH5,GPH6,GPH8 (49): PCIE, UFS, Ethernet
>>>   - GPG0,GPG1,GPG2,GPG3,GPG4,GPG5 (29): General purpose
>>>   - GPP0,GPP1,GPP2,GPP3,GPP4,GPP5,GPP6,GPP7,GPP8,GPP9,GPP10 (77): USI
>>>
>>> Signed-off-by: Jaewon Kim<jaewon02.kim@samsung.com>
>>> ---
>>>   .../pinctrl/samsung/pinctrl-exynos-arm64.c    | 140 ++++++++++++++++++
>>>   drivers/pinctrl/samsung/pinctrl-exynos.c      | 102 ++++++++++++-
>>>   drivers/pinctrl/samsung/pinctrl-exynos.h      |  27 ++++
>>>   drivers/pinctrl/samsung/pinctrl-samsung.c     |   5 +
>>>   drivers/pinctrl/samsung/pinctrl-samsung.h     |  13 ++
>>>   5 files changed, 280 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
>>> index cb965cf93705..cf86722a70a3 100644
>>> --- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
>>> +++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
>>> @@ -796,3 +796,143 @@ const struct samsung_pinctrl_of_match_data fsd_of_data __initconst = {
>>>   	.ctrl		= fsd_pin_ctrl,
>>>   	.num_ctrl	= ARRAY_SIZE(fsd_pin_ctrl),
>>>   };
>>> +
>>> +/* pin banks of exynosautov920 pin-controller 0 (ALIVE) */
>>> +static struct samsung_pin_bank_data exynosautov920_pin_banks0[] = {
>> So you created patch from some downstream code? No, please work on
>> upstream. Take upstream code and customize it to your needs. That way
>> you won't introduce same mistakes fixes years ago.
>>
>> Missing const.
> 
> Thanks for the guide.
> 
> I didn`t work on downstream source, but when I copy/paste
> 
> the struct enumerations from downstream, it seemed like

That's what I am talking about. Don't do like this.

We fixed several things in Linux kernel, so copying unfixed code is
wasting of everyone's time. Don't work on downstream. Don't copy
anything from downstream. You *MUST CUSTOMIZE* upstream file, not
downstream.


> 
> 'const' was missing.
> 
>>
>> ...
>>
>>> @@ -31,6 +31,7 @@
>>>   #define EXYNOS7_WKUP_EMASK_OFFSET	0x900
>>>   #define EXYNOS7_WKUP_EPEND_OFFSET	0xA00
>>>   #define EXYNOS_SVC_OFFSET		0xB08
>>> +#define EXYNOSAUTOV920_SVC_OFFSET	0xF008
>>>   
>> ...
>>
>>>   #ifdef CONFIG_PINCTRL_S3C64XX
>>>   	{ .compatible = "samsung,s3c64xx-pinctrl",
>>> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
>>> index 9b3db50adef3..cbb78178651b 100644
>>> --- a/drivers/pinctrl/samsung/pinctrl-samsung.h
>>> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
>>> @@ -122,6 +122,9 @@ struct samsung_pin_bank_type {
>>>    * @eint_type: type of the external interrupt supported by the bank.
>>>    * @eint_mask: bit mask of pins which support EINT function.
>>>    * @eint_offset: SoC-specific EINT register or interrupt offset of bank.
>>> + * @mask_offset: SoC-specific EINT mask register offset of bank.
>>> + * @pend_offset: SoC-specific EINT pend register offset of bank.
>>> + * @combine: EINT register is adjacent to the GPIO control register.
>> I don't understand it. Adjacent? Are you sure? GPIO control register has
>> 0xF004 (EXYNOSAUTOV920_SVC_OFFSET + 0x4)? Anyway, this does not scale.
>> What if next revision comes with not-adjacent. There will be
>> "combine_plus"? Also name confuses me - combine means together.
>>
>> Also your first map of registers does not have it adjacent...
> 
> I think I should have added a little more information about new struct.
> 
> -------------------------------------------------
> | original             | ExynosAutov920         |
> |-----------------------------------------------|
> | 0x0   GPA_CON	       | 0x0    GPA_CON         |
> | 0x4   GPA_DAT	       | 0x4    GPA_DAT         |
> | 0x8   GPA_PUD	       | 0x8    GPA_PUD         |
> | 0xc   GPA_DRV	       | 0xc    GPA_DRV         |
> |----------------------| 0x18   EINT_GPA_CON    |
> | 0x20  GPB_CON        | 0x1c   EINT_GPA_FLTCON0|
> | 0x4   GPB_DAT	       | 0x20   EINT_GPA_FLTCON1|
> | 0x28  GPB_PUD	       | 0x24   EINT_GPA_MASK   |
> | 0x2c  GPB_DRV	       | 0x28   EINT_GPA_PEND   |
> |----------------------|------------------------|
> | 0x700	EINT_GPA_CON   | 0x1000 GPA_CON         |
> | 0x704	EINT_GPB_CON   | 0x1004 GPA_DAT         |
> |----------------------| 0x1008 GPA_PUD         |
> | 0x800	EINT_GPA_FLTCON| 0x100c GPA_DRV         |
> | 0x804	EINT_GPB_FLTCON| 0x1018 EINT_GPA_CON    |
> |----------------------| 0x101c EINT_GPA_FLTCON0|
> | 0x900	EINT_GPA_MASK  | 0x1020 EINT_GPA_FLTCON1|
> | 0x904	EINT_GPB_MASK  | 0x1024 EINT_GPA_MASK   |
> |----------------------| 0x1028 EINT_GPA_PEND   |
> | 0xa00	EINT_GPA_PEND  |------------------------|
> | 0xa04	EINT_GPB_PEND  |                        |
> ------------------------------------------------|
> | 0xb08 SVC            | 0xf008 SVC             |
> -------------------------------------------------
> 
> The reason why I chose variable name 'combine' is that EINT registers was
> separated from gpio control address. However, in exynosautov920 EINT
> registers combined with GPx group. So I chose "combine" word.

What does it mean "the GPx group"? Combined means the same place, the
same register. I could imagine offset is 0x4, what I wrote last time.

Is the offset 0x4?


> Is another reasonable word, I will change it.


Why you cannot store the offset?

> 
> EINT registers related to the entire group(e.g SVC) were at the end of
> the GPIO block and are now moved to 0xf000.

So not in the same register, not combined?

Best regards,
Krzysztof

