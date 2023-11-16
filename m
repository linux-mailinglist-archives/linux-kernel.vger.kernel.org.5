Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AE27EDAF3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 05:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344454AbjKPEqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 23:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjKPEqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 23:46:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E660219D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 20:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700109965; x=1731645965;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DWg8gmVjVRjLuRrzL5UgsXn3x3er6VzpA6Gex9Qjg48=;
  b=gr4cMTTL+BK7f2dYi03aoY/sUkqS4KPKbAKJ6+FeMpZSkF/OWJXfLUxB
   vimcdDcPE+W6yz1R6AbMPK15bf4HUzm1rxcu23GTo06e+Ltxyfso8e2RT
   EAu+AwMGgAOEDMqqbW6m+T0hyV3Kzq0u75PIHoUCFxqJm2P0wsAU6G1yl
   CgmbJhVuAdSpqoTbKrYjJ4w8qcIv/pDbC8Cp8jwx/UPHygy1+JCEaKDDq
   16tDC4BjhEl8jUBwaxi+GgDyJgEBStDZtCoehoMpre6GkxfpF+QKOI45p
   GR+4RC8JaaQWUjtq1oarLquZz1tczAn/3p6EJeYa1OITwj58vCoVUW2fT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="9654374"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="9654374"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 20:46:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="938714949"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="938714949"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Nov 2023 20:46:02 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3UGO-0001Ig-1v;
        Thu, 16 Nov 2023 04:46:00 +0000
Date:   Thu, 16 Nov 2023 12:45:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: arch/x86/events/amd/uncore.c:941:52: error: '%d' directive output
 may be truncated writing between 1 and 10 bytes into a region of size 8
Message-ID: <202311161239.NeSj2wJT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: 25e56847821f7375bdee7dae1027c7917d07ce4b perf/x86/amd/uncore: Add memory controller support
date:   5 weeks ago
config: x86_64-sof-customedconfig-avs-defconfig (https://download.01.org/0day-ci/archive/20231116/202311161239.NeSj2wJT-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311161239.NeSj2wJT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311161239.NeSj2wJT-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/events/amd/uncore.c: In function 'amd_uncore_umc_ctx_init':
>> arch/x86/events/amd/uncore.c:941:52: error: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 8 [-Werror=format-truncation=]
       snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%d", index);
                                                       ^~
   arch/x86/events/amd/uncore.c:941:43: note: directive argument in the range [0, 2147483647]
       snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%d", index);
                                              ^~~~~~~~~~~~
   arch/x86/events/amd/uncore.c:941:4: note: 'snprintf' output between 10 and 19 bytes into a destination of size 16
       snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%d", index);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +941 arch/x86/events/amd/uncore.c

   900	
   901	static
   902	int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
   903	{
   904		DECLARE_BITMAP(gmask, UNCORE_GROUP_MAX) = { 0 };
   905		u8 group_num_pmus[UNCORE_GROUP_MAX] = { 0 };
   906		u8 group_num_pmcs[UNCORE_GROUP_MAX] = { 0 };
   907		union amd_uncore_info info;
   908		struct amd_uncore_pmu *pmu;
   909		int index = 0, gid, i;
   910	
   911		if (pmu_version < 2)
   912			return 0;
   913	
   914		/* Run just once */
   915		if (uncore->init_done)
   916			return amd_uncore_ctx_init(uncore, cpu);
   917	
   918		/* Find unique groups */
   919		for_each_online_cpu(i) {
   920			info = *per_cpu_ptr(uncore->info, i);
   921			gid = info.split.gid;
   922			if (test_bit(gid, gmask))
   923				continue;
   924	
   925			__set_bit(gid, gmask);
   926			group_num_pmus[gid] = hweight32(info.split.aux_data);
   927			group_num_pmcs[gid] = info.split.num_pmcs;
   928			uncore->num_pmus += group_num_pmus[gid];
   929		}
   930	
   931		uncore->pmus = kzalloc(sizeof(*uncore->pmus) * uncore->num_pmus,
   932				       GFP_KERNEL);
   933		if (!uncore->pmus) {
   934			uncore->num_pmus = 0;
   935			goto done;
   936		}
   937	
   938		for_each_set_bit(gid, gmask, UNCORE_GROUP_MAX) {
   939			for (i = 0; i < group_num_pmus[gid]; i++) {
   940				pmu = &uncore->pmus[index];
 > 941				snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%d", index);
   942				pmu->num_counters = group_num_pmcs[gid] / group_num_pmus[gid];
   943				pmu->msr_base = MSR_F19H_UMC_PERF_CTL + i * pmu->num_counters * 2;
   944				pmu->rdpmc_base = -1;
   945				pmu->group = gid;
   946	
   947				pmu->ctx = alloc_percpu(struct amd_uncore_ctx *);
   948				if (!pmu->ctx)
   949					goto done;
   950	
   951				pmu->pmu = (struct pmu) {
   952					.task_ctx_nr	= perf_invalid_context,
   953					.attr_groups	= amd_uncore_umc_attr_groups,
   954					.name		= pmu->name,
   955					.event_init	= amd_uncore_umc_event_init,
   956					.add		= amd_uncore_add,
   957					.del		= amd_uncore_del,
   958					.start		= amd_uncore_umc_start,
   959					.stop		= amd_uncore_stop,
   960					.read		= amd_uncore_read,
   961					.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
   962					.module		= THIS_MODULE,
   963				};
   964	
   965				if (perf_pmu_register(&pmu->pmu, pmu->pmu.name, -1)) {
   966					free_percpu(pmu->ctx);
   967					pmu->ctx = NULL;
   968					goto done;
   969				}
   970	
   971				pr_info("%d %s counters detected\n", pmu->num_counters,
   972					pmu->pmu.name);
   973	
   974				index++;
   975			}
   976		}
   977	
   978	done:
   979		uncore->num_pmus = index;
   980		uncore->init_done = true;
   981	
   982		return amd_uncore_ctx_init(uncore, cpu);
   983	}
   984	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
