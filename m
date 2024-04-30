Return-Path: <linux-kernel+bounces-164130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB988B7974
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8AE1F227C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625A1175541;
	Tue, 30 Apr 2024 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2dQJZsW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DADC174EDF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486964; cv=none; b=bKPdJDmOLH9vUxelh78g4jNo+yfHUcvh07JWS4oivOi4OT4KEM4/glq8RJHVAIy8AoRToV67VXvEwtCJyALaHbQUgQm+oFym1slTknCvcsm43PgpGqoV14smM9rhnGm1U1RhvJvmmB1mBjc5LZFy5VLL0tGdzW5Zkt9PE1TkliE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486964; c=relaxed/simple;
	bh=NSkv3w+kzdI+qxClVfzji2TfL1j3isYzoKWfULHWh6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=On6US6mySDbAh9BfIqymAwL6oYjRFA0xkAyPkJET8zfnGsy4zsim1Xyy09ZzH2fLZ6Dw2WGaOP6phzl//7pmhy+vQVnEhiZrh8emHCnPq2/ARBq6hZczmh+v/hyJj/3KQjvZfPaTDUzkgLDSmyxCGMPaA9ynO4YJZZUN9ArQnaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2dQJZsW; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714486963; x=1746022963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NSkv3w+kzdI+qxClVfzji2TfL1j3isYzoKWfULHWh6A=;
  b=i2dQJZsWJ3xx45pC2FSVJ+U5cICbnUFIgS40mXBEgCD6uaD0JorBj+od
   YIoo0kv2siOvCZi44Sqonfetw/OBauJedaAT4yOdzvMiWj1e0UoPT3mkx
   o2g6taefoXcM6BtEVtbR54+VUdlBcmYwGHdrJhxxGW5rFKhIAES4l4A89
   o7AdMv2BuuPlei8RKFqA+7lfQGiPxHCEnYIOsqEZ9zotcL+dEWbsozx/i
   J2RF6/N3qRlXrfgzXnMoUnK7csMBVewbcPE+X8I6uKL/Q8c+xLcPoZQdj
   UTRmPBZfM9AxjE/RsazJWegMe4lKcizyjkpAy9W9B7mPOFX7+ieO7aOIE
   Q==;
X-CSE-ConnectionGUID: YWw4bsV+TpOJfhux51Nw8w==
X-CSE-MsgGUID: dyk00SRDQVWm8o/w5iK5yQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10358693"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10358693"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:22:41 -0700
X-CSE-ConnectionGUID: Ei1AZGKzQUqrUK8xpg6NzQ==
X-CSE-MsgGUID: VqEpa3rOT2ODvWurHcL2GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="57657112"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 30 Apr 2024 07:22:38 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1oNQ-0008Cd-04;
	Tue, 30 Apr 2024 14:22:36 +0000
Date: Tue, 30 Apr 2024 22:22:11 +0800
From: kernel test robot <lkp@intel.com>
To: Vamsi Attunuru <vattunuru@marvell.com>, arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	vattunuru@marvell.com, jerinj@marvell.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K DPI
 administrative driver
Message-ID: <202404302217.urdwvcqg-lkp@intel.com>
References: <20240429055027.2162310-1-vattunuru@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429055027.2162310-1-vattunuru@marvell.com>

Hi Vamsi,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus soc/for-next linus/master v6.9-rc6 next-20240430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vamsi-Attunuru/misc-mrvl-cn10k-dpi-add-Octeon-CN10K-DPI-administrative-driver/20240430-142354
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20240429055027.2162310-1-vattunuru%40marvell.com
patch subject: [PATCH v6 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K DPI administrative driver
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20240430/202404302217.urdwvcqg-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 37ae4ad0eef338776c7e2cffb3896153d43dcd90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240430/202404302217.urdwvcqg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404302217.urdwvcqg-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/misc/mrvl_cn10k_dpi.c:12:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/misc/mrvl_cn10k_dpi.c:12:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/misc/mrvl_cn10k_dpi.c:12:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
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
   In file included from drivers/misc/mrvl_cn10k_dpi.c:12:
   In file included from include/linux/pci.h:2693:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/misc/mrvl_cn10k_dpi.c:453:2: error: call to undeclared function 'pci_free_irq_vectors'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     453 |         pci_free_irq_vectors((struct pci_dev *)pdev);
         |         ^
   drivers/misc/mrvl_cn10k_dpi.c:453:2: note: did you mean 'dpi_free_irq_vectors'?
   drivers/misc/mrvl_cn10k_dpi.c:451:13: note: 'dpi_free_irq_vectors' declared here
     451 | static void dpi_free_irq_vectors(void *pdev)
         |             ^
     452 | {
     453 |         pci_free_irq_vectors((struct pci_dev *)pdev);
         |         ~~~~~~~~~~~~~~~~~~~~
         |         dpi_free_irq_vectors
>> drivers/misc/mrvl_cn10k_dpi.c:661:28: error: called object type 'void *' is not a function or function pointer
     661 |         pci_sriov_configure_simple(pdev, 0);
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~^
>> drivers/misc/mrvl_cn10k_dpi.c:681:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     681 | module_pci_driver(dpi_driver);
         | ^
         | int
>> drivers/misc/mrvl_cn10k_dpi.c:681:19: error: a parameter list without types is only allowed in a function definition
     681 | module_pci_driver(dpi_driver);
         |                   ^
   13 warnings and 4 errors generated.


vim +/pci_free_irq_vectors +453 drivers/misc/mrvl_cn10k_dpi.c

   450	
   451	static void dpi_free_irq_vectors(void *pdev)
   452	{
 > 453		pci_free_irq_vectors((struct pci_dev *)pdev);
   454	}
   455	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

