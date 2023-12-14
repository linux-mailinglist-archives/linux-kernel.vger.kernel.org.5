Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B7C813A70
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573202AbjLNTCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 14:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNTCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 14:02:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0FA10E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 11:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702580548; x=1734116548;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6PUMFCKy5rUwaQ3rE8TRKOBhqSE6XK+cMxtD5pFiIGA=;
  b=B4CfJmxscymgELKKhxiPdoXQF69IQxyv3D/0cRRTFFK+EQHl0NtaXqXw
   uwvgk9gdjHV1tb5bzkthz1IJiWPhDMCw7pIgD6D16Y1gxZ8jCSrtBJXhs
   6ix1veGXZfkw0mcOzbItFHuVCkZZwBdD1ZYHeE4OzMP5A+7/mTLiR3o+v
   HmHyvv+ahBIQivA7I291AZQCJuNCHUNi115uKJ0mMjKlOAIGnAodw96KO
   LywaFM1ZnzzbmtiwPAnvpGBFQOzjf5p1ujuo6hvaC0Piu5oyhFXml/LNc
   HP3bp/nLuC+oKwquCD7P3kWSYgM3Lqf+hNdx2+0rXSmxpw8MKGjvWZ96A
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="461635081"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="461635081"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 11:02:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="844835880"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="844835880"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 14 Dec 2023 11:02:07 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDqyC-000MVE-1x;
        Thu, 14 Dec 2023 19:02:04 +0000
Date:   Fri, 15 Dec 2023 03:01:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: lib/test_kmod.c:134: warning: Excess struct member 'thread_lock'
 description in 'kmod_test_device'
Message-ID: <202312150205.NY5AKrJM-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: c093a74dac1c008daee92d6d613e9e3fe20b6585 test_kmod: stop kernel-doc warnings
date:   11 months ago
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20231215/202312150205.NY5AKrJM-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150205.NY5AKrJM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150205.NY5AKrJM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   lib/test_kmod.c:67: warning: Enum value '__TEST_KMOD_INVALID' not described in enum 'kmod_test_case'
   lib/test_kmod.c:67: warning: Enum value '__TEST_KMOD_MAX' not described in enum 'kmod_test_case'
   lib/test_kmod.c:100: warning: Function parameter or member 'task_sync' not described in 'kmod_test_device_info'
   lib/test_kmod.c:134: warning: Function parameter or member 'thread_mutex' not described in 'kmod_test_device'
>> lib/test_kmod.c:134: warning: Excess struct member 'thread_lock' description in 'kmod_test_device'


vim +134 lib/test_kmod.c

d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  101  
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  102  /**
c093a74dac1c00 Randy Dunlap      2023-01-02  103   * struct kmod_test_device - test device to help test kmod
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  104   *
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  105   * @dev_idx: unique ID for test device
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  106   * @config: configuration for the test
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  107   * @misc_dev: we use a misc device under the hood
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  108   * @dev: pointer to misc_dev's own struct device
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  109   * @config_mutex: protects configuration of test
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  110   * @trigger_mutex: the test trigger can only be fired once at a time
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  111   * @thread_lock: protects @done count, and the @info per each thread
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  112   * @done: number of threads which have completed or failed
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  113   * @test_is_oom: when we run out of memory, use this to halt moving forward
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  114   * @kthreads_done: completion used to signal when all work is done
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  115   * @list: needed to be part of the reg_test_devs
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  116   * @info: array of info for each thread
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  117   */
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  118  struct kmod_test_device {
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  119  	int dev_idx;
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  120  	struct test_config config;
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  121  	struct miscdevice misc_dev;
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  122  	struct device *dev;
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  123  	struct mutex config_mutex;
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  124  	struct mutex trigger_mutex;
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  125  	struct mutex thread_mutex;
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  126  
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  127  	unsigned int done;
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  128  
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  129  	bool test_is_oom;
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  130  	struct completion kthreads_done;
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  131  	struct list_head list;
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  132  
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  133  	struct kmod_test_device_info *info;
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14 @134  };
d9c6a72d6fa29d Luis R. Rodriguez 2017-07-14  135  

:::::: The code at line 134 was first introduced by commit
:::::: d9c6a72d6fa29d3a7999dda726577e5d1fccafa5 kmod: add test driver to stress test the module loader

:::::: TO: Luis R. Rodriguez <mcgrof@kernel.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
