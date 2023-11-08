Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAE67E4E70
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjKHBHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344539AbjKHBHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:07:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D04199E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 17:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699405615; x=1730941615;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l9ydbeBAy7drnypWXhZgnImPqEjdmm0V8LFc0n8Po1c=;
  b=WKw9kqGN7AVg1uQ0olZyRkWG5eB8sLF/pLlmZ5loeU6wTW/N+DR5vmgc
   8FhiM1Mm1fCVYBvwWfMcLHJ2DPHAZHeRVirQxzP8fOVIA8zsxVPFhYGt2
   t2Lksn5hkbAnW1xV07wPm886uI50HCLYnIuf0n95Zl8nv2gu74YtdjwFr
   Lfy/otSSu8wA3isTLEMX8fshyF5UlPEcyLuuOlcMnGk1JNeZUEQSElYq5
   4RCKZYOlunRNV4pr7L2eKAx9ALo8gLQoLKwPHqi0PH465pfl3YxZ+ZZf3
   UisasQi+i1tCJkCYRzKdPGBNc1mAhyg7GlbX7+oqdG08O8YUSmc7ftmiZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="374703618"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="374703618"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 17:06:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="792023868"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="792023868"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Nov 2023 17:06:53 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0X1u-0007XE-1v;
        Wed, 08 Nov 2023 01:06:50 +0000
Date:   Wed, 8 Nov 2023 09:04:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202311080840.Vc2kXhfp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   13d88ac54ddd1011b6e94443958e798aa06eb835
commit: 9458e0a78c45bc6537ce11eb9f03489eab92f9c2 flex_proportions: Disable preemption entering the write section.
date:   1 year, 2 months ago
config: loongarch-randconfig-r123-20231107 (https://download.01.org/0day-ci/archive/20231108/202311080840.Vc2kXhfp-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231108/202311080840.Vc2kXhfp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311080840.Vc2kXhfp-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   lib/flex_proportions.c:73:9: sparse:     expected void *ptr
   lib/flex_proportions.c:73:9: sparse:     got unsigned int [noderef] __percpu *
>> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   lib/flex_proportions.c:73:9: sparse:     expected void *ptr
   lib/flex_proportions.c:73:9: sparse:     got unsigned int [noderef] __percpu *
>> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   lib/flex_proportions.c:73:9: sparse:     expected void *ptr
   lib/flex_proportions.c:73:9: sparse:     got unsigned int [noderef] __percpu *
>> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   lib/flex_proportions.c:73:9: sparse:     expected void *ptr
   lib/flex_proportions.c:73:9: sparse:     got unsigned int [noderef] __percpu *
>> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   lib/flex_proportions.c:73:9: sparse:     expected void *ptr
   lib/flex_proportions.c:73:9: sparse:     got int [noderef] __percpu *
>> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   lib/flex_proportions.c:73:9: sparse:     expected void *ptr
   lib/flex_proportions.c:73:9: sparse:     got int [noderef] __percpu *
>> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   lib/flex_proportions.c:73:9: sparse:     expected void *ptr
   lib/flex_proportions.c:73:9: sparse:     got int [noderef] __percpu *
>> lib/flex_proportions.c:73:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   lib/flex_proportions.c:73:9: sparse:     expected void *ptr
   lib/flex_proportions.c:73:9: sparse:     got int [noderef] __percpu *
   lib/flex_proportions.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/percpu_counter.h, ...):
   include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
   include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
   include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
   include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
   include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
   include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
   include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
   include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *

vim +73 lib/flex_proportions.c

    55	
    56	/*
    57	 * Declare @periods new periods. It is upto the caller to make sure period
    58	 * transitions cannot happen in parallel.
    59	 *
    60	 * The function returns true if the proportions are still defined and false
    61	 * if aging zeroed out all events. This can be used to detect whether declaring
    62	 * further periods has any effect.
    63	 */
    64	bool fprop_new_period(struct fprop_global *p, int periods)
    65	{
    66		s64 events = percpu_counter_sum(&p->events);
    67	
    68		/*
    69		 * Don't do anything if there are no events.
    70		 */
    71		if (events <= 1)
    72			return false;
  > 73		preempt_disable_nested();
    74		write_seqcount_begin(&p->sequence);
    75		if (periods < 64)
    76			events -= events >> periods;
    77		/* Use addition to avoid losing events happening between sum and set */
    78		percpu_counter_add(&p->events, -events);
    79		p->period += periods;
    80		write_seqcount_end(&p->sequence);
    81		preempt_enable_nested();
    82	
    83		return true;
    84	}
    85	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
