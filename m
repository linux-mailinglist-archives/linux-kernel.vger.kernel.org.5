Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3EF7D56FB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343942AbjJXP4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjJXP4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:56:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584D483;
        Tue, 24 Oct 2023 08:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698162971; x=1729698971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vKnb1pkNJBElrMmDQTHLa1aDlzaoDjjjnmPUwHZ2DCQ=;
  b=fR1+966oyMe27JENygpQCYY/iOIYaDzruOOgm9V5pWQxi+mG4W8x85/a
   d6uMT9VQ3USCZw5WzqFXXyM964O7NxpGaPiEpuAlAxrZJw1tlDOk7LaRw
   M1VSmPXqhmyEz6BGAUXvr0hQy4c+RAA38unc07nO408L8LY87a47p9Tus
   hYkT26GhCyXyY+lOLXVr4FOpbgmOL05i/5bXpzo3/3HNyj/KNgQyBpJ66
   6X4cEJHyqk+K+5l9dVRsqefuJmU0SizIZyz47fUJUlzKJ0mb9cx5+iRvJ
   yk/vVMMUwsaZz/+FIoWHQb+z7O712fVweYI3Inqnl4GVNS3/EJB23ENRQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="5719672"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="5719672"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:56:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="758510352"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="758510352"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Oct 2023 08:56:07 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvJlF-0007yL-1n;
        Tue, 24 Oct 2023 15:56:05 +0000
Date:   Tue, 24 Oct 2023 23:55:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     fenghui <fenghui@nfschina.com>, wim@linux-watchdog.org,
        linux@roeck-us.net
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        fenghui <fenghui@nfschina.com>
Subject: Re: [PATCH] watchdog_dev: =?utf-8?Q?Remove?=
 =?utf-8?B?IHVubmVjZXNzYXJ5IOKAmDDigJk=?= values from err
Message-ID: <202310242358.POvbqd5T-lkp@intel.com>
References: <20231021110538.441-1-fenghui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231021110538.441-1-fenghui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi fenghui,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc7 next-20231024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/fenghui/watchdog_dev-Remove-unnecessary-0-values-from-err/20231021-190730
base:   linus/master
patch link:    https://lore.kernel.org/r/20231021110538.441-1-fenghui%40nfschina.com
patch subject: [PATCH] watchdog_dev: Remove unnecessary ‘0’ values from err
config: arm-omap1_defconfig (https://download.01.org/0day-ci/archive/20231024/202310242358.POvbqd5T-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231024/202310242358.POvbqd5T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310242358.POvbqd5T-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/watchdog/watchdog_dev.c:305:6: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     305 |         if (wdd->ops->stop) {
         |             ^~~~~~~~~~~~~~
   drivers/watchdog/watchdog_dev.c:313:6: note: uninitialized use occurs here
     313 |         if (err == 0) {
         |             ^~~
   drivers/watchdog/watchdog_dev.c:305:2: note: remove the 'if' if its condition is always true
     305 |         if (wdd->ops->stop) {
         |         ^~~~~~~~~~~~~~~~~~~~
     306 |                 clear_bit(WDOG_HW_RUNNING, &wdd->status);
     307 |                 err = wdd->ops->stop(wdd);
     308 |                 trace_watchdog_stop(wdd, err);
     309 |         } else {
         |          ~~~~~~~
     310 |                 set_bit(WDOG_HW_RUNNING, &wdd->status);
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     311 |         }
         | ~~~~~~~~~
   drivers/watchdog/watchdog_dev.c:294:9: note: initialize the variable 'err' to silence this warning
     294 |         int err;
         |                ^
         |                 = 0
   1 warning generated.


vim +305 drivers/watchdog/watchdog_dev.c

234445b4e4542f Wim Van Sebroeck           2011-07-22  281  
234445b4e4542f Wim Van Sebroeck           2011-07-22  282  /*
ba6c89ab3b5878 Daniel Bristot de Oliveira 2022-02-11  283   * watchdog_stop - wrapper to stop the watchdog
ba6c89ab3b5878 Daniel Bristot de Oliveira 2022-02-11  284   * @wdd: The watchdog device to stop
b4ffb1909843b2 Guenter Roeck              2015-12-25  285   *
234445b4e4542f Wim Van Sebroeck           2011-07-22  286   * Stop the watchdog if it is still active and unmark it active.
7e192b9c4234d2 Wim Van Sebroeck           2011-07-22  287   * If the 'nowayout' feature was set, the watchdog cannot be stopped.
ba6c89ab3b5878 Daniel Bristot de Oliveira 2022-02-11  288   * The caller must hold wd_data->lock.
ba6c89ab3b5878 Daniel Bristot de Oliveira 2022-02-11  289   *
ba6c89ab3b5878 Daniel Bristot de Oliveira 2022-02-11  290   * Return: 0 on success or a negative errno code for failure.
234445b4e4542f Wim Van Sebroeck           2011-07-22  291   */
bc794ac3b5836e Guenter Roeck              2015-09-29  292  static int watchdog_stop(struct watchdog_device *wdd)
234445b4e4542f Wim Van Sebroeck           2011-07-22  293  {
585c761ac0ef85 fenghui                    2023-10-21  294  	int err;
e907df32725204 Hans de Goede              2012-05-22  295  
bc794ac3b5836e Guenter Roeck              2015-09-29  296  	if (!watchdog_active(wdd))
b4ffb1909843b2 Guenter Roeck              2015-12-25  297  		return 0;
7e192b9c4234d2 Wim Van Sebroeck           2011-07-22  298  
bc794ac3b5836e Guenter Roeck              2015-09-29  299  	if (test_bit(WDOG_NO_WAY_OUT, &wdd->status)) {
0254e953537c92 Guenter Roeck              2016-01-03  300  		pr_info("watchdog%d: nowayout prevents watchdog being stopped!\n",
0254e953537c92 Guenter Roeck              2016-01-03  301  			wdd->id);
b4ffb1909843b2 Guenter Roeck              2015-12-25  302  		return -EBUSY;
7e192b9c4234d2 Wim Van Sebroeck           2011-07-22  303  	}
234445b4e4542f Wim Van Sebroeck           2011-07-22  304  
3c10bbde10fe4d Guenter Roeck              2016-07-21 @305  	if (wdd->ops->stop) {
3c10bbde10fe4d Guenter Roeck              2016-07-21  306  		clear_bit(WDOG_HW_RUNNING, &wdd->status);
bc794ac3b5836e Guenter Roeck              2015-09-29  307  		err = wdd->ops->stop(wdd);
e25b091bed4946 Uwe Kleine-König           2022-10-08  308  		trace_watchdog_stop(wdd, err);
3c10bbde10fe4d Guenter Roeck              2016-07-21  309  	} else {
d0684c8a935495 Guenter Roeck              2016-02-28  310  		set_bit(WDOG_HW_RUNNING, &wdd->status);
3c10bbde10fe4d Guenter Roeck              2016-07-21  311  	}
d0684c8a935495 Guenter Roeck              2016-02-28  312  
664a39236e718f Guenter Roeck              2016-02-28  313  	if (err == 0) {
bc794ac3b5836e Guenter Roeck              2015-09-29  314  		clear_bit(WDOG_ACTIVE, &wdd->status);
ee142889e32f56 Guenter Roeck              2016-02-28  315  		watchdog_update_worker(wdd);
7b7d2fdc8c3e3f Curtis Klein               2021-02-03  316  		watchdog_hrtimer_pretimeout_stop(wdd);
664a39236e718f Guenter Roeck              2016-02-28  317  	}
7a87982420e5e1 Hans de Goede              2012-05-22  318  
234445b4e4542f Wim Van Sebroeck           2011-07-22  319  	return err;
7a87982420e5e1 Hans de Goede              2012-05-22  320  }
234445b4e4542f Wim Van Sebroeck           2011-07-22  321  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
