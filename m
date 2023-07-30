Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6FC768378
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 04:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjG3CRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 22:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG3CRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 22:17:49 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885B826BF;
        Sat, 29 Jul 2023 19:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690683468; x=1722219468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4wDGaGKo6PLfCUabc1B5tsUUYI3cEeGdCdYqo2+gK4U=;
  b=cIn2TF5Ylu98/Dd1/v7GvIrh3kCuEum/ZzFLnY87uM+n/VkYXmzDZ4sx
   1WTXtEpDHCZXxN3f9+lnUpkWOogdYqPZCCbCmyw8OyKKu70ryjzNb/vXF
   rTDAeiQKfGCO2H0zIYIQGy8vWF8inm9zlHdEwA4GRNHge3YD/tJP6N19h
   D4mcW+eW12NR6UdOTJybR25sBPCKSmbX8euy9GHsU8CZyia0WjEKlHzrR
   vKk2NuYmdwIq0buvbUIvoDpJYGwldhaLhrLShKT4/BwwtLVBpKfXyKtPx
   +CQcOlSvEyr2ORnYMKnqsEdhZOeTbVN9nQ5sELo460cQyDhscxR6AqfJd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="371506912"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="371506912"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 19:17:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="871227345"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.203.2])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 19:17:43 -0700
Date:   Sat, 29 Jul 2023 19:17:40 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Raghu Halharvi <raghuhack78@gmail.com>
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com,
        bwidawsk@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, linux-kernel@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v7 1/2] cxl/mbox: Remove redundant dev_err() after failed
 mem alloc
Message-ID: <ZMXIRBPwrocRBD74@aschofie-mobl2>
References: <20230726073421.2452-1-raghuhack78@gmail.com>
 <20230726073421.2452-2-raghuhack78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726073421.2452-2-raghuhack78@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 07:34:20AM +0000, Raghu Halharvi wrote:
> Issue found with checkpatch
> 
> A return of errno should be good enough if the memory allocation fails,
> the error message here is redundant as per the coding style, removing
> it.
> 
> Signed-off-by: Raghu Halharvi <raghuhack78@gmail.com>
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Thanks for follow-up Raghu!

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> ---
>  drivers/cxl/core/mbox.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d6d067fbee97..af7f37cea871 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1325,10 +1325,8 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  	struct cxl_memdev_state *mds;
>  
>  	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
> -	if (!mds) {
> -		dev_err(dev, "No memory available\n");
> +	if (!mds)
>  		return ERR_PTR(-ENOMEM);
> -	}
>  
>  	mutex_init(&mds->mbox_mutex);
>  	mutex_init(&mds->event.log_lock);
> -- 
> 2.39.2
> 
