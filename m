Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66227838AC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 06:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjHVECl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 00:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjHVECe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 00:02:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D408187;
        Mon, 21 Aug 2023 21:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692676952; x=1724212952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Np9K9D7gW60gwdVKyUbkrixG4oCRBzuj6aPMVEF47M8=;
  b=mFS5vNrA741qCw3t13VCFtBgOuMOpPfl4g5Ot3ZHJIOuB0WNvo9mIRh4
   vL+qEIFY2lmOs/cuChlpKR3xRITnC+S6k3PccAs064JNnAUuOUTfQFqy4
   fxrgYrbm/gmOBPFqMN//iEsAP5Sk+cmh2T+HGNKnBHqFFdoL4n1dMTtIE
   6pHamg2QB+AF0gjZN45/ceWw7oA6isTX1oStumZHRCzXb72pRtKYaUadV
   bmIIiiKYR7yRw+XRuOsCKwrNvoO6fH+6lVU8/2gMcOoB4UcZJxmh4h9Gk
   L7nnhNALntMIrhj5aTWP2afc19+eB1Is1zDDEaXSN8FQZhIkVcZiwOoH2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="376506626"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="376506626"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 21:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="771211418"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="771211418"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 21 Aug 2023 21:02:26 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYIb3-0001KN-2y;
        Tue, 22 Aug 2023 04:02:25 +0000
Date:   Tue, 22 Aug 2023 12:01:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kartik <kkartik@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, sumitg@nvidia.com, arnd@arndb.de,
        pshete@nvidia.co, andriy.shevchenko@linux.intel.com,
        digetx@gmail.com, petlozup@nvidia.com, windhl@126.com,
        frank.li@vivo.com, robh@kernel.org, stefank@nvidia.com,
        pdeschrijver@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/6] soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
Message-ID: <202308221124.bP9Do9ir-lkp@intel.com>
References: <20230818093028.7807-2-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818093028.7807-2-kkartik@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
config: arm-defconfig (https://download.01.org/0day-ci/archive/20230822/202308221124.bP9Do9ir-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230822/202308221124.bP9Do9ir-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308221124.bP9Do9ir-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/soc/tegra/fuse/tegra-apbmisc.c: In function 'tegra_acpi_init_apbmisc':
>> drivers/soc/tegra/fuse/tegra-apbmisc.c:268:18: error: implicit declaration of function 'acpi_dev_get_memory_resources'; did you mean 'acpi_get_event_resources'? [-Werror=implicit-function-declaration]
     268 |         rcount = acpi_dev_get_memory_resources(adev, &resource_list);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                  acpi_get_event_resources
>> drivers/soc/tegra/fuse/tegra-apbmisc.c:280:9: error: implicit declaration of function 'acpi_dev_free_resource_list' [-Werror=implicit-function-declaration]
     280 |         acpi_dev_free_resource_list(&resource_list);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +268 drivers/soc/tegra/fuse/tegra-apbmisc.c

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
