Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3717B020F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjI0Klu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjI0Klr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:41:47 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Sep 2023 03:41:46 PDT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C5A139;
        Wed, 27 Sep 2023 03:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695811306; x=1727347306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FJ0IYu3pUocOEwzdSIbSElmwbN5DTKpi1QShGYs7pSo=;
  b=dwflQPAtVpZpv5CcCV5FDNgTTY0OJclwhgh0DvW6F1QA6zyw7vQvyi5w
   aE5zGBr8f3LrAvz5HGoOnSIAOrDFUEQjBQCJ6xLpDzYCgcZxfey3kIPxj
   9QkAnLHKLO+vp/ac7vLvJ342a2b+pWNFgzQR/uHUSj+UIsvogOK29r6fs
   fdCpj3M1jz63Sn93q6s32M4yaUty8PIw5/me5o1wUv6x6GdZVqUaDvMvS
   JF0ZX/Dnc+4O8OkFje3s1xyaFSdl+ZWsf7UL5XWl4GQBZaNRC3M6KZl5I
   Ygsn7XoMG8DuQ+Syb9c5XdZzk002KKXKyw4w8E1nnPgoSRbGYLDBT8S7v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="390852"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="390852"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 03:40:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="864783523"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="864783523"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 03:40:42 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id F3C0211F94F;
        Wed, 27 Sep 2023 13:40:38 +0300 (EEST)
Date:   Wed, 27 Sep 2023 10:40:38 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Wentong Wu <wentong.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: pci: intel: ivsc: select V4L2_FWNODE
Message-ID: <ZRQGpg/jX25Wgm8z@kekkonen.localdomain>
References: <20230927072127.2529885-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927072127.2529885-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Sep 27, 2023 at 09:21:19AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Some missing select statements were already added back, but I ran into
> another one that is missing:
> 
> ERROR: modpost: "v4l2_fwnode_endpoint_free" [drivers/media/pci/intel/ivsc/ivsc-csi.ko] undefined!
> ERROR: modpost: "v4l2_fwnode_endpoint_alloc_parse" [drivers/media/pci/intel/ivsc/ivsc-csi.ko] undefined!
> ERROR: modpost: "v4l2_fwnode_endpoint_parse" [drivers/media/pci/intel/ivsc/ivsc-csi.ko] undefined!
> 
> Fixes: 29006e196a566 ("media: pci: intel: ivsc: Add CSI submodule")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/media/pci/intel/ivsc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/pci/intel/ivsc/Kconfig b/drivers/media/pci/intel/ivsc/Kconfig
> index 0acea4678fc0d..6a2995b02d274 100644
> --- a/drivers/media/pci/intel/ivsc/Kconfig
> +++ b/drivers/media/pci/intel/ivsc/Kconfig
> @@ -7,6 +7,7 @@ config INTEL_VSC
>  	select MEDIA_CONTROLLER
>  	select VIDEO_V4L2_SUBDEV_API
>  	select V4L2_ASYNC
> +	select V4L2_FWNODE

Thanks for the fix.

V4L2_FWNODE already implies V4L2_ASYNC so V4L2_ASYNC can be removed. I
somehow thought this only needed V4L2_ASYNC but that indeed is not the
case.

I'll just drop the line selecting V4L2_ASYNC above if that's fine.

>  	help
>  	  This adds support for Intel Visual Sensing Controller (IVSC).
>  

-- 
Regards,

Sakari Ailus
