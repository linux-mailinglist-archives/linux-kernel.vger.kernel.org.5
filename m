Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB38766119
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 03:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjG1BPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 21:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjG1BPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 21:15:39 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0AB30ED;
        Thu, 27 Jul 2023 18:15:36 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id EA9835C01A5;
        Thu, 27 Jul 2023 21:15:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 27 Jul 2023 21:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1690506932; x=1690593332; bh=7dnleHlm1IYnr6iCJwAu3V8UveWoChLXqZO
        mYdjb56Q=; b=UX09S4dvFnIe9wCAMHUeL+NxNGa1V8VJFeYbic1PXue7TYo4MKM
        zNk/7fpqfLj5Cq/a6qA6J+7Rf4dwRWQkNA++D4HwrJsIzTH+j5rkCUrr+XbPk70U
        HTC1P1fjhhdqVKdnOI0eJAaJMG8/IPwvwy880viO/AfixLBDFfM4VlQPVZeLPC/F
        hUfliD1JPbx+OIa/Y7fDjbQ3ePtQzvWamBVJG3vIu5xHEMUNJLzbgUZdqmKuBvKe
        SXmHZW21GOqHuuOpDLPWJUKRfAf+UAJLp+7bhOhUXzxrMW6zeVyMAlsoqGSMPWVK
        8h2AxJ2PJ0vho/KOxB9cSFI/2RMNv0jXENA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690506932; x=1690593332; bh=7dnleHlm1IYnr6iCJwAu3V8UveWoChLXqZO
        mYdjb56Q=; b=tmzz+cSYLb94RYNPsvQoFq9sIjUYkU7VZEEDXf0zW0SfYNiVrRt
        kIWcrHnXF5nZRnUk3AfdF0YWN9XCt7SZo166a4wO/7CMzpqt7SmqgBQnrMfc5pRp
        Xohij63D4BfkDza/93yscUqZ9Ypq8G7blCOpBlF8Osrcp47UoEaF0M7SJKKxZdky
        hGehd+MRX1t5g2b0c68wseJgpwe0YCZZLrxbsj2d2wLljMEt4ZRBGivNDarSiDJP
        hwQoJnqGqa0czRBFTAYBHixySziLJTnY4aNOocduHnhvk2ehI+1k3noPE7oq9Kxj
        KHtKL8hPW23TeBekWh4FCX1ex2WXhltsJwQ==
X-ME-Sender: <xms:tBbDZAxaxSeF-LOeICNDswhWXIRPQGyFmAeiq0N64uKL1jMth2XM9g>
    <xme:tBbDZEQ79PBTbEiQc4j-cjJz4bK-f9UQLrOyIynhCCx5XkVY06aqTVpe8QCi8m6x4
    tlgea_-8ao_>
X-ME-Received: <xmr:tBbDZCWsTJez0Z4OnslfgbhnbX1uub92z-ParVUsKTxdeqv_ahVDH0k0tppDI1UHqNhFZnmx30_N7ZyMkRBBg6gkT4Kl8c-dHBMKUAanq2IwPxqJOXk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieehgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    euhfeuieeijeeuveekgfeitdethefguddtleffhfelfeelhfduuedvfefhgefhheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:tBbDZOj1TVu0EzPIxAgJvyB6whhE3tzmVhbOms5_fd7I016Syb5B6A>
    <xmx:tBbDZCDoQwkzJdYOKKtAADL_P0SH7Wetr5ifzCIgmskCKzo3XBAcYw>
    <xmx:tBbDZPIx3TKLwkKzCjD7EHlbCxZa7BlCskPpcJUHvcSzVjEBmUNllA>
    <xmx:tBbDZD7Wpu4sP_VWa-Z5LmZWS5l6WcHa9LB5Qo-6YTktn_0irpV6jw>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 21:15:30 -0400 (EDT)
Message-ID: <70487905-c2a2-13b8-67a2-3863d179ae83@themaw.net>
Date:   Fri, 28 Jul 2023 09:15:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arch/*/configs/*defconfig: Replace AUTOFS4_FS by
 AUTOFS_FS
Content-Language: en-US
To:     Sven Joachim <svenjoac@gmx.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     autofs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230727200041.21404-1-svenjoac@gmx.de>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <20230727200041.21404-1-svenjoac@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/7/23 04:00, Sven Joachim wrote:
> Commit a2225d931f75 ("autofs: remove left-over autofs4 stubs")
> promised the removal of the fs/autofs/Kconfig fragment for AUTOFS4_FS
> within a couple of releases, but five years later this still has not
> happened yet, and AUTOFS4_FS is still enabled in 63 defconfigs.  Get
> rid of it mechanically:

Thanks Sven.


Acked-by: Ian Kent <raven@themaw.net>


IIRC almost everything I tried worked fine when I checked this.


I suspect there will be an odd case or two but getting rid of

it is definitely the right thing to do especially since people

have had more than enough time to become aware of the change

and the need for it.


Ian

>
> find arch -name "*defconfig" -exec sed -i 's/AUTOFS4_FS/AUTOFS_FS/' '{}' \;
>
> Signed-off-by: Sven Joachim <svenjoac@gmx.de>
> ---
>   arch/arm/configs/axm55xx_defconfig          | 2 +-
>   arch/arm/configs/davinci_all_defconfig      | 2 +-
>   arch/arm/configs/exynos_defconfig           | 2 +-
>   arch/arm/configs/footbridge_defconfig       | 2 +-
>   arch/arm/configs/imx_v6_v7_defconfig        | 2 +-
>   arch/arm/configs/keystone_defconfig         | 2 +-
>   arch/arm/configs/lpc32xx_defconfig          | 2 +-
>   arch/arm/configs/milbeaut_m10v_defconfig    | 2 +-
>   arch/arm/configs/multi_v7_defconfig         | 2 +-
>   arch/arm/configs/omap1_defconfig            | 2 +-
>   arch/arm/configs/omap2plus_defconfig        | 2 +-
>   arch/arm/configs/pxa_defconfig              | 2 +-
>   arch/arm/configs/rpc_defconfig              | 2 +-
>   arch/arm/configs/s5pv210_defconfig          | 2 +-
>   arch/arm/configs/socfpga_defconfig          | 2 +-
>   arch/arm/configs/spear13xx_defconfig        | 2 +-
>   arch/arm/configs/spear3xx_defconfig         | 2 +-
>   arch/arm/configs/spear6xx_defconfig         | 2 +-
>   arch/arm64/configs/defconfig                | 2 +-
>   arch/ia64/configs/bigsur_defconfig          | 2 +-
>   arch/ia64/configs/generic_defconfig         | 2 +-
>   arch/ia64/configs/gensparse_defconfig       | 2 +-
>   arch/ia64/configs/tiger_defconfig           | 2 +-
>   arch/loongarch/configs/loongson3_defconfig  | 2 +-
>   arch/mips/configs/bigsur_defconfig          | 2 +-
>   arch/mips/configs/fuloong2e_defconfig       | 2 +-
>   arch/mips/configs/ip22_defconfig            | 2 +-
>   arch/mips/configs/ip32_defconfig            | 2 +-
>   arch/mips/configs/jazz_defconfig            | 2 +-
>   arch/mips/configs/lemote2f_defconfig        | 2 +-
>   arch/mips/configs/loongson2k_defconfig      | 2 +-
>   arch/mips/configs/loongson3_defconfig       | 2 +-
>   arch/mips/configs/mtx1_defconfig            | 2 +-
>   arch/mips/configs/pic32mzda_defconfig       | 2 +-
>   arch/mips/configs/rm200_defconfig           | 2 +-
>   arch/parisc/configs/generic-32bit_defconfig | 2 +-
>   arch/parisc/configs/generic-64bit_defconfig | 2 +-
>   arch/powerpc/configs/44x/sam440ep_defconfig | 2 +-
>   arch/powerpc/configs/85xx/stx_gp3_defconfig | 2 +-
>   arch/powerpc/configs/cell_defconfig         | 2 +-
>   arch/powerpc/configs/ep8248e_defconfig      | 2 +-
>   arch/powerpc/configs/mgcoge_defconfig       | 2 +-
>   arch/powerpc/configs/pasemi_defconfig       | 2 +-
>   arch/powerpc/configs/pmac32_defconfig       | 2 +-
>   arch/powerpc/configs/powernv_defconfig      | 2 +-
>   arch/powerpc/configs/ppc64_defconfig        | 2 +-
>   arch/powerpc/configs/ppc64e_defconfig       | 2 +-
>   arch/powerpc/configs/ppc6xx_defconfig       | 2 +-
>   arch/powerpc/configs/ps3_defconfig          | 2 +-
>   arch/riscv/configs/defconfig                | 2 +-
>   arch/riscv/configs/rv32_defconfig           | 2 +-
>   arch/s390/configs/debug_defconfig           | 2 +-
>   arch/s390/configs/defconfig                 | 2 +-
>   arch/sh/configs/espt_defconfig              | 2 +-
>   arch/sh/configs/sdk7780_defconfig           | 2 +-
>   arch/sh/configs/sdk7786_defconfig           | 2 +-
>   arch/sh/configs/sh03_defconfig              | 2 +-
>   arch/sh/configs/sh7763rdp_defconfig         | 2 +-
>   arch/sparc/configs/sparc32_defconfig        | 2 +-
>   arch/um/configs/i386_defconfig              | 2 +-
>   arch/um/configs/x86_64_defconfig            | 2 +-
>   arch/x86/configs/i386_defconfig             | 2 +-
>   arch/x86/configs/x86_64_defconfig           | 2 +-
>   63 files changed, 63 insertions(+), 63 deletions(-)
>
> diff --git a/arch/arm/configs/axm55xx_defconfig b/arch/arm/configs/axm55xx_defconfig
> index bfbaa2df3be5..d1c550894a65 100644
> --- a/arch/arm/configs/axm55xx_defconfig
> +++ b/arch/arm/configs/axm55xx_defconfig
> @@ -197,7 +197,7 @@ CONFIG_EXT2_FS=y
>   CONFIG_EXT3_FS=y
>   # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
>   CONFIG_EXT4_FS=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_FUSE_FS=y
>   CONFIG_CUSE=y
>   CONFIG_FSCACHE=y
> diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
> index 821d966c95a5..05ea71778ef8 100644
> --- a/arch/arm/configs/davinci_all_defconfig
> +++ b/arch/arm/configs/davinci_all_defconfig
> @@ -232,7 +232,7 @@ CONFIG_EXT2_FS=y
>   CONFIG_EXT3_FS=y
>   CONFIG_EXT4_FS_POSIX_ACL=y
>   CONFIG_XFS_FS=m
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_MSDOS_FS=y
>   CONFIG_VFAT_FS=y
>   CONFIG_TMPFS=y
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index b0f0baa3a6c4..53b1d41b4a8b 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -327,7 +327,7 @@ CONFIG_PWM_SAMSUNG=y
>   CONFIG_PHY_EXYNOS5250_SATA=y
>   CONFIG_EXT2_FS=y
>   CONFIG_EXT4_FS=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_MSDOS_FS=y
>   CONFIG_VFAT_FS=y
>   CONFIG_TMPFS=y
> diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/footbridge_defconfig
> index 87c489337d0e..c9f4594b7ca9 100644
> --- a/arch/arm/configs/footbridge_defconfig
> +++ b/arch/arm/configs/footbridge_defconfig
> @@ -94,7 +94,7 @@ CONFIG_LEDS_CLASS=y
>   CONFIG_LEDS_TRIGGERS=y
>   CONFIG_LEDS_TRIGGER_TIMER=y
>   CONFIG_EXT2_FS=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_ISO9660_FS=m
>   CONFIG_JOLIET=y
>   CONFIG_MSDOS_FS=m
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 05706696a5fb..0a90583f9f01 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -442,7 +442,7 @@ CONFIG_EXT3_FS_SECURITY=y
>   CONFIG_QUOTA=y
>   CONFIG_QUOTA_NETLINK_INTERFACE=y
>   # CONFIG_PRINT_QUOTA_WARNING is not set
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_FUSE_FS=y
>   CONFIG_ISO9660_FS=m
>   CONFIG_JOLIET=y
> diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
> index d7a0bca641eb..1cb145633a91 100644
> --- a/arch/arm/configs/keystone_defconfig
> +++ b/arch/arm/configs/keystone_defconfig
> @@ -207,7 +207,7 @@ CONFIG_RESET_TI_SYSCON=m
>   CONFIG_EXT4_FS=y
>   CONFIG_EXT4_FS_POSIX_ACL=y
>   CONFIG_FANOTIFY=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_MSDOS_FS=y
>   CONFIG_VFAT_FS=y
>   CONFIG_NTFS_FS=y
> diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
> index d7df0486850f..e2b0ff0b253f 100644
> --- a/arch/arm/configs/lpc32xx_defconfig
> +++ b/arch/arm/configs/lpc32xx_defconfig
> @@ -162,7 +162,7 @@ CONFIG_MAX517=y
>   CONFIG_PWM=y
>   CONFIG_PWM_LPC32XX=y
>   CONFIG_EXT2_FS=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_MSDOS_FS=y
>   CONFIG_VFAT_FS=y
>   CONFIG_TMPFS=y
> diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
> index 385ad0f391a8..7d4284502325 100644
> --- a/arch/arm/configs/milbeaut_m10v_defconfig
> +++ b/arch/arm/configs/milbeaut_m10v_defconfig
> @@ -81,7 +81,7 @@ CONFIG_SOC_BRCMSTB=y
>   CONFIG_MEMORY=y
>   # CONFIG_ARM_PMU is not set
>   CONFIG_EXT4_FS=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_MSDOS_FS=y
>   CONFIG_VFAT_FS=y
>   CONFIG_NTFS_FS=y
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index f0800f806b5f..c7b2550d706c 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -1226,7 +1226,7 @@ CONFIG_COUNTER=m
>   CONFIG_STM32_TIMER_CNT=m
>   CONFIG_STM32_LPTIMER_CNT=m
>   CONFIG_EXT4_FS=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_MSDOS_FS=y
>   CONFIG_VFAT_FS=y
>   CONFIG_NTFS_FS=y
> diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
> index 53dd0717cea5..7c2cc7a89511 100644
> --- a/arch/arm/configs/omap1_defconfig
> +++ b/arch/arm/configs/omap1_defconfig
> @@ -188,7 +188,7 @@ CONFIG_RTC_DRV_OMAP=y
>   CONFIG_EXT2_FS=y
>   CONFIG_EXT3_FS=y
>   # CONFIG_DNOTIFY is not set
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_ISO9660_FS=y
>   CONFIG_JOLIET=y
>   CONFIG_MSDOS_FS=y
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 9bd36dd39bd0..b685018dcf54 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -678,7 +678,7 @@ CONFIG_EXT4_FS_SECURITY=y
>   CONFIG_FANOTIFY=y
>   CONFIG_QUOTA=y
>   CONFIG_QFMT_V2=y
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_MSDOS_FS=y
>   CONFIG_VFAT_FS=y
>   CONFIG_TMPFS=y
> diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
> index b46e39369dbb..b0c3355e2599 100644
> --- a/arch/arm/configs/pxa_defconfig
> +++ b/arch/arm/configs/pxa_defconfig
> @@ -589,7 +589,7 @@ CONFIG_REISERFS_FS_XATTR=y
>   CONFIG_REISERFS_FS_POSIX_ACL=y
>   CONFIG_REISERFS_FS_SECURITY=y
>   CONFIG_XFS_FS=m
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_FUSE_FS=m
>   CONFIG_CUSE=m
>   CONFIG_FSCACHE=y
> diff --git a/arch/arm/configs/rpc_defconfig b/arch/arm/configs/rpc_defconfig
> index 65a3fded55be..b1d12a2c2ef8 100644
> --- a/arch/arm/configs/rpc_defconfig
> +++ b/arch/arm/configs/rpc_defconfig
> @@ -79,7 +79,7 @@ CONFIG_RTC_CLASS=y
>   CONFIG_RTC_DRV_PCF8583=y
>   CONFIG_EXT2_FS=y
>   CONFIG_EXT3_FS=y
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_ISO9660_FS=y
>   CONFIG_JOLIET=y
>   CONFIG_MSDOS_FS=m
> diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
> index 4c1e480b5bbd..72df854878f8 100644
> --- a/arch/arm/configs/s5pv210_defconfig
> +++ b/arch/arm/configs/s5pv210_defconfig
> @@ -103,7 +103,7 @@ CONFIG_PHY_SAMSUNG_USB2=m
>   CONFIG_PHY_S5PV210_USB2=y
>   CONFIG_EXT2_FS=y
>   CONFIG_EXT4_FS=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_MSDOS_FS=y
>   CONFIG_VFAT_FS=y
>   CONFIG_TMPFS=y
> diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
> index 70739e09d0f4..d6dfae196f84 100644
> --- a/arch/arm/configs/socfpga_defconfig
> +++ b/arch/arm/configs/socfpga_defconfig
> @@ -136,7 +136,7 @@ CONFIG_EXT2_FS=y
>   CONFIG_EXT2_FS_XATTR=y
>   CONFIG_EXT2_FS_POSIX_ACL=y
>   CONFIG_EXT3_FS=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_VFAT_FS=y
>   CONFIG_NTFS_FS=y
>   CONFIG_NTFS_RW=y
> diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
> index bfde0c86cdc5..c8128a6180e7 100644
> --- a/arch/arm/configs/spear13xx_defconfig
> +++ b/arch/arm/configs/spear13xx_defconfig
> @@ -85,7 +85,7 @@ CONFIG_EXT2_FS_XATTR=y
>   CONFIG_EXT2_FS_SECURITY=y
>   CONFIG_EXT3_FS=y
>   CONFIG_EXT3_FS_SECURITY=y
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_FUSE_FS=y
>   CONFIG_MSDOS_FS=m
>   CONFIG_VFAT_FS=m
> diff --git a/arch/arm/configs/spear3xx_defconfig b/arch/arm/configs/spear3xx_defconfig
> index a96ed5cf778e..97ea2e9a6f07 100644
> --- a/arch/arm/configs/spear3xx_defconfig
> +++ b/arch/arm/configs/spear3xx_defconfig
> @@ -68,7 +68,7 @@ CONFIG_EXT2_FS_XATTR=y
>   CONFIG_EXT2_FS_SECURITY=y
>   CONFIG_EXT3_FS=y
>   CONFIG_EXT3_FS_SECURITY=y
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_MSDOS_FS=m
>   CONFIG_VFAT_FS=m
>   CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
> diff --git a/arch/arm/configs/spear6xx_defconfig b/arch/arm/configs/spear6xx_defconfig
> index 3e2c2abae5ba..a7a3413ac968 100644
> --- a/arch/arm/configs/spear6xx_defconfig
> +++ b/arch/arm/configs/spear6xx_defconfig
> @@ -54,7 +54,7 @@ CONFIG_EXT2_FS_XATTR=y
>   CONFIG_EXT2_FS_SECURITY=y
>   CONFIG_EXT3_FS=y
>   CONFIG_EXT3_FS_SECURITY=y
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_MSDOS_FS=m
>   CONFIG_VFAT_FS=m
>   CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0777bcae9104..a25d783dfb95 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1469,7 +1469,7 @@ CONFIG_BTRFS_FS_POSIX_ACL=y
>   CONFIG_FANOTIFY=y
>   CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
>   CONFIG_QUOTA=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_FUSE_FS=m
>   CONFIG_CUSE=m
>   CONFIG_OVERLAY_FS=m
> diff --git a/arch/ia64/configs/bigsur_defconfig b/arch/ia64/configs/bigsur_defconfig
> index 3e1337aceb37..7cb96db9a25d 100644
> --- a/arch/ia64/configs/bigsur_defconfig
> +++ b/arch/ia64/configs/bigsur_defconfig
> @@ -77,7 +77,7 @@ CONFIG_EXT3_FS=y
>   CONFIG_XFS_FS=y
>   CONFIG_XFS_QUOTA=y
>   CONFIG_XFS_POSIX_ACL=y
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_ISO9660_FS=m
>   CONFIG_JOLIET=y
>   CONFIG_UDF_FS=m
> diff --git a/arch/ia64/configs/generic_defconfig b/arch/ia64/configs/generic_defconfig
> index f8033bacea89..4581240013dd 100644
> --- a/arch/ia64/configs/generic_defconfig
> +++ b/arch/ia64/configs/generic_defconfig
> @@ -146,7 +146,7 @@ CONFIG_REISERFS_FS_XATTR=y
>   CONFIG_REISERFS_FS_POSIX_ACL=y
>   CONFIG_REISERFS_FS_SECURITY=y
>   CONFIG_XFS_FS=y
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_ISO9660_FS=m
>   CONFIG_JOLIET=y
>   CONFIG_UDF_FS=m
> diff --git a/arch/ia64/configs/gensparse_defconfig b/arch/ia64/configs/gensparse_defconfig
> index ffebe6c503f5..c9e806616544 100644
> --- a/arch/ia64/configs/gensparse_defconfig
> +++ b/arch/ia64/configs/gensparse_defconfig
> @@ -127,7 +127,7 @@ CONFIG_REISERFS_FS_XATTR=y
>   CONFIG_REISERFS_FS_POSIX_ACL=y
>   CONFIG_REISERFS_FS_SECURITY=y
>   CONFIG_XFS_FS=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_ISO9660_FS=m
>   CONFIG_JOLIET=y
>   CONFIG_UDF_FS=m
> diff --git a/arch/ia64/configs/tiger_defconfig b/arch/ia64/configs/tiger_defconfig
> index 45f5d6e2da0a..d7d8fb5c7b71 100644
> --- a/arch/ia64/configs/tiger_defconfig
> +++ b/arch/ia64/configs/tiger_defconfig
> @@ -110,7 +110,7 @@ CONFIG_REISERFS_FS_XATTR=y
>   CONFIG_REISERFS_FS_POSIX_ACL=y
>   CONFIG_REISERFS_FS_SECURITY=y
>   CONFIG_XFS_FS=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_ISO9660_FS=m
>   CONFIG_JOLIET=y
>   CONFIG_UDF_FS=m
> diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
> index 6cd26dd3c134..d64849b4cba1 100644
> --- a/arch/loongarch/configs/loongson3_defconfig
> +++ b/arch/loongarch/configs/loongson3_defconfig
> @@ -769,7 +769,7 @@ CONFIG_QUOTA=y
>   # CONFIG_PRINT_QUOTA_WARNING is not set
>   CONFIG_QFMT_V1=m
>   CONFIG_QFMT_V2=m
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_FUSE_FS=m
>   CONFIG_OVERLAY_FS=y
>   CONFIG_OVERLAY_FS_INDEX=y
> diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
> index b0cbfa781ffc..e463a9acae03 100644
> --- a/arch/mips/configs/bigsur_defconfig
> +++ b/arch/mips/configs/bigsur_defconfig
> @@ -153,7 +153,7 @@ CONFIG_QUOTA=y
>   CONFIG_QUOTA_NETLINK_INTERFACE=y
>   # CONFIG_PRINT_QUOTA_WARNING is not set
>   CONFIG_QFMT_V2=m
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_FUSE_FS=m
>   CONFIG_ISO9660_FS=m
>   CONFIG_JOLIET=y
> diff --git a/arch/mips/configs/fuloong2e_defconfig b/arch/mips/configs/fuloong2e_defconfig
> index 5458573286a2..1843468f84a3 100644
> --- a/arch/mips/configs/fuloong2e_defconfig
> +++ b/arch/mips/configs/fuloong2e_defconfig
> @@ -178,7 +178,7 @@ CONFIG_EXT3_FS=y
>   CONFIG_EXT4_FS_POSIX_ACL=y
>   CONFIG_EXT4_FS_SECURITY=y
>   CONFIG_REISERFS_FS=m
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_FUSE_FS=y
>   CONFIG_ISO9660_FS=m
>   CONFIG_JOLIET=y
> diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
> index 897e55579af0..44821f497261 100644
> --- a/arch/mips/configs/ip22_defconfig
> +++ b/arch/mips/configs/ip22_defconfig
> @@ -245,7 +245,7 @@ CONFIG_QUOTA=y
>   CONFIG_QUOTA_NETLINK_INTERFACE=y
>   # CONFIG_PRINT_QUOTA_WARNING is not set
>   CONFIG_QFMT_V2=m
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_FUSE_FS=m
>   CONFIG_ISO9660_FS=m
>   CONFIG_JOLIET=y
> diff --git a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_defconfig
> index 418a4181e2fe..930c5f6ed182 100644
> --- a/arch/mips/configs/ip32_defconfig
> +++ b/arch/mips/configs/ip32_defconfig
> @@ -95,7 +95,7 @@ CONFIG_EXT3_FS_SECURITY=y
>   CONFIG_QUOTA=y
>   CONFIG_QFMT_V1=m
>   CONFIG_QFMT_V2=m
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_FUSE_FS=m
>   CONFIG_ISO9660_FS=m
>   CONFIG_JOLIET=y
> diff --git a/arch/mips/configs/jazz_defconfig b/arch/mips/configs/jazz_defconfig
> index 6b5d7e963ed9..fdf374574105 100644
> --- a/arch/mips/configs/jazz_defconfig
> +++ b/arch/mips/configs/jazz_defconfig
> @@ -76,7 +76,7 @@ CONFIG_REISERFS_FS_POSIX_ACL=y
>   CONFIG_REISERFS_FS_SECURITY=y
>   CONFIG_XFS_FS=m
>   CONFIG_XFS_QUOTA=y
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_FUSE_FS=m
>   CONFIG_ISO9660_FS=m
>   CONFIG_JOLIET=y
> diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
> index 7e598d338979..83d9a8ff4270 100644
> --- a/arch/mips/configs/lemote2f_defconfig
> +++ b/arch/mips/configs/lemote2f_defconfig
> @@ -240,7 +240,7 @@ CONFIG_XFS_POSIX_ACL=y
>   CONFIG_BTRFS_FS=m
>   CONFIG_QUOTA=y
>   CONFIG_QFMT_V2=m
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_FSCACHE=m
>   CONFIG_CACHEFILES=m
>   CONFIG_ISO9660_FS=m
> diff --git a/arch/mips/configs/loongson2k_defconfig b/arch/mips/configs/loongson2k_defconfig
> index 0ab029ecad21..ec3ee8df737d 100644
> --- a/arch/mips/configs/loongson2k_defconfig
> +++ b/arch/mips/configs/loongson2k_defconfig
> @@ -296,7 +296,7 @@ CONFIG_XFS_QUOTA=y
>   CONFIG_XFS_POSIX_ACL=y
>   CONFIG_QUOTA=y
>   # CONFIG_PRINT_QUOTA_WARNING is not set
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_FUSE_FS=m
>   CONFIG_ISO9660_FS=m
>   CONFIG_JOLIET=y
> diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
> index 3087e64e6ebe..129426351237 100644
> --- a/arch/mips/configs/loongson3_defconfig
> +++ b/arch/mips/configs/loongson3_defconfig
> @@ -352,7 +352,7 @@ CONFIG_QUOTA=y
>   # CONFIG_PRINT_QUOTA_WARNING is not set
>   CONFIG_QFMT_V1=m
>   CONFIG_QFMT_V2=m
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_FUSE_FS=m
>   CONFIG_VIRTIO_FS=m
>   CONFIG_FSCACHE=m
> diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
> index b64172179160..935585d8bb26 100644
> --- a/arch/mips/configs/mtx1_defconfig
> +++ b/arch/mips/configs/mtx1_defconfig
> @@ -601,7 +601,7 @@ CONFIG_EXT3_FS=m
>   CONFIG_EXT3_FS_POSIX_ACL=y
>   CONFIG_EXT3_FS_SECURITY=y
>   CONFIG_QUOTA=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_FUSE_FS=m
>   CONFIG_ISO9660_FS=m
>   CONFIG_JOLIET=y
> diff --git a/arch/mips/configs/pic32mzda_defconfig b/arch/mips/configs/pic32mzda_defconfig
> index 8397f28355d5..0e494c24246f 100644
> --- a/arch/mips/configs/pic32mzda_defconfig
> +++ b/arch/mips/configs/pic32mzda_defconfig
> @@ -66,7 +66,7 @@ CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
>   CONFIG_EXT4_FS=y
>   CONFIG_EXT4_FS_POSIX_ACL=y
>   CONFIG_EXT4_FS_SECURITY=y
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_FUSE_FS=m
>   CONFIG_FSCACHE=m
>   CONFIG_ISO9660_FS=m
> diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
> index 7475c2cbea89..e0e312dd968a 100644
> --- a/arch/mips/configs/rm200_defconfig
> +++ b/arch/mips/configs/rm200_defconfig
> @@ -317,7 +317,7 @@ CONFIG_REISERFS_FS_POSIX_ACL=y
>   CONFIG_REISERFS_FS_SECURITY=y
>   CONFIG_XFS_FS=m
>   CONFIG_XFS_QUOTA=y
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_FUSE_FS=m
>   CONFIG_ISO9660_FS=m
>   CONFIG_JOLIET=y
> diff --git a/arch/parisc/configs/generic-32bit_defconfig b/arch/parisc/configs/generic-32bit_defconfig
> index 9651f4390029..ee4febb30386 100644
> --- a/arch/parisc/configs/generic-32bit_defconfig
> +++ b/arch/parisc/configs/generic-32bit_defconfig
> @@ -237,7 +237,7 @@ CONFIG_EXT3_FS_SECURITY=y
>   CONFIG_QUOTA=y
>   CONFIG_QUOTA_NETLINK_INTERFACE=y
>   CONFIG_QFMT_V2=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_ISO9660_FS=y
>   CONFIG_JOLIET=y
>   CONFIG_VFAT_FS=y
> diff --git a/arch/parisc/configs/generic-64bit_defconfig b/arch/parisc/configs/generic-64bit_defconfig
> index 6758c030b09d..f6ded7147b4d 100644
> --- a/arch/parisc/configs/generic-64bit_defconfig
> +++ b/arch/parisc/configs/generic-64bit_defconfig
> @@ -259,7 +259,7 @@ CONFIG_BTRFS_FS=m
>   CONFIG_QUOTA=y
>   CONFIG_QUOTA_NETLINK_INTERFACE=y
>   CONFIG_QFMT_V2=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_FUSE_FS=y
>   CONFIG_CUSE=y
>   CONFIG_ISO9660_FS=y
> diff --git a/arch/powerpc/configs/44x/sam440ep_defconfig b/arch/powerpc/configs/44x/sam440ep_defconfig
> index ef09786d49b9..51499ee6366b 100644
> --- a/arch/powerpc/configs/44x/sam440ep_defconfig
> +++ b/arch/powerpc/configs/44x/sam440ep_defconfig
> @@ -79,7 +79,7 @@ CONFIG_EXT2_FS_POSIX_ACL=y
>   CONFIG_EXT4_FS=y
>   CONFIG_EXT4_FS_POSIX_ACL=y
>   CONFIG_REISERFS_FS=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_ISO9660_FS=y
>   CONFIG_JOLIET=y
>   CONFIG_ZISOFS=y
> diff --git a/arch/powerpc/configs/85xx/stx_gp3_defconfig b/arch/powerpc/configs/85xx/stx_gp3_defconfig
> index ecbcc853307d..e7080497048d 100644
> --- a/arch/powerpc/configs/85xx/stx_gp3_defconfig
> +++ b/arch/powerpc/configs/85xx/stx_gp3_defconfig
> @@ -50,7 +50,7 @@ CONFIG_DRM=m
>   CONFIG_SOUND=m
>   CONFIG_EXT2_FS=y
>   CONFIG_EXT4_FS=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_ISO9660_FS=m
>   CONFIG_UDF_FS=m
>   CONFIG_MSDOS_FS=m
> diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/cell_defconfig
> index 06391cc2af3a..53f43a34e1a9 100644
> --- a/arch/powerpc/configs/cell_defconfig
> +++ b/arch/powerpc/configs/cell_defconfig
> @@ -172,7 +172,7 @@ CONFIG_EDAC_CELL=y
>   CONFIG_UIO=m
>   CONFIG_EXT2_FS=y
>   CONFIG_EXT4_FS=y
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_ISO9660_FS=m
>   CONFIG_JOLIET=y
>   CONFIG_UDF_FS=m
> diff --git a/arch/powerpc/configs/ep8248e_defconfig b/arch/powerpc/configs/ep8248e_defconfig
> index b9dfa3a0713b..0d8d3f41f194 100644
> --- a/arch/powerpc/configs/ep8248e_defconfig
> +++ b/arch/powerpc/configs/ep8248e_defconfig
> @@ -47,7 +47,7 @@ CONFIG_SERIAL_CPM_CONSOLE=y
>   # CONFIG_USB_SUPPORT is not set
>   CONFIG_EXT2_FS=y
>   CONFIG_EXT4_FS=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_PROC_KCORE=y
>   CONFIG_TMPFS=y
>   CONFIG_CRAMFS=y
> diff --git a/arch/powerpc/configs/mgcoge_defconfig b/arch/powerpc/configs/mgcoge_defconfig
> index ce220ceeb91c..2101bfe6db94 100644
> --- a/arch/powerpc/configs/mgcoge_defconfig
> +++ b/arch/powerpc/configs/mgcoge_defconfig
> @@ -60,7 +60,7 @@ CONFIG_USB_FSL_USB2=y
>   CONFIG_USB_G_SERIAL=y
>   CONFIG_UIO=y
>   CONFIG_EXT2_FS=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_PROC_KCORE=y
>   CONFIG_TMPFS=y
>   CONFIG_JFFS2_FS=y
> diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
> index 96aa5355911f..61993944db40 100644
> --- a/arch/powerpc/configs/pasemi_defconfig
> +++ b/arch/powerpc/configs/pasemi_defconfig
> @@ -143,7 +143,7 @@ CONFIG_EXT2_FS=y
>   CONFIG_EXT2_FS_XATTR=y
>   CONFIG_EXT2_FS_POSIX_ACL=y
>   CONFIG_EXT4_FS=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_ISO9660_FS=y
>   CONFIG_UDF_FS=y
>   CONFIG_MSDOS_FS=y
> diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
> index 019163c2571e..05ed58576464 100644
> --- a/arch/powerpc/configs/pmac32_defconfig
> +++ b/arch/powerpc/configs/pmac32_defconfig
> @@ -254,7 +254,7 @@ CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
>   CONFIG_EXT2_FS=y
>   CONFIG_EXT4_FS=y
>   CONFIG_EXT4_FS_POSIX_ACL=y
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_FUSE_FS=m
>   CONFIG_ISO9660_FS=y
>   CONFIG_JOLIET=y
> diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
> index e02ab94a09bf..ee84ade7a033 100644
> --- a/arch/powerpc/configs/powernv_defconfig
> +++ b/arch/powerpc/configs/powernv_defconfig
> @@ -270,7 +270,7 @@ CONFIG_BTRFS_FS=m
>   CONFIG_BTRFS_FS_POSIX_ACL=y
>   CONFIG_NILFS2_FS=m
>   CONFIG_FANOTIFY=y
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_FUSE_FS=m
>   CONFIG_OVERLAY_FS=m
>   CONFIG_ISO9660_FS=y
> diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
> index 268fa361a06d..c0f4bbc2c975 100644
> --- a/arch/powerpc/configs/ppc64_defconfig
> +++ b/arch/powerpc/configs/ppc64_defconfig
> @@ -327,7 +327,7 @@ CONFIG_BTRFS_FS=m
>   CONFIG_BTRFS_FS_POSIX_ACL=y
>   CONFIG_NILFS2_FS=m
>   CONFIG_FS_DAX=y
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_FUSE_FS=m
>   CONFIG_OVERLAY_FS=m
>   CONFIG_ISO9660_FS=y
> diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/ppc64e_defconfig
> index 776c32964e12..624c371ffcc3 100644
> --- a/arch/powerpc/configs/ppc64e_defconfig
> +++ b/arch/powerpc/configs/ppc64e_defconfig
> @@ -185,7 +185,7 @@ CONFIG_JFS_SECURITY=y
>   CONFIG_XFS_FS=m
>   CONFIG_XFS_POSIX_ACL=y
>   CONFIG_FS_DAX=y
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_ISO9660_FS=y
>   CONFIG_UDF_FS=m
>   CONFIG_MSDOS_FS=y
> diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
> index f21170b8fa11..1034aeabdd6c 100644
> --- a/arch/powerpc/configs/ppc6xx_defconfig
> +++ b/arch/powerpc/configs/ppc6xx_defconfig
> @@ -969,7 +969,7 @@ CONFIG_XFS_POSIX_ACL=y
>   CONFIG_GFS2_FS=m
>   CONFIG_FS_DAX=y
>   CONFIG_QUOTA_NETLINK_INTERFACE=y
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_FUSE_FS=m
>   CONFIG_ISO9660_FS=y
>   CONFIG_JOLIET=y
> diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
> index ea3ee0719bb2..1ea732c19235 100644
> --- a/arch/powerpc/configs/ps3_defconfig
> +++ b/arch/powerpc/configs/ps3_defconfig
> @@ -129,7 +129,7 @@ CONFIG_EXT2_FS=m
>   CONFIG_EXT4_FS=y
>   CONFIG_QUOTA=y
>   CONFIG_QFMT_V2=y
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_ISO9660_FS=m
>   CONFIG_JOLIET=y
>   CONFIG_UDF_FS=m
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 0a0107460a5c..ab86ec3b9eab 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -192,7 +192,7 @@ CONFIG_EXT4_FS_POSIX_ACL=y
>   CONFIG_EXT4_FS_SECURITY=y
>   CONFIG_BTRFS_FS=m
>   CONFIG_BTRFS_FS_POSIX_ACL=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_OVERLAY_FS=m
>   CONFIG_ISO9660_FS=y
>   CONFIG_JOLIET=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 38760e4296cf..89b601e253a6 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -98,7 +98,7 @@ CONFIG_RPMSG_CTRL=y
>   CONFIG_RPMSG_VIRTIO=y
>   CONFIG_EXT4_FS=y
>   CONFIG_EXT4_FS_POSIX_ACL=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_MSDOS_FS=y
>   CONFIG_VFAT_FS=y
>   CONFIG_TMPFS=y
> diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
> index aa95cf6dfabb..d03d4cb9332c 100644
> --- a/arch/s390/configs/debug_defconfig
> +++ b/arch/s390/configs/debug_defconfig
> @@ -624,7 +624,7 @@ CONFIG_QUOTA_NETLINK_INTERFACE=y
>   CONFIG_QUOTA_DEBUG=y
>   CONFIG_QFMT_V1=m
>   CONFIG_QFMT_V2=m
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_FUSE_FS=y
>   CONFIG_CUSE=m
>   CONFIG_VIRTIO_FS=m
> diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
> index f041945f9148..1855759cdc6a 100644
> --- a/arch/s390/configs/defconfig
> +++ b/arch/s390/configs/defconfig
> @@ -609,7 +609,7 @@ CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
>   CONFIG_QUOTA_NETLINK_INTERFACE=y
>   CONFIG_QFMT_V1=m
>   CONFIG_QFMT_V2=m
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_FUSE_FS=y
>   CONFIG_CUSE=m
>   CONFIG_VIRTIO_FS=m
> diff --git a/arch/sh/configs/espt_defconfig b/arch/sh/configs/espt_defconfig
> index 623012d9af9d..67716a44463e 100644
> --- a/arch/sh/configs/espt_defconfig
> +++ b/arch/sh/configs/espt_defconfig
> @@ -61,7 +61,7 @@ CONFIG_USB_STORAGE=y
>   CONFIG_EXT2_FS=y
>   CONFIG_EXT3_FS=y
>   # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_PROC_KCORE=y
>   CONFIG_TMPFS=y
>   CONFIG_TMPFS_POSIX_ACL=y
> diff --git a/arch/sh/configs/sdk7780_defconfig b/arch/sh/configs/sdk7780_defconfig
> index 41cb588ca99c..cd24cf08210e 100644
> --- a/arch/sh/configs/sdk7780_defconfig
> +++ b/arch/sh/configs/sdk7780_defconfig
> @@ -105,7 +105,7 @@ CONFIG_EXT2_FS_POSIX_ACL=y
>   CONFIG_EXT3_FS=y
>   # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
>   CONFIG_EXT3_FS_POSIX_ACL=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_ISO9660_FS=y
>   CONFIG_MSDOS_FS=y
>   CONFIG_VFAT_FS=y
> diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
> index a080c5d05a7b..cf59b98446e4 100644
> --- a/arch/sh/configs/sdk7786_defconfig
> +++ b/arch/sh/configs/sdk7786_defconfig
> @@ -168,7 +168,7 @@ CONFIG_EXT3_FS=y
>   CONFIG_EXT4_FS=y
>   CONFIG_XFS_FS=y
>   CONFIG_BTRFS_FS=y
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_FUSE_FS=y
>   CONFIG_CUSE=m
>   CONFIG_FSCACHE=m
> diff --git a/arch/sh/configs/sh03_defconfig b/arch/sh/configs/sh03_defconfig
> index f661ef816f09..48f38ec236b6 100644
> --- a/arch/sh/configs/sh03_defconfig
> +++ b/arch/sh/configs/sh03_defconfig
> @@ -60,7 +60,7 @@ CONFIG_EXT2_FS_XATTR=y
>   CONFIG_EXT3_FS=y
>   # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
>   CONFIG_EXT3_FS_POSIX_ACL=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_ISO9660_FS=m
>   CONFIG_JOLIET=y
>   CONFIG_ZISOFS=y
> diff --git a/arch/sh/configs/sh7763rdp_defconfig b/arch/sh/configs/sh7763rdp_defconfig
> index ae726745d9a0..57923c3296cc 100644
> --- a/arch/sh/configs/sh7763rdp_defconfig
> +++ b/arch/sh/configs/sh7763rdp_defconfig
> @@ -63,7 +63,7 @@ CONFIG_MMC=y
>   CONFIG_EXT2_FS=y
>   CONFIG_EXT3_FS=y
>   # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_MSDOS_FS=y
>   CONFIG_VFAT_FS=y
>   CONFIG_PROC_KCORE=y
> diff --git a/arch/sparc/configs/sparc32_defconfig b/arch/sparc/configs/sparc32_defconfig
> index 7c489e7f19b7..5010164de3e4 100644
> --- a/arch/sparc/configs/sparc32_defconfig
> +++ b/arch/sparc/configs/sparc32_defconfig
> @@ -65,7 +65,7 @@ CONFIG_EXT2_FS=y
>   CONFIG_EXT2_FS_XATTR=y
>   CONFIG_EXT2_FS_POSIX_ACL=y
>   CONFIG_EXT2_FS_SECURITY=y
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_ISO9660_FS=m
>   CONFIG_PROC_KCORE=y
>   CONFIG_ROMFS_FS=m
> diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
> index 05ae535ba0dc..630be793759e 100644
> --- a/arch/um/configs/i386_defconfig
> +++ b/arch/um/configs/i386_defconfig
> @@ -62,7 +62,7 @@ CONFIG_UML_NET_SLIRP=y
>   CONFIG_EXT4_FS=y
>   CONFIG_REISERFS_FS=y
>   CONFIG_QUOTA=y
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_ISO9660_FS=m
>   CONFIG_JOLIET=y
>   CONFIG_PROC_KCORE=y
> diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
> index 1c757238be7f..8540d3370272 100644
> --- a/arch/um/configs/x86_64_defconfig
> +++ b/arch/um/configs/x86_64_defconfig
> @@ -60,7 +60,7 @@ CONFIG_UML_NET_SLIRP=y
>   CONFIG_EXT4_FS=y
>   CONFIG_REISERFS_FS=y
>   CONFIG_QUOTA=y
> -CONFIG_AUTOFS4_FS=m
> +CONFIG_AUTOFS_FS=m
>   CONFIG_ISO9660_FS=m
>   CONFIG_JOLIET=y
>   CONFIG_PROC_KCORE=y
> diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
> index 3cf34912abfe..75a343f10e58 100644
> --- a/arch/x86/configs/i386_defconfig
> +++ b/arch/x86/configs/i386_defconfig
> @@ -245,7 +245,7 @@ CONFIG_QUOTA=y
>   CONFIG_QUOTA_NETLINK_INTERFACE=y
>   # CONFIG_PRINT_QUOTA_WARNING is not set
>   CONFIG_QFMT_V2=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_ISO9660_FS=y
>   CONFIG_JOLIET=y
>   CONFIG_ZISOFS=y
> diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
> index 27759236fd60..0902518e9b93 100644
> --- a/arch/x86/configs/x86_64_defconfig
> +++ b/arch/x86/configs/x86_64_defconfig
> @@ -242,7 +242,7 @@ CONFIG_QUOTA=y
>   CONFIG_QUOTA_NETLINK_INTERFACE=y
>   # CONFIG_PRINT_QUOTA_WARNING is not set
>   CONFIG_QFMT_V2=y
> -CONFIG_AUTOFS4_FS=y
> +CONFIG_AUTOFS_FS=y
>   CONFIG_ISO9660_FS=y
>   CONFIG_JOLIET=y
>   CONFIG_ZISOFS=y
> --
> 2.40.1
>
