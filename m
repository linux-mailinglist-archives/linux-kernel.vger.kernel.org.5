Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F82F7851E9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjHWHqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjHWHqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:46:39 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398611B9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:46:36 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bbad32bc79so89025221fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692776794; x=1693381594;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gVR3Ol02RiDRtEy+mOIaBxEgslqdqQP+rOYrdmjpu+8=;
        b=VkN60rI7awXiKg/CT8pBgyY0JZREiKeFFeRY/sXgUN+z4LTIkIGIGWOLtVgPhnpK5F
         +kJc3S1scYZB/h/9ZfQxjLQdZTqJPhm/RBzAbZ0FdUMrHcwOMqpvOSuw9pjzL1CyVqrn
         vp6IWc76FPusJCYiK/dBLUQTQ4U5RhaWYih7uey3m0uTYL9Iof+PJSwWlDZ1p7NiRMbH
         6Ew2cd6GAR7URYSyflXYuKkZWiRU7W16Tqo3+jE4bRR/QWfS6DnKBjBX/XEHrRJYjKE8
         2u3E6d+xg7miwsrxRCSdJscycpH0R/st18sx6KuJsBuIGGeYIIj/eao7DOv7uQWLNYXK
         HPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692776794; x=1693381594;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gVR3Ol02RiDRtEy+mOIaBxEgslqdqQP+rOYrdmjpu+8=;
        b=PSma+GP4EcQe1544Xfm2CQIoPoYBOkX+MlNXy7+FrXJu3DpMtQ08cRhaf3o9mJKMwK
         HggYU3E9w1lI5Xwz0Fo69ppTY9gxK3aE1B2ikXTOoAQu+mozPiD7K6tPKQ1YaSWQcaeK
         yz0K5Y/gcN4vI1Afob8CHy/k+KfdjvXeHK8/rl9yXj8mcudeTVZgStL7YgglUFgCok9g
         x22kDdy162gt78pHkF9DZzmsaVI8zrNXXgT4IjoWpbzxCWQhvHvrhbzeJgnnjDU+nrcF
         sNAVIe9XiFKXhc3pzZADS8vL30j2Sta9AOuyI/9AJ1zGMun2pSQStBv1SvhOptYUovBZ
         VXIA==
X-Gm-Message-State: AOJu0Yz7qux2DiUDAxCX2Urpbbsxom61qKfFhM+XOfDbzSTAcpE1HzSa
        gN5lBUE8fFgpjRzksZm3dszNMQ==
X-Google-Smtp-Source: AGHT+IEmHUBCWESIdnTaneDULNO2QMOufyOzbkP6lr7GjIpKjkqj7NttugeViIASCCLxcHUMuXo/MA==
X-Received: by 2002:a2e:7007:0:b0:2bc:d6a8:1efd with SMTP id l7-20020a2e7007000000b002bcd6a81efdmr2256509ljc.39.1692776794343;
        Wed, 23 Aug 2023 00:46:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:c457:5132:4849:b9d9? ([2a01:e0a:cad:2140:c457:5132:4849:b9d9])
        by smtp.gmail.com with ESMTPSA id s14-20020a05600c044e00b003fa96fe2bd9sm21424272wmb.22.2023.08.23.00.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 00:46:33 -0700 (PDT)
Message-ID: <543b1f3d-60b6-44fd-bddf-eb35cc163e10@linaro.org>
Date:   Wed, 23 Aug 2023 09:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <5d5ad774-3269-232a-db15-751726742460@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/08/2023 07:35, Maulik Shah (mkshah) wrote:
> Hi Neil,
> 
> @@ -142,8 +163,17 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
>>           return -EINVAL;
>>       }
>> -    old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
>> -    pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
>> +    if (pdc_version < PDC_VERSION_3_2) {
>> +        old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
>> +        pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
>> +    } else {
>> +        u32 val;
>> +
>> +        val = pdc_reg_read(IRQ_i_CFG, d->hwirq);
>> +        old_pdc_type = val & IRQ_i_CFG_TYPE_MASK;
>> +        pdc_reg_write(IRQ_i_CFG, d->hwirq,
>> +                  pdc_type | (val & IRQ_i_CFG_IRQ_ENABLE));
>> +    }
> While above is correct, i don't think we need version check in qcom_pdc_gic_set_type() as bits 0-2 are always for the type in old/new version as mentioned in v1.
> 
> Adding one line after reading old_pdc_type should be good enough.

Yes I understood, but while looking at the IRQ_i_CFG bits, I wanted to keep the original
driver behavior intact by setting remaining bits to 0.

Adding this single line changes that behavior and keeps bits 3-31
to the default register value, which may have some consequences.

If you consider it's an ok change, then I'll reduce it to this single line.

> 
>    old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
> + pdc_type |= (old_pdc_type & ~IRQ_i_CFG_TYPE_MASK);
>> +            if (pdc_version < PDC_VERSION_3_2) {
>> +                u32 irq_index, reg_index;
>> +
>> +                reg_index = (i + pdc_region[n].pin_base) >> 5;
>> +                irq_index = (i + pdc_region[n].pin_base) & 0x1f;
>> +                val = pdc_reg_read(IRQ_ENABLE_BANK, reg_index);
>> +                val &= ~BIT(irq_index);
> can use  __assign_bit(irq_index, &val, 0); here.
>> +                pdc_reg_write(IRQ_ENABLE_BANK, reg_index, val);
>> +            } else {
>> +                u32 irq;
>> +
>> +                irq = i + pdc_region[n].pin_base;
>> +                val = pdc_reg_read(IRQ_i_CFG, irq);
>> +                val &= ~IRQ_i_CFG_IRQ_ENABLE;
> 
> __assign_bit(IRQ_i_CFG_IRQ_ENABLE, &val,  0); here.

Ack I'll update those.

> 
> other than this..
> Reviewed-by: Maulik Shah <quic_mkshah@quicinc.com>
> 
> Thanks,
> Maulik
> 

Thanks,
Neil

