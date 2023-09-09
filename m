Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D0F799795
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 13:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241827AbjIILMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 07:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjIILMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 07:12:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F495CF2
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 04:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694257936; x=1725793936;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qyKutLoZKoLOFpzk6XaecEIRNR5GF6ckDnIB3YFoW5Y=;
  b=EAtNoAIZrccIE/QTyDFPhw6wvWEhFqAfnuk86ZNgDieFPqhEINY/+o8Z
   DoQOUPn1VdbaBnnaL7sPXACssR0Nv+Q4jjW02XTyo2enISjXCPL5sP31P
   C85vh/k3GPNTAk6YIH1AebNGZeQdXk3gevY4lAXiKDeSGOJIrnd/kLHlY
   6Ka9aPPR2YLu583lBxmPEHfI2m2MnP5mr3/ItpYD8l4ApJH2H6Kzd+3IL
   Ov/5uzWMmUGEp21C2BV0AhgBoV+Re6vh6ai98BmpV2B9SglqWqoGiWcL+
   K9e0wH9TCScaTxM2kGslprHVFZ9QA9ApqtGTGajLbyqhxEPeXkqWVvdQ9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="357279308"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="357279308"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 04:12:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="812827421"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="812827421"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 Sep 2023 04:12:13 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qevsp-0003Oc-37;
        Sat, 09 Sep 2023 11:12:11 +0000
Date:   Sat, 9 Sep 2023 19:12:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Marco Elver <elver@google.com>
Subject: mm/kasan/kasan_test.c:114: warning: Function parameter or member
 'test' not described in 'KUNIT_EXPECT_KASAN_FAIL'
Message-ID: <202309091957.3t8zSfDw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6099776f9f268e61fe5ecd721f994a8cfce5306f
commit: f7e01ab828fd4bf6d25b1f143a3994241e8572bf kasan: move tests to mm/kasan/
date:   11 months ago
config: x86_64-randconfig-013-20230909 (https://download.01.org/0day-ci/archive/20230909/202309091957.3t8zSfDw-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309091957.3t8zSfDw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309091957.3t8zSfDw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/kasan/kasan_test.c:114: warning: Function parameter or member 'test' not described in 'KUNIT_EXPECT_KASAN_FAIL'
>> mm/kasan/kasan_test.c:114: warning: Function parameter or member 'expression' not described in 'KUNIT_EXPECT_KASAN_FAIL'


vim +114 mm/kasan/kasan_test.c

83c4e7a0363bdb lib/test_kasan.c Patricia Alfonso  2020-10-13   69  
83c4e7a0363bdb lib/test_kasan.c Patricia Alfonso  2020-10-13   70  /**
0fd379253691e7 lib/test_kasan.c Andrey Konovalov  2021-02-24   71   * KUNIT_EXPECT_KASAN_FAIL() - check that the executed expression produces a
0fd379253691e7 lib/test_kasan.c Andrey Konovalov  2021-02-24   72   * KASAN report; causes a test failure otherwise. This relies on a KUnit
ed6d74446cbfb8 lib/test_kasan.c Andrey Konovalov  2022-03-24   73   * resource named "kasan_status". Do not use this name for KUnit resources
0fd379253691e7 lib/test_kasan.c Andrey Konovalov  2021-02-24   74   * outside of KASAN tests.
f05842cfb9ae25 lib/test_kasan.c Andrey Konovalov  2021-02-24   75   *
ed6d74446cbfb8 lib/test_kasan.c Andrey Konovalov  2022-03-24   76   * For hardware tag-based KASAN, when a synchronous tag fault happens, tag
e80a76aa1a9101 lib/test_kasan.c Andrey Konovalov  2021-03-15   77   * checking is auto-disabled. When this happens, this test handler reenables
e80a76aa1a9101 lib/test_kasan.c Andrey Konovalov  2021-03-15   78   * tag checking. As tag checking can be only disabled or enabled per CPU,
e80a76aa1a9101 lib/test_kasan.c Andrey Konovalov  2021-03-15   79   * this handler disables migration (preemption).
2e4bde6a1e3a3f lib/test_kasan.c Andrey Konovalov  2021-02-24   80   *
ed6d74446cbfb8 lib/test_kasan.c Andrey Konovalov  2022-03-24   81   * Since the compiler doesn't see that the expression can change the test_status
2e4bde6a1e3a3f lib/test_kasan.c Andrey Konovalov  2021-02-24   82   * fields, it can reorder or optimize away the accesses to those fields.
2e4bde6a1e3a3f lib/test_kasan.c Andrey Konovalov  2021-02-24   83   * Use READ/WRITE_ONCE() for the accesses and compiler barriers around the
2e4bde6a1e3a3f lib/test_kasan.c Andrey Konovalov  2021-02-24   84   * expression to prevent that.
99734b535d9bf8 lib/test_kasan.c Andrey Konovalov  2021-04-29   85   *
ed6d74446cbfb8 lib/test_kasan.c Andrey Konovalov  2022-03-24   86   * In between KUNIT_EXPECT_KASAN_FAIL checks, test_status.report_found is kept
ed6d74446cbfb8 lib/test_kasan.c Andrey Konovalov  2022-03-24   87   * as false. This allows detecting KASAN reports that happen outside of the
ed6d74446cbfb8 lib/test_kasan.c Andrey Konovalov  2022-03-24   88   * checks by asserting !test_status.report_found at the start of
ed6d74446cbfb8 lib/test_kasan.c Andrey Konovalov  2022-03-24   89   * KUNIT_EXPECT_KASAN_FAIL and in kasan_test_exit.
83c4e7a0363bdb lib/test_kasan.c Patricia Alfonso  2020-10-13   90   */
0fd379253691e7 lib/test_kasan.c Andrey Konovalov  2021-02-24   91  #define KUNIT_EXPECT_KASAN_FAIL(test, expression) do {			\
e80a76aa1a9101 lib/test_kasan.c Andrey Konovalov  2021-03-15   92  	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&				\
2d27e585147395 lib/test_kasan.c Vincenzo Frascino 2021-10-06   93  	    kasan_sync_fault_possible())				\
f05842cfb9ae25 lib/test_kasan.c Andrey Konovalov  2021-02-24   94  		migrate_disable();					\
ed6d74446cbfb8 lib/test_kasan.c Andrey Konovalov  2022-03-24   95  	KUNIT_EXPECT_FALSE(test, READ_ONCE(test_status.report_found));	\
2e4bde6a1e3a3f lib/test_kasan.c Andrey Konovalov  2021-02-24   96  	barrier();							\
0fd379253691e7 lib/test_kasan.c Andrey Konovalov  2021-02-24   97  	expression;							\
2e4bde6a1e3a3f lib/test_kasan.c Andrey Konovalov  2021-02-24   98  	barrier();							\
ed6d74446cbfb8 lib/test_kasan.c Andrey Konovalov  2022-03-24   99  	if (kasan_async_fault_possible())				\
ed6d74446cbfb8 lib/test_kasan.c Andrey Konovalov  2022-03-24  100  		kasan_force_async_fault();				\
ed6d74446cbfb8 lib/test_kasan.c Andrey Konovalov  2022-03-24  101  	if (!READ_ONCE(test_status.report_found)) {			\
3ff16d30f593d8 lib/test_kasan.c David Gow         2021-06-28  102  		KUNIT_FAIL(test, KUNIT_SUBTEST_INDENT "KASAN failure "	\
3ff16d30f593d8 lib/test_kasan.c David Gow         2021-06-28  103  				"expected in \"" #expression		\
3ff16d30f593d8 lib/test_kasan.c David Gow         2021-06-28  104  				 "\", but none occurred");		\
3ff16d30f593d8 lib/test_kasan.c David Gow         2021-06-28  105  	}								\
ed6d74446cbfb8 lib/test_kasan.c Andrey Konovalov  2022-03-24  106  	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&				\
ed6d74446cbfb8 lib/test_kasan.c Andrey Konovalov  2022-03-24  107  	    kasan_sync_fault_possible()) {				\
ed6d74446cbfb8 lib/test_kasan.c Andrey Konovalov  2022-03-24  108  		if (READ_ONCE(test_status.report_found) &&		\
ed6d74446cbfb8 lib/test_kasan.c Andrey Konovalov  2022-03-24  109  		    READ_ONCE(test_status.sync_fault))			\
ed6d74446cbfb8 lib/test_kasan.c Andrey Konovalov  2022-03-24  110  			kasan_enable_tagging();				\
f05842cfb9ae25 lib/test_kasan.c Andrey Konovalov  2021-02-24  111  		migrate_enable();					\
f05842cfb9ae25 lib/test_kasan.c Andrey Konovalov  2021-02-24  112  	}								\
ed6d74446cbfb8 lib/test_kasan.c Andrey Konovalov  2022-03-24  113  	WRITE_ONCE(test_status.report_found, false);			\
83c4e7a0363bdb lib/test_kasan.c Patricia Alfonso  2020-10-13 @114  } while (0)
83c4e7a0363bdb lib/test_kasan.c Patricia Alfonso  2020-10-13  115  

:::::: The code at line 114 was first introduced by commit
:::::: 83c4e7a0363bdb8104f510370907161623e31086 KUnit: KASAN Integration

:::::: TO: Patricia Alfonso <trishalfonso@google.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
