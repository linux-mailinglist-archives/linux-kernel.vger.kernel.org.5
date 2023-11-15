Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6757EBAB3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 01:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbjKOAue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 19:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjKOAuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 19:50:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3707CDB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 16:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700009429; x=1731545429;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Vd08LoyVEWnxZ5T+q5GPkFLvm5e9l0fj5U/OOVJ0kQI=;
  b=ljjdn4xCieUwmhSeuhEp95Qo/xmK1AaMaDEvGwFAW0rOYk5pgnY/e9oP
   1uMezBDUb++3Vrn4b7pCUwh2JymFm5FiCbyCvS2f7hVa2UlxdvoqCQ8zH
   5sUcppHzsF8FmZbRjTlti5HXID5fs/4VrBbsFFIfcY2Xmt92edA6j9D6M
   JHBD+nLp4pFehA8ORnmYX5sGZzqsJTrTvG89chzL7YpbLpcPDH1D2nXak
   XE43MHnF23ARZ6DM5CjBu3pIEolMiJ/4DUqqcwowHu+w3QsgurHflQgGZ
   NA3XGA5/TWzoIpIziESzFzinBfS24JJLQTqoF3hdoVUx5j+LJnqeNwadm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="393637538"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="393637538"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 16:50:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="5964509"
Received: from lkp-server02.sh.intel.com (HELO 83346ef18697) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 14 Nov 2023 16:50:10 -0800
Received: from kbuild by 83346ef18697 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r346Z-0000qR-0N;
        Wed, 15 Nov 2023 00:50:07 +0000
Date:   Wed, 15 Nov 2023 08:49:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Steve Wahl <steve.wahl@hpe.com>
Subject: drivers/iommu/intel/dmar.c:1050:35: error: '%d' directive writing
 between 1 and 10 bytes into a region of size 9
Message-ID: <202311150851.QD7VEYOT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9bacdd8996c77c42ca004440be610692275ff9d0
commit: 913432f217c843a69ff9d11a6474a7982033087b iommu/vt-d: Use IDA interface to manage iommu sequence id
date:   1 year, 4 months ago
config: x86_64-sof-customedconfig-edison-defconfig (https://download.01.org/0day-ci/archive/20231115/202311150851.QD7VEYOT-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231115/202311150851.QD7VEYOT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311150851.QD7VEYOT-lkp@intel.com/

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
