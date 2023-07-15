Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD70E75497F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjGOOwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGOOw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:52:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5889A2715;
        Sat, 15 Jul 2023 07:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689432748; x=1720968748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d6WEpFZuPlPo7XMEqofr+HqNzzQ2DFei4agOjq1eyUg=;
  b=AylkoyvrE0umCJ9X+8JuMU4O7ILA9z5ofFdlhA5KcdiXOL3TgVppCBEH
   rNZp4BJ7/IN9WV+IYQVqOd7QQtixhmUdnizrFJhGPJt85WR8Rvelbxf+S
   a7WK60CJNC2vVV7/kH2vVayk4iRno9pEFxYu3Q9qL0bc0XcACrdqA4Ymy
   55P0X/RUiRW+WkF6cKy4piRzdMzWdtQN/eMSwceL7FtLkwMIayEs6zuEG
   u2+3x/54+OSwEs0y1n96Nk2bi6OBqNwL/U0tu2L7OsB/4OuIac5Uh0W7o
   AFSVLJENHqjwTpkYrvr62+FwY24VZMIesl/lGGu7YelPtbPDkiKhA9FVY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="355600673"
X-IronPort-AV: E=Sophos;i="6.01,208,1684825200"; 
   d="scan'208";a="355600673"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2023 07:52:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="722713529"
X-IronPort-AV: E=Sophos;i="6.01,208,1684825200"; 
   d="scan'208";a="722713529"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga002.jf.intel.com with ESMTP; 15 Jul 2023 07:52:26 -0700
Date:   Sat, 15 Jul 2023 22:50:51 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fpga: fpga-mgr: altera-pr-ip: Convert to
 devm_platform_ioremap_resource()
Message-ID: <ZLKyS3CAtdgl+Oyu@yilunxu-OptiPlex-7050>
References: <20230710133830.65631-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710133830.65631-1-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-10 at 21:38:28 +0800, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied.

> ---
> v2:
> -keep comment
>  drivers/fpga/altera-pr-ip-core-plat.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/fpga/altera-pr-ip-core-plat.c b/drivers/fpga/altera-pr-ip-core-plat.c
> index b008a6b8d2d3..06c6a4721205 100644
> --- a/drivers/fpga/altera-pr-ip-core-plat.c
> +++ b/drivers/fpga/altera-pr-ip-core-plat.c
> @@ -15,13 +15,9 @@ static int alt_pr_platform_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	void __iomem *reg_base;
> -	struct resource *res;
>  
>  	/* First mmio base is for register access */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -
> -	reg_base = devm_ioremap_resource(dev, res);
> -
> +	reg_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(reg_base))
>  		return PTR_ERR(reg_base);
>  
> -- 
> 2.39.0
> 
