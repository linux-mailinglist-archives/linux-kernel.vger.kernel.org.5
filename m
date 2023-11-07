Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3426A7E461E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjKGQfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjKGQfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:35:30 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31AB98
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:35:27 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9dd5879a126so652802066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 08:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699374926; x=1699979726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UiOu+Ralv0dufbdtPJyi6xiJ84oDwqMkQ15EC3ob9to=;
        b=FM597MQiv39GogE+Q1RtSHr4GsQTc9FzOFBGnBDBFg1Dw/eBsWaYDnYBawHlOCobcm
         OW7m248FKM3qtiqSt/WmwlpamdBvYv+aEVR3EytESbWKe+q1Giwjgvj1oo1fcMPiBz+s
         sa3VGXaXO/JkXVG5Gu9jUt1k9TQ3C/febklLcK8Ur72KbFw0iMIJj45S7gVOKj9fOA1i
         Z0LMgtfJ+1fpii0LD2GbVVpaQjxiseHM4QDqklmm74I49LnJoQvG+mqLK6JiSFQ9pO7M
         /yQCavPjFAmzToefdRAefcY3EyhJgGVPwExBXgVKYGo/EejG0KEwj5DHOwflUL7OBajL
         kmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699374926; x=1699979726;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UiOu+Ralv0dufbdtPJyi6xiJ84oDwqMkQ15EC3ob9to=;
        b=vVVVtCCG9bjUb98UKco1yxnDH0YJQNdI3kIsiAIVz6DiXZCIbv3p9EnrPjWbsrCA7K
         8mDqh8GVQlbhEz8K7SeNCMoNYTCaTrAUb2+RzbTETqNDzZ5AmmfwfyobJ83d/uVI2Evh
         O1beBTx88qBeGAuKtBWIoUs9Q1w5G5jm47mMW7Y6Z6PkhgfbSeyFByvSLXkGq5nAGzYe
         yaoEBOT29tjfAtIFNag57zixcxfFzWxEivpAbrv1zvB04CB92HLivAIug/re2D8TDNH4
         KeZRHnAH7zxhHvpe75D+FYhnVUZ5zUIZc8xS+Ys7/U2ssAzeRK+VzGgMF+sHI8EML653
         X9bw==
X-Gm-Message-State: AOJu0YxqUpb7RjG9GM6dpAo9lBQ5dNExWmnsSkSO40cMw6kWaBJTq8KY
        ghA0g0MA6F9UwgxUOspg0ob1lQ==
X-Google-Smtp-Source: AGHT+IE1GHiPCoSyHgjvwCwk2ZXvupW1wadPoDSWt6BqgGGM9z41u7IjQ2xfrDbSFTwENvSvXE2uhg==
X-Received: by 2002:a17:907:7da6:b0:9a9:ef41:e5c7 with SMTP id oz38-20020a1709077da600b009a9ef41e5c7mr20265796ejc.8.1699374926048;
        Tue, 07 Nov 2023 08:35:26 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id a9-20020a17090640c900b009b9977867fbsm1223842ejk.109.2023.11.07.08.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 08:35:25 -0800 (PST)
Message-ID: <07bbb8c3-b6c0-4e5e-8fe9-2fcbb71b7dbc@linaro.org>
Date:   Tue, 7 Nov 2023 17:35:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] crypto: rockchip: add rk3588 driver
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>, davem@davemloft.net,
        heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org
Cc:     ricardo@pardini.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20231107155532.3747113-1-clabbe@baylibre.com>
 <20231107155532.3747113-7-clabbe@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231107155532.3747113-7-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2023 16:55, Corentin Labbe wrote:
> RK3588 have a new crypto IP, this patch adds basic support for it.
> Only hashes and cipher are handled for the moment.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/crypto/Kconfig                        |  29 +
>  drivers/crypto/rockchip/Makefile              |   5 +
>  drivers/crypto/rockchip/rk2_crypto.c          | 739 ++++++++++++++++++
>  drivers/crypto/rockchip/rk2_crypto.h          | 246 ++++++
>  drivers/crypto/rockchip/rk2_crypto_ahash.c    | 344 ++++++++
>  drivers/crypto/rockchip/rk2_crypto_skcipher.c | 576 ++++++++++++++
>  6 files changed, 1939 insertions(+)
>  create mode 100644 drivers/crypto/rockchip/rk2_crypto.c
>  create mode 100644 drivers/crypto/rockchip/rk2_crypto.h
>  create mode 100644 drivers/crypto/rockchip/rk2_crypto_ahash.c
>  create mode 100644 drivers/crypto/rockchip/rk2_crypto_skcipher.c
> 
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 79c3bb9c99c3..b6a2027b1f9a 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -660,6 +660,35 @@ config CRYPTO_DEV_ROCKCHIP_DEBUG
>  	  the number of requests per algorithm and other internal stats.
>  
>  
> +config CRYPTO_DEV_ROCKCHIP2
> +	tristate "Rockchip's cryptographic offloader V2"
> +	depends on OF && ARCH_ROCKCHIP
> +	depends on PM
> +	select CRYPTO_ECB
> +	select CRYPTO_CBC
> +	select CRYPTO_AES
> +	select CRYPTO_MD5
> +	select CRYPTO_SHA1
> +	select CRYPTO_SHA256
> +	select CRYPTO_SHA512
> +	select CRYPTO_SM3_GENERIC
> +	select CRYPTO_HASH
> +	select CRYPTO_SKCIPHER
> +	select CRYPTO_ENGINE
> +
> +	help
> +	  This driver interfaces with the hardware crypto offloader present
> +	  on RK3566, RK3568 and RK3588.
> +
> +config CRYPTO_DEV_ROCKCHIP2_DEBUG
> +	bool "Enable Rockchip V2 crypto stats"
> +	depends on CRYPTO_DEV_ROCKCHIP2
> +	depends on DEBUG_FS
> +	help
> +	  Say y to enable Rockchip crypto debug stats.
> +	  This will create /sys/kernel/debug/rk3588_crypto/stats for displaying
> +	  the number of requests per algorithm and other internal stats.
> +
>  config CRYPTO_DEV_ZYNQMP_AES
>  	tristate "Support for Xilinx ZynqMP AES hw accelerator"
>  	depends on ZYNQMP_FIRMWARE || COMPILE_TEST
> diff --git a/drivers/crypto/rockchip/Makefile b/drivers/crypto/rockchip/Makefile
> index 785277aca71e..452a12ff6538 100644
> --- a/drivers/crypto/rockchip/Makefile
> +++ b/drivers/crypto/rockchip/Makefile
> @@ -3,3 +3,8 @@ obj-$(CONFIG_CRYPTO_DEV_ROCKCHIP) += rk_crypto.o
>  rk_crypto-objs := rk3288_crypto.o \
>  		  rk3288_crypto_skcipher.o \
>  		  rk3288_crypto_ahash.o
> +
> +obj-$(CONFIG_CRYPTO_DEV_ROCKCHIP2) += rk_crypto2.o
> +rk_crypto2-objs := rk2_crypto.o \
> +		  rk2_crypto_skcipher.o \
> +		  rk2_crypto_ahash.o
> diff --git a/drivers/crypto/rockchip/rk2_crypto.c b/drivers/crypto/rockchip/rk2_crypto.c
> new file mode 100644
> index 000000000000..f3b8d27924da
> --- /dev/null
> +++ b/drivers/crypto/rockchip/rk2_crypto.c
> @@ -0,0 +1,739 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * hardware cryptographic offloader for RK3568/RK3588 SoC
> + *
> + * Copyright (c) 2022-2023, Corentin Labbe <clabbe@baylibre.com>
> + */
> +
> +#include "rk2_crypto.h"
> +#include <linux/clk.h>
> +#include <linux/crypto.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/reset.h>
> +
> +static struct rockchip_ip rocklist = {
> +	.dev_list = LIST_HEAD_INIT(rocklist.dev_list),
> +	.lock = __SPIN_LOCK_UNLOCKED(rocklist.lock),

Drop it, not needed.

> +};
> +

Exposed interfaces need kerneldoc.

> +struct rk2_crypto_dev *get_rk2_crypto(void)
> +{
> +	struct rk2_crypto_dev *first;
> +
> +	spin_lock(&rocklist.lock);
> +	first = list_first_entry_or_null(&rocklist.dev_list,
> +					 struct rk2_crypto_dev, list);
> +	list_rotate_left(&rocklist.dev_list);
> +	spin_unlock(&rocklist.lock);
> +	return first;

This is some spaghetti... Why do need a global list of devices to pass
to crypto callbacks? The context is for that. This does not scale. Drop
entire function.


> +}
> +
> +static const struct rk2_variant rk3568_variant = {
> +	.num_clks = 3,
> +};
> +
> +static const struct rk2_variant rk3588_variant = {
> +	.num_clks = 3,
> +};
> +
> +static int rk2_crypto_get_clks(struct rk2_crypto_dev *dev)
> +{
> +	int i, j, err;
> +	unsigned long cr;
> +
> +	dev->num_clks = devm_clk_bulk_get_all(dev->dev, &dev->clks);
> +	if (dev->num_clks < dev->variant->num_clks) {
> +		dev_err(dev->dev, "Missing clocks, got %d instead of %d\n",
> +			dev->num_clks, dev->variant->num_clks);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < dev->num_clks; i++) {
> +		cr = clk_get_rate(dev->clks[i].clk);
> +		for (j = 0; j < ARRAY_SIZE(dev->variant->rkclks); j++) {
> +			if (dev->variant->rkclks[j].max == 0)
> +				continue;
> +			if (strcmp(dev->variant->rkclks[j].name, dev->clks[i].id))
> +				continue;
> +			if (cr > dev->variant->rkclks[j].max) {
> +				err = clk_set_rate(dev->clks[i].clk,
> +						   dev->variant->rkclks[j].max);
> +				if (err)
> +					dev_err(dev->dev, "Fail downclocking %s from %lu to %lu\n",
> +						dev->variant->rkclks[j].name, cr,
> +						dev->variant->rkclks[j].max);
> +				else
> +					dev_info(dev->dev, "Downclocking %s from %lu to %lu\n",
> +						 dev->variant->rkclks[j].name, cr,
> +						 dev->variant->rkclks[j].max);
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int rk2_crypto_enable_clk(struct rk2_crypto_dev *dev)
> +{
> +	int err;
> +
> +	err = clk_bulk_prepare_enable(dev->num_clks, dev->clks);
> +	if (err)
> +		dev_err(dev->dev, "Could not enable clock clks\n");

Why do you create abstract wrappers over single call?

> +
> +	return err;
> +}
> +
> +static void rk2_crypto_disable_clk(struct rk2_crypto_dev *dev)
> +{
> +	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);

What is the benefit of this?

I know that downstream code likes abstraction layers. You are supposed
to remove all of them when upstreaming.

> +}
> +
> +/*
> + * Power management strategy: The device is suspended until a request
> + * is handled. For avoiding suspend/resume yoyo, the autosuspend is set to 2s.
> + */
> +static int rk2_crypto_pm_suspend(struct device *dev)
> +{

...


> +	}
> +}
> +
> +static const struct of_device_id crypto_of_id_table[] = {
> +	{ .compatible = "rockchip,rk3568-crypto",
> +	  .data = &rk3568_variant,
> +	},
> +	{ .compatible = "rockchip,rk3588-crypto",
> +	  .data = &rk3588_variant,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, crypto_of_id_table);
> +
> +static int rk2_crypto_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rk2_crypto_dev *rkc, *first;
> +	int err = 0;
> +
> +	rkc = devm_kzalloc(&pdev->dev, sizeof(*rkc), GFP_KERNEL);
> +	if (!rkc) {
> +		err = -ENOMEM;

return -ENOMEM

> +		goto err_crypto;
> +	}
> +
> +	rkc->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, rkc);
> +
> +	rkc->variant = of_device_get_match_data(&pdev->dev);
> +	if (!rkc->variant) {
> +		dev_err(&pdev->dev, "Missing variant\n");

How is this possible?

> +		return -EINVAL;
> +	}
> +
> +	rkc->rst = devm_reset_control_array_get_exclusive(dev);
> +	if (IS_ERR(rkc->rst)) {
> +		err = PTR_ERR(rkc->rst);
> +		dev_err(&pdev->dev, "Fail to get resets err=%d\n", err);

Nope, this is just wrong. You do not have any cleanup path. And
regardless of cleanup path, why do you print "Accelerator not
successfully registered? It's an error!

Syntax is:
return dev_err_probe

> +		goto err_crypto;
> +	}
> +
> +	rkc->tl = dma_alloc_coherent(rkc->dev,
> +				     sizeof(struct rk2_crypto_lli) * MAX_LLI,
> +				     &rkc->t_phy, GFP_KERNEL);
> +	if (!rkc->tl) {
> +		dev_err(rkc->dev, "Cannot get DMA memory for task\n");

Run coccinelle.

> +		err = -ENOMEM;

Nope, return dev_err_probe

> +		goto err_crypto;
> +	}
> +
> +	reset_control_assert(rkc->rst);
> +	usleep_range(10, 20);
> +	reset_control_deassert(rkc->rst);
> +
> +	rkc->reg = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(rkc->reg)) {
> +		err = PTR_ERR(rkc->reg);
> +		dev_err(&pdev->dev, "Fail to get resources\n");
> +		goto err_crypto;
> +	}
> +
> +	err = rk2_crypto_get_clks(rkc);
> +	if (err)
> +		goto err_crypto;
> +
> +	rkc->irq = platform_get_irq(pdev, 0);
> +	if (rkc->irq < 0) {
> +		dev_err(&pdev->dev, "control Interrupt is not available.\n");
> +		err = rkc->irq;
> +		goto err_crypto;
> +	}
> +
> +	err = devm_request_irq(&pdev->dev, rkc->irq,
> +			       rk2_crypto_irq_handle, IRQF_SHARED,
> +			       "rk-crypto", pdev);
> +
> +	if (err) {
> +		dev_err(&pdev->dev, "irq request failed.\n");
> +		goto err_crypto;
> +	}
> +
> +	rkc->engine = crypto_engine_alloc_init(&pdev->dev, true);
> +	crypto_engine_start(rkc->engine);
> +	init_completion(&rkc->complete);
> +
> +	err = rk2_crypto_pm_init(rkc);
> +	if (err)
> +		goto err_pm;
> +
> +	err = pm_runtime_resume_and_get(&pdev->dev);
> +
> +	spin_lock(&rocklist.lock);
> +	first = list_first_entry_or_null(&rocklist.dev_list,
> +					 struct rk2_crypto_dev, list);
> +	list_add_tail(&rkc->list, &rocklist.dev_list);
> +	spin_unlock(&rocklist.lock);
> +
> +	if (!first) {
> +		dev_info(dev, "Registers crypto algos\n");
> +		err = rk2_crypto_register(rkc);
> +		if (err) {
> +			dev_err(dev, "Fail to register crypto algorithms");
> +			goto err_register_alg;
> +		}
> +
> +		register_debugfs(rkc);
> +	}
> +
> +	return 0;
> +
> +err_register_alg:
> +	rk2_crypto_pm_exit(rkc);
> +err_pm:
> +	crypto_engine_exit(rkc->engine);
> +err_crypto:
> +	dev_err(dev, "Crypto Accelerator not successfully registered\n");

Drop useless probe success messages.

> +	return err;
> +}
> +
> +static int rk2_crypto_remove(struct platform_device *pdev)
> +{
> +	struct rk2_crypto_dev *rkc = platform_get_drvdata(pdev);
> +	struct rk2_crypto_dev *first;
> +
> +	spin_lock_bh(&rocklist.lock);
> +	list_del(&rkc->list);
> +	first = list_first_entry_or_null(&rocklist.dev_list,
> +					 struct rk2_crypto_dev, list);
> +	spin_unlock_bh(&rocklist.lock);
> +
> +	if (!first) {
> +#ifdef CONFIG_CRYPTO_DEV_ROCKCHIP2_DEBUG
> +		debugfs_remove_recursive(rocklist.dbgfs_dir);
> +#endif
> +		rk2_crypto_unregister();
> +	}
> +	rk2_crypto_pm_exit(rkc);
> +	crypto_engine_exit(rkc->engine);
> +	return 0;
> +}
> +
> +static struct platform_driver crypto_driver = {
> +	.probe		= rk2_crypto_probe,
> +	.remove		= rk2_crypto_remove,
> +	.driver		= {
> +		.name	= "rk2-crypto",
> +		.pm		= &rk2_crypto_pm_ops,
> +		.of_match_table	= crypto_of_id_table,
> +	},
> +};
> +
> +module_platform_driver(crypto_driver);
> +
> +MODULE_DESCRIPTION("Rockchip Crypto Engine cryptographic offloader");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Corentin Labbe <clabbe@baylibre.com>");
> diff --git a/drivers/crypto/rockchip/rk2_crypto.h b/drivers/crypto/rockchip/rk2_crypto.h
> new file mode 100644
> index 000000000000..59cd8be59f70
> --- /dev/null
> +++ b/drivers/crypto/rockchip/rk2_crypto.h
> @@ -0,0 +1,246 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <crypto/aes.h>
> +#include <crypto/xts.h>
> +#include <crypto/engine.h>
> +#include <crypto/internal/des.h>
> +#include <crypto/internal/hash.h>
> +#include <crypto/internal/skcipher.h>
> +#include <crypto/algapi.h>
> +#include <crypto/md5.h>
> +#include <crypto/sha1.h>
> +#include <crypto/sha2.h>
> +#include <crypto/sm3.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/scatterlist.h>
> +#include <linux/hw_random.h>

Nope. This is some insane list of unneeded headers. You include here
only the headers which this header uses. I see just few.


> +
> +#define RK2_CRYPTO_CLK_CTL	0x0000
> +#define RK2_CRYPTO_RST_CTL	0x0004
> +
> +#define RK2_CRYPTO_DMA_INT_EN	0x0008
> +/* values for RK2_CRYPTO_DMA_INT_EN */
> +#define RK2_CRYPTO_DMA_INT_LISTDONE	BIT(0)
> +
> +#define RK2_CRYPTO_DMA_INT_ST	0x000C
> +/* values in RK2_CRYPTO_DMA_INT_ST are the same than in RK2_CRYPTO_DMA_INT_EN */
> +
> +#define RK2_CRYPTO_DMA_CTL	0x0010
> +#define RK2_CRYPTO_DMA_CTL_START	BIT(0)
> +
> +#define RK2_CRYPTO_DMA_LLI_ADDR	0x0014
> +#define RK2_CRYPTO_DMA_ST	0x0018
> +#define RK2_CRYPTO_DMA_STATE	0x001C
> +#define RK2_CRYPTO_DMA_LLI_RADDR	0x0020
> +#define RK2_CRYPTO_DMA_SRC_RADDR	0x0024
> +#define RK2_CRYPTO_DMA_DST_WADDR	0x0028
> +#define RK2_CRYPTO_DMA_ITEM_ID		0x002C
> +
> +#define RK2_CRYPTO_FIFO_CTL	0x0040
> +
> +#define RK2_CRYPTO_BC_CTL	0x0044
> +#define RK2_CRYPTO_AES		(0 << 8)
> +#define RK2_CRYPTO_MODE_ECB	(0 << 4)
> +#define RK2_CRYPTO_MODE_CBC	(1 << 4)
> +#define RK2_CRYPTO_XTS		(6 << 4)
> +
> +#define RK2_CRYPTO_HASH_CTL	0x0048
> +#define RK2_CRYPTO_HW_PAD	BIT(2)
> +#define RK2_CRYPTO_SHA1		(0 << 4)
> +#define RK2_CRYPTO_MD5		(1 << 4)
> +#define RK2_CRYPTO_SHA224	(3 << 4)
> +#define RK2_CRYPTO_SHA256	(2 << 4)
> +#define RK2_CRYPTO_SHA384	(9 << 4)
> +#define RK2_CRYPTO_SHA512	(8 << 4)
> +#define RK2_CRYPTO_SM3		(4 << 4)
> +
> +#define RK2_CRYPTO_AES_ECB		(RK2_CRYPTO_AES | RK2_CRYPTO_MODE_ECB)
> +#define RK2_CRYPTO_AES_CBC		(RK2_CRYPTO_AES | RK2_CRYPTO_MODE_CBC)
> +#define RK2_CRYPTO_AES_XTS		(RK2_CRYPTO_AES | RK2_CRYPTO_XTS)
> +#define RK2_CRYPTO_AES_CTR_MODE		3
> +#define RK2_CRYPTO_AES_128BIT_key	(0 << 2)
> +#define RK2_CRYPTO_AES_192BIT_key	(1 << 2)
> +#define RK2_CRYPTO_AES_256BIT_key	(2 << 2)
> +
> +#define RK2_CRYPTO_DEC			BIT(1)
> +#define RK2_CRYPTO_ENABLE		BIT(0)
> +
> +#define RK2_CRYPTO_CIPHER_ST	0x004C
> +#define RK2_CRYPTO_CIPHER_STATE	0x0050
> +
> +#define RK2_CRYPTO_CH0_IV_0		0x0100
> +
> +#define RK2_CRYPTO_KEY0			0x0180
> +#define RK2_CRYPTO_KEY1			0x0184
> +#define RK2_CRYPTO_KEY2			0x0188
> +#define RK2_CRYPTO_KEY3			0x018C
> +#define RK2_CRYPTO_KEY4			0x0190
> +#define RK2_CRYPTO_KEY5			0x0194
> +#define RK2_CRYPTO_KEY6			0x0198
> +#define RK2_CRYPTO_KEY7			0x019C
> +#define RK2_CRYPTO_CH4_KEY0		0x01c0
> +
> +#define RK2_CRYPTO_CH0_PC_LEN_0		0x0280
> +
> +#define RK2_CRYPTO_CH0_IV_LEN		0x0300
> +
> +#define RK2_CRYPTO_HASH_DOUT_0	0x03A0
> +#define RK2_CRYPTO_HASH_VALID	0x03E4
> +
> +#define RK2_CRYPTO_TRNG_CTL	0x0400
> +#define RK2_CRYPTO_TRNG_START	BIT(0)
> +#define RK2_CRYPTO_TRNG_ENABLE	BIT(1)
> +#define RK2_CRYPTO_TRNG_256	(0x3 << 4)
> +#define RK2_CRYPTO_TRNG_SAMPLE_CNT	0x0404
> +#define RK2_CRYPTO_TRNG_DOUT	0x0410
> +
> +#define CRYPTO_AES_VERSION	0x0680
> +#define CRYPTO_DES_VERSION	0x0684
> +#define CRYPTO_SM4_VERSION	0x0688
> +#define CRYPTO_HASH_VERSION	0x068C
> +#define CRYPTO_HMAC_VERSION	0x0690
> +#define CRYPTO_RNG_VERSION	0x0694
> +#define CRYPTO_PKA_VERSION	0x0698
> +#define CRYPTO_CRYPTO_VERSION	0x06F0
> +
> +#define RK2_LLI_DMA_CTRL_SRC_INT		BIT(10)
> +#define RK2_LLI_DMA_CTRL_DST_INT		BIT(9)
> +#define RK2_LLI_DMA_CTRL_LIST_INT	BIT(8)
> +#define RK2_LLI_DMA_CTRL_LAST		BIT(0)
> +
> +#define RK2_LLI_STRING_LAST		BIT(2)
> +#define RK2_LLI_STRING_FIRST		BIT(1)
> +#define RK2_LLI_CIPHER_START		BIT(0)
> +
> +#define RK2_MAX_CLKS 4
> +
> +#define MAX_LLI 20
> +
> +struct rk2_crypto_lli {
> +	__le32 src_addr;
> +	__le32 src_len;
> +	__le32 dst_addr;
> +	__le32 dst_len;
> +	__le32 user;
> +	__le32 iv;
> +	__le32 dma_ctrl;
> +	__le32 next;
> +};
> +
> +/*
> + * struct rockchip_ip - struct for managing a list of RK crypto instance
> + * @dev_list:		Used for doing a list of rk2_crypto_dev
> + * @lock:		Control access to dev_list
> + * @dbgfs_dir:		Debugfs dentry for statistic directory
> + * @dbgfs_stats:	Debugfs dentry for statistic counters
> + */
> +struct rockchip_ip {
> +	struct list_head	dev_list;
> +	spinlock_t		lock; /* Control access to dev_list */
> +	struct dentry		*dbgfs_dir;
> +	struct dentry		*dbgfs_stats;
> +};
> +
> +struct rk2_clks {
> +	const char *name;
> +	unsigned long max;
> +};
> +
> +struct rk2_variant {
> +	int num_clks;
> +	struct rk2_clks rkclks[RK2_MAX_CLKS];
> +};
> +
> +struct rk2_crypto_dev {
> +	struct list_head		list;
> +	struct device			*dev;
> +	struct clk_bulk_data		*clks;
> +	int				num_clks;
> +	struct reset_control		*rst;
> +	void __iomem			*reg;
> +	int				irq;
> +	const struct rk2_variant *variant;
> +	unsigned long nreq;
> +	struct crypto_engine *engine;
> +	struct completion complete;
> +	int status;
> +	struct rk2_crypto_lli *tl;
> +	dma_addr_t t_phy;
> +};
> +
> +/* the private variable of hash */
> +struct rk2_ahash_ctx {
> +	/* for fallback */
> +	struct crypto_ahash		*fallback_tfm;
> +};
> +
> +/* the private variable of hash for fallback */
> +struct rk2_ahash_rctx {
> +	struct rk2_crypto_dev		*dev;
> +	struct ahash_request		fallback_req;
> +	u32				mode;
> +	int nrsgs;
> +};
> +
> +/* the private variable of cipher */
> +struct rk2_cipher_ctx {
> +	unsigned int			keylen;
> +	u8				key[AES_MAX_KEY_SIZE * 2];
> +	u8				iv[AES_BLOCK_SIZE];
> +	struct crypto_skcipher *fallback_tfm;
> +};
> +
> +struct rk2_cipher_rctx {
> +	struct rk2_crypto_dev		*dev;
> +	u8 backup_iv[AES_BLOCK_SIZE];
> +	u32				mode;
> +	struct skcipher_request fallback_req;   // keep at the end
> +};
> +
> +struct rk2_crypto_template {
> +	u32 type;
> +	u32 rk2_mode;
> +	bool is_xts;
> +	struct rk2_crypto_dev           *dev;

Your indentation is a mess.

> +	union {
> +		struct skcipher_engine_alg	skcipher;
> +		struct ahash_engine_alg	hash;
> +	} alg;
> +	unsigned long stat_req;
> +	unsigned long stat_fb;
> +	unsigned long stat_fb_len;
> +	unsigned long stat_fb_sglen;
> +	unsigned long stat_fb_align;
> +	unsigned long stat_fb_sgdiff;
> +};
> +
> +struct rk2_crypto_dev *get_rk2_crypto(void);
> +int rk2_cipher_run(struct crypto_engine *engine, void *async_req);
> +int rk2_hash_run(struct crypto_engine *engine, void *breq);
> +
> +int rk2_cipher_tfm_init(struct crypto_skcipher *tfm);
> +void rk2_cipher_tfm_exit(struct crypto_skcipher *tfm);
> +int rk2_aes_setkey(struct crypto_skcipher *cipher, const u8 *key,
> +		   unsigned int keylen);
> +int rk2_aes_xts_setkey(struct crypto_skcipher *cipher, const u8 *key,
> +		       unsigned int keylen);
> +int rk2_skcipher_encrypt(struct skcipher_request *req);
> +int rk2_skcipher_decrypt(struct skcipher_request *req);
> +int rk2_aes_ecb_encrypt(struct skcipher_request *req);
> +int rk2_aes_ecb_decrypt(struct skcipher_request *req);
> +int rk2_aes_cbc_encrypt(struct skcipher_request *req);
> +int rk2_aes_cbc_decrypt(struct skcipher_request *req);
> +
> +int rk2_ahash_init(struct ahash_request *req);
> +int rk2_ahash_update(struct ahash_request *req);
> +int rk2_ahash_final(struct ahash_request *req);
> +int rk2_ahash_finup(struct ahash_request *req);
> +int rk2_ahash_import(struct ahash_request *req, const void *in);
> +int rk2_ahash_export(struct ahash_request *req, void *out);
> +int rk2_ahash_digest(struct ahash_request *req);
> +int rk2_hash_init_tfm(struct crypto_ahash *tfm);
> +void rk2_hash_exit_tfm(struct crypto_ahash *tfm);

Missing guards.

> diff --git a/drivers/crypto/rockchip/rk2_crypto_ahash.c b/drivers/crypto/rockchip/rk2_crypto_ahash.c
> new file mode 100644
> index 000000000000..75b8d9893447
> --- /dev/null
> +++ b/drivers/crypto/rockchip/rk2_crypto_ahash.c
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Crypto offloader support for Rockchip RK3568/RK3588
> + *
> + * Copyright (c) 2022-2023 Corentin Labbe <clabbe@baylibre.com>
> + */
> +#include <asm/unaligned.h>
> +#include <linux/iopoll.h>

There is no way this file needs only two headers. Each unit must include
everything it uses.

> +#include "rk2_crypto.h"

So here you stuffed all the includes... no.


> +
> +int rk2_hash_run(struct crypto_engine *engine, void *breq)
> +{
> +	struct ahash_request *areq = container_of(breq, struct ahash_request, base);
> +	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
> +	struct rk2_ahash_rctx *rctx = ahash_request_ctx(areq);
> +	struct ahash_alg *alg = crypto_ahash_alg(tfm);
> +	struct rk2_crypto_template *algt = container_of(alg, struct rk2_crypto_template, alg.hash.base);
> +	struct scatterlist *sgs = areq->src;
> +	struct rk2_crypto_dev *rkc = rctx->dev;
> +	struct rk2_crypto_lli *dd = &rkc->tl[0];
> +	int ddi = 0;
> +	int err = 0;
> +	unsigned int len = areq->nbytes;
> +	unsigned int todo;
> +	u32 v;
> +	int i;
> +
> +	err = rk2_hash_prepare(engine, breq);
> +
> +	err = pm_runtime_resume_and_get(rkc->dev);
> +	if (err)
> +		return err;
> +
> +	dev_dbg(rkc->dev, "%s %s len=%d\n", __func__,
> +		crypto_tfm_alg_name(areq->base.tfm), areq->nbytes);
> +
> +	algt->stat_req++;
> +	rkc->nreq++;
> +
> +	rctx->mode = algt->rk2_mode;
> +	rctx->mode |= 0xffff0000;
> +	rctx->mode |= RK2_CRYPTO_ENABLE | RK2_CRYPTO_HW_PAD;
> +	writel(rctx->mode, rkc->reg + RK2_CRYPTO_HASH_CTL);
> +
> +	while (sgs && len > 0) {
> +		dd = &rkc->tl[ddi];
> +
> +		todo = min(sg_dma_len(sgs), len);
> +		dd->src_addr = sg_dma_address(sgs);
> +		dd->src_len = todo;
> +		dd->dst_addr = 0;
> +		dd->dst_len = 0;
> +		dd->dma_ctrl = ddi << 24;
> +		dd->iv = 0;
> +		dd->next = rkc->t_phy + sizeof(struct rk2_crypto_lli) * (ddi + 1);
> +
> +		if (ddi == 0)
> +			dd->user = RK2_LLI_CIPHER_START | RK2_LLI_STRING_FIRST;
> +		else
> +			dd->user = 0;
> +
> +		len -= todo;
> +		dd->dma_ctrl |= RK2_LLI_DMA_CTRL_SRC_INT;
> +		if (len == 0) {
> +			dd->user |= RK2_LLI_STRING_LAST;
> +			dd->dma_ctrl |= RK2_LLI_DMA_CTRL_LAST;
> +		}
> +		dev_dbg(rkc->dev, "HASH SG %d sglen=%d user=%x dma=%x mode=%x len=%d todo=%d phy=%llx\n",
> +			ddi, sgs->length, dd->user, dd->dma_ctrl, rctx->mode, len, todo, rkc->t_phy);
> +
> +		sgs = sg_next(sgs);
> +		ddi++;
> +	}
> +	dd->next = 1;
> +	writel(RK2_CRYPTO_DMA_INT_LISTDONE | 0x7F, rkc->reg + RK2_CRYPTO_DMA_INT_EN);
> +
> +	writel(rkc->t_phy, rkc->reg + RK2_CRYPTO_DMA_LLI_ADDR);
> +
> +	reinit_completion(&rkc->complete);
> +	rkc->status = 0;
> +
> +	writel(RK2_CRYPTO_DMA_CTL_START | RK2_CRYPTO_DMA_CTL_START << 16, rkc->reg + RK2_CRYPTO_DMA_CTL);

Wrap your code according to Coding Style document (so 80).

> +
> +	wait_for_completion_interruptible_timeout(&rkc->complete,
> +						  msecs_to_jiffies(2000));
> +	if (!rkc->status) {
> +		dev_err(rkc->dev, "DMA timeout\n");
> +		err = -EFAULT;
> +		goto theend;

Please use something closer to Linux.
goto exit;
goto out;



Best regards,
Krzysztof

