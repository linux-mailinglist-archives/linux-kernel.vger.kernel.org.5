Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC6879F1F9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjIMTYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjIMTYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:24:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44027B7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694633042; x=1726169042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Um2MtTfHVP3AhNYPuGkHR/IlcPV4IcwmbHNi4nWhmw=;
  b=XJinCfo9v73ttMVjB2J5PlJ5TZYhEEy3ylr3oAeSKwWbjZWLDz2BNlPJ
   yaxAXM8Rjis1VkTvVwOa6uUWRCykGXF06GeltOfI5J6LQlBtnGGT1+o+R
   O7vm/rHazCeGk1x6yIdRIPurwMR9DBUJ70ujeR7jC/ZHYt8IdeZeQS7MG
   XZmksDn9aTq/Evlr2e/lNwsRHwB9wxJgzP5YslMXHjd9bjGhOYNzEqwSv
   GkNnTYb3cD4KVdFsel7q+r8+mfXjbgUkCR0ARIVD3NSHKltwWym3ZzH1g
   wwrAB43cBCKXdOthA/EVzyFIu1cnzFp1fdG8jtDTnrljQPQV/WZ+Q4azQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="377673274"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="377673274"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 12:24:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="917962140"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="917962140"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Sep 2023 12:23:58 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgVSu-0000Vn-2B;
        Wed, 13 Sep 2023 19:23:56 +0000
Date:   Thu, 14 Sep 2023 03:23:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oleg Nesterov <oleg@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] seqlock: change __seqprop() to return the function
 pointer
Message-ID: <202309140355.Sglwk06B-lkp@intel.com>
References: <20230913154956.GA26245@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913154956.GA26245@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/locking/core]
[also build test ERROR on tip/sched/core linus/master v6.6-rc1 next-20230913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleg-Nesterov/seqlock-simplify-SEQCOUNT_LOCKNAME/20230913-235245
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20230913154956.GA26245%40redhat.com
patch subject: [PATCH 2/5] seqlock: change __seqprop() to return the function pointer
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20230914/202309140355.Sglwk06B-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309140355.Sglwk06B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309140355.Sglwk06B-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/hrtimer.h:20,
                    from include/linux/sched.h:20,
                    from arch/powerpc/kernel/syscalls.c:18:
   include/linux/u64_stats_sync.h: In function '__u64_stats_fetch_retry':
>> include/linux/u64_stats_sync.h:176:36: error: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
     176 |         return read_seqcount_retry(&syncp->seq, start);
         |                                    ^~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/u64_stats_sync.h:176:16: note: in expansion of macro 'read_seqcount_retry'
     176 |         return read_seqcount_retry(&syncp->seq, start);
         |                ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
   cc1: all warnings being treated as errors


vim +176 include/linux/u64_stats_sync.h

68107df5f2cb5d Frederic Weisbecker 2016-09-26  172  
68107df5f2cb5d Frederic Weisbecker 2016-09-26  173  static inline bool __u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
16b8a4761cbe50 Eric Dumazet        2010-06-22  174  					   unsigned int start)
16b8a4761cbe50 Eric Dumazet        2010-06-22  175  {
16b8a4761cbe50 Eric Dumazet        2010-06-22 @176  	return read_seqcount_retry(&syncp->seq, start);
44b0c2957adc62 Thomas Gleixner     2022-08-25  177  }
44b0c2957adc62 Thomas Gleixner     2022-08-25  178  #endif /* !64 bit */
44b0c2957adc62 Thomas Gleixner     2022-08-25  179  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
