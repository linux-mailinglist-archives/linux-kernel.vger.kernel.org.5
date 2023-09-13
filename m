Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A5879E662
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240085AbjIMLQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240111AbjIMLPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:15:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075883C02
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694603674; x=1726139674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CO7FuKGxFldgK75QHPqN9lKBJ3RZKKyTcKvNBywVB6U=;
  b=Zzfyg8HDA5+7XrjlfzPdCaeoNAiNFwN64a1rRZoNgMgS/fTUWiup4Xej
   pG1agdYmu1BK7k+qeseMh+IQ/rQR4159G58JI7wNj87MHJ0nPf3J1CKe0
   2w5cd7AUN1zHWBfXFE2XU3mBpNjV3hJDpsfyuGZp/htnk6+OoBHE0dfP6
   77bPiWQxWkXwRO9Svl2Oq1Booci/EDFCjxXqhknsjgXjRSI8qqVCBs2E1
   WydN4w6wuE4RVE2ZJCrR76eZIFOgNZ6F3HU0o6j4zIE3EK7NTBR6qcb2s
   iaTM2enBVgNy4YF5IcQ2dAWJx3FZVUXrucCwnwrUoystADNCTG/dvB10G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="363660576"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="363660576"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:14:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="917791463"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="917791463"
Received: from lkp-server02.sh.intel.com (HELO cf13c67269a2) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Sep 2023 04:14:31 -0700
Received: from kbuild by cf13c67269a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgNpD-0000R1-29;
        Wed, 13 Sep 2023 11:14:28 +0000
Date:   Wed, 13 Sep 2023 19:14:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/19] powerpc: Untangle fixmap.h and pgtable.h and
 mmu.h
Message-ID: <202309131942.k7EzJho8-lkp@intel.com>
References: <c94717708db817a0a0a6349431a2701252686899.1694443576.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c94717708db817a0a0a6349431a2701252686899.1694443576.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6-rc1 next-20230913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-Leroy/powerpc-8xx-Fix-pte_access_permitted-for-PAGE_NONE/20230912-031616
base:   linus/master
patch link:    https://lore.kernel.org/r/c94717708db817a0a0a6349431a2701252686899.1694443576.git.christophe.leroy%40csgroup.eu
patch subject: [PATCH v1 07/19] powerpc: Untangle fixmap.h and pgtable.h and mmu.h
config: powerpc-randconfig-r013-20230912 (https://download.01.org/0day-ci/archive/20230913/202309131942.k7EzJho8-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309131942.k7EzJho8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309131942.k7EzJho8-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/platforms/83xx/misc.c: In function 'mpc83xx_setup_arch':
>> arch/powerpc/platforms/83xx/misc.c:126:28: error: implicit declaration of function 'fix_to_virt'; did you mean 'bus_to_virt'? [-Werror=implicit-function-declaration]
     126 |         unsigned long va = fix_to_virt(FIX_IMMR_BASE);
         |                            ^~~~~~~~~~~
         |                            bus_to_virt
>> arch/powerpc/platforms/83xx/misc.c:126:40: error: 'FIX_IMMR_BASE' undeclared (first use in this function)
     126 |         unsigned long va = fix_to_virt(FIX_IMMR_BASE);
         |                                        ^~~~~~~~~~~~~
   arch/powerpc/platforms/83xx/misc.c:126:40: note: each undeclared identifier is reported only once for each function it appears in
   cc1: all warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for HOTPLUG_CPU
   Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
   Selected by [y]:
   - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=y] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]


vim +/FIX_IMMR_BASE +126 arch/powerpc/platforms/83xx/misc.c

fff69fd03d1290 Kevin Hao        2016-08-23  121  
fff69fd03d1290 Kevin Hao        2016-08-23  122  void __init mpc83xx_setup_arch(void)
fff69fd03d1290 Kevin Hao        2016-08-23  123  {
6b7c095a51e1ba Christophe Leroy 2019-09-16  124  	phys_addr_t immrbase = get_immrbase();
6b7c095a51e1ba Christophe Leroy 2019-09-16  125  	int immrsize = IS_ALIGNED(immrbase, SZ_2M) ? SZ_2M : SZ_1M;
6b7c095a51e1ba Christophe Leroy 2019-09-16 @126  	unsigned long va = fix_to_virt(FIX_IMMR_BASE);
6b7c095a51e1ba Christophe Leroy 2019-09-16  127  
1ce844973bb516 Christophe Leroy 2022-06-14  128  	if (ppc_md.progress)
1ce844973bb516 Christophe Leroy 2022-06-14  129  		ppc_md.progress("mpc83xx_setup_arch()", 0);
1ce844973bb516 Christophe Leroy 2022-06-14  130  
6b7c095a51e1ba Christophe Leroy 2019-09-16  131  	setbat(-1, va, immrbase, immrsize, PAGE_KERNEL_NCG);
6b7c095a51e1ba Christophe Leroy 2019-09-16  132  	update_bats();
6b7c095a51e1ba Christophe Leroy 2019-09-16  133  }
0deae39cec6dab Christophe Leroy 2018-12-10  134  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
