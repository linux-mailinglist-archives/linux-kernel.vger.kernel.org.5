Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BFA77F3CC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349839AbjHQJrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349826AbjHQJql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:46:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0102D57
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692265600; x=1723801600;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YkyEet77dp9TRcLjhi3o3OaysEk4Qjd1sFd+7OcePgU=;
  b=I+WXa7PXGW0k0rBgl2QoiQoiErRVacqSETf4F02oUkPtZRVM+VSwEa0o
   YonBHK10fXj/CPNSgEGJM/sNlJXzSeFik5OHN0rwGAj5eRBGHWQW590i7
   Ntn2jYd/JAfOYIYkzHwH+h/KTsDiO11esmQ6wQpMlvz3lu0eWWUuYI4+Q
   Md4wY2qr5zjfxHaVq4hhu9y2il480jxxDMbOZBaWSUemG9+G9iPaBL4zm
   /3RWqhxVwJEvIirPBGpdns9OhPksVcJXVKE4hp1UtNRSg9zG6UQDFN+gs
   h1E+hCBX4BVu2ydEkLDyiHHggag/45QK6a5Z5iG5cFwsIHnKTvNuIC503
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="370232645"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="370232645"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 02:46:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="1065177725"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="1065177725"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2023 02:46:35 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWZaM-00010r-2q;
        Thu, 17 Aug 2023 09:46:34 +0000
Date:   Thu, 17 Aug 2023 17:45:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Marco Elver <elver@google.com>
Subject: mm/kasan/kasan_test.c:114: warning: Function parameter or member
 'test' not described in 'KUNIT_EXPECT_KASAN_FAIL'
Message-ID: <202308171757.7V5YUcje-lkp@intel.com>
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

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: f7e01ab828fd4bf6d25b1f143a3994241e8572bf kasan: move tests to mm/kasan/
date:   11 months ago
config: x86_64-rhel-8.3-kunit (https://download.01.org/0day-ci/archive/20230817/202308171757.7V5YUcje-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171757.7V5YUcje-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171757.7V5YUcje-lkp@intel.com/

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
