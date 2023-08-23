Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6E378534D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbjHWI5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbjHWIxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:53:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D13C1BFA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:51:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fee51329feso24096895e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692780673; x=1693385473;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+p+WwXY5fLDp3fht9OF1MgWbHUlJ7rQelzIQB6wxQo4=;
        b=jmaJJM6rTYPDh6x5ktPBPUAOM1FqgaVhDyFv2dyoWBGAg0A6oOXECx5x2ktQ+wwlcw
         IqSdnfGlrIboIUAGiKoMKt43mRkpkFt1Q0sevLZJpuQMyydWLcwkcUiecKJb/mRd8UQB
         bz//4cr1ugCglSAIOul3txYo/ZvnHaUmucNA9cWHp/cUKxYijQwkTI0eU3uN+FxROwx7
         34ZxbmLuvVa3hPkrmawqFqQlsHiI5/hXi58ccEHgxoiBi5N+3jCUtRGLrI2mOXahkECi
         lUB31sd3cxOn0oTHonrWGYt5jx9LMQ58xK1WBW+r8JwXDR3Y434Agpn1qKlo2fQuBAvI
         Fp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692780673; x=1693385473;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+p+WwXY5fLDp3fht9OF1MgWbHUlJ7rQelzIQB6wxQo4=;
        b=R0oZu4vwExusaT5Gvb3aQyTpxGnMoT9cAiYoi2PKXYM2vn7TWe4ZlzQU0mNCLKqy9g
         LmrS0IHDmp9oBcDSQQAlcmIjSJQbyJ3q4twW9vJzqcr9YwLbVDVRsn83dsjU3vjI7Q5Y
         BTeaKCZG7ESq+VSrVjNdD2ohrmPTT6lpRTVy7iKRt6/8DVwnErPkAJXva1Wa5ACFhblH
         /UzthZxA9gU59S5yjpX8X8T7HbNVJ3+E5xIMVTc3ub+ydJXAIJ91G39vNpbPSQwOV5ev
         DcmZet8Opkzb1epIx+bt85gmVMjcRDUCCDuuop4WNpBLSx0cNT2ZweL+dMaVOhrgxbdL
         efKg==
X-Gm-Message-State: AOJu0YzLlgCKUh6SLPeNbqweCbfFPdMN7ttRAB5s0HKnIH3mjzqehix/
        o65qaKQ+gBvZ+P/AHCyX8vS9wg==
X-Google-Smtp-Source: AGHT+IF4QlscfYxhjPYYFvGoBHf+62irUrTldgRGLaddwbU27iffdv2Ytk7Img2MwJm0mbmHQ7/P+Q==
X-Received: by 2002:a05:600c:2b57:b0:3fe:21f1:aba8 with SMTP id e23-20020a05600c2b5700b003fe21f1aba8mr9128014wmf.12.1692780673283;
        Wed, 23 Aug 2023 01:51:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:c457:5132:4849:b9d9? ([2a01:e0a:cad:2140:c457:5132:4849:b9d9])
        by smtp.gmail.com with ESMTPSA id z10-20020a1c4c0a000000b003fef5402d2dsm6217640wmf.8.2023.08.23.01.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 01:51:12 -0700 (PDT)
Message-ID: <ac1026c7-f446-482a-8abe-ac34786462a6@linaro.org>
Date:   Wed, 23 Aug 2023 10:51:11 +0200
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
In-Reply-To: <dcf0cddc-2a35-2ddb-1912-465e29413b9c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 10:25, Maulik Shah (mkshah) wrote:
> Hi,
> 
> On 8/23/2023 1:16 PM, Neil Armstrong wrote:
>> Hi,
>>
>> On 23/08/2023 07:35, Maulik Shah (mkshah) wrote:
>>> Hi Neil,
>>>
>>> @@ -142,8 +163,17 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
>>>>           return -EINVAL;
>>>>       }
>>>> -    old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
>>>> -    pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
>>>> +    if (pdc_version < PDC_VERSION_3_2) {
>>>> +        old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
>>>> +        pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
>>>> +    } else {
>>>> +        u32 val;
>>>> +
>>>> +        val = pdc_reg_read(IRQ_i_CFG, d->hwirq);
>>>> +        old_pdc_type = val & IRQ_i_CFG_TYPE_MASK;
>>>> +        pdc_reg_write(IRQ_i_CFG, d->hwirq,
>>>> +                  pdc_type | (val & IRQ_i_CFG_IRQ_ENABLE));
>>>> +    }
>>> While above is correct, i don't think we need version check in qcom_pdc_gic_set_type() as bits 0-2 are always for the type in old/new version as mentioned in v1.
>>>
>>> Adding one line after reading old_pdc_type should be good enough.
>>
>> Yes I understood, but while looking at the IRQ_i_CFG bits, I wanted to keep the original
>> driver behavior intact by setting remaining bits to 0.
>>
>> Adding this single line changes that behavior and keeps bits 3-31
>> to the default register value, which may have some consequences.
>>
>> If you consider it's an ok change, then I'll reduce it to this single line.
> Yes this ok change to have single line and should not have  any consequences.

I also remember why, it's about the final check:

184         if (old_pdc_type != pdc_type)
185                 irq_chip_set_parent_state(d, IRQCHIP_STATE_PENDING, false);

We need to strip out remaining bits of old_pdc_type of this won't work as
expected, so I'll change it to :

+       old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
+       pdc_type |= (old_pdc_type & ~IRQ_i_CFG_TYPE_MASK);
+       old_pdc_type &= IRQ_i_CFG_TYPE_MASK;
+       pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);

Is it ok for you ?

Thanks,
Neil


> 
> Thanks,
> Maulik
> 

