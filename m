Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D436275B5C6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjGTRi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjGTRiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:38:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512D72719
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689874703; x=1721410703;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=deBOvTeII7hbzJ6MM2i8mI3IXlmLFekUZCFAL/jP414=;
  b=Zz0fyfXloavXmBC4rSUStGXw3vcsZfLVgnG2wpGFXFx0gSI8c29215tY
   CSWfyZg2nTcdmC6R1nr38XVMDEJT/sD5f78niGbTeeJaG63y0TS8X7EkL
   0Wxqh+NoAxi3r03LhBCZk3GzdoSG/cmTq0MmOhuiNjNgIYwTRvWcFZukf
   LJe2xkRAYpYQc5oxV7iRCsBO68zs58YL4hmudC0UCZL0xzlXp9UA7NnTl
   HTTLISmQcgZxy3iIVuYl7QDhui4U4yGr88xjo2JcarvMgEvH7sAwbkuyw
   Hwv5DQpxFm8gwhJChSvD60kor2/ikHEQe9irbvd5sAFtOuujrfq5+5bfC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="433037073"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="433037073"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 10:35:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="718511340"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="718511340"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 20 Jul 2023 10:35:28 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMXYk-0006KR-2R;
        Thu, 20 Jul 2023 17:35:26 +0000
Date:   Fri, 21 Jul 2023 01:35:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Subject: include/linux/compiler_types.h:328:45: error: call to
 '__compiletime_assert_312' declared with attribute error: BUILD_BUG_ON
 failed: (PTRS_PER_PGD * sizeof(pgd_t)) > PAGE_SIZE
Message-ID: <202307210114.a8lhJ4rl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineet,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   46670259519f4ee4ab378dc014798aabe77c5057
commit: d9820ff76f95fa26d33e412254a89cd65b23142d ARC: mm: switch pgtable_t back to struct page *
date:   1 year, 11 months ago
config: arc-randconfig-r014-20230720 (https://download.01.org/0day-ci/archive/20230721/202307210114.a8lhJ4rl-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230721/202307210114.a8lhJ4rl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307210114.a8lhJ4rl-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/arc/mm/init.c:35:13: warning: no previous prototype for 'arc_get_mem_sz' [-Wmissing-prototypes]
      35 | long __init arc_get_mem_sz(void)
         |             ^~~~~~~~~~~~~~
   arch/arc/mm/init.c:88:13: warning: no previous prototype for 'setup_arch_memory' [-Wmissing-prototypes]
      88 | void __init setup_arch_memory(void)
         |             ^~~~~~~~~~~~~~~~~
   In file included from <command-line>:
   arch/arc/mm/init.c: In function 'mem_init':
>> include/linux/compiler_types.h:328:45: error: call to '__compiletime_assert_312' declared with attribute error: BUILD_BUG_ON failed: (PTRS_PER_PGD * sizeof(pgd_t)) > PAGE_SIZE
     328 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:309:25: note: in definition of macro '__compiletime_assert'
     309 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:328:9: note: in expansion of macro '_compiletime_assert'
     328 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   arch/arc/mm/init.c:193:9: note: in expansion of macro 'BUILD_BUG_ON'
     193 |         BUILD_BUG_ON((PTRS_PER_PGD * sizeof(pgd_t)) > PAGE_SIZE);
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_312 +328 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  314  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  315  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  316  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  317  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  318  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  319   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  320   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  321   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  322   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  323   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  324   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  325   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  326   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  327  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @328  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  329  

:::::: The code at line 328 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
