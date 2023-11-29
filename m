Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19927FE41A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343610AbjK2XPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK2XPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:15:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA60AA2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701299717; x=1732835717;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oshx3fgiU+1xnFMMtoAuzWS1fyMm+0Zwhw8f8FuPRgk=;
  b=R/7qXNE1sUR5Z3JFy3MyQUIXQHVvgFxdCgmx3sWjzNKY0zAD9LxQeJyg
   krwjj14QmkkqkbvX1RMR7VU9ZTeB2xnHHEC4ZnLxdsPj3aSiQkzm/zOSR
   IOSFJsFUpxnuarZDBxr1Vzt7ix3zN92RV41NZxzfxqW8eYEL3/QRsh89B
   FjMrpS7pWlgAfGWRm4dfijEy229gvnV3X/AIM7NAxdC+zgevuodV9guky
   VZstvlO9XE93WsW43bROYVe2h+r+onRh1PG99RIIi41DT13zaEMmVWbiG
   Ymkvn42MaWijYazQZtspBD2XyR5rKEbZ87A6A82ZI8AIDgVk9y/1d1rMh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="397133085"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="397133085"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 15:15:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="839601027"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="839601027"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Nov 2023 15:15:15 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8Tlx-00014M-1x;
        Wed, 29 Nov 2023 23:15:13 +0000
Date:   Thu, 30 Nov 2023 07:14:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: kernel/time/hrtimer.c:1876:20: error: unused function
 '__hrtimer_peek_ahead_timers'
Message-ID: <202311300441.Pn3mlj4p-lkp@intel.com>
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
head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
commit: 5c0930ccaad5a74d74e8b18b648c5eb21ed2fe94 hrtimers: Push pending hrtimers away from outgoing CPU earlier
date:   3 weeks ago
config: x86_64-sof-customedconfig-fuzz-defconfig (https://download.01.org/0day-ci/archive/20231130/202311300441.Pn3mlj4p-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311300441.Pn3mlj4p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311300441.Pn3mlj4p-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/time/hrtimer.c:147:20: error: unused function 'is_migration_base' [-Werror,-Wunused-function]
   static inline bool is_migration_base(struct hrtimer_clock_base *base)
                      ^
>> kernel/time/hrtimer.c:1876:20: error: unused function '__hrtimer_peek_ahead_timers' [-Werror,-Wunused-function]
   static inline void __hrtimer_peek_ahead_timers(void)
                      ^
   2 errors generated.


vim +/__hrtimer_peek_ahead_timers +1876 kernel/time/hrtimer.c

54cdfdb47f73b5 kernel/hrtimer.c      Thomas Gleixner   2007-02-16  1874  
016da20148a169 kernel/time/hrtimer.c Stephen Boyd      2017-03-16  1875  /* called with interrupts disabled */
c6eb3f70d44828 kernel/time/hrtimer.c Thomas Gleixner   2015-04-14 @1876  static inline void __hrtimer_peek_ahead_timers(void)
8bdec955b0da2f kernel/hrtimer.c      Thomas Gleixner   2009-01-05  1877  {
8bdec955b0da2f kernel/hrtimer.c      Thomas Gleixner   2009-01-05  1878  	struct tick_device *td;
8bdec955b0da2f kernel/hrtimer.c      Thomas Gleixner   2009-01-05  1879  
8bdec955b0da2f kernel/hrtimer.c      Thomas Gleixner   2009-01-05  1880  	if (!hrtimer_hres_active())
8bdec955b0da2f kernel/hrtimer.c      Thomas Gleixner   2009-01-05  1881  		return;
8bdec955b0da2f kernel/hrtimer.c      Thomas Gleixner   2009-01-05  1882  
22127e93c587af kernel/time/hrtimer.c Christoph Lameter 2014-08-17  1883  	td = this_cpu_ptr(&tick_cpu_device);
8bdec955b0da2f kernel/hrtimer.c      Thomas Gleixner   2009-01-05  1884  	if (td && td->evtdev)
8bdec955b0da2f kernel/hrtimer.c      Thomas Gleixner   2009-01-05  1885  		hrtimer_interrupt(td->evtdev);
8bdec955b0da2f kernel/hrtimer.c      Thomas Gleixner   2009-01-05  1886  }
8bdec955b0da2f kernel/hrtimer.c      Thomas Gleixner   2009-01-05  1887  

:::::: The code at line 1876 was first introduced by commit
:::::: c6eb3f70d4482806dc2d3e1e3c7736f497b1d418 hrtimer: Get rid of hrtimer softirq

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
