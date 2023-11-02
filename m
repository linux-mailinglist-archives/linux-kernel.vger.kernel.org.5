Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723D27DEF97
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346275AbjKBKNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346103AbjKBKNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:13:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E807131
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 03:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698920025; x=1730456025;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tQ5B+IzOxqIEpgJ8NCqfmn8JnM+A6Sav/L1STDnF81w=;
  b=Nods9+60KfTeSkTJYzGpaolaGs5e/qlCujDjQCy5/uAnCdXhnnFc2kht
   PX5gAWRAmeuMr2NHdK/Wqb3SYcuN1m4CfpnZFxdp9l4CUVDZrVGrA0jWw
   9ql5rFg0UzoK1U1nJ6/HQTXr9C9A8TH3Rgq+vzvjVD6c73he+rBZvvc0n
   Vlg0idlN2Xpf083zTOg8y1eSJSYHh3S9cm5gRZjEmcoTd8YbvImrTkjwp
   mALIuMubCT7s0NUhJIgi4j30Sd0meR1wl9/KVWIhKa+mPuDqYYVG4wx8j
   lC+a3jZ2hQPoTcHHfLkzikVqt5PlJam/3O/y9EBLYbzr2ZnFanYr+w0Es
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1550599"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="1550599"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="796191507"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="796191507"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 Nov 2023 03:13:42 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyUho-0001Nu-1M;
        Thu, 02 Nov 2023 10:13:40 +0000
Date:   Thu, 2 Nov 2023 18:13:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/thermal/broadcom/ns-thermal.c:56:44: sparse: sparse:
 incorrect type in argument 3 (different address spaces)
Message-ID: <202311021837.jbynFQZT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
commit: f59ac19b7f44cab23df84810e2da5f57bdd3a7e7 thermal/of: Remove old OF code
date:   1 year, 3 months ago
config: openrisc-randconfig-r131-20231102 (https://download.01.org/0day-ci/archive/20231102/202311021837.jbynFQZT-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231102/202311021837.jbynFQZT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311021837.jbynFQZT-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/thermal/broadcom/ns-thermal.c:19:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *pvtmon @@     got void *devdata @@
   drivers/thermal/broadcom/ns-thermal.c:19:34: sparse:     expected void [noderef] __iomem *pvtmon
   drivers/thermal/broadcom/ns-thermal.c:19:34: sparse:     got void *devdata
>> drivers/thermal/broadcom/ns-thermal.c:56:44: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *data @@     got void [noderef] __iomem *[assigned] pvtmon @@
   drivers/thermal/broadcom/ns-thermal.c:56:44: sparse:     expected void *data
   drivers/thermal/broadcom/ns-thermal.c:56:44: sparse:     got void [noderef] __iomem *[assigned] pvtmon
   drivers/thermal/broadcom/ns-thermal.c:63:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *data @@     got void [noderef] __iomem *[assigned] pvtmon @@
   drivers/thermal/broadcom/ns-thermal.c:63:36: sparse:     expected void *data
   drivers/thermal/broadcom/ns-thermal.c:63:36: sparse:     got void [noderef] __iomem *[assigned] pvtmon
>> drivers/thermal/broadcom/ns-thermal.c:70:52: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *pvtmon @@     got void * @@
   drivers/thermal/broadcom/ns-thermal.c:70:52: sparse:     expected void [noderef] __iomem *pvtmon
   drivers/thermal/broadcom/ns-thermal.c:70:52: sparse:     got void *

vim +56 drivers/thermal/broadcom/ns-thermal.c

a94cb7eeecc410 Rafał Miłecki  2017-04-03  44  
a94cb7eeecc410 Rafał Miłecki  2017-04-03  45  static int ns_thermal_probe(struct platform_device *pdev)
a94cb7eeecc410 Rafał Miłecki  2017-04-03  46  {
a94cb7eeecc410 Rafał Miłecki  2017-04-03  47  	struct device *dev = &pdev->dev;
944441d878b0ae Daniel Lezcano 2022-08-05  48  	struct thermal_zone_device *tz;
944441d878b0ae Daniel Lezcano 2022-08-05  49  	void __iomem *pvtmon;
a94cb7eeecc410 Rafał Miłecki  2017-04-03  50  
944441d878b0ae Daniel Lezcano 2022-08-05  51  	pvtmon = of_iomap(dev_of_node(dev), 0);
944441d878b0ae Daniel Lezcano 2022-08-05  52  	if (WARN_ON(!pvtmon))
a94cb7eeecc410 Rafał Miłecki  2017-04-03  53  		return -ENOENT;
a94cb7eeecc410 Rafał Miłecki  2017-04-03  54  
944441d878b0ae Daniel Lezcano 2022-08-05  55  	tz = devm_thermal_of_zone_register(dev, 0,
944441d878b0ae Daniel Lezcano 2022-08-05 @56  					   pvtmon,
a94cb7eeecc410 Rafał Miłecki  2017-04-03  57  					   &ns_thermal_ops);
944441d878b0ae Daniel Lezcano 2022-08-05  58  	if (IS_ERR(tz)) {
944441d878b0ae Daniel Lezcano 2022-08-05  59  		iounmap(pvtmon);
944441d878b0ae Daniel Lezcano 2022-08-05  60  		return PTR_ERR(tz);
a94cb7eeecc410 Rafał Miłecki  2017-04-03  61  	}
a94cb7eeecc410 Rafał Miłecki  2017-04-03  62  
944441d878b0ae Daniel Lezcano 2022-08-05  63  	platform_set_drvdata(pdev, pvtmon);
a94cb7eeecc410 Rafał Miłecki  2017-04-03  64  
a94cb7eeecc410 Rafał Miłecki  2017-04-03  65  	return 0;
a94cb7eeecc410 Rafał Miłecki  2017-04-03  66  }
a94cb7eeecc410 Rafał Miłecki  2017-04-03  67  
a94cb7eeecc410 Rafał Miłecki  2017-04-03  68  static int ns_thermal_remove(struct platform_device *pdev)
a94cb7eeecc410 Rafał Miłecki  2017-04-03  69  {
944441d878b0ae Daniel Lezcano 2022-08-05 @70  	void __iomem *pvtmon = platform_get_drvdata(pdev);
a94cb7eeecc410 Rafał Miłecki  2017-04-03  71  
944441d878b0ae Daniel Lezcano 2022-08-05  72  	iounmap(pvtmon);
a94cb7eeecc410 Rafał Miłecki  2017-04-03  73  
a94cb7eeecc410 Rafał Miłecki  2017-04-03  74  	return 0;
a94cb7eeecc410 Rafał Miłecki  2017-04-03  75  }
a94cb7eeecc410 Rafał Miłecki  2017-04-03  76  

:::::: The code at line 56 was first introduced by commit
:::::: 944441d878b0aebd87ec404fe86c322186da458d thermal/drivers/broadcom: Switch to new of API

:::::: TO: Daniel Lezcano <daniel.lezcano@linexp.org>
:::::: CC: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
