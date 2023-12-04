Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B09803A39
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjLDQ1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbjLDQ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:27:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1262B0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701707240; x=1733243240;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+iSO+tk+fjhPT+NgD0A2WzHQf904ykpSEJJSfaUXP9g=;
  b=bZDT8fjOOKMola+LuwCVFWjQuTiY20rZpHM04dtv/hojd8E/CCFUku+k
   w6YLPpKUQwOGhyocuKENv2599xl7wPfBP0kDRfoINsdhuxcLv18nYbzkL
   IBMkowyZsvlHBCf/aBVMhMHxMDTbdBl0OeWiW5TLktWBK2zKhSEE6bKIE
   OlNEbPRETeuV7iVcK3RAEydkU/TibZ2BJssCXLTEiiWqW8MAtS9fCfHof
   0NVBTyu9mfWxiqEd4emJt8Je5FY8wmYE4QgmBDQmJ2CRMZv8ThAMfj9Ix
   8jpY0b5ERB6NJahbozwin130mOcqObF4svUQNy1qqOqZMAE41DNvgGCKe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="12473899"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="12473899"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 08:27:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="836637119"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="836637119"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 04 Dec 2023 08:27:18 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rABmu-0007uF-0T;
        Mon, 04 Dec 2023 16:27:16 +0000
Date:   Tue, 5 Dec 2023 00:27:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Deepak Kumar Singh <quic_deesin@quicinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
Subject: drivers/soc/qcom/smem.c:1056:16: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202312050055.4Ug9imUI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: 20bb6c9de1b7e13f11d2ffe73686f4449c426807 soc: qcom: smem: map only partitions used by local HOST
date:   1 year, 8 months ago
config: sh-randconfig-r111-20231116 (https://download.01.org/0day-ci/archive/20231205/202312050055.4Ug9imUI-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231205/202312050055.4Ug9imUI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312050055.4Ug9imUI-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/soc/qcom/smem.c:422:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:422:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:422:16: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:507:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:507:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:507:16: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:520:50: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/soc/qcom/smem.c:520:50: sparse:     expected void *
   drivers/soc/qcom/smem.c:520:50: sparse:     got void [noderef] __iomem *
   drivers/soc/qcom/smem.c:648:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_partition_header *phdr @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:648:22: sparse:     expected struct smem_partition_header *phdr
   drivers/soc/qcom/smem.c:648:22: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:653:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_partition_header *phdr @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:653:22: sparse:     expected struct smem_partition_header *phdr
   drivers/soc/qcom/smem.c:653:22: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:657:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:657:24: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:657:24: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:667:30: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/soc/qcom/smem.c:667:30: sparse:    void *
   drivers/soc/qcom/smem.c:667:30: sparse:    void [noderef] __iomem *
   drivers/soc/qcom/smem.c:688:36: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/qcom/smem.c:697:28: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/qcom/smem.c:706:36: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/qcom/smem.c:721:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:721:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:721:16: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:754:57: sparse: sparse: restricted __le32 degrades to integer
   drivers/soc/qcom/smem.c:775:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_partition_header *header @@     got void [noderef] __iomem * @@
   drivers/soc/qcom/smem.c:775:16: sparse:     expected struct smem_partition_header *header
   drivers/soc/qcom/smem.c:775:16: sparse:     got void [noderef] __iomem *
   drivers/soc/qcom/smem.c:926:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_ptable *ptable @@     got void [noderef] __iomem * @@
   drivers/soc/qcom/smem.c:926:22: sparse:     expected struct smem_ptable *ptable
   drivers/soc/qcom/smem.c:926:22: sparse:     got void [noderef] __iomem *
   drivers/soc/qcom/smem.c:1035:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:1035:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:1035:16: sparse:     got void [noderef] __iomem *virt_base
>> drivers/soc/qcom/smem.c:1056:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/soc/qcom/smem.c:1056:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/soc/qcom/smem.c:1056:16: sparse:     got restricted __le32 *
   drivers/soc/qcom/smem.c:1056:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/soc/qcom/smem.c:1056:52: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/soc/qcom/smem.c:1056:52: sparse:     got restricted __le32 *

vim +1056 drivers/soc/qcom/smem.c

   973	
   974	static int qcom_smem_probe(struct platform_device *pdev)
   975	{
   976		struct smem_header *header;
   977		struct reserved_mem *rmem;
   978		struct qcom_smem *smem;
   979		unsigned long flags;
   980		size_t array_size;
   981		int num_regions;
   982		int hwlock_id;
   983		u32 version;
   984		u32 size;
   985		int ret;
   986		int i;
   987	
   988		num_regions = 1;
   989		if (of_find_property(pdev->dev.of_node, "qcom,rpm-msg-ram", NULL))
   990			num_regions++;
   991	
   992		array_size = num_regions * sizeof(struct smem_region);
   993		smem = devm_kzalloc(&pdev->dev, sizeof(*smem) + array_size, GFP_KERNEL);
   994		if (!smem)
   995			return -ENOMEM;
   996	
   997		smem->dev = &pdev->dev;
   998		smem->num_regions = num_regions;
   999	
  1000		rmem = of_reserved_mem_lookup(pdev->dev.of_node);
  1001		if (rmem) {
  1002			smem->regions[0].aux_base = rmem->base;
  1003			smem->regions[0].size = rmem->size;
  1004		} else {
  1005			/*
  1006			 * Fall back to the memory-region reference, if we're not a
  1007			 * reserved-memory node.
  1008			 */
  1009			ret = qcom_smem_resolve_mem(smem, "memory-region", &smem->regions[0]);
  1010			if (ret)
  1011				return ret;
  1012		}
  1013	
  1014		if (num_regions > 1) {
  1015			ret = qcom_smem_resolve_mem(smem, "qcom,rpm-msg-ram", &smem->regions[1]);
  1016			if (ret)
  1017				return ret;
  1018		}
  1019	
  1020	
  1021		ret = qcom_smem_map_toc(smem, &smem->regions[0]);
  1022		if (ret)
  1023			return ret;
  1024	
  1025		for (i = 1; i < num_regions; i++) {
  1026			smem->regions[i].virt_base = devm_ioremap_wc(&pdev->dev,
  1027								     smem->regions[i].aux_base,
  1028								     smem->regions[i].size);
  1029			if (!smem->regions[i].virt_base) {
  1030				dev_err(&pdev->dev, "failed to remap %pa\n", &smem->regions[i].aux_base);
  1031				return -ENOMEM;
  1032			}
  1033		}
  1034	
  1035		header = smem->regions[0].virt_base;
  1036		if (le32_to_cpu(header->initialized) != 1 ||
  1037		    le32_to_cpu(header->reserved)) {
  1038			dev_err(&pdev->dev, "SMEM is not initialized by SBL\n");
  1039			return -EINVAL;
  1040		}
  1041	
  1042		hwlock_id = of_hwspin_lock_get_id(pdev->dev.of_node, 0);
  1043		if (hwlock_id < 0) {
  1044			if (hwlock_id != -EPROBE_DEFER)
  1045				dev_err(&pdev->dev, "failed to retrieve hwlock\n");
  1046			return hwlock_id;
  1047		}
  1048	
  1049		smem->hwlock = hwspin_lock_request_specific(hwlock_id);
  1050		if (!smem->hwlock)
  1051			return -ENXIO;
  1052	
  1053		ret = hwspin_lock_timeout_irqsave(smem->hwlock, HWSPINLOCK_TIMEOUT, &flags);
  1054		if (ret)
  1055			return ret;
> 1056		size = readl_relaxed(&header->available) + readl_relaxed(&header->free_offset);
  1057		hwspin_unlock_irqrestore(smem->hwlock, &flags);
  1058	
  1059		version = qcom_smem_get_sbl_version(smem);
  1060		/*
  1061		 * smem header mapping is required only in heap version scheme, so unmap
  1062		 * it here. It will be remapped in qcom_smem_map_global() when whole
  1063		 * partition is mapped again.
  1064		 */
  1065		devm_iounmap(smem->dev, smem->regions[0].virt_base);
  1066		switch (version >> 16) {
  1067		case SMEM_GLOBAL_PART_VERSION:
  1068			ret = qcom_smem_set_global_partition(smem);
  1069			if (ret < 0)
  1070				return ret;
  1071			smem->item_count = qcom_smem_get_item_count(smem);
  1072			break;
  1073		case SMEM_GLOBAL_HEAP_VERSION:
  1074			qcom_smem_map_global(smem, size);
  1075			smem->item_count = SMEM_ITEM_COUNT;
  1076			break;
  1077		default:
  1078			dev_err(&pdev->dev, "Unsupported SMEM version 0x%x\n", version);
  1079			return -EINVAL;
  1080		}
  1081	
  1082		BUILD_BUG_ON(SMEM_HOST_APPS >= SMEM_HOST_COUNT);
  1083		ret = qcom_smem_enumerate_partitions(smem, SMEM_HOST_APPS);
  1084		if (ret < 0 && ret != -ENOENT)
  1085			return ret;
  1086	
  1087		__smem = smem;
  1088	
  1089		smem->socinfo = platform_device_register_data(&pdev->dev, "qcom-socinfo",
  1090							      PLATFORM_DEVID_NONE, NULL,
  1091							      0);
  1092		if (IS_ERR(smem->socinfo))
  1093			dev_dbg(&pdev->dev, "failed to register socinfo device\n");
  1094	
  1095		return 0;
  1096	}
  1097	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
