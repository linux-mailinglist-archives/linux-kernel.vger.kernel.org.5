Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5560C7F4EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343687AbjKVSBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjKVSBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:01:08 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853591A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 10:01:02 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c88750e7d1so520441fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 10:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700676061; x=1701280861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rlcXNO/YvL3pSI78Gj8bkvzKJ+5tSLbCTyvm7rSGCSA=;
        b=H9TeY57mD3nH2Bk3CTptf8aTPd8RZHJEA4f21RuuvVySO82XUuh8lD+nu7rZXMFCVK
         XJYAdKl8gJV8DiF+jQ724HFyQet2qwMq6POws0DfTxsJAkAqqEwkLKLR3edd2t1Uzitl
         cD10oJQPmbO16UXz3/2hLusOFAPaa0DngUUUgITURfSREgkh8v0958t1S6s093/2VNAE
         vGfi+jIo7ggnF6P9L4WIuHj8/IPxATjD+SXTLdAeLJBcLNsvJjImyqtdtU0LqLCoNA7Q
         NPdIk5G3zaMgRcJ9uqooFgocetWYX2eCYMRJShSMKb90vvMxk4c++u/NR0vB45hOTM54
         AY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700676061; x=1701280861;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlcXNO/YvL3pSI78Gj8bkvzKJ+5tSLbCTyvm7rSGCSA=;
        b=OOiC4Z+ecBWhi76gXcwYdG6p4DC8q5+IqDVyvomk/Rsob2Bt9yRyU//Yj0ti4Zhoul
         4p6vCCX4aoJunOjXkeVoZTAH2G28UdrgHcTyItrDpFi4Bcghr7nzW17yK6eFu2be9Yfo
         p0gquSRC608ylZJtw5uS8iQ2cmVtZz/PBiqLpqAeSoi4xF95Gm67jDOCgrM1zjDvMx+Q
         6YJNkvaHPxt7nNBPzLD7vwUZ3xrSdjnqI5B8vGd5V2ph5mh9HMVazEKtPGe/RhOXmKKH
         YXT5UmfgHS6UHnkJGCPHIScbGhI7LVtil4PxZi6XNEtV98D22TiwZY3W1SnoBkY+6hHG
         x54A==
X-Gm-Message-State: AOJu0YyQfemyfeDuN3M8gjl1IRoIPJPoktRxWrPRYuC0zOVtY2+pHOJy
        f5T/vFz4ujmhOVtFqrcAEaHAmg==
X-Google-Smtp-Source: AGHT+IFbREYSh29YxeVAt614vvr3qCBOOQFTQ1/HhijMTVOznlhfY7VnGhWGWbXDpBW2boRSndVpsg==
X-Received: by 2002:a2e:be09:0:b0:2c6:ed3a:73ee with SMTP id z9-20020a2ebe09000000b002c6ed3a73eemr2195620ljq.7.1700676058610;
        Wed, 22 Nov 2023 10:00:58 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c468500b004063d8b43e7sm150990wmo.48.2023.11.22.10.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 10:00:57 -0800 (PST)
Message-ID: <40afeed9-8780-47fa-ac20-6191dd05b239@linaro.org>
Date:   Wed, 22 Nov 2023 19:00:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <fd5c7d9f-a52b-4abb-a0d4-f5bdf2a669de@linaro.org>
 <1c016987-da88-47f2-bc1b-fcbe4c71a5c9@rasmusvillemoes.dk>
 <67a2cea0-f2de-4e7d-bc9d-ae29885f9210@linaro.org>
 <83eeb98d-ea56-4f7c-bed9-fe09aaa4cf7a@rasmusvillemoes.dk>
Content-Language: en-US
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
In-Reply-To: <83eeb98d-ea56-4f7c-bed9-fe09aaa4cf7a@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2023 10:28, Rasmus Villemoes wrote:
> On 21/11/2023 09.34, Krzysztof Kozlowski wrote:
>> On 21/11/2023 09:27, Rasmus Villemoes wrote:
>>> On 21/11/2023 08.52, Krzysztof Kozlowski wrote:
> 
>>>> Anyway, similar comments: this does not look like generic RS485
>>>> property. Are you saying that standard defines such GPIO?
>>>
>>> No, I'm saying that several boards that exist in the wild have the
>>> RX/TX/CTS etc. pins routed to a multiplexer, which in turn routes those
>>> signals to either a rs485 transceiver or an rs232 driver (and those in
>>> turn are connected to different screw terminals). So no, it's not a
>>> property of the rs485 protocol itself, but very much related to making
>>> use of rs485 (and rs232, though of course not simultaneously) on such
>>> boards.
>>
>> Which upstream boards use it?
> 
> None, because the binding doesn't exist.
> 
>> To me it looks like specific to each controller, not to RS485.
> 
> What do you mean "controller"? It's not specific to one particular
> SOC/IP, any uart IP capable of both rs232 and rs485 could be wired to
> circuitry like this.
> 
>>> Would a link to a schematic help?
>>
>> Yes, always :)
> 
> https://ibb.co/B3gzySt
> 
> The UART1.* signals on the right are from the SOC (in this case an
> imx8mp, but I know of other boards e.g. based on powerpc that use a
> similar scheme), and the COM1_Sel is just some gpio. The multiplexer is
> roughly in the middle (U2103).
> 
> As you can see, if one wants to talk rs485, one must set COM1_Sel low
> (and that works just fine by describing the rs485-mux-gpio as
> ACTIVE_LOW), and if one wants to talk rs232, it must be set high. While
> userspace could be tasked with knowing about and handling that gpio on
> top of the ioctl() for switching mode, this really seems like the kind
> of thing that DT is supposed to describe and the kernel is supposed to
> handle.

Yep, the trouble is only the placement. This GPIO mux is neither part of
the UART controller nor connector. Usually such pins in static
configuration are described either as GPIO hogs or as pinctrl. I guess
this matches other GPIOs in that binding, so I think it is fine. You
still though should answer to comments from other folks, including
multiple-GPIO case and mux.

Best regards,
Krzysztof

