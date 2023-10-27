Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD317D99CC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345955AbjJ0N2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345868AbjJ0N23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:28:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165CBE5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:28:27 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32d849cc152so1431092f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698413305; x=1699018105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0NlxUt01xoDUM68uUAmSCgMLEqGDv0Czy1rYZIZs8k=;
        b=RYq4t/OtjpcnhJ7nvatwi6XWunrU7+ltC0mejQ4vbEIaSkNeOMfc5TbkTlFzfUWyNb
         TKUroIxKknLXNmN2uWN2b/DYwdfIkVdgpuXG1luE1p0yG5tAELxs2iDSCawCnAbiR7uG
         C67WK52VM4DNobBmhMzVzcwJZSUDt3JVje7MQTii3zJZCYnHfxxbs0agia8nC5EVifg6
         fvom5/1ov4ftAQwHZD5PjMLBCB2fXSOLIwHFLrMjlfxh/EzVfG/UyVUzHAAz+E5m0z49
         /Fk+FwCnepU092B5TB15AzLXln/d1QndQ2DKCrSRgEmO3KgAZ4L7Ge/NPWnDbojdtUUb
         hmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698413305; x=1699018105;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+0NlxUt01xoDUM68uUAmSCgMLEqGDv0Czy1rYZIZs8k=;
        b=DeRmG7Q/wV5aNzQtDXN0D7PVFY1OUX9vNPMTVn6NLRg1mxjRAJ0DqO0wdjhQIrVAtx
         aqaYtiO7VWm0NOu4pood2zHftmyS10pFfmznVZTYP4iEOGx5ePS4BZKFNsL8KC2vnVbZ
         W/TDUxEevibZZcCldKNgEqQ/a9OFA6rjiXDq65ndvVx9rlJ7zAkyOLdQiJAdkuQbPJQ0
         L2oG6jJMT/SKa1DOj0hP0BCNxwPhDcKFqqDI8ktjDWptP+n83a7UAq7oPADji8/uYUyv
         o7WnIjP6kqoliKgPnStN980FqcncBIPXeAZbAyQklFtS8/WaIU7eczednOMQ/Atk21/H
         WdrA==
X-Gm-Message-State: AOJu0Yw6u8skKV2h1/L7W4jUc75H5uLW7idBF1wHdXFIECtvwd7lfXvL
        HPcMI1z1qj4fG8oXenoJ37sfQQ==
X-Google-Smtp-Source: AGHT+IG6NK1Rh7HLaXTjKt7lln3TdQMWNPp78NlU0dyomBEcFLajh2wIyo8PyRUjYJ8ipbOM/k5xig==
X-Received: by 2002:a5d:6145:0:b0:32d:9579:94e3 with SMTP id y5-20020a5d6145000000b0032d957994e3mr1720098wrt.6.1698413305254;
        Fri, 27 Oct 2023 06:28:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:bba7:4e7d:4d42:af62? ([2a01:e0a:982:cbb0:bba7:4e7d:4d42:af62])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d6ac9000000b0032d687fd9d0sm1761313wrw.19.2023.10.27.06.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 06:28:24 -0700 (PDT)
Message-ID: <85b5ea04-a0d8-4c31-abb6-8778dcb8a9be@linaro.org>
Date:   Fri, 27 Oct 2023 15:28:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/3] pinctrl: qcom: handle intr_target_reg
 wakeup_present/enable bits
Content-Language: en-US, fr
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231025-topic-sm8650-upstream-tlmm-v1-0-4e3d84a3a46b@linaro.org>
 <20231025-topic-sm8650-upstream-tlmm-v1-2-4e3d84a3a46b@linaro.org>
 <vtr3s7fyrionospnmzvm2xl2plsue2jlrc3tjifqua3ihucxao@6hxi3i22bwxs>
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
In-Reply-To: <vtr3s7fyrionospnmzvm2xl2plsue2jlrc3tjifqua3ihucxao@6hxi3i22bwxs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2023 04:10, Bjorn Andersson wrote:
> On Wed, Oct 25, 2023 at 09:33:52AM +0200, Neil Armstrong wrote:
>> New platforms uses a new set of bits to control the wakeirq
>> delivery to the PDC block.
>>
>> The intr_wakeup_present_bit indicates if the GPIO supports
>> wakeirq and intr_wakeup_enable_bit enables wakeirq delivery
>> to the PDC block.
>>
>> While the name seems to imply this only enables wakeup events,
>> it is required to allow interrupts events to the PDC block.
>>
>> Enable this bit in the irq resource request/free if:
>> - gpio is in wakeirq map
>> - has the intr_wakeup_present_bit
>> - the intr_wakeup_enable_bit is set
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/pinctrl/qcom/pinctrl-msm.c | 32 ++++++++++++++++++++++++++++++++
>>   drivers/pinctrl/qcom/pinctrl-msm.h |  5 +++++
>>   2 files changed, 37 insertions(+)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
>> index 395040346d0f..2489a9ac8455 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
>> @@ -1196,6 +1196,7 @@ static int msm_gpio_irq_reqres(struct irq_data *d)
>>   {
>>   	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>>   	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
>> +	const struct msm_pingroup *g = &pctrl->soc->groups[d->hwirq];
>>   	int ret;
>>   
>>   	if (!try_module_get(gc->owner))
>> @@ -1221,6 +1222,24 @@ static int msm_gpio_irq_reqres(struct irq_data *d)
>>   	 */
>>   	irq_set_status_flags(d->irq, IRQ_DISABLE_UNLAZY);
>>   
>> +	/*
>> +	 * If the wakeup_enable bit is present and marked as available for the
>> +	 * requested GPIO, it should be enabled when the GPIO is marked as
>> +	 * wake irq in order to allow the interrupt event to be transfered to
>> +	 * the PDC HW.
>> +	 * While the name implies only the wakeup event, it's also required for
>> +	 * the interrupt event.
>> +	 */
>> +	if (test_bit(d->hwirq, pctrl->skip_wake_irqs) && g->intr_wakeup_present_bit) {
>> +		u32 intr_cfg;
>> +
>> +		intr_cfg = msm_readl_intr_cfg(pctrl, g);
>> +		if (intr_cfg & BIT(g->intr_wakeup_present_bit)) {
>> +			intr_cfg |= BIT(g->intr_wakeup_enable_bit);
>> +			msm_writel_intr_cfg(intr_cfg, pctrl, g);
> 
> If I understand correctly, the two modified functions are hooked
> straight into the irq_chip, which would imply that nothing prevent
> concurrent execution of this and the other accessors of intr_cfg.
> 
> If I'm reading this correctly, I think we should perform this
> read-modify-write under the spinlock.

Yes exact, thanks for pointing this.

Neil

> 
> Regards,
> Bjorn
> 
>> +		}
>> +	}
>> +
>>   	return 0;
>>   out:
>>   	module_put(gc->owner);
>> @@ -1230,6 +1249,19 @@ static int msm_gpio_irq_reqres(struct irq_data *d)
>>   static void msm_gpio_irq_relres(struct irq_data *d)
>>   {
>>   	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>> +	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
>> +	const struct msm_pingroup *g = &pctrl->soc->groups[d->hwirq];
>> +
>> +	/* Disable the wakeup_enable bit if it has been set in msm_gpio_irq_reqres() */
>> +	if (test_bit(d->hwirq, pctrl->skip_wake_irqs) && g->intr_wakeup_present_bit) {
>> +		u32 intr_cfg;
>> +
>> +		intr_cfg = msm_readl_intr_cfg(pctrl, g);
>> +		if (intr_cfg & BIT(g->intr_wakeup_present_bit)) {
>> +			intr_cfg &= ~BIT(g->intr_wakeup_enable_bit);
>> +			msm_writel_intr_cfg(intr_cfg, pctrl, g);
>> +		}
>> +	}
>>   
>>   	gpiochip_unlock_as_irq(gc, d->hwirq);
>>   	module_put(gc->owner);
>> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
>> index 4968d08a384d..63852ed70295 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-msm.h
>> +++ b/drivers/pinctrl/qcom/pinctrl-msm.h
>> @@ -58,6 +58,9 @@ struct pinctrl_pin_desc;
>>    * @intr_enable_bit:      Offset in @intr_cfg_reg for enabling the interrupt for this group.
>>    * @intr_status_bit:      Offset in @intr_status_reg for reading and acking the interrupt
>>    *                        status.
>> + * @intr_wakeup_present_bit: Offset in @intr_target_reg specifying the GPIO can generate
>> + *			  wakeup events.
>> + * @intr_wakeup_enable_bit: Offset in @intr_target_reg to enable wakeup events for the GPIO.
>>    * @intr_target_bit:      Offset in @intr_target_reg for configuring the interrupt routing.
>>    * @intr_target_width:    Number of bits used for specifying interrupt routing target.
>>    * @intr_target_kpss_val: Value in @intr_target_bit for specifying that the interrupt from
>> @@ -100,6 +103,8 @@ struct msm_pingroup {
>>   	unsigned intr_status_bit:5;
>>   	unsigned intr_ack_high:1;
>>   
>> +	unsigned intr_wakeup_present_bit:5;
>> +	unsigned intr_wakeup_enable_bit:5;
>>   	unsigned intr_target_bit:5;
>>   	unsigned intr_target_width:5;
>>   	unsigned intr_target_kpss_val:5;
>>
>> -- 
>> 2.34.1
>>

