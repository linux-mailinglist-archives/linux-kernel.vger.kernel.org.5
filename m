Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EF38066B2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 06:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376739AbjLFFtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 00:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376643AbjLFFtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 00:49:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F2A18F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 21:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701841768; x=1733377768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KpX/geHnpmimsq733O3OkvfmwoF/8EDiPR7c4SR7YHI=;
  b=RmXSo5HT/uFHd7tDDW8He+IuGCN+OcEnZ99ZrFU9NOFQoPQIn3EVv3Vq
   7wHwhqQpUEl2UNnywSbdqUOe45TIf2MJfy7AWupUjX3+U/ZGqLdkmBYhs
   gpnFtFhSy7zerL5HnF6LxieXNlBy8Hrm81ZVQmQ2lRO6Jwn4GoAI0AeUs
   h9AqoD6+zpOh08IDauKskHVGC/5vhQkCrrQZIWu8SARpJqAhSd7uWAbPA
   H5s5lcgmk1hdslirNVw2rXfpAhUXi+OsececbDXeGCeQ50uvJN5ZL3Lgq
   KFN1SN9wpEjGBXjMJgSVXNBnI6NURxyiReYZ1aDXbeBbQeMIIhwPzJjFl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="396800529"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="396800529"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 21:49:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="889224283"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="889224283"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 05 Dec 2023 21:49:25 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAkmh-000AL8-1y;
        Wed, 06 Dec 2023 05:49:23 +0000
Date:   Wed, 6 Dec 2023 13:48:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, jgg@ziepe.ca,
        kevin.tian@intel.com
Cc:     oe-kbuild-all@lists.linux.dev, will@kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommufd/selftest: Use normal IOMMU registration
Message-ID: <202312061310.UufAZ5vQ-lkp@intel.com>
References: <44ee6854da69e86b208f49752f60a4c18205c32a.1701165201.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ee6854da69e86b208f49752f60a4c18205c32a.1701165201.git.robin.murphy@arm.com>
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

Hi Robin,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20231128]
[cannot apply to joro-iommu/next v6.7-rc3 v6.7-rc2 v6.7-rc1 linus/master v6.7-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Robin-Murphy/iommufd-selftest-Use-a-fwnode-to-distinguish-devices/20231128-185058
base:   next-20231128
patch link:    https://lore.kernel.org/r/44ee6854da69e86b208f49752f60a4c18205c32a.1701165201.git.robin.murphy%40arm.com
patch subject: [PATCH 2/2] iommufd/selftest: Use normal IOMMU registration
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20231206/202312061310.UufAZ5vQ-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312061310.UufAZ5vQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312061310.UufAZ5vQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/iommu/iommufd/selftest.o: in function `iommufd_bus_init':
>> (.init.text+0x10): multiple definition of `init_module'; drivers/iommu/iommufd/main.o:(.init.text+0x10): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
