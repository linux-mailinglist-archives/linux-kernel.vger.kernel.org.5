Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECFF7E29ED
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjKFQhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjKFQhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:37:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B58191
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699288651; x=1730824651;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/lfKu8XpdrH0OH9ho02SRHTnkNIlLD6PMSQElwjYxIk=;
  b=CIQD4YoWHpiTRHdf/X+Ib+wogKdLxP5nH+ZqUthyI8A12/XWZcPvYMXp
   GYpSwpPnnmduvVhI+n2lgudrKG/ck2hrKz4hn067rWuFPoYKqwdiblUvi
   JFBgSUCNbv1UJkmB4wVKULuUjzE1WJZxhx6y+COnF+hAzGpuJhyFao3Am
   5RnlFxQg9v5Fg/w9hP9Va8C1xjgpzbaT2z9WEQ5E4mbgYTwawkpdDCG4O
   K43og13qy15ZdB03eY0pPWx2NdP5DqH052XhMZpS80j4+yHoCnLelAdCW
   OIVJ8SOPpxYzPoCQJlWGC7FXjNK6MLYkXUjkXEibYN8F+a2C9As3NVxRy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="393209666"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="393209666"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 08:37:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="885955668"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="885955668"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 06 Nov 2023 08:37:00 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r02av-0006Z1-2H;
        Mon, 06 Nov 2023 16:36:57 +0000
Date:   Tue, 7 Nov 2023 00:36:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>
Subject: lib/kunit/kunit-test.c:565:25: warning: cast from 'void (*)(const
 void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to
 incompatible function type
Message-ID: <202311070041.kWVYx7YP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2f51b3516dade79269ff45eae2a7668ae711b25
commit: 05e2006ce493cb6fb5e5b4b8317f82754dfa2b1e kunit: Use string_stream for test log
date:   7 weeks ago
config: hexagon-buildonly-randconfig-r002-20221027 (https://download.01.org/0day-ci/archive/20231107/202311070041.kWVYx7YP-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231107/202311070041.kWVYx7YP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311070041.kWVYx7YP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/kunit/kunit-test.c:565:25: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
           kunit_add_action(test, (kunit_action_t *)kfree, full_log);
                                  ^~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +565 lib/kunit/kunit-test.c

   545	
   546	static void kunit_log_test(struct kunit *test)
   547	{
   548		struct kunit_suite suite;
   549	#ifdef CONFIG_KUNIT_DEBUGFS
   550		char *full_log;
   551	#endif
   552		suite.log = kunit_alloc_string_stream(test, GFP_KERNEL);
   553		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
   554		string_stream_set_append_newlines(suite.log, true);
   555	
   556		kunit_log(KERN_INFO, test, "put this in log.");
   557		kunit_log(KERN_INFO, test, "this too.");
   558		kunit_log(KERN_INFO, &suite, "add to suite log.");
   559		kunit_log(KERN_INFO, &suite, "along with this.");
   560	
   561	#ifdef CONFIG_KUNIT_DEBUGFS
   562		KUNIT_EXPECT_TRUE(test, test->log->append_newlines);
   563	
   564		full_log = string_stream_get_string(test->log);
 > 565		kunit_add_action(test, (kunit_action_t *)kfree, full_log);
   566		KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
   567					     strstr(full_log, "put this in log."));
   568		KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
   569					     strstr(full_log, "this too."));
   570	
   571		full_log = string_stream_get_string(suite.log);
   572		kunit_add_action(test, kfree_wrapper, full_log);
   573		KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
   574					     strstr(full_log, "add to suite log."));
   575		KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
   576					     strstr(full_log, "along with this."));
   577	#else
   578		KUNIT_EXPECT_NULL(test, test->log);
   579	#endif
   580	}
   581	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
