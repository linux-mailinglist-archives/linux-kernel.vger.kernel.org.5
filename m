Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C3D7F26B1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjKUHwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjKUHwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:52:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D487B113;
        Mon, 20 Nov 2023 23:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700553154; x=1732089154;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Fhu8H8MWgkHD8YqbKOkQKpOG48GvYpoMt/tgalXYiz4=;
  b=kYOHT+nbmAEeJEGMXlV4T+scDfc57H/TER1eajLAG4TYXhNLwkR98agd
   9MOCOzouD0R+1Tt/7eUEOHdknpWsLgpywl4tnk77+KKZ4lVEKFS9SGpA5
   al3kxMY3K2YUV4R9AY0EXw8eBZ3trSX/f0JqEM/1q++Ji1gnBuvY4/IE0
   ayCHXeD20WkhX26LXGAH5LeuI7Ipb1hhEgAsyTfi3MBX5knlIml6iY8Mj
   wSqvYjC2S2zVI3HQlYNemnJ4mEXxbi13CLDJKRreIusTtMRFL+UEPGeub
   bv90oh/GHj6TajS1wJbtjrb1U4cuJofymKfHMWGDN3jeNL0zG6wDnFQWo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="390641676"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="390641676"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 23:52:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="857258927"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="857258927"
Received: from sbouradx-mobl.ger.corp.intel.com ([10.252.58.80])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 23:52:30 -0800
Date:   Tue, 21 Nov 2023 09:52:19 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     David Thompson <davthompson@nvidia.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        vadimp@nvidia.com, platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kblaiech@nvidia.com
Subject: Re: [PATCH v1] mlxbf-bootctl: check the secure boot development mode
 status bit
In-Reply-To: <20231120201109.3435-1-davthompson@nvidia.com>
Message-ID: <e9c18d37-235c-a16-64e1-8a8e8a38d5e@linux.intel.com>
References: <20231120201109.3435-1-davthompson@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023, David Thompson wrote:

> If the secure boot is enabled with the development key, then print
> it to the output buffer when lifecycle_state_show() is invoked.
> 
> Fixes: 79e29cb8fbc5c ("platform/mellanox: Add bootctl driver for Mellanox BlueField Soc")

The commit message says nothing that warrants a Fixes tag.

Also, the commit message doesn't tell why you need to do this, that is, it 
doesn't tell what's the current situation and how it's wrong/unwanted. 
Please amend.

> Reviewed-by: Khalil Blaiech <kblaiech@nvidia.com>
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> ---
>  drivers/platform/mellanox/mlxbf-bootctl.c | 24 +++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
> index 1ac7dab22c63..ed22908d79b9 100644
> --- a/drivers/platform/mellanox/mlxbf-bootctl.c
> +++ b/drivers/platform/mellanox/mlxbf-bootctl.c
> @@ -20,6 +20,7 @@
>  
>  #define MLXBF_BOOTCTL_SB_SECURE_MASK		0x03
>  #define MLXBF_BOOTCTL_SB_TEST_MASK		0x0c
> +#define MLXBF_BOOTCTL_SB_DEV_MASK		0x10

BIT(4)

(Those other too could be converted to GENMASK() but not in this patch.)

>  #define MLXBF_SB_KEY_NUM			4
>  
> @@ -40,11 +41,18 @@ static struct mlxbf_bootctl_name boot_names[] = {
>  	{ MLXBF_BOOTCTL_NONE, "none" },
>  };
>  
> +enum {
> +	MLXBF_BOOTCTL_SB_LIFECYCLE_PRODUCTION = 0,
> +	MLXBF_BOOTCTL_SB_LIFECYCLE_GA_SECURE = 1,
> +	MLXBF_BOOTCTL_SB_LIFECYCLE_GA_NON_SECURE = 2,
> +	MLXBF_BOOTCTL_SB_LIFECYCLE_RMA = 3
> +};
> +
>  static const char * const mlxbf_bootctl_lifecycle_states[] = {
> -	[0] = "Production",
> -	[1] = "GA Secured",
> -	[2] = "GA Non-Secured",
> -	[3] = "RMA",
> +	[MLXBF_BOOTCTL_SB_LIFECYCLE_PRODUCTION] = "Production",
> +	[MLXBF_BOOTCTL_SB_LIFECYCLE_GA_SECURE] = "GA Secured",
> +	[MLXBF_BOOTCTL_SB_LIFECYCLE_GA_NON_SECURE] = "GA Non-Secured",
> +	[MLXBF_BOOTCTL_SB_LIFECYCLE_RMA] = "RMA",
>  };
>  
>  /* Log header format. */
> @@ -254,8 +262,9 @@ static ssize_t lifecycle_state_show(struct device *dev,
>  	if (lc_state < 0)
>  		return lc_state;
>  
> -	lc_state &=
> -		MLXBF_BOOTCTL_SB_TEST_MASK | MLXBF_BOOTCTL_SB_SECURE_MASK;
> +	lc_state &= (MLXBF_BOOTCTL_SB_TEST_MASK |
> +		     MLXBF_BOOTCTL_SB_SECURE_MASK |
> +		     MLXBF_BOOTCTL_SB_DEV_MASK);
>  
>  	/*
>  	 * If the test bits are set, we specify that the current state may be
> @@ -266,6 +275,9 @@ static ssize_t lifecycle_state_show(struct device *dev,
>  
>  		return sprintf(buf, "%s(test)\n",
>  			       mlxbf_bootctl_lifecycle_states[lc_state]);
> +	} else if ((lc_state & MLXBF_BOOTCTL_SB_SECURE_MASK) == MLXBF_BOOTCTL_SB_LIFECYCLE_GA_SECURE
> +		   && (lc_state & MLXBF_BOOTCTL_SB_DEV_MASK)) {

I cannot review this line until you amend the commit message with the 
above mentioned details. To be more precise, I'm interested in 
understanding if you've precedences right here so your commit message 
should have enough details to support me in that decision, thank you.

> +		return sprintf(buf, "Secured (development)\n");
>  	}
>  
>  	return sprintf(buf, "%s\n", mlxbf_bootctl_lifecycle_states[lc_state]);
> 

-- 
 i.

