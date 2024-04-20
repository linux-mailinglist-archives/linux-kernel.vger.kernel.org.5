Return-Path: <linux-kernel+bounces-152163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD608ABA15
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 09:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF61B21008
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 07:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC2313ADC;
	Sat, 20 Apr 2024 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfwYvnR4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDAD12E7F;
	Sat, 20 Apr 2024 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713598133; cv=none; b=OaMhKzewpm/0zeVrTKpZfuL1fUUpbWvZ6g79UmwpikMPaWI3UCdQEgRAJrtwLgAzT9ATmvBAXP87w3156Z9bKjBOd0P6ESEyGv2bYpwhSxR+8qliEwFA8fDsssaPto+pcPBrtj6VQt8hBPEdCCpzkrqRVZdH3Bx1s+Db6vGXk8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713598133; c=relaxed/simple;
	bh=Ap/Y7FzXBDxHQevt459EIpFLTrhDLkThFu5ixHCXtkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVcxhBaLmrWvw4+Ut1ow6AwSBdtADQ1dvdDgDwtDEDOg0MDdGo/FPMtdipJoOK4siZ6KBWIkTS+dp6jakgNfXkE4AmdmoXrvYvnfGeAbk5A4EXwjXraPJbWRsucnILOFpQDHecpvIqz1LNDQmJwZQLNAq/ewXrwDGpKhOKC7AEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfwYvnR4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713598132; x=1745134132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ap/Y7FzXBDxHQevt459EIpFLTrhDLkThFu5ixHCXtkQ=;
  b=nfwYvnR4+VzzXpuJ+TVSCiUCvVVAArDjg259KJOdBKW4w89n4cXonlFq
   JuyZPweJRc6su/bBfPGc9IyMf+0BhWWDOEwxodXJSlJvosb+gPvGI/COC
   qUPV3hbqiRtkdpEOjz9lzc8tIO4feGEtu09dTgJCdp5wrKyctiS3dOfuJ
   CaO92klHyefbIoZn8z/T9kDY8iNFo7Ys0ppKEg7NWPMFXZKD5qd2oT5Io
   0gZeaTmSG/ZYgMSE0+KZdUXBhMEiComjDKR0nf40xH7R7SKgveeEnwgj+
   P//6luLOUfaOr11pNLjd8XbSM+Kb8ghQgq06lfoGhCioD4mqUs8SKj54V
   g==;
X-CSE-ConnectionGUID: MEDgpNSdRCyaa4WvFR5WiQ==
X-CSE-MsgGUID: lxqkFcO7RnmcD4QVYn7bHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="34603255"
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="34603255"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2024 00:28:51 -0700
X-CSE-ConnectionGUID: q7yocQK/QY2rb1xW4HE39A==
X-CSE-MsgGUID: dg6dhHaOTVqBkitTllpVWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="23412049"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 20 Apr 2024 00:28:46 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ry59P-000Apw-1U;
	Sat, 20 Apr 2024 07:28:43 +0000
Date: Sat, 20 Apr 2024 15:28:11 +0800
From: kernel test robot <lkp@intel.com>
To: Konstantin Pugin <rilian.la.te@ya.ru>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Konstantin Pugin <ria.freelander@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Max Filippov <jcmvbkbc@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 3/3] serial: sc16is7xx: add support for EXAR XR20M1172
 UART
Message-ID: <202404201559.2eM6MALu-lkp@intel.com>
References: <20240419124506.1531035-4-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419124506.1531035-4-rilian.la.te@ya.ru>

Hi Konstantin,

kernel test robot noticed the following build errors:

[auto build test ERROR on c6795fbffc4547b40933ec368200bd4926a41b44]

url:    https://github.com/intel-lab-lkp/linux/commits/Konstantin-Pugin/serial-sc16is7xx-announce-support-of-SER_RS485_RTS_ON_SEND/20240420-004819
base:   c6795fbffc4547b40933ec368200bd4926a41b44
patch link:    https://lore.kernel.org/r/20240419124506.1531035-4-rilian.la.te%40ya.ru
patch subject: [PATCH v4 3/3] serial: sc16is7xx: add support for EXAR XR20M1172 UART
config: hexagon-randconfig-001-20240420 (https://download.01.org/0day-ci/archive/20240420/202404201559.2eM6MALu-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7089c359a3845323f6f30c44a47dd901f2edfe63)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240420/202404201559.2eM6MALu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404201559.2eM6MALu-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/tty/serial/sc16is7xx_spi.c:7:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/tty/serial/sc16is7xx_spi.c:7:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/tty/serial/sc16is7xx_spi.c:7:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/tty/serial/sc16is7xx_spi.c:8:
   In file included from include/linux/spi/spi.h:17:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/tty/serial/sc16is7xx_spi.c:72:34: error: use of undeclared identifier 'xr20m1172_devtype'
      72 |         { "xr20m1172",  (kernel_ulong_t)&xr20m1172_devtype, },
         |                                          ^
   7 warnings and 1 error generated.


vim +/xr20m1172_devtype +72 drivers/tty/serial/sc16is7xx_spi.c

    63	
    64	static const struct spi_device_id sc16is7xx_spi_id_table[] = {
    65		{ "sc16is74x",	(kernel_ulong_t)&sc16is74x_devtype, },
    66		{ "sc16is740",	(kernel_ulong_t)&sc16is74x_devtype, },
    67		{ "sc16is741",	(kernel_ulong_t)&sc16is74x_devtype, },
    68		{ "sc16is750",	(kernel_ulong_t)&sc16is750_devtype, },
    69		{ "sc16is752",	(kernel_ulong_t)&sc16is752_devtype, },
    70		{ "sc16is760",	(kernel_ulong_t)&sc16is760_devtype, },
    71		{ "sc16is762",	(kernel_ulong_t)&sc16is762_devtype, },
  > 72		{ "xr20m1172",	(kernel_ulong_t)&xr20m1172_devtype, },
    73		{ }
    74	};
    75	MODULE_DEVICE_TABLE(spi, sc16is7xx_spi_id_table);
    76	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

