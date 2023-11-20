Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854297F0C91
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjKTHKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjKTHKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:10:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E5AD49
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:10:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65B9C433C8;
        Mon, 20 Nov 2023 07:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700464233;
        bh=QK0PgTaVbBvv2X0aIH9Uuk5IFiowbBZz2Na5Q67+0l4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sj5B7rO78qQYLL8NNM7p/sbM3F5CbfQ4qszGQUqJZlu9gjL6JWWvXdfH/1l8d6rn5
         cC/wETWQp9bALHwN1OT02i4ccZ9ogaGjMf2UIEdEBEzCe4Jrog1R/zZVwG5PEXezXr
         ZqTF7/Io/R34rfikNQ8bvH6LN6FYd/GUwQcwliVHSDDVYOdN84rVJWaAHsVo/fthxj
         ZmprUWN1SOnZxZJWSGl55AvxC+KmYEAuyYemwz2K+0fcaM9S4sf/p34+UOXEzBP8Kp
         MHD4pDrMh+IJBGzBBYcKpynPqTo4iv6cvcYsS0a6sJDxzbuodJQCjLQ2rAMpRDaexc
         SkA712JzL/WGA==
Date:   Mon, 20 Nov 2023 16:10:28 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Baruch Siach <baruch@tkos.co.il>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/9] ARM: mach-uniphier: Move Socionext UniPhier
 support into Kconfig.platforms
Message-Id: <20231120161028.5b68bd38099fbf9686d29d21@kernel.org>
In-Reply-To: <20231113144359.174140-5-afd@ti.com>
References: <20231113144359.174140-1-afd@ti.com>
        <20231113144359.174140-5-afd@ti.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2023 08:43:54 -0600
Andrew Davis <afd@ti.com> wrote:

> This removes the need for a dedicated Kconfig and empty mach directory.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

This looks good to me. 

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  MAINTAINERS                    |  1 -
>  arch/arm/Kconfig               |  2 --
>  arch/arm/Kconfig.platforms     | 15 +++++++++++++++
>  arch/arm/mach-uniphier/Kconfig | 15 ---------------
>  4 files changed, 15 insertions(+), 18 deletions(-)
>  delete mode 100644 arch/arm/mach-uniphier/Kconfig
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97f51d5ec1cfd..b1ee757a4306d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2957,7 +2957,6 @@ F:	Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
>  F:	Documentation/devicetree/bindings/soc/socionext/socionext,uniphier*.yaml
>  F:	arch/arm/boot/dts/socionext/uniphier*
>  F:	arch/arm/include/asm/hardware/cache-uniphier.h
> -F:	arch/arm/mach-uniphier/
>  F:	arch/arm/mm/cache-uniphier.c
>  F:	arch/arm64/boot/dts/socionext/uniphier*
>  F:	drivers/bus/uniphier-system-bus.c
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e1aeaf25d7aab..cfdfba4d52e19 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -466,8 +466,6 @@ source "arch/arm/mach-sunxi/Kconfig"
>  
>  source "arch/arm/mach-tegra/Kconfig"
>  
> -source "arch/arm/mach-uniphier/Kconfig"
> -
>  source "arch/arm/mach-ux500/Kconfig"
>  
>  source "arch/arm/mach-versatile/Kconfig"
> diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
> index 80f5b040e6ef4..0e6d7172bf61e 100644
> --- a/arch/arm/Kconfig.platforms
> +++ b/arch/arm/Kconfig.platforms
> @@ -83,3 +83,18 @@ config ARCH_RDA
>  	select RDA_TIMER
>  	help
>  	  This enables support for the RDA Micro 8810PL SoC family.
> +
> +config ARCH_UNIPHIER
> +	bool "Socionext UniPhier SoCs"
> +	depends on ARCH_MULTI_V7
> +	select ARCH_HAS_RESET_CONTROLLER
> +	select ARM_AMBA
> +	select ARM_GLOBAL_TIMER
> +	select ARM_GIC
> +	select HAVE_ARM_SCU
> +	select HAVE_ARM_TWD if SMP
> +	select PINCTRL
> +	select RESET_CONTROLLER
> +	help
> +	  Support for UniPhier SoC family developed by Socionext Inc.
> +	  (formerly, System LSI Business Division of Panasonic Corporation)
> diff --git a/arch/arm/mach-uniphier/Kconfig b/arch/arm/mach-uniphier/Kconfig
> deleted file mode 100644
> index e661d26266751..0000000000000
> --- a/arch/arm/mach-uniphier/Kconfig
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -config ARCH_UNIPHIER
> -	bool "Socionext UniPhier SoCs"
> -	depends on ARCH_MULTI_V7
> -	select ARCH_HAS_RESET_CONTROLLER
> -	select ARM_AMBA
> -	select ARM_GLOBAL_TIMER
> -	select ARM_GIC
> -	select HAVE_ARM_SCU
> -	select HAVE_ARM_TWD if SMP
> -	select PINCTRL
> -	select RESET_CONTROLLER
> -	help
> -	  Support for UniPhier SoC family developed by Socionext Inc.
> -	  (formerly, System LSI Business Division of Panasonic Corporation)
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
