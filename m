Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9156A7E0B5A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377580AbjKCW7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjKCW7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:59:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C54418B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 15:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699052376; x=1730588376;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LceVb6KBLNXMY4syCICW54D9r3fewHjPYLQVI3TVSEU=;
  b=Svd5yTVf0++iv5nDPnXeo57um82nZ97PeleG1fwgu3fGII3g5RfgPT2Q
   NGPRDM9YE7knMZhrbshC1Qevq3J/pl1/UFsAR/Om5yRNU0t/Af6pZtNDD
   pv5eJy9YdUjO9qJy+aB/oubxOWyic0kEsqp5o8+vNNe57DWaEhNOYdJfv
   jKMXMTsUh7fPsKlkdfrZPpwwGARRSXvVZfqRRtxlwBaWNCj54YicYz1Nu
   A/N8c66ODbxL+QbrQIcPp+LJfN5lnAae+d8jRceo4a6Ma7qTXY+vjPSLa
   bKSMn3/kZCGisBvwDEyTiEKaRNIzLHz7nRV7ZFcGlIQ8p1FGkxRGDUeyX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="455526571"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="455526571"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 15:59:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="761761429"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="761761429"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 03 Nov 2023 15:59:33 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qz38V-000327-18;
        Fri, 03 Nov 2023 22:59:31 +0000
Date:   Sat, 4 Nov 2023 06:58:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: drivers/clocksource/timer-ti-dm.c:947: warning: Function parameter
 or member 'cookie' not described in 'omap_dm_timer_set_int_disable'
Message-ID: <202311040606.XL5OcR9O-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e392ea4d4d00880bf94550151b1ace4f88a4b17a
commit: a6e543f61531b63bfc8d43053c6ec6f65117f627 clocksource/drivers/timer-ti-dm: Move struct omap_dm_timer fields to driver
date:   1 year, 1 month ago
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20231104/202311040606.XL5OcR9O-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040606.XL5OcR9O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311040606.XL5OcR9O-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clocksource/timer-ti-dm.c:191: warning: Function parameter or member 'val' not described in 'dmtimer_write'
   drivers/clocksource/timer-ti-dm.c:191: warning: Excess function parameter 'value' description in 'dmtimer_write'
>> drivers/clocksource/timer-ti-dm.c:947: warning: Function parameter or member 'cookie' not described in 'omap_dm_timer_set_int_disable'
   drivers/clocksource/timer-ti-dm.c:947: warning: Excess function parameter 'timer' description in 'omap_dm_timer_set_int_disable'


vim +947 drivers/clocksource/timer-ti-dm.c

92105bb70634aba arch/arm/plat-omap/dmtimer.c      Tony Lindgren 2005-09-07  938  
4249d96ca35a765 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  939  /**
4249d96ca35a765 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  940   * omap_dm_timer_set_int_disable - disable timer interrupts
4249d96ca35a765 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  941   * @timer:	pointer to timer handle
4249d96ca35a765 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  942   * @mask:	bit mask of interrupts to be disabled
4249d96ca35a765 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  943   *
4249d96ca35a765 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  944   * Disables the specified timer interrupts for a timer.
4249d96ca35a765 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  945   */
a6e543f61531b63 drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  946  static int omap_dm_timer_set_int_disable(struct omap_dm_timer *cookie, u32 mask)
4249d96ca35a765 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13 @947  {
a6e543f61531b63 drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  948  	struct dmtimer *timer;
bd351f1aee21ca6 drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  949  	struct device *dev;
4249d96ca35a765 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  950  	u32 l = mask;
bd351f1aee21ca6 drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  951  	int rc;
4249d96ca35a765 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  952  
a6e543f61531b63 drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  953  	timer = to_dmtimer(cookie);
4249d96ca35a765 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  954  	if (unlikely(!timer))
4249d96ca35a765 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  955  		return -EINVAL;
4249d96ca35a765 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  956  
bd351f1aee21ca6 drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  957  	dev = &timer->pdev->dev;
bd351f1aee21ca6 drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  958  	rc = pm_runtime_resume_and_get(dev);
bd351f1aee21ca6 drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  959  	if (rc)
bd351f1aee21ca6 drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  960  		return rc;
4249d96ca35a765 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  961  
4249d96ca35a765 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  962  	if (timer->revision == 1)
f32bdac10cb5f46 drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  963  		l = dmtimer_read(timer, timer->irq_ena) & ~mask;
4249d96ca35a765 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  964  
f32bdac10cb5f46 drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  965  	dmtimer_write(timer, timer->irq_dis, l);
90c9aada19606ae drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  966  	l = dmtimer_read(timer, OMAP_TIMER_WAKEUP_EN_REG) & ~mask;
49cd16bb573e43d drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  967  	dmtimer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
4249d96ca35a765 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  968  
bd351f1aee21ca6 drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  969  	pm_runtime_put_sync(dev);
bd351f1aee21ca6 drivers/clocksource/timer-ti-dm.c Tony Lindgren 2022-08-15  970  
4249d96ca35a765 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  971  	return 0;
4249d96ca35a765 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  972  }
4249d96ca35a765 arch/arm/plat-omap/dmtimer.c      Jon Hunter    2012-07-13  973  

:::::: The code at line 947 was first introduced by commit
:::::: 4249d96ca35a765c25a70b7d29df5b6d80987c7f ARM: OMAP: Add dmtimer interrupt disable function

:::::: TO: Jon Hunter <jon-hunter@ti.com>
:::::: CC: Jon Hunter <jon-hunter@ti.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
