Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F41A77F7F0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351565AbjHQNkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351560AbjHQNkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:40:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81F326BB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692279645; x=1723815645;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jh1jF8tvs1dvl8/2VePDXi0ZR2gJmtMjnTWqKbl8fEE=;
  b=hBxbpWaZvzNEpiD0miFAFO1QUeh75jYK9AALKzpL+1d0w0R7up5I9KUi
   Md65yL2RajugFZNCMg9iOPkSg5jCInReLrtfwX3QKh0tidAgzfYlehafY
   +5rZHCqqrktF5uazx0wC8xR9+QVrLD67gByCXgw8upflY4sYtdobxRz7g
   yMQQcninaXV+PxhZrsuhayp009IYveT/Z9S31nIKcVR66RXqpn3+QhYiI
   3ThGNg/MD269u6vV4h5ExUDiiOCcS9TMKpPfS+w1vEmMfRUT0/UxK0B4/
   F4SjJLbb/4y8z5C4P1QOpDbeSiiQLhk4DX+NOjiFoGbxSKbL1+rqLFK8u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371717252"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="371717252"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 06:40:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="908411150"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="908411150"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Aug 2023 06:40:43 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWdEw-0001Aw-1a;
        Thu, 17 Aug 2023 13:40:42 +0000
Date:   Thu, 17 Aug 2023 21:39:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: drivers/clocksource/timer-ti-dm.c:947: warning: Function parameter
 or member 'cookie' not described in 'omap_dm_timer_set_int_disable'
Message-ID: <202308172114.YF07ZKCd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: a6e543f61531b63bfc8d43053c6ec6f65117f627 clocksource/drivers/timer-ti-dm: Move struct omap_dm_timer fields to driver
date:   11 months ago
config: riscv-randconfig-r002-20230817 (https://download.01.org/0day-ci/archive/20230817/202308172114.YF07ZKCd-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308172114.YF07ZKCd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308172114.YF07ZKCd-lkp@intel.com/

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
