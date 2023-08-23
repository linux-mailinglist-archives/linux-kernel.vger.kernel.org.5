Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC22785450
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbjHWJex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjHWJdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:33:50 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6031C26BB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:22:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31c4d5bd69cso2647575f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692782521; x=1693387321;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbc7sX2EtFFZTG3RE5OjMadql9NjkQKNUCzLFcKCo2g=;
        b=FY8J5WaYd9D/RzmqC4Qc7wYRQOmow5Y8h8yQi5XNks6qc4HbuKem9l5ZYRWPQPlBe5
         tyynNAfx1FbPvgf5ogSE2qKPN2zLkSKX8bKKeDoJwR4uvj37LbYeJx7npENAboFtlzQh
         eL3g1fZOGxBcMGftKRdJjO3HKUbR+2o8h1hz+aUclSMXOZYnN5ZsC+hvra5IeNN8DhvZ
         eLhKnb7p2urRrbKK+x0Bz/bNVP1sq4QiYmqVQz6p5vXxhUxdOx6a/k1ktAdgOaA6zC34
         5E9bxs/YkM/EcOnJm1/c0FfMkkIahNpPXAt8ABV6hRL89giqmb1tc13B47HOJo3oCcQR
         81ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692782521; x=1693387321;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fbc7sX2EtFFZTG3RE5OjMadql9NjkQKNUCzLFcKCo2g=;
        b=hhwJ/yGgofsfNMqcuvAVCwT4xG3lrNjitGNjiEFp8EPIsBFkJg236ti+/ujz9x69u/
         +tw0+3iuwTToRIY4mPhFTJ2Vu16b8f9QOfWm4Q0jUSKRVkxdRvyKPvfR6r3sHZCIPBTe
         OfIoKfy9AqpU6/OordJF4X8WqOZxcIwGfbY2v5UNwOh61iPuxwn/pyRmkkvWCeDc+xat
         HYbe4LhgQmL1ujlOwZmS6nwsSMPlI30YMmIBqC50Xs1upjnGQnE1CRxUkTqWKYfOU2Zo
         m3LXBV3E0tQ5Kr3xkvJXffVbX7JzKz2IxxPl222NoPL1ThzZw7FHUW1RFNnfCCYnVwar
         MsfA==
X-Gm-Message-State: AOJu0YwvUvysoLictlozeA1LssbaBqLNZEtwXwntMpTUKj5zEZT2S05q
        wjgQxmXaDdsSOFOyg3Goy+VhaA==
X-Google-Smtp-Source: AGHT+IHkZhl4O59xfOKQ6gAuZ9gpPN0nL8zSFjFn9QBl/DDxmJHNmGPocE7mbIw2y2zbh5T7AxVRpw==
X-Received: by 2002:adf:e802:0:b0:313:f45f:74a1 with SMTP id o2-20020adfe802000000b00313f45f74a1mr10043691wrm.51.1692782520834;
        Wed, 23 Aug 2023 02:22:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:c457:5132:4849:b9d9? ([2a01:e0a:cad:2140:c457:5132:4849:b9d9])
        by smtp.gmail.com with ESMTPSA id a1-20020a056000100100b003141a3c4353sm18391481wrx.30.2023.08.23.02.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 02:22:00 -0700 (PDT)
Message-ID: <725804c1-446e-4bf5-ad89-9300b34aa0c9@linaro.org>
Date:   Wed, 23 Aug 2023 11:21:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] irqchip/qcom-pdc: add support for v3.2 HW
Content-Language: en-US, fr
To:     "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230822-topic-sm8x50-upstream-pdc-ver-v2-1-3035b8d388f7@linaro.org>
 <5d5ad774-3269-232a-db15-751726742460@quicinc.com>
 <543b1f3d-60b6-44fd-bddf-eb35cc163e10@linaro.org>
 <dcf0cddc-2a35-2ddb-1912-465e29413b9c@quicinc.com>
 <ac1026c7-f446-482a-8abe-ac34786462a6@linaro.org>
 <6613c15b-7951-12b3-cbfd-2961046de2b7@quicinc.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <6613c15b-7951-12b3-cbfd-2961046de2b7@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 11:19, Maulik Shah (mkshah) wrote:
> Hi Neil,
> 
> On 8/23/2023 2:21 PM, neil.armstrong@linaro.org wrote:
>> On 23/08/2023 10:25, Maulik Shah (mkshah) wrote:
>>> Hi,
>>>
>>> On 8/23/2023 1:16 PM, Neil Armstrong wrote:
>>>> Hi,
>>>>
>>>> On 23/08/2023 07:35, Maulik Shah (mkshah) wrote:
>>>>> Hi Neil,
>>>>>
>>>>> @@ -142,8 +163,17 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
>>>>>>           return -EINVAL;
>>>>>>       }
>>>>>> -    old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
>>>>>> -    pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
>>>>>> +    if (pdc_version < PDC_VERSION_3_2) {
>>>>>> +        old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
>>>>>> +        pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
>>>>>> +    } else {
>>>>>> +        u32 val;
>>>>>> +
>>>>>> +        val = pdc_reg_read(IRQ_i_CFG, d->hwirq);
>>>>>> +        old_pdc_type = val & IRQ_i_CFG_TYPE_MASK;
>>>>>> +        pdc_reg_write(IRQ_i_CFG, d->hwirq,
>>>>>> +                  pdc_type | (val & IRQ_i_CFG_IRQ_ENABLE));
>>>>>> +    }
>>>>> While above is correct, i don't think we need version check in qcom_pdc_gic_set_type() as bits 0-2 are always for the type in old/new version as mentioned in v1.
>>>>>
>>>>> Adding one line after reading old_pdc_type should be good enough.
>>>>
>>>> Yes I understood, but while looking at the IRQ_i_CFG bits, I wanted to keep the original
>>>> driver behavior intact by setting remaining bits to 0.
>>>>
>>>> Adding this single line changes that behavior and keeps bits 3-31
>>>> to the default register value, which may have some consequences.
>>>>
>>>> If you consider it's an ok change, then I'll reduce it to this single line.
>>> Yes this ok change to have single line and should not have  any consequences.
>>
>> I also remember why, it's about the final check:
>>
>> 184         if (old_pdc_type != pdc_type)
>> 185                 irq_chip_set_parent_state(d, IRQCHIP_STATE_PENDING, false);
>>
>> We need to strip out remaining bits of old_pdc_type of this won't work as
>> expected, so I'll change it to :
>>
>> +       old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
>> +       pdc_type |= (old_pdc_type & ~IRQ_i_CFG_TYPE_MASK);
>> +       old_pdc_type &= IRQ_i_CFG_TYPE_MASK;
>> +       pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
>>
>> Is it ok for you ?
> 
> No.
> 
>          old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
> 
> +       pdc_type |= (old_pdc_type & ~IRQ_i_CFG_TYPE_MASK);
> 
> Adding above suggested single line is sufficient to make final check properly compare both old_pdc_type and new pdc_type, right?
> 
> But with your above change, It will end up comparing only bits 0-2 of old_pdc_type with updated pdc_type (which just got the other bits (3 to 31) of IRQ_i_CFG register by the ORing it with old_pdc_type).

Oh yeah indeed it's right, I had my previous code in mind.

I'll stick with the single line then,

Thanks,
Neil

> 
> Thanks,
> Maulik

