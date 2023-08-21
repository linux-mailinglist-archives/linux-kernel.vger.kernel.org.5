Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E94782964
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjHUMr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbjHUMr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:47:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98D4CF;
        Mon, 21 Aug 2023 05:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692622041; x=1724158041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WT0CppAYh4JWZnBJRGCct2icAFxfvQD2ozg66ant7VA=;
  b=PehRDXWm18NvThT8+b+DoHE8aXSo/OmmqEdoLxS/3H076MREWIb0k1rw
   yWw0XmQXThQ/Tgbqz5oZN6wNs+fuFrYyZJqkhujFrEFpiid+VaeU6m8oX
   e19Nb7tJFQWER4sXZDIFcbmvaJbjfnQ00Y9PIyUDQKofRkxWO8BZDHx4J
   QAc52GemUK8KNcdvT+kIq922T/n9SCpMiITXy24ZnZbwCBfqcTW6XBY37
   9iYHntD6GWqQ1p4/ZKkWpVg1nKVVG46hs/WGkMFy2s/OMmGQ9YEaxqf2S
   PgjAnOmy/La5PyXqzXsiMa2I2hVEU+WXha2mopN9N1IGdwvSfeztaegjo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="353895300"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="353895300"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 05:47:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="859460788"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="859460788"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 21 Aug 2023 05:47:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY4JO-00ES7D-37;
        Mon, 21 Aug 2023 15:47:14 +0300
Date:   Mon, 21 Aug 2023 15:47:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kartik <kkartik@nvidia.com>
Cc:     arnd@arndb.de, digetx@gmail.com, frank.li@vivo.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, pdeschrijver@nvidia.com,
        petlozup@nvidia.com, pshete@nvidia.com, robh@kernel.org,
        stefank@nvidia.com, sumitg@nvidia.com, thierry.reding@gmail.com,
        windhl@126.com
Subject: Re: [PATCH 6/6] soc/tegra: fuse: Add support for Tegra241
Message-ID: <ZONc0r5lJ8C32Kdc@smile.fi.intel.com>
References: <ZN+Jzbsci3RLtEnW@smile.fi.intel.com>
 <20230821114033.4446-1-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821114033.4446-1-kkartik@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 05:10:33PM +0530, Kartik wrote:
> On Fri, 2023-08-18 at 18:10 +0300, Andy Shevchenko wrote:
> >On Fri, Aug 18, 2023 at 03:00:28PM +0530, Kartik wrote:

...

> >>  	case TEGRA234:
> >>  		fuse->soc = &tegra234_fuse_soc;
> >>  		break;
> >> +#endif
> >> +#if defined(CONFIG_ARCH_TEGRA_241_SOC)
> >> +	case TEGRA241:
> >> +		fuse->soc = &tegra241_fuse_soc;
> >> +		break;
> >>  #endif
> >
> >Have you tried --patience when formatting patches?
> >Does it help them to look better?
> 
> No, I did not use --patience flag while formatting the patches.
> Shall I post the next patch set using it?

Do you see the difference in the output? If yes, definitely use it.
Otherwise it's recommended to use anyway.

-- 
With Best Regards,
Andy Shevchenko


