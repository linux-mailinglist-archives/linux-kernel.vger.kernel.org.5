Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDD280A8D1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbjLHQZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbjLHQZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:25:04 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2C619B6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:25:06 -0800 (PST)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 32F953F5F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1702052705;
        bh=4CY6DbkeB0I+Lk7WkHRys6b0nBda4yA81yMnMYFbYZ8=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=MQMxG9+uP/MJB7T3pSPTI8gdXkj+0z4G++dTRWQsDlLPxCZKx9oLS7QDoezevy4CW
         /OQoHSJuRwmr3U5im1xZyEt4/bz5onAQbKku0YL0nO8ftPXEuBL0z/6xV4IsLPh+hM
         2rF3G8p6aIkS0MI0/wSB+FDcOiugFGlFc2nZptPkRovNMqyvzICkXh6MswPi37GRw0
         e6fnnTF8E0EH1cNx+V1tbNqrty6YpI4ZXNrZ4b/x/PIe01ZjmO4TaEi9FJpHlWO1T0
         w9/7fKw6ULmbumnas4vAlDcuZgbPMp45lPilUV5+Wt/nsmtqXzDeBKq9MKU/oMqffq
         Yhhe+UClhe7Jw==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-42589f2016eso24774301cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 08:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702052703; x=1702657503;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4CY6DbkeB0I+Lk7WkHRys6b0nBda4yA81yMnMYFbYZ8=;
        b=LAsaPcLBKpJCHI7Bb8t7wKmc9xZwXz2+hWRkwZez6K8TYmD6Jd5Z/W9U7DeDuaNp/n
         5gQTGHgChOA8sx5Z0q5z5DngeUvwaYFDap71OxOxOKi2fcCRcJqKJltR5KqoiKaEr+oJ
         /QLRSrBXe8Og6/eFS/7lUDtwit8U3TSY74KqHLnBll1pag+DuHOtZyCBiaU5hNy5y+eW
         5jy+PIKLwxrkuM6vMrajh/V1rWq5R9Wg0wPWZvEcm5EIldGGgdz1GDVaMdplNWA14APQ
         YX2FcxNnWARWfAFesNTbzSU5v4rxFki5aB8gARcsPxO4znfjV46/nZSkuGXA+5qveK7i
         aOgA==
X-Gm-Message-State: AOJu0Yw8VN2p/zZkQt/p0UuZk/VE9HqrWJCyWXRtKGieOvYOAt+DUrL8
        wi/4MPaKG/aNp4XydVLgcPb0iaz9wx2Vmx1mqq8vaZsO7kIO6FT5aGR6I7kJnyyyWOQjsaYzCYZ
        xoxHo3dX3hb2vTGFV/6itGXnxbkJgdJgD7n0l0cvmsgwbmJD4W/olZE0vAA==
X-Received: by 2002:a05:622a:54c:b0:425:4043:41be with SMTP id m12-20020a05622a054c00b00425404341bemr348047qtx.106.1702052703018;
        Fri, 08 Dec 2023 08:25:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtfrgSw/9Kfccz7+UvxzXQyGa6T7fEI30XAMwGXYEdh9HXn8lXkNpUGn8sAs28Rg/sYXQ0gIa7I2tnYMuCfiA=
X-Received: by 2002:a05:622a:54c:b0:425:4043:41be with SMTP id
 m12-20020a05622a054c00b00425404341bemr348029qtx.106.1702052702696; Fri, 08
 Dec 2023 08:25:02 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 Dec 2023 08:25:02 -0800
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231206115000.295825-7-jeeheng.sia@starfivetech.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com> <20231206115000.295825-7-jeeheng.sia@starfivetech.com>
Mime-Version: 1.0
Date:   Fri, 8 Dec 2023 08:25:02 -0800
Message-ID: <CAJM55Z_VgBGvCPuvwmQahMcMfuWKnOKpZ9bBbbhei_Teu5Apeg@mail.gmail.com>
Subject: Re: [PATCH v1 06/16] clk: starfive: Add JH8100 System clock generator driver
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>, kernel@esmil.dk,
        conor@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        emil.renner.berthing@canonical.com, hal.feng@starfivetech.com,
        xingyu.wu@starfivetech.com
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        leyfoon.tan@starfivetech.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sia Jee Heng wrote:
> Add support for JH8100 System clock generator.
>
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> ---
>  MAINTAINERS                                   |   8 +
>  drivers/clk/starfive/Kconfig                  |   9 +
>  drivers/clk/starfive/Makefile                 |   1 +
>  drivers/clk/starfive/clk-starfive-common.h    |   9 +-
>  drivers/clk/starfive/jh8100/Makefile          |   3 +
>  .../clk/starfive/jh8100/clk-starfive-jh8100.h |  11 +
>  drivers/clk/starfive/jh8100/clk-sys.c         | 455 ++++++++++++++++++
>  7 files changed, 495 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/starfive/jh8100/Makefile
>  create mode 100644 drivers/clk/starfive/jh8100/clk-starfive-jh8100.h
>  create mode 100644 drivers/clk/starfive/jh8100/clk-sys.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 788be9ab5b73..87bcb25becc1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20763,6 +20763,14 @@ F:	Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
>  F:	drivers/phy/starfive/phy-jh7110-pcie.c
>  F:	drivers/phy/starfive/phy-jh7110-usb.c
>
> +STARFIVE JH8100 CLOCK DRIVERS
> +M:	Sia Jee Heng <jeeheng.sia@starfivetech.com>
> +M:	Ley Foon Tan <leyfoon.tan@starfivetech.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/clock/starfive,jh81*.yaml
> +F:	drivers/clk/starfive/jh8100
> +F:	include/dt-bindings/clock/starfive?jh81*.h
> +
>  STATIC BRANCH/CALL
>  M:	Peter Zijlstra <peterz@infradead.org>
>  M:	Josh Poimboeuf <jpoimboe@kernel.org>
> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
> index ff8eace36e64..d8c7b9bb3895 100644
> --- a/drivers/clk/starfive/Kconfig
> +++ b/drivers/clk/starfive/Kconfig
> @@ -72,3 +72,12 @@ config CLK_STARFIVE_JH7110_VOUT
>  	help
>  	  Say yes here to support the Video-Output clock controller
>  	  on the StarFive JH7110 SoC.
> +
> +config CLK_STARFIVE_JH8100_SYS
> +	bool "StarFive JH8100 System clock support"
> +	depends on SOC_STARFIVE || COMPILE_TEST
> +	select AUXILIARY_BUS
> +	select CLK_STARFIVE_COMMON
> +	default ARCH_STARFIVE
> +	help
> +	  Say yes here to support the System clock controller on the StarFive JH8100 SoC.
> diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
> index 012f7ee83f8e..6cb3ce823330 100644
> --- a/drivers/clk/starfive/Makefile
> +++ b/drivers/clk/starfive/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_AON)	+= clk-starfive-jh7110-aon.o
>  obj-$(CONFIG_CLK_STARFIVE_JH7110_STG)	+= clk-starfive-jh7110-stg.o
>  obj-$(CONFIG_CLK_STARFIVE_JH7110_ISP)	+= clk-starfive-jh7110-isp.o
>  obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
> +obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS)	+= jh8100/

I don't really see why do you need a special subdirectory for the JH8100? The
JH7110 drivers do fine without it.

> diff --git a/drivers/clk/starfive/clk-starfive-common.h b/drivers/clk/starfive/clk-starfive-common.h
> index fed45311360c..ec30af0658cf 100644
> --- a/drivers/clk/starfive/clk-starfive-common.h
> +++ b/drivers/clk/starfive/clk-starfive-common.h
> @@ -103,6 +103,13 @@ struct starfive_clk_data {
>  	.parents = { [0] = _parent },						\
>  }
>
> +#define STARFIVE_GINV(_idx, _name, _flags, _parent)[_idx] = {			\
> +	.name = _name,								\
> +	.flags = _flags,							\
> +	.max = STARFIVE_CLK_ENABLE | STARFIVE_CLK_INVERT,			\
> +	.parents = { [0] = _parent },						\
> +}
> +
>  struct starfive_clk {
>  	struct clk_hw hw;
>  	unsigned int idx;
> @@ -114,7 +121,7 @@ struct starfive_clk_priv {
>  	spinlock_t rmw_lock;
>  	struct device *dev;
>  	void __iomem *base;
> -	struct clk_hw *pll[3];
> +	struct clk_hw *pll[8];

These extra slots are just used for fixed factor dummy PLLs right now, similar
to how the JH7110 first used them and later had to rework drivers and device
trees for the proper PLL driver.

This time around I'd much rather you work on getting the PLL driver in first,
so we don't need all that churn.

>  	struct starfive_clk reg[];
>  };
>
> diff --git a/drivers/clk/starfive/jh8100/Makefile b/drivers/clk/starfive/jh8100/Makefile
> new file mode 100644
> index 000000000000..af6a09e220d3
> --- /dev/null
> +++ b/drivers/clk/starfive/jh8100/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# StarFive JH8100 Clock
> +obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS)		+= clk-sys.o

This will name the module clk-sys, which is way too generic. Please name this
clk-starfive-jh8100-sys similar to the JH7110 drivers.

> diff --git a/drivers/clk/starfive/jh8100/clk-starfive-jh8100.h b/drivers/clk/starfive/jh8100/clk-starfive-jh8100.h
> new file mode 100644
> index 000000000000..7c8249c11464
> --- /dev/null
> +++ b/drivers/clk/starfive/jh8100/clk-starfive-jh8100.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __CLK_STARFIVE_JH8100_H
> +#define __CLK_STARFIVE_JH8100_H
> +
> +#include "../clk-starfive-common.h"
> +
> +int jh8100_reset_controller_register(struct starfive_clk_priv *priv,
> +				     const char *adev_name,
> +				     u32 adev_id);
> +
> +#endif
> diff --git a/drivers/clk/starfive/jh8100/clk-sys.c b/drivers/clk/starfive/jh8100/clk-sys.c
> new file mode 100644
> index 000000000000..e2c802523c7d
> --- /dev/null
> +++ b/drivers/clk/starfive/jh8100/clk-sys.c
> @@ -0,0 +1,455 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * StarFive JH8100 System Clock Driver
> + *
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> + *
> + * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/clk-provider.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <soc/starfive/reset-starfive-common.h>
> +
> +#include <dt-bindings/clock/starfive,jh8100-crg.h>
> +
> +#include "clk-starfive-jh8100.h"
> +
> +/* external clocks */
> +#define SYSCRG_CLK_OSC				(SYSCRG_CLK_END + 0)
> +#define SYSCRG_CLK_MCLK_EXT			(SYSCRG_CLK_END + 1)
> +#define SYSCRG_CLK_PLL0_OUT			(SYSCRG_CLK_END + 2)
> +#define SYSCRG_CLK_PLL1_OUT			(SYSCRG_CLK_END + 3)
> +#define SYSCRG_CLK_PLL2_OUT			(SYSCRG_CLK_END + 4)
> +#define SYSCRG_CLK_PLL3_OUT			(SYSCRG_CLK_END + 5)
> +#define SYSCRG_CLK_PLL4_OUT			(SYSCRG_CLK_END + 6)
> +#define SYSCRG_CLK_PLL6_OUT			(SYSCRG_CLK_END + 7)
> +#define SYSCRG_CLK_PLL7_OUT			(SYSCRG_CLK_END + 8)
> +
> +static const struct starfive_clk_data jh8100_syscrg_clk_data[] __initconst = {
> +	/* root */
> +	STARFIVE__DIV(SYSCRG_CLK_VDEC_ROOT_PREOSC, "sys_clk_vdec_root_preosc", 10,
> +		      SYSCRG_CLK_PLL7_OUT),
> +	STARFIVE__MUX(SYSCRG_CLK_VDEC_ROOT, "sys_clk_vdec_root", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_VDEC_ROOT_PREOSC),
> +	STARFIVE__DIV(SYSCRG_CLK_VENC_ROOT_PREOSC, "sys_clk_venc_root_preosc", 10,
> +		      SYSCRG_CLK_PLL7_OUT),
> +	STARFIVE__MUX(SYSCRG_CLK_VENC_ROOT, "sys_clk_venc_root", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_VENC_ROOT_PREOSC),
> +	STARFIVE__DIV(SYSCRG_CLK_GPU_ROOT, "sys_clk_gpu_root", 7,
> +		      SYSCRG_CLK_PLL0_OUT),
> +	STARFIVE__MUX(SYSCRG_CLK_GPU_CORE, "sys_clk_gpu_core", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_GPU_ROOT),
> +	STARFIVE__DIV(SYSCRG_CLK_VOUT_ROOT0_PREOSC, "sys_clk_vout_root0_preosc", 127,
> +		      SYSCRG_CLK_PLL1_OUT),
> +	STARFIVE__MUX(SYSCRG_CLK_VOUT_ROOT0, "sys_clk_vout_root0", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_VOUT_ROOT0_PREOSC),
> +	STARFIVE__DIV(SYSCRG_CLK_VOUT_ROOT1_PREOSC, "sys_clk_vout_root1_preosc", 127,
> +		      SYSCRG_CLK_PLL6_OUT),
> +	STARFIVE__MUX(SYSCRG_CLK_VOUT_ROOT1, "sys_clk_vout_root1", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_VOUT_ROOT1_PREOSC),
> +	STARFIVE__DIV(SYSCRG_CLK_VOUT_SCAN_ATS, "sys_clk_vout_scan_ats", 6,
> +		      SYSCRG_CLK_PLL3_OUT),
> +	STARFIVE__DIV(SYSCRG_CLK_PERH_ROOT_PREOSC, "sys_clk_perh_root_preosc", 4,
> +		      SYSCRG_CLK_PLL0_OUT),
> +	STARFIVE__MUX(SYSCRG_CLK_PERH_ROOT, "sys_clk_perh_root", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_PERH_ROOT_PREOSC),
> +	STARFIVE__DIV(SYSCRG_CLK_AXI_200_PREOSC, "sys_clk_axi_200_preosc", 4,
> +		      SYSCRG_CLK_PLL0_OUT),
> +	STARFIVE__MUX(SYSCRG_CLK_AXI_200, "sys_clk_axi_200", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_AXI_200_PREOSC),
> +	STARFIVE__MUX(SYSCRG_CLK_AXI_200_GMAC, "sys_clk_axi_200_gmac", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_AXI_200_PREOSC),
> +	STARFIVE__DIV(SYSCRG_CLK_AXI_500_PREOSC, "sys_clk_axi_500_preosc", 10,
> +		      SYSCRG_CLK_PLL0_OUT),
> +	STARFIVE__MUX(SYSCRG_CLK_AXI_500, "sys_clk_axi_500", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_AXI_500_PREOSC),
> +	STARFIVE__MUX(SYSCRG_CLK_AXI_500_PCIEX1A, "sys_clk_axi_500_pciex1a", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_AXI_500_PREOSC),
> +	STARFIVE__MUX(SYSCRG_CLK_AXI_500_PCIEX1B, "sys_clk_axi_500_pciex1b", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_AXI_500_PREOSC),
> +	STARFIVE__MUX(SYSCRG_CLK_AXI_500_PCIEX2, "sys_clk_axi_500_pciex2", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_AXI_500_PREOSC),
> +	STARFIVE__MUX(SYSCRG_CLK_AXI_500_PCIEX8, "sys_clk_axi_500_pciex8", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_AXI_500_PREOSC),
> +	STARFIVE__DIV(SYSCRG_CLK_AXI_400_PREOSC, "sys_clk_axi_400_preosc", 10,
> +		      SYSCRG_CLK_PLL0_OUT),
> +	STARFIVE__MUX(SYSCRG_CLK_AXI_400, "sys_clk_axi_400", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_AXI_400_PREOSC),
> +	STARFIVE__MUX(SYSCRG_CLK_AXI_400_APBOOTRAM, "sys_clk_axi_400_apbootram", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_AXI_400_PREOSC),
> +	STARFIVE__DIV(SYSCRG_CLK_AXI_125_PREOSC, "sys_clk_axi_125_preosc", 32,
> +		      SYSCRG_CLK_PLL0_OUT),
> +	STARFIVE__MUX(SYSCRG_CLK_AXI_125, "sys_clk_axi_125", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_AXI_125_PREOSC),
> +	STARFIVE__DIV(SYSCRG_CLK_AHB0_PREOSC, "sys_clk_ahb0_preosc", 15,
> +		      SYSCRG_CLK_PLL0_OUT),
> +	STARFIVE__MUX(SYSCRG_CLK_AHB0, "sys_clk_ahb0", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_AHB0_PREOSC),
> +	STARFIVE__DIV(SYSCRG_CLK_APB_BUS_FUNC, "sys_clk_apb_bus_func", 30,
> +		      SYSCRG_CLK_PLL0_OUT),
> +	STARFIVE__MUX(SYSCRG_CLK_APB_BUS, "sys_clk_apb_bus", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
> +	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER0, "sys_clk_apb_bus_per0", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
> +	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER1, "sys_clk_apb_bus_per1", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
> +	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER2, "sys_clk_apb_bus_per2", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
> +	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER3, "sys_clk_apb_bus_per3", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
> +	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER4, "sys_clk_apb_bus_per4", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
> +	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER5, "sys_clk_apb_bus_per5", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
> +	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER6, "sys_clk_apb_bus_per6", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
> +	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER7, "sys_clk_apb_bus_per7", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
> +	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER8, "sys_clk_apb_bus_per8", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
> +	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER9, "sys_clk_apb_bus_per9", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
> +	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER10, "sys_clk_apb_bus_per10", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
> +	STARFIVE__MUX(SYSCRG_CLK_SPI_CORE_100, "sys_clk_spi_core_100", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
> +	STARFIVE__DIV(SYSCRG_CLK_PLL1_DIV2, "sys_clk_pll1_div2", 2,
> +		      SYSCRG_CLK_PLL1_OUT),
> +	STARFIVE__DIV(SYSCRG_CLK_PLL2_DIV2, "sys_clk_pll2_div2", 2,
> +		      SYSCRG_CLK_PLL2_OUT),
> +	STARFIVE__DIV(SYSCRG_CLK_PLL3_DIV2, "sys_clk_pll3_div2", 2,
> +		      SYSCRG_CLK_PLL3_OUT),
> +	STARFIVE__DIV(SYSCRG_CLK_PLL4_DIV2, "sys_clk_pll4_div2", 2,
> +		      SYSCRG_CLK_PLL4_OUT),
> +	STARFIVE__DIV(SYSCRG_CLK_PLL6_DIV2, "sys_clk_pll6_div2", 2,
> +		      SYSCRG_CLK_PLL6_OUT),
> +	STARFIVE__DIV(SYSCRG_CLK_PLL7_DIV2, "sys_clk_pll7_div2", 2,
> +		      SYSCRG_CLK_PLL7_OUT),
> +	STARFIVE__DIV(SYSCRG_CLK_AUDIO_ROOT, "sys_clk_audio_root", 8,
> +		      SYSCRG_CLK_PLL2_OUT),
> +	STARFIVE__DIV(SYSCRG_CLK_MCLK_INNER, "sys_clk_mclk_inner", 64,
> +		      SYSCRG_CLK_AUDIO_ROOT),
> +	STARFIVE__MUX(SYSCRG_CLK_MCLK, "sys_clk_mclk", 2,
> +		      SYSCRG_CLK_MCLK_INNER, SYSCRG_CLK_MCLK_EXT),
> +	STARFIVE_GATE(SYSCRG_CLK_MCLK_OUT, "sys_clk_mclk_out", 0,
> +		      SYSCRG_CLK_MCLK_INNER),
> +	STARFIVE_MDIV(SYSCRG_CLK_ISP_2X_PREOSC, "sys_clk_isp_2x_preosc", 8, 2,
> +		      SYSCRG_CLK_PLL7_OUT, SYSCRG_CLK_PLL0_OUT),
> +	STARFIVE__MUX(SYSCRG_CLK_ISP_2X, "sys_clk_isp_2x", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_ISP_2X_PREOSC),
> +	STARFIVE__DIV(SYSCRG_CLK_ISP_AXI, "sys_clk_isp_axi", 4,
> +		      SYSCRG_CLK_ISP_2X),
> +	STARFIVE_GDIV(SYSCRG_CLK_GCLK1, "sys_clk_gclk1", CLK_IS_CRITICAL, 120,
> +		      SYSCRG_CLK_PLL1_DIV2),
> +	STARFIVE_GDIV(SYSCRG_CLK_GCLK2, "sys_clk_gclk2", CLK_IS_CRITICAL, 120,
> +		      SYSCRG_CLK_PLL2_DIV2),
> +	STARFIVE_GDIV(SYSCRG_CLK_GCLK3, "sys_clk_gclk3", CLK_IS_CRITICAL, 120,
> +		      SYSCRG_CLK_PLL3_DIV2),
> +	STARFIVE_GDIV(SYSCRG_CLK_GCLK4, "sys_clk_gclk4", CLK_IS_CRITICAL, 120,
> +		      SYSCRG_CLK_PLL4_DIV2),
> +	STARFIVE_GDIV(SYSCRG_CLK_GCLK6, "sys_clk_gclk6", CLK_IS_CRITICAL, 120,
> +		      SYSCRG_CLK_PLL6_DIV2),
> +	STARFIVE_GDIV(SYSCRG_CLK_GCLK7, "sys_clk_gclk7", CLK_IS_CRITICAL, 120,
> +		      SYSCRG_CLK_PLL7_DIV2),
> +	/* flexnoc (se) */
> +	STARFIVE__DIV(SYSCRG_CLK_FLEXNOC0_PREOSC, "sys_clk_flexnoc0_preosc", 8,
> +		      SYSCRG_CLK_PLL0_OUT),
> +	STARFIVE__MUX(SYSCRG_CLK_FLEXNOC0, "sys_clk_flexnoc0", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_FLEXNOC0_PREOSC),
> +	STARFIVE__DIV(SYSCRG_CLK_FLEXNOC1_PREOSC, "sys_clk_flexnoc1_preosc", 8,
> +		      SYSCRG_CLK_PLL0_OUT),
> +	STARFIVE__MUX(SYSCRG_CLK_FLEXNOC1, "sys_clk_flexnoc1", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_FLEXNOC1_PREOSC),
> +	STARFIVE__DIV(SYSCRG_CLK_FLEXNOC2_PREOSC, "sys_clk_flexnoc2_preosc", 12,
> +		      SYSCRG_CLK_PLL0_OUT),
> +	STARFIVE__MUX(SYSCRG_CLK_FLEXNOC2, "sys_clk_flexnoc2", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_FLEXNOC2_PREOSC),
> +	STARFIVE__MUX(SYSCRG_CLK_VDEC_CORE, "sys_clk_vdec_core", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_FLEXNOC1_PREOSC),
> +	/* img_gpu (se) */
> +	STARFIVE_GATE(SYSCRG_CLK_GPU_CORE_ICG, "sys_clk_gpu_core_icg", 0,
> +		      SYSCRG_CLK_GPU_CORE),
> +	STARFIVE_GATE(SYSCRG_CLK_IMG_GPU_CLK_APB, "sys_clk_img_gpu_clk_apb", 0,
> +		      SYSCRG_CLK_APB_BUS_PER7),
> +	STARFIVE_GATE(SYSCRG_CLK_IMG_GPU_RTC_TOGGLE, "sys_clk_img_gpu_rtc_toggle", 0,
> +		      SYSCRG_CLK_OSC),
> +	STARFIVE_GATE(SYSCRG_CLK_IMG_GPU_TIMER_USC, "sys_clk_img_gpu_timer_usc", 0,
> +		      SYSCRG_CLK_OSC),
> +	/* hifi4 (se) */
> +	STARFIVE__DIV(SYSCRG_CLK_HIFI4_CORE_PREOSC, "sys_clk_hifi4_core_preosc", 15,
> +		      SYSCRG_CLK_PLL0_OUT),
> +	STARFIVE__MUX(SYSCRG_CLK_HIFI4_CORE, "sys_clk_hifi4_core", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_HIFI4_CORE_PREOSC),
> +	/* espi */
> +	STARFIVE__DIV(SYSCRG_CLK_ESPI_200_PREOSC, "sys_clk_espi_200_preosc", 2,
> +		      SYSCRG_CLK_PLL0_OUT),
> +	STARFIVE__MUX(SYSCRG_CLK_ESPI_200, "sys_clk_espi_200", 2,
> +		      SYSCRG_CLK_OSC, SYSCRG_CLK_ESPI_200_PREOSC),
> +	/* hd audio */
> +	STARFIVE__DIV(SYSCRG_CLK_HD_AUDIO_48M, "sys_clk_hd_audio_48m", 80,
> +		      SYSCRG_CLK_PLL7_OUT),
> +	/* dom vout */
> +	STARFIVE__DIV(SYSCRG_CLK_VOUT_DC_CORE, "sys_clk_vout_dc_core", 10,
> +		      SYSCRG_CLK_PLL7_OUT),
> +	STARFIVE__DIV(SYSCRG_CLK_VOUT_AXI, "sys_clk_vout_axi", 10,
> +		      SYSCRG_CLK_PLL7_OUT),
> +	/* stg2_usb_wrap (se) */
> +	STARFIVE__DIV(SYSCRG_CLK_USB_WRAP_625, "sys_clk_usb_wrap_625", 6,
> +		      SYSCRG_CLK_PLL0_OUT),
> +	STARFIVE__DIV(SYSCRG_CLK_USB_WRAP_480, "sys_clk_usb_wrap_480", 8,
> +		      SYSCRG_CLK_PLL0_OUT),
> +	STARFIVE__DIV(SYSCRG_CLK_USB_WRAP_240, "sys_clk_usb_wrap_240", 2,
> +		      SYSCRG_CLK_USB_WRAP_480),
> +	STARFIVE__DIV(SYSCRG_CLK_USB_WRAP_60, "sys_clk_usb_wrap_60", 10,
> +		      SYSCRG_CLK_USB_WRAP_480),
> +	STARFIVE__DIV(SYSCRG_CLK_USB_WRAP_156P25, "sys_clk_usb_wrap_156p25", 4,
> +		      SYSCRG_CLK_USB_WRAP_625),
> +	STARFIVE__DIV(SYSCRG_CLK_USB_WRAP_312P5, "sys_clk_usb_wrap_312p5", 2,
> +		      SYSCRG_CLK_USB_WRAP_625),
> +	/* stg */
> +	STARFIVE__DIV(SYSCRG_CLK_USB_125M, "sys_clk_usb_125m", 32,
> +		      SYSCRG_CLK_PLL0_OUT),
> +	/* Flexnoc (se) */
> +	STARFIVE_GATE(SYSCRG_CLK_FLEXNOC_APBOOTRAM, "sys_clk_flexnoc_apbootram",
> +		      CLK_IS_CRITICAL, SYSCRG_CLK_AXI_400_APBOOTRAM),
> +	STARFIVE_GATE(SYSCRG_CLK_FLEXNOC_PCIEX1AMST, "sys_clk_flexnoc_pciex1amst",
> +		      CLK_IS_CRITICAL, SYSCRG_CLK_AXI_500_PCIEX1A),
> +	STARFIVE_GATE(SYSCRG_CLK_FLEXNOC_PCIEX1ASLV, "sys_clk_flexnoc_pciex1aslv",
> +		      CLK_IS_CRITICAL, SYSCRG_CLK_AXI_500_PCIEX1A),
> +	STARFIVE_GATE(SYSCRG_CLK_FLEXNOC_PCIEX1BMST, "sys_clk_flexnoc_pciex1bmst",
> +		      CLK_IS_CRITICAL, SYSCRG_CLK_AXI_500_PCIEX1B),
> +	STARFIVE_GATE(SYSCRG_CLK_FLEXNOC_PCIEX1BSLV, "sys_clk_flexnoc_pciex1bslv",
> +		      CLK_IS_CRITICAL, SYSCRG_CLK_AXI_500_PCIEX1B),
> +	STARFIVE_GATE(SYSCRG_CLK_FLEXNOC_PCIEX2MST, "sys_clk_flexnoc_pciex2mst",
> +		      CLK_IS_CRITICAL, SYSCRG_CLK_AXI_500_PCIEX2),
> +	STARFIVE_GATE(SYSCRG_CLK_FLEXNOC_PCIEX2SLV, "sys_clk_flexnoc_pciex2slv",
> +		      CLK_IS_CRITICAL, SYSCRG_CLK_AXI_500_PCIEX2),
> +	STARFIVE_GATE(SYSCRG_CLK_FLEXNOC_PCIEX8MST, "sys_clk_flexnoc_pciex8mst",
> +		      CLK_IS_CRITICAL, SYSCRG_CLK_AXI_500_PCIEX8),
> +	STARFIVE_GATE(SYSCRG_CLK_FLEXNOC_PCIEX8SLV, "sys_clk_flexnoc_pciex8slv",
> +		      CLK_IS_CRITICAL, SYSCRG_CLK_AXI_500_PCIEX8),
> +	STARFIVE_GATE(SYSCRG_CLK_FLEXNOC_GMACSYSSLV, "sys_clk_flexnoc_gmacsysslv",
> +		      CLK_IS_CRITICAL, SYSCRG_CLK_AXI_200_GMAC),
> +	/* gmac1 (se) */
> +	STARFIVE__DIV(SYSCRG_CLK_GMAC_SRC, "sys_clk_gmac_src", 7,
> +		      SYSCRG_CLK_PLL0_OUT),
> +	STARFIVE__DIV(SYSCRG_CLK_GMAC1_GTXCLK_TOP, "sys_clk_gmac1_gtxclk_top", 400,
> +		      SYSCRG_CLK_PLL0_OUT),
> +	STARFIVE__DIV(SYSCRG_CLK_GMAC1_PTP, "sys_clk_gmac1_ptp", 31,
> +		      SYSCRG_CLK_GMAC_SRC),
> +	/* hd audio */
> +	STARFIVE_GATE(SYSCRG_CLK_HD_AUDIO_SYSTEM_CLOCK, "sys_clk_hd_audio_system_clock",
> +		      0, SYSCRG_CLK_APB_BUS_PER7),
> +	STARFIVE_GATE(SYSCRG_CLK_HD_AUDIO_CLOCK_48, "sys_clk_hd_audio_clock_48",
> +		      0, SYSCRG_CLK_HD_AUDIO_48M),
> +	STARFIVE_GATE(SYSCRG_CLK_HD_AUDIO_BCLK_POST_OCC_IN, "sys_clk_hd_audio_bclk_post_occ_in",
> +		      0, SYSCRG_CLK_HD_AUDIO_48M),
> +	/* nne_vip (se) */
> +	STARFIVE_GATE(SYSCRG_CLK_NNE_VIP_ACLK, "sys_clk_nne_vip_aclk",
> +		      0, SYSCRG_CLK_AXI_500),
> +	STARFIVE_GATE(SYSCRG_CLK_NNE_VIP_HCLK, "sys_clk_nne_vip_hclk",
> +		      0, SYSCRG_CLK_AXI_200),
> +	STARFIVE_GMUX(SYSCRG_CLK_NNE_VIP_CLKCORE, "sys_clk_nne_vip_clkcore", 0, 2,
> +		      SYSCRG_CLK_PLL2_OUT,
> +		      SYSCRG_CLK_PLL0_OUT),
> +	/* icg_en */
> +	STARFIVE_GATE(SYSCRG_CLK_GPU_ICG_EN, "sys_clk_gpu_en",
> +		      0, SYSCRG_CLK_GPU_CORE),
> +	STARFIVE_GATE(SYSCRG_CLK_HD_AUDIO_ICG_EN, "sys_clk_hd_audio_en",
> +		      0, SYSCRG_CLK_APB_BUS),
> +	STARFIVE_GATE(SYSCRG_CLK_NNE_ICG_EN, "sys_clk_nne_en",
> +		      CLK_IGNORE_UNUSED, SYSCRG_CLK_PLL2_OUT),
> +};

Please drop the redundant sys_clk_ prefix from all the clock names similar to
how it was done for the JH71X0s.

/Emil
