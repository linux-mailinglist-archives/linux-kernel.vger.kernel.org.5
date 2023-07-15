Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAC5754982
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjGOOxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGOOxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:53:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08D13588;
        Sat, 15 Jul 2023 07:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689432777; x=1720968777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MHw2DQVFNfxjFwSF/4sgJHjNRr54XFl94hsUEflYaZs=;
  b=cTUZ7HUzCC+HW4sVgkI9HHI+/1f0twT4cFy7uOyDFc5WT5Em0IpKK8Uk
   GID8jSuIxqPA5WWwt2kNrP2P2MIUpOU4Hzcj5rK8P+gEfRwLLgaGXKbhv
   vP02GYV2LydMv16iWDbvpks45SNTFj202dOa4yv32gnzpW4+Fnxu2jgIa
   uatg1dQKiWbvEkqa283kz9QKUlgwsa53c+t/Zh8K4c2JAdvo1nr8o1MWf
   L295gBqeeV6+IPF9fmLCe5x/HVZPLMa89OCStnVztxXDy0wHdXSoPgWYV
   0o//JwunormFTKoRZT/uSFth02CfaW8JsExwQ4CE5k02ETldCLJwhjAQ1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="452037217"
X-IronPort-AV: E=Sophos;i="6.01,208,1684825200"; 
   d="scan'208";a="452037217"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2023 07:52:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="726018439"
X-IronPort-AV: E=Sophos;i="6.01,208,1684825200"; 
   d="scan'208";a="726018439"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jul 2023 07:52:55 -0700
Date:   Sat, 15 Jul 2023 22:51:21 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] fpga: socfpga-a10: Convert to
 devm_platform_ioremap_resource()
Message-ID: <ZLKyaY9mOZ6/XaR4@yilunxu-OptiPlex-7050>
References: <20230710133830.65631-1-frank.li@vivo.com>
 <20230710133830.65631-2-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710133830.65631-2-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-10 at 21:38:29 +0800, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied.

> ---
>  drivers/fpga/socfpga-a10.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
> index ac8e89b8a5cc..cc4861e345c9 100644
> --- a/drivers/fpga/socfpga-a10.c
> +++ b/drivers/fpga/socfpga-a10.c
> @@ -471,7 +471,6 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
>  	struct a10_fpga_priv *priv;
>  	void __iomem *reg_base;
>  	struct fpga_manager *mgr;
> -	struct resource *res;
>  	int ret;
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> @@ -479,14 +478,12 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	/* First mmio base is for register access */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	reg_base = devm_ioremap_resource(dev, res);
> +	reg_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(reg_base))
>  		return PTR_ERR(reg_base);
>  
>  	/* Second mmio base is for writing FPGA image data */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	priv->fpga_data_addr = devm_ioremap_resource(dev, res);
> +	priv->fpga_data_addr = devm_platform_ioremap_resource(pdev, 1);
>  	if (IS_ERR(priv->fpga_data_addr))
>  		return PTR_ERR(priv->fpga_data_addr);
>  
> -- 
> 2.39.0
> 
