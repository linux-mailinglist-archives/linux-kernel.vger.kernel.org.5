Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433AE755AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 06:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjGQEn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 00:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGQEny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 00:43:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163D1E52
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 21:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689569033; x=1721105033;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jEZNzbhvk0iVBgdyuqQG25AdbOBeE2ZROjZsk8pPgW8=;
  b=U99qEid2RUlhjRDm0lhVtwIRkbSGq0r/ty+Xv3mn8L+m9kzmwqA27AF/
   KIj61xdcRCGPTWHjNP1y1MoFW/33ulYODU9UQc7/gQAGOBDfMJCul1w99
   xiWVnZLE3YR3pJdknCNAEvpiw0wX73w735KOcSWZHYIwpdGs1+b0qJr0J
   wlYlj0FBIx/jhKfS+2rNkbmmIXPkO4Y3cEPBivtBvQxlxuqCVDBTF8yP2
   I8Mm/mhVzyGwpA4LbFGLsGbuluswHGuVbapUEnfRzKbJ3tnWlVC9pHcvJ
   F5SDmlUR2UDMrvsVcGkBZ/ia4cOEY9IC3XGPisUYfZ1WME4LiZoV2VvFL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="452218752"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="452218752"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 21:43:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="866595407"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jul 2023 21:43:43 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qLG5G-0009C8-0m;
        Mon, 17 Jul 2023 04:43:42 +0000
Date:   Mon, 17 Jul 2023 12:42:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: lib/test_bitmap.c:920:2: error: call to __compiletime_assert_348
 declared with 'error' attribute: BUILD_BUG_ON failed:
 !__builtin_constant_p(res)
Message-ID: <202307171254.yFcH97ej-lkp@intel.com>
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

Hi Alexander,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fdf0eaf11452d72945af31804e2a1048ee1b574c
commit: dc34d5036692c614eef23c1130ee42a201c316bf lib: test_bitmap: add compile-time optimization/evaluations assertions
date:   1 year, 1 month ago
config: arm64-randconfig-r031-20230717 (https://download.01.org/0day-ci/archive/20230717/202307171254.yFcH97ej-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20230717/202307171254.yFcH97ej-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307171254.yFcH97ej-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/test_bitmap.c:920:2: error: call to __compiletime_assert_348 declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(res)
           BUILD_BUG_ON(!__builtin_constant_p(res));
           ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
           BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
           ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:352:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:340:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:333:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:287:1: note: expanded from here
   __compiletime_assert_348
   ^
   1 error generated.


vim +/error +920 lib/test_bitmap.c

   871	
   872	static void __init test_bitmap_const_eval(void)
   873	{
   874		DECLARE_BITMAP(bitmap, BITS_PER_LONG);
   875		unsigned long initvar = BIT(2);
   876		unsigned long bitopvar = 0;
   877		unsigned long var = 0;
   878		int res;
   879	
   880		/*
   881		 * Compilers must be able to optimize all of those to compile-time
   882		 * constants on any supported optimization level (-O2, -Os) and any
   883		 * architecture. Otherwise, trigger a build bug.
   884		 * The whole function gets optimized out then, there's nothing to do
   885		 * in runtime.
   886		 */
   887	
   888		/*
   889		 * Equals to `unsigned long bitmap[1] = { GENMASK(6, 5), }`.
   890		 * Clang on s390 optimizes bitops at compile-time as intended, but at
   891		 * the same time stops treating @bitmap and @bitopvar as compile-time
   892		 * constants after regular test_bit() is executed, thus triggering the
   893		 * build bugs below. So, call const_test_bit() there directly until
   894		 * the compiler is fixed.
   895		 */
   896		bitmap_clear(bitmap, 0, BITS_PER_LONG);
   897	#if defined(__s390__) && defined(__clang__)
   898		if (!const_test_bit(7, bitmap))
   899	#else
   900		if (!test_bit(7, bitmap))
   901	#endif
   902			bitmap_set(bitmap, 5, 2);
   903	
   904		/* Equals to `unsigned long bitopvar = BIT(20)` */
   905		__change_bit(31, &bitopvar);
   906		bitmap_shift_right(&bitopvar, &bitopvar, 11, BITS_PER_LONG);
   907	
   908		/* Equals to `unsigned long var = BIT(25)` */
   909		var |= BIT(25);
   910		if (var & BIT(0))
   911			var ^= GENMASK(9, 6);
   912	
   913		/* __const_hweight<32|64>(GENMASK(6, 5)) == 2 */
   914		res = bitmap_weight(bitmap, 20);
   915		BUILD_BUG_ON(!__builtin_constant_p(res));
   916		BUILD_BUG_ON(res != 2);
   917	
   918		/* !(BIT(31) & BIT(18)) == 1 */
   919		res = !test_bit(18, &bitopvar);
 > 920		BUILD_BUG_ON(!__builtin_constant_p(res));
   921		BUILD_BUG_ON(!res);
   922	
   923		/* BIT(2) & GENMASK(14, 8) == 0 */
   924		res = initvar & GENMASK(14, 8);
   925		BUILD_BUG_ON(!__builtin_constant_p(res));
   926		BUILD_BUG_ON(res);
   927	
   928		/* ~BIT(25) */
   929		BUILD_BUG_ON(!__builtin_constant_p(~var));
   930		BUILD_BUG_ON(~var != ~BIT(25));
   931	}
   932	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
