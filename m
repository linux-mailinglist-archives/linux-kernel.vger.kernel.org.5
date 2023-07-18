Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3417C757DFD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjGRNoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjGRNoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:44:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589CC1A2;
        Tue, 18 Jul 2023 06:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689687837; x=1721223837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eLq/QLoTywf6uS59NIETBEC5IDTxwIcuMyrOlSGZm7s=;
  b=LOU8cRLQxPK5zcDuVSo3hK2HILKkKrzHKt6ScbBV5hA5BCio383inF1P
   iRRw+OmbAgDcn8/tuIo9fExdFwFAG4WeXPlpCRy8EUB/FXv69DKcYZGbl
   Ym1Z3CEuZMmlQu+hgq0dqw8y8KXiYLTleeEbOUNuIsSpnhzmX119c05jD
   +7xcOPIpmD7OGIiH0uhOqWaf5cVkLHWtYWzlTfB6Tejt1Ovm0Pz9t1GOR
   1Ubbi2MxS0Y7R5ljXrSUatJ43vKjZUkgDv7Tnx4K3i5N7cPvNItfEJ+HU
   i1sQ0ek2AovvVhpV6BFvS/FMxtBB1w8LRkZAVzBNmVmOZ3InqwUK8Qk3k
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="345801174"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="345801174"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 06:43:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="847706875"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="847706875"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 18 Jul 2023 06:43:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLkzL-00FZjh-2V;
        Tue, 18 Jul 2023 16:43:39 +0300
Date:   Tue, 18 Jul 2023 16:43:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <ZLaXC29UH3SuTJtP@smile.fi.intel.com>
References: <20230718100257.1ed9290e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718100257.1ed9290e@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:02:57AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:

Thank you for this report!

Andrew, since it's in a separate patch, can you drop the change to
include/linux/arm-smccc.h?

I will try to figure out what's going on here.

...

> Presumably caused by commits

by this one

>   fceebffabbb6 ("arm64: smccc: replace custom COUNT_ARGS() & CONCATENATE() implementations")

-- 
With Best Regards,
Andy Shevchenko


