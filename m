Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A667FEAD8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344918AbjK3IgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344955AbjK3IgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:36:06 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768B610F0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:36:12 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54bb5ebbb35so580297a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701333371; x=1701938171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ObsOROnpkbSezGJjA9kHVUriLkfnwLirBce/YF+bAkk=;
        b=FntZOjFL90ECUoyqY0YSJInC497hIF7Sc/JHJR3KywsUGmYVQheEXjYlB+1ZckmgbO
         qyD6kKrOdiBFXB8WLoOor6jUbRwOcDpzOvLREHplt5G0LbEepdzqUv8ylq03Upr5/5sq
         DHkrFg2cisk3VR9wUwXkjbClonbIsm/vMmNFYzlqivEa++NYyD26LQ2bL7Sk2chkf7bO
         K0U+7rScy6MaCpSt47l+aaYYl+cQqghfNXXj4kSIMLQYOrAYoNOmYiuING5VxyHBiIYV
         iIx0kSUYkZLOwhoKslOcsMz/5Ezn6rfs2UiAJGjDwWRxxQ/Apav7+bNeCGp2a8vrwzdh
         QZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701333371; x=1701938171;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObsOROnpkbSezGJjA9kHVUriLkfnwLirBce/YF+bAkk=;
        b=ErJr+bVGy8ki8jzjQOMihmGgbwCx8IKyWKeoqpxjudrd+/0N/C2Lp5B1cPEg+k3MzE
         4LXAQeNRf6zl9Bnc+gELKbhb/PSHaTYc2q+6l37xN+YGFEHxc2S0mJx0sq7CzSO7MROn
         VTgf534nVtipfOoTWCGdvJZCtahUAJEX+ESmI2CFTVxQ/97qL4hXyX8G7U4sneb+Y9pE
         yP3OWro0kB8LVpOtx6bJ8FWWrSfsWi4nT+IE11BdudEzmfcuH1hUSTZDe+Wg+/w77opw
         SdeDLmDEX8GXPSME+s0IJXh4T/VN1KLkFnmpQ4DdHb4h+3fnH1u1NcO4uJJIxLGfKEYn
         SqAg==
X-Gm-Message-State: AOJu0YxM3sfEzvmXUyMRwtSKm7kltYi0q/5MMgfSoQ4wiTrc0D+UDu3/
        /5tGDF+3KScx1qnhmuczL3yoBA==
X-Google-Smtp-Source: AGHT+IFijJ2dL0rrwFIC/oGgYn4XPWGR8i7aEz1lHlvxrn+1Mp6Ra089obwQTTw8dewalQdjd0NDCA==
X-Received: by 2002:a05:6402:520c:b0:54b:4067:6274 with SMTP id s12-20020a056402520c00b0054b40676274mr12578151edd.5.1701333370929;
        Thu, 30 Nov 2023 00:36:10 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id y24-20020a056402135800b00548d649f638sm313478edw.96.2023.11.30.00.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 00:36:10 -0800 (PST)
Message-ID: <e127dcef-3149-443a-9a8c-d24ef4054f09@linaro.org>
Date:   Thu, 30 Nov 2023 09:36:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] dt-bindings: pwm: amlogic: add new compatible for
 meson8 pwm type
Content-Language: en-US
To:     neil.armstrong@linaro.org, Jerome Brunet <jbrunet@baylibre.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        JunYi Zhao <junyi.zhao@amlogic.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
References: <20231129134004.3642121-1-jbrunet@baylibre.com>
 <20231129134004.3642121-3-jbrunet@baylibre.com>
 <8e78be99-3d4d-4f79-9791-404e60bcb67c@linaro.org>
 <1jfs0ojz1a.fsf@starbuckisacylon.baylibre.com>
 <11f8d986-3e97-4191-b46c-ad3166ee6dc7@linaro.org>
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
In-Reply-To: <11f8d986-3e97-4191-b46c-ad3166ee6dc7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2023 17:41, neil.armstrong@linaro.org wrote:
>>>>    .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 52 ++++++++++++++++---
>>>>    1 file changed, 46 insertions(+), 6 deletions(-)
>>>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>>>> b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>>>> index 387976ed36d5..eece390114a3 100644
>>>> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>>>> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>>>> @@ -21,23 +21,35 @@ properties:
>>>>              - amlogic,meson-g12a-ee-pwm
>>>>              - amlogic,meson-g12a-ao-pwm-ab
>>>>              - amlogic,meson-g12a-ao-pwm-cd
>>>> -          - amlogic,meson-s4-pwm
>>>> +        deprecated: true
>>>>          - items:
>>>>              - const: amlogic,meson-gx-pwm
>>>>              - const: amlogic,meson-gxbb-pwm
>>>> +        deprecated: true
>>>>          - items:
>>>>              - const: amlogic,meson-gx-ao-pwm
>>>>              - const: amlogic,meson-gxbb-ao-pwm
>>>> +        deprecated: true
>>>>          - items:
>>>>              - const: amlogic,meson8-pwm
>>>>              - const: amlogic,meson8b-pwm
>>>> +        deprecated: true
>>>
>>> I think deprecated should be moved in a third patch
>>
>> The complain on v2 was that it was not clear the new binding was making
>> the old one obsolete. It looked to me that the deprecation old bindings
>> needed to go together with the introduction of the new.
>>
>> I don't mind one way or the other
>>
>> Is there a rule somewhere about this ?
> 
> Not sure about that, I don't think it's a problem to have both valid
> at the same time, setting them deprecated afterwards looks cleaner
> to avoid mixing too much changes at the same time.

For me current order is correct and intuitive: you add new binding,
because old binding was wrong, so the old binding should be deprecated.
Otherwise you have a state with both new and old binding and one could
question - why did we need new binding? For dtschema it does not matter,
but it matters how we read the code.

Best regards,
Krzysztof

