Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6419E802151
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjLCGe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 01:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjLCGeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 01:34:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FD8125
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701585227; x=1733121227;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wrk0Kl1e7I/Z18YrZdNfSmGgEaEzZ5BwY6VdYRlgZNs=;
  b=eDYB21RtH4NaNflciRIDKfuWMbSc5+eACBCNmVijLyE27wSQbFiYyl5K
   omsota02ugWYBvAso8UvxfuGG1eRaAGBVCxa45b0qnwzu99hdMB7YfOGI
   ujBay2GvPSFeOtZ4mo2aX+DKxsAD8HesQcvc38Xt/LXGHOoUPbUVhE92n
   j9NVBZOuaaIKM3zf3rLMd4DPmtdnzEwvi9wpYhBfyM8KZ2XGKqFiVjQjn
   ettmPrc443m04QmFDKnySAv3PQxW6BZA4D627a+kleBVsYLbwFjWpM62H
   +Ap32MCjek+IbPllYrfPnsoWIcULMqM7NxvRfSxSTIyZAsQ2wJziUZyb4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="15180438"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="15180438"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 22:32:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="914081651"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="914081651"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 02 Dec 2023 22:32:47 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9g20-0006Lz-2c;
        Sun, 03 Dec 2023 06:32:44 +0000
Date:   Sun, 3 Dec 2023 14:31:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: kernel/events/core.c:8288:1: sparse: sparse: symbol
 'dev_attr_nr_addr_filters' was not declared. Should it be static?
Message-ID: <202312030617.SdoSYtcc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   815fb87b753055df2d9e50f6cd80eb10235fe3e9
commit: 6e855cd4f4b5258016cf707f94f96bfa51c32f32 perf/core: Let userspace know if the PMU supports address filters
date:   8 years ago
config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231203/202312030617.SdoSYtcc-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231203/202312030617.SdoSYtcc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312030617.SdoSYtcc-lkp@intel.com/

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
   kernel/events/internal.h:162:1: sparse: sparse: self-comparison always evaluates to true
   kernel/events/internal.h:162:1: sparse: sparse: self-comparison always evaluates to true
   kernel/events/internal.h:162:1: sparse: sparse: self-comparison always evaluates to true
   kernel/events/internal.h:162:1: sparse: sparse: self-comparison always evaluates to true
   kernel/events/internal.h:162:1: sparse: sparse: self-comparison always evaluates to true
   kernel/events/internal.h:162:1: sparse: sparse: self-comparison always evaluates to true
   kernel/events/core.c:5913:26: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:5924:17: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:6012:43: sparse: sparse: dereference of noderef expression
   kernel/events/internal.h:162:1: sparse: sparse: self-comparison always evaluates to true
   kernel/events/internal.h:162:1: sparse: sparse: self-comparison always evaluates to true
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

vim +/dev_attr_nr_addr_filters +8288 kernel/events/core.c

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
