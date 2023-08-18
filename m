Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F879780EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377984AbjHRPKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378016AbjHRPKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:10:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E683A99;
        Fri, 18 Aug 2023 08:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692371413; x=1723907413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q/jZ37qbijWW62BdQY9/xP7Bfe8jDPnF+3L2ur66xwc=;
  b=Q0kW1HpydSnEV7HMXHa/HQB+X8tvDiP6ys5SvZ8XFU3q99d94fI77agl
   P8P0rMaOZ5ebSRYA7K3z0TTrgu7r8usIHeOH+ZwlBsqmOdZqexE6/qO3C
   0DwYtyxLraH/RgRaaHzTXuVBT91ORHOdyaFGyeGSDaAySaIX0ylvN7Ab4
   pR3Sip1gfXddwD6tGsJWQ4FMU+UPM10G7U/QrDT1JMuUVhLbnVWCRmlVU
   mjppLIF6/2QTlP5J95eX9p7lZSobdKPUE/4p6r+k4Kr1iRspc94t91XV/
   YlF4jpoaqTuqhcuRABROaYPK4wNadtzC3LjFqqovx+2Sg/te0gptObuaD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="437030699"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="437030699"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 08:10:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="908913322"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="908913322"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 18 Aug 2023 08:10:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qX16z-00DFbG-28;
        Fri, 18 Aug 2023 18:10:05 +0300
Date:   Fri, 18 Aug 2023 18:10:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kartik <kkartik@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, sumitg@nvidia.com,
        arnd@arndb.de, pshete@nvidia.co, digetx@gmail.com,
        petlozup@nvidia.com, windhl@126.com, frank.li@vivo.com,
        robh@kernel.org, stefank@nvidia.com, pdeschrijver@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] soc/tegra: fuse: Add support for Tegra241
Message-ID: <ZN+Jzbsci3RLtEnW@smile.fi.intel.com>
References: <20230818093028.7807-1-kkartik@nvidia.com>
 <20230818093028.7807-7-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818093028.7807-7-kkartik@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 03:00:28PM +0530, Kartik wrote:
> Add support for Tegra241 which use ACPI boot.

...

>  	case TEGRA234:
>  		fuse->soc = &tegra234_fuse_soc;
>  		break;
> +#endif
> +#if defined(CONFIG_ARCH_TEGRA_241_SOC)
> +	case TEGRA241:
> +		fuse->soc = &tegra241_fuse_soc;
> +		break;
>  #endif

Have you tried --patience when formatting patches?
Does it help them to look better?

...

> +const struct tegra_fuse_soc tegra241_fuse_soc = {
> +	.init = tegra30_fuse_init,
> +	.info = &tegra241_fuse_info,

> +	.lookups = NULL,
> +	.num_lookups = 0,
> +	.cells = NULL,
> +	.num_cells = 0,

Isn't it the default?

> +	.keepouts = tegra241_fuse_keepouts,
> +	.num_keepouts = ARRAY_SIZE(tegra241_fuse_keepouts),
> +	.soc_attr_group = &tegra194_soc_attr_group,

> +	.clk_suspend_on = false,

Ditto.

> +};

-- 
With Best Regards,
Andy Shevchenko


