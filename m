Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D9C7F89C9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 10:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjKYJuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 04:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKYJuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 04:50:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D3210D8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 01:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700905817; x=1732441817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Aqc2go/1I5Lhzy1CTRLHUJ9I76KJLrgIOLwaPYI5Esw=;
  b=DMgneKbMZGmDv8tPzAjWYoUOiHjbNyhtYp49mWD3tnChMxstfG6YhEJ4
   16Zl7N4uaYBR54EgbbFHfvp+Uepa1d5V6Oj2T+OiPz1yqlSniCPWcCKOB
   Yaj0tU74kGhSn99utlpLmnkj2RWFZd6pK/o57jqxpIVdykQY9biC+5oPI
   KT+5Hjh7wftKchoIldT5WTedhhOaJXJPXHHsrwiN2Br/MBhJpOZPeucLF
   Mz3lXyyjMI3OyIL1WDsu8tbJ9Y1KexbfZcjMZQfsc62M/FXmwV5Zub8Tq
   MzJFdTeVNJnFZsvuPHegsKh2kNyvLcJOD5j+I21jdOG51tE9jw/NR0+3g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="382908200"
X-IronPort-AV: E=Sophos;i="6.04,226,1695711600"; 
   d="scan'208";a="382908200"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2023 01:50:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="891256779"
X-IronPort-AV: E=Sophos;i="6.04,226,1695711600"; 
   d="scan'208";a="891256779"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Nov 2023 01:50:13 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6pIg-0003r8-2R;
        Sat, 25 Nov 2023 09:50:10 +0000
Date:   Sat, 25 Nov 2023 17:49:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     guoren@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
        keescook@chromium.org, paulmck@kernel.org, ubizjak@gmail.com,
        tglx@linutronix.de
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2] locking/atomic: scripts: Increase template priority
 in order variants
Message-ID: <202311251751.UOK2L2UW-lkp@intel.com>
References: <20231125013025.3620560-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125013025.3620560-1-guoren@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kees/for-next/pstore]
[also build test WARNING on kees/for-next/kspp]
[cannot apply to linus/master v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/guoren-kernel-org/locking-atomic-scripts-Increase-template-priority-in-order-variants/20231125-093207
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
patch link:    https://lore.kernel.org/r/20231125013025.3620560-1-guoren%40kernel.org
patch subject: [PATCH V2] locking/atomic: scripts: Increase template priority in order variants
config: i386-buildonly-randconfig-002-20231125 (https://download.01.org/0day-ci/archive/20231125/202311251751.UOK2L2UW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231125/202311251751.UOK2L2UW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311251751.UOK2L2UW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/atomic.h:8,
                    from include/linux/atomic.h:7,
                    from include/linux/jump_label.h:255,
                    from include/linux/static_key.h:1,
                    from arch/x86/include/asm/nospec-branch.h:6,
                    from arch/x86/include/asm/paravirt_types.h:27,
                    from arch/x86/include/asm/ptrace.h:97,
                    from arch/x86/include/asm/math_emu.h:5,
                    from arch/x86/include/asm/processor.h:13,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/compat.h:10,
                    from kernel/futex/core.c:34:
   arch/x86/include/asm/cmpxchg.h: In function 'raw_atomic64_cmpxchg_relaxed':
>> arch/x86/include/asm/cmpxchg.h:130:9: warning: '__ret' is used uninitialized [-Wuninitialized]
     130 |         __ret;                                                          \
         |         ^~~~~
   arch/x86/include/asm/cmpxchg.h:87:28: note: '__ret' was declared here
      87 |         __typeof__(*(ptr)) __ret;                                       \
         |                            ^~~~~
   arch/x86/include/asm/cmpxchg.h:134:9: note: in expansion of macro '__raw_cmpxchg'
     134 |         __raw_cmpxchg((ptr), (old), (new), (size), LOCK_PREFIX)
         |         ^~~~~~~~~~~~~
   arch/x86/include/asm/cmpxchg.h:149:9: note: in expansion of macro '__cmpxchg'
     149 |         __cmpxchg(ptr, old, new, sizeof(*(ptr)))
         |         ^~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:91:29: note: in expansion of macro 'arch_cmpxchg'
      91 | #define raw_cmpxchg_relaxed arch_cmpxchg
         |                             ^~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:4107:16: note: in expansion of macro 'raw_cmpxchg_relaxed'
    4107 |         return raw_cmpxchg_relaxed(&v->counter, old, new);
         |                ^~~~~~~~~~~~~~~~~~~
   In function 'raw_atomic64_cmpxchg_relaxed',
       inlined from 'atomic64_cmpxchg_relaxed' at include/linux/atomic/atomic-instrumented.h:2817:9,
       inlined from 'get_inode_sequence_number' at kernel/futex/core.c:186:9,
       inlined from 'get_futex_key' at kernel/futex/core.c:387:23:
   arch/x86/include/asm/cmpxchg.h:128:17: error: call to '__cmpxchg_wrong_size' declared with attribute error: Bad argument size for cmpxchg
     128 |                 __cmpxchg_wrong_size();                                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/cmpxchg.h:134:9: note: in expansion of macro '__raw_cmpxchg'
     134 |         __raw_cmpxchg((ptr), (old), (new), (size), LOCK_PREFIX)
         |         ^~~~~~~~~~~~~
   arch/x86/include/asm/cmpxchg.h:149:9: note: in expansion of macro '__cmpxchg'
     149 |         __cmpxchg(ptr, old, new, sizeof(*(ptr)))
         |         ^~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:91:29: note: in expansion of macro 'arch_cmpxchg'
      91 | #define raw_cmpxchg_relaxed arch_cmpxchg
         |                             ^~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:4107:16: note: in expansion of macro 'raw_cmpxchg_relaxed'
    4107 |         return raw_cmpxchg_relaxed(&v->counter, old, new);
         |                ^~~~~~~~~~~~~~~~~~~


vim +/__ret +130 arch/x86/include/asm/cmpxchg.h

e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   79  
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   80  /*
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   81   * Atomic compare and exchange.  Compare OLD with MEM, if identical,
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   82   * store NEW in MEM.  Return the initial value in MEM.  Success is
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   83   * indicated by comparing RETURN with OLD.
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   84   */
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   85  #define __raw_cmpxchg(ptr, old, new, size, lock)			\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   86  ({									\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   87  	__typeof__(*(ptr)) __ret;					\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   88  	__typeof__(*(ptr)) __old = (old);				\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   89  	__typeof__(*(ptr)) __new = (new);				\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   90  	switch (size) {							\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   91  	case __X86_CASE_B:						\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   92  	{								\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   93  		volatile u8 *__ptr = (volatile u8 *)(ptr);		\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   94  		asm volatile(lock "cmpxchgb %2,%1"			\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   95  			     : "=a" (__ret), "+m" (*__ptr)		\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   96  			     : "q" (__new), "0" (__old)			\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   97  			     : "memory");				\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   98  		break;							\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18   99  	}								\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  100  	case __X86_CASE_W:						\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  101  	{								\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  102  		volatile u16 *__ptr = (volatile u16 *)(ptr);		\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  103  		asm volatile(lock "cmpxchgw %2,%1"			\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  104  			     : "=a" (__ret), "+m" (*__ptr)		\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  105  			     : "r" (__new), "0" (__old)			\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  106  			     : "memory");				\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  107  		break;							\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  108  	}								\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  109  	case __X86_CASE_L:						\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  110  	{								\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  111  		volatile u32 *__ptr = (volatile u32 *)(ptr);		\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  112  		asm volatile(lock "cmpxchgl %2,%1"			\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  113  			     : "=a" (__ret), "+m" (*__ptr)		\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  114  			     : "r" (__new), "0" (__old)			\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  115  			     : "memory");				\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  116  		break;							\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  117  	}								\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  118  	case __X86_CASE_Q:						\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  119  	{								\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  120  		volatile u64 *__ptr = (volatile u64 *)(ptr);		\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  121  		asm volatile(lock "cmpxchgq %2,%1"			\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  122  			     : "=a" (__ret), "+m" (*__ptr)		\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  123  			     : "r" (__new), "0" (__old)			\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  124  			     : "memory");				\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  125  		break;							\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  126  	}								\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  127  	default:							\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  128  		__cmpxchg_wrong_size();					\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  129  	}								\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18 @130  	__ret;								\
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  131  })
e9826380d83d1b Jeremy Fitzhardinge 2011-08-18  132  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
