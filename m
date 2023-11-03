Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309AC7E0A65
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378345AbjKCUf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjKCUf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:35:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30914194
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 13:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699043754; x=1730579754;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fKAsYhrHKSpr69L5ydbmu9t1v9UJxzxdZxUAlwhfxDE=;
  b=WGvqP0pIQ0QEAm9iqI3oaspkBfhxNKNxlcLY0XL+qmkMEo4722Aiatnh
   1mr+IAn+N9tw2wH5lVsAO+eqbtGKbqOxsD6r0/SjH7BQE2oklMTDpdT6w
   2HQbqQ5vtL/gwbHBg9VriUwqo9u/uscb+rZ7qxcIlsvORARxQTlv5oZeL
   ORD3+QHvR/rtcXzf3KibqaCltyCHhsucZzuVcrV0+ya+s3gUOldDsYMX0
   IuNQIX3SgzSBGEQgQcJEF9w1OAmXfh7YpDv6lUtXT/LwJlE4W6NEdeMif
   OadlCnRVMmgK7feofqtwL1r9AVQ4KnqGZmvttTYbeaMquXu7tEYxUlTrR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="455506734"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="455506734"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 13:35:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="905453024"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="905453024"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 03 Nov 2023 13:35:51 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qz0tR-0002vA-27;
        Fri, 03 Nov 2023 20:35:49 +0000
Date:   Sat, 4 Nov 2023 04:35:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: drivers/clocksource/timer-ti-dm.c:82: warning: Excess function
 parameter 'value' description in 'dmtimer_write'
Message-ID: <202311040403.DzIiBuwU-lkp@intel.com>
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

Hi Tony,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8f6f76a6a29f36d2f3e4510d0bde5046672f6924
commit: 49cd16bb573e43dc2ee64d734b9b545475dbb35f clocksource/drivers/timer-ti-dm: Simplify register writes with dmtimer_write()
date:   1 year, 1 month ago
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20231104/202311040403.DzIiBuwU-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040403.DzIiBuwU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311040403.DzIiBuwU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clocksource/timer-ti-dm.c:82: warning: Function parameter or member 'val' not described in 'dmtimer_write'
>> drivers/clocksource/timer-ti-dm.c:82: warning: Excess function parameter 'value' description in 'dmtimer_write'


vim +82 drivers/clocksource/timer-ti-dm.c

41e79b1d4584772 Tony Lindgren 2022-04-08  70  
49cd16bb573e43d Tony Lindgren 2022-08-15  71  /**
49cd16bb573e43d Tony Lindgren 2022-08-15  72   * dmtimer_write - write timer registers in posted and non-posted mode
49cd16bb573e43d Tony Lindgren 2022-08-15  73   * @timer:      timer pointer over which write operation is to perform
49cd16bb573e43d Tony Lindgren 2022-08-15  74   * @reg:        lowest byte holds the register offset
49cd16bb573e43d Tony Lindgren 2022-08-15  75   * @value:      data to write into the register
49cd16bb573e43d Tony Lindgren 2022-08-15  76   *
49cd16bb573e43d Tony Lindgren 2022-08-15  77   * The posted mode bit is encoded in reg. Note that in posted mode, the write
49cd16bb573e43d Tony Lindgren 2022-08-15  78   * pending bit must be checked. Otherwise a write on a register which has a
49cd16bb573e43d Tony Lindgren 2022-08-15  79   * pending write will be lost.
49cd16bb573e43d Tony Lindgren 2022-08-15  80   */
49cd16bb573e43d Tony Lindgren 2022-08-15  81  static inline void dmtimer_write(struct omap_dm_timer *timer, u32 reg, u32 val)
41e79b1d4584772 Tony Lindgren 2022-04-08 @82  {
49cd16bb573e43d Tony Lindgren 2022-08-15  83  	u16 wp, offset;
49cd16bb573e43d Tony Lindgren 2022-08-15  84  
49cd16bb573e43d Tony Lindgren 2022-08-15  85  	wp = reg >> WPSHIFT;
49cd16bb573e43d Tony Lindgren 2022-08-15  86  	offset = reg & 0xff;
49cd16bb573e43d Tony Lindgren 2022-08-15  87  
49cd16bb573e43d Tony Lindgren 2022-08-15  88  	/* Wait for a possible write pending bit in posted mode */
49cd16bb573e43d Tony Lindgren 2022-08-15  89  	if (wp && timer->posted)
49cd16bb573e43d Tony Lindgren 2022-08-15  90  		while (readl_relaxed(timer->pend) & wp)
41e79b1d4584772 Tony Lindgren 2022-04-08  91  			cpu_relax();
41e79b1d4584772 Tony Lindgren 2022-04-08  92  
49cd16bb573e43d Tony Lindgren 2022-08-15  93  	writel_relaxed(val, timer->func_base + offset);
41e79b1d4584772 Tony Lindgren 2022-04-08  94  }
41e79b1d4584772 Tony Lindgren 2022-04-08  95  

:::::: The code at line 82 was first introduced by commit
:::::: 41e79b1d458477212d0a880c87622bcaa69ab3ea clocksource/drivers/timer-ti-dm: Move inline functions to driver for am6

:::::: TO: Tony Lindgren <tony@atomide.com>
:::::: CC: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
