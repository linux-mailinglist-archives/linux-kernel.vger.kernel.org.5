Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27B97B5196
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbjJBLm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbjJBLmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:42:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DA793
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696246972; x=1727782972;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m9mE8NH7u2Rse4DbyyyqUn4RrCYgKc6Jbl5K35i1so0=;
  b=KnswlRguV+70QXxW9+vPLfibLpccb5S+ZWQGamvRHytUI8fV/bEW6iFA
   ueVMBPHWrFJiPnIrnO1DzaNTBdOrZ3eGPnebWtBRYBxm9esNkH1Ca6FE2
   Z6B/PNkrEysUUrbVDqWZQNoFhvEYfbbOYz0n13VjpMoCWQM9+2e981AJm
   OlKuXIQPLyNIDcQlJTGH3Xzb8tUeOwCom7MYeAHOtiBxwjgPvlhlfCLT9
   2D5X3Ud1xsNJx/OpaqrsdhO9OLYdBcWfqwvxK//+tYTnZvvb0FwTTH6kA
   T4hz4bZ4bSGM98Ud55sRnf74j8b6Ar7Sm9eKgznWMsGkxw0tI1qX5Pyhk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="379902237"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="379902237"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 04:42:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="1508264"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 02 Oct 2023 04:42:53 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnHK4-00061X-0L;
        Mon, 02 Oct 2023 11:42:48 +0000
Date:   Mon, 2 Oct 2023 19:42:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: drivers/clocksource/timer-ti-dm.c:947: warning: Function parameter
 or member 'cookie' not described in 'omap_dm_timer_set_int_disable'
Message-ID: <202310021902.Uqcr69hR-lkp@intel.com>
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

Hi Tony,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
commit: a6e543f61531b63bfc8d43053c6ec6f65117f627 clocksource/drivers/timer-ti-dm: Move struct omap_dm_timer fields to driver
date:   1 year ago
config: arm-defconfig (https://download.01.org/0day-ci/archive/20231002/202310021902.Uqcr69hR-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231002/202310021902.Uqcr69hR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310021902.Uqcr69hR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clocksource/timer-ti-dm.c:191: warning: Function parameter or member 'val' not described in 'dmtimer_write'
   drivers/clocksource/timer-ti-dm.c:191: warning: Excess function parameter 'value' description in 'dmtimer_write'
>> drivers/clocksource/timer-ti-dm.c:947: warning: Function parameter or member 'cookie' not described in 'omap_dm_timer_set_int_disable'
>> drivers/clocksource/timer-ti-dm.c:947: warning: Excess function parameter 'timer' description in 'omap_dm_timer_set_int_disable'


vim +947 drivers/clocksource/timer-ti-dm.c

92105bb70634ab arch/arm/plat-omap/dmtimer.c      Tony Lindgren 2005-09-07  938  
4249d96ca35a76 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  939  /**
4249d96ca35a76 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  940   * omap_dm_timer_set_int_disable - disable timer interrupts
4249d96ca35a76 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  941   * @timer:	pointer to timer handle
4249d96ca35a76 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  942   * @mask:	bit mask of interrupts to be disabled
4249d96ca35a76 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  943   *
4249d96ca35a76 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  944   * Disables the specified timer interrupts for a timer.
4249d96ca35a76 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  945   */
a6e543f61531b6 drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  946  static int omap_dm_timer_set_int_disable(struct omap_dm_timer *cookie, u32 mask)
4249d96ca35a76 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13 @947  {
a6e543f61531b6 drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  948  	struct dmtimer *timer;
bd351f1aee21ca drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  949  	struct device *dev;
4249d96ca35a76 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  950  	u32 l = mask;
bd351f1aee21ca drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  951  	int rc;
4249d96ca35a76 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  952  
a6e543f61531b6 drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  953  	timer = to_dmtimer(cookie);
4249d96ca35a76 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  954  	if (unlikely(!timer))
4249d96ca35a76 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  955  		return -EINVAL;
4249d96ca35a76 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  956  
bd351f1aee21ca drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  957  	dev = &timer->pdev->dev;
bd351f1aee21ca drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  958  	rc = pm_runtime_resume_and_get(dev);
bd351f1aee21ca drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  959  	if (rc)
bd351f1aee21ca drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  960  		return rc;
4249d96ca35a76 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  961  
4249d96ca35a76 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  962  	if (timer->revision == 1)
f32bdac10cb5f4 drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  963  		l = dmtimer_read(timer, timer->irq_ena) & ~mask;
4249d96ca35a76 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  964  
f32bdac10cb5f4 drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  965  	dmtimer_write(timer, timer->irq_dis, l);
90c9aada19606a drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  966  	l = dmtimer_read(timer, OMAP_TIMER_WAKEUP_EN_REG) & ~mask;
49cd16bb573e43 drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  967  	dmtimer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
4249d96ca35a76 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  968  
bd351f1aee21ca drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  969  	pm_runtime_put_sync(dev);
bd351f1aee21ca drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  970  
4249d96ca35a76 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  971  	return 0;
4249d96ca35a76 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  972  }
4249d96ca35a76 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  973  

:::::: The code at line 947 was first introduced by commit
:::::: 4249d96ca35a765c25a70b7d29df5b6d80987c7f ARM: OMAP: Add dmtimer interrupt disable function

:::::: TO: Jon Hunter <jon-hunter@ti.com>
:::::: CC: Jon Hunter <jon-hunter@ti.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
