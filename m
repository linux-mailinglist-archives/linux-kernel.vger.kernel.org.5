Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB607584FB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjGRSms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGRSmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:42:46 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B3CF0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:42:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-986d8332f50so783697466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689705764; x=1692297764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWDxOdiEo182qQTrdfRT1NqU4AQWgKjDTPUDJMk0vho=;
        b=oM+zaRthwE4f1r8MkTbNFtjNtHOKecZtu+MAMEo0rp8+TxOC3AczvBqG74Wq+XGe9z
         ayeOGgPv2iSjCSC8JS5AVBnqntVcodyk/VvMSJcBHxiwtRRRKP8HOHgSTxwGw9NsxM+m
         5/ePv26ZjawWFhwQDjYTAvkA+/BdJCX7wz94mKhpWSUunUZJRDl68l6SlNJhOooMXDhK
         XkRWgjaFHT5joJWlLLpy1vAFUwgB5jnxpZgcLbNQSlwYyLWOfTzekB0N8u/VAYKEXkBM
         O2UgCYLq1kiV3oAlEcxVRALJhxZtPQPtsuXsq1zYPeIwAEO4NNkQvPK8g8kNcWcsinm3
         3B2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689705764; x=1692297764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YWDxOdiEo182qQTrdfRT1NqU4AQWgKjDTPUDJMk0vho=;
        b=HUYpnfoEva0v6FeL7F51q6/IRMJo4INO0V29+wZGUiVNP7zI18Oi4N5vAMgHgNeYkC
         ODe/JM4jZUT0VqP0B9+LtEXUlq3pNjnD5GXz3/BtZyN9tVoIizDGWmomQG6723NfUCr/
         825LpWXu0oC/XpdMUvxpdO7e7PrIC91+vrNYDkSyZJlLWKrngWOIBmWF+R6BJMtmVXS4
         qmoyqcd9qn8v/EfJrxw5ja1mHX0bxeCNkRipKzDIFhHl3Nf5Io5uKDfDkLSNPT+kwKPZ
         RKA49X6MH6W8i8LN1AYmiSqoUECIQYXWUFGzQU+Z9Lgm0EC4jMpb4ggwm/StkNRATou5
         JsAw==
X-Gm-Message-State: ABy/qLbR1wZ6Ti8H3fK6rs6ttiXq5hPfe3QkAw4C0slyp6CuD60tvst1
        Aogr2AGOynK+EyCSJhcr0LA1SQ==
X-Google-Smtp-Source: APBJJlHwuALuQ2dnZX9w3l3xk/u5CDjDpB+cpbIhy0GLp1XygrSwSlaoo21eYMhJ9yJm12JZwn9kMw==
X-Received: by 2002:a17:907:78cf:b0:994:2fa9:7444 with SMTP id kv15-20020a17090778cf00b009942fa97444mr641821ejc.42.1689705764057;
        Tue, 18 Jul 2023 11:42:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id rp25-20020a170906d97900b009786ae9ed50sm1309961ejb.194.2023.07.18.11.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 11:42:43 -0700 (PDT)
Message-ID: <ec3d7769-8a5f-d938-7f77-351ddfe6fb45@linaro.org>
Date:   Tue, 18 Jul 2023 20:42:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Add qcom hvc/shmem transport
Content-Language: en-US
To:     Nikunj Kela <quic_nkela@quicinc.com>, sudeep.holla@arm.com
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230718160833.36397-3-quic_nkela@quicinc.com>
 <d9d5ffd5-6f85-f091-5d69-12cdd8d04c99@linaro.org>
 <3ae2d618-490a-06da-b4b6-b5a24b0a9747@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3ae2d618-490a-06da-b4b6-b5a24b0a9747@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 20:25, Nikunj Kela wrote:
>>> +
>>> +	scmi_info = devm_kzalloc(dev, sizeof(*scmi_info), GFP_KERNEL);
>>> +	if (!scmi_info)
>>> +		return -ENOMEM;
>>> +
>>> +	np = of_parse_phandle(cdev->of_node, "shmem", 0);
>>> +	if (!of_device_is_compatible(np, "arm,scmi-shmem"))
>> You leak here reference.
> Wouldn't the devm_* API take care of that implicitly? It is same in 
> smc.c as well.

Thanks for bringing my attention to this. I sent a fix for smc.c. Fix
your patch as well, please.

>>> +		return -ENXIO;
>>> +
>>> +	ret = of_address_to_resource(np, 0, &res);
>>> +	of_node_put(np);
>>> +	if (ret) {
>>> +		dev_err(cdev, "failed to get SCMI Tx shared memory\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	size = resource_size(&res);
>>> +
>>> +	/* let's map 2 additional ulong since
>>> +	 * func-id & capability-id are kept after shmem.
>>> +	 *     +-------+
>>> +	 *     |       |
>>> +	 *     | shmem |
>>> +	 *     |       |
>>> +	 *     |       |
>>> +	 *     +-------+ <-- size
>>> +	 *     | funcId|
>>> +	 *     +-------+ <-- size + sizeof(ulong)
>>> +	 *     | capId |
>>> +	 *     +-------+ <-- size + 2*sizeof(ulong)
>>> +	 */
>>> +
>>> +	scmi_info->shmem = devm_ioremap(dev, res.start,
>>> +					size + 2 * sizeof(unsigned long));
>>> +	if (!scmi_info->shmem) {
>>> +		dev_err(dev, "failed to ioremap SCMI Tx shared memory\n");
>>> +		return -EADDRNOTAVAIL;
>>> +	}
>>> +
>>> +	func_id = readl((void *)(scmi_info->shmem) + size);
>>> +
>>> +#ifdef CONFIG_ARM64
>>> +	cap_id = readq((void *)(scmi_info->shmem) + size +
>>> +		       sizeof(unsigned long));
>>> +#else
>>> +	cap_id = readl((void *)(scmi_info->shmem) + size +
>>> +		       sizeof(unsigned long));
>>> +#endif
>>> +
>>> +	/*
>>> +	 * If there is an interrupt named "a2p", then the service and
>>> +	 * completion of a message is signaled by an interrupt rather than by
>>> +	 * the return of the hvc call.
>>> +	 */
>>> +	irq = of_irq_get_byname(cdev->of_node, "a2p");
>>> +	if (irq > 0) {
>>> +		ret = devm_request_irq(dev, irq, qcom_hvc_msg_done_isr,
>>> +				       IRQF_NO_SUSPEND,
>>> +				       dev_name(dev), scmi_info);
>>> +		if (ret) {
>>> +			dev_err(dev, "failed to setup SCMI completion irq\n");
>> return dev_err_probe, unless this is not called in probe... but then
>> using devm-interface raises questions.
> This is copied as is from existing smc.c

I understand and I hope you understand the code you copied. If there is
a bug in existing code, please do not copy it to new code (like leaking
OF node reference).

Best regards,
Krzysztof

