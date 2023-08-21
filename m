Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9991F7828B5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbjHUMOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjHUMOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:14:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2E8BE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:14:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-319559fd67dso3048688f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692620061; x=1693224861;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jZeDhZ6rG2eXOJmaq+YM/zeTECUDJRs4cIoio/GoLM=;
        b=BQwHHl+fa5LX2NkPQJZvj4EIRN/nothMbgKkNK0mkrVnYYwi0NCuGTTc1cOwj0fc9N
         CRn6LR1KJarxOLMRI91aHW0eOUximtNcj1VJXdTWSSQLMUCDn8rVzo7hJduZmIBrGhhw
         bshqTPzUGCbNZqcocrnBJyBa9FTRKCM8Q2tPN+8e7bcIEvG44plZeCRPepCZGdHKTdM5
         MPLQxtqz5bJve/ZUCPS7iGl7pmtfdfwu694DTESFPjDez+usx7Fp/t/iaAPkj2HTZUUY
         8+o+Hv9izH/ZLFGLbG2u18i6R6LHkQYbr3BurE/+CxSDbKVF4QnqgsfrpOvgUE6YVhS1
         ILPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692620061; x=1693224861;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+jZeDhZ6rG2eXOJmaq+YM/zeTECUDJRs4cIoio/GoLM=;
        b=b/YIfTqpxovn5+wzeQLfj4C3hE9fKp7Z8mJX1UwtLmrfEtm+afkx6MIA9Aj41vb+ea
         rFsQVjy5cZXudtubxQTNgaSHGEfpqn/SepnIcHppT2ZeTw0AeqRQTeEcU2akIfmv0xhv
         vs75s2e+Z4ngfFQEGjNJgENN3E4XQZgnv77r2tW4uOQkZF+wojx9u4j3Svc2OF7wFsaY
         +71ZAR6CH+1UlkgrFtfW9mPMgpbNxyY2z6MQyyMrnaLc1E3sdhcGeZyAj3dksGQlTn+o
         9YgtL+hIF+3ufeZOJ1uMrTgS9XaZGQjyfZnpDeQya9a0Q7PrZ70uagDAgksGx9i0ZVUr
         JmKg==
X-Gm-Message-State: AOJu0YzB3OOeKbRy+bjZ4sq1HBFV1kt4Opq+e+wpy4R3Zep5TqBUEnen
        sAViSt2fB6d/iyYcguA5qff4EMiW4j6zZyUGEiJsOQ==
X-Google-Smtp-Source: AGHT+IFyJbTW8jQSyNnceEplKrsLLXGXCTkIBMUWsT78Qef/JlWfpZa2nzs/5jSg+rrrH3mBy9Z1zw==
X-Received: by 2002:a5d:5102:0:b0:315:a1d5:a3d5 with SMTP id s2-20020a5d5102000000b00315a1d5a3d5mr5414513wrt.22.1692620060278;
        Mon, 21 Aug 2023 05:14:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:4b:459f:81d3:47f3? ([2a01:e0a:cad:2140:4b:459f:81d3:47f3])
        by smtp.gmail.com with ESMTPSA id q16-20020a05600000d000b0031c56218984sm2464418wrx.104.2023.08.21.05.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 05:14:19 -0700 (PDT)
Message-ID: <c58ed3f8-87bb-4a48-aae6-8d67f8f0b3ed@linaro.org>
Date:   Mon, 21 Aug 2023 14:14:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] irqchip/qcom-pdc: add support for v3.2 HW
Content-Language: en-US, fr
To:     "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230821-topic-sm8x50-upstream-pdc-ver-v1-1-6d7f4dd95719@linaro.org>
 <0439125b-2952-229b-497f-c44592621410@quicinc.com>
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
In-Reply-To: <0439125b-2952-229b-497f-c44592621410@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2023 10:41, Maulik Shah (mkshah) wrote:
> Hi,
> 
> On 8/21/2023 1:00 PM, Neil Armstrong wrote:
>> The PDC Hw version 3.2 and later doesn't have the enable registers
>> anymore, get the HW version from registers and stop accessing those
>> registers starting at this version.
> 
> Starting PDC v3.2, enable bit is moved from IRQ_ENABLE_BANK to the IRQ_i_CFG register.
> we need to set enable bit to tell PDC HW whether IRQ is enabled / disabled in order to wake up from SoC sleep states.
> 
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/irqchip/qcom-pdc.c | 64 ++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 53 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
>> index d96916cf6a41..620efb9fcc96 100644
>> --- a/drivers/irqchip/qcom-pdc.c
>> +++ b/drivers/irqchip/qcom-pdc.c
>> @@ -26,6 +26,13 @@
>>   #define IRQ_ENABLE_BANK        0x10
>>   #define IRQ_i_CFG        0x110
>> +#define PDC_VERSION        0x1000
>> +
>> +/* Notable PDC versions */
>> +enum {
>> +    PDC_VERSION_3_2    = 0x30200,
>> +};
>> +
>>   struct pdc_pin_region {
>>       u32 pin_base;
>>       u32 parent_base;
>> @@ -38,6 +45,7 @@ static DEFINE_RAW_SPINLOCK(pdc_lock);
>>   static void __iomem *pdc_base;
>>   static struct pdc_pin_region *pdc_region;
>>   static int pdc_region_cnt;
>> +static unsigned int pdc_version;
>>   static void pdc_reg_write(int reg, u32 i, u32 val)
>>   {
>> @@ -183,6 +191,25 @@ static struct irq_chip qcom_pdc_gic_chip = {
>>       .irq_set_affinity    = irq_chip_set_affinity_parent,
>>   };
>> +static struct irq_chip qcom_pdc_gic_chip_3_2 = {
>> +    .name            = "PDC",
>> +    .irq_eoi        = irq_chip_eoi_parent,
>> +    .irq_mask        = irq_chip_mask_parent,
>> +    .irq_unmask        = irq_chip_unmask_parent,
>> +    .irq_disable        = irq_chip_disable_parent,
>> +    .irq_enable        = irq_chip_enable_parent,
>> +    .irq_get_irqchip_state    = irq_chip_get_parent_state,
>> +    .irq_set_irqchip_state    = irq_chip_set_parent_state,
>> +    .irq_retrigger        = irq_chip_retrigger_hierarchy,
>> +    .irq_set_type        = qcom_pdc_gic_set_type,
>> +    .flags            = IRQCHIP_MASK_ON_SUSPEND |
>> +                  IRQCHIP_SET_TYPE_MASKED |
>> +                  IRQCHIP_SKIP_SET_WAKE |
>> +                  IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND,
>> +    .irq_set_vcpu_affinity    = irq_chip_set_vcpu_affinity_parent,
>> +    .irq_set_affinity    = irq_chip_set_affinity_parent,
>> +};
>> +
> we should not need to have another irqchip defined for same as these remains same for old/new version.
> 
> Not sure if you have access to downstream change, or let me know i can post the same.
> In downstream we do like...
> 
> The 3rd bit in IRQ_i_CFG in PDC v3.2 is for enable/disable,
> The 0-2 bits are for the IRQ type in all PDC versions..
> 
>      #define IRQ_i_CFG_IRQ_ENABLE   BIT(3)
>      #define IRQ_i_CFG_TYPE_MASK    0x7
> 
> and modify pdc_enable_intr()
> 
>         if (pdc_version < PDC_VERSION_3_2) {
>                 index = pin_out / 32;
>                 mask = pin_out % 32;
>                 enable = pdc_reg_read(IRQ_ENABLE_BANK, index);
>                 __assign_bit(mask, &enable, on);
>                 pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
>         } else {
>                 index = d->hwirq;
>                 enable = pdc_reg_read(IRQ_i_CFG, index);
>                 __assign_bit(IRQ_i_CFG_IRQ_ENABLE, &enable, on);
>                 pdc_reg_write(IRQ_i_CFG, index, enable);
>         }
> 
> and qcom_pdc_gic_set_type(), add line to only take 0-2 bits from old_pdc_type as they are for type.
> 
>          old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
> +       pdc_type |= (old_pdc_type & ~IRQ_i_CFG_TYPE_MASK);
>> +        if (pdc_version < PDC_VERSION_3_2)
>> +            pdc_enable_region(n);
>>       }
> 
> you will still need to clear enable bits in version 3.2.

Ack, thx for the review, I'll fix all that for v2.

Neil

> 
> Thanks,
> Maulik
> 

