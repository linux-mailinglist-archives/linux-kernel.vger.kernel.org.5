Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6CE7B60CB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 08:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239152AbjJCGbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 02:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjJCGbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 02:31:38 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C901B7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 23:31:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c3c8adb27so90405066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 23:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696314694; x=1696919494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wl4i5GUbRFBV0EmtTs7RvF9qxfnbhF5NMh+Rtk9x0rg=;
        b=u7ld3tyIrOmvYVns9yqh99UZ9l6ztFLhnrTj54n70BdJxacliAZJ0GogKajH/nEA8O
         Pa6cMf3kenQQeh4Iu10mfYYm7h83aTjY0Cqftkj6wMsVqpwPRKvsMLC/5s2BJ8npIyaR
         zcFTiYDDSmuX6EnvfEyIx4c4Bi44wmhPcnOZw1ZqorNZdwl384V8sdcK3Z/ScN6BuxNM
         Eg57arBEkFT1SjJTdHB7UDIHa2qO3ucQwtJBMacEm1MkgqTVGSXeAcbBFo4o+89RhF6m
         UhtxN/vSLbQ2FdGzAhn4r9MMWIR3YrjP4IWgxaV0ZMUrufGPJpUn8ghF4XzguD+t8Hkj
         /38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696314694; x=1696919494;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl4i5GUbRFBV0EmtTs7RvF9qxfnbhF5NMh+Rtk9x0rg=;
        b=cHvaOroAclPckulSBuS3uNAXr7Ei+9HxdbjOXTaxiRDbv5vauc/SDy4zrvx3CxKNt5
         wS2PHzroeXsfR+W0DqYsqPxrPhEAtGHBcFiaUvR4vGdRbtClrCLzV1ZVsAE/xOXGo7Gi
         B/I+ccpPcBBiYGaRa+BF+3r04GeFNXUq9xgRjLhLgcuFSAjPozM8TwHhI6AlZJyDLl6O
         cKKWOkJY3YSloCQhS7ptbdVnb6baO/C35cZZlUzbMtQWBElO4uClcNCNPU7n+3n0nqAm
         lSYcqdWrFY0IxuX992fxtj1dEP/+kaoqulb/KVWjMSl6ahyXG9ZskLhfW/eocLari87c
         e3yQ==
X-Gm-Message-State: AOJu0YyEcuyoGYxmYu/wI0obUMlTtM+ANl0bjKpDDBWrpNjrm+ya+Gkj
        khOzFYGNHxijsT7/J1q9UPGEiCXlu9h3KeCe08V5H4xf
X-Google-Smtp-Source: AGHT+IHGAfxeGSub9yo0QsL2dKbBPljLcG5xqC2yNoJOX9V9HSYEcaoKAlI2IoUckhTd4A9C1tsAuQ==
X-Received: by 2002:a17:906:8a74:b0:9ae:3e72:7c72 with SMTP id hy20-20020a1709068a7400b009ae3e727c72mr10215436ejc.58.1696314694088;
        Mon, 02 Oct 2023 23:31:34 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id h22-20020a17090619d600b009ad8796a6aesm483673ejd.56.2023.10.02.23.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 23:31:33 -0700 (PDT)
Message-ID: <fa467359-85d6-4847-b956-db793811d304@linaro.org>
Date:   Tue, 3 Oct 2023 08:31:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH 1/7] dt-bindings: arm: coresight-tmc: Add
 "memory-region" property
Content-Language: en-US
To:     Linu Cherian <lcherian@marvell.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>
References: <20230929133754.857678-1-lcherian@marvell.com>
 <20230929133754.857678-2-lcherian@marvell.com>
 <e5663ac2-e197-4667-8c70-28951628920a@linaro.org>
 <PH0PR18MB50028D5A8AA48036974D45A2CEC4A@PH0PR18MB5002.namprd18.prod.outlook.com>
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
In-Reply-To: <PH0PR18MB50028D5A8AA48036974D45A2CEC4A@PH0PR18MB5002.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2023 06:33, Linu Cherian wrote:
> Hi Krzysztof,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Saturday, September 30, 2023 8:59 PM
>> To: Linu Cherian <lcherian@marvell.com>; suzuki.poulose@arm.com;
>> mike.leach@linaro.org; james.clark@arm.com; leo.yan@linaro.org
>> Cc: linux-arm-kernel@lists.infradead.org; coresight@lists.linaro.org; linux-
>> kernel@vger.kernel.org; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>> devicetree@vger.kernel.org; Sunil Kovvuri Goutham
>> <sgoutham@marvell.com>; George Cherian <gcherian@marvell.com>
>> Subject: [EXT] Re: [PATCH 1/7] dt-bindings: arm: coresight-tmc: Add
>> "memory-region" property
>>
>> External Email
>>
>> ----------------------------------------------------------------------
>> On 29/09/2023 15:37, Linu Cherian wrote:
>>> memory-region 0: Reserved trace buffer memory
>>>
>>>   TMC ETR: When available, use this reserved memory region for
>>>   trace data capture. Same region is used for trace data
>>>   retention after a panic or watchdog reset.
>>>
>>>   TMC ETF: When available, use this reserved memory region for
>>>   trace data retention synced from internal SRAM after a panic or
>>>   watchdog reset.
>>>
>>> memory-region 1: Reserved meta data memory
>>>
>>>   TMC ETR, ETF: When available, use this memory for register
>>>   snapshot retention synced from hardware registers after a panic
>>>   or watchdog reset.
>>>
>>> Signed-off-by: Linu Cherian <lcherian@marvell.com>
>>> ---
>>
>> Where is the changelog? This is supposed to be v4 or something later.
>> Please, keep proper versioning and changelog.
> 
> Sure, will add the changelog from next version onwards. 
> 
> Yeah, the last version was RFC v3 and the RFC tag has been dropped from this version onwards.
> Hence started this version with V1.

v1 says it is the first version, but you already had three others.
Please keep continuous version log, regardless whether you call it RFC
or RFT or RFsomething.

> 
>>
>>>  .../bindings/arm/arm,coresight-tmc.yaml       | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>

Best regards,
Krzysztof

