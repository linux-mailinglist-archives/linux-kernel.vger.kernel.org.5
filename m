Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB3C7BC5EA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343723AbjJGH61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343737AbjJGH6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:58:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21248C5;
        Sat,  7 Oct 2023 00:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696665504; x=1728201504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CbjHvxyXudfS+jzLFMB4pf2hIr3LIVRFnB5F1KEY7V8=;
  b=c/McKJYj9dqjBP4/ItBIyHjLtUKYL6O8U+1FwzhdLaJJeNe4kibUmaBz
   6RD2bhLKbQvLzi08inBhaIl4gdbXPKjlgPU5VQ3kqu1OoAebVZHXr0/bh
   7+2s8l5l5htn0Jd5QpLu/tDSVjnQyE7e5nJs4dDq8/kf9otZisehpoXV8
   wHQsf8eBSLmuEUJEJPUuP7p7Tr/WTHgupgrFmZb7+LW8C5Gs3DZ55J26Z
   m6di6+obfHdfCDdzFR0oFEqLl3bakDWUD/Oo4V1kEPRz9BzMgBtbqzQ1U
   SzdK7uCt8UYFI3yIyF9ABqNzaJJLVLN+6/xOQ7EFbhEjQFkcz8npaXZY/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="374239922"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="374239922"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 00:58:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="926217413"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="926217413"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga005.jf.intel.com with ESMTP; 07 Oct 2023 00:58:21 -0700
Date:   Sat, 7 Oct 2023 15:57:31 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@amd.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] fpga: Use device_get_match_data()
Message-ID: <ZSEPa6JRAz4xH4mc@yilunxu-OptiPlex-7050>
References: <20231006224633.445035-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006224633.445035-1-robh@kernel.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 05:46:33PM -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied.

> ---
>  drivers/fpga/altera-hps2fpga.c     | 12 +++---------
>  drivers/fpga/xilinx-pr-decoupler.c | 15 ++++-----------
>  2 files changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
> index aa758426c22b..578663503297 100644
> --- a/drivers/fpga/altera-hps2fpga.c
> +++ b/drivers/fpga/altera-hps2fpga.c
> @@ -24,7 +24,8 @@
>  #include <linux/kernel.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> -#include <linux/of_platform.h>
> +#include <linux/of.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
>  #include <linux/spinlock.h>
> @@ -127,18 +128,11 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct altera_hps2fpga_data *priv;
> -	const struct of_device_id *of_id;
>  	struct fpga_bridge *br;
>  	u32 enable;
>  	int ret;
>  
> -	of_id = of_match_device(altera_fpga_of_match, dev);
> -	if (!of_id) {
> -		dev_err(dev, "failed to match device\n");
> -		return -ENODEV;
> -	}
> -
> -	priv = (struct altera_hps2fpga_data *)of_id->data;
> +	priv = (struct altera_hps2fpga_data *)device_get_match_data(dev);
>  
>  	priv->bridge_reset = of_reset_control_get_exclusive_by_index(dev->of_node,
>  								     0);
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> index 208d9560f56d..0c012d0f616d 100644
> --- a/drivers/fpga/xilinx-pr-decoupler.c
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -10,8 +10,10 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> -#include <linux/of_device.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/fpga/fpga-bridge.h>
>  
>  #define CTRL_CMD_DECOUPLE	BIT(0)
> @@ -81,7 +83,6 @@ static const struct fpga_bridge_ops xlnx_pr_decoupler_br_ops = {
>  	.enable_show = xlnx_pr_decoupler_enable_show,
>  };
>  
> -#ifdef CONFIG_OF
>  static const struct xlnx_config_data decoupler_config = {
>  	.name = "Xilinx PR Decoupler",
>  };
> @@ -100,11 +101,9 @@ static const struct of_device_id xlnx_pr_decoupler_of_match[] = {
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, xlnx_pr_decoupler_of_match);
> -#endif
>  
>  static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>  {
> -	struct device_node *np = pdev->dev.of_node;
>  	struct xlnx_pr_decoupler_data *priv;
>  	struct fpga_bridge *br;
>  	int err;
> @@ -113,13 +112,7 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	if (np) {
> -		const struct of_device_id *match;
> -
> -		match = of_match_node(xlnx_pr_decoupler_of_match, np);
> -		if (match && match->data)
> -			priv->ipconfig = match->data;
> -	}
> +	priv->ipconfig = device_get_match_data(&pdev->dev);
>  
>  	priv->io_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(priv->io_base))
> -- 
> 2.40.1
> 
