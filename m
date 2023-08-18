Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCA7780D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377645AbjHROGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377627AbjHROGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:06:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B58A2102;
        Fri, 18 Aug 2023 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692367581; x=1723903581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OWykNYp8xK0wg9jjqTR3ywTYeKlqGIll0oWR9iTbnuk=;
  b=UbIBihIi2IjuBBM2Nca2Ik+jTm4nFMCyv9/FIFFmQ0X18Qfj/E+XrnIR
   9YKmUWsbGoTIyNEkG5MjmxMb7pdkZmWRtAvNzKd1YztKoilcVFZQGE4Eh
   5ocHppH6N/DGFBkIbfA1yn4I9IA5OYgGHuogZnHTgHirh7PMqSGCCN3p6
   RVsrCQ6ULehGT9rCkIhkCsMmrdHfAcmo6tw7yUBA2156bc0YHr9JOt3+n
   3uAps+i7CYhI0WK7i6hM4jTZhI1Ow6xYUPl/Dq7QFYWCaMr4EskJwZgFz
   G21RJfMFtvOXbDjlppZD2+hFc/V3moNqWtC4fR0vjkfTsHqH0re6uJhm+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="376866450"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="376866450"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 07:06:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="764574292"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="764574292"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2023 07:06:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qX07D-00B5Zs-0F;
        Fri, 18 Aug 2023 17:06:15 +0300
Date:   Fri, 18 Aug 2023 17:06:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kartik <kkartik@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, sumitg@nvidia.com,
        arnd@arndb.de, pshete@nvidia.co, digetx@gmail.com,
        petlozup@nvidia.com, windhl@126.com, frank.li@vivo.com,
        robh@kernel.org, stefank@nvidia.com, pdeschrijver@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] soc/tegra: fuse: Add function to add lookups
Message-ID: <ZN961t8WesCG2J0+@smile.fi.intel.com>
References: <20230818093028.7807-1-kkartik@nvidia.com>
 <20230818093028.7807-4-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818093028.7807-4-kkartik@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 03:00:25PM +0530, Kartik wrote:
> Add helper function tegra_fuse_add_lookups() to register Tegra fuse
> nvmem lookups. So, this can be shared between tegra_fuse_init() and
> ACPI probe, which is to be introduced later.

...

> +	size = sizeof(*fuse->lookups) * fuse->soc->num_lookups;

At least this should use size_mul().

> +	fuse->lookups = kmemdup(fuse->soc->lookups, size, GFP_KERNEL);
> +	if (!fuse->lookups)
> +		return -ENOMEM;

But ideally you need to add a patch that brings kmemdup_array().

Okay, it seems it's in the original code :-(
Can you add in your ToDo list to amend this?

-- 
With Best Regards,
Andy Shevchenko


