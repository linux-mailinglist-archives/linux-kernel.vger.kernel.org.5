Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCA4784F22
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 05:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjHWDJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 23:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjHWDJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 23:09:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61ECE54
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 20:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692760162; x=1724296162;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=93OPgOVhOfI1xvrWbE8vYK+PW6HWOqzJOUU0sZcYsVE=;
  b=AzFIZUk8iYB50v85/tKpeb6/wDF9Z6iDSF6KSV2Dg3H7DyPxzuYXAgID
   0HPvvg84lNCKnAbYdd/uMAhLlq5xgqLrRgmxxxqaOP+eSmLSlAAz7FuT5
   emq68G3LqM0BblCsWNh8y4IEY1kD0RADh6iqSqL57gZCSY6B5B8YJewCK
   KW9+V0AbDm4d9P7Q2wVi/hVWQpdwkL3l83mGxGOqSrU1rxMct/EJQzIIh
   oPHKZq4r9R3GoFptnkxc0uY4HcSkv7a74YhhTMTdCs3N0waMdHkuJ3iDq
   mgaWQa+lgvog7wHXmYx9YJM7o4Tj6KxxW1I6yMUqpWyBYGUhz5kaM+kC1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="405048240"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="405048240"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 20:09:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="910344919"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="910344919"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 22 Aug 2023 20:09:20 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYeFD-0000ne-1b;
        Wed, 23 Aug 2023 03:09:19 +0000
Date:   Wed, 23 Aug 2023 11:08:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Christopher M. Riedl" <cmr@bluescreens.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Gray <bgray@linux.ibm.com>
Subject: arch/powerpc/include/asm/book3s/32/tlbflush.h:83:2: error: call to
 __compiletime_assert_188 declared with 'error' attribute: BUILD_BUG failed
Message-ID: <202308231138.tzBn5so0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christopher,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89bf6209cad66214d3774dac86b6bbf2aec6a30d
commit: c28c15b6d28a776538482101522cbcd9f906b15c powerpc/code-patching: Use temporary mm for Radix MMU
date:   9 months ago
config: powerpc-randconfig-r001-20230823 (https://download.01.org/0day-ci/archive/20230823/202308231138.tzBn5so0-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308231138.tzBn5so0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308231138.tzBn5so0-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/lib/code-patching.c:6:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:29:
   In file included from include/linux/mm.h:29:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/powerpc/include/asm/pgtable.h:11:
   In file included from arch/powerpc/include/asm/tlbflush.h:6:
   In file included from arch/powerpc/include/asm/book3s/tlbflush.h:8:
>> arch/powerpc/include/asm/book3s/32/tlbflush.h:83:2: error: call to __compiletime_assert_188 declared with 'error' attribute: BUILD_BUG failed
           BUILD_BUG();
           ^
   include/linux/build_bug.h:59:21: note: expanded from macro 'BUILD_BUG'
   #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
                       ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:357:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:345:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:338:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:107:1: note: expanded from here
   __compiletime_assert_188
   ^
   1 error generated.


vim +/error +83 arch/powerpc/include/asm/book3s/32/tlbflush.h

274d842fa1efd9 Benjamin Gray 2022-11-09  79  
274d842fa1efd9 Benjamin Gray 2022-11-09  80  static inline void local_flush_tlb_page_psize(struct mm_struct *mm,
274d842fa1efd9 Benjamin Gray 2022-11-09  81  					      unsigned long vmaddr, int psize)
274d842fa1efd9 Benjamin Gray 2022-11-09  82  {
274d842fa1efd9 Benjamin Gray 2022-11-09 @83  	BUILD_BUG();
274d842fa1efd9 Benjamin Gray 2022-11-09  84  }
274d842fa1efd9 Benjamin Gray 2022-11-09  85  

:::::: The code at line 83 was first introduced by commit
:::::: 274d842fa1efd9449e62222c8896e0be11621f1f powerpc/tlb: Add local flush for page given mm_struct and psize

:::::: TO: Benjamin Gray <bgray@linux.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
