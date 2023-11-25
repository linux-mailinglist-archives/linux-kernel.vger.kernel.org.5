Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747F47F8BFB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjKYPRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjKYPRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:17:10 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AB6101
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:17:15 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40859dee28cso22600515e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700925434; x=1701530234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L//cXM65lEufA8qopdoTlT0G7CECObDXCb5waukCjRo=;
        b=Ap7yNQ2moSOX+8m5uas3PtuT63QBqWm6/dD8H9jpRPFgLvz2j41AxuYzYlG0yUT5lV
         0qgjyt0H35yUQaGz1Z5kIxSHfSiy6RDgF+aFd0sxZOHMuPgthx2lHoj6MfMDmaRSkV6E
         qyJBvAxQKuF/zDHeBf4I96rnj13bzHSmsnVW/ZKVZ8jLQG32M/i55hnyFLfBYJP7bAbq
         g4ASPA3UO5MwqKWgf/mkL+iYjKOlBLv/nslgMnuEUljzRvbsdtLhbDwXb3g/1cDQdfeF
         rD0blYYsMuAtVA3W/iiIwao5+2A1wbuwFk/f4xk3FwMeH4Kf32FjPJIUwu59TJmJwQGu
         truw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700925434; x=1701530234;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L//cXM65lEufA8qopdoTlT0G7CECObDXCb5waukCjRo=;
        b=VKXr6HeXfCWL7ZWvb+B4xx7wI6QuKvptScqbbG/zWKCuwGVI4YDm9J+pwlNhC7XKYb
         uBre1RhZB1lHHf9qjUy5hHhuIc5kohfYJJldFnbWDy9pOdIq4g9+X7eTMaB3Nwj4Zp2X
         oScvbCf+ELrJKUXraeytdRuy3erVAzdAYot/62zz0wJXKPca3D6LpGvnk2zpLuhYLK+M
         Wsu4CgXNUqdZ2DCodWic4h57k6O5JDIXiGZ4DVD+GkS2pQ69MIHWCxaHC87js/9SJLRh
         ZoGw+2nfAbJ0Ah4D6MgGtSRPk7JYHq/P0VSazmth1nVyuJhw6DkHIhQAk41k5xE2rE3t
         Uy8g==
X-Gm-Message-State: AOJu0YxKH9w1Idq+s6tcJBvypgM4lunGcGt8cCsvm9nr0P/gl4ZhKLr9
        I/ahj7D5g9MWLOEZbU1l3PEz9A==
X-Google-Smtp-Source: AGHT+IGwnqLhrtr72VZNjFVnj7zkFww47Kvwg5iba4kzHIGXaWjdDtnp+7LshXKgBUTTBwgApNkbpA==
X-Received: by 2002:a05:600c:3550:b0:40b:415e:c044 with SMTP id i16-20020a05600c355000b0040b415ec044mr1056018wmq.37.1700925434011;
        Sat, 25 Nov 2023 07:17:14 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id a10-20020a056000050a00b0032ddf2804ccsm6798220wrf.83.2023.11.25.07.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 07:17:13 -0800 (PST)
Message-ID: <44a2b30a-7f8c-44a9-8a74-b09fee2b61b7@linaro.org>
Date:   Sat, 25 Nov 2023 15:17:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] irqchip: irq-qcom-mpm: Support passing a slice of
 SRAM as reg space
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
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
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230328-topic-msgram_mpm-v6-2-682e4855b7e2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2023 14:27, Konrad Dybcio wrote:
> The MPM hardware is accessible to us from the ARM CPUs through a shared
> memory region (RPM MSG RAM) that's also concurrently accessed by other
> kinds of cores on the system (like modem, ADSP etc.). Modeling this
> relation in a (somewhat) sane manner in the device tree basically
> requires us to either present the MPM as a child of said memory region
> (which makes little sense, as a mapped memory carveout is not a bus),
> define nodes which bleed their register spaces into one another, or
> passing their slice of the MSG RAM through some kind of a property.
> 
> Go with the third option and add a way to map a region passed through
> the "qcom,rpm-msg-ram" property as our register space.
> 
> The current way of using 'reg' is preserved for ABI reasons.
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/irqchip/irq-qcom-mpm.c | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
> index 7124565234a5..7115e3056aa5 100644
> --- a/drivers/irqchip/irq-qcom-mpm.c
> +++ b/drivers/irqchip/irq-qcom-mpm.c
> @@ -14,6 +14,7 @@
>   #include <linux/mailbox_client.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> +#include <linux/of_address.h>
>   #include <linux/of_platform.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_domain.h>
> @@ -322,8 +323,10 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
>   	struct device *dev = &pdev->dev;
>   	struct irq_domain *parent_domain;
>   	struct generic_pm_domain *genpd;
> +	struct device_node *msgram_np;
>   	struct qcom_mpm_priv *priv;
>   	unsigned int pin_cnt;
> +	struct resource res;
>   	int i, irq;
>   	int ret;
>   
> @@ -374,9 +377,21 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
>   
>   	raw_spin_lock_init(&priv->lock);
>   
> -	priv->base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(priv->base))
> -		return PTR_ERR(priv->base);
> +	/* If we have a handle to an RPM message ram partition, use it. */
> +	msgram_np = of_parse_phandle(np, "qcom,rpm-msg-ram", 0);
> +	if (msgram_np) {
> +		ret = of_address_to_resource(msgram_np, 0, &res);

You are capturing the return value but doing nothing with it.

One of

if (ret) {
     of_node_put(msgram_np);
     return ret;
}

or just drop the ret =

if you are sure of_address_to_resource() can never return an error for 
your use-case.

Once fixed.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
