Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3CE7CBCEE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbjJQH5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjJQH5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:57:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D1593;
        Tue, 17 Oct 2023 00:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697529441; x=1729065441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/3dLxBeYCBYs7cbxjoQ3RwA50oR+l6rsJm/7QYEWI7M=;
  b=Mt1bMyZYZsqQa9n8WD2/qQVIvnLllYz4jcumV4veh0gMpr1gV4pvdlJ2
   8EudFTWVqe0PSReKSwrNfYtlxlZNY8hzHA3uSeL4qusg3frbrEOq7tH1P
   dBsrFrfgJCyeRh9iT74iMYPIC9Kn/PQ4YoNrw5BUElKEFmPXHjzFTGxsH
   NzCtmSoqmdJ9vG9z6DInmSJ6FplgVzdwNTTPrkkJ953gEvSzYF1TRUcX5
   KPR29ECRhRzvwWBgxjUtcBN9UZDVvb7IGBGQV9zt7Kz7c3wSWuE29DxE1
   aPdikyVOCJ6SwQo/mu8+D+wF55XQcx8AmP8sl+DC5arqL+a8Hpnzw+Oda
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="384602485"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="384602485"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 00:57:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="759701926"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="759701926"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 00:57:18 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id DA05111F89D;
        Tue, 17 Oct 2023 10:57:15 +0300 (EEST)
Date:   Tue, 17 Oct 2023 07:57:15 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Jai Luthra <j-luthra@ti.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] media: platform: cadence: select MIPI_DPHY dependency
Message-ID: <ZS4+WwbItuFeOIdD@kekkonen.localdomain>
References: <20231017-cdns_phy_config-v1-1-583243d1c187@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017-cdns_phy_config-v1-1-583243d1c187@ti.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jai,

Thanks for the patch.

On Tue, Oct 17, 2023 at 01:07:24PM +0530, Jai Luthra wrote:
> The driver uses MIPI DPHY helper routines from the PHY core. Make sure
> we select the relevant config for compilation.
> 
> Fixes: a91d06f46bf7 ("media: cadence: csi2rx: Configure DPHY using link freq")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310170258.UzSN4RUB-lkp@intel.com/
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>  drivers/media/platform/cadence/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/cadence/Kconfig b/drivers/media/platform/cadence/Kconfig
> index 480325d053de..317bd9e2e728 100644
> --- a/drivers/media/platform/cadence/Kconfig
> +++ b/drivers/media/platform/cadence/Kconfig
> @@ -8,6 +8,7 @@ config VIDEO_CADENCE_CSI2RX
>  	select MEDIA_CONTROLLER
>  	select VIDEO_V4L2_SUBDEV_API
>  	select V4L2_FWNODE
> +	select GENERIC_PHY_MIPI_DPHY

Selecting GENERIC_PHY_MIPI_DPHY isn't enough as it depends on GENERIC_PHY.
I'll add the missing select line while applying this.

>  	help
>  	  Support for the Cadence MIPI CSI2 Receiver controller.
>  
> 

-- 
Regards,

Sakari Ailus
