Return-Path: <linux-kernel+bounces-128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB69813C94
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A53128169C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76993BB48;
	Thu, 14 Dec 2023 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1XEwg8x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB97054275
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702589236; x=1734125236;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Nb4cbx6ndAFy/GNaPW1An0xpvjDiKZXf0j/RAd6x8og=;
  b=Z1XEwg8xz+RQuDiTjPPpSeyGZ0w/4CqguQtkeHZj6oPuk1C2IJ9d532D
   cXpXokp+uXF62fztysiShUc7fBZgJRINEP+SGpGsALqmXNF4h8nLTTNzl
   kafbKS/6U00GBhKLTUC7YNEcGiixmRz1CGWcV5fq4YSJJmbx6fL3hcWv+
   fI0mdDcTKp5PV81S2LhpJhQ/3i322EOkfXcFo6B3fAB1+twsr4Pgfk52S
   w2Cz8dnUhoR4sTK32FqlRs49wSNxNMVsE0/w3Sbn3zCBBjQQhmvxMiP2P
   cxhpDXbmduSRmP1597QpwnUglDegh2/IeT7/v55WZJwWDYymbYezmGrfp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2344413"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="2344413"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 13:27:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="724212346"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="724212346"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 14 Dec 2023 13:27:14 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDtEe-000Mcq-1L;
	Thu, 14 Dec 2023 21:27:12 +0000
Date: Fri, 15 Dec 2023 05:26:48 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Carpenter <error27@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section
 mismatch in reference: qed_mfw_ext_maps (section: .data) -> qed_mfw_ext_1g
 (section: .init.rodata)
Message-ID: <202312150527.87ozSKcC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: 3a3f1e573a105328a2cca45a7cfbebabbf5e3192 modpost: fix off by one in is_executable_section()
date:   6 months ago
config: openrisc-randconfig-r015-20230110 (https://download.01.org/0day-ci/archive/20231215/202312150527.87ozSKcC-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150527.87ozSKcC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150527.87ozSKcC-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps (section: .data) -> qed_mfw_ext_1g (section: .init.rodata)
>> WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps (section: .data) -> qed_mfw_ext_10g (section: .init.rodata)
>> WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps (section: .data) -> qed_mfw_ext_25g (section: .init.rodata)
>> WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps (section: .data) -> qed_mfw_ext_40g (section: .init.rodata)
>> WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps (section: .data) -> qed_mfw_ext_50g_base_r (section: .init.rodata)
>> WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps (section: .data) -> qed_mfw_ext_50g_base_r2 (section: .init.rodata)
>> WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps (section: .data) -> qed_mfw_ext_100g_base_r2 (section: .init.rodata)
>> WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps (section: .data) -> qed_mfw_ext_100g_base_r4 (section: .init.rodata)
>> WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps (section: .data) -> qed_mfw_legacy_1g (section: .init.rodata)
>> WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps (section: .data) -> qed_mfw_legacy_10g (section: .init.rodata)
>> WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps (section: .data) -> qed_mfw_legacy_20g (section: .init.rodata)
>> WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps (section: .data) -> qed_mfw_legacy_25g (section: .init.rodata)
>> WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps (section: .data) -> qed_mfw_legacy_40g (section: .init.rodata)
>> WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps (section: .data) -> qed_mfw_legacy_50g (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata)
>> WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps (section: .data) -> qede_forced_speed_1000 (section: .init.rodata)
>> WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps (section: .data) -> qede_forced_speed_10000 (section: .init.rodata)
>> WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps (section: .data) -> qede_forced_speed_20000 (section: .init.rodata)
>> WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps (section: .data) -> qede_forced_speed_25000 (section: .init.rodata)
>> WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps (section: .data) -> qede_forced_speed_40000 (section: .init.rodata)
>> WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps (section: .data) -> qede_forced_speed_50000 (section: .init.rodata)
WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps (section: .data) -> qede_forced_speed_100000 (section: .init.rodata)
WARNING: modpost: "__mulsi3" [kernel/locking/test-ww_mutex.ko] undefined!
WARNING: modpost: "__mulsi3" [kernel/trace/preemptirq_delay_test.ko] undefined!
WARNING: modpost: "__mulsi3" [fs/ext2/ext2.ko] undefined!
WARNING: modpost: "__mulsi3" [fs/ntfs/ntfs.ko] undefined!
WARNING: modpost: "__mulsi3" [fs/ntfs3/ntfs3.ko] undefined!
WARNING: modpost: "__mulsi3" [fs/fuse/fuse.ko] undefined!
WARNING: modpost: "__mulsi3" [fs/fuse/cuse.ko] undefined!
WARNING: modpost: "__mulsi3" [fs/fuse/virtiofs.ko] undefined!
WARNING: modpost: "__mulsi3" [fs/jfs/jfs.ko] undefined!
WARNING: modpost: "__mulsi3" [fs/nilfs2/nilfs2.ko] undefined!
WARNING: modpost: suppressed 594 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

