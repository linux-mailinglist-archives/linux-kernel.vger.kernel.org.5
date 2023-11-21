Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73D27F29A3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbjKUKCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjKUKCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:02:02 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6A598
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:01:58 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b26d700a1so5250115e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700560917; x=1701165717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y6pAMrXZCsC9+OWXdFpSmvCkHlA/ZfvZjJUb02puI8w=;
        b=kFyqKSJiROcVCCqud7oMvHT7F4DB8RImz+H0dBN8qrLPW/IDnvHxaZ4qMG77lk4lFi
         LRel0+SRV3rm3mBbUUspLJYlgLPVcmVYgTai42yr+V0VwJ2XDAgm06x6unyGOjPQ4rfN
         Wsy9cD5OrfwQLmV5OKNfWvu1fQfgfMeGDx2xkGg9eY1LIWK8HJKf/I2vd5IXloaCxVH8
         reTUpmN2Qp+5VyJTwtfGM+vQECf/qL4Dr4IMvQ00Oc6tQ43c1sBttsax3UE4kJegAu6M
         qXgb+agr4oHI8SX1StbYkV6/WtPPbHw+YBJbFECY5YzyWrUhwU9U2ihRf21C97R/KA5H
         9mCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700560917; x=1701165717;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6pAMrXZCsC9+OWXdFpSmvCkHlA/ZfvZjJUb02puI8w=;
        b=QSCJUK1EX45kNcoyXxYyQdLrZenv/uoqqqAXh6d5jf9YteyVfwFd5L+Osmelss6iz8
         LU5+65Os8QB5ptoeYt61XYGvXv8qQZIL/8lykCxkNJABc25zuiMOlfIMzE49ulEI7rP/
         4vLBHB+mxRtZOR1d/oaebyiNzR8+sohPV/yBTZwb+a8dFYLihxaeZgYMbnoQp7KlLLWO
         wjeurtHxesOFqNC2Ka2s0MAVCHgbb2asSS0CsSBMW9ierWjHCir0TtDhY9lq2IJuQ0PE
         TbLWFNzG4m4rROGq9e1uXrdFEwZ/f2hY8YrgtJZIqyA4sapvYD7OlPZhxHh/qixM6XMb
         FStA==
X-Gm-Message-State: AOJu0YwYdFdXWdH4EP/i5DHa1i8AyTEJG7OSulzRi8YdH9Peqg3FTvXV
        befdOrVLRv8z+Zu8Kcafq32o3g==
X-Google-Smtp-Source: AGHT+IGWt5NlNLAhrNC/AuSQRmP2bnbVaJFrxzDxhd0d0AXhNycPe643EY1hpVXWh5mmdOrSQEHQKg==
X-Received: by 2002:a05:600c:3b25:b0:407:3b6d:b561 with SMTP id m37-20020a05600c3b2500b004073b6db561mr6789472wms.9.1700560917051;
        Tue, 21 Nov 2023 02:01:57 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id f12-20020adff44c000000b003313e4dddecsm13821903wrp.108.2023.11.21.02.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 02:01:56 -0800 (PST)
Message-ID: <09b29f1f-a42b-49f7-afca-f82357acd4c8@linaro.org>
Date:   Tue, 21 Nov 2023 11:01:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rtc: add rtc controller support for Sophgo CV1800B
 SoC
Content-Language: en-US
To:     Jingbao Qiu <qiujingbao.dlmu@gmail.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, krzysztof.kozlowski+dt@linaro.org,
        chao.wei@sophgo.com, unicorn_wang@outlook.com, conor+dt@kernel.org,
        robh+dt@kernel.org, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231121094642.2973795-1-qiujingbao.dlmu@gmail.com>
 <20231121094642.2973795-3-qiujingbao.dlmu@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231121094642.2973795-3-qiujingbao.dlmu@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 21/11/2023 10:46, Jingbao Qiu wrote:
> Implement the RTC driver for CV1800B, which able to provide time and
> alarm functionality.
> 
> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> ---
>  drivers/rtc/Kconfig       |  10 ++
>  drivers/rtc/Makefile      |   1 +
>  drivers/rtc/rtc-cv1800b.c | 293 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 304 insertions(+)
>  create mode 100644 drivers/rtc/rtc-cv1800b.c

Bindings were not tested, so I assume you did not compile the code
either. Please confirm that you fixed all warnings pointed out by W=1
builds, smatch and sparse. All of them.

> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 3814e0845e77..2089cceea38c 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1103,6 +1103,16 @@ config RTC_DRV_DS2404
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-ds2404.
>  
> +config RTC_DRV_CV1800B
> +	tristate "Sophgo CV1800B RTC"
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	help
> +	  If you say yes here you will get support for the
> +	  RTC of the Sophgo CV1800B SOC.
> +
> +	  This depend on ARCH_SOPHGO and COMPILE_TEST. Please
> +	  first config that.

...

> +static int cv1800b_rtc_probe(struct platform_device *pdev)
> +{
> +	struct cv1800b_rtc_priv *rtc;
> +	struct resource *res;
> +	int ret;
> +
> +	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
> +	if (!rtc)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	rtc->core_map = devm_ioremap_resource(&pdev->dev, res);

Use helper combining these two calls.

> +	if (IS_ERR(rtc->core_map)) {
> +		ret = PTR_ERR(rtc->core_map);
> +		goto err;
> +	}
> +
> +	rtc->irq = platform_get_irq(pdev, 0);
> +	platform_set_drvdata(pdev, rtc);

Your code has random order. First you get IRQ, then you check its value,
then you go further.

> +	if (rtc->irq < 0) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	ret =
> +	    devm_request_irq(&pdev->dev, rtc->irq, cv1800b_rtc_irq_handler,

Wrong wrapping.

> +			     IRQF_SHARED, "rtc alarm", &pdev->dev);

Why shared?

> +	if (ret)
> +		goto err;
> +
> +	rtc->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(rtc->clk)) {
> +		dev_err(&pdev->dev, "no clock");

This code is not ready for upstream. There are multiple things wrong here.

First, syntax is return dev_err_probe.

Second, you do not have clocks and you do not allow them! Just open your
binding.

Third, use wrapper - devm_clk_get_enable or something like that.


> +		ret = PTR_ERR(rtc->clk);
> +		goto err;
> +	}

Blank line.

> +	ret = clk_prepare_enable(rtc->clk);
> +	if (ret)
> +		goto err;

Blank line.

> +	ret = cv1800b_rtc_softinit(rtc);
> +	if (ret)
> +		goto err;
> +	cv1800b_rtc_alarm_irq_enable(&pdev->dev, 1);
> +	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
> +	if (IS_ERR(rtc->rtc_dev)) {
> +		ret = PTR_ERR(rtc->rtc_dev);
> +		goto err;
> +	}
> +	rtc->rtc_dev->range_max = U32_MAX;
> +	rtc->rtc_dev->ops = &cv800b_rtc_ops;
> +
> +	return rtc_register_device(rtc->rtc_dev);
> +err:
> +	return dev_err_probe(&pdev->dev, ret, "Failed to init cv1800b rtc\n");

Drop, just return.

Best regards,
Krzysztof

