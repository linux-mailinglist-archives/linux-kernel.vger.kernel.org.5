Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E9676518B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjG0KoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjG0KoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:44:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598B22125
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:44:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-991da766865so108010566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690454648; x=1691059448;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SnWKErK3zLv3fa3cgBV53I392/gHvMJGHqSQ8OYW9hU=;
        b=LgE++r/Sumr6b+xq5qBd5x39kS5MLVffOScuMgDhlhI7EA/39BgJuSo1UckalOEI9S
         hoiSfgNqH5cR/9j7vsotArp0dE/m/7I8DH2/i7QDSqg2pvICIS+S1yqX4234cQNl0Qfx
         0sZKzpLkLFVaEThuun6gfAwc1hT/8vHTUOyRmxfVe1gaIUn44+88OXLMT40nfqiI9414
         ldtbuTJIhmdzQrlqKxdlfPrtNct+opilao8mKMnExMS2vqrmvmi2QXdKNN3EoIof4R5k
         R7WVY4ouDg8VT4Qag9M88f1/ikliODaqSJIfxO2y+HF9DqYwNU7Y6mQ1XHJs5nDNRvOH
         cG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690454648; x=1691059448;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnWKErK3zLv3fa3cgBV53I392/gHvMJGHqSQ8OYW9hU=;
        b=PcgLeUZ8XB9BmNn28ywh8MhlOYrngT6w2S31A9iF3O5v8mkmgJMvswOJ1oI1Ecrcy5
         ASV23h2zdHMYT2aWFY+2Sc7Lb1DLAuB1XukWcLq46gH5HeyVqp0EJ9XeIdZJym9rN6nn
         mDE6/xkd9YPtL5Zy1w9eUte35lOt9kBLve0FY5dHNigNf/hMiYBbNIOPYsk3ST3cdHH8
         sfToVcsQArxVKeidv66kEnUQpw4buEWa7JTPvxcnScqCiZJ29KJ8iLO1fPoNI73KAR/N
         583T1Xuuqf9Jq3zJaMV7LLlk3d7Mx0rn0qJVOtbm8aJaVjoVUGVIu7CXn9i2RhGirHe9
         9drQ==
X-Gm-Message-State: ABy/qLZnmxPsd6EL+gO4iEAc8tsnc8CrUPfglKfBrMhL2/jl6yt0nY8q
        elKAYn3uBJ0hmVDIWi3uxTjvNw==
X-Google-Smtp-Source: APBJJlGuLK4tiPTUPs0SC4M5utpwMeT583KSVJlvEjgxvc1rVWcFxi9dGuC5aBoxS/hDLPLtWthXfA==
X-Received: by 2002:a17:906:3092:b0:98e:37fe:691b with SMTP id 18-20020a170906309200b0098e37fe691bmr1659057ejv.34.1690454647186;
        Thu, 27 Jul 2023 03:44:07 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id b10-20020a170906490a00b0099bd6ef67e8sm618404ejq.78.2023.07.27.03.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 03:44:06 -0700 (PDT)
Message-ID: <f6fab6b7-0cfb-6aa5-2043-6c789709d04a@linaro.org>
Date:   Thu, 27 Jul 2023 11:44:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 2/2] nvmem: sec-qfprom: Add Qualcomm secure QFPROM
 support
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230724083849.8277-1-quic_kbajaj@quicinc.com>
 <20230724083849.8277-3-quic_kbajaj@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230724083849.8277-3-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/07/2023 09:38, Komal Bajaj wrote:
> For some of the Qualcomm SoC's, it is possible that
> some of the fuse regions or entire qfprom region is
> protected from non-secure access. In such situations,
> Linux will have to use secure calls to read the region.
> With that motivation, add secure qfprom driver.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>   drivers/nvmem/Kconfig      |  13 +++++
>   drivers/nvmem/Makefile     |   2 +
>   drivers/nvmem/sec-qfprom.c | 101 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 116 insertions(+)
>   create mode 100644 drivers/nvmem/sec-qfprom.c
> 

> diff --git a/drivers/nvmem/sec-qfprom.c b/drivers/nvmem/sec-qfprom.c
> new file mode 100644
> index 000000000000..bc68053b7d94
> --- /dev/null
> +++ b/drivers/nvmem/sec-qfprom.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>

> +
> +static int sec_qfprom_probe(struct platform_device *pdev)
> +{
> +	struct nvmem_config econfig = {
> +		.name = "sec-qfprom",
> +		.stride = 1,
> +		.word_size = 1,
> +		.id = NVMEM_DEVID_AUTO,
> +		.reg_read = sec_qfprom_reg_read,
> +	};
> +	struct device *dev = &pdev->dev;
> +	struct nvmem_device *nvmem;
> +	struct sec_qfprom *priv;
> +	struct resource *res;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
> +
> +	priv->base = res->start;
> +
> +	econfig.size = resource_size(res);
> +	econfig.dev = dev;
> +	econfig.priv = priv;
> +
> +	priv->dev = dev;
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;

Any reason why we need to enable pm runtime for this driver? As Am not 
seeing any pm runtime handlers or users in this driver.


--srini
> +
> +	nvmem = devm_nvmem_register(dev, &econfig);
> +
> +	return PTR_ERR_OR_ZERO(nvmem);
> +}
> +
> +static const struct of_device_id sec_qfprom_of_match[] = {
> +	{ .compatible = "qcom,sec-qfprom" },
> +	{/* sentinel */},
> +};
> +MODULE_DEVICE_TABLE(of, sec_qfprom_of_match);
> +
> +static struct platform_driver qfprom_driver = {
> +	.probe = sec_qfprom_probe,
> +	.driver = {
> +		.name = "qcom_sec_qfprom",
> +		.of_match_table = sec_qfprom_of_match,
> +	},
> +};
> +module_platform_driver(qfprom_driver);
> +MODULE_DESCRIPTION("Qualcomm Secure QFPROM driver");
> +MODULE_LICENSE("GPL");
> --
> 2.40.1
> 
