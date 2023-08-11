Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D7C7795A4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbjHKRGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbjHKRGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:06:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF97DE54
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691773608; x=1723309608;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2IcQV1yIgCRYTpZ02Ma18fM28DH96y7mzyy5YgCrHxM=;
  b=HS06uExqyDfsACov2WreI3zzd7YQREyB6/XSVr+NklcUeYvPkkIXyUU1
   3IqGuxWm9e0iE7c7kPXkdhGK1nbzXky39vKMFszgW5UNCbUNodJulqiSH
   M1+DO82JXvGhOD2CDIMxGW84377dHf6bt5OztqkGhso/Px2c2j4QDs8mM
   P+7L6x+/MtA3EIbH109kSHOfEvr9o/IbhLB2CB0Ew//J4d7M9CuYcclZ3
   CtJKAKkqa9Nl3nUR7vmoFus8WEXunwkMP54WUNmlucS5P/j/bTw/hFl1c
   o51J/yiLan5BK91Unub1GkXr0woblBZT3NZ2RC294S2FzNYbndOztvWk6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="374488824"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="374488824"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 10:06:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="726317674"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="726317674"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 11 Aug 2023 10:06:46 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUVb3-0007u4-21;
        Fri, 11 Aug 2023 17:06:45 +0000
Date:   Sat, 12 Aug 2023 01:06:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/perf/arm_dmc620_pmu.c:524:9: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202308120139.j0lPderX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   25aa0bebba72b318e71fe205bfd1236550cc9534
commit: f3c0eba287049237b23d1300376768293eb89e69 perf: Add a few assertions
date:   11 months ago
config: loongarch-randconfig-r073-20230811 (https://download.01.org/0day-ci/archive/20230812/202308120139.j0lPderX-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308120139.j0lPderX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308120139.j0lPderX-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/perf/arm_dmc620_pmu.c:524:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     expected void *ptr
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm_dmc620_pmu.c:524:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     expected void *ptr
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm_dmc620_pmu.c:524:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     expected void *ptr
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm_dmc620_pmu.c:524:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     expected void *ptr
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm_dmc620_pmu.c:524:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     expected void *ptr
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm_dmc620_pmu.c:524:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     expected void *ptr
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm_dmc620_pmu.c:524:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     expected void *ptr
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm_dmc620_pmu.c:524:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     expected void *ptr
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     got int [noderef] __percpu *
--
>> drivers/perf/arm_smmuv3_pmu.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     expected void *ptr
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm_smmuv3_pmu.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     expected void *ptr
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm_smmuv3_pmu.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     expected void *ptr
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm_smmuv3_pmu.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     expected void *ptr
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm_smmuv3_pmu.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     expected void *ptr
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm_smmuv3_pmu.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     expected void *ptr
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm_smmuv3_pmu.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     expected void *ptr
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm_smmuv3_pmu.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     expected void *ptr
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     got int [noderef] __percpu *
   drivers/perf/arm_smmuv3_pmu.c: note: in included file (through arch/loongarch/include/asm/io.h, arch/loongarch/include/asm/pgtable.h, arch/loongarch/include/asm/uaccess.h, ...):
   include/asm-generic/io.h:239:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:239:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:290:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:290:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:290:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:290:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:290:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:290:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:290:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:290:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:290:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:290:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:290:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:290:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:290:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:290:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:290:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:239:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:290:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:290:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:290:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
--
>> drivers/perf/arm-cmn.c:1471:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm-cmn.c:1471:9: sparse:     expected void *ptr
   drivers/perf/arm-cmn.c:1471:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm-cmn.c:1471:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm-cmn.c:1471:9: sparse:     expected void *ptr
   drivers/perf/arm-cmn.c:1471:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm-cmn.c:1471:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm-cmn.c:1471:9: sparse:     expected void *ptr
   drivers/perf/arm-cmn.c:1471:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm-cmn.c:1471:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm-cmn.c:1471:9: sparse:     expected void *ptr
   drivers/perf/arm-cmn.c:1471:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm-cmn.c:1471:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm-cmn.c:1471:9: sparse:     expected void *ptr
   drivers/perf/arm-cmn.c:1471:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm-cmn.c:1471:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm-cmn.c:1471:9: sparse:     expected void *ptr
   drivers/perf/arm-cmn.c:1471:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm-cmn.c:1471:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm-cmn.c:1471:9: sparse:     expected void *ptr
   drivers/perf/arm-cmn.c:1471:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm-cmn.c:1471:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm-cmn.c:1471:9: sparse:     expected void *ptr
   drivers/perf/arm-cmn.c:1471:9: sparse:     got int [noderef] __percpu *
   drivers/perf/arm-cmn.c: note: in included file (through arch/loongarch/include/asm/io.h, arch/loongarch/include/asm/pgtable.h, arch/loongarch/include/asm/uaccess.h, ...):
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
--
>> drivers/perf/xgene_pmu.c:935:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/xgene_pmu.c:935:9: sparse:     expected void *ptr
   drivers/perf/xgene_pmu.c:935:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/xgene_pmu.c:935:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/xgene_pmu.c:935:9: sparse:     expected void *ptr
   drivers/perf/xgene_pmu.c:935:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/xgene_pmu.c:935:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/xgene_pmu.c:935:9: sparse:     expected void *ptr
   drivers/perf/xgene_pmu.c:935:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/xgene_pmu.c:935:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/xgene_pmu.c:935:9: sparse:     expected void *ptr
   drivers/perf/xgene_pmu.c:935:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/xgene_pmu.c:935:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/xgene_pmu.c:935:9: sparse:     expected void *ptr
   drivers/perf/xgene_pmu.c:935:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/xgene_pmu.c:935:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/xgene_pmu.c:935:9: sparse:     expected void *ptr
   drivers/perf/xgene_pmu.c:935:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/xgene_pmu.c:935:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/xgene_pmu.c:935:9: sparse:     expected void *ptr
   drivers/perf/xgene_pmu.c:935:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/xgene_pmu.c:935:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/xgene_pmu.c:935:9: sparse:     expected void *ptr
   drivers/perf/xgene_pmu.c:935:9: sparse:     got int [noderef] __percpu *

vim +524 drivers/perf/arm_dmc620_pmu.c

53c218da220c36 Tuan Phan 2020-11-04  482  
53c218da220c36 Tuan Phan 2020-11-04  483  static int dmc620_pmu_event_init(struct perf_event *event)
53c218da220c36 Tuan Phan 2020-11-04  484  {
53c218da220c36 Tuan Phan 2020-11-04  485  	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
53c218da220c36 Tuan Phan 2020-11-04  486  	struct hw_perf_event *hwc = &event->hw;
53c218da220c36 Tuan Phan 2020-11-04  487  	struct perf_event *sibling;
53c218da220c36 Tuan Phan 2020-11-04  488  
53c218da220c36 Tuan Phan 2020-11-04  489  	if (event->attr.type != event->pmu->type)
53c218da220c36 Tuan Phan 2020-11-04  490  		return -ENOENT;
53c218da220c36 Tuan Phan 2020-11-04  491  
53c218da220c36 Tuan Phan 2020-11-04  492  	/*
53c218da220c36 Tuan Phan 2020-11-04  493  	 * DMC 620 PMUs are shared across all cpus and cannot
53c218da220c36 Tuan Phan 2020-11-04  494  	 * support task bound and sampling events.
53c218da220c36 Tuan Phan 2020-11-04  495  	 */
53c218da220c36 Tuan Phan 2020-11-04  496  	if (is_sampling_event(event) ||
53c218da220c36 Tuan Phan 2020-11-04  497  		event->attach_state & PERF_ATTACH_TASK) {
53c218da220c36 Tuan Phan 2020-11-04  498  		dev_dbg(dmc620_pmu->pmu.dev,
53c218da220c36 Tuan Phan 2020-11-04  499  			"Can't support per-task counters\n");
53c218da220c36 Tuan Phan 2020-11-04  500  		return -EOPNOTSUPP;
53c218da220c36 Tuan Phan 2020-11-04  501  	}
53c218da220c36 Tuan Phan 2020-11-04  502  
53c218da220c36 Tuan Phan 2020-11-04  503  	/*
53c218da220c36 Tuan Phan 2020-11-04  504  	 * Many perf core operations (eg. events rotation) operate on a
53c218da220c36 Tuan Phan 2020-11-04  505  	 * single CPU context. This is obvious for CPU PMUs, where one
53c218da220c36 Tuan Phan 2020-11-04  506  	 * expects the same sets of events being observed on all CPUs,
53c218da220c36 Tuan Phan 2020-11-04  507  	 * but can lead to issues for off-core PMUs, where each
53c218da220c36 Tuan Phan 2020-11-04  508  	 * event could be theoretically assigned to a different CPU. To
53c218da220c36 Tuan Phan 2020-11-04  509  	 * mitigate this, we enforce CPU assignment to one, selected
53c218da220c36 Tuan Phan 2020-11-04  510  	 * processor.
53c218da220c36 Tuan Phan 2020-11-04  511  	 */
53c218da220c36 Tuan Phan 2020-11-04  512  	event->cpu = dmc620_pmu->irq->cpu;
53c218da220c36 Tuan Phan 2020-11-04  513  	if (event->cpu < 0)
53c218da220c36 Tuan Phan 2020-11-04  514  		return -EINVAL;
53c218da220c36 Tuan Phan 2020-11-04  515  
53c218da220c36 Tuan Phan 2020-11-04  516  	/*
53c218da220c36 Tuan Phan 2020-11-04  517  	 * We can't atomically disable all HW counters so only one event allowed,
53c218da220c36 Tuan Phan 2020-11-04  518  	 * although software events are acceptable.
53c218da220c36 Tuan Phan 2020-11-04  519  	 */
53c218da220c36 Tuan Phan 2020-11-04  520  	if (event->group_leader != event &&
53c218da220c36 Tuan Phan 2020-11-04  521  			!is_software_event(event->group_leader))
53c218da220c36 Tuan Phan 2020-11-04  522  		return -EINVAL;
53c218da220c36 Tuan Phan 2020-11-04  523  
53c218da220c36 Tuan Phan 2020-11-04 @524  	for_each_sibling_event(sibling, event->group_leader) {
53c218da220c36 Tuan Phan 2020-11-04  525  		if (sibling != event &&
53c218da220c36 Tuan Phan 2020-11-04  526  				!is_software_event(sibling))
53c218da220c36 Tuan Phan 2020-11-04  527  			return -EINVAL;
53c218da220c36 Tuan Phan 2020-11-04  528  	}
53c218da220c36 Tuan Phan 2020-11-04  529  
53c218da220c36 Tuan Phan 2020-11-04  530  	hwc->idx = -1;
53c218da220c36 Tuan Phan 2020-11-04  531  	return 0;
53c218da220c36 Tuan Phan 2020-11-04  532  }
53c218da220c36 Tuan Phan 2020-11-04  533  

:::::: The code at line 524 was first introduced by commit
:::::: 53c218da220c3619b5befec4674ffa35d590092a driver/perf: Add PMU driver for the ARM DMC-620 memory controller

:::::: TO: Tuan Phan <tuanphan@os.amperecomputing.com>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
