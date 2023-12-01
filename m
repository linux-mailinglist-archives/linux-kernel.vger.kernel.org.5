Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D179800A80
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378745AbjLAMKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378799AbjLAMKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:10:48 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F7710F3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:10:53 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54b532b261bso2516703a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 04:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701432652; x=1702037452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jf2VmZf9HW8ZFTDwybKL2Aiz279wqxhmPeD/Xu8cQLI=;
        b=MnxtsxiUiz/GhOwKBNdG6KG4HQwg3T/ziW6GSM28KBu/yLyeGIkRFWU2ldXGxZngUL
         wuTNlSmyYt/EbR0rjwhpdJlt8vZhV6OqGCUzXPygJLmfA/T65Yd0mS6KlVvBHNXJzqKr
         qd5zkqmhPqKNXeU2fDHM/eUY5k3tjOLL6qRSdjtsPRElmHrsx/8KsZ6gIo+7s/QTWtg5
         gOb7iK7WGuDUR2Hq+7xTZWrxxfJNLDac1a6p40VeTFbRgSMdruEEZ2N7ykJErefxB6cs
         Wqr/0JrUYyyJpN/LwJ1ZB/cEj3onO/Nwo+gJm85ef6KrxV1lVGZwdPX5w08rVONIp95F
         itxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701432652; x=1702037452;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jf2VmZf9HW8ZFTDwybKL2Aiz279wqxhmPeD/Xu8cQLI=;
        b=V4e968V0IrE69lfePu7bFOxg645NNfiZQwnpFVNdVD2esscLZdV0PtBMdyR7cYvoOW
         6+Q2jlOxLHKiJzKGHh6SjYoaDy/yP3T5wpPeCK67SEopdd24gEgQ5yQzGoksNIMsBJR6
         MYFNNwgfROnl9LODbMWomcfOVlFqwnaFCHcOlrhTffCM0fFSuigofugFdhWe7ndi40Dp
         if2YUOmfsTkdUEQvlxdqPIzt4XIbFIfITivRhXEc2vqQilGR3zdc/6jzPVTuaNy0o0pa
         q5/XRcki8vAzGXxXRSUhTzcI1fZoFRmxPz5Kd3BtCPMqRt4+5937k2X2d9IaqP6puNSR
         KqzQ==
X-Gm-Message-State: AOJu0YwOGKaz91ABHqxTtK5pP8v/MeEzEgcC7xTKPIhmFmtjGjH7MyCP
        LN9CxsZIria5ulFkq41NxlArPA==
X-Google-Smtp-Source: AGHT+IHj/IZeTxOoelk+biR29d4G6gz52/1zLRKvvFnhpTMkxNk9Q9LO5aApvxjhv9D8fbO0LV0QLw==
X-Received: by 2002:a50:a45c:0:b0:54c:62c5:7df6 with SMTP id v28-20020a50a45c000000b0054c62c57df6mr331702edb.47.1701432651951;
        Fri, 01 Dec 2023 04:10:51 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id s11-20020a05640217cb00b0054c6625511csm238967edy.28.2023.12.01.04.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 04:10:51 -0800 (PST)
Message-ID: <f844cd1e-7e4f-4836-bc9a-2e1ed13f064f@linaro.org>
Date:   Fri, 1 Dec 2023 13:10:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: phy: qcom,qmp: Add PCIe
 qcom,refclk-always-on property
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_vpernami@quicinc.com, quic_parass@quicinc.com
References: <20231127-refclk_always_on-v3-0-26d969fa8f1d@quicinc.com>
 <20231127-refclk_always_on-v3-1-26d969fa8f1d@quicinc.com>
 <78815f1b-7390-40de-8afd-ac71806f4051@linaro.org>
 <24fae40a-453b-b14c-923f-88758a246aa7@quicinc.com>
 <20231201060716.GJ4009@thinkpad>
 <166d307e-7d1b-48b5-90db-9b6df01d87c2@linaro.org>
 <20231201111033.GL4009@thinkpad>
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
In-Reply-To: <20231201111033.GL4009@thinkpad>
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

On 01/12/2023 12:10, Manivannan Sadhasivam wrote:
> On Fri, Dec 01, 2023 at 09:01:43AM +0100, Krzysztof Kozlowski wrote:
>> On 01/12/2023 07:07, Manivannan Sadhasivam wrote:
>>> On Tue, Nov 28, 2023 at 02:49:18PM +0530, Krishna Chaitanya Chundru wrote:
>>>>
>>>> On 11/28/2023 2:26 PM, Krzysztof Kozlowski wrote:
>>>>> On 27/11/2023 13:13, Krishna chaitanya chundru wrote:
>>>>>> Document qcom,refclk-always-on property which is needed in some platforms
>>>>>> to supply refclk even in PCIe low power states.
>>>>>>
>>>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>>>> ---
>>>>>>   .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml        | 7 +++++++
>>>>>>   1 file changed, 7 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
>>>>>> index 2c3d6553a7ba..c747c9f35795 100644
>>>>>> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
>>>>>> @@ -93,6 +93,13 @@ properties:
>>>>>>     "#phy-cells":
>>>>>>       const: 0
>>>>>> +  qcom,refclk-always-on:
>>>>>> +    type: boolean
>>>>>> +    description: In some platform where PCIe switch is connected, pcie switch due to some design
>>>>> You received a comment to use proper wrapping: 80. Please implement it.
>>>> I will update this.
>>>>>> +      limitation fails to propage clkreq signal to the host and due to that host will not send
>>>>>> +      refclk, which  results in linkdown in L1.2 or L1.1 exit initiated by EP.
>>>>>> +      This property if set keeps refclk always on even in Low power states.
>>>>> The property name suggests that's the state of hardware - refclk is
>>>>> always on. Description suggests you want to instruct OS to do something.
>>>>>
>>>>> Again, third time (once from Bjorn, once from Dmitry), rephrase property
>>>>> name and description to describe the hardware issue. I see description
>>>>> improved, but not the property name. Again in the end of description you
>>>>
>>>> Both bjorn and Dmitry gave comments to change the description only, and not
>>>> the property name,
>>>>
>>>> correct if I am wrong.
>>>>
>>>>> say what Linux should do. Bindings do not describe Linux OS.
>>>>
>>>> I will remove the last line in the next patch.
>>>>
>>>
>>> You should name the property as, "qcom,keep-refclk-always-on"
>>
>> Keep the clock by who? By driver? Then not, property should describe
>> physical phenomena or hardware issue being fixed here, not what driver
>> should do.
>>
> 
> This property indeed fixes the hardware issue (though in board level) and I see
> a plenty of properties similar to this one instructing the OS to keep some
> resource ON to workaround hardware issues. So they are all wrong?

What I said before:
"Again, third time (once from Bjorn, once from Dmitry), rephrase
property name and description to describe the hardware issue. I see
description improved, but not the property name. Again in the end of
description you say what Linux should do. Bindings do not describe Linux
OS."


Best regards,
Krzysztof

