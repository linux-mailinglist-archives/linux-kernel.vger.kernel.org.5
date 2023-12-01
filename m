Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B133D8007EC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378156AbjLAKJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377899AbjLAKJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:09:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B98584
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 02:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701425376; x=1732961376;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hPzww2gmkbqeVRs+bdhL8KLZbuzbpmKJ5THyUEmP1po=;
  b=cUbDp9qAkzGmOFi5M/lkB9ylD+T4iSNHk8sZYH+Qbjcgi4O/FgzGb3kB
   8JUN/PXIzcuAfOKwRf8ojldvTxzdDRroScXyv9DPslNnEvtyCZ63EsRCd
   rTRP5tAL8yMQ3l8u1G6xJUtb5OM6X7SxHhs1K/KoV/wlrn8oUNu9aNjID
   N5TPKa6Gk0qB7yFOP2MzU269ySX9mHyRh3aJzXsC7G5EnaoR0z6f6Sz6U
   a9XjgB7e+RkzMj4YXLdUHiXB7nzlygGIXDNfPp+/qmNhuvokO1X/Gr4lt
   hkIP9qahpidJB5vrgmcN+UJqHqTdzkiBahpjrn4qp+2nyHHqzHNvCt7fS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="484110"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="484110"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 02:09:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="798670643"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="798670643"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 01 Dec 2023 02:09:32 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r90Sg-0003TQ-0n;
        Fri, 01 Dec 2023 10:09:30 +0000
Date:   Fri, 1 Dec 2023 18:09:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/kernel/smp-cps.c:165:37: sparse: sparse: cast removes
 address space '__iomem' of expression
Message-ID: <202312011758.7OxUUAY3-lkp@intel.com>
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
head:   994d5c58e50e91bb02c7be4a91d5186292a895c8
commit: fea8826d5fdc4ff5c93e883a738597129614039c MIPS: smp-cps: Don't rely on CP0_CMGCRBASE
date:   9 months ago
config: mips-randconfig-r122-20231108 (https://download.01.org/0day-ci/archive/20231201/202312011758.7OxUUAY3-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231201/202312011758.7OxUUAY3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312011758.7OxUUAY3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/mips/kernel/smp-cps.c:165:37: sparse: sparse: cast removes address space '__iomem' of expression
   arch/mips/kernel/smp-cps.c: note: in included file (through arch/mips/include/asm/mips-cps.h, arch/mips/include/asm/smp-ops.h, arch/mips/include/asm/smp.h, ...):
   arch/mips/include/asm/mips-cm.h:152:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:152:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:152:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:152:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:152:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:152:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:152:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:152:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:292:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:292:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:292:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:292:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:292:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:292:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:292:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:292:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:292:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:292:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:292:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:292:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:292:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:292:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:292:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:292:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:292:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:292:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:292:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:292:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:292:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:292:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:292:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:292:1: sparse:     got void [noderef] __iomem *
   arch/mips/kernel/smp-cps.c: note: in included file (through arch/mips/include/asm/mips-cps.h, arch/mips/include/asm/smp-ops.h, arch/mips/include/asm/smp.h, ...):
   arch/mips/include/asm/mips-cpc.h:149:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     got void *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     got void *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     got void *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     got void *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     expected void *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     expected void *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     expected void *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     expected void *
   arch/mips/include/asm/mips-cpc.h:149:1: sparse:     got void [noderef] __iomem *
   arch/mips/kernel/smp-cps.c: note: in included file (through arch/mips/include/asm/mips-cps.h, arch/mips/include/asm/smp-ops.h, arch/mips/include/asm/smp.h, ...):
   arch/mips/include/asm/mips-cm.h:152:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:152:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:152:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:152:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:152:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:152:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:152:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:152:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:152:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:131:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@

vim +/__iomem +165 arch/mips/kernel/smp-cps.c

   118	
   119	static void __init cps_prepare_cpus(unsigned int max_cpus)
   120	{
   121		unsigned ncores, core_vpes, c, cca;
   122		bool cca_unsuitable, cores_limited;
   123		u32 *entry_code;
   124	
   125		mips_mt_set_cpuoptions();
   126	
   127		/* Detect whether the CCA is unsuited to multi-core SMP */
   128		cca = read_c0_config() & CONF_CM_CMASK;
   129		switch (cca) {
   130		case 0x4: /* CWBE */
   131		case 0x5: /* CWB */
   132			/* The CCA is coherent, multi-core is fine */
   133			cca_unsuitable = false;
   134			break;
   135	
   136		default:
   137			/* CCA is not coherent, multi-core is not usable */
   138			cca_unsuitable = true;
   139		}
   140	
   141		/* Warn the user if the CCA prevents multi-core */
   142		cores_limited = false;
   143		if (cca_unsuitable || cpu_has_dc_aliases) {
   144			for_each_present_cpu(c) {
   145				if (cpus_are_siblings(smp_processor_id(), c))
   146					continue;
   147	
   148				set_cpu_present(c, false);
   149				cores_limited = true;
   150			}
   151		}
   152		if (cores_limited)
   153			pr_warn("Using only one core due to %s%s%s\n",
   154				cca_unsuitable ? "unsuitable CCA" : "",
   155				(cca_unsuitable && cpu_has_dc_aliases) ? " & " : "",
   156				cpu_has_dc_aliases ? "dcache aliasing" : "");
   157	
   158		/*
   159		 * Patch the start of mips_cps_core_entry to provide:
   160		 *
   161		 * s0 = kseg0 CCA
   162		 */
   163		entry_code = (u32 *)&mips_cps_core_entry;
   164		uasm_i_addiu(&entry_code, 16, 0, cca);
 > 165		UASM_i_LA(&entry_code, 17, (long)mips_gcr_base);
   166		BUG_ON((void *)entry_code > (void *)&mips_cps_core_entry_patch_end);
   167		blast_dcache_range((unsigned long)&mips_cps_core_entry,
   168				   (unsigned long)entry_code);
   169		bc_wback_inv((unsigned long)&mips_cps_core_entry,
   170			     (void *)entry_code - (void *)&mips_cps_core_entry);
   171		__sync();
   172	
   173		/* Allocate core boot configuration structs */
   174		ncores = mips_cps_numcores(0);
   175		mips_cps_core_bootcfg = kcalloc(ncores, sizeof(*mips_cps_core_bootcfg),
   176						GFP_KERNEL);
   177		if (!mips_cps_core_bootcfg) {
   178			pr_err("Failed to allocate boot config for %u cores\n", ncores);
   179			goto err_out;
   180		}
   181	
   182		/* Allocate VPE boot configuration structs */
   183		for (c = 0; c < ncores; c++) {
   184			core_vpes = core_vpe_count(0, c);
   185			mips_cps_core_bootcfg[c].vpe_config = kcalloc(core_vpes,
   186					sizeof(*mips_cps_core_bootcfg[c].vpe_config),
   187					GFP_KERNEL);
   188			if (!mips_cps_core_bootcfg[c].vpe_config) {
   189				pr_err("Failed to allocate %u VPE boot configs\n",
   190				       core_vpes);
   191				goto err_out;
   192			}
   193		}
   194	
   195		/* Mark this CPU as booted */
   196		atomic_set(&mips_cps_core_bootcfg[cpu_core(&current_cpu_data)].vpe_mask,
   197			   1 << cpu_vpe_id(&current_cpu_data));
   198	
   199		return;
   200	err_out:
   201		/* Clean up allocations */
   202		if (mips_cps_core_bootcfg) {
   203			for (c = 0; c < ncores; c++)
   204				kfree(mips_cps_core_bootcfg[c].vpe_config);
   205			kfree(mips_cps_core_bootcfg);
   206			mips_cps_core_bootcfg = NULL;
   207		}
   208	
   209		/* Effectively disable SMP by declaring CPUs not present */
   210		for_each_possible_cpu(c) {
   211			if (c == 0)
   212				continue;
   213			set_cpu_present(c, false);
   214		}
   215	}
   216	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
