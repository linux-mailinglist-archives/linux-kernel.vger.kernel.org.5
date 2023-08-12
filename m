Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316BA779BD5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 02:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbjHLAVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 20:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbjHLAVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 20:21:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240042706
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691799658; x=1723335658;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KeY3hyBtmfcLPtC0n51/iywGCgbvLslZc7rmdMZaHiQ=;
  b=ZGl3RRIzGglKqbF5ongM92Pqe/AmlgJKB9UfYO9WKyTG8utdiuXh2r0S
   Fa+jOUpmXf+AwPZrzbh0ZF4nHnlNgjv0PUEuWgSANkST+rNXdFjbIYiBK
   9WbD7tNA03UlvUMNr1I5ili+1+WGIxzx6kyhSC8dszp4sh2z9JcViaNHI
   +GAcTlM9V6aYuc64sWEunFYVD8ee23etMjNTN/2Mv8PnkmTQUiESaK8d7
   a6HFlMlsif+vZnOq5YTkUr/C2kApWIIkya39+3KsEG+h7PhijYlHdw/AR
   mzHrroSg5ekTz7lqHkc5XUUwnm23KmVfaX6CO6umzdUt3ZcZqY16OYlV1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="371793005"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="371793005"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 17:20:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="822850065"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="822850065"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Aug 2023 17:20:55 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUcND-00088C-02;
        Sat, 12 Aug 2023 00:20:55 +0000
Date:   Sat, 12 Aug 2023 08:20:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Muchun Song <songmuchun@bytedance.com>
Subject: mm/memcontrol.c:600:9: sparse: sparse: incorrect type in argument 1
 (different address spaces)
Message-ID: <202308120839.dVnfuv2t-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   190bf7b14b0cf3df19c059061be032bd8994a597
commit: e575d401583273a7ac5dfb27520e41c821e81816 mm/memcontrol: Replace the PREEMPT_RT conditionals
date:   11 months ago
config: loongarch-randconfig-r072-20230811 (https://download.01.org/0day-ci/archive/20230812/202308120839.dVnfuv2t-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308120839.dVnfuv2t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308120839.dVnfuv2t-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/memcontrol.c:600:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/memcontrol.c:600:9: sparse:     expected void *ptr
   mm/memcontrol.c:600:9: sparse:     got unsigned int [noderef] __percpu *
>> mm/memcontrol.c:600:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/memcontrol.c:600:9: sparse:     expected void *ptr
   mm/memcontrol.c:600:9: sparse:     got unsigned int [noderef] __percpu *
>> mm/memcontrol.c:600:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/memcontrol.c:600:9: sparse:     expected void *ptr
   mm/memcontrol.c:600:9: sparse:     got unsigned int [noderef] __percpu *
>> mm/memcontrol.c:600:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/memcontrol.c:600:9: sparse:     expected void *ptr
   mm/memcontrol.c:600:9: sparse:     got unsigned int [noderef] __percpu *
>> mm/memcontrol.c:600:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/memcontrol.c:600:9: sparse:     expected void *ptr
   mm/memcontrol.c:600:9: sparse:     got int [noderef] __percpu *
>> mm/memcontrol.c:600:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/memcontrol.c:600:9: sparse:     expected void *ptr
   mm/memcontrol.c:600:9: sparse:     got int [noderef] __percpu *
>> mm/memcontrol.c:600:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/memcontrol.c:600:9: sparse:     expected void *ptr
   mm/memcontrol.c:600:9: sparse:     got int [noderef] __percpu *
>> mm/memcontrol.c:600:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/memcontrol.c:600:9: sparse:     expected void *ptr
   mm/memcontrol.c:600:9: sparse:     got int [noderef] __percpu *
   mm/memcontrol.c:606:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/memcontrol.c:606:9: sparse:     expected void *ptr
   mm/memcontrol.c:606:9: sparse:     got unsigned int [noderef] __percpu *
   mm/memcontrol.c:606:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/memcontrol.c:606:9: sparse:     expected void *ptr
   mm/memcontrol.c:606:9: sparse:     got unsigned int [noderef] __percpu *
   mm/memcontrol.c:606:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/memcontrol.c:606:9: sparse:     expected void *ptr
   mm/memcontrol.c:606:9: sparse:     got unsigned int [noderef] __percpu *
   mm/memcontrol.c:606:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/memcontrol.c:606:9: sparse:     expected void *ptr
   mm/memcontrol.c:606:9: sparse:     got unsigned int [noderef] __percpu *
   mm/memcontrol.c:606:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/memcontrol.c:606:9: sparse:     expected void *ptr
   mm/memcontrol.c:606:9: sparse:     got int [noderef] __percpu *
   mm/memcontrol.c:606:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/memcontrol.c:606:9: sparse:     expected void *ptr
   mm/memcontrol.c:606:9: sparse:     got int [noderef] __percpu *
   mm/memcontrol.c:606:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/memcontrol.c:606:9: sparse:     expected void *ptr
   mm/memcontrol.c:606:9: sparse:     got int [noderef] __percpu *
   mm/memcontrol.c:606:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/memcontrol.c:606:9: sparse:     expected void *ptr
   mm/memcontrol.c:606:9: sparse:     got int [noderef] __percpu *
   mm/memcontrol.c:4109:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/memcontrol.c:4109:21: sparse:    struct mem_cgroup_threshold_ary [noderef] __rcu *
   mm/memcontrol.c:4109:21: sparse:    struct mem_cgroup_threshold_ary *
   mm/memcontrol.c:4111:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/memcontrol.c:4111:21: sparse:    struct mem_cgroup_threshold_ary [noderef] __rcu *
   mm/memcontrol.c:4111:21: sparse:    struct mem_cgroup_threshold_ary *
   mm/memcontrol.c:4267:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/memcontrol.c:4267:9: sparse:    struct mem_cgroup_threshold_ary [noderef] __rcu *
   mm/memcontrol.c:4267:9: sparse:    struct mem_cgroup_threshold_ary *
   mm/memcontrol.c:4361:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/memcontrol.c:4361:9: sparse:    struct mem_cgroup_threshold_ary [noderef] __rcu *
   mm/memcontrol.c:4361:9: sparse:    struct mem_cgroup_threshold_ary *
   mm/memcontrol.c:5991:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/memcontrol.c:5991:23: sparse:    struct task_struct [noderef] __rcu *
   mm/memcontrol.c:5991:23: sparse:    struct task_struct *
   mm/memcontrol.c:914:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct mem_cgroup *[noderef] __percpu * @@
   mm/memcontrol.c:914:24: sparse:     expected void *ptr
   mm/memcontrol.c:914:24: sparse:     got struct mem_cgroup *[noderef] __percpu *
   mm/memcontrol.c:914:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct mem_cgroup *[noderef] __percpu * @@
   mm/memcontrol.c:914:24: sparse:     expected void *ptr
   mm/memcontrol.c:914:24: sparse:     got struct mem_cgroup *[noderef] __percpu *
   mm/memcontrol.c:914:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct mem_cgroup *[noderef] __percpu * @@
   mm/memcontrol.c:914:24: sparse:     expected void *ptr
   mm/memcontrol.c:914:24: sparse:     got struct mem_cgroup *[noderef] __percpu *
   mm/memcontrol.c:914:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct mem_cgroup *[noderef] __percpu * @@
   mm/memcontrol.c:914:24: sparse:     expected void *ptr
   mm/memcontrol.c:914:24: sparse:     got struct mem_cgroup *[noderef] __percpu *
   mm/memcontrol.c: note: in included file:
   include/linux/memcontrol.h:754:9: sparse: sparse: context imbalance in 'folio_lruvec_lock' - wrong count at exit
   include/linux/memcontrol.h:754:9: sparse: sparse: context imbalance in 'folio_lruvec_lock_irq' - wrong count at exit
   include/linux/memcontrol.h:754:9: sparse: sparse: context imbalance in 'folio_lruvec_lock_irqsave' - wrong count at exit
   mm/memcontrol.c:2027:6: sparse: sparse: context imbalance in 'folio_memcg_lock' - wrong count at exit
   mm/memcontrol.c:2079:17: sparse: sparse: context imbalance in '__folio_memcg_unlock' - unexpected unlock
   mm/memcontrol.c:914:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct mem_cgroup *[noderef] __percpu * @@
   mm/memcontrol.c:914:24: sparse:     expected void *ptr
   mm/memcontrol.c:914:24: sparse:     got struct mem_cgroup *[noderef] __percpu *
   mm/memcontrol.c:914:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct mem_cgroup *[noderef] __percpu * @@
   mm/memcontrol.c:914:24: sparse:     expected void *ptr
   mm/memcontrol.c:914:24: sparse:     got struct mem_cgroup *[noderef] __percpu *
   mm/memcontrol.c:914:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct mem_cgroup *[noderef] __percpu * @@
   mm/memcontrol.c:914:24: sparse:     expected void *ptr
   mm/memcontrol.c:914:24: sparse:     got struct mem_cgroup *[noderef] __percpu *
   mm/memcontrol.c:914:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct mem_cgroup *[noderef] __percpu * @@
   mm/memcontrol.c:914:24: sparse:     expected void *ptr
   mm/memcontrol.c:914:24: sparse:     got struct mem_cgroup *[noderef] __percpu *
   mm/memcontrol.c:914:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct mem_cgroup *[noderef] __percpu * @@
   mm/memcontrol.c:914:24: sparse:     expected void *ptr
   mm/memcontrol.c:914:24: sparse:     got struct mem_cgroup *[noderef] __percpu *
   mm/memcontrol.c:914:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct mem_cgroup *[noderef] __percpu * @@
   mm/memcontrol.c:914:24: sparse:     expected void *ptr
   mm/memcontrol.c:914:24: sparse:     got struct mem_cgroup *[noderef] __percpu *
   mm/memcontrol.c:914:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct mem_cgroup *[noderef] __percpu * @@
   mm/memcontrol.c:914:24: sparse:     expected void *ptr
   mm/memcontrol.c:914:24: sparse:     got struct mem_cgroup *[noderef] __percpu *
   mm/memcontrol.c:914:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct mem_cgroup *[noderef] __percpu * @@
   mm/memcontrol.c:914:24: sparse:     expected void *ptr
   mm/memcontrol.c:914:24: sparse:     got struct mem_cgroup *[noderef] __percpu *
   mm/memcontrol.c:914:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct mem_cgroup *[noderef] __percpu * @@
   mm/memcontrol.c:914:24: sparse:     expected void *ptr
   mm/memcontrol.c:914:24: sparse:     got struct mem_cgroup *[noderef] __percpu *
   mm/memcontrol.c:914:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct mem_cgroup *[noderef] __percpu * @@
   mm/memcontrol.c:914:24: sparse:     expected void *ptr
   mm/memcontrol.c:914:24: sparse:     got struct mem_cgroup *[noderef] __percpu *
   mm/memcontrol.c:914:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct mem_cgroup *[noderef] __percpu * @@
   mm/memcontrol.c:914:24: sparse:     expected void *ptr
   mm/memcontrol.c:914:24: sparse:     got struct mem_cgroup *[noderef] __percpu *
   mm/memcontrol.c:914:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct mem_cgroup *[noderef] __percpu * @@
   mm/memcontrol.c:914:24: sparse:     expected void *ptr
   mm/memcontrol.c:914:24: sparse:     got struct mem_cgroup *[noderef] __percpu *
   mm/memcontrol.c:914:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct mem_cgroup *[noderef] __percpu * @@
   mm/memcontrol.c:914:24: sparse:     expected void *ptr
   mm/memcontrol.c:914:24: sparse:     got struct mem_cgroup *[noderef] __percpu *
   mm/memcontrol.c:914:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct mem_cgroup *[noderef] __percpu * @@
   mm/memcontrol.c:914:24: sparse:     expected void *ptr

vim +600 mm/memcontrol.c

   591	
   592	/*
   593	 * Accessors to ensure that preemption is disabled on PREEMPT_RT because it can
   594	 * not rely on this as part of an acquired spinlock_t lock. These functions are
   595	 * never used in hardirq context on PREEMPT_RT and therefore disabling preemtion
   596	 * is sufficient.
   597	 */
   598	static void memcg_stats_lock(void)
   599	{
 > 600		preempt_disable_nested();
   601		VM_WARN_ON_IRQS_ENABLED();
   602	}
   603	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
