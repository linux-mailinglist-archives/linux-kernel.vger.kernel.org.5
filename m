Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0F07DDD0C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjKAHP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjKAHPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:15:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43E6E4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 00:15:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9d267605ceeso518519066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 00:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698822946; x=1699427746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CpCLipAbLr8Dr2vPD2scJOySJWTj/POf6fuygWnoTxU=;
        b=Ps0S3IAiHVX+DbINHTAqwOMIt9FUbje8cC6Z30nzw0IAqypl9EpV7RZW6DAa7dLc4I
         Xdq8ZesGbj2/m/Pc2MimB6MCoW+35zzq/FAbo10aI4+DI8WyrQnTDNA6xdIzHs3TSd9U
         fVAA2I7yQvPQghUO7tLL7EiDvL9+y68BCue7EYRK1hMcUnvb9TEN7a/HVhuP9N/lT6NB
         UsWKodP/ul4NHjUH04peMq7ehEgDWG/mAMjWBaKgbdb8s6DddP/gegO6UaIJmx4H5gSu
         +H9TVI38ZqsfTtnvuzvviMmgAnQqNjfZuPNIQ/2i7i24ztho7N5blW/2TGJidlgKr80Q
         TOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698822946; x=1699427746;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpCLipAbLr8Dr2vPD2scJOySJWTj/POf6fuygWnoTxU=;
        b=oYQvgz+9MgoGKDKk5S8NIf2C5+s73fmek00yLLTRqXL++yFp3CjBUDVBcECfTDdvWa
         5rc6RbMWzh7TWRKV9lQ3HoU/01Ee29FbXhyHOpIFUbjW/8IDwhxrttQYCMY2nXhQB7he
         fgZAzqa6S4bfDHWgEtEZa16dUZPuki/Nq24TR0zTPrp8iwZ/P150PuE84wxt+kUNQvVe
         LsKs/nBBh2CwXR16VmOkDw5hbvBLXWxEIJ3rSgY5urttYZKPEKlhv/0sEcs+hgG3qI+N
         e5h6N73OmDXoscdnx+uyZvQ9nXg70ACgcDu4VuTbmDPimAIXcLoNsympVqyHni4emv7g
         nTTQ==
X-Gm-Message-State: AOJu0YySjc5HaQfs/uqxsq6BZHe3A2jX1awgPwqax5GR/Ws9mr5rsB/u
        F7wg6uSZMchdOPubTcpBKNbXZw==
X-Google-Smtp-Source: AGHT+IHBzDnEU3sZNzIb1iFrj72jfWdxiV4xte+nzG+0NUPxkyB5prhMBWpsaG9br3UId8caGScDtQ==
X-Received: by 2002:a17:907:7d93:b0:9b2:b7f2:bc7b with SMTP id oz19-20020a1709077d9300b009b2b7f2bc7bmr1054404ejc.37.1698822946113;
        Wed, 01 Nov 2023 00:15:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id m12-20020a17090607cc00b009c7608eb499sm2055003ejc.94.2023.11.01.00.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 00:15:45 -0700 (PDT)
Message-ID: <e18a7ee0-a5e3-4180-9f8a-99b21d1303e6@linaro.org>
Date:   Wed, 1 Nov 2023 08:15:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gpio: realtek: Add GPIO support for RTD SoC variants
Content-Language: en-US
To:     Tzuyi Chang <tychang@realtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231101025802.3744-1-tychang@realtek.com>
 <20231101025802.3744-2-tychang@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231101025802.3744-2-tychang@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2023 03:58, Tzuyi Chang wrote:
> This commit adds GPIO support for Realtek DHC RTD SoCs.

Please do not use "This commit/patch", but imperative mood. See longer
explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> This driver enables configuration of GPIO direction, GPIO values, GPIO
> debounce settings and handles GPIO interrupts.
> 
> Signed-off-by: Tzuyi Chang <tychang@realtek.com>
> ---

...

> +
> +static int rtd_gpio_probe(struct platform_device *pdev)
> +{
> +	struct rtd_gpio *data;
> +	const struct of_device_id *match;
> +	struct device_node *node;
> +	int ret;
> +	int i;
> +
> +	node = pdev->dev.of_node;
> +	match = of_match_node(rtd_gpio_of_matches, pdev->dev.of_node);
> +	if (!match || !match->data)
> +		return -EINVAL;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->assert_irq = irq_of_parse_and_map(node, 0);
> +	if (!data->assert_irq)
> +		goto deferred;
> +
> +	data->deassert_irq = irq_of_parse_and_map(node, 1);
> +	if (!data->deassert_irq)
> +		goto deferred;

So this goes to cleanup path...

> +
> +	data->info = match->data;
> +	spin_lock_init(&data->lock);
> +
> +	data->base = of_iomap(node, 0);
> +	if (!data->base)
> +		return -ENXIO;

But this does not? What?

> +
> +	data->irq_base = of_iomap(node, 1);
> +	if (!data->irq_base)
> +		return -ENXIO;
> +
> +	data->gpio_chip.parent = &pdev->dev;
> +	data->gpio_chip.label = dev_name(&pdev->dev);
> +	data->gpio_chip.of_gpio_n_cells = 2;
> +	data->gpio_chip.base = data->info->gpio_base;
> +	data->gpio_chip.ngpio = data->info->num_gpios;
> +	data->gpio_chip.request = rtd_gpio_request;
> +	data->gpio_chip.free = rtd_gpio_free;
> +	data->gpio_chip.get_direction = rtd_gpio_get_direction;
> +	data->gpio_chip.direction_input = rtd_gpio_direction_input;
> +	data->gpio_chip.direction_output = rtd_gpio_direction_output;
> +	data->gpio_chip.set = rtd_gpio_set;
> +	data->gpio_chip.get = rtd_gpio_get;
> +	data->gpio_chip.set_config = rtd_gpio_set_config;
> +	data->gpio_chip.to_irq = rtd_gpio_to_irq;
> +	data->irq_chip = rtd_gpio_irq_chip;
> +	data->irq_chip.name = data->info->name;
> +
> +	ret = devm_gpiochip_add_data(&pdev->dev, &data->gpio_chip, data);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Adding GPIO chip failed (%d)\n", ret);

And here no cleanup? It's some random choice.

> +		return ret;
> +	}
> +
> +	data->domain = irq_domain_add_linear(node, data->gpio_chip.ngpio,
> +				&irq_domain_simple_ops, data);
> +	if (!data->domain) {
> +		devm_kfree(&pdev->dev, data);

NAK, test your patch.

> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < data->gpio_chip.ngpio; i++) {
> +		int irq = irq_create_mapping(data->domain, i);
> +
> +		irq_set_chip_data(irq, data);
> +		irq_set_chip_and_handler(irq, &data->irq_chip, handle_simple_irq);
> +	}
> +
> +	irq_set_chained_handler_and_data(data->assert_irq, rtd_gpio_assert_irq_handle, data);
> +	irq_set_chained_handler_and_data(data->deassert_irq, rtd_gpio_deassert_irq_handle, data);
> +
> +	dev_dbg(&pdev->dev, "probed\n");

Nop, drop all silly, simple entry/exit messages.

> +
> +	return 0;
> +
> +deferred:
> +	devm_kfree(&pdev->dev, data);

NAK, test your patch.

> +	return -EPROBE_DEFER;
> +}
> +
> +static struct platform_driver rtd_gpio_platform_driver = {
> +	.driver = {
> +		.name = "gpio-rtd",
> +		.of_match_table = rtd_gpio_of_matches,
> +	},
> +	.probe = rtd_gpio_probe,
> +};
> +
> +static int rtd_gpio_init(void)
> +{
> +	return platform_driver_register(&rtd_gpio_platform_driver);
> +}
> +
> +subsys_initcall(rtd_gpio_init);
> +
> +static void __exit rtd_gpio_exit(void)
> +{
> +	platform_driver_unregister(&rtd_gpio_platform_driver);
> +}
> +module_exit(rtd_gpio_exit);
> +
> +MODULE_DESCRIPTION("Realtek DHC SoC gpio driver");
> +MODULE_LICENSE("GPL v2");

Best regards,
Krzysztof

