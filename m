Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5881C774D11
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjHHV3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjHHV3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:29:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BE091
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691530157; x=1723066157;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7CI5gLJfERGZqbKPNE5VN7Av0UrIx51a4AyX+qyjFn4=;
  b=AetmglOhePiTh2J3HqcQaqrvWMnlUZZ9MtChpVXBhlgZOdNci8d85BCD
   q71vaSy9lztgnVUQ2wDRmm+veN27GjiedllTi7Dmzzs+Q4efm4X4ae4ej
   l2R0q9VQBRzfA4lR9itOr3CXCwyX8QqwXFGbxFOPeFdAjRcxjIqds6D/Z
   wBY6fwsFi1oNuKEFNrEYp+EaQVFkpSS3xjdh2fs4ulqeXDf6u08VMyiGp
   iM+5JeAydFAe4Y3XNFlMXEyGO0v3sbBQ+88v12f7fQmUCWU57wFeqKSVy
   mgSf5yNJD8MkzFAH3OwAKMbc7cWMighcFm9C+eRCAXPWYoo7ndPh7+LIg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="350546391"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="350546391"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 14:29:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="845658201"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="845658201"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 Aug 2023 14:29:15 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTUGQ-0005dU-30;
        Tue, 08 Aug 2023 21:29:14 +0000
Date:   Wed, 9 Aug 2023 05:28:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Christopher M. Riedl" <cmr@bluescreens.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Gray <bgray@linux.ibm.com>
Subject: arch/powerpc/include/asm/book3s/32/tlbflush.h:83:2: error: call to
 __compiletime_assert_179 declared with 'error' attribute: BUILD_BUG failed
Message-ID: <202308090515.ItaRqhnW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christopher,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   02aee814d37c563e24b73bcd0f9cb608fbd403d4
commit: c28c15b6d28a776538482101522cbcd9f906b15c powerpc/code-patching: Use temporary mm for Radix MMU
date:   8 months ago
config: powerpc-randconfig-r021-20230807 (https://download.01.org/0day-ci/archive/20230809/202308090515.ItaRqhnW-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230809/202308090515.ItaRqhnW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308090515.ItaRqhnW-lkp@intel.com/

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
>> arch/powerpc/include/asm/book3s/32/tlbflush.h:83:2: error: call to __compiletime_assert_179 declared with 'error' attribute: BUILD_BUG failed
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
   <scratch space>:28:1: note: expanded from here
   __compiletime_assert_179
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
