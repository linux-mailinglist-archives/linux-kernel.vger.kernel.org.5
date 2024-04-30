Return-Path: <linux-kernel+bounces-164052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0808B77DB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359A0284641
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5343F174EC7;
	Tue, 30 Apr 2024 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2c6qqtP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E674172BD3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485674; cv=none; b=lhH1fRHRXyMYV63Jwa4ICzWd9/OkjFKxhvmZYdwQRKhHUpKLK66OgxynlDkQy0bc3A1vOBKJLsNXYChoY6fpEd13BdpjnUP0LQvZgg0eq1AdzMRZA1Mt7ikqvmr4EdtV0PlHzdUXaz3xXgyR/77aL2xPwB6s313P7J9u8g5dNOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485674; c=relaxed/simple;
	bh=eRs0L7ZAubuQzJX6/wz3doHU4QIqlJv2glQxRWHroLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IctHWKeZFNxW2Gznzhv3Md1M0kVthxbh9Gffx9Ut+496nhCLa3vSXhzkwLKdPaDNppK4BqJvK4SCBN04ZJQZJat3YkxW/Rd98I7NYfAuDxO2/C3JSaOOvc04HM6Y5xe6C+oSXu7OLYGgfCHRV3HUpDBEddycHJ1+jfmR+lmS5YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2c6qqtP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714485672; x=1746021672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eRs0L7ZAubuQzJX6/wz3doHU4QIqlJv2glQxRWHroLw=;
  b=m2c6qqtP6ZhSyU61oy+QeHraqwcpeZx4eSdeX+ajSyw3mXEj3OXGYQ9B
   MO9Blf5pMGGdX4XM8nja68hMBRguKWS2UlJB7SBa0YFrRElsVy8IXAFIO
   19PrgK8ANcQXMH3mK0FbzpshNkSlMTc2VXLoJet+37AieB4DS/Xv4LEUT
   3iV858DWh1Urpam53trcu3pgnF/yYZV22mFS/t/wxt/5RZ2yDik8+fzNG
   052DeQJ4fYDhGsu/ZYplgPcWPxfTz2hDuWv+wHQZk9Ua3lC/xh4lheJ0Y
   zOg2SHlUJy6uiEb8qEphQpboc44zRYU77udsJKcCHEj+ntJmOklw5+waB
   g==;
X-CSE-ConnectionGUID: SXTRpWilT9SMSHILmOUlYw==
X-CSE-MsgGUID: OGv/HsY6SBSdJGzAykVlpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10354940"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10354940"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:01:11 -0700
X-CSE-ConnectionGUID: 4Abq3tc3R9i6+anKPkzuYw==
X-CSE-MsgGUID: ULqEoewVSwKC+4qQTJ9nww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="57647349"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 30 Apr 2024 07:01:10 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1o2d-0008Br-0P;
	Tue, 30 Apr 2024 14:01:07 +0000
Date: Tue, 30 Apr 2024 22:00:15 +0800
From: kernel test robot <lkp@intel.com>
To: Vamsi Attunuru <vattunuru@marvell.com>, arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, vattunuru@marvell.com,
	jerinj@marvell.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K DPI
 administrative driver
Message-ID: <202404302147.7X1w59Jg-lkp@intel.com>
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
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20240430/202404302147.7X1w59Jg-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240430/202404302147.7X1w59Jg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404302147.7X1w59Jg-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/misc/mrvl_cn10k_dpi.c: In function 'dpi_reg_write':
>> drivers/misc/mrvl_cn10k_dpi.c:202:9: error: implicit declaration of function 'writeq'; did you mean 'writeb'? [-Werror=implicit-function-declaration]
     202 |         writeq(val, dpi->reg_base + offset);
         |         ^~~~~~
         |         writeb
   drivers/misc/mrvl_cn10k_dpi.c: In function 'dpi_reg_read':
>> drivers/misc/mrvl_cn10k_dpi.c:207:16: error: implicit declaration of function 'readq'; did you mean 'readb'? [-Werror=implicit-function-declaration]
     207 |         return readq(dpi->reg_base + offset);
         |                ^~~~~
         |                readb
   drivers/misc/mrvl_cn10k_dpi.c: In function 'dpi_free_irq_vectors':
>> drivers/misc/mrvl_cn10k_dpi.c:453:9: error: implicit declaration of function 'pci_free_irq_vectors'; did you mean 'dpi_free_irq_vectors'? [-Werror=implicit-function-declaration]
     453 |         pci_free_irq_vectors((struct pci_dev *)pdev);
         |         ^~~~~~~~~~~~~~~~~~~~
         |         dpi_free_irq_vectors
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/compat.h:9,
                    from drivers/misc/mrvl_cn10k_dpi.c:8:
   drivers/misc/mrvl_cn10k_dpi.c: In function 'dpi_remove':
   include/linux/stddef.h:8:14: error: called object is not a function or function pointer
       8 | #define NULL ((void *)0)
         |              ^
   include/linux/pci.h:2445:41: note: in expansion of macro 'NULL'
    2445 | #define pci_sriov_configure_simple      NULL
         |                                         ^~~~
   drivers/misc/mrvl_cn10k_dpi.c:661:9: note: in expansion of macro 'pci_sriov_configure_simple'
     661 |         pci_sriov_configure_simple(pdev, 0);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/mrvl_cn10k_dpi.c: At top level:
>> drivers/misc/mrvl_cn10k_dpi.c:681:1: warning: data definition has no type or storage class
     681 | module_pci_driver(dpi_driver);
         | ^~~~~~~~~~~~~~~~~
>> drivers/misc/mrvl_cn10k_dpi.c:681:1: error: type defaults to 'int' in declaration of 'module_pci_driver' [-Werror=implicit-int]
>> drivers/misc/mrvl_cn10k_dpi.c:681:1: warning: parameter names (without types) in function declaration
>> drivers/misc/mrvl_cn10k_dpi.c:673:26: warning: 'dpi_driver' defined but not used [-Wunused-variable]
     673 | static struct pci_driver dpi_driver = {
         |                          ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +202 drivers/misc/mrvl_cn10k_dpi.c

   199	
   200	static inline void dpi_reg_write(struct dpipf *dpi, u64 offset, u64 val)
   201	{
 > 202		writeq(val, dpi->reg_base + offset);
   203	}
   204	
   205	static inline u64 dpi_reg_read(struct dpipf *dpi, u64 offset)
   206	{
 > 207		return readq(dpi->reg_base + offset);
   208	}
   209	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

