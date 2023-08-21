Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84ED57835FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjHUWxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHUWxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:53:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692A818F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692658396; x=1724194396;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wej/YTXGgPtzSR7AXhIr2FZKaEa6HwWznGI8gaO7CJQ=;
  b=KBzRCrK1T9DJmXGRqxmYRABZveS2n8twIBZjlw6KtlXn4Yz3pG/RvJdr
   0W4TaKb6hkr8aZbkRislDyAoK/aNqa7wXC+gkgfgujewsXWZTqbZ5H0/Y
   ZPhlCJvP6j8RHxMDAVx19oukMkA09R8NG6aV/dDhuWRiPHAWhAgqO6ADQ
   6XsyitgG6wfuIPi8e/S1/zMWoVmGWM54gUqQbZRsa3M42Vk7TB53Jnxdq
   EGLj50ZX0f1DvQppXTyGf8SlvqtHTFlbtKfPWJjKfShQQJ4sfFXxKOdKO
   CrjgMASo4QLrY4KWH66wDsjEkmts4oycyJG9QobG17tIZxBSK+dTgZL3P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="440088410"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="440088410"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 15:53:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="879694214"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2023 15:53:18 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYDlj-00011f-20;
        Mon, 21 Aug 2023 22:53:09 +0000
Date:   Tue, 22 Aug 2023 06:52:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/perf/core-fsl-emb.c:648:13: warning: variable 'found'
 set but not used
Message-ID: <202308220658.OR5hHFcD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f7757129e3dea336c407551c98f50057c22bb266
commit: 0069f3d14e7a656ba9d7dbaac72659687fdbf43c powerpc/64e: Tie PPC_BOOK3E_64 to PPC_E500MC
date:   11 months ago
config: powerpc64-randconfig-r031-20230822 (https://download.01.org/0day-ci/archive/20230822/202308220658.OR5hHFcD-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230822/202308220658.OR5hHFcD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308220658.OR5hHFcD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/powerpc/perf/core-fsl-emb.c: In function 'perf_event_interrupt':
>> arch/powerpc/perf/core-fsl-emb.c:648:13: warning: variable 'found' set but not used [-Wunused-but-set-variable]
     648 |         int found = 0;
         |             ^~~~~
   arch/powerpc/perf/core-fsl-emb.c: At top level:
>> arch/powerpc/perf/core-fsl-emb.c:675:6: warning: no previous prototype for 'hw_perf_event_setup' [-Wmissing-prototypes]
     675 | void hw_perf_event_setup(int cpu)
         |      ^~~~~~~~~~~~~~~~~~~


vim +/found +648 arch/powerpc/perf/core-fsl-emb.c

a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  641  
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  642  static void perf_event_interrupt(struct pt_regs *regs)
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  643  {
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  644  	int i;
69111bac42f5ce arch/powerpc/perf/core-fsl-emb.c         Christoph Lameter 2014-10-21  645  	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  646  	struct perf_event *event;
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  647  	unsigned long val;
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25 @648  	int found = 0;
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  649  
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  650  	for (i = 0; i < ppmu->n_counter; ++i) {
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  651  		event = cpuhw->event[i];
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  652  
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  653  		val = read_pmc(i);
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  654  		if ((int)val < 0) {
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  655  			if (event) {
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  656  				/* event has overflowed */
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  657  				found = 1;
a8b0ca17b80e92 arch/powerpc/kernel/perf_event_fsl_emb.c Peter Zijlstra    2011-06-27  658  				record_and_restart(event, val, regs);
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  659  			} else {
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  660  				/*
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  661  				 * Disabled counter is negative,
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  662  				 * reset it just in case.
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  663  				 */
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  664  				write_pmc(i, 0);
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  665  			}
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  666  		}
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  667  	}
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  668  
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  669  	/* PMM will keep counters frozen until we return from the interrupt. */
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  670  	mtmsr(mfmsr() | MSR_PMM);
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  671  	mtpmr(PMRN_PMGC0, PMGC0_PMIE | PMGC0_FCECE);
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  672  	isync();
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  673  }
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  674  
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25 @675  void hw_perf_event_setup(int cpu)
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  676  {
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  677  	struct cpu_hw_events *cpuhw = &per_cpu(cpu_hw_events, cpu);
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  678  
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  679  	memset(cpuhw, 0, sizeof(*cpuhw));
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  680  }
a11106544f33c1 arch/powerpc/kernel/perf_event_fsl_emb.c Scott Wood        2010-02-25  681  

:::::: The code at line 648 was first introduced by commit
:::::: a11106544f33c104706ae42d27219a409b67478e powerpc/perf: e500 support

:::::: TO: Scott Wood <scottwood@freescale.com>
:::::: CC: Kumar Gala <galak@kernel.crashing.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
