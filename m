Return-Path: <linux-kernel+bounces-4257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEF08179F2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859171C2309C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C09271465;
	Mon, 18 Dec 2023 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtNcNnx6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868A771454
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702925174; x=1734461174;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2n7rEdQG/7oHLpk+IKtiKKxC3nrQgzl83tSimJJpOAg=;
  b=jtNcNnx6LU5nd8wSf4Amgdv7dtlDWANQPTVGKuqTBKlw2ONkboFPATEn
   OLIcklY0TcrfY44oqmy5JcTEmct40ihYPI5crYxxfvgnwXb188bFG4tfs
   OCgnjrPbQDsRo00Hra23YUijUDOOb/3R+c7jKpa0U/pHB/12lm1VlBvC3
   1fy2clt1XvwUATTEiXd7lek0X1DN2g8SN3bIhRAxFTP4bAC5vToJl6keQ
   ecYVDVnsvaAaJmS0Cd/87CUtDqYvoVrXkczjN2WIlXU6iajIaY8o+NJu+
   0GQpnUcM/6Z24xloeuZvVDk0J+S+sjGVstAYb5y9K/pO1LpVqKma27SmW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="395277778"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="395277778"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 10:46:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="866323818"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="866323818"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Dec 2023 10:46:11 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFIcz-0004RF-1m;
	Mon, 18 Dec 2023 18:46:09 +0000
Date: Tue, 19 Dec 2023 02:45:40 +0800
From: kernel test robot <lkp@intel.com>
To: Alastair D'Silva <alastair@d-silva.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>, Greg Kurz <groug@kaod.org>
Subject: drivers/misc/ocxl/mmio.c:20:34: sparse: sparse: cast removes address
 space '__iomem' of expression
Message-ID: <202312190208.xrAsnOMZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ceb6a6f023fd3e8b07761ed900352ef574010bcb
commit: 7e462c2a8a6d00d3c240cac9f5626eff96d8e641 ocxl: Provide global MMIO accessors for external drivers
date:   4 years, 8 months ago
config: powerpc64-randconfig-r113-20231118 (https://download.01.org/0day-ci/archive/20231219/202312190208.xrAsnOMZ-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231219/202312190208.xrAsnOMZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312190208.xrAsnOMZ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/misc/ocxl/mmio.c:20:34: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/misc/ocxl/mmio.c:20:62: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:20:62: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:20:62: sparse:     got char *
   drivers/misc/ocxl/mmio.c:24:31: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:24:59: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:24:59: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:24:59: sparse:     got char *
   drivers/misc/ocxl/mmio.c:45:34: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:45:62: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:45:62: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:45:62: sparse:     got char *
   drivers/misc/ocxl/mmio.c:49:31: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:49:59: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:49:59: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:49:59: sparse:     got char *
   drivers/misc/ocxl/mmio.c:70:33: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/misc/ocxl/mmio.c:70:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:70:61: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:70:61: sparse:     got char *
   drivers/misc/ocxl/mmio.c:74:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:74:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:74:58: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:74:58: sparse:     got char *
   drivers/misc/ocxl/mmio.c:96:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:96:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:96:61: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:96:61: sparse:     got char *
   drivers/misc/ocxl/mmio.c:100:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:100:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:100:58: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:100:58: sparse:     got char *
   drivers/misc/ocxl/mmio.c:124:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:124:61: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:124:61: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:124:61: sparse:     got char *
   drivers/misc/ocxl/mmio.c:126:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:126:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:126:61: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:126:61: sparse:     got char *
   drivers/misc/ocxl/mmio.c:130:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:130:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:130:58: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:130:58: sparse:     got char *
   drivers/misc/ocxl/mmio.c:132:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:132:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:132:58: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:132:58: sparse:     got char *
   drivers/misc/ocxl/mmio.c:155:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:155:61: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:155:61: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:155:61: sparse:     got char *
   drivers/misc/ocxl/mmio.c:157:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:157:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:157:61: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:157:61: sparse:     got char *
   drivers/misc/ocxl/mmio.c:161:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:161:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:161:58: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:161:58: sparse:     got char *
   drivers/misc/ocxl/mmio.c:163:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:163:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:163:58: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:163:58: sparse:     got char *
   drivers/misc/ocxl/mmio.c:186:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:186:61: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:186:61: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:186:61: sparse:     got char *
   drivers/misc/ocxl/mmio.c:188:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:188:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:188:61: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:188:61: sparse:     got char *
   drivers/misc/ocxl/mmio.c:192:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:192:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:192:58: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:192:58: sparse:     got char *
   drivers/misc/ocxl/mmio.c:194:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:194:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:194:58: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:194:58: sparse:     got char *
   drivers/misc/ocxl/mmio.c:218:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:218:61: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:218:61: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:218:61: sparse:     got char *
   drivers/misc/ocxl/mmio.c:220:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:220:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:220:61: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:220:61: sparse:     got char *
   drivers/misc/ocxl/mmio.c:224:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:224:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:224:58: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:224:58: sparse:     got char *
   drivers/misc/ocxl/mmio.c:226:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:226:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:226:58: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:226:58: sparse:     got char *
   drivers/misc/ocxl/mmio.c:230:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/ocxl/mmio.c:230:50: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/ocxl/mmio.c:230:50: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/ocxl/mmio.c:230:50: sparse:     got char *
   drivers/misc/ocxl/mmio.c: note: in included file (through include/linux/io.h, include/linux/irq.h, arch/powerpc/include/asm/hardirq.h, ...):
   arch/powerpc/include/asm/io.h:157:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:162:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:157:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:162:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:157:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:162:1: sparse: sparse: dereference of noderef expression

vim +/__iomem +20 drivers/misc/ocxl/mmio.c

    17	
    18		switch (endian) {
    19		case OCXL_BIG_ENDIAN:
  > 20			*val = readl_be((char *)afu->global_mmio_ptr + offset);
    21			break;
    22	
    23		default:
    24			*val = readl((char *)afu->global_mmio_ptr + offset);
    25			break;
    26		}
    27	
    28		return 0;
    29	}
    30	EXPORT_SYMBOL_GPL(ocxl_global_mmio_read32);
    31	
    32	int ocxl_global_mmio_read64(struct ocxl_afu *afu, size_t offset,
    33					enum ocxl_endian endian, u64 *val)
    34	{
    35		if (offset > afu->config.global_mmio_size - 8)
    36			return -EINVAL;
    37	
    38	#ifdef __BIG_ENDIAN__
    39		if (endian == OCXL_HOST_ENDIAN)
    40			endian = OCXL_BIG_ENDIAN;
    41	#endif
    42	
    43		switch (endian) {
    44		case OCXL_BIG_ENDIAN:
    45			*val = readq_be((char *)afu->global_mmio_ptr + offset);
    46			break;
    47	
    48		default:
    49			*val = readq((char *)afu->global_mmio_ptr + offset);
    50			break;
    51		}
    52	
    53		return 0;
    54	}
    55	EXPORT_SYMBOL_GPL(ocxl_global_mmio_read64);
    56	
    57	int ocxl_global_mmio_write32(struct ocxl_afu *afu, size_t offset,
    58					enum ocxl_endian endian, u32 val)
    59	{
    60		if (offset > afu->config.global_mmio_size - 4)
    61			return -EINVAL;
    62	
    63	#ifdef __BIG_ENDIAN__
    64		if (endian == OCXL_HOST_ENDIAN)
    65			endian = OCXL_BIG_ENDIAN;
    66	#endif
    67	
    68		switch (endian) {
    69		case OCXL_BIG_ENDIAN:
  > 70			writel_be(val, (char *)afu->global_mmio_ptr + offset);
    71			break;
    72	
    73		default:
    74			writel(val, (char *)afu->global_mmio_ptr + offset);
    75			break;
    76		}
    77	
    78	
    79		return 0;
    80	}
    81	EXPORT_SYMBOL_GPL(ocxl_global_mmio_write32);
    82	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

