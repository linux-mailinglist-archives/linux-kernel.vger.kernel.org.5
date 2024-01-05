Return-Path: <linux-kernel+bounces-17557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFAB824F55
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0DDB2292A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094FA200AA;
	Fri,  5 Jan 2024 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyv6Dk3Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8086200AE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704441041; x=1735977041;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=t8MKxl0UlVrrvohdRZeIZvu2TQYxXODY9FqfArPk0wY=;
  b=cyv6Dk3ZABNvzutIRgiMpY48z/2SMfOxpTeq77U1wFAK6O9NWtT5+ZUc
   aIvbnS8w/TkmNgpohCgoDEWlPziCJz6vhr2Bo5Vzx+GQuOe/5j/AEB2+f
   mPlvR8ussRx4zCNJvi8vwqz5W2YL/s70nKB0WrfIqkQhJpXAWADzt1xaq
   aqipnIqk+Lr0zN1i0JTFy8tQ3qxHtlktJ/NHAbcRyRrRCbb+YDOU56m35
   RKm0KI7TtnW/UZ5mzlvdnPaEF+xFPFJx9tns6uM484WT6g04HJOI+i7xf
   GCTOBPQsdl2MVOSgdFRwlCqSbZfxXOhI2tNjcPXuU9wh/nNVFOq+RkH6s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="18968524"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="18968524"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 23:50:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="851067869"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="851067869"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jan 2024 23:50:38 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLeyS-0000xb-2I;
	Fri, 05 Jan 2024 07:50:36 +0000
Date: Fri, 5 Jan 2024 15:50:04 +0800
From: kernel test robot <lkp@intel.com>
To: Sandipan Das <sandipan.das@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: arch/x86/events/amd/uncore.c:941:52: error: '%d' directive output
 may be truncated writing between 1 and 10 bytes into a region of size 8
Message-ID: <202401051554.teOdw8yt-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sandipan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1f874787ed9a2d78ed59cb21d0d90ac0178eceb0
commit: 25e56847821f7375bdee7dae1027c7917d07ce4b perf/x86/amd/uncore: Add memory controller support
date:   3 months ago
config: x86_64-sof-customedconfig-avs-defconfig (https://download.01.org/0day-ci/archive/20240105/202401051554.teOdw8yt-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240105/202401051554.teOdw8yt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401051554.teOdw8yt-lkp@intel.com/

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

