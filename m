Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002777F8C1C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjKYPlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjKYPlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:41:20 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996B710D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:41:26 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5441305cbd1so3737384a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700926885; x=1701531685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZPM3fc1sKx4Gg4S7hWUKEhn04fj5QKwM/8vpdwmNFU=;
        b=pYXm/QspGRx6QRVsuDtOx03EY+AjkRqwAfwRQEK5XxP8ALmm+u4vEn3jHHdMvalMbK
         fwr+h03WXG03hk9I0BWruk4JgaWinRx29nnvA0FvCpmpR1Geo3ylQeF1KTx4C0Lc4qAz
         JroU3gVnEIXCHmrngcL7Hl+BK1WgSS+0Oxxatl+8nKiKQ1ND92ca6TQwDyr7izQ/FTDk
         VmwLqu7HM+l4CuSiPAcjR1Ve/Z60CvttaFPyMgiavV4kRfM9cKAMPfXLYiibFAPM6y8z
         8JCCnCifHT8gsiRn/S0X2BlmPWbIO9Bi5ng7SMay/3mB7wwmNOKjU1QN3jWVHvJj9E72
         WTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700926885; x=1701531685;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZPM3fc1sKx4Gg4S7hWUKEhn04fj5QKwM/8vpdwmNFU=;
        b=wlzflnRQFCg4qo4ZIyBnu0irKn85MsS/Jn4G/2gX4DVAKbQO82+qGlaHp0MgEPt320
         es1kL6g8VqO6uFdWDdVeZEdevw2dL91reTa7m4K/HKKU0xcMCNC4YF1sc3NQoJ7xOg78
         EZmUFfybN9cUXDPKzBF2yjrnansNvaqd+6zJ5DDoD0UuTM5imu+yOyWYlQm4TEnm1whE
         c0jy0x+9LFRC9nUc3MOxy+9ANyJ2UCIB+l+DGHgK7H/ZE2fFmdvoupDXxsXhhMrYOI6z
         GkMPwx1FRo1sqY99qqtMv8PKDV1rVh8LyzOgTsXYAuNWdT45RehOI0Tt8DiBUqmRbO1f
         6qOw==
X-Gm-Message-State: AOJu0YymUw4Jf0oaASjCtbiS7lA507V6G70t7BxLDoCGQ0ID99WdGHYk
        EhJ9AuJo2G32fgUWD8KGb5XvCQ==
X-Google-Smtp-Source: AGHT+IGv0MEH8sNlUhtqfKhYJ9Upqi2F+eqUc2Kl8ESIWnUn9KzDFJ0am9U2dyiRdjKXNzSoe+0JMA==
X-Received: by 2002:a50:aac3:0:b0:544:a153:cd19 with SMTP id r3-20020a50aac3000000b00544a153cd19mr3594225edc.41.1700926884918;
        Sat, 25 Nov 2023 07:41:24 -0800 (PST)
Received: from [192.168.201.100] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id j26-20020aa7ca5a000000b00548aeeb1a9esm3148429edt.89.2023.11.25.07.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 07:41:24 -0800 (PST)
Message-ID: <1a3d840d-50d3-474f-89a6-e36a1cb8f5de@linaro.org>
Date:   Sat, 25 Nov 2023 16:41:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] irqchip: irq-qcom-mpm: Support passing a slice of
 SRAM as reg space
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230328-topic-msgram_mpm-v6-0-682e4855b7e2@linaro.org>
 <20230328-topic-msgram_mpm-v6-2-682e4855b7e2@linaro.org>
 <44a2b30a-7f8c-44a9-8a74-b09fee2b61b7@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <44a2b30a-7f8c-44a9-8a74-b09fee2b61b7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.2023 16:17, Bryan O'Donoghue wrote:
> On 25/11/2023 14:27, Konrad Dybcio wrote:
>> The MPM hardware is accessible to us from the ARM CPUs through a shared
>> memory region (RPM MSG RAM) that's also concurrently accessed by other
>> kinds of cores on the system (like modem, ADSP etc.). Modeling this
>> relation in a (somewhat) sane manner in the device tree basically
>> requires us to either present the MPM as a child of said memory region
>> (which makes little sense, as a mapped memory carveout is not a bus),
>> define nodes which bleed their register spaces into one another, or
>> passing their slice of the MSG RAM through some kind of a property.
>>
>> Go with the third option and add a way to map a region passed through
>> the "qcom,rpm-msg-ram" property as our register space.
>>
>> The current way of using 'reg' is preserved for ABI reasons.
>>
>> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/irqchip/irq-qcom-mpm.c | 21 ++++++++++++++++++---
>>   1 file changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
>> index 7124565234a5..7115e3056aa5 100644
>> --- a/drivers/irqchip/irq-qcom-mpm.c
>> +++ b/drivers/irqchip/irq-qcom-mpm.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/mailbox_client.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> +#include <linux/of_address.h>
>>   #include <linux/of_platform.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/pm_domain.h>
>> @@ -322,8 +323,10 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
>>       struct device *dev = &pdev->dev;
>>       struct irq_domain *parent_domain;
>>       struct generic_pm_domain *genpd;
>> +    struct device_node *msgram_np;
>>       struct qcom_mpm_priv *priv;
>>       unsigned int pin_cnt;
>> +    struct resource res;
>>       int i, irq;
>>       int ret;
>>   @@ -374,9 +377,21 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
>>         raw_spin_lock_init(&priv->lock);
>>   -    priv->base = devm_platform_ioremap_resource(pdev, 0);
>> -    if (IS_ERR(priv->base))
>> -        return PTR_ERR(priv->base);
>> +    /* If we have a handle to an RPM message ram partition, use it. */
>> +    msgram_np = of_parse_phandle(np, "qcom,rpm-msg-ram", 0);
>> +    if (msgram_np) {
>> +        ret = of_address_to_resource(msgram_np, 0, &res);
> 
> You are capturing the return value but doing nothing with it.
Oops you're right
> 
> One of
> 
> if (ret) {
>     of_node_put(msgram_np);
>     return ret;
> }
> 
> or just drop the ret =
> 
> if you are sure of_address_to_resource() can never return an error for your use-case.
Never say never!

Konrad
