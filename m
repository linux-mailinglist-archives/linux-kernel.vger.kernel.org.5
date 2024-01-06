Return-Path: <linux-kernel+bounces-18707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5036826170
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 21:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 825B1B21CE5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 20:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC56F50C;
	Sat,  6 Jan 2024 20:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3D3g57p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F5BF4F6
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704572373; x=1736108373;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RKhBNxVXz0F+rE96hKcNXWC02MAzoNMSeD1B00Q4SNI=;
  b=Q3D3g57pjPmS+O3GsfhTMoQ3RDPCUvn6nEwselKHIKMEH7vY4Kiyc0j7
   PvbAIAu4eJMOGqXHnBbCadsVqDUzNE6j/ybTVrqIHjgl3a7Y6kDyai4SY
   cXtHyP/9QLHMs4RJmiWJAoR5Yyv/HZPggpJBXGRhCsWE7FHhUhUXB802M
   rttqK4PMivR8VKqLhLd8E/cJP7gJK7yzRKrPfXWPGYDD6T6Mh450Og/af
   Hih7ByNocZ2Zu5EcciHDvdgVZcOQs4M/NAirLeW5CfSwZcZl8073VbiLU
   oqbt/GE13GFWo7QAu4yW/WskBu5Z9iJf8cdxU10wDNER+2Dv6sYynm7s3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="382648042"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="382648042"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 12:19:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="1028051168"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="1028051168"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jan 2024 12:19:23 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMD8a-0002xq-2b;
	Sat, 06 Jan 2024 20:19:20 +0000
Date: Sun, 7 Jan 2024 04:19:12 +0800
From: kernel test robot <lkp@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
	Steve Wahl <steve.wahl@hpe.com>
Subject: drivers/iommu/intel/dmar.c:1050:35: error: '%d' directive writing
 between 1 and 10 bytes into a region of size 9
Message-ID: <202401070415.wky5kFa6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lu,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   95c8a35f1c017327eab3b6a2ff5c04255737c856
commit: 913432f217c843a69ff9d11a6474a7982033087b iommu/vt-d: Use IDA interface to manage iommu sequence id
date:   1 year, 6 months ago
config: x86_64-sof-customedconfig-edison-defconfig (https://download.01.org/0day-ci/archive/20240107/202401070415.wky5kFa6-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401070415.wky5kFa6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401070415.wky5kFa6-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iommu/intel/dmar.c: In function 'dmar_parse_one_drhd':
>> drivers/iommu/intel/dmar.c:1050:35: error: '%d' directive writing between 1 and 10 bytes into a region of size 9 [-Werror=format-overflow=]
    1050 |         sprintf(iommu->name, "dmar%d", iommu->seq_id);
         |                                   ^~
   In function 'alloc_iommu',
       inlined from 'dmar_parse_one_drhd' at drivers/iommu/intel/dmar.c:439:8:
   drivers/iommu/intel/dmar.c:1050:30: note: directive argument in the range [0, 2147483647]
    1050 |         sprintf(iommu->name, "dmar%d", iommu->seq_id);
         |                              ^~~~~~~~
   drivers/iommu/intel/dmar.c:1050:9: note: 'sprintf' output between 6 and 15 bytes into a destination of size 13
    1050 |         sprintf(iommu->name, "dmar%d", iommu->seq_id);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +1050 drivers/iommu/intel/dmar.c

  1025	
  1026	static int alloc_iommu(struct dmar_drhd_unit *drhd)
  1027	{
  1028		struct intel_iommu *iommu;
  1029		u32 ver, sts;
  1030		int agaw = -1;
  1031		int msagaw = -1;
  1032		int err;
  1033	
  1034		if (!drhd->reg_base_addr) {
  1035			warn_invalid_dmar(0, "");
  1036			return -EINVAL;
  1037		}
  1038	
  1039		iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
  1040		if (!iommu)
  1041			return -ENOMEM;
  1042	
  1043		iommu->seq_id = ida_alloc_range(&dmar_seq_ids, 0,
  1044						DMAR_UNITS_SUPPORTED - 1, GFP_KERNEL);
  1045		if (iommu->seq_id < 0) {
  1046			pr_err("Failed to allocate seq_id\n");
  1047			err = iommu->seq_id;
  1048			goto error;
  1049		}
> 1050		sprintf(iommu->name, "dmar%d", iommu->seq_id);
  1051	
  1052		err = map_iommu(iommu, drhd->reg_base_addr);
  1053		if (err) {
  1054			pr_err("Failed to map %s\n", iommu->name);
  1055			goto error_free_seq_id;
  1056		}
  1057	
  1058		err = -EINVAL;
  1059		if (cap_sagaw(iommu->cap) == 0) {
  1060			pr_info("%s: No supported address widths. Not attempting DMA translation.\n",
  1061				iommu->name);
  1062			drhd->ignored = 1;
  1063		}
  1064	
  1065		if (!drhd->ignored) {
  1066			agaw = iommu_calculate_agaw(iommu);
  1067			if (agaw < 0) {
  1068				pr_err("Cannot get a valid agaw for iommu (seq_id = %d)\n",
  1069				       iommu->seq_id);
  1070				drhd->ignored = 1;
  1071			}
  1072		}
  1073		if (!drhd->ignored) {
  1074			msagaw = iommu_calculate_max_sagaw(iommu);
  1075			if (msagaw < 0) {
  1076				pr_err("Cannot get a valid max agaw for iommu (seq_id = %d)\n",
  1077				       iommu->seq_id);
  1078				drhd->ignored = 1;
  1079				agaw = -1;
  1080			}
  1081		}
  1082		iommu->agaw = agaw;
  1083		iommu->msagaw = msagaw;
  1084		iommu->segment = drhd->segment;
  1085	
  1086		iommu->node = NUMA_NO_NODE;
  1087	
  1088		ver = readl(iommu->reg + DMAR_VER_REG);
  1089		pr_info("%s: reg_base_addr %llx ver %d:%d cap %llx ecap %llx\n",
  1090			iommu->name,
  1091			(unsigned long long)drhd->reg_base_addr,
  1092			DMAR_VER_MAJOR(ver), DMAR_VER_MINOR(ver),
  1093			(unsigned long long)iommu->cap,
  1094			(unsigned long long)iommu->ecap);
  1095	
  1096		/* Reflect status in gcmd */
  1097		sts = readl(iommu->reg + DMAR_GSTS_REG);
  1098		if (sts & DMA_GSTS_IRES)
  1099			iommu->gcmd |= DMA_GCMD_IRE;
  1100		if (sts & DMA_GSTS_TES)
  1101			iommu->gcmd |= DMA_GCMD_TE;
  1102		if (sts & DMA_GSTS_QIES)
  1103			iommu->gcmd |= DMA_GCMD_QIE;
  1104	
  1105		raw_spin_lock_init(&iommu->register_lock);
  1106	
  1107		/*
  1108		 * This is only for hotplug; at boot time intel_iommu_enabled won't
  1109		 * be set yet. When intel_iommu_init() runs, it registers the units
  1110		 * present at boot time, then sets intel_iommu_enabled.
  1111		 */
  1112		if (intel_iommu_enabled && !drhd->ignored) {
  1113			err = iommu_device_sysfs_add(&iommu->iommu, NULL,
  1114						     intel_iommu_groups,
  1115						     "%s", iommu->name);
  1116			if (err)
  1117				goto err_unmap;
  1118	
  1119			err = iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
  1120			if (err)
  1121				goto err_sysfs;
  1122		}
  1123	
  1124		drhd->iommu = iommu;
  1125		iommu->drhd = drhd;
  1126	
  1127		return 0;
  1128	
  1129	err_sysfs:
  1130		iommu_device_sysfs_remove(&iommu->iommu);
  1131	err_unmap:
  1132		unmap_iommu(iommu);
  1133	error_free_seq_id:
  1134		ida_free(&dmar_seq_ids, iommu->seq_id);
  1135	error:
  1136		kfree(iommu);
  1137		return err;
  1138	}
  1139	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

