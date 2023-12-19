Return-Path: <linux-kernel+bounces-6035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4E9819362
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72C51F263E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3775481C3;
	Tue, 19 Dec 2023 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AmgF79CJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2D040C08
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 22:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703023877; x=1734559877;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GQoBEefhBa6xPFQLcnQPKZQcpdK/s+IrJL/IOERV3Cw=;
  b=AmgF79CJXVHA497Hb5xwDlKL23vS2BbvXq+0D9JtkYfl4070SqWbg39+
   xvyeoTFPZwE3k4kf+OQe0ghR+ZmwcStW3RxFcmdjj21RCZOJMrfzDeUfZ
   X7+S2yA3FTLEVsBpL6OeRiRocDvaZC7EduEGBR6LOql8qIOvjdwQ3/T+G
   frf0FlE1nExefwRuSBw6zUo0GIhW3ao/7yRP+QjqwC2mRFEjddHvobWHw
   RaMSGcZMbEn3O2tjLn8PqXl+aIgbT94S6xqFO9y3phkNfA0RhsqXYrdWw
   a1PYwTFETYPUkiW67VHtpeqRLrpvQ3r7Y/tfllMkuiUaheQ7EUAdRMceR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="392896488"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="392896488"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 14:10:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="1107504847"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="1107504847"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 19 Dec 2023 14:10:26 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFiIC-00061G-1o;
	Tue, 19 Dec 2023 22:10:24 +0000
Date: Wed, 20 Dec 2023 06:10:00 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/powerpc/platforms/powernv/opal-core.c:476:58: sparse: sparse:
 incorrect type in argument 2 (different base types)
Message-ID: <202312200649.ij4BcWVk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   55cb5f43689d7a9ea5bf35ef050f12334f197347
commit: d936f8182e1bd18f5e9e6c5e8d8b69261200ca96 powerpc/powernv: Fix type of opal_mpipl_query_tag() addr argument
date:   2 years, 8 months ago
config: powerpc64-randconfig-r113-20231118 (https://download.01.org/0day-ci/archive/20231220/202312200649.ij4BcWVk-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231220/202312200649.ij4BcWVk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312200649.ij4BcWVk-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/powerpc/platforms/powernv/opal-core.c:99:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] n_namesz @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:99:24: sparse:     expected unsigned int [usertype] n_namesz
   arch/powerpc/platforms/powernv/opal-core.c:99:24: sparse:     got restricted __be32 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:100:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] n_descsz @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:100:24: sparse:     expected unsigned int [usertype] n_descsz
   arch/powerpc/platforms/powernv/opal-core.c:100:24: sparse:     got restricted __be32 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:101:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] n_type @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:101:24: sparse:     expected unsigned int [usertype] n_type
   arch/powerpc/platforms/powernv/opal-core.c:101:24: sparse:     got restricted __be32 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:122:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected int [usertype] pr_pid @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:122:34: sparse:     expected int [usertype] pr_pid
   arch/powerpc/platforms/powernv/opal-core.c:122:34: sparse:     got restricted __be32 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:123:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected int [usertype] pr_ppid @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:123:34: sparse:     expected int [usertype] pr_ppid
   arch/powerpc/platforms/powernv/opal-core.c:123:34: sparse:     got restricted __be32 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:133:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected short pr_cursig @@     got restricted __be16 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:133:44: sparse:     expected short pr_cursig
   arch/powerpc/platforms/powernv/opal-core.c:133:44: sparse:     got restricted __be16 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:146:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:146:21: sparse:     expected unsigned long long [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:146:21: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:147:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:147:21: sparse:     expected unsigned long long [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:147:21: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:150:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:150:21: sparse:     expected unsigned long long [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:150:21: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:277:17: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-core.c:277:17: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-core.c:363:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] e_type @@     got restricted __be16 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:363:21: sparse:     expected unsigned short [usertype] e_type
   arch/powerpc/platforms/powernv/opal-core.c:363:21: sparse:     got restricted __be16 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:364:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] e_machine @@     got restricted __be16 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:364:24: sparse:     expected unsigned short [usertype] e_machine
   arch/powerpc/platforms/powernv/opal-core.c:364:24: sparse:     got restricted __be16 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:365:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] e_version @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:365:24: sparse:     expected unsigned int [usertype] e_version
   arch/powerpc/platforms/powernv/opal-core.c:365:24: sparse:     got restricted __be32 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:367:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] e_phoff @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:367:22: sparse:     expected unsigned long long [usertype] e_phoff
   arch/powerpc/platforms/powernv/opal-core.c:367:22: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:371:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] e_ehsize @@     got restricted __be16 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:371:23: sparse:     expected unsigned short [usertype] e_ehsize
   arch/powerpc/platforms/powernv/opal-core.c:371:23: sparse:     got restricted __be16 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:372:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] e_phentsize @@     got restricted __be16 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:372:26: sparse:     expected unsigned short [usertype] e_phentsize
   arch/powerpc/platforms/powernv/opal-core.c:372:26: sparse:     got restricted __be16 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:380:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] p_type @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:380:25: sparse:     expected unsigned int [usertype] p_type
   arch/powerpc/platforms/powernv/opal-core.c:380:25: sparse:     got restricted __be32 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:384:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] p_offset @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:384:25: sparse:     expected unsigned long long [usertype] p_offset
   arch/powerpc/platforms/powernv/opal-core.c:384:25: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:385:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] p_memsz @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:385:41: sparse:     expected unsigned long long [usertype] p_memsz
   arch/powerpc/platforms/powernv/opal-core.c:385:41: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:394:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] p_type @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:394:33: sparse:     expected unsigned int [usertype] p_type
   arch/powerpc/platforms/powernv/opal-core.c:394:33: sparse:     got restricted __be32 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:395:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] p_flags @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:395:33: sparse:     expected unsigned int [usertype] p_flags
   arch/powerpc/platforms/powernv/opal-core.c:395:33: sparse:     got restricted __be32 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:406:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] p_paddr @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:406:33: sparse:     expected unsigned long long [usertype] p_paddr
   arch/powerpc/platforms/powernv/opal-core.c:406:33: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:407:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] p_vaddr @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:407:33: sparse:     expected unsigned long long [usertype] p_vaddr
   arch/powerpc/platforms/powernv/opal-core.c:407:33: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:408:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] p_memsz @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:408:50: sparse:     expected unsigned long long [usertype] p_memsz
   arch/powerpc/platforms/powernv/opal-core.c:408:50: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:410:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] p_offset @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:410:33: sparse:     expected unsigned long long [usertype] p_offset
   arch/powerpc/platforms/powernv/opal-core.c:410:33: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:417:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] e_phnum @@     got restricted __be16 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:417:22: sparse:     expected unsigned short [usertype] e_phnum
   arch/powerpc/platforms/powernv/opal-core.c:417:22: sparse:     got restricted __be16 [usertype]
>> arch/powerpc/platforms/powernv/opal-core.c:476:58: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be64 [usertype] *addr @@     got unsigned long long * @@
   arch/powerpc/platforms/powernv/opal-core.c:476:58: sparse:     expected restricted __be64 [usertype] *addr
   arch/powerpc/platforms/powernv/opal-core.c:476:58: sparse:     got unsigned long long *
   arch/powerpc/platforms/powernv/opal-core.c:482:16: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-core.c:487:57: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be64 [usertype] *addr @@     got unsigned long long * @@
   arch/powerpc/platforms/powernv/opal-core.c:487:57: sparse:     expected restricted __be64 [usertype] *addr
   arch/powerpc/platforms/powernv/opal-core.c:487:57: sparse:     got unsigned long long *
   arch/powerpc/platforms/powernv/opal-core.c:493:16: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-core.c: note: in included file:
   arch/powerpc/platforms/powernv/opal-fadump.h:138:33: sparse: sparse: restricted __be64 degrades to integer

vim +476 arch/powerpc/platforms/powernv/opal-core.c

6f713d18144ce8 Hari Bathini  2019-09-11  450  
6f713d18144ce8 Hari Bathini  2019-09-11  451  static void __init opalcore_config_init(void)
6f713d18144ce8 Hari Bathini  2019-09-11  452  {
6f713d18144ce8 Hari Bathini  2019-09-11  453  	u32 idx, cpu_data_version;
6f713d18144ce8 Hari Bathini  2019-09-11  454  	struct device_node *np;
6f713d18144ce8 Hari Bathini  2019-09-11  455  	const __be32 *prop;
6f713d18144ce8 Hari Bathini  2019-09-11  456  	u64 addr = 0;
6f713d18144ce8 Hari Bathini  2019-09-11  457  	int i, ret;
6f713d18144ce8 Hari Bathini  2019-09-11  458  
6f713d18144ce8 Hari Bathini  2019-09-11  459  	np = of_find_node_by_path("/ibm,opal/dump");
6f713d18144ce8 Hari Bathini  2019-09-11  460  	if (np == NULL)
6f713d18144ce8 Hari Bathini  2019-09-11  461  		return;
6f713d18144ce8 Hari Bathini  2019-09-11  462  
6f713d18144ce8 Hari Bathini  2019-09-11  463  	if (!of_device_is_compatible(np, "ibm,opal-dump")) {
6f713d18144ce8 Hari Bathini  2019-09-11  464  		pr_warn("Support missing for this f/w version!\n");
6f713d18144ce8 Hari Bathini  2019-09-11  465  		return;
6f713d18144ce8 Hari Bathini  2019-09-11  466  	}
6f713d18144ce8 Hari Bathini  2019-09-11  467  
6f713d18144ce8 Hari Bathini  2019-09-11  468  	/* Check if dump has been initiated on last reboot */
6f713d18144ce8 Hari Bathini  2019-09-11  469  	prop = of_get_property(np, "mpipl-boot", NULL);
6f713d18144ce8 Hari Bathini  2019-09-11  470  	if (!prop) {
6f713d18144ce8 Hari Bathini  2019-09-11  471  		of_node_put(np);
6f713d18144ce8 Hari Bathini  2019-09-11  472  		return;
6f713d18144ce8 Hari Bathini  2019-09-11  473  	}
6f713d18144ce8 Hari Bathini  2019-09-11  474  
6f713d18144ce8 Hari Bathini  2019-09-11  475  	/* Get OPAL metadata */
6f713d18144ce8 Hari Bathini  2019-09-11 @476  	ret = opal_mpipl_query_tag(OPAL_MPIPL_TAG_OPAL, &addr);
6f713d18144ce8 Hari Bathini  2019-09-11  477  	if ((ret != OPAL_SUCCESS) || !addr) {
6f713d18144ce8 Hari Bathini  2019-09-11  478  		pr_err("Failed to get OPAL metadata (%d)\n", ret);
6f713d18144ce8 Hari Bathini  2019-09-11  479  		goto error_out;
6f713d18144ce8 Hari Bathini  2019-09-11  480  	}
6f713d18144ce8 Hari Bathini  2019-09-11  481  
6f713d18144ce8 Hari Bathini  2019-09-11  482  	addr = be64_to_cpu(addr);
6f713d18144ce8 Hari Bathini  2019-09-11  483  	pr_debug("OPAL metadata addr: %llx\n", addr);
6f713d18144ce8 Hari Bathini  2019-09-11  484  	opalc_metadata = __va(addr);
6f713d18144ce8 Hari Bathini  2019-09-11  485  
6f713d18144ce8 Hari Bathini  2019-09-11  486  	/* Get OPAL CPU metadata */
6f713d18144ce8 Hari Bathini  2019-09-11  487  	ret = opal_mpipl_query_tag(OPAL_MPIPL_TAG_CPU, &addr);
6f713d18144ce8 Hari Bathini  2019-09-11  488  	if ((ret != OPAL_SUCCESS) || !addr) {
6f713d18144ce8 Hari Bathini  2019-09-11  489  		pr_err("Failed to get OPAL CPU metadata (%d)\n", ret);
6f713d18144ce8 Hari Bathini  2019-09-11  490  		goto error_out;
6f713d18144ce8 Hari Bathini  2019-09-11  491  	}
6f713d18144ce8 Hari Bathini  2019-09-11  492  
6f713d18144ce8 Hari Bathini  2019-09-11  493  	addr = be64_to_cpu(addr);
6f713d18144ce8 Hari Bathini  2019-09-11  494  	pr_debug("CPU metadata addr: %llx\n", addr);
6f713d18144ce8 Hari Bathini  2019-09-11  495  	opalc_cpu_metadata = __va(addr);
6f713d18144ce8 Hari Bathini  2019-09-11  496  
6f713d18144ce8 Hari Bathini  2019-09-11  497  	/* Allocate memory for config buffer */
6f713d18144ce8 Hari Bathini  2019-09-11  498  	oc_conf = kzalloc(sizeof(struct opalcore_config), GFP_KERNEL);
6f713d18144ce8 Hari Bathini  2019-09-11  499  	if (oc_conf == NULL)
6f713d18144ce8 Hari Bathini  2019-09-11  500  		goto error_out;
6f713d18144ce8 Hari Bathini  2019-09-11  501  
6f713d18144ce8 Hari Bathini  2019-09-11  502  	/* Parse OPAL metadata */
6f713d18144ce8 Hari Bathini  2019-09-11  503  	if (opalc_metadata->version != OPAL_MPIPL_VERSION) {
6f713d18144ce8 Hari Bathini  2019-09-11  504  		pr_warn("Supported OPAL metadata version: %u, found: %u!\n",
6f713d18144ce8 Hari Bathini  2019-09-11  505  			OPAL_MPIPL_VERSION, opalc_metadata->version);
6f713d18144ce8 Hari Bathini  2019-09-11  506  		pr_warn("WARNING: F/W using newer OPAL metadata format!!\n");
6f713d18144ce8 Hari Bathini  2019-09-11  507  	}
6f713d18144ce8 Hari Bathini  2019-09-11  508  
6f713d18144ce8 Hari Bathini  2019-09-11  509  	oc_conf->ptload_cnt = 0;
6f713d18144ce8 Hari Bathini  2019-09-11  510  	idx = be32_to_cpu(opalc_metadata->region_cnt);
6f713d18144ce8 Hari Bathini  2019-09-11  511  	if (idx > MAX_PT_LOAD_CNT) {
6f713d18144ce8 Hari Bathini  2019-09-11  512  		pr_warn("WARNING: OPAL regions count (%d) adjusted to limit (%d)",
8ec5cb12cd957e Qinglang Miao 2020-09-16  513  			idx, MAX_PT_LOAD_CNT);
6f713d18144ce8 Hari Bathini  2019-09-11  514  		idx = MAX_PT_LOAD_CNT;
6f713d18144ce8 Hari Bathini  2019-09-11  515  	}
6f713d18144ce8 Hari Bathini  2019-09-11  516  	for (i = 0; i < idx; i++) {
6f713d18144ce8 Hari Bathini  2019-09-11  517  		oc_conf->ptload_addr[oc_conf->ptload_cnt] =
6f713d18144ce8 Hari Bathini  2019-09-11  518  				be64_to_cpu(opalc_metadata->region[i].dest);
6f713d18144ce8 Hari Bathini  2019-09-11  519  		oc_conf->ptload_size[oc_conf->ptload_cnt++] =
6f713d18144ce8 Hari Bathini  2019-09-11  520  				be64_to_cpu(opalc_metadata->region[i].size);
6f713d18144ce8 Hari Bathini  2019-09-11  521  	}
6f713d18144ce8 Hari Bathini  2019-09-11  522  	oc_conf->ptload_cnt = i;
6f713d18144ce8 Hari Bathini  2019-09-11  523  	oc_conf->crashing_cpu = be32_to_cpu(opalc_metadata->crashing_pir);
6f713d18144ce8 Hari Bathini  2019-09-11  524  
6f713d18144ce8 Hari Bathini  2019-09-11  525  	if (!oc_conf->ptload_cnt) {
6f713d18144ce8 Hari Bathini  2019-09-11  526  		pr_err("OPAL memory regions not found\n");
6f713d18144ce8 Hari Bathini  2019-09-11  527  		goto error_out;
6f713d18144ce8 Hari Bathini  2019-09-11  528  	}
6f713d18144ce8 Hari Bathini  2019-09-11  529  
6f713d18144ce8 Hari Bathini  2019-09-11  530  	/* Parse OPAL CPU metadata */
6f713d18144ce8 Hari Bathini  2019-09-11  531  	cpu_data_version = be32_to_cpu(opalc_cpu_metadata->cpu_data_version);
6f713d18144ce8 Hari Bathini  2019-09-11  532  	if (cpu_data_version != HDAT_FADUMP_CPU_DATA_VER) {
6f713d18144ce8 Hari Bathini  2019-09-11  533  		pr_warn("Supported CPU data version: %u, found: %u!\n",
6f713d18144ce8 Hari Bathini  2019-09-11  534  			HDAT_FADUMP_CPU_DATA_VER, cpu_data_version);
6f713d18144ce8 Hari Bathini  2019-09-11  535  		pr_warn("WARNING: F/W using newer CPU state data format!!\n");
6f713d18144ce8 Hari Bathini  2019-09-11  536  	}
6f713d18144ce8 Hari Bathini  2019-09-11  537  
6f713d18144ce8 Hari Bathini  2019-09-11  538  	addr = be64_to_cpu(opalc_cpu_metadata->region[0].dest);
6f713d18144ce8 Hari Bathini  2019-09-11  539  	if (!addr) {
6f713d18144ce8 Hari Bathini  2019-09-11  540  		pr_err("CPU state data not found!\n");
6f713d18144ce8 Hari Bathini  2019-09-11  541  		goto error_out;
6f713d18144ce8 Hari Bathini  2019-09-11  542  	}
6f713d18144ce8 Hari Bathini  2019-09-11  543  	oc_conf->cpu_state_destination_vaddr = (u64)__va(addr);
6f713d18144ce8 Hari Bathini  2019-09-11  544  
6f713d18144ce8 Hari Bathini  2019-09-11  545  	oc_conf->cpu_state_data_size =
6f713d18144ce8 Hari Bathini  2019-09-11  546  			be64_to_cpu(opalc_cpu_metadata->region[0].size);
6f713d18144ce8 Hari Bathini  2019-09-11  547  	oc_conf->cpu_state_entry_size =
6f713d18144ce8 Hari Bathini  2019-09-11  548  			be32_to_cpu(opalc_cpu_metadata->cpu_data_size);
6f713d18144ce8 Hari Bathini  2019-09-11  549  
6f713d18144ce8 Hari Bathini  2019-09-11  550  	if ((oc_conf->cpu_state_entry_size == 0) ||
6f713d18144ce8 Hari Bathini  2019-09-11  551  	    (oc_conf->cpu_state_entry_size > oc_conf->cpu_state_data_size)) {
6f713d18144ce8 Hari Bathini  2019-09-11  552  		pr_err("CPU state data is invalid.\n");
6f713d18144ce8 Hari Bathini  2019-09-11  553  		goto error_out;
6f713d18144ce8 Hari Bathini  2019-09-11  554  	}
6f713d18144ce8 Hari Bathini  2019-09-11  555  	oc_conf->num_cpus = (oc_conf->cpu_state_data_size /
6f713d18144ce8 Hari Bathini  2019-09-11  556  			     oc_conf->cpu_state_entry_size);
6f713d18144ce8 Hari Bathini  2019-09-11  557  
6f713d18144ce8 Hari Bathini  2019-09-11  558  	of_node_put(np);
6f713d18144ce8 Hari Bathini  2019-09-11  559  	return;
6f713d18144ce8 Hari Bathini  2019-09-11  560  
6f713d18144ce8 Hari Bathini  2019-09-11  561  error_out:
6f713d18144ce8 Hari Bathini  2019-09-11  562  	pr_err("Could not export /sys/firmware/opal/core\n");
6f713d18144ce8 Hari Bathini  2019-09-11  563  	opalcore_cleanup();
6f713d18144ce8 Hari Bathini  2019-09-11  564  	of_node_put(np);
6f713d18144ce8 Hari Bathini  2019-09-11  565  }
6f713d18144ce8 Hari Bathini  2019-09-11  566  

:::::: The code at line 476 was first introduced by commit
:::::: 6f713d18144ce86c9f01cdf64222d6339e26129e powerpc/opalcore: export /sys/firmware/opal/core for analysing opal crashes

:::::: TO: Hari Bathini <hbathini@linux.vnet.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

