Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536B67D96B5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjJ0LdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjJ0LdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:33:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA3F1AC;
        Fri, 27 Oct 2023 04:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698406385; x=1729942385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dRYmGR3I5MgS4CYaxSz229MI2vtrH0ER7fq+BA+NuSw=;
  b=IRq+7+iuLpp+aOuNLs8AoySMCizgMlrwWTnLCfAp4d4ZSi0sfsxrd6/q
   iGJ3Rt1jtyBJt1TCEt/b/3fHWttX7pt+gCkHoWoCPF+BF5FmsW4d4KpWq
   kffNMXUd5l3VOKNt2zoiv9774lNm3zSgIBdgqHsNbhee9+A8jlygMW77O
   ipGGDspjxvimZ5kPTy1GeqPdZ8uP9tNwoTkbqKPG73Zol8oF5KBQP4KuV
   0tD+pLM/Vf7fRXKS0UbtXGgxE3YadFpF1JOccUh1fd2ff30HBwPCcQbxP
   9mQzEVr//INsQMr9Rb4F8iG163Swz/t4neLZxrhOravlIf3g5xnfnBRGl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="9297396"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="9297396"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:33:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="825314891"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="825314891"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:33:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qwL1o-0000000988M-2LVq;
        Fri, 27 Oct 2023 14:29:24 +0300
Date:   Fri, 27 Oct 2023 14:29:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linhua Xu <Linhua.xu@unisoc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        lh xu <xulh0829@gmail.com>,
        Zhirong Qiu <zhirong.qiu@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH V3 1/6] pinctrl: sprd: Modify pull-up parameters
Message-ID: <ZTufFGSJM+041nO6@smile.fi.intel.com>
References: <20231027071426.17724-1-Linhua.xu@unisoc.com>
 <20231027071426.17724-2-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027071426.17724-2-Linhua.xu@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 03:14:21PM +0800, Linhua Xu wrote:
> From: Linhua Xu <Linhua.Xu@unisoc.com>
> 
> For UNISOC pin controller, there are three different configurations of
> pull-up drive current. Modify the 20K pull-up resistor configuration and
> add the 1.8K pull-up resistor configuration.

> Fixes:<1fb4b907e808> ("pinctrl: sprd: Add Spreadtrum pin control driver")
> 
> Signed-off-by: Linhua Xu <Linhua.Xu@unisoc.com>

I guess I already pointed out that there must not be blank lines in the tag
block, besides that read "Submitting Patches" document to see how properly
format the Fixes: tag.

...

> -#define PULL_UP_4_7K			(BIT(12) | BIT(7))
> +#define PULL_UP_1_8K			(BIT(12) | BIT(7))
> +#define PULL_UP_4_7K			BIT(12)
>  #define PULL_UP_20K			BIT(7)

>  #define PULL_UP_MASK			0x21
>  #define PULL_UP_SHIFT			7

Basically these two repeat the above 1.8K case.
But I see that you try to take care in the next patch about them.
Still, the better is to use those _MASKs and _SHIFTs in the code.
See below.

...

>  			if ((reg & (SLEEP_PULL_DOWN | SLEEP_PULL_UP)) ||
> -			    (reg & (PULL_DOWN | PULL_UP_4_7K | PULL_UP_20K)))
> +			    (reg & (PULL_DOWN | PULL_UP_4_7K | PULL_UP_20K | PULL_UP_1_8K)))

			if ((reg & (SLEEP_PULL_DOWN | SLEEP_PULL_UP)) ||
			    (reg & (PULL_DOWN | (PULL_UP_MASK << PULL_UP_SHIFT))))

>  				return -EINVAL;

...

>  					mask = PULL_DOWN | PULL_UP_20K |
> -						PULL_UP_4_7K;
> +						PULL_UP_4_7K | PULL_UP_1_8K;

					mask = PULL_DOWN | (PULL_UP_MASK << PULL_UP_SHIFT);

Ditto.

-- 
With Best Regards,
Andy Shevchenko


