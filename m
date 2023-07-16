Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E3F7550CC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 20:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjGPSze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 14:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPSzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 14:55:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9659F1B5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 11:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689533730; x=1721069730;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+3UVeKKHJ51HvF0nINQ8coPJDDV2uIssD6DCsaC2LyI=;
  b=W821dOuXaSXwxWSZpJOck9bTYmospkQZ8KvByOBWG1ZnV/KADi4k35P5
   PY3feQM6p56V9Qp/FJgoRcNm/YDAuVzFxjKzFdJXmpE/0KWR/NAYqon+i
   goqLvY7qN+dM2Z8PqOOLHOT0U1UTug3Jj1lxdceIAKtZcfu+MTpAW/oEO
   spj8seBnkhamA2+it+pg0F6G4glvR2hbLTHpKTn4FMqsa7tIIx2BrasR5
   ue7xVpjKSk+bYK8lsySWi9n5KpoJRb8myIK4O/KwCjFx6VAdLn3oSwYUW
   tnwUrQm4f6WRSw3SWI1puWtt6f/7KJ/QMBA/6H/9QYXr/32n3FBc63pW/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="350652368"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="350652368"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 11:55:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="836655212"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="836655212"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jul 2023 11:55:28 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qL6tz-0008wm-0y;
        Sun, 16 Jul 2023 18:55:27 +0000
Date:   Mon, 17 Jul 2023 02:54:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>
Subject: arch/x86/include/asm/cmpxchg_64.h:24:2: error: unknown type name
 'u128'
Message-ID: <202307170214.X98DNEOs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   831fe284d8275987596b7d640518dddba5735f61
commit: b23e139d0b66c0216e7e9361a5021290395f504c arch: Introduce arch_{,try_}_cmpxchg128{,_local}()
date:   6 weeks ago
config: i386-randconfig-r013-20230710 (https://download.01.org/0day-ci/archive/20230717/202307170214.X98DNEOs-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230717/202307170214.X98DNEOs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307170214.X98DNEOs-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from scripts/mod/devicetable-offsets.c:3:
   In file included from include/linux/mod_devicetable.h:14:
   In file included from include/linux/uuid.h:11:
   In file included from include/linux/string.h:20:
   In file included from arch/x86/include/asm/string.h:5:
   In file included from arch/x86/include/asm/string_64.h:6:
   In file included from include/linux/jump_label.h:255:
   In file included from include/linux/atomic.h:7:
   In file included from arch/x86/include/asm/atomic.h:8:
   In file included from arch/x86/include/asm/cmpxchg.h:145:
>> arch/x86/include/asm/cmpxchg_64.h:24:2: error: unknown type name 'u128'
           u128 full;
           ^
   arch/x86/include/asm/cmpxchg_64.h:44:24: error: unknown type name 'u128'
   static __always_inline u128 arch_cmpxchg128(volatile u128 *ptr, u128 old, u128 new)
                          ^
   arch/x86/include/asm/cmpxchg_64.h:44:54: error: unknown type name 'u128'
   static __always_inline u128 arch_cmpxchg128(volatile u128 *ptr, u128 old, u128 new)
                                                        ^
   arch/x86/include/asm/cmpxchg_64.h:44:65: error: unknown type name 'u128'
   static __always_inline u128 arch_cmpxchg128(volatile u128 *ptr, u128 old, u128 new)
                                                                   ^
   arch/x86/include/asm/cmpxchg_64.h:44:75: error: unknown type name 'u128'
   static __always_inline u128 arch_cmpxchg128(volatile u128 *ptr, u128 old, u128 new)
                                                                             ^
>> arch/x86/include/asm/cmpxchg_64.h:46:9: error: invalid output size for constraint '+a'
           return __arch_cmpxchg128(ptr, old, new, LOCK_PREFIX);
                  ^
   arch/x86/include/asm/cmpxchg_64.h:37:16: note: expanded from macro '__arch_cmpxchg128'
                          "+a" (o.low), "+d" (o.high)                      \
                                ^
   arch/x86/include/asm/cmpxchg_64.h:49:24: error: unknown type name 'u128'
   static __always_inline u128 arch_cmpxchg128_local(volatile u128 *ptr, u128 old, u128 new)
                          ^
   arch/x86/include/asm/cmpxchg_64.h:49:60: error: unknown type name 'u128'
   static __always_inline u128 arch_cmpxchg128_local(volatile u128 *ptr, u128 old, u128 new)
                                                              ^
   arch/x86/include/asm/cmpxchg_64.h:49:71: error: unknown type name 'u128'
   static __always_inline u128 arch_cmpxchg128_local(volatile u128 *ptr, u128 old, u128 new)
                                                                         ^
   arch/x86/include/asm/cmpxchg_64.h:49:81: error: unknown type name 'u128'
   static __always_inline u128 arch_cmpxchg128_local(volatile u128 *ptr, u128 old, u128 new)
                                                                                   ^
   arch/x86/include/asm/cmpxchg_64.h:51:9: error: invalid output size for constraint '+a'
           return __arch_cmpxchg128(ptr, old, new,);
                  ^
   arch/x86/include/asm/cmpxchg_64.h:37:16: note: expanded from macro '__arch_cmpxchg128'
                          "+a" (o.low), "+d" (o.high)                      \
                                ^
   arch/x86/include/asm/cmpxchg_64.h:74:58: error: unknown type name 'u128'
   static __always_inline bool arch_try_cmpxchg128(volatile u128 *ptr, u128 *oldp, u128 new)
                                                            ^
   arch/x86/include/asm/cmpxchg_64.h:74:69: error: unknown type name 'u128'
   static __always_inline bool arch_try_cmpxchg128(volatile u128 *ptr, u128 *oldp, u128 new)
                                                                       ^
   arch/x86/include/asm/cmpxchg_64.h:74:81: error: unknown type name 'u128'
   static __always_inline bool arch_try_cmpxchg128(volatile u128 *ptr, u128 *oldp, u128 new)
                                                                                   ^
   arch/x86/include/asm/cmpxchg_64.h:76:9: error: invalid output size for constraint '+a'
           return __arch_try_cmpxchg128(ptr, oldp, new, LOCK_PREFIX);
                  ^
   arch/x86/include/asm/cmpxchg_64.h:64:16: note: expanded from macro '__arch_try_cmpxchg128'
                          "+a" (o.low), "+d" (o.high)                      \
                                ^
   arch/x86/include/asm/cmpxchg_64.h:79:64: error: unknown type name 'u128'
   static __always_inline bool arch_try_cmpxchg128_local(volatile u128 *ptr, u128 *oldp, u128 new)
                                                                  ^
   arch/x86/include/asm/cmpxchg_64.h:79:75: error: unknown type name 'u128'
   static __always_inline bool arch_try_cmpxchg128_local(volatile u128 *ptr, u128 *oldp, u128 new)
                                                                             ^
   arch/x86/include/asm/cmpxchg_64.h:79:87: error: unknown type name 'u128'
   static __always_inline bool arch_try_cmpxchg128_local(volatile u128 *ptr, u128 *oldp, u128 new)
                                                                                         ^
   arch/x86/include/asm/cmpxchg_64.h:81:9: error: invalid output size for constraint '+a'
           return __arch_try_cmpxchg128(ptr, oldp, new,);
                  ^
   arch/x86/include/asm/cmpxchg_64.h:64:16: note: expanded from macro '__arch_try_cmpxchg128'
                          "+a" (o.low), "+d" (o.high)                      \
                                ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.
   make[2]: *** [scripts/Makefile.build:114: scripts/mod/devicetable-offsets.s] Error 1
   make[2]: Target 'scripts/mod/' not remade because of errors.
   make[1]: *** [Makefile:1286: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:226: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/u128 +24 arch/x86/include/asm/cmpxchg_64.h

    22	
    23	union __u128_halves {
  > 24		u128 full;
    25		struct {
    26			u64 low, high;
    27		};
    28	};
    29	
    30	#define __arch_cmpxchg128(_ptr, _old, _new, _lock)			\
    31	({									\
    32		union __u128_halves o = { .full = (_old), },			\
    33				    n = { .full = (_new), };			\
    34										\
    35		asm volatile(_lock "cmpxchg16b %[ptr]"				\
    36			     : [ptr] "+m" (*(_ptr)),				\
    37			       "+a" (o.low), "+d" (o.high)			\
    38			     : "b" (n.low), "c" (n.high)			\
    39			     : "memory");					\
    40										\
    41		o.full;								\
    42	})
    43	
  > 44	static __always_inline u128 arch_cmpxchg128(volatile u128 *ptr, u128 old, u128 new)
    45	{
  > 46		return __arch_cmpxchg128(ptr, old, new, LOCK_PREFIX);
    47	}
    48	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
