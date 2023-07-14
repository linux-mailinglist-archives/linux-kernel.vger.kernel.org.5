Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E267534C3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbjGNIKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbjGNIKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:10:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2350B359B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689322080; x=1720858080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CgZXYqhZ35zPyxRRZNLQUNIhUn27suwkGUDknpm9M4E=;
  b=e2NVZZhDzRITzbJbWircw5WtTxFxOiETtW3V8P170dZsNm/sASK3AxB7
   XwGpzlxZ1U5aGhTV3m/5eU730M5/L0CzrBVqYeYagFSGaU1fqFdFLtUO9
   7AeqeKvvBSBBuMNdxGgo5WO8NHV/1jCjOUfuxVI98bMg0MtD4h9UEm2xW
   +i/iyN32kcAmZGAQ2ziYqCl05PKZH+QeP2Uk04E+3VVIOSXM2c4SIqDDv
   QlD+MfrXdi1laz4TOcSZ9AOdkjRNIYPdgtRPobc2JYvG/H4M8UR78bgUo
   gov+Vnf8RYOxYOYBI3mml3zrpDjvLYmDzrDat/CyNh++jZm/HBWOmN1dJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="431590678"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="431590678"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 01:07:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="896328208"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="896328208"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 14 Jul 2023 01:07:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qKDpn-002bDV-1M;
        Fri, 14 Jul 2023 11:07:27 +0300
Date:   Fri, 14 Jul 2023 11:07:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, ira.weiny@intel.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel: =?utf-8?Q?resource?=
 =?utf-8?B?OiBSZW1vdmUgdW5uZWNlc3Nhcnkg4oCYMOKAmQ==?= values from err
Message-ID: <ZLECP7KmESS1pkha@smile.fi.intel.com>
References: <20230715182428.3348-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230715182428.3348-1-kunyu@nfschina.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 02:24:28AM +0800, Li kunyu wrote:
> err is assigned first, so it does not need to initialize the assignment.
> Modify __find_resource execution syntax to make it more in line with
> commonly used styles.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  v2:
>    Modify __find_resource Execution Syntax.
> 
>  kernel/resource.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index b1763b2fd7ef..ee79e8f4f422 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -656,13 +656,14 @@ static int reallocate_resource(struct resource *root, struct resource *old,
>  			       resource_size_t newsize,
>  			       struct resource_constraint *constraint)
>  {
> -	int err=0;
> +	int err;
>  	struct resource new = *old;
>  	struct resource *conflict;
>  
>  	write_lock(&resource_lock);
>  
> -	if ((err = __find_resource(root, old, &new, newsize, constraint)))
> +	err = __find_resource(root, old, &new, newsize, constraint);
> +	if (err)
>  		goto out;
>  
>  	if (resource_contains(&new, old)) {
> -- 
> 2.18.2
> 

-- 
With Best Regards,
Andy Shevchenko


