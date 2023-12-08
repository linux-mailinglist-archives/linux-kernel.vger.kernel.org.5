Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CAC80A437
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjLHNMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHNMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:12:52 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6926171F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 05:12:57 -0800 (PST)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 70D8C3F15F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1702041175;
        bh=K9zgZeSUkIRgWWjMY0ssDLpumUX4eiD6JCn0PCUYG1U=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=g7CWAWM7LE9NDgp2iKsRf2J/mJ4VMrzl2ALULKIIOlaUq0QL3AuCpp8Mc7/KuLKGq
         CVFqMrDV5eY390FzA/fbciqRTAHZhYg1XHD9SJBedYokhXOuh59qgWTbRNRNgyVZOx
         vhWvHsON3ixKlsEccpdL53XFEX+ZJZEmyq+CFSI/LlR1DSSiE/SbmyHW/cTOsHWQmq
         fFl+bT62l3Kzrg7cUpaVwKx/omysURH0qUjoAv05MDmCLvtBmQdFXJubGTaI3yHTnB
         Y190X4LFM/VyKQ2nYYt38a6h0suow/AFwMxpLvilzME7R+1qDKNchC1hzx1wyNSzBS
         7WRnbQo7aKCUg==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-42599db593fso17764601cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 05:12:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702041174; x=1702645974;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9zgZeSUkIRgWWjMY0ssDLpumUX4eiD6JCn0PCUYG1U=;
        b=cYYVodMU0qKedZuZULcy/ZrqpZ58XHD3gwOQIfWccTkSO8UPL8spYMDEC4BGBevU3B
         gJrCkskEekfk88VFaJoaeA123UPWzWXVyqqaeDvcPD7OieH8O4lNORSYc5CzeDHUsVYb
         y/Dy0L54bV6CNWpIvxO4hn5eHN3CvTiH/OP/wVC8HuU2wESIfK0hxHbQt7A43o/ioNP+
         PQXvMUusNBnG2gXrkvzGik+HNrNHM63FxU5aqfQtQxCB32qI7U+Hea3plCdYjw+ZrEIM
         ro4QPFOlYY+wuqMRmf5LTxngmgnPPumAh186SaYvMLAxTi3vmJ4713IPrqglX1FGqycM
         Bplw==
X-Gm-Message-State: AOJu0YydmXKpLUe8tlFfPTfgv03aJBL5gn+azMT1V/W917FbemnPLnLB
        W3SuL6gohta1BjH0EwwT31UmVGlf9Kf4A+a3ez9XNVU2WEsmV9zantD0WsgVOClec7OFXNy9ZCe
        DPs27nN1vBW++ixmXQZsHg647IEHwfxL1uVxdLYR6Gtzb3hh6p1jVrCbuKA==
X-Received: by 2002:a05:622a:44d:b0:425:4054:bc5e with SMTP id o13-20020a05622a044d00b004254054bc5emr1204030qtx.58.1702041174449;
        Fri, 08 Dec 2023 05:12:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMDwD1ffbD4BKzlSumuMZD3sOD+sywLn2kwgwb+azE8LEIA/r3L2mxNLPHVXDnFbuSkerKtd9gx6pjrsRIO9Y=
X-Received: by 2002:a05:622a:44d:b0:425:4054:bc5e with SMTP id
 o13-20020a05622a044d00b004254054bc5emr1204009qtx.58.1702041174155; Fri, 08
 Dec 2023 05:12:54 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 Dec 2023 08:12:53 -0500
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231206115000.295825-2-jeeheng.sia@starfivetech.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com> <20231206115000.295825-2-jeeheng.sia@starfivetech.com>
Mime-Version: 1.0
Date:   Fri, 8 Dec 2023 08:12:53 -0500
Message-ID: <CAJM55Z8uDFH1cmNdqLBy3sdF5ddxA5N1Mf_oeOmEiDg0z03AHg@mail.gmail.com>
Subject: Re: [PATCH v1 01/16] reset: starfive: Rename file name "jh71x0" to "common"
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sia Jee Heng wrote:
> StarFive JH8100 shares a similar clock and reset design with JH7110.
> To facilitate the reuse of the file and its functionalities, files
> containing the "jh71x0" naming convention are renamed to use the
> "common" wording.
>
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  drivers/clk/starfive/clk-starfive-jh7110-sys.c              | 2 +-
>  drivers/reset/starfive/Kconfig                              | 6 +++---
>  drivers/reset/starfive/Makefile                             | 2 +-
>  .../{reset-starfive-jh71x0.c => reset-starfive-common.c}    | 4 ++--
>  .../{reset-starfive-jh71x0.h => reset-starfive-common.h}    | 6 +++---
>  drivers/reset/starfive/reset-starfive-jh7100.c              | 2 +-
>  drivers/reset/starfive/reset-starfive-jh7110.c              | 4 ++--
>  .../{reset-starfive-jh71x0.h => reset-starfive-common.h}    | 4 ++--
>  8 files changed, 15 insertions(+), 15 deletions(-)
>  rename drivers/reset/starfive/{reset-starfive-jh71x0.c => reset-starfive-common.c} (97%)
>  rename drivers/reset/starfive/{reset-starfive-jh71x0.h => reset-starfive-common.h} (75%)
>  rename include/soc/starfive/{reset-starfive-jh71x0.h => reset-starfive-common.h} (81%)
>
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> index 3884eff9fe93..6e45c580c9ba 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> @@ -14,7 +14,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>
> -#include <soc/starfive/reset-starfive-jh71x0.h>
> +#include <soc/starfive/reset-starfive-common.h>
>
>  #include <dt-bindings/clock/starfive,jh7110-crg.h>
>
> diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kconfig
> index d832339f61bc..29fbcf1a7d83 100644
> --- a/drivers/reset/starfive/Kconfig
> +++ b/drivers/reset/starfive/Kconfig
> @@ -1,12 +1,12 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>
> -config RESET_STARFIVE_JH71X0
> +config RESET_STARFIVE_COMMON
>  	bool
>
>  config RESET_STARFIVE_JH7100
>  	bool "StarFive JH7100 Reset Driver"
>  	depends on ARCH_STARFIVE || COMPILE_TEST
> -	select RESET_STARFIVE_JH71X0
> +	select RESET_STARFIVE_COMMON
>  	default ARCH_STARFIVE
>  	help
>  	  This enables the reset controller driver for the StarFive JH7100 SoC.
> @@ -15,7 +15,7 @@ config RESET_STARFIVE_JH7110
>  	bool "StarFive JH7110 Reset Driver"
>  	depends on CLK_STARFIVE_JH7110_SYS
>  	select AUXILIARY_BUS
> -	select RESET_STARFIVE_JH71X0
> +	select RESET_STARFIVE_COMMON
>  	default ARCH_STARFIVE
>  	help
>  	  This enables the reset controller driver for the StarFive JH7110 SoC.
> diff --git a/drivers/reset/starfive/Makefile b/drivers/reset/starfive/Makefile
> index 7a44b66fb9d5..582e4c160bd4 100644
> --- a/drivers/reset/starfive/Makefile
> +++ b/drivers/reset/starfive/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_RESET_STARFIVE_JH71X0)		+= reset-starfive-jh71x0.o
> +obj-$(CONFIG_RESET_STARFIVE_COMMON)		+= reset-starfive-common.o
>
>  obj-$(CONFIG_RESET_STARFIVE_JH7100)		+= reset-starfive-jh7100.o
>  obj-$(CONFIG_RESET_STARFIVE_JH7110)		+= reset-starfive-jh7110.o
> diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.c b/drivers/reset/starfive/reset-starfive-common.c
> similarity index 97%
> rename from drivers/reset/starfive/reset-starfive-jh71x0.c
> rename to drivers/reset/starfive/reset-starfive-common.c
> index 55bbbd2de52c..dab454e46bbf 100644
> --- a/drivers/reset/starfive/reset-starfive-jh71x0.c
> +++ b/drivers/reset/starfive/reset-starfive-common.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Reset driver for the StarFive JH71X0 SoCs
> + * Reset driver for the StarFive SoCs
>   *
>   * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
>   */
> @@ -12,7 +12,7 @@
>  #include <linux/reset-controller.h>
>  #include <linux/spinlock.h>
>
> -#include "reset-starfive-jh71x0.h"
> +#include "reset-starfive-common.h"
>
>  struct jh71x0_reset {
>  	struct reset_controller_dev rcdev;
> diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.h b/drivers/reset/starfive/reset-starfive-common.h
> similarity index 75%
> rename from drivers/reset/starfive/reset-starfive-jh71x0.h
> rename to drivers/reset/starfive/reset-starfive-common.h
> index db7d39a87f87..266acc4b2caf 100644
> --- a/drivers/reset/starfive/reset-starfive-jh71x0.h
> +++ b/drivers/reset/starfive/reset-starfive-common.h
> @@ -3,12 +3,12 @@
>   * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
>   */
>
> -#ifndef __RESET_STARFIVE_JH71X0_H
> -#define __RESET_STARFIVE_JH71X0_H
> +#ifndef __RESET_STARFIVE_COMMON_H
> +#define __RESET_STARFIVE_COMMON_H
>
>  int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
>  				   void __iomem *assert, void __iomem *status,
>  				   const u32 *asserted, unsigned int nr_resets,
>  				   struct module *owner);
>
> -#endif /* __RESET_STARFIVE_JH71X0_H */
> +#endif /* __RESET_STARFIVE_COMMON_H */
> diff --git a/drivers/reset/starfive/reset-starfive-jh7100.c b/drivers/reset/starfive/reset-starfive-jh7100.c
> index 2a56f7fd4ba7..546dea2e5811 100644
> --- a/drivers/reset/starfive/reset-starfive-jh7100.c
> +++ b/drivers/reset/starfive/reset-starfive-jh7100.c
> @@ -8,7 +8,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>
> -#include "reset-starfive-jh71x0.h"
> +#include "reset-starfive-common.h"
>
>  #include <dt-bindings/reset/starfive-jh7100.h>
>
> diff --git a/drivers/reset/starfive/reset-starfive-jh7110.c b/drivers/reset/starfive/reset-starfive-jh7110.c
> index 29a43f0f2ad6..87dba01491ae 100644
> --- a/drivers/reset/starfive/reset-starfive-jh7110.c
> +++ b/drivers/reset/starfive/reset-starfive-jh7110.c
> @@ -7,9 +7,9 @@
>
>  #include <linux/auxiliary_bus.h>
>
> -#include <soc/starfive/reset-starfive-jh71x0.h>
> +#include <soc/starfive/reset-starfive-common.h>
>
> -#include "reset-starfive-jh71x0.h"
> +#include "reset-starfive-common.h"
>
>  #include <dt-bindings/reset/starfive,jh7110-crg.h>
>
> diff --git a/include/soc/starfive/reset-starfive-jh71x0.h b/include/soc/starfive/reset-starfive-common.h
> similarity index 81%
> rename from include/soc/starfive/reset-starfive-jh71x0.h
> rename to include/soc/starfive/reset-starfive-common.h
> index 47b486ececc5..56d8f413cf18 100644
> --- a/include/soc/starfive/reset-starfive-jh71x0.h
> +++ b/include/soc/starfive/reset-starfive-common.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __SOC_STARFIVE_RESET_JH71X0_H
> -#define __SOC_STARFIVE_RESET_JH71X0_H
> +#ifndef __SOC_STARFIVE_RESET_COMMON_H
> +#define __SOC_STARFIVE_RESET_COMMON_H
>
>  #include <linux/auxiliary_bus.h>
>  #include <linux/compiler_types.h>
> --
> 2.34.1
>
