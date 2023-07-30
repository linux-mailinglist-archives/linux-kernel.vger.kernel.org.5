Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1922476875E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjG3TSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjG3TSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:18:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FF010FE
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 12:18:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe1344b707so6012239e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 12:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690744722; x=1691349522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=agLqXaz0c7wyuGYGSjrjb5qxhwxX+7bECvgEb/jdvuU=;
        b=AcOtHpOngAwQ9+il3kF66L3+Yw19UNlTwy+m7sBnGYEiMejMudc+xTx/cpbiZjpOpQ
         k4W4Xkn7BY/QUeMPI1wZfLw6JZpEqKZwj8rYju0HgJuTkmgpW2C54BiuRuRdU8z0SlnC
         xVdyrzKwOiuuxopCB5h278hKwaXUVoBzfo2qPWNnoqhbwEg4jVJeeGMayZsr1TJh7kZg
         4+vuFXvZZxsc5QvC+BIHIH9p9QAm3WBy/N0ObGZNOwPkQKdiKOf5k8VX5am3WHOXHwcQ
         11s4ectk0YF8xMAx21iOCqO8RPlly3KrR8/CwxKOg9BOnwbA/NASj3QCP9+KBfttMt/q
         sxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690744722; x=1691349522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=agLqXaz0c7wyuGYGSjrjb5qxhwxX+7bECvgEb/jdvuU=;
        b=l/VgdkdA3vlf3eARfyO0WvX5uZ8UnfJnZAKsoeakv2PeBSnBIvClVl03GX5+bB+RJa
         REh9KqZL6GHIbl3tiMhaBngD8PZyN2zk8soAcwX6TL5yvYfx1ZN1eV+8Z6z/s3tY65Ir
         lUgji+cVrttyrXzMRmrHmNZrdd2rvblOylPspGh8hMgR9aNdz0WwR2SZFNYmZKJz2fxU
         K/jNOQp+O+0bqRgtEby8JgGLSG3Jfl6/T1fV/OlR7n54OwhGSO/JD6xj5ClTIts+K2bg
         ssLg4jzrTtBmb4BDyb8SqgKklt89korHaQFZ3A4GPtyGt5Xg30ztNlwC+CZhP60e3boR
         1rQA==
X-Gm-Message-State: ABy/qLb6kXUgAc22ZDGXmKbUCg216Z68UBhYM+wHXJ3YY9niRtwkrus5
        zS6UIadvOUYQHtqQZ3RsZ3PPNQe/wspDkukCp4I=
X-Google-Smtp-Source: APBJJlFu9z/tKPI//7N6srzdfcsCzjs7n9LwJ9vswGdvBa5uTmmlIXPuam4fgHopslEDxLTvAMsL4g==
X-Received: by 2002:a19:8c10:0:b0:4fe:ecd:494f with SMTP id o16-20020a198c10000000b004fe0ecd494fmr4381841lfd.33.1690744721849;
        Sun, 30 Jul 2023 12:18:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id d2-20020aa7d5c2000000b00522560d6035sm4361513eds.10.2023.07.30.12.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 12:18:41 -0700 (PDT)
Message-ID: <beec285d-5d34-3677-c24d-07e08e72a440@linaro.org>
Date:   Sun, 30 Jul 2023 21:18:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 3/5] crypto: ti - add driver for MCRC64 engine
Content-Language: en-US
To:     Kamlesh Gurudasani <kamlesh@ti.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230719-mcrc-upstream-v1-0-dc8798a24c47@ti.com>
 <20230719-mcrc-upstream-v1-3-dc8798a24c47@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719-mcrc-upstream-v1-3-dc8798a24c47@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2023 20:55, Kamlesh Gurudasani wrote:
> Add support for MCRC64 engine to calculate 64-bit CRC in Full-CPU mode.
> 
> In Full-CPU mode, the CPU does the data patterns transfer and signature
> verification all by itself, only CRC calculation is being done by MCRC64
> engine.
> 
> MCRC64 engine calculates 64-bit cyclic redundancy checks (CRC)
> according to the ISO 3309 standard.
> 
> Generator polynomial: x^64 + x^4 + x^3 + x + 1
> Polynomial value: 0x000000000000001b
> 
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> ---
>  MAINTAINERS                |   2 +
>  drivers/crypto/Kconfig     |   1 +
>  drivers/crypto/Makefile    |   1 +
>  drivers/crypto/ti/Kconfig  |  10 +++
>  drivers/crypto/ti/Makefile |   2 +
>  drivers/crypto/ti/mcrc64.c | 360 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 376 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d8680f6969e3..a2f50adb51ac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21464,8 +21464,10 @@ F:	drivers/iio/adc/ti-lmp92064.c
>  
>  TI MEMORY CYCLIC REDUNDANCY CHECK (MCRC64) DRIVER
>  M:	Kamlesh Gurudasani <kamlesh@ti.com>
> +L:	linux-crypto@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml
> +F:	drivers/crypto/ti/mcrc64.c
>  
>  TI PCM3060 ASoC CODEC DRIVER
>  M:	Kirill Marinushkin <kmarinushkin@birdec.com>
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index c761952f0dc6..2101f92ead66 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -796,5 +796,6 @@ config CRYPTO_DEV_SA2UL
>  
>  source "drivers/crypto/aspeed/Kconfig"
>  source "drivers/crypto/starfive/Kconfig"
> +source "drivers/crypto/ti/Kconfig"
>  
>  endif # CRYPTO_HW
> diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
> index d859d6a5f3a4..f1a151b73ff1 100644
> --- a/drivers/crypto/Makefile
> +++ b/drivers/crypto/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_CRYPTO_DEV_SAHARA) += sahara.o
>  obj-$(CONFIG_CRYPTO_DEV_SL3516) += gemini/
>  obj-y += stm32/
>  obj-$(CONFIG_CRYPTO_DEV_TALITOS) += talitos.o
> +obj-$(CONFIG_ARCH_K3) += ti/
>  obj-$(CONFIG_CRYPTO_DEV_VIRTIO) += virtio/
>  obj-$(CONFIG_CRYPTO_DEV_VMX) += vmx/
>  obj-$(CONFIG_CRYPTO_DEV_BCM_SPU) += bcm/
> diff --git a/drivers/crypto/ti/Kconfig b/drivers/crypto/ti/Kconfig
> new file mode 100644
> index 000000000000..8e3b2b8b7623
> --- /dev/null
> +++ b/drivers/crypto/ti/Kconfig
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config CRYPTO_DEV_TI_MCRC64
> +	tristate "Support for TI MCRC64 crc64 accelerators"
> +	depends on ARCH_K3

So it is a part of Soc. Fix the compatible.

> +	select CRYPTO_HASH
> +	help
> +	  This enables support for the MCRC64 hw accelerator
> +	  which can be found on TI SOC.
> +	  MCRC64 engine calculates 64-bit cyclic redundancy checks (CRC)
> +	  according to the ISO 3309 standard using Full-CPU mode.
> \ No newline at end of file

You have warnings...

> diff --git a/drivers/crypto/ti/Makefile b/drivers/crypto/ti/Makefile
> new file mode 100644
> index 000000000000..94ffc2576137
> --- /dev/null
> +++ b/drivers/crypto/ti/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_CRYPTO_DEV_TI_MCRC64) += mcrc64.o
> diff --git a/drivers/crypto/ti/mcrc64.c b/drivers/crypto/ti/mcrc64.c
> new file mode 100644
> index 000000000000..45f8ae6078ff
> --- /dev/null
> +++ b/drivers/crypto/ti/mcrc64.c
> @@ -0,0 +1,360 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) Texas Instruments 2023 - http://www.ti.com
> + * Author: Kamlesh Gurudasani <kamlesh@ti.com>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +
> +#include <crypto/internal/hash.h>
> +
> +#include <asm/unaligned.h>
> +
> +#define DRIVER_NAME		"mcrc64"
> +#define CHKSUM_DIGEST_SIZE	8
> +#define CHKSUM_BLOCK_SIZE	1
> +
> +/* Registers */
> +#define CRC_CTRL0 0x0000 /* CRC Global Control Register 0 */
> +#define CH_PSA_SWRE(ch) BIT(((ch) - 1) << 3) /* PSA Software Reset  */
> +
> +#define CRC_CTRL1 0x0008 /* CRC Global Control Register 1 */
> +#define PWDN BIT(0) /* Power Down  */
> +
> +#define CRC_CTRL2 0x0010 /* CRC Global Control Register 2 */
> +#define CH_MODE(ch, m) ((m) << (((ch) - 1) << 3))
> +
> +#define PSA_SIGREGL(ch) ((0x6 + (4 * ((ch) - 1))) << 4) /* Signature register */
> +
> +#define MCRC64_ALG_MASK 0x8000000000000000
> +#define MCRC64_CRC64_POLY 0x000000000000001b
> +
> +#define MCRC64_AUTOSUSPEND_DELAY	50
> +
> +static struct device *mcrc64_k3_dev;

Nope. How do you support two devices? No, no, drop such approach
entirely from *all your drivers before upstreaming*.

> +
> +enum mcrc64_mode {
> +	MCRC64_MODE_DATA_CAPTURE = 0,
> +	MCRC64_MODE_AUTO,
> +	MCRC64_MODE_SEMI_CPU,
> +	MCRC64_MODE_FULL_CPU,
> +	MCRC64_MODE_INVALID,
> +};
> +
> +enum mcrc64_channel {
> +	MCRC64_CHANNEL_1 = 1,
> +	MCRC64_CHANNEL_2,
> +	MCRC64_CHANNEL_3,
> +	MCRC64_CHANNEL_4,
> +	MCRC64_CHANNEL_INVALID,
> +};
> +
> +struct mcrc64_data {
> +	struct device	 *dev;
> +	void __iomem	 *regs;
> +};
> +
> +struct mcrc64_ctx {
> +	u32 key;
> +};
> +
> +struct mcrc64_desc_ctx {
> +	u64    signature;

Keep consistent indentation/alignment in structures.

> +};
> +

...

> +
> +static int mcrc64_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mcrc64_data *dev_data;
> +
> +	dev_data = devm_kzalloc(dev, sizeof(*dev_data), GFP_KERNEL);
> +	if (!dev_data)
> +		return -ENOMEM;
> +
> +	mcrc64_k3_dev = dev;
> +	dev_data->dev = dev;
> +	dev_data->regs = devm_platform_ioremap_resource(pdev, 0);
> +
> +	platform_set_drvdata(pdev, dev_data);
> +	dev_set_drvdata(mcrc64_k3_dev, dev_data);
> +
> +	crypto_register_shashes(algs, ARRAY_SIZE(algs));
> +
> +	pm_runtime_set_autosuspend_delay(dev, MCRC64_AUTOSUSPEND_DELAY);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	pm_runtime_put_sync(dev);
> +
> +	return 0;
> +}
> +
> +static int mcrc64_remove(struct platform_device *pdev)
> +{
> +	struct mcrc64_data *dev_data = platform_get_drvdata(pdev);
> +
> +	int ret = pm_runtime_get_sync(dev_data->dev);
> +
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(dev_data->dev);
> +		return ret;
> +	}

Isn't there helper doing this for you?


Best regards,
Krzysztof

