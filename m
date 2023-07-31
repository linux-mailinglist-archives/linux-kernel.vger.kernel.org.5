Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46A7768991
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 03:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjGaBYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 21:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGaBYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 21:24:52 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE72E10C3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 18:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690766690; x=1722302690;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E/xpLcKG1zz6c3DowOS8as5jjdm6TYeyYaDAx+LvpOg=;
  b=Af+kYbDwBESNSf+5cp0roDS08I1idpxZrA/xSw+yuy1fFEgikRxbL59f
   VS8xovAKbZ6VI4qFgOQKeOUF49cfa796WLo7UmdjApgrDKe03hG+q5CkQ
   L3KkkTbhy2uPonhz1V5HZEsNDEluNofm3wsIZ2/hRy5c9XAFTHI7hkThF
   D1MytmiXjjCNp8KwqPMdOG3RdbNwVZVMdugD+3b+XGhLpR2g8hOyO1kMD
   jQeOc0Z3IiIghRjGUT3Al2+qSQ0aPL0A1s4d9KEW/TLVNaF12XYRtUKad
   uIsF8SqDK/KqE7r6af96yrnmSkfG0/KLXPcJWQm1z9pMlkq2Zf+VmswWm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="371603494"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="371603494"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 18:24:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="757761879"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="757761879"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 30 Jul 2023 18:24:48 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQHeR-0004rG-2Q;
        Mon, 31 Jul 2023 01:24:47 +0000
Date:   Mon, 31 Jul 2023 09:24:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: kernel/watchdog.c:162:1: warning: the frame size of 1248 bytes is
 larger than 1024 bytes
Message-ID: <202307310955.pLZDhpnl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
commit: 77c12fc95980d100fdc49e88a5727c242d0dfedc watchdog/hardlockup: add a "cpu" param to watchdog_hardlockup_check()
date:   7 weeks ago
config: x86_64-intel-next-customedconfig-intel_next_rpm_defconfig (https://download.01.org/0day-ci/archive/20230731/202307310955.pLZDhpnl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230731/202307310955.pLZDhpnl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307310955.pLZDhpnl-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/watchdog.c: In function 'watchdog_hardlockup_check':
>> kernel/watchdog.c:162:1: warning: the frame size of 1248 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     162 | }
         | ^


vim +162 kernel/watchdog.c

81972551df9d16 Douglas Anderson 2023-05-19  116  
77c12fc95980d1 Douglas Anderson 2023-05-19  117  void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
81972551df9d16 Douglas Anderson 2023-05-19  118  {
1610611aadc224 Douglas Anderson 2023-05-19  119  	/*
1610611aadc224 Douglas Anderson 2023-05-19  120  	 * Check for a hardlockup by making sure the CPU's timer
1610611aadc224 Douglas Anderson 2023-05-19  121  	 * interrupt is incrementing. The timer interrupt should have
81972551df9d16 Douglas Anderson 2023-05-19  122  	 * fired multiple times before we overflow'd. If it hasn't
81972551df9d16 Douglas Anderson 2023-05-19  123  	 * then this is a good indication the cpu is stuck
81972551df9d16 Douglas Anderson 2023-05-19  124  	 */
77c12fc95980d1 Douglas Anderson 2023-05-19  125  	if (is_hardlockup(cpu)) {
1610611aadc224 Douglas Anderson 2023-05-19  126  		unsigned int this_cpu = smp_processor_id();
77c12fc95980d1 Douglas Anderson 2023-05-19  127  		struct cpumask backtrace_mask = *cpu_online_mask;
81972551df9d16 Douglas Anderson 2023-05-19  128  
1610611aadc224 Douglas Anderson 2023-05-19  129  		/* Only print hardlockups once. */
77c12fc95980d1 Douglas Anderson 2023-05-19  130  		if (per_cpu(watchdog_hardlockup_warned, cpu))
81972551df9d16 Douglas Anderson 2023-05-19  131  			return;
81972551df9d16 Douglas Anderson 2023-05-19  132  
77c12fc95980d1 Douglas Anderson 2023-05-19  133  		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n", cpu);
81972551df9d16 Douglas Anderson 2023-05-19  134  		print_modules();
81972551df9d16 Douglas Anderson 2023-05-19  135  		print_irqtrace_events(current);
77c12fc95980d1 Douglas Anderson 2023-05-19  136  		if (cpu == this_cpu) {
81972551df9d16 Douglas Anderson 2023-05-19  137  			if (regs)
81972551df9d16 Douglas Anderson 2023-05-19  138  				show_regs(regs);
81972551df9d16 Douglas Anderson 2023-05-19  139  			else
81972551df9d16 Douglas Anderson 2023-05-19  140  				dump_stack();
77c12fc95980d1 Douglas Anderson 2023-05-19  141  			cpumask_clear_cpu(cpu, &backtrace_mask);
77c12fc95980d1 Douglas Anderson 2023-05-19  142  		} else {
77c12fc95980d1 Douglas Anderson 2023-05-19  143  			if (trigger_single_cpu_backtrace(cpu))
77c12fc95980d1 Douglas Anderson 2023-05-19  144  				cpumask_clear_cpu(cpu, &backtrace_mask);
77c12fc95980d1 Douglas Anderson 2023-05-19  145  		}
81972551df9d16 Douglas Anderson 2023-05-19  146  
81972551df9d16 Douglas Anderson 2023-05-19  147  		/*
77c12fc95980d1 Douglas Anderson 2023-05-19  148  		 * Perform multi-CPU dump only once to avoid multiple
77c12fc95980d1 Douglas Anderson 2023-05-19  149  		 * hardlockups generating interleaving traces
81972551df9d16 Douglas Anderson 2023-05-19  150  		 */
81972551df9d16 Douglas Anderson 2023-05-19  151  		if (sysctl_hardlockup_all_cpu_backtrace &&
1610611aadc224 Douglas Anderson 2023-05-19  152  		    !test_and_set_bit(0, &watchdog_hardlockup_all_cpu_dumped))
77c12fc95980d1 Douglas Anderson 2023-05-19  153  			trigger_cpumask_backtrace(&backtrace_mask);
81972551df9d16 Douglas Anderson 2023-05-19  154  
81972551df9d16 Douglas Anderson 2023-05-19  155  		if (hardlockup_panic)
81972551df9d16 Douglas Anderson 2023-05-19  156  			nmi_panic(regs, "Hard LOCKUP");
81972551df9d16 Douglas Anderson 2023-05-19  157  
77c12fc95980d1 Douglas Anderson 2023-05-19  158  		per_cpu(watchdog_hardlockup_warned, cpu) = true;
1610611aadc224 Douglas Anderson 2023-05-19  159  	} else {
77c12fc95980d1 Douglas Anderson 2023-05-19  160  		per_cpu(watchdog_hardlockup_warned, cpu) = false;
81972551df9d16 Douglas Anderson 2023-05-19  161  	}
81972551df9d16 Douglas Anderson 2023-05-19 @162  }
81972551df9d16 Douglas Anderson 2023-05-19  163  

:::::: The code at line 162 was first introduced by commit
:::::: 81972551df9d168a8183b786ff4de06008469c2e watchdog/hardlockup: move perf hardlockup checking/panic to common watchdog.c

:::::: TO: Douglas Anderson <dianders@chromium.org>
:::::: CC: Andrew Morton <akpm@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
