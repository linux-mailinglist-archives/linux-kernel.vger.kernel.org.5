Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558C27DA5FB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 10:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjJ1IwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 04:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJ1IwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 04:52:24 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84F610A
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 01:52:21 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c518a1d83fso43927541fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698483140; x=1699087940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Z9vB9VbZGgvTRVizPNnWhkdTc6ZaUyij5O3MqvXo+E=;
        b=cQWgT6idAcmJyn6zHTFc2krb9mD18hBVEdCCzKqKABLuUf0cFv4K7IwNoWdN8tUQ8u
         vR36rcx2jfdDNE6F/UV4OtkSUAzyZMQmE0fdfg4/xivSAa4qafwq/pp/Ekav4IfboWh/
         l0CQ5rwlQD5Tbgs1/E6wJBuKhLFBUaDLcgS3HZNxOhgPhnNBWfzEc0b0KKE8ZOTg1UwR
         fLj3sbUlv16HM26UgSsUE2s5vQtRtbm1h7qCueZ985fUNqL5P3Y6WJJGtgLCO5hILvvH
         CgO0XI/kheJyN05qhsARtqeggtmjsxV6/MWP2sX0FD5q5GF8st7WSrXQx93VUVM8M7xZ
         1mLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698483140; x=1699087940;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z9vB9VbZGgvTRVizPNnWhkdTc6ZaUyij5O3MqvXo+E=;
        b=McWrCWev04/zYX2ku1nGFbxj0CFK6EVCcfQnD/bcEwd4Y2GDMlEBf0jDZDSjw1lRHl
         SrOMUif1U0lJpbmiDaBDJBsVzFvzXQpi8YhCGOBI4r344YDkLtJhdsHxcaQpQQ3ifLxn
         1QdFz8zfo9CoD7GBi00GV97hIGUMGEQ2yy6HNRPZmi+ancZTmnT9fHJ8iDpSCTDpDFRb
         3gOEtNOWpB3rbIsqhiG3Xj/csNMrRIFeaHIKqhxmeOSh+B9sV5ZRhD9j5ACqobtudshb
         fPIyLOGtC2OzDGO2iuYJ8nkJGMN3ztuVyOfs2usC353srxLMQQKJc9BRq70dTjOf3YH+
         CBMQ==
X-Gm-Message-State: AOJu0YwR/iS7ryxAZF7K7wJ6EtreiudWXShh1HhrNt7d6zzM15vDs0AW
        WAUoJkYJ6TznhHIKC97JK7FtXA==
X-Google-Smtp-Source: AGHT+IFYfc7ZFlUFJOumyOmfk5FdBsPYEnDsaUjipT1I3jn3dt3zk4NSwZ6bmHrjK7+FatlEEuqV8g==
X-Received: by 2002:a05:651c:38c:b0:2c5:2df8:d31c with SMTP id e12-20020a05651c038c00b002c52df8d31cmr3413459ljp.21.1698483140178;
        Sat, 28 Oct 2023 01:52:20 -0700 (PDT)
Received: from [192.168.0.22] ([78.10.206.168])
        by smtp.gmail.com with ESMTPSA id m7-20020a2e8707000000b002b6e77e87fcsm571403lji.68.2023.10.28.01.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Oct 2023 01:52:19 -0700 (PDT)
Message-ID: <c66bb1fe-152f-492f-ada6-274162515c58@linaro.org>
Date:   Sat, 28 Oct 2023 10:52:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Input: Add driver for Novatek NT519XX series
 touchscreen devices
Content-Language: en-US
To:     Wei-Shih Lin <frank101417@gmail.com>, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231025082054.1190-1-Weishih_Lin@novatek.com.tw>
 <20231025082054.1190-3-Weishih_Lin@novatek.com.tw>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231025082054.1190-3-Weishih_Lin@novatek.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 10:20, Wei-Shih Lin wrote:
> This patch adds support for Novatek NT519XX series touchscreen devices.
> Existing Novatek touchscreen driver code developed for Acer Iconia One 7
> B1-750 tablet with Novatek IC NT11205 is novatek-nvt-ts.c in the path
> drivers/input/touchscreen/. However, this patch supports touch features
> for automotive display with Novatek TDDI NT519XX.
> 


> +
> +static int32_t nvt_ts_resume(struct device *dev)
> +{
> +	if (bTouchIsAwake) {
> +		NVT_LOG("Touch is already resume.\n");
> +		return 0;
> +	}
> +
> +	mutex_lock(&ts->lock);
> +
> +	NVT_LOG("start\n");

Sorry, you cannot have such silly debugs.

> +
> +	nvt_bootloader_reset();
> +	nvt_check_fw_reset_state(RESET_STATE_NORMAL_RUN);
> +
> +	nvt_irq_enable(true);
> +
> +	bTouchIsAwake = 1;
> +
> +	mutex_unlock(&ts->lock);
> +
> +	NVT_LOG("end\n");



....

> +#endif
> +
> +static struct i2c_driver nvt_i2c_driver = {
> +	.probe		= nvt_ts_probe,
> +	.remove		= nvt_ts_remove,
> +	.shutdown	= nvt_ts_shutdown,
> +	.id_table	= nvt_ts_id,
> +	.driver = {
> +		.name	= NVT_I2C_NAME,
> +		.owner	= THIS_MODULE,

Drop

> +#ifdef CONFIG_OF

Nope, drop

> +		.of_match_table = nvt_match_table,
> +#endif
> +	},
> +};
> +
> +static int32_t __init nvt_driver_init(void)
> +{
> +	int32_t ret = 0;
> +
> +	NVT_LOG("start\n");

Drop entire init. Open existing code and use it as template.

> +
> +	bTouchIsAwake = 0;
> +
> +	ret = i2c_add_driver(&nvt_i2c_driver);
> +	if (ret) {
> +		NVT_ERR("Failed to add i2c driver!");
> +		goto err_driver;
> +	}
> +
> +	NVT_LOG("end\n");
> +
> +err_driver:
> +	return ret;
> +}
> +
> +static void __exit nvt_driver_exit(void)
> +{
> +	i2c_del_driver(&nvt_i2c_driver);
> +}
> +
> +module_init(nvt_driver_init);
> +module_exit(nvt_driver_exit);
> +
> +MODULE_DESCRIPTION("Novatek Touchscreen Driver");
> +MODULE_LICENSE("GPL");

This driver has very poor quality. Pointing issues here would be even
too much work. Please start from scratch from existing, accepted and
reviewed driver and customize it for your needs. You will notice that it
does not have all this weird code you put here.

Best regards,
Krzysztof

