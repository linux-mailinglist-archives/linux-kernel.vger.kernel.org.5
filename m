Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D638C768379
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 04:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjG3CS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 22:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjG3CSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 22:18:54 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2572D47;
        Sat, 29 Jul 2023 19:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690683534; x=1722219534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EQW1AUMVIHfkGxuTUZ5EIEjw4SLFZTzHQ6Y4u2cWtno=;
  b=f5X6nfEMXWBYMfRLK3zOH6CZ9RI8HUJhcHizmtXCOm2I/G2R7NrC1sex
   M4UZJ6do/7EmxE319kYMF4n7VK5R3Izt+RTAr1C8US+EibhOecWRVWycF
   wrZ6AB2s58hnCxwg8XX2a04HmASOThy2GAa6SSeWYRVqGNl2kNKIbZuWp
   XXfBjtNwDsPYkhw3Rp7rYPfVj2zUlmJqib65+z1Tip7wifHhWCKQgxXiz
   fJC/6E3pUYyeF8ASwLpXyZqmIBZCLncCljG9wRpKOr+9eei7gWDGbYwj1
   Pv4PYZQZVd2YSIahpDiGNR0UcAq+CLG/atZXu+267CoecK9OIcwOj89lQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="399752508"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="399752508"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 19:18:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="974492429"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="974492429"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.203.2])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 19:18:53 -0700
Date:   Sat, 29 Jul 2023 19:18:51 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Raghu Halharvi <raghuhack78@gmail.com>
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com,
        bwidawsk@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, linux-kernel@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v7 2/2] cxl/region: Remove else after return statement
Message-ID: <ZMXIi+HC3uFQyvGK@aschofie-mobl2>
References: <20230726073421.2452-1-raghuhack78@gmail.com>
 <20230726073421.2452-3-raghuhack78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726073421.2452-3-raghuhack78@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 07:34:21AM +0000, Raghu Halharvi wrote:
> Issue found with checkpatch
> 
> The else section here is redundant after return statement, removing it.
> Sanity and correctness is not affected due to this fix.
> 
> Signed-off-by: Raghu Halharvi <raghuhack78@gmail.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>



> ---
>  drivers/cxl/core/region.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e115ba382e04..bfd3b13dd2c1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -133,11 +133,11 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
>  				&cxlr->dev,
>  				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
>  			return 0;
> -		} else {
> -			dev_err(&cxlr->dev,
> -				"Failed to synchronize CPU cache state\n");
> -			return -ENXIO;
>  		}
> +
> +		dev_err(&cxlr->dev,
> +			"Failed to synchronize CPU cache state\n");
> +		return -ENXIO;
>  	}
>  
>  	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> -- 
> 2.39.2
> 
