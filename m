Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0037C78292A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbjHUMdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbjHUMdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:33:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183F8106;
        Mon, 21 Aug 2023 05:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692621221; x=1724157221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gsKKmGxyq06MklhX85/TgQrIKXsf+G0L4vEqXIDJDr4=;
  b=gg8guL1rYPjOrFLk/2Jy5ytacuUAj8LWNts7CI/L4nipIJCC/SJg9e+2
   XGqPh4SkYvyp6HUd+1utcEqPh5X1vH6YgDc1lADN1Z+mj+yBk9NeG1tBy
   OEa531tbY6B7+K0LlG6Sp58VdzFV0u/TF7cJcK6kvcwgcSLbRWIWw33Ip
   K5Z30QvMzs+I2AJHJ7r02tz0EhPMQxZgvusfRvUnSvz5loJpUNk4k+3Rj
   iWxb3TQgkDfA+nUyzzaAfR7IFPSA2C4ktu8+GiJlVhq3SC8DG0vWm3ykk
   iTusqZkQSkHxPpQWtItSuG6MKesY0O/2qrt4tmGU782e4roivPR13pvVU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="459943788"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="459943788"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 05:32:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="982447566"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="982447566"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 21 Aug 2023 05:32:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY45J-00DxF8-1L;
        Mon, 21 Aug 2023 15:32:41 +0300
Date:   Mon, 21 Aug 2023 15:32:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kartik <kkartik@nvidia.com>
Cc:     arnd@arndb.de, digetx@gmail.com, frank.li@vivo.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, pdeschrijver@nvidia.com,
        petlozup@nvidia.com, pshete@nvidia.com, robh@kernel.org,
        stefank@nvidia.com, sumitg@nvidia.com, thierry.reding@gmail.com,
        windhl@126.com
Subject: Re: [PATCH 1/6] soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
Message-ID: <ZONZaZ1QaWKBCMYj@smile.fi.intel.com>
References: <ZN9wdTLK1rwnVK/e@smile.fi.intel.com>
 <20230821113220.4255-1-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821113220.4255-1-kkartik@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 05:02:20PM +0530, Kartik wrote:
> On Fri, 2023-08-18 at 16:21 +0300, Andy Shevchenko wrote:

...

> >>  void tegra_init_revision(void);
> >>  void tegra_init_apbmisc(void);
> >> +void tegra_acpi_init_apbmisc(void);
> >
> >Why do you  need a separate function?
> 
> Function tegra_init_apbmisc() is called from tegra_init_fuse() which
> is invoked at early init and it also has `__init` keyword. If we use
> the same function for both ACPI/DT, then we will get init section
> mismatches when the Tegra Fuse driver probes using ACPI.
> 
> We can use the same function by dropping the `init` keyword. But
> the way we are getting the resources for device-tree and on ACPI is
> slightly different. Hence, I kept a separate function for ACPI
> and move the common bits to a function shared between
> tegra_init_apbmisc() and tegra_acpi_init_apbmisc().

So, you mean that behaviour is different for ACPI and DT cases.
Then obvious question why DT case can't be delayed to not so early
stage to be run? This requires some explanations, more than given
in the commit message and here.

-- 
With Best Regards,
Andy Shevchenko


