Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F2E78C811
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbjH2OyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbjH2Oxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:53:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505A5CD6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693320794; x=1724856794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DgeK/xRyG2IFrQpmGZedAYLJ2Bq3DZ7mg+pJ/J38asY=;
  b=hzpw/f8WUo5ot6WBHGWKVI6MUVAOQq5p7YrJr3zdGkLMI3F1RFf6aSLE
   Z8uaxD/3v4xj1JNVqvm1wi/uUsRwCL1GsMGQtAWWAX229ZgsLGA/KQvfz
   zRjBnY8wSh51o1V++kJx13qcO49Cgonte1tnp2pV8tNzpbvd3RIy/9tex
   VXGjZxNopOKTET9I9Ri+D6+QW4H9QrX/2hcz+Y7ml9knkh+f/OMVD3Z3a
   pPTXWIMFP8IOjJY0mxTNVfVkuQEeJk8AOp2ufZRJWrHcc2vEuQw1abqaF
   /IKlkNFlLtlk6Q5C7H7lhfnY7MnmUFlCbcqwpuF/CNP+I+uTeZSi+8Yk/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="439341587"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="439341587"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 07:53:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="768102031"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="768102031"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 29 Aug 2023 07:53:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qb05e-004uJY-1M;
        Tue, 29 Aug 2023 17:53:10 +0300
Date:   Tue, 29 Aug 2023 17:53:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: max77541: Simplify probe()
Message-ID: <ZO4GViBrAvAG5EPT@smile.fi.intel.com>
References: <20230828153805.78421-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828153805.78421-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 04:38:05PM +0100, Biju Das wrote:
> Simplify probe() by replacing device_get_match_data() and ID lookup for
> retrieving match data by i2c_get_match_data().

...

> While at it, drop leading commas from OF table.

Sure?

...

>  static const struct of_device_id max77541_of_id[] = {
> -	{
> -		.compatible = "adi,max77540",
> -		.data = (void *)MAX77540,
> -	},
> -	{
> -		.compatible = "adi,max77541",
> -		.data = (void *)MAX77541,
> -	},
> +	{ .compatible = "adi,max77540", .data = (void *)MAX77540 },
> +	{ .compatible = "adi,max77541", .data = (void *)MAX77541 },
>  	{ }
>  };

Seems to me an unneeded churn as nothing has been changed here
(except commas and indentation). If any, it should be a separate
change.

-- 
With Best Regards,
Andy Shevchenko


