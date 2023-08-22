Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404AB78385A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 05:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjHVDNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 23:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjHVDNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 23:13:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E03186;
        Mon, 21 Aug 2023 20:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692674018; x=1724210018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sIDWcw3K9YRBhz6ckYRBx/0tiDNsLHzeB+cXxebBkfY=;
  b=TzBECRDFZc/e42VvN4/SIFiRx6FOInB5inQRZ0pWJtz1bUIde82OhGD8
   eEfS+2cmznjR9tbFhWNYz4i4u0WJFLM43T2LhR6Qasw0PJgd20VUfW/Nz
   eoOR502OrL7SiHVf/a4pnHONwE+DWr/UiYJ4vGoZGD/zQ3HopM90MTj1W
   jlnlv4+d4W+LcXN7f24sXZAqby5BVEi0w7JbeVfdoVjWuhHOxh8M/V6bd
   NQh1ac3FAItk7BLWGZt/tzQ6fB9dzbkVTqMcHQ8vEwePp39tAzOgbruj1
   yd2COCCcEQQWh8Vwusei4gwPg9Xrh/oYYxSXmnXLWpIeApuhQ4sN3HxXP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="373735371"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="373735371"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 20:13:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="729653448"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="729653448"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 21 Aug 2023 20:13:33 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYHpk-0001Hi-1w;
        Tue, 22 Aug 2023 03:13:32 +0000
Date:   Tue, 22 Aug 2023 11:12:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kartik <kkartik@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, sumitg@nvidia.com, arnd@arndb.de,
        pshete@nvidia.co, andriy.shevchenko@linux.intel.com,
        digetx@gmail.com, petlozup@nvidia.com, windhl@126.com,
        frank.li@vivo.com, robh@kernel.org, stefank@nvidia.com,
        pdeschrijver@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/6] soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
Message-ID: <202308221133.L1WzlvN7-lkp@intel.com>
References: <20230818093028.7807-2-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818093028.7807-2-kkartik@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kartik,

kernel test robot noticed the following build errors:

[auto build test ERROR on tegra/for-next]
[also build test ERROR on soc/for-next linus/master v6.5-rc7 next-20230821]
[cannot apply to tegra-drm/drm/tegra/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kartik/soc-tegra-fuse-Add-tegra_acpi_init_apbmisc/20230821-095539
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
patch link:    https://lore.kernel.org/r/20230818093028.7807-2-kkartik%40nvidia.com
patch subject: [PATCH 1/6] soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
config: arm-randconfig-r004-20230822 (https://download.01.org/0day-ci/archive/20230822/202308221133.L1WzlvN7-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230822/202308221133.L1WzlvN7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308221133.L1WzlvN7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/soc/tegra/fuse/tegra-apbmisc.c:268:11: error: call to undeclared function 'acpi_dev_get_memory_resources'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     268 |         rcount = acpi_dev_get_memory_resources(adev, &resource_list);
         |                  ^
>> drivers/soc/tegra/fuse/tegra-apbmisc.c:280:2: error: call to undeclared function 'acpi_dev_free_resource_list'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     280 |         acpi_dev_free_resource_list(&resource_list);
         |         ^
   2 errors generated.


vim +/acpi_dev_get_memory_resources +268 drivers/soc/tegra/fuse/tegra-apbmisc.c

   253	
   254	void tegra_acpi_init_apbmisc(void)
   255	{
   256		struct acpi_device *adev = NULL;
   257		struct resource *apbmisc, *straps;
   258		struct list_head resource_list;
   259		struct resource_entry *rentry;
   260		int rcount;
   261	
   262		adev = acpi_dev_get_first_match_dev(apbmisc_acpi_match[0].id, NULL, -1);
   263		if (!adev)
   264			return;
   265	
   266		INIT_LIST_HEAD(&resource_list);
   267	
 > 268		rcount = acpi_dev_get_memory_resources(adev, &resource_list);
   269		if (rcount != 2) {
   270			pr_err("failed to get APBMISC memory resources");
   271			return;
   272		}
   273	
   274		rentry = list_first_entry(&resource_list, struct resource_entry, node);
   275		apbmisc = rentry->res;
   276		rentry = list_next_entry(rentry, node);
   277		straps = rentry->res;
   278	
   279		tegra_init_apbmisc_base(apbmisc, straps);
 > 280		acpi_dev_free_resource_list(&resource_list);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
