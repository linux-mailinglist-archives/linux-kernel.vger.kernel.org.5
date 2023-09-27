Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BAB7B0243
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjI0K5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI0K5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:57:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B241F3;
        Wed, 27 Sep 2023 03:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695812270; x=1727348270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jb2Av0IYJPI3zJ+2i+bD1UoqIPdVABtXYLj8arBzUFQ=;
  b=Lzv3kiiibWmn7an5AUXE7zZt53CMXZukzjRTKZ052/vXGIwD9JiEYm+p
   rcuIbLM2Kjve75kb7ZUPnloA+e24KZeISWMYuTwpKqkKe/Qfq7OxDLUhV
   KnWFL8o5zRZwQba8w2pQWcFMzNlDIGS3eoyMKQ90Cr4XoRK6Qg5bnxue6
   KUikyHyJSkfy/a+xaQc//j102wNQulYcC9MH+ilyuikvto7/tXsbgmIDi
   mwC/PI9FBlKtQ4ihTtDhHd1lUlBBDIqm2so32ay+aXpMVwiV0EN9PbfA6
   VT74sl0fxMLz81ORVfFYeoU9jD8YVr+Ci+5ENBm2FbwbZL0Di+OUcagnU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="445930007"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="445930007"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 03:57:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="749161810"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="749161810"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 03:57:47 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 00EDC11F94F;
        Wed, 27 Sep 2023 13:48:28 +0300 (EEST)
Date:   Wed, 27 Sep 2023 10:48:28 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] media: sunxi: a83-mips-csi2: also select GENERIC_PHY
Message-ID: <ZRQIfC67fDmOUBNY@kekkonen.localdomain>
References: <20230927040438.5589-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927040438.5589-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Thanks for the patch.

On Tue, Sep 26, 2023 at 09:04:38PM -0700, Randy Dunlap wrote:
> When selecting GENERIC_PHY_MIPI_DPHY, also select GENERIC_PHY to
> prevent kconfig warnings:
> 
> WARNING: unmet direct dependencies detected for GENERIC_PHY_MIPI_DPHY
>   Depends on [n]: GENERIC_PHY [=n]
>   Selected by [y]:
>   - VIDEO_SUN8I_A83T_MIPI_CSI2 [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && VIDEO_DEV [=y] && (ARCH_SUNXI || COMPILE_TEST [=y]) && PM [=y] && COMMON_CLK [=y] && RESET_CONTROLLER [=y]
> 
> Fixes: 94d7fd9692b5 ("media: sunxi: Depend on GENERIC_PHY_MIPI_DPHY")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: lore.kernel.org/r/ZQ/WS8HC1A3F0Qn8@rli9-mobl
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-sunxi@lists.linux.dev
> ---
>  drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -- a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig
> --- a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig
> +++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig
> @@ -8,6 +8,7 @@ config VIDEO_SUN8I_A83T_MIPI_CSI2
>  	select VIDEO_V4L2_SUBDEV_API
>  	select V4L2_FWNODE
>  	select REGMAP_MMIO
> +	select GENERIC_PHY

Could GENERIC_PHY_MIPI_DPHY select GENERIC_PHY instead of depending it?

There seem to be a few other drivers that appear to have the same issue.

>  	select GENERIC_PHY_MIPI_DPHY
>  	help
>  	   Support for the Allwinner A83T MIPI CSI-2 controller and D-PHY.

-- 
Regards,

Sakari Ailus
