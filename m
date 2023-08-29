Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1923078C01C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbjH2ITI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjH2ISj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:18:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F70E9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:18:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52a49a42353so5717987a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693297114; x=1693901914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HAL+QW1Uxu14SX9zM6XGspJb7wIOSyL2pK7dTNh/26U=;
        b=roc5GwCTf4Wov4tDBI/QnszPHmiYCEvRyWplc/HaO3bkm2vMvbg65394r99uJPFPU3
         XKQmcppXsNgIQxw2dFesLqHLvd5knr1bTHLd0YPAaNcJo0OA3jW4p2Ke7zENQePy+JV1
         5tM/icOdhJdlF/hvNsj5PqQ2CtO34lv93epbMPIjLaTt4Bz8FDXR4WL9W6O9TG7D2C/T
         HLRk/EkCJei99aAX06/oMdpBNrgMBOZDTgFOD6fJVyFSSVLWkEhEobOEEFDzjqD4R75g
         VOCFYpMmH/91dLEiUte/H/sxPYdWCWD+2HAQ6iFdbZaF+qUAligW7qeFwzs9afZ9z8b8
         PR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693297114; x=1693901914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAL+QW1Uxu14SX9zM6XGspJb7wIOSyL2pK7dTNh/26U=;
        b=S7DXIfYKuXEuo63aSVKlAoJqzMsxgJDDtEhR6iNdNq5aZLZQ9ltWkNmSqFsyOo0Zkj
         cUtZfLzc2LlEb2+TE9CaHNM8ETlUnHXzIaL+Z6MYH+BZDZ4VS1IBlsBUK26wH66UwxKu
         I438KNlHDxtD4+d9aYFu6YQZnCHirYaYa4dGallc/vtGqzWyHJk3TAKn899XJ4U3TZrW
         5nJeq0C27Boorj1F32+fQdZ4Bqd3JfTqlykogzqtwWJC/2qnXNv/jLyFB397GrieTE7o
         hM72Zw/rvfWhXo5Wyu0i+z0j0P44xnR2pwQMhsZTN71NO5WSysJfxuDfkU35PEHARbfB
         AMNQ==
X-Gm-Message-State: AOJu0Yy028DC8NIEBdec4qdhZd4V/ik2kkvpauh19FMV5gUprF3go7Mp
        qvhVc07qeAEORhx+ukhFiQX41g==
X-Google-Smtp-Source: AGHT+IG2+d5PEh9rBmWoOPU9HPi/XpqQcvKK3PEkc3ZJaZR3D/RfTXVQfgYCM+c+SUI99a4J2q6IlA==
X-Received: by 2002:aa7:d1cc:0:b0:52a:250e:a052 with SMTP id g12-20020aa7d1cc000000b0052a250ea052mr14348868edp.7.1693297114502;
        Tue, 29 Aug 2023 01:18:34 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id r9-20020aa7da09000000b005236b47116asm5402296eds.70.2023.08.29.01.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 01:18:34 -0700 (PDT)
Message-ID: <8b7bada9-3898-1b60-3dea-766a760412f7@linaro.org>
Date:   Tue, 29 Aug 2023 10:18:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 06/11] firmware: qcom-shm-bridge: new driver
Content-Language: en-US
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
 <20230828192507.117334-7-bartosz.golaszewski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230828192507.117334-7-bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 21:25, Bartosz Golaszewski wrote:
> This module is a platform driver that also exposes an interface for
> kernel users to allocate blocks of memory shared with the trustzone.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/firmware/Kconfig                 |   8 +
>  drivers/firmware/Makefile                |   1 +
>  drivers/firmware/qcom-shm-bridge.c       | 452 +++++++++++++++++++++++
>  include/linux/firmware/qcom/shm-bridge.h |  32 ++
>  4 files changed, 493 insertions(+)
>  create mode 100644 drivers/firmware/qcom-shm-bridge.c
>  create mode 100644 include/linux/firmware/qcom/shm-bridge.h
> 

...

> +/**
> + * qcom_shm_bridge_to_phys_addr - Translate address from virtual to physical.
> + *
> + * @vaddr: Virtual address to translate.
> + *
> + * Return:
> + * Physical address corresponding to 'vaddr'.
> + */
> +phys_addr_t qcom_shm_bridge_to_phys_addr(void *vaddr)
> +{
> +	struct qcom_shm_bridge_chunk *chunk;
> +	struct qcom_shm_bridge_pool *pool;
> +
> +	guard(spinlock_irqsave)(&qcom_shm_bridge_chunks_lock);
> +
> +	chunk = radix_tree_lookup(&qcom_shm_bridge_chunks,
> +				  (unsigned long)vaddr);
> +	if (!chunk)
> +		return 0;
> +
> +	pool = chunk->parent;
> +
> +	guard(spinlock_irqsave)(&pool->lock);

Why both locks are spinlocks? The locks are used quite a lot.

> +
> +	return gen_pool_virt_to_phys(pool->genpool, (unsigned long)vaddr);
> +}
> +EXPORT_SYMBOL_GPL(qcom_shm_bridge_to_phys_addr);
> +
> +static int qcom_shm_bridge_probe(struct platform_device *pdev)
> +{
> +	struct qcom_shm_bridge_pool *default_pool;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	/*
> +	 * We need to wait for the SCM device to be created and bound to the
> +	 * SCM driver.
> +	 */
> +	if (!qcom_scm_is_available())
> +		return -EPROBE_DEFER;

I think we miss here (and in all other drivers) device links to qcm.

> +
> +	ret = qcom_scm_enable_shm_bridge();
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable the SHM bridge\n");
> +
> +	default_pool = qcom_shm_bridge_pool_new_for_dev(
> +				dev, qcom_shm_bridge_default_pool_size);
> +	if (IS_ERR(default_pool))
> +		return dev_err_probe(dev, PTR_ERR(default_pool),
> +				     "Failed to create the default SHM Bridge pool\n");
> +
> +	WRITE_ONCE(qcom_shm_bridge_default_pool, default_pool);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id qcom_shm_bridge_of_match[] = {
> +	{ .compatible = "qcom,shm-bridge", },
> +	{ }
> +};
> +
> +static struct platform_driver qcom_shm_bridge_driver = {
> +	.driver = {
> +		.name = "qcom-shm-bridge",
> +		.of_match_table = qcom_shm_bridge_of_match,
> +		/*
> +		 * Once enabled, the SHM Bridge feature cannot be disabled so
> +		 * there's no reason to ever unbind the driver.
> +		 */
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe = qcom_shm_bridge_probe,
> +};
> +
> +static int __init qcom_shm_bridge_init(void)
> +{
> +	return platform_driver_register(&qcom_shm_bridge_driver);
> +}
> +subsys_initcall(qcom_shm_bridge_init);

Why this is part of subsystem? Should be rather device_initcall... or
simply module (and a tristate).

Best regards,
Krzysztof

