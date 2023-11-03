Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291397E04B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377873AbjKCOaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377818AbjKCOaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:30:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD245D49
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699021805; x=1730557805;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HD6L/TTZPofsJIc3Uh7UxtvYOFAP0PMrQQRN15wX65s=;
  b=RGdjISJCdYbJX/kb1m4cjFiADNtOs0x1rQUTCANRrbV07zMBGS1CgE6N
   nueE8eKJrieBkaLzFk8Tj9pFs745QFQ5TQl8+I8j8RvgJbQkT4AecBDuX
   Wm+TMSnPwGTF8EgYT3G1kmbh0dMqr6bC31B9bTqISA/QzthaRj58XVpXm
   2JkLZLThVv/66LR74s872NfXNn9ryt00Yibp7Zv+0+hvHuEMotHlHUF1j
   ea3uXVVwkmOzEPiphPZmK/LBZox2EpNa4rJBfk2ofcXw/9vWlnjDP+36c
   lO5u+VrVpYysv+Yxbij+m9T6FQJaGEc/fWasaNgMoV5yVJ+J0N4qdEj7L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="386122632"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="386122632"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 07:30:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="935121629"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="935121629"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 Nov 2023 07:30:02 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyvBQ-0002a0-2v;
        Fri, 03 Nov 2023 14:30:00 +0000
Date:   Fri, 3 Nov 2023 22:29:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: lib/test_kmod.c:100: warning: Function parameter or member
 'task_sync' not described in 'kmod_test_device_info'
Message-ID: <202311032240.w1q3ydGG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8f6f76a6a29f36d2f3e4510d0bde5046672f6924
commit: c093a74dac1c008daee92d6d613e9e3fe20b6585 test_kmod: stop kernel-doc warnings
date:   9 months ago
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20231103/202311032240.w1q3ydGG-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311032240.w1q3ydGG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311032240.w1q3ydGG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   lib/test_kmod.c:67: warning: Enum value '__TEST_KMOD_INVALID' not described in enum 'kmod_test_case'
   lib/test_kmod.c:67: warning: Enum value '__TEST_KMOD_MAX' not described in enum 'kmod_test_case'
>> lib/test_kmod.c:100: warning: Function parameter or member 'task_sync' not described in 'kmod_test_device_info'
   lib/test_kmod.c:134: warning: Function parameter or member 'thread_mutex' not described in 'kmod_test_device'


vim +100 lib/test_kmod.c

d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14   78  
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14   79  /**
c093a74dac1c00 Randy Dunlap      2023-01-02   80   * struct kmod_test_device_info - thread info
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14   81   *
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14   82   * @ret_sync: return value if request_module() is used, sync request for
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14   83   * 	@TEST_KMOD_DRIVER
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14   84   * @fs_sync: return value of get_fs_type() for @TEST_KMOD_FS_TYPE
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14   85   * @thread_idx: thread ID
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14   86   * @test_dev: test device test is being performed under
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14   87   * @need_mod_put: Some tests (get_fs_type() is one) requires putting the module
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14   88   *	(module_put(fs_sync->owner)) when done, otherwise you will not be able
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14   89   *	to unload the respective modules and re-test. We use this to keep
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14   90   *	accounting of when we need this and to help out in case we need to
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14   91   *	error out and deal with module_put() on error.
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14   92   */
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14   93  struct kmod_test_device_info {
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14   94  	int ret_sync;
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14   95  	struct file_system_type *fs_sync;
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14   96  	struct task_struct *task_sync;
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14   97  	unsigned int thread_idx;
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14   98  	struct kmod_test_device *test_dev;
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14   99  	bool need_mod_put;
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14 @100  };
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  101  

:::::: The code at line 100 was first introduced by commit
:::::: d9c6a72d6fa29d3a7999dda726577e5d1fccafa5 kmod: add test driver to stress test the module loader

:::::: TO: Luis R. Rodriguez <mcgrof@kernel.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
