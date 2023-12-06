Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B51806C61
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377492AbjLFKn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377467AbjLFKn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:43:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F22D18F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701859411; x=1733395411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xi/Tvlsu8RZu+OF2u1C2q0qQLAQ8vl2Z9OL3pG5pHY0=;
  b=E17GA96EIKw6kvwz+DoQ+D1/8qIzuq/0xETBjsSp/Caqw/BocFlrtWY0
   R62TDjOyHHF5Tsd6pZTuCG+rYmdcbLw9yI+p8u//ZxAy+x0AAfrnZjmEt
   gLWpPgtbzOBGLxqAXcHSxSV1KbhHbicGMdWLPTygj5DcBeHvxO9o8GGJn
   CQi7ZTud0CD3s50J0OqCDAun0rMNjNIdes11ZpBW5s/KIpy+lqi+wt0X6
   blu69uuLpWbHYevWC603tGy+O7Bwt4ESTog1fH+HHO5PoOgmSLKPgyrKq
   ni4HkXVZiKivrFQxZJMqrMoPyF+ehXSgb/KztCaSZpnM4t0xowKr4VNjQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="391213753"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="391213753"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 02:43:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="1018524737"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="1018524737"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 06 Dec 2023 02:43:30 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rApNI-000AeK-1L;
        Wed, 06 Dec 2023 10:43:28 +0000
Date:   Wed, 6 Dec 2023 18:42:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, jgg@ziepe.ca,
        kevin.tian@intel.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommufd/selftest: Use normal IOMMU registration
Message-ID: <202312061821.knvqS2Hz-lkp@intel.com>
References: <44ee6854da69e86b208f49752f60a4c18205c32a.1701165201.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ee6854da69e86b208f49752f60a4c18205c32a.1701165201.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20231128]
[cannot apply to joro-iommu/next v6.7-rc3 v6.7-rc2 v6.7-rc1 linus/master v6.7-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Robin-Murphy/iommufd-selftest-Use-a-fwnode-to-distinguish-devices/20231128-185058
base:   next-20231128
patch link:    https://lore.kernel.org/r/44ee6854da69e86b208f49752f60a4c18205c32a.1701165201.git.robin.murphy%40arm.com
patch subject: [PATCH 2/2] iommufd/selftest: Use normal IOMMU registration
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231206/202312061821.knvqS2Hz-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312061821.knvqS2Hz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312061821.knvqS2Hz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iommu/iommufd/selftest.c:1323:12: warning: no previous prototype for function 'iommufd_bus_init' [-Wmissing-prototypes]
   int __init iommufd_bus_init(void)
              ^
   drivers/iommu/iommufd/selftest.c:1323:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __init iommufd_bus_init(void)
   ^
   static 
   drivers/iommu/iommufd/selftest.c:515:1: warning: unused function 'get_md_pagetable_nested' [-Wunused-function]
   get_md_pagetable_nested(struct iommufd_ucmd *ucmd, u32 mockpt_id,
   ^
   2 warnings generated.


vim +/iommufd_bus_init +1323 drivers/iommu/iommufd/selftest.c

  1322	
> 1323	int __init iommufd_bus_init(void)
  1324	{
  1325		return bus_register(&iommufd_mock_bus_type);
  1326	}
  1327	subsys_initcall(iommufd_bus_init);
  1328	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
