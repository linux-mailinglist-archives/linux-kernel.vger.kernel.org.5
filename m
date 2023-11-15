Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973107EC1DC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343608AbjKOML2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjKOML1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:11:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3119B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 04:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700050283; x=1731586283;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oVQprlmxqKR+44uPorntLBHlx2c75fM9PHkgCNxKdvY=;
  b=gWlPYbIIwRjwOcp2ZL1oKI/dOU9Xv3dLOqpClQCJrrCRxHiZ0wPK/yzF
   T5+4CQ3RB7/Fos5GsrSFuwVoJyzYNCSVQPTrt3aMGM9KDFO2XqfimR56B
   oaRjEsS73sLsaaOXLvFN/6jYNQVfAZYoGWgpW82NjXISIbDb3QFqNEBwD
   tCjnB/YjEfTOJA6P7PREjsi52KaPwJ6xuh67E3p0vqj9EEypf6psWTku0
   Qto3wQ7wLxNZ4Wdu1Yrm/dnEzzUNm1DGaJ5XHYDOTeeEBKpXuKm9M3ZBz
   RTefaAGpbXiTUFKXqOsLFg4AdzPov0nc0Wu2fiLyu8r+ucHCQRqCadHcm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="370210215"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="370210215"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 04:11:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="835382527"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="835382527"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 15 Nov 2023 04:11:21 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3Ejl-0000Js-1D;
        Wed, 15 Nov 2023 12:11:17 +0000
Date:   Wed, 15 Nov 2023 20:10:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202311151948.RANfH9T9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: f9bd34e3753ea8f1433a3ba70f03a165a1416f98 perf/arm_cspmu: Clean up ACPI dependency
date:   5 months ago
config: loongarch-randconfig-r133-20231107 (https://download.01.org/0day-ci/archive/20231115/202311151948.RANfH9T9-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231115/202311151948.RANfH9T9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311151948.RANfH9T9-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void *ptr
   drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void *ptr
   drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void *ptr
   drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void *ptr
   drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void *ptr
   drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void *ptr
   drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void *ptr
   drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void *ptr
   drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got int [noderef] __percpu *

vim +627 drivers/perf/arm_cspmu/arm_cspmu.c

e37dfd65731dc4 Besar Wicaksono 2022-11-11  609  
e37dfd65731dc4 Besar Wicaksono 2022-11-11  610  /*
e37dfd65731dc4 Besar Wicaksono 2022-11-11  611   * Make sure the group of events can be scheduled at once
e37dfd65731dc4 Besar Wicaksono 2022-11-11  612   * on the PMU.
e37dfd65731dc4 Besar Wicaksono 2022-11-11  613   */
e37dfd65731dc4 Besar Wicaksono 2022-11-11  614  static bool arm_cspmu_validate_group(struct perf_event *event)
e37dfd65731dc4 Besar Wicaksono 2022-11-11  615  {
e37dfd65731dc4 Besar Wicaksono 2022-11-11  616  	struct perf_event *sibling, *leader = event->group_leader;
e37dfd65731dc4 Besar Wicaksono 2022-11-11  617  	struct arm_cspmu_hw_events fake_hw_events;
e37dfd65731dc4 Besar Wicaksono 2022-11-11  618  
e37dfd65731dc4 Besar Wicaksono 2022-11-11  619  	if (event->group_leader == event)
e37dfd65731dc4 Besar Wicaksono 2022-11-11  620  		return true;
e37dfd65731dc4 Besar Wicaksono 2022-11-11  621  
e37dfd65731dc4 Besar Wicaksono 2022-11-11  622  	memset(&fake_hw_events, 0, sizeof(fake_hw_events));
e37dfd65731dc4 Besar Wicaksono 2022-11-11  623  
e37dfd65731dc4 Besar Wicaksono 2022-11-11  624  	if (!arm_cspmu_validate_event(event->pmu, &fake_hw_events, leader))
e37dfd65731dc4 Besar Wicaksono 2022-11-11  625  		return false;
e37dfd65731dc4 Besar Wicaksono 2022-11-11  626  
e37dfd65731dc4 Besar Wicaksono 2022-11-11 @627  	for_each_sibling_event(sibling, leader) {
e37dfd65731dc4 Besar Wicaksono 2022-11-11  628  		if (!arm_cspmu_validate_event(event->pmu, &fake_hw_events,
e37dfd65731dc4 Besar Wicaksono 2022-11-11  629  						  sibling))
e37dfd65731dc4 Besar Wicaksono 2022-11-11  630  			return false;
e37dfd65731dc4 Besar Wicaksono 2022-11-11  631  	}
e37dfd65731dc4 Besar Wicaksono 2022-11-11  632  
e37dfd65731dc4 Besar Wicaksono 2022-11-11  633  	return arm_cspmu_validate_event(event->pmu, &fake_hw_events, event);
e37dfd65731dc4 Besar Wicaksono 2022-11-11  634  }
e37dfd65731dc4 Besar Wicaksono 2022-11-11  635  

:::::: The code at line 627 was first introduced by commit
:::::: e37dfd65731dc4f001fa7dfa7f705e6840017d5a perf: arm_cspmu: Add support for ARM CoreSight PMU driver

:::::: TO: Besar Wicaksono <bwicaksono@nvidia.com>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
