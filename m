Return-Path: <linux-kernel+bounces-23762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F8682B156
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5FF51F28C8C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D074B5AD;
	Thu, 11 Jan 2024 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPJqSVE/"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CEC4E1A3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704985613; x=1736521613;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rmn9GtoIH8QVlbyLqym7TUipHb7yWcfUb9mJnaRvgeo=;
  b=MPJqSVE/KpIrKHSkIDIb+AsmF+j1QidM6bLeP1IRiPh/80lMqDrhveWT
   acUv+DyUaYDvU0dJm8INzJ+XqqlkXBSbvJdGh23ziAUVaSMQzmJYvadii
   OrUeBeq9ZgFe+NgEmJZ9sJZJRYOnilAobZYe7Pe9qiVeOqGvnqVYrl50Q
   hsXeE+8h/K7g577/qg+vu+qlTdG6bDD/f/5tjtzLSDg4hYWdnkDCTDc29
   cJT43cznzSJ4FKXEvx3Ul6OaHewbFIey60XzrsSXjexM0FbdETvNA+cqt
   mcGw59q+hn0pgHQgRbokG2CfDgBjNvy4n9v4so6Yv7l6nK12Ms/wdabU0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="485044267"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="485044267"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 07:06:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="17073185"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 11 Jan 2024 07:06:50 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNwdr-0008OM-2U;
	Thu, 11 Jan 2024 15:06:47 +0000
Date: Thu, 11 Jan 2024 23:05:36 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: drivers/iommu/iommufd/vfio_compat.c:315:17: sparse: sparse: cast
 removes address space '__user' of expression
Message-ID: <202401112201.oMA1N8EM-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   de927f6c0b07d9e698416c5b287c521b07694cac
commit: d624d6652a65ad4f47a58b8651a1ec1163bb81d3 iommufd: vfio container FD ioctl compatibility
date:   1 year, 1 month ago
config: arm64-randconfig-r132-20240105 (https://download.01.org/0day-ci/archive/20240111/202401112201.oMA1N8EM-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240111/202401112201.oMA1N8EM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401112201.oMA1N8EM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iommu/iommufd/vfio_compat.c:315:17: sparse: sparse: cast removes address space '__user' of expression

vim +/__user +315 drivers/iommu/iommufd/vfio_compat.c

   309	
   310	static int iommufd_fill_cap_iova(struct iommufd_ioas *ioas,
   311					 struct vfio_info_cap_header __user *cur,
   312					 size_t avail)
   313	{
   314		struct vfio_iommu_type1_info_cap_iova_range __user *ucap_iovas =
 > 315			container_of(cur,
   316				     struct vfio_iommu_type1_info_cap_iova_range __user,
   317				     header);
   318		struct vfio_iommu_type1_info_cap_iova_range cap_iovas = {
   319			.header = {
   320				.id = VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE,
   321				.version = 1,
   322			},
   323		};
   324		struct interval_tree_span_iter span;
   325	
   326		interval_tree_for_each_span(&span, &ioas->iopt.reserved_itree, 0,
   327					    ULONG_MAX) {
   328			struct vfio_iova_range range;
   329	
   330			if (!span.is_hole)
   331				continue;
   332			range.start = span.start_hole;
   333			range.end = span.last_hole;
   334			if (avail >= struct_size(&cap_iovas, iova_ranges,
   335						 cap_iovas.nr_iovas + 1) &&
   336			    copy_to_user(&ucap_iovas->iova_ranges[cap_iovas.nr_iovas],
   337					 &range, sizeof(range)))
   338				return -EFAULT;
   339			cap_iovas.nr_iovas++;
   340		}
   341		if (avail >= struct_size(&cap_iovas, iova_ranges, cap_iovas.nr_iovas) &&
   342		    copy_to_user(ucap_iovas, &cap_iovas, sizeof(cap_iovas)))
   343			return -EFAULT;
   344		return struct_size(&cap_iovas, iova_ranges, cap_iovas.nr_iovas);
   345	}
   346	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

