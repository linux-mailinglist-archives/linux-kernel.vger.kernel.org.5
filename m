Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF91C799E73
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 15:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243223AbjIJNRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 09:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjIJNQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 09:16:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82DFCCD
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694351815; x=1725887815;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NRlH3oZGbbuCMekb6i/2KsmZ0rPCDwFh9Uc0JpBXUmE=;
  b=A6nDZ1vUXIR2Vq3r8lZOMKU7xOBCDFB/+N+uoPZjkiRF64tuT0wtJRnM
   kojZ3sVI9xI/CaSi4yLUkGzbPqxjt+DQZtK9UBNhHvMcGEivt5qREqaOc
   w2j6aiyiO0WfdhqNLnLFeoG0wXU3kBzYVso7L7EbX3pxsJgK2T/2l9gfr
   TY4UulmKc8Lr1urtVvhaLQYtvouAoMEQ6lnTP+so0pwDKYXE07rXqOZHu
   xrkO9Vu/SRioEYabpjCkIyyWM08UIpWiG5jG5sRJ2jWRXAAU9za8k5MEu
   e6p/kSudncCAd6oyu+rlaQla9yuyGEQe5ph95IW5oMsy/NQpq/MJv2WaG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="464262002"
X-IronPort-AV: E=Sophos;i="6.02,241,1688454000"; 
   d="scan'208";a="464262002"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 06:16:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="886191806"
X-IronPort-AV: E=Sophos;i="6.02,241,1688454000"; 
   d="scan'208";a="886191806"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Sep 2023 06:16:32 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfKJ1-0004y0-1o;
        Sun, 10 Sep 2023 13:16:51 +0000
Date:   Sun, 10 Sep 2023 21:16:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: drivers/iommu/iommufd/vfio_compat.c:315:17: sparse: sparse: cast
 removes address space '__user' of expression
Message-ID: <202309102158.44x6nW0r-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   535a265d7f0dd50d8c3a4f8b4f3a452d56bd160f
commit: d624d6652a65ad4f47a58b8651a1ec1163bb81d3 iommufd: vfio container FD ioctl compatibility
date:   9 months ago
config: i386-randconfig-063-20230910 (https://download.01.org/0day-ci/archive/20230910/202309102158.44x6nW0r-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230910/202309102158.44x6nW0r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309102158.44x6nW0r-lkp@intel.com/

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
