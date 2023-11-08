Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486BE7E5FE3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 22:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjKHVSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 16:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHVSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 16:18:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482FD213F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 13:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699478281; x=1731014281;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OF95v2cTbvgLmjzbw0xDyzPIo3nbTrMnF+GZgt20Tgk=;
  b=aCaXQmADrCqmYuhbwJcp+Sy28PQimiamBZPnE3Yuf4vpD80utjsBjHYn
   QzpTNLHd/F0zILOUNEL64NghKK/q/cTlfZf4MfICHLolPrVkGFucV/9pk
   yE2iFIL4P0MhTY8HFO4dpjCIOWuwQ8lKFqaUSg290GEFhMfZK0smXT2dn
   WbC0f1pFj9bFIwyh9Q2MN+O8DVNNuPWnJTcH5mtJWwB2suaAZOhYxBoYn
   k5J6aPdyj1MQoiPV6KRd1xfL9mrhEascEJZa7CZbjxwGttV4B3wGG2WMQ
   jN4Zzoy3xAgzb/GJbBzR86UTp/Pz+vuHLTR3BRUcCaJMK/unZ14nX31Bk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="454160099"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="454160099"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 13:18:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="739634390"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="739634390"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Nov 2023 13:17:59 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0pvw-0008C4-2i;
        Wed, 08 Nov 2023 21:17:56 +0000
Date:   Thu, 9 Nov 2023 05:17:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202311090500.TY5ePlwa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   90450a06162e6c71ab813ea22a83196fe7cff4bc
commit: f9bd34e3753ea8f1433a3ba70f03a165a1416f98 perf/arm_cspmu: Clean up ACPI dependency
date:   5 months ago
config: loongarch-randconfig-r133-20231107 (https://download.01.org/0day-ci/archive/20231109/202311090500.TY5ePlwa-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231109/202311090500.TY5ePlwa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311090500.TY5ePlwa-lkp@intel.com/

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
