Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EDF79F07A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjIMRiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjIMRiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:38:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1879AB8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694626679; x=1726162679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aBkxSLFEBrjJTjfiWHBMc0aPx08qq1ybjekmSlov7iM=;
  b=NpBvh1e51omc9h3UInOrF3dGqqKWMTJCYbz74yKFqOO5GcqbNVWl9FRk
   WfZ70cYrWO7fEWyrUBScepuyTuH7qiR+In4ur1440UUEoTslktRZnLmpN
   D2nDSpbAASm90ocm2lOuk948kds+TwjixY1EeOTpO4rTXrCYiGU8tstYY
   te8tgbUlkcGHOkN7JDlaONebdABOMO1sCh+uVWYEcLxscs2KBwD/AeIt0
   2/Z0vOiAaSUubUf5IBySLP2vXnUqFtyxpTuXZmNcu3LfpjJe6lqX5HYE2
   ikQsUdFKcQPw/AJgBhPgTkZ7XXwsKOkYyxxIjt4lP4KQP8Yz7nFe/gXTQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="363768565"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="363768565"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 10:37:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="867882237"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="867882237"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 13 Sep 2023 10:37:55 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgToG-0000Pt-3A;
        Wed, 13 Sep 2023 17:37:52 +0000
Date:   Thu, 14 Sep 2023 01:37:38 +0800
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
Message-ID: <202309140117.J5VH7p4z-lkp@intel.com>
References: <20230913154956.GA26245@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913154956.GA26245@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on tip/sched/core linus/master v6.6-rc1 next-20230913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleg-Nesterov/seqlock-simplify-SEQCOUNT_LOCKNAME/20230913-235245
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20230913154956.GA26245%40redhat.com
patch subject: [PATCH 2/5] seqlock: change __seqprop() to return the function pointer
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230914/202309140117.J5VH7p4z-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309140117.J5VH7p4z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309140117.J5VH7p4z-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/rbtree_latch.h:37,
                    from include/linux/bpf.h:14,
                    from include/linux/filter.h:9,
                    from kernel/bpf/core.c:21:
   include/linux/u64_stats_sync.h: In function '__u64_stats_fetch_retry':
>> include/linux/u64_stats_sync.h:176:36: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
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
   kernel/bpf/core.c: At top level:
   kernel/bpf/core.c:1638:12: warning: no previous prototype for 'bpf_probe_read_kernel' [-Wmissing-prototypes]
    1638 | u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
         |            ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/rbtree_latch.h:37,
                    from include/linux/bpf.h:14,
                    from kernel/bpf/syscall.c:4:
   include/linux/u64_stats_sync.h: In function '__u64_stats_fetch_retry':
>> include/linux/u64_stats_sync.h:176:36: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
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
--
   In file included from include/linux/hrtimer.h:20,
                    from include/linux/sched.h:20,
                    from include/linux/ptrace.h:6,
                    from include/uapi/asm-generic/bpf_perf_event.h:4,
                    from ./arch/m68k/include/generated/uapi/asm/bpf_perf_event.h:1,
                    from include/uapi/linux/bpf_perf_event.h:11,
                    from kernel/bpf/btf.c:6:
   include/linux/u64_stats_sync.h: In function '__u64_stats_fetch_retry':
>> include/linux/u64_stats_sync.h:176:36: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
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
   kernel/bpf/btf.c: In function 'btf_seq_show':
   kernel/bpf/btf.c:7075:29: warning: function 'btf_seq_show' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    7075 |         seq_vprintf((struct seq_file *)show->target, fmt, args);
         |                             ^~~~~~~~
   kernel/bpf/btf.c: In function 'btf_snprintf_show':
   kernel/bpf/btf.c:7112:9: warning: function 'btf_snprintf_show' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    7112 |         len = vsnprintf(show->target, ssnprintf->len_left, fmt, args);
         |         ^~~


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
