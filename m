Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245CD79E550
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239779AbjIMKwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239771AbjIMKwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:52:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE9419AF;
        Wed, 13 Sep 2023 03:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694602346; x=1726138346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uIXZmLagWKHpKAxrnpcZV9CNBqds5leMt0sK3E0/sCc=;
  b=b3UIbLKk3LKG2bCFPqbfU3zUxGGKZ0BkoTl91ZMC1NJ1g6PjeetZxuHR
   bGQ4IO53sb/M7ZHutm/zInIshmV1LaVD5ltZSeQT8Fyti48bF+NZlVonZ
   3E11+QksACaPtyXSsMOJbe1yF0JY/ZUFvsYleTtgPHI9M9FU736ALfivv
   puf3pStxlKgn/xy2IjldY/e/+V7X0ewuuzRqBdaIrFJAi8ee3yUBUXBcC
   Xf/g8JOTvpX3qKlRBXHF44bQmDpYyq0837THTKwdvrBaDZzU69G5KrgyK
   M/Q0YQnLacyD9frBEMfMfSEhSx+BElTt71bOmth2TfEV0pfUL5ETb5w4x
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="377538670"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="377538670"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:52:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="809636480"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="809636480"
Received: from lkp-server02.sh.intel.com (HELO cf13c67269a2) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 13 Sep 2023 03:52:22 -0700
Received: from kbuild by cf13c67269a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgNTo-0000Px-2m;
        Wed, 13 Sep 2023 10:52:20 +0000
Date:   Wed, 13 Sep 2023 18:52:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "guojinhui.liam" <guojinhui.liam@bytedance.com>, rafael@kernel.org,
        lenb@kernel.org, gregkh@linuxfoundation.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        lizefan.x@bytedance.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "guojinhui.liam" <guojinhui.liam@bytedance.com>
Subject: Re: [PATCH] driver core: platform: set numa_node before
 platform_add_device()
Message-ID: <202309131848.CgiiHpZu-lkp@intel.com>
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
[also build test ERROR on v6.6-rc1 next-20230913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/guojinhui-liam/driver-core-platform-set-numa_node-before-platform_add_device/20230912-151119
base:   linus/master
patch link:    https://lore.kernel.org/r/20230912070900.1862-1-guojinhui.liam%40bytedance.com
patch subject: [PATCH] driver core: platform: set numa_node before platform_add_device()
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20230913/202309131848.CgiiHpZu-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309131848.CgiiHpZu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309131848.CgiiHpZu-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/base/platform.c:15:
   In file included from include/linux/of_irq.h:7:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/base/platform.c:15:
   In file included from include/linux/of_irq.h:7:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/base/platform.c:15:
   In file included from include/linux/of_irq.h:7:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/base/platform.c:846:28: error: implicit declaration of function 'acpi_get_node' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
                                            ^
   drivers/base/platform.c:846:28: note: did you mean 'acpi_get_name'?
   include/acpi/acpixf.h:525:9: note: 'acpi_get_name' declared here
                                acpi_get_name(acpi_handle object, u32 name_type,
                                ^
   include/acpi/platform/aclinux.h:93:21: note: expanded from macro 'ACPI_EXTERNAL_RETURN_STATUS'
           static ACPI_INLINE prototype {return(AE_NOT_CONFIGURED);}
                              ^
   drivers/base/platform.c:846:46: error: incomplete definition of type 'struct acpi_device'
                   set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
                                                          ~~~~^
   include/linux/acpi.h:788:8: note: forward declaration of 'struct acpi_device'
   struct acpi_device;
          ^
   12 warnings and 2 errors generated.


vim +/acpi_get_node +846 drivers/base/platform.c

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
