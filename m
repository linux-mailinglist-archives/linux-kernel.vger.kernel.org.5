Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FFF790A52
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 02:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjICAAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 20:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbjICAAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 20:00:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5FACDD
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 17:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693699238; x=1725235238;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=S7WTD2QPamIUc8oBQm9Uxb5b3h5Y3eYUXwjTlcmGics=;
  b=n6KiOxPOY0nSN2fp/utnYPr785ynnGGfj96s833TNJ9D+OdwwE+K2QLM
   F16Db2vaExBYTv7qs6D6Mdv3KfgCbwFgsJYhFwpmfRsd1XVLx9EXylk/6
   RnFIiy+ecLgz4JN4SS7SL1BWviLp4tcP3JFGxziMFPq5m/1O7HtCV3EwF
   hhfuo/JwVGhxP8K5wQZR6K2dS70raeJNohI1MRZnIZ3+JAgIXrWHAoe0X
   r6Ct/PA81XmO2SAxeNWpRFcyJQC6bSuL6DD5fR0LTZP0nzl++uIo8ny9w
   P0lxxlUplhbcDeZf6cAu4tUn0iGoSH998qPbeKGpd/S2+2nx/imgRFkVf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="366635031"
X-IronPort-AV: E=Sophos;i="6.02,223,1688454000"; 
   d="scan'208";a="366635031"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 17:00:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="1071158258"
X-IronPort-AV: E=Sophos;i="6.02,223,1688454000"; 
   d="scan'208";a="1071158258"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Sep 2023 17:00:35 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qcaXZ-0002hn-0Z;
        Sun, 03 Sep 2023 00:00:33 +0000
Date:   Sun, 3 Sep 2023 08:00:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: arch/powerpc/kvm/../../../virt/kvm/vfio.c:89:7: warning: attribute
 declaration must precede definition
Message-ID: <202309030741.82aLACDG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   92901222f83d988617aee37680cb29e1a743b5e4
commit: c1cce6d079b875396c9a7c6838fc5b024758e540 vfio: Compile vfio_group infrastructure optionally
date:   6 weeks ago
config: powerpc64-randconfig-r005-20230903 (https://download.01.org/0day-ci/archive/20230903/202309030741.82aLACDG-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230903/202309030741.82aLACDG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309030741.82aLACDG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/powerpc/kvm/../../../virt/kvm/vfio.c:89:7: warning: attribute declaration must precede definition [-Wignored-attributes]
           fn = symbol_get(vfio_file_iommu_group);
                ^
   include/linux/module.h:805:60: note: expanded from macro 'symbol_get'
   #define symbol_get(x) ({ extern typeof(x) x __attribute__((weak,visibility("hidden"))); &(x); })
                                                              ^
   include/linux/vfio.h:294:35: note: previous definition is here
   static inline struct iommu_group *vfio_file_iommu_group(struct file *file)
                                     ^
>> arch/powerpc/kvm/../../../virt/kvm/vfio.c:89:7: warning: attribute declaration must precede definition [-Wignored-attributes]
           fn = symbol_get(vfio_file_iommu_group);
                ^
   include/linux/module.h:805:65: note: expanded from macro 'symbol_get'
   #define symbol_get(x) ({ extern typeof(x) x __attribute__((weak,visibility("hidden"))); &(x); })
                                                                   ^
   include/linux/vfio.h:294:35: note: previous definition is here
   static inline struct iommu_group *vfio_file_iommu_group(struct file *file)
                                     ^
   2 warnings generated.


vim +89 arch/powerpc/kvm/../../../virt/kvm/vfio.c

4b22ef042d6f54 Jason Gunthorpe      2022-10-07  82  
4b22ef042d6f54 Jason Gunthorpe      2022-10-07  83  #ifdef CONFIG_SPAPR_TCE_IOMMU
50d63b5bbfd122 Jason Gunthorpe      2022-05-04  84  static struct iommu_group *kvm_vfio_file_iommu_group(struct file *file)
121f80ba68f1a5 Alexey Kardashevskiy 2017-03-22  85  {
50d63b5bbfd122 Jason Gunthorpe      2022-05-04  86  	struct iommu_group *(*fn)(struct file *file);
50d63b5bbfd122 Jason Gunthorpe      2022-05-04  87  	struct iommu_group *ret;
121f80ba68f1a5 Alexey Kardashevskiy 2017-03-22  88  
50d63b5bbfd122 Jason Gunthorpe      2022-05-04 @89  	fn = symbol_get(vfio_file_iommu_group);
121f80ba68f1a5 Alexey Kardashevskiy 2017-03-22  90  	if (!fn)
50d63b5bbfd122 Jason Gunthorpe      2022-05-04  91  		return NULL;
121f80ba68f1a5 Alexey Kardashevskiy 2017-03-22  92  
50d63b5bbfd122 Jason Gunthorpe      2022-05-04  93  	ret = fn(file);
121f80ba68f1a5 Alexey Kardashevskiy 2017-03-22  94  
50d63b5bbfd122 Jason Gunthorpe      2022-05-04  95  	symbol_put(vfio_file_iommu_group);
121f80ba68f1a5 Alexey Kardashevskiy 2017-03-22  96  
121f80ba68f1a5 Alexey Kardashevskiy 2017-03-22  97  	return ret;
121f80ba68f1a5 Alexey Kardashevskiy 2017-03-22  98  }
121f80ba68f1a5 Alexey Kardashevskiy 2017-03-22  99  

:::::: The code at line 89 was first introduced by commit
:::::: 50d63b5bbfd12262069ad062611cd5e69c5e9e05 vfio: Change vfio_external_user_iommu_id() to vfio_file_iommu_group()

:::::: TO: Jason Gunthorpe <jgg@nvidia.com>
:::::: CC: Alex Williamson <alex.williamson@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
