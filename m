Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1007BBDEB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjJFRoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjJFRo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:44:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38102AD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 10:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696614267; x=1728150267;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VhHENdpgY+sILTg2ivPgyRFZ3jNbhscJkyL8yBGyQjU=;
  b=bVPS2ODcUx4nqbEKfsvQmzWjWfiXHh7vJPJHJbrRC+GNZrM6fvCA0MMQ
   JpOblSOM2MHDSm6I8F8QwkuFJDkb4IoKpfPMp2ebDIOxBHKKzlC29VmMA
   VLkIMEXyHT4HKUl1VFE6cItN4HbOSgRDIXOk0xhU+/JOHxDRNXjCpnK8r
   WfluKQ0zv7KqItra81ZI5TYY3pPAfYDbdkPEK0+7YJQ78LjShPHl+OS/Q
   SxzNIcM4IevJeWrqlpZPp3n4eg/s9i9aSLHA0I7+fLR4/mqJE7PmmN86t
   OfQiIiDfOJFVDkKQXFMEA9R+RNYqmbkdanleePP3/gZ/9pOTqZOwftmbi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="2399415"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="2399415"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 10:44:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="868417795"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="868417795"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Oct 2023 10:44:25 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoosA-0003U7-2k;
        Fri, 06 Oct 2023 17:44:22 +0000
Date:   Sat, 7 Oct 2023 01:43:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: arch/arm/mach-omap1/timer32k.c:186: warning: cannot understand
 function prototype: 'struct timespec64 persistent_ts; '
Message-ID: <202310070106.8QSyJOm3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   af95dc6fdc25e616051d0234aad638e15c02ec8f
commit: d379e8899a8da1041c347ae5b792773c48a559a9 ARM: omap1: move 32k counter from plat-omap to mach-omap1
date:   1 year, 6 months ago
config: arm-omap1_defconfig (https://download.01.org/0day-ci/archive/20231007/202310070106.8QSyJOm3-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310070106.8QSyJOm3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310070106.8QSyJOm3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm/mach-omap1/timer32k.c:186: warning: cannot understand function prototype: 'struct timespec64 persistent_ts; '
>> arch/arm/mach-omap1/timer32k.c:216: warning: Function parameter or member 'vbase' not described in 'omap_init_clocksource_32k'
>> arch/arm/mach-omap1/timer32k.c:216: warning: Excess function parameter 'pbase' description in 'omap_init_clocksource_32k'
>> arch/arm/mach-omap1/timer32k.c:216: warning: Excess function parameter 'size' description in 'omap_init_clocksource_32k'


vim +186 arch/arm/mach-omap1/timer32k.c

   178	
   179	/**
   180	 * omap_read_persistent_clock64 -  Return time from a persistent clock.
   181	 *
   182	 * Reads the time from a source which isn't disabled during PM, the
   183	 * 32k sync timer.  Convert the cycles elapsed since last read into
   184	 * nsecs and adds to a monotonically increasing timespec64.
   185	 */
 > 186	static struct timespec64 persistent_ts;
   187	static cycles_t cycles;
   188	static unsigned int persistent_mult, persistent_shift;
   189	
   190	static void omap_read_persistent_clock64(struct timespec64 *ts)
   191	{
   192		unsigned long long nsecs;
   193		cycles_t last_cycles;
   194	
   195		last_cycles = cycles;
   196		cycles = sync32k_cnt_reg ? readl_relaxed(sync32k_cnt_reg) : 0;
   197	
   198		nsecs = clocksource_cyc2ns(cycles - last_cycles,
   199						persistent_mult, persistent_shift);
   200	
   201		timespec64_add_ns(&persistent_ts, nsecs);
   202	
   203		*ts = persistent_ts;
   204	}
   205	
   206	/**
   207	 * omap_init_clocksource_32k - setup and register counter 32k as a
   208	 * kernel clocksource
   209	 * @pbase: base addr of counter_32k module
   210	 * @size: size of counter_32k to map
   211	 *
   212	 * Returns 0 upon success or negative error code upon failure.
   213	 *
   214	 */
   215	int __init omap_init_clocksource_32k(void __iomem *vbase)
 > 216	{
   217		int ret;
   218	
   219		/*
   220		 * 32k sync Counter IP register offsets vary between the
   221		 * highlander version and the legacy ones.
   222		 * The 'SCHEME' bits(30-31) of the revision register is used
   223		 * to identify the version.
   224		 */
   225		if (readl_relaxed(vbase + OMAP2_32KSYNCNT_REV_OFF) &
   226							OMAP2_32KSYNCNT_REV_SCHEME)
   227			sync32k_cnt_reg = vbase + OMAP2_32KSYNCNT_CR_OFF_HIGH;
   228		else
   229			sync32k_cnt_reg = vbase + OMAP2_32KSYNCNT_CR_OFF_LOW;
   230	
   231		/*
   232		 * 120000 rough estimate from the calculations in
   233		 * __clocksource_update_freq_scale.
   234		 */
   235		clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
   236				32768, NSEC_PER_SEC, 120000);
   237	
   238		ret = clocksource_mmio_init(sync32k_cnt_reg, "32k_counter", 32768,
   239					250, 32, clocksource_mmio_readl_up);
   240		if (ret) {
   241			pr_err("32k_counter: can't register clocksource\n");
   242			return ret;
   243		}
   244	
   245		sched_clock_register(omap_32k_read_sched_clock, 32, 32768);
   246		register_persistent_clock(omap_read_persistent_clock64);
   247		pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
   248	
   249		return 0;
   250	}
   251	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
