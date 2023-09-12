Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656D079D624
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbjILQWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjILQWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:22:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3179510D;
        Tue, 12 Sep 2023 09:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694535748; x=1726071748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mwK32jgEcjiMlJxPxk0G0xYgI3vfMvfC8fyaTAmOUkQ=;
  b=hc0CsrDhA0kF05V3a9yDoaLb04iJxbSXGhgxqTOzSjKCSfS45sbHTROw
   pX50etV23pZULg0vC7bAPXWbqnlLrdu74GFOvyJ6cv+L0EVG0S/DAuu+x
   YpoOazIDRho9/niX3//mQDSCsT+7i4DSJqr3nj0gdBb+SjxoKObtkS/KW
   jzmbasFFF229HfLdvxNmu5Io9kBc+0YlavuIMevo2LJkdV1kA0iW7nIYF
   sh/7Q1o/+kKFXXKjp1arzDw0YdsCpcQJP/ad0urFwj7BAYDLy4MF0hmHn
   k+upeIOeWK/cG6kuk5HAnoYTOBIMvUY5C8i4cboPM7fLbrRQsZ0SUfFeG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="358702305"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="358702305"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:19:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="867435721"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="867435721"
Received: from lkp-server02.sh.intel.com (HELO 0a6943a0b3e1) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 12 Sep 2023 09:19:49 -0700
Received: from kbuild by 0a6943a0b3e1 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qg665-0000DX-0V;
        Tue, 12 Sep 2023 16:18:58 +0000
Date:   Wed, 13 Sep 2023 00:11:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "guojinhui.liam" <guojinhui.liam@bytedance.com>, rafael@kernel.org,
        lenb@kernel.org, gregkh@linuxfoundation.org
Cc:     oe-kbuild-all@lists.linux.dev, lizefan.x@bytedance.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "guojinhui.liam" <guojinhui.liam@bytedance.com>
Subject: Re: [PATCH] driver core: platform: set numa_node before
 platform_add_device()
Message-ID: <202309122309.mbxAnAIe-lkp@intel.com>
References: <20230912070900.1862-1-guojinhui.liam@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912070900.1862-1-guojinhui.liam@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guojinhui.liam,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6-rc1 next-20230912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/guojinhui-liam/driver-core-platform-set-numa_node-before-platform_add_device/20230912-151119
base:   linus/master
patch link:    https://lore.kernel.org/r/20230912070900.1862-1-guojinhui.liam%40bytedance.com
patch subject: [PATCH] driver core: platform: set numa_node before platform_add_device()
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20230912/202309122309.mbxAnAIe-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230912/202309122309.mbxAnAIe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/base/platform.c: In function 'platform_device_register_full':
>> drivers/base/platform.c:846:42: error: implicit declaration of function 'acpi_get_node'; did you mean 'acpi_get_name'? [-Werror=implicit-function-declaration]
     846 |                 set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
         |                                          ^~~~~~~~~~~~~
         |                                          acpi_get_name
>> drivers/base/platform.c:846:60: error: invalid use of undefined type 'struct acpi_device'
     846 |                 set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
         |                                                            ^~
   cc1: some warnings being treated as errors


vim +846 drivers/base/platform.c

   797	
   798	/**
   799	 * platform_device_register_full - add a platform-level device with
   800	 * resources and platform-specific data
   801	 *
   802	 * @pdevinfo: data used to create device
   803	 *
   804	 * Returns &struct platform_device pointer on success, or ERR_PTR() on error.
   805	 */
   806	struct platform_device *platform_device_register_full(
   807			const struct platform_device_info *pdevinfo)
   808	{
   809		int ret;
   810		struct platform_device *pdev;
   811		struct acpi_device *adev = to_acpi_device_node(pdevinfo->fwnode);
   812	
   813		pdev = platform_device_alloc(pdevinfo->name, pdevinfo->id);
   814		if (!pdev)
   815			return ERR_PTR(-ENOMEM);
   816	
   817		pdev->dev.parent = pdevinfo->parent;
   818		pdev->dev.fwnode = pdevinfo->fwnode;
   819		pdev->dev.of_node = of_node_get(to_of_node(pdev->dev.fwnode));
   820		pdev->dev.of_node_reused = pdevinfo->of_node_reused;
   821	
   822		if (pdevinfo->dma_mask) {
   823			pdev->platform_dma_mask = pdevinfo->dma_mask;
   824			pdev->dev.dma_mask = &pdev->platform_dma_mask;
   825			pdev->dev.coherent_dma_mask = pdevinfo->dma_mask;
   826		}
   827	
   828		ret = platform_device_add_resources(pdev,
   829				pdevinfo->res, pdevinfo->num_res);
   830		if (ret)
   831			goto err;
   832	
   833		ret = platform_device_add_data(pdev,
   834				pdevinfo->data, pdevinfo->size_data);
   835		if (ret)
   836			goto err;
   837	
   838		if (pdevinfo->properties) {
   839			ret = device_create_managed_software_node(&pdev->dev,
   840								  pdevinfo->properties, NULL);
   841			if (ret)
   842				goto err;
   843		}
   844	
   845		if (adev)
 > 846			set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
   847	
   848		ret = platform_device_add(pdev);
   849		if (ret) {
   850	err:
   851			ACPI_COMPANION_SET(&pdev->dev, NULL);
   852			platform_device_put(pdev);
   853			return ERR_PTR(ret);
   854		}
   855	
   856		return pdev;
   857	}
   858	EXPORT_SYMBOL_GPL(platform_device_register_full);
   859	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
