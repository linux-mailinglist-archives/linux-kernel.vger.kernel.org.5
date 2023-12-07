Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7699808B96
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443401AbjLGPST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjLGPSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:18:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EF519A;
        Thu,  7 Dec 2023 07:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701962304; x=1733498304;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UaX0GAKK5igBIXL0RGWc8kbygqI2txdyVYRY2GmNRYE=;
  b=BIhJbqjzpIjBzX+C4wYM3St2nFc77hBAE7sMmA0OzIe0bLBDU3MhpyNX
   cJ2KoUHvfG6LJslVqbCG/1br8iLUisu2EPqm3XfNH2iFt0FjirGG8yohX
   XxpaILHSBbFNRHLjYaqG2ekEGkiKA/0Jq8o+ttv30ToMY8NeKVxiKtuCQ
   5XNTnm/JhI5w2pPTE20GxfSjIonZo0aVAo0Ui4nYM3sJNYBC5Uv2uLIY3
   X8sQtvnC+yHjCUh+bh1Q/XvdMtDfBzf9RGwSaNdxxHuZG8Ldz2N/2mAj7
   fZavr1JWpfmTSb9L5EfGWAWqC6vWEQ7Xi11RtE92Wxs4wAdSPJJYJTTeM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="425392090"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="425392090"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 07:18:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1103227584"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1103227584"
Received: from dkrupnov-mobl3.ger.corp.intel.com ([10.249.34.6])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 07:18:22 -0800
Date:   Thu, 7 Dec 2023 17:18:19 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 19/26] selftests/resctrl: Rewrite Cache Allocation
 Technology (CAT) test
In-Reply-To: <516f3152-0690-403e-a8eb-c142888a16d5@intel.com>
Message-ID: <1a571afa-1898-3253-126f-b57020768f91@linux.intel.com>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com> <20231120111340.7805-20-ilpo.jarvinen@linux.intel.com> <516f3152-0690-403e-a8eb-c142888a16d5@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-619595144-1701962303=:1765"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-619595144-1701962303=:1765
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 28 Nov 2023, Reinette Chatre wrote:
> On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> > CAT test spawns two processes into two different control groups with
> > exclusive schemata. Both the processes alloc a buffer from memory
> > matching their allocated LLC block size and flush the entire buffer out
> > of caches. Since the processes are reading through the buffer only once
> > during the measurement and initially all the buffer was flushed, the
> > test isn't testing CAT.
> > 
> > Rewrite the CAT test to allocate a buffer sized to half of LLC. Then
> > perform a sequence of tests with different LLC alloc sizes starting
> > from half of the CBM bits down to 1-bit CBM. Flush the buffer before
> > each test and read the buffer twice. Observe the LLC misses on the
> > second read through the buffer. As the allocated LLC block gets smaller
> > and smaller, the LLC misses will become larger and larger giving a
> > strong signal on CAT working properly.
> > 
> > The new CAT test is using only a single process because it relies on
> > measured effect against another run of itself rather than another
> > process adding noise. The rest of the system is set to use the CBM bits
> > not used by the CAT test to keep the test isolated.
> > 
> > Replace count_bits() with count_contiguous_bits() to get the first bit
> > position in order to be able to calculate masks based on it.
> > 
> > This change has been tested with a number of systems from different
> > generations.
> > 
> > Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  tools/testing/selftests/resctrl/cat_test.c  | 282 +++++++++-----------
> >  tools/testing/selftests/resctrl/fill_buf.c  |   6 +-
> >  tools/testing/selftests/resctrl/resctrl.h   |   5 +-
> >  tools/testing/selftests/resctrl/resctrlfs.c |  44 +--
> >  4 files changed, 138 insertions(+), 199 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> > index cfda87667b46..4169b17b8f91 100644
> > --- a/tools/testing/selftests/resctrl/cat_test.c
> > +++ b/tools/testing/selftests/resctrl/cat_test.c
> > @@ -11,65 +11,69 @@
> >  #include "resctrl.h"
> >  #include <unistd.h>
> >  
> > -#define RESULT_FILE_NAME1	"result_cat1"
> > -#define RESULT_FILE_NAME2	"result_cat2"
> > +#define RESULT_FILE_NAME	"result_cat"
> >  #define NUM_OF_RUNS		5
> > -#define MAX_DIFF_PERCENT	4
> > -#define MAX_DIFF		1000000
> >  
> >  /*
> > - * Change schemata. Write schemata to specified
> > - * con_mon grp, mon_grp in resctrl FS.
> > - * Run 5 times in order to get average values.
> > + * Minimum difference in LLC misses between a test with n+1 bits CBM to the
> > + * test with n bits is MIN_DIFF_PERCENT_PER_BIT * (n - 1). With e.g. 5 vs 4
> > + * bits in the CBM mask, the minimum difference must be at least
> > + * MIN_DIFF_PERCENT_PER_BIT * (4 - 1) = 3 percent.
> > + *
> > + * The relationship between number of used CBM bits and difference in LLC
> > + * misses is not expected to be linear. With a small number of bits, the
> > + * margin is smaller than with larger number of bits. For selftest purposes,
> > + * however, linear approach is enough because ultimately only pass/fail
> > + * decision has to be made and distinction between strong and stronger
> > + * signal is irrelevant.
> >   */
> > -static int cat_setup(struct resctrl_val_param *p)
> > -{
> > -	char schemata[64];
> > -	int ret = 0;
> > -
> > -	/* Run NUM_OF_RUNS times */
> > -	if (p->num_of_runs >= NUM_OF_RUNS)
> > -		return END_OF_TESTS;
> > -
> > -	if (p->num_of_runs == 0) {
> > -		sprintf(schemata, "%lx", p->mask);
> > -		ret = write_schemata(p->ctrlgrp, schemata, p->cpu_no,
> > -				     p->resctrl_val);
> > -	}
> > -	p->num_of_runs++;
> > -
> > -	return ret;
> > -}
> > +#define MIN_DIFF_PERCENT_PER_BIT	1
> >  
> >  static int show_results_info(__u64 sum_llc_val, int no_of_bits,
> > -			     unsigned long cache_span, unsigned long max_diff,
> > -			     unsigned long max_diff_percent, unsigned long num_of_runs,
> > -			     bool platform)
> > +			     unsigned long cache_span, long min_diff_percent,
> 
> With all care taken in unsigned use I wonder why min_diff_percent is 
> just long? 

This was a leftover from the time when I still wasn't using floats so the
compare typing was easier. But's it's long gone now so I'll make that 
unsigned long.

> It looks to me as though this test impacts the affinity of main program
> since it is only one process, changes its affinity, but never change it back.

Ah, right.

It looks pre-existing problem though as despite more than one process in 
the old CAT test, it altered affinity of both of them. I'll need to look 
into fixing this.

-- 
 i.

--8323329-619595144-1701962303=:1765--
