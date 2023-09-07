Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A0D797BD0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbjIGS3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbjIGS3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:29:14 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FB51FDF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:28:58 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso22523401fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694111337; x=1694716137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wTsVaP+71NqmdPRHOGwX5IHf8E9ep68PnA55/HuDkMQ=;
        b=jqMRbfkqF1n7wrXJ5uqBKKt2kJrQC6CFXpu7iM3yuezYv526GwGuVh695lNJFdHQj4
         LBwxbmgi0kI7JJyBV+sICSu4wzuHyqU+vI+952YUANuc9gc0ZfbdaM37J4WzbwwfArAR
         n0PnzSVfZ5sXznpFE55Y2a2lNX4wY8eVlBT/KUXX9Ha/raljbmqsinKMuOToMfg+gjIA
         bcgfoaS37G6cvkQ7bXvzUyF2CtyC9VnQF7XOn9XLPhXF78ylMTXLpn8hTjFOy5TDZqSj
         IBbc/uDu//A15MU8Cf8r9GmR43Ontf7D6fn051hRLnRV4FE6+uDXqnCr0SBWMYaQmG3j
         8wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694111337; x=1694716137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTsVaP+71NqmdPRHOGwX5IHf8E9ep68PnA55/HuDkMQ=;
        b=pv5yGTEX1nbODMV8u/9kc71A/lLzZmOiqkBTPwjqmouK0XYHRI+lrZlLPDOXAMdWm/
         4Oca9HJQQFyhLduUKpVCT5OpWKmgf+4y7E5mPsXHXNbzUQmdInllcH8wq50MpoJrQa2U
         HMXUG3WR7rw1/6PqxbYyShJkj1vpy6gkcvyJCR75wyzQyaDP0tBLQYAUY/7mTCeVKssO
         7471p/T7xzzE1owABgJyIhh94Di1xWzfqqk2eSO/oZkRiTsio0+ks//JjxHriSa4jJRw
         b9fO0zrRer88PALYyQToDRembEKphEO9pLXdDA7ov13Sv8dAku6R5LcNmK5I2hZMVMsu
         Cfyw==
X-Gm-Message-State: AOJu0Ywo8hgGxuoEBTOwL4ffS5cxyj5VUPeVX/6RvAGhcQ0lkPprq6a/
        NR9xmF7O2s+4IZY0bSgmlz55ZcuHWWResrrVpgRu1Q==
X-Google-Smtp-Source: AGHT+IFif2c/BpnquDlibCJoxZKaSjA9cO8862DBRQf4TERPnA+7sSqJ0EMKb0emx0l0ms0HIc+meg==
X-Received: by 2002:a17:906:535d:b0:9a2:120a:5777 with SMTP id j29-20020a170906535d00b009a2120a5777mr3753951ejo.70.1694067014365;
        Wed, 06 Sep 2023 23:10:14 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id rp24-20020a170906d97800b009a5c98fd82asm9841726ejb.81.2023.09.06.23.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 23:10:13 -0700 (PDT)
Message-ID: <45cd927d-da55-3460-0a26-62b30c33a3ad@linaro.org>
Date:   Thu, 7 Sep 2023 08:10:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] drm: tiny: Add st7735s driver
Content-Language: en-US
To:     Stefan x Nilsson <stefan.x.nilsson@axis.com>,
        David Lechner <david@lechnology.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
References: <20230906-st7735s-v1-0-add92677c190@axis.com>
 <20230906-st7735s-v1-2-add92677c190@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230906-st7735s-v1-2-add92677c190@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 18:22, Stefan x Nilsson wrote:
> Add a driver for Sitronix st7735s display controller, as well as a
> Winstar wf0096atyaa3dnn0 0.96" 80x160 TFT panel.
> 
> The driver code is very similar to st7735r, but with adaptations for
> the pipe_enable function. There is also optional support to specify
> a power regulator for the display.
> 
> Signed-off-by: Stefan x Nilsson <stefan.x.nilsson@axis.com>
> ---
>  MAINTAINERS                    |   1 +
>  drivers/gpu/drm/tiny/Kconfig   |  14 +++
>  drivers/gpu/drm/tiny/Makefile  |   1 +
>  drivers/gpu/drm/tiny/st7735s.c | 264 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 280 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c00b2b9086f2..f24295d691e5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6733,6 +6733,7 @@ M:	Stefan x Nilsson <stefan.x.nilsson@axis.com>
>  S:	Maintained
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	Documentation/devicetree/bindings/display/sitronix,st7735s.yaml
> +F:	drivers/gpu/drm/tiny/st7735s.c
>  
>  DRM DRIVER FOR SOLOMON SSD130X OLED DISPLAYS
>  M:	Javier Martinez Canillas <javierm@redhat.com>
> diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
> index f6889f649bc1..2917f5412ddd 100644
> --- a/drivers/gpu/drm/tiny/Kconfig
> +++ b/drivers/gpu/drm/tiny/Kconfig
> @@ -212,3 +212,17 @@ config TINYDRM_ST7735R
>  	  * Okaya RH128128T 1.44" 128x128 TFT
>  
>  	  If M is selected the module will be called st7735r.
> +
> +config TINYDRM_ST7735S
> +	tristate "DRM support for Sitronix ST7735S display panels"
> +	depends on DRM && SPI
> +	select DRM_KMS_HELPER
> +	select DRM_GEM_DMA_HELPER
> +	select DRM_MIPI_DBI
> +	select BACKLIGHT_CLASS_DEVICE
> +	help
> +	  DRM driver for Sitronix ST7735S with one of the following
> +	  LCDs:
> +	  * Winstar WF0096ATYAA3DNN0 0.96" 80x160 Color TFT
> +
> +	  If M is selected the module will be called st7735s.
> diff --git a/drivers/gpu/drm/tiny/Makefile b/drivers/gpu/drm/tiny/Makefile
> index 76dde89a044b..2e805c5b6f16 100644
> --- a/drivers/gpu/drm/tiny/Makefile
> +++ b/drivers/gpu/drm/tiny/Makefile
> @@ -16,3 +16,4 @@ obj-$(CONFIG_TINYDRM_MI0283QT)		+= mi0283qt.o
>  obj-$(CONFIG_TINYDRM_REPAPER)		+= repaper.o
>  obj-$(CONFIG_TINYDRM_ST7586)		+= st7586.o
>  obj-$(CONFIG_TINYDRM_ST7735R)		+= st7735r.o
> +obj-$(CONFIG_TINYDRM_ST7735S)		+= st7735s.o
> diff --git a/drivers/gpu/drm/tiny/st7735s.c b/drivers/gpu/drm/tiny/st7735s.c
> new file mode 100644
> index 000000000000..42290f4128db
> --- /dev/null
> +++ b/drivers/gpu/drm/tiny/st7735s.c
> @@ -0,0 +1,264 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * DRM driver for display panels connected to a Sitronix ST7735S
> + * display controller in SPI mode.
> + *
> + * Copyright (C) 2023 Axis Communications AB
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/dma-buf.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/spi/spi.h>
> +#include <video/mipi_display.h>
> +
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_fbdev_generic.h>
> +#include <drm/drm_gem_atomic_helper.h>
> +#include <drm/drm_gem_dma_helper.h>
> +#include <drm/drm_managed.h>
> +#include <drm/drm_mipi_dbi.h>
> +
> +#define ST7735S_FRMCTR1		0xb1
> +#define ST7735S_FRMCTR2		0xb2
> +#define ST7735S_FRMCTR3		0xb3
> +#define ST7735S_INVCTR		0xb4
> +#define ST7735S_PWCTR1		0xc0
> +#define ST7735S_PWCTR2		0xc1
> +#define ST7735S_PWCTR3		0xc2
> +#define ST7735S_PWCTR4		0xc3
> +#define ST7735S_PWCTR5		0xc4
> +#define ST7735S_VMCTR1		0xc5
> +#define ST7735S_GAMCTRP1	0xe0
> +#define ST7735S_GAMCTRN1	0xe1
> +
> +#define ST7735S_MY	BIT(7)
> +#define ST7735S_MX	BIT(6)
> +#define ST7735S_MV	BIT(5)
> +#define ST7735S_RGB	BIT(3)

So you just duplicated st7735r. No need for new driver. Integrate your
work. Probably also no need for new bindings file (although this I did
not check)...

Best regards,
Krzysztof

