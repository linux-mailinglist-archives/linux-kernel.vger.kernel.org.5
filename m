Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAE175F7C5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjGXNGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGXNGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:06:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C42DA1;
        Mon, 24 Jul 2023 06:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690203971; x=1721739971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p9plD+MBNzWngIxz/Eq231KgWmF5zw1xzGbqHZJ+UVc=;
  b=GL2sYqxjBtrnPIaYiGsJ74UAOjVvWflFj+BPZ7bQPsOz58ET5sEaT7RP
   JCj7UEzURTgP4bCVrGch3uR0vbFQlEV2a8koLPrr8KE5fWl9ISft9PwnE
   M5VchHQYxOQKOSVbmMbscbuzcN2rjnbv8D3aCha2XxnA79fwB8uW0jQaf
   NKwUyO6IMZbSXgapW6sqSpr5Dp5KH8D9cE30LSNyCNxlXMpvI95W6yCor
   iUo/aXx02ke1JYDxCzqok5W0W+N9CvoIx8YBs14XpD/pM6ZeMqSy2Wdib
   +K3FM6bwYeamhMYB8fOedtESSgMiLltXzeTaj2pPDo5++KmcxRnfqH/Rk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="453811724"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="453811724"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 06:05:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="675813760"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="675813760"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 24 Jul 2023 06:05:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qNvFm-00E4ma-1w;
        Mon, 24 Jul 2023 16:05:34 +0300
Date:   Mon, 24 Jul 2023 16:05:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <ZL53HkIWuE4byo+R@smile.fi.intel.com>
References: <20230713121627.17990c86@canb.auug.org.au>
 <ZK/ruOD4QFPQ3Q5q@smile.fi.intel.com>
 <ZK/w5LFanElxZazG@smile.fi.intel.com>
 <ZLES/6iNcmR7H+f7@smile.fi.intel.com>
 <20230724135858.3c1abb01@canb.auug.org.au>
 <ZL410jAw2ksuBx56@smile.fi.intel.com>
 <cbff36d5-cde7-43bd-b0d5-ede8950fd885@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbff36d5-cde7-43bd-b0d5-ede8950fd885@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 01:36:53PM +0100, Mark Brown wrote:
> On Mon, Jul 24, 2023 at 11:26:58AM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 24, 2023 at 01:58:58PM +1000, Stephen Rothwell wrote:
> > > On Fri, 14 Jul 2023 12:18:55 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > > > The 20230713165320.14199-1-andriy.shevchenko@linux.intel.com had been sent.
> 
> For the benefit of those playing at home that's "Documentation:
> core-api: Drop :export: for int_log.h".
> 
> > > But not yet applied by anyone :-(
> 
> > Since the culprit went via ASoC tree, I think that tree is the best for the fix.
> > Mark, can you apply that, please?
> 
> Jon's usually fairly responsive, perhaps there's something worrying
> there,

Hmm... maybe my understanding of the :export: is wrong? Or what do you suggest?

> though I do note you only sent it a bit more than a week ago.

I fully aware of that and you can see that this reply has been induced by
the ping from Stephen.

-- 
With Best Regards,
Andy Shevchenko


