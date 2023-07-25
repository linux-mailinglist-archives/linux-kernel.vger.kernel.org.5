Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22CB761B12
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjGYOMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjGYOMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:12:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC98102;
        Tue, 25 Jul 2023 07:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690294322; x=1721830322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PWe9GNMaoHh1LXm7vt0nJC8CylhYVvYcKyTMHoFXiSs=;
  b=W1mg2S368EBdyh5bxVmcwX/RNIaxm/eB8spyWMfbOSikH8e9j9SRFFDV
   gjN+yNIIJQBkQ7w9svAmppFtkUBONKzzpsuSAAK46yGWOolzpVpaiEOfQ
   CUAHw4JT/tOWV3Hj/9zoKy9GASM2nXDf7//3l8az2hgOm3NYFKMdya9cC
   8WtIAJRgfyqsQ/f2LjvHLosgD5iy9QULOC8949Rvq1zph/lYgbzEjfD1N
   f7NMzqYutFXs7R/FobsBTQ7uQzlNOVHiG8H3soevnGWzIU92rf45GkStb
   jKPF30bOeCMMnJQpSBGyMuVOnFPD03I65lBgEbyKclIAhJC3vV7HVooEJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="365195243"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="365195243"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 07:06:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="729369767"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="729369767"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jul 2023 07:06:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qOIgI-00CmmR-29;
        Tue, 25 Jul 2023 17:06:30 +0300
Date:   Tue, 25 Jul 2023 17:06:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/1] Documentation: core-api: Drop :export: for
 int_log.h
Message-ID: <ZL/W5rc043oPLfMV@smile.fi.intel.com>
References: <20230725104956.47806-1-andriy.shevchenko@linux.intel.com>
 <87a5vkb0ee.fsf@meer.lwn.net>
 <b761d010-ef21-4be6-b6c3-678498b7fa71@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b761d010-ef21-4be6-b6c3-678498b7fa71@sirena.org.uk>
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

On Tue, Jul 25, 2023 at 02:46:33PM +0100, Mark Brown wrote:
> On Tue, Jul 25, 2023 at 07:12:25AM -0600, Jonathan Corbet wrote:
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> 
> > > The :export: keyword makes sense only for C-files, where EXPORT_SYMBOL()
> > > might appear. Otherwise kernel-doc may not produce anything out of this
> > > file.
> 
> > So I still can't take this patch for the reasons described before.  It
> > looks like Mark took the patch that added the problem, so perhaps he
> > should be a recipient of this one too?  I'll add him to the CC...
> 
> Is this the same patch I applied yesterday or a different one?

Hmm...
I do not see anything like this patch in your current ASoC for-next
(nor in for-6.6). Did I look into wrong branch?

-- 
With Best Regards,
Andy Shevchenko


