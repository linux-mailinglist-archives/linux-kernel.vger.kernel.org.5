Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE65758683
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjGRVHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGRVHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:07:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8FCEC;
        Tue, 18 Jul 2023 14:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689714463; x=1721250463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ootxdXDE5uMtvxtWujNgqbk4Aj9V+Z+d5RmLRHxw5Bc=;
  b=U0jOwkb1rXjVe4itcTgbwrTFYhfHhwlavzeYKVeeICx9lzF2jOawu9h8
   5YNr234/kRgXLvNbSv8tZpjzmukG89KYEm7YGNQrXBN5VThJUmw1v0yv8
   gMduMlGpr8lGeSf2shpDKhCAmSV9mWk8H78aLT2Scdpa8q8ddFc3Z1MHP
   y21+1GzVfDqrDKpR5nOHrJ0DBdW5NGkulhd1QpnUjU1UXmoIvdMbGgxk/
   8/RfrvFZPqUraFEct4G8D/+YrUbo6r4TsGD61JRHMPkOi/2PVV02eQ9+J
   G5T61O6wlkzE0AQNFyggsfgfC1BNOuaPOEyqASf1LKM+/pM/qA+FoeFID
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="356261387"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="356261387"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 14:07:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="758927100"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="758927100"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 18 Jul 2023 14:07:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLrv1-00DMHs-1X;
        Wed, 19 Jul 2023 00:07:39 +0300
Date:   Wed, 19 Jul 2023 00:07:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <ZLb/GzwqI6tkzLv6@smile.fi.intel.com>
References: <20230718100257.1ed9290e@canb.auug.org.au>
 <ZLaXC29UH3SuTJtP@smile.fi.intel.com>
 <20230718103430.f5062ce13b63171e418c94f3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718103430.f5062ce13b63171e418c94f3@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:34:30AM -0700, Andrew Morton wrote:
> On Tue, 18 Jul 2023 16:43:39 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Jul 18, 2023 at 10:02:57AM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > After merging the mm tree, today's linux-next build (arm
> > > multi_v7_defconfig) failed like this:
> > 
> > Thank you for this report!
> > 
> > Andrew, since it's in a separate patch, can you drop the change to
> > include/linux/arm-smccc.h?
> 
> I actually dropped the whole series.

Okay, I fixed that locally and soon send a v4.

-- 
With Best Regards,
Andy Shevchenko


