Return-Path: <linux-kernel+bounces-20385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C10A9827DF4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A69228585C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C656FBC;
	Tue,  9 Jan 2024 04:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YhxfF+8k"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0E91371;
	Tue,  9 Jan 2024 04:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704775578; x=1736311578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qRDK6Oo9AgDzs3fiuyV3rGxNrCnaC1HrYpHIF810WxY=;
  b=YhxfF+8kziYysYFxLr+RNmFI2iIg0W8OROPXT5phmpgHUkugQNncSdwu
   4aL5UpaC2kSSZs9waA9/waEwiN7zmk1WmKvJb6xtrlT9MpQZzO71wmK2Z
   j72mlb2RHR06H3RgknlqXyMZf2JJGiIL4dCBZ3pal7V7jNRyGXubH/g7G
   AIgiLsxsVW5QCdSa1rZeRgnhgWigwvgaZzR/IUp8eQLqQLB54widxHMEn
   zInDRq3oB/efPGJgW70ZIlw9BumTNE7kwBSUlFEObq2+W/HAiKfVXnvQ9
   9r9CkFysOxcea0njbClPX4EFDnInjN2kHzUsi0iJxnNxRCWzQ7455KQli
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="395242008"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="395242008"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 20:46:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="900617596"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="900617596"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jan 2024 20:46:13 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rN40B-0005TY-0t;
	Tue, 09 Jan 2024 04:46:11 +0000
Date: Tue, 9 Jan 2024 12:45:15 +0800
From: kernel test robot <lkp@intel.com>
To: James Tai <james.tai@realtek.com>, Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/6] irqchip: Introduce RTD1319D support using the
 Realtek common interrupt controller driver
Message-ID: <202401091218.1mO2PJxw-lkp@intel.com>
References: <20231228060825.1380439-5-james.tai@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228060825.1380439-5-james.tai@realtek.com>

Hi James,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on robh/for-next linus/master v6.7 next-20240108]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Tai/dt-bindings-interrupt-controller-Add-support-for-Realtek-DHC-SoCs/20231228-141213
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20231228060825.1380439-5-james.tai%40realtek.com
patch subject: [PATCH v4 4/6] irqchip: Introduce RTD1319D support using the Realtek common interrupt controller driver
config: s390-randconfig-r113-20240109 (https://download.01.org/0day-ci/archive/20240109/202401091218.1mO2PJxw-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 7e186d366d6c7def0543acc255931f617e76dff0)
reproduce: (https://download.01.org/0day-ci/archive/20240109/202401091218.1mO2PJxw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401091218.1mO2PJxw-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/irqchip/irq-realtek-intc-common.c:8:
   In file included from include/linux/irqchip.h:17:
   In file included from include/linux/of_irq.h:7:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/irqchip/irq-realtek-intc-common.c:8:
   In file included from include/linux/irqchip.h:17:
   In file included from include/linux/of_irq.h:7:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/irqchip/irq-realtek-intc-common.c:8:
   In file included from include/linux/irqchip.h:17:
   In file included from include/linux/of_irq.h:7:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/irqchip/irq-realtek-intc-common.c:204:3: error: call to undeclared function 'iounmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     204 |                 iounmap(data->base);
         |                 ^
   arch/s390/include/asm/io.h:29:17: note: expanded from macro 'iounmap'
      29 | #define iounmap iounmap
         |                 ^
   drivers/irqchip/irq-realtek-intc-common.c:204:3: note: did you mean 'vunmap'?
   arch/s390/include/asm/io.h:29:17: note: expanded from macro 'iounmap'
      29 | #define iounmap iounmap
         |                 ^
   include/linux/vmalloc.h:167:13: note: 'vunmap' declared here
     167 | extern void vunmap(const void *addr);
         |             ^
   12 warnings and 1 error generated.


vim +/iounmap +204 drivers/irqchip/irq-realtek-intc-common.c

59fe9dce1f284e James Tai 2023-12-28  161  
59fe9dce1f284e James Tai 2023-12-28  162  int realtek_intc_probe(struct platform_device *pdev, const struct realtek_intc_info *info)
59fe9dce1f284e James Tai 2023-12-28  163  {
59fe9dce1f284e James Tai 2023-12-28  164  	struct realtek_intc_data *data;
59fe9dce1f284e James Tai 2023-12-28  165  	struct device *dev = &pdev->dev;
59fe9dce1f284e James Tai 2023-12-28  166  	struct device_node *node = dev->of_node;
59fe9dce1f284e James Tai 2023-12-28  167  	int ret, i;
59fe9dce1f284e James Tai 2023-12-28  168  
59fe9dce1f284e James Tai 2023-12-28  169  	data = devm_kzalloc(dev, struct_size(data, subset_data, info->subset_num), GFP_KERNEL);
59fe9dce1f284e James Tai 2023-12-28  170  	if (!data)
59fe9dce1f284e James Tai 2023-12-28  171  		return -ENOMEM;
59fe9dce1f284e James Tai 2023-12-28  172  
59fe9dce1f284e James Tai 2023-12-28  173  	data->base = of_iomap(node, 0);
59fe9dce1f284e James Tai 2023-12-28  174  	if (!data->base)
59fe9dce1f284e James Tai 2023-12-28  175  		goto iomap_cleanup;
59fe9dce1f284e James Tai 2023-12-28  176  
59fe9dce1f284e James Tai 2023-12-28  177  	data->info = info;
59fe9dce1f284e James Tai 2023-12-28  178  
59fe9dce1f284e James Tai 2023-12-28  179  	raw_spin_lock_init(&data->lock);
59fe9dce1f284e James Tai 2023-12-28  180  
59fe9dce1f284e James Tai 2023-12-28  181  	data->domain = irq_domain_add_linear(node, 32, &realtek_intc_domain_ops, data);
59fe9dce1f284e James Tai 2023-12-28  182  	if (!data->domain)
59fe9dce1f284e James Tai 2023-12-28  183  		goto iomap_cleanup;
59fe9dce1f284e James Tai 2023-12-28  184  
59fe9dce1f284e James Tai 2023-12-28  185  	data->subset_data_num = info->subset_num;
59fe9dce1f284e James Tai 2023-12-28  186  	for (i = 0; i < info->subset_num; i++) {
59fe9dce1f284e James Tai 2023-12-28  187  		ret = realtek_intc_subset(node, data, i);
59fe9dce1f284e James Tai 2023-12-28  188  		if (ret <= 0) {
59fe9dce1f284e James Tai 2023-12-28  189  			dev_err(dev, "failed to init subset %d: %d", i, ret);
59fe9dce1f284e James Tai 2023-12-28  190  			goto irq_domain_cleanup;
59fe9dce1f284e James Tai 2023-12-28  191  		}
59fe9dce1f284e James Tai 2023-12-28  192  	}
59fe9dce1f284e James Tai 2023-12-28  193  
59fe9dce1f284e James Tai 2023-12-28  194  	platform_set_drvdata(pdev, data);
59fe9dce1f284e James Tai 2023-12-28  195  
59fe9dce1f284e James Tai 2023-12-28  196  	return 0;
59fe9dce1f284e James Tai 2023-12-28  197  
59fe9dce1f284e James Tai 2023-12-28  198  irq_domain_cleanup:
59fe9dce1f284e James Tai 2023-12-28  199  	if (data->domain)
59fe9dce1f284e James Tai 2023-12-28  200  		irq_domain_remove(data->domain);
59fe9dce1f284e James Tai 2023-12-28  201  
59fe9dce1f284e James Tai 2023-12-28  202  iomap_cleanup:
59fe9dce1f284e James Tai 2023-12-28  203  	if (data->base)
59fe9dce1f284e James Tai 2023-12-28 @204  		iounmap(data->base);
59fe9dce1f284e James Tai 2023-12-28  205  
59fe9dce1f284e James Tai 2023-12-28  206  	return -ENOMEM;
59fe9dce1f284e James Tai 2023-12-28  207  }
59fe9dce1f284e James Tai 2023-12-28  208  EXPORT_SYMBOL_GPL(realtek_intc_probe);
59fe9dce1f284e James Tai 2023-12-28  209  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

