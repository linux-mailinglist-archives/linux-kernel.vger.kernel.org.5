Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289E57E86FC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 01:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344875AbjKKAn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 19:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjKKAnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 19:43:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DADD3C39
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699663431; x=1731199431;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yyQ6RXfueaauwVYk75Dyag4mUtaoYJb3VBeJ8ggptuI=;
  b=gpitzuPKxUQ4bpl7XnVIcFpmM7HL4ssR+H4jkklgGCTtqYYg+i86XnvM
   gvkPpe49zv7kn7JvHlmUG8VXV7Q+qVq3nXu48Fq7ly4VFJSW3ZIm3qXmN
   6IOOJwy4qPKICN1nFK2p+5XEJnTxCCVsuJp59bZPRvo0hkVfMDdevIgNl
   rErANqHvtsgwdr9h7TruKqGoNhiroRHN5vNBdh1UKfhQf1p5NFHshn3QL
   elLpcAMGTWpF9xnxsDlvSPa8PB87ROql0b/b1Mnb1Y+w9Hi6fwHa6S/5u
   3xbTclRafidmx0c6ANs2tZLVqrBG67cTll3BVr6nmFbmtpJsgfT7HdYIW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="3302271"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="3302271"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 16:43:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="713748304"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="713748304"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 Nov 2023 16:43:48 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1c6E-000A5O-1s;
        Sat, 11 Nov 2023 00:43:46 +0000
Date:   Sat, 11 Nov 2023 08:42:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: kernel/events/core.c:8288:1: sparse: sparse: symbol
 'dev_attr_nr_addr_filters' was not declared. Should it be static?
Message-ID: <202311110824.gykVW4Cq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   18553507f60f4f51f071644621a58836eb59e28c
commit: 6e855cd4f4b5258016cf707f94f96bfa51c32f32 perf/core: Let userspace know if the PMU supports address filters
date:   8 years ago
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231111/202311110824.gykVW4Cq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311110824.gykVW4Cq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311110824.gykVW4Cq-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/events/core.c:518:26: sparse: sparse: function 'perf_pmu_name' with external linkage has definition
   kernel/events/core.c:891:1: sparse: sparse: symbol 'perf_cgroup_switch' was not declared. Should it be static?
   kernel/events/core.c:993:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got int * @@
   kernel/events/core.c:993:22: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:993:22: sparse:     got int *
   kernel/events/core.c:1000:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got int * @@
   kernel/events/core.c:1000:22: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:1000:22: sparse:     got int *
   kernel/events/core.c:2783:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:2783:34: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:2783:34: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:3571:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:3571:26: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:3571:26: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:5913:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:5913:26: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:5913:26: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:6012:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:6012:43: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:6012:43: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:8237:35: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct perf_cpu_context [noderef] <asn:3> * @@     got struct perf_cpu_context *[noderef] pmu_cpu_context @@
   kernel/events/core.c:8237:35: sparse:     expected struct perf_cpu_context [noderef] <asn:3> *
   kernel/events/core.c:8237:35: sparse:     got struct perf_cpu_context *[noderef] pmu_cpu_context
   kernel/events/core.c:8250:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:8250:26: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:8250:26: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:8272:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:3> *__pdata @@     got struct perf_cpu_context *[noderef] pmu_cpu_context @@
   kernel/events/core.c:8272:24: sparse:     expected void [noderef] <asn:3> *__pdata
   kernel/events/core.c:8272:24: sparse:     got struct perf_cpu_context *[noderef] pmu_cpu_context
>> kernel/events/core.c:8288:1: sparse: sparse: symbol 'dev_attr_nr_addr_filters' was not declared. Should it be static?
   kernel/events/core.c:8339:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:8339:26: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:8339:26: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:8418:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int *[noderef] pmu_disable_count @@     got int [noderef] <asn:3> * @@
   kernel/events/core.c:8418:32: sparse:     expected int *[noderef] pmu_disable_count
   kernel/events/core.c:8418:32: sparse:     got int [noderef] <asn:3> *
   kernel/events/core.c:8452:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct perf_cpu_context *[noderef] pmu_cpu_context @@     got struct perf_cpu_context [noderef] <asn:3> * @@
   kernel/events/core.c:8452:30: sparse:     expected struct perf_cpu_context *[noderef] pmu_cpu_context
   kernel/events/core.c:8452:30: sparse:     got struct perf_cpu_context [noderef] <asn:3> *
   kernel/events/core.c:8457:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct perf_cpu_context *[noderef] pmu_cpu_context @@     got struct perf_cpu_context [noderef] <asn:3> * @@
   kernel/events/core.c:8457:30: sparse:     expected struct perf_cpu_context *[noderef] pmu_cpu_context
   kernel/events/core.c:8457:30: sparse:     got struct perf_cpu_context [noderef] <asn:3> *
   kernel/events/core.c:8464:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:8464:26: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:8464:26: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:8518:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:3> *__pdata @@     got int *[noderef] pmu_disable_count @@
   kernel/events/core.c:8518:24: sparse:     expected void [noderef] <asn:3> *__pdata
   kernel/events/core.c:8518:24: sparse:     got int *[noderef] pmu_disable_count
   kernel/events/core.c:8536:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:3> *__pdata @@     got int *[noderef] pmu_disable_count @@
   kernel/events/core.c:8536:24: sparse:     expected void [noderef] <asn:3> *__pdata
   kernel/events/core.c:8536:24: sparse:     got int *[noderef] pmu_disable_count
   kernel/events/core.c:9587:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:9587:20: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:9587:20: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:9588:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:9588:20: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:9588:20: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:152:9: sparse: sparse: context imbalance in 'perf_ctx_lock' - wrong count at exit
   kernel/events/core.c:160:17: sparse: sparse: context imbalance in 'perf_ctx_unlock' - unexpected unlock
   kernel/events/core.c:145:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:145:16: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:145:16: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:145:16: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:993:22: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:1000:22: sparse: sparse: dereference of noderef expression
   kernel/events/core.c: note: in included file (through include/linux/rculist.h, include/linux/dcache.h, include/linux/fs.h):
   include/linux/rcupdate.h:924:9: sparse: sparse: context imbalance in 'perf_lock_task_context' - different lock contexts for basic block
   kernel/events/core.c:1281:17: sparse: sparse: context imbalance in 'perf_pin_task_context' - unexpected unlock
   kernel/events/core.c:145:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:145:16: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:145:16: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:145:16: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:145:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:145:16: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:145:16: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:145:16: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:2191:9: sparse: sparse: context imbalance in '__perf_install_in_context' - wrong count at exit
   kernel/events/core.c:145:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:145:16: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:145:16: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:145:16: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:2783:34: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:145:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:145:16: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:145:16: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:145:16: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:145:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:145:16: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:145:16: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:145:16: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:145:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:145:16: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:145:16: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:145:16: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:3571:26: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:3602:17: sparse: sparse: context imbalance in 'find_get_context' - unexpected unlock
   kernel/events/core.c: note: in included file:
   kernel/events/internal.h:188:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got void const *buf @@
   kernel/events/internal.h:188:1: sparse:     expected void const [noderef] <asn:1> *from
   kernel/events/internal.h:188:1: sparse:     got void const *buf
   kernel/events/core.c:5913:26: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:5924:17: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:6012:43: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:8237:32: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:8250:26: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:8266:21: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:8266:43: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:8272:21: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:8339:26: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:8419:14: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:8453:13: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:8458:14: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:8464:26: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:8518:21: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:8536:21: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:9587:20: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:9588:20: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:145:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:145:16: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:145:16: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:145:16: sparse: sparse: dereference of noderef expression
   In file included from include/linux/kobject.h:21,
                    from include/linux/device.h:17,
                    from include/linux/node.h:17,
                    from include/linux/cpu.h:16,
                    from kernel/events/core.c:14:
   include/linux/sysfs.h: In function 'sysfs_get_dirent':
   include/linux/sysfs.h:517:44: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
     517 |         return kernfs_find_and_get(parent, name);
         |                                            ^~~~

vim +/dev_attr_nr_addr_filters +8288 kernel/events/core.c

  8223	
  8224	/*
  8225	 * Ensures all contexts with the same task_ctx_nr have the same
  8226	 * pmu_cpu_context too.
  8227	 */
  8228	static struct perf_cpu_context __percpu *find_pmu_context(int ctxn)
  8229	{
  8230		struct pmu *pmu;
  8231	
  8232		if (ctxn < 0)
  8233			return NULL;
  8234	
  8235		list_for_each_entry(pmu, &pmus, entry) {
  8236			if (pmu->task_ctx_nr == ctxn)
> 8237				return pmu->pmu_cpu_context;
  8238		}
  8239	
  8240		return NULL;
  8241	}
  8242	
  8243	static void update_pmu_context(struct pmu *pmu, struct pmu *old_pmu)
  8244	{
  8245		int cpu;
  8246	
  8247		for_each_possible_cpu(cpu) {
  8248			struct perf_cpu_context *cpuctx;
  8249	
  8250			cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
  8251	
  8252			if (cpuctx->unique_pmu == old_pmu)
  8253				cpuctx->unique_pmu = pmu;
  8254		}
  8255	}
  8256	
  8257	static void free_pmu_context(struct pmu *pmu)
  8258	{
  8259		struct pmu *i;
  8260	
  8261		mutex_lock(&pmus_lock);
  8262		/*
  8263		 * Like a real lame refcount.
  8264		 */
  8265		list_for_each_entry(i, &pmus, entry) {
  8266			if (i->pmu_cpu_context == pmu->pmu_cpu_context) {
  8267				update_pmu_context(i, pmu);
  8268				goto out;
  8269			}
  8270		}
  8271	
  8272		free_percpu(pmu->pmu_cpu_context);
  8273	out:
  8274		mutex_unlock(&pmus_lock);
  8275	}
  8276	
  8277	/*
  8278	 * Let userspace know that this PMU supports address range filtering:
  8279	 */
  8280	static ssize_t nr_addr_filters_show(struct device *dev,
  8281					    struct device_attribute *attr,
  8282					    char *page)
  8283	{
  8284		struct pmu *pmu = dev_get_drvdata(dev);
  8285	
  8286		return snprintf(page, PAGE_SIZE - 1, "%d\n", pmu->nr_addr_filters);
  8287	}
> 8288	DEVICE_ATTR_RO(nr_addr_filters);
  8289	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
