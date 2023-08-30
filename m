Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E222B78DFC3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242116AbjH3TLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243333AbjH3KpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:45:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5C81BB;
        Wed, 30 Aug 2023 03:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82D5360FE8;
        Wed, 30 Aug 2023 10:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBC4C433C7;
        Wed, 30 Aug 2023 10:44:58 +0000 (UTC)
Message-ID: <d4b12bc1-65b8-6881-3648-85099d9319ec@xs4all.nl>
Date:   Wed, 30 Aug 2023 12:44:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v8 3/8] media: staging: media: starfive: camss: Add core
 driver
Content-Language: en-US, nl
To:     Jack Zhu <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, bryan.odonoghue@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-staging@lists.linux.dev,
        changhuang.liang@starfivetech.com
References: <20230824080109.89613-1-jack.zhu@starfivetech.com>
 <20230824080109.89613-4-jack.zhu@starfivetech.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230824080109.89613-4-jack.zhu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 10:01, Jack Zhu wrote:
> Add core driver for StarFive Camera Subsystem. The code parses
> the device platform resources and registers related devices.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
> ---
>  MAINTAINERS                                   |   1 +
>  drivers/staging/media/Kconfig                 |   2 +
>  drivers/staging/media/Makefile                |   1 +
>  drivers/staging/media/starfive/Kconfig        |   5 +
>  drivers/staging/media/starfive/Makefile       |   2 +
>  drivers/staging/media/starfive/camss/Kconfig  |  17 +
>  drivers/staging/media/starfive/camss/Makefile |   9 +
>  .../staging/media/starfive/camss/stf_camss.c  | 316 ++++++++++++++++++
>  .../staging/media/starfive/camss/stf_camss.h  | 129 +++++++
>  9 files changed, 482 insertions(+)
>  create mode 100644 drivers/staging/media/starfive/Kconfig
>  create mode 100644 drivers/staging/media/starfive/Makefile
>  create mode 100644 drivers/staging/media/starfive/camss/Kconfig
>  create mode 100644 drivers/staging/media/starfive/camss/Makefile
>  create mode 100644 drivers/staging/media/starfive/camss/stf_camss.c
>  create mode 100644 drivers/staging/media/starfive/camss/stf_camss.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4c63c0a85301..97d3054416ed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20258,6 +20258,7 @@ L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/admin-guide/media/starfive_camss.rst
>  F:	Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> +F:	drivers/staging/media/starfive/camss
>  
>  STARFIVE CRYPTO DRIVER
>  M:	Jia Jie Ho <jiajie.ho@starfivetech.com>
> diff --git a/drivers/staging/media/Kconfig b/drivers/staging/media/Kconfig
> index bc6c7b248f86..554c2e475ce3 100644
> --- a/drivers/staging/media/Kconfig
> +++ b/drivers/staging/media/Kconfig
> @@ -36,6 +36,8 @@ source "drivers/staging/media/omap4iss/Kconfig"
>  
>  source "drivers/staging/media/rkvdec/Kconfig"
>  
> +source "drivers/staging/media/starfive/Kconfig"
> +
>  source "drivers/staging/media/sunxi/Kconfig"
>  
>  source "drivers/staging/media/tegra-video/Kconfig"
> diff --git a/drivers/staging/media/Makefile b/drivers/staging/media/Makefile
> index 1a4c3a062e3d..dcaeeca0ee6d 100644
> --- a/drivers/staging/media/Makefile
> +++ b/drivers/staging/media/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_VIDEO_MAX96712)	+= max96712/
>  obj-$(CONFIG_VIDEO_MESON_VDEC)	+= meson/vdec/
>  obj-$(CONFIG_VIDEO_OMAP4)	+= omap4iss/
>  obj-$(CONFIG_VIDEO_ROCKCHIP_VDEC)	+= rkvdec/
> +obj-$(CONFIG_VIDEO_STARFIVE_CAMSS)	+= starfive/
>  obj-$(CONFIG_VIDEO_SUNXI)	+= sunxi/
>  obj-$(CONFIG_VIDEO_TEGRA)	+= tegra-video/
>  obj-$(CONFIG_VIDEO_IPU3_IMGU)	+= ipu3/
> diff --git a/drivers/staging/media/starfive/Kconfig b/drivers/staging/media/starfive/Kconfig
> new file mode 100644
> index 000000000000..34727cf56072
> --- /dev/null
> +++ b/drivers/staging/media/starfive/Kconfig
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +comment "StarFive media platform drivers"
> +
> +source "drivers/staging/media/starfive/camss/Kconfig"
> diff --git a/drivers/staging/media/starfive/Makefile b/drivers/staging/media/starfive/Makefile
> new file mode 100644
> index 000000000000..4639fa1bca32
> --- /dev/null
> +++ b/drivers/staging/media/starfive/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-y += camss/
> diff --git a/drivers/staging/media/starfive/camss/Kconfig b/drivers/staging/media/starfive/camss/Kconfig
> new file mode 100644
> index 000000000000..8d20e2bd2559
> --- /dev/null
> +++ b/drivers/staging/media/starfive/camss/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config VIDEO_STARFIVE_CAMSS
> +	tristate "Starfive Camera Subsystem driver"
> +	depends on V4L_PLATFORM_DRIVERS
> +	depends on VIDEO_DEV && OF
> +	depends on HAS_DMA
> +	depends on PM
> +	select MEDIA_CONTROLLER
> +	select VIDEO_V4L2_SUBDEV_API
> +	select VIDEOBUF2_DMA_CONTIG
> +	select V4L2_FWNODE
> +	help
> +	   Enable this to support for the Starfive Camera subsystem
> +	   found on Starfive JH7110 SoC.
> +
> +	   To compile this driver as a module, choose M here: the
> +	   module will be called stf-camss.

This is actually called starfive-camss.ko!

Regards,

	Hans

