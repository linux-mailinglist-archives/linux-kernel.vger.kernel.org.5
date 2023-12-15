Return-Path: <linux-kernel+bounces-1257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA70814C80
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C352B224C5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCD43BB30;
	Fri, 15 Dec 2023 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BsVuvNaa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D253A8F7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702656407; x=1734192407;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cRQ3ir9IzDt89ijjdCb5AdcB8xFiQU9DkIiHhfrDblQ=;
  b=BsVuvNaa/7y9v1NdqybmxdlZl67f5KtO9J97tRPmPYvzkhb/VwPhhQXo
   5AhYqNLWBvzrtstipjf/QGh3cArOUp05YuPhwN6b012ZDLk89AUDeHxWB
   k/V2lh8//PsRqg2eSZKTz32mGoTfn8xOHkdOGnpd+ug3sN6SGQfJSD62a
   maXcvAq7SplQiY6njMYDH8m+Cx+l50KYagiKud7MLoyeEGg2c+HK544Rx
   Qaj9gkWzaZ7vZlJb2uHJcwNldLHNNOsrpSC8gPU4Xsbk+JtWreM0vpOn7
   D+jZaMt3rLwcrxHYl7PmQNjwfR+luhTYLU+2pbeVqG67JHThmePWFrmG+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="8711918"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="8711918"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 08:06:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="845165017"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="845165017"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 15 Dec 2023 08:06:44 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEAi2-0000Pa-1o;
	Fri, 15 Dec 2023 16:06:42 +0000
Date: Sat, 16 Dec 2023 00:06:35 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: drivers/ata/pata_buddha.c:75:27: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202312152310.PfrGc8IR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3f7168591ebf7bbdb91797d02b1afaf00a4289b1
commit: c7db3832ff19a9a1116c1b3d435c9db165a2f2f8 m68k: io: Mark mmio read addresses as const
date:   2 months ago
config: m68k-randconfig-r113-20231215 (https://download.01.org/0day-ci/archive/20231215/202312152310.PfrGc8IR-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231215/202312152310.PfrGc8IR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312152310.PfrGc8IR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/ata/pata_buddha.c:75:27: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/ata/pata_buddha.c:75:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
   drivers/ata/pata_buddha.c:75:27: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *port
   drivers/ata/pata_buddha.c:75:27: sparse:     got unsigned short [usertype] *
   drivers/ata/pata_buddha.c:77:28: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_buddha.c:77:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
   drivers/ata/pata_buddha.c:77:28: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
   drivers/ata/pata_buddha.c:77:28: sparse:     got unsigned short [usertype] *
   drivers/ata/pata_buddha.c:87:35: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_buddha.c:87:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
   drivers/ata/pata_buddha.c:87:35: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *port
   drivers/ata/pata_buddha.c:87:35: sparse:     got unsigned short [usertype] *
   drivers/ata/pata_buddha.c:91:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_buddha.c:91:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
   drivers/ata/pata_buddha.c:91:36: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
   drivers/ata/pata_buddha.c:91:36: sparse:     got unsigned short [usertype] *
   drivers/ata/pata_buddha.c:236:37: sparse: sparse: cast removes address space '__iomem' of expression
--
   drivers/ata/pata_gayle.c:53:27: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/ata/pata_gayle.c:53:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
   drivers/ata/pata_gayle.c:53:27: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *port
   drivers/ata/pata_gayle.c:53:27: sparse:     got unsigned short [usertype] *
   drivers/ata/pata_gayle.c:55:28: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_gayle.c:55:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
   drivers/ata/pata_gayle.c:55:28: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
   drivers/ata/pata_gayle.c:55:28: sparse:     got unsigned short [usertype] *
   drivers/ata/pata_gayle.c:65:35: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_gayle.c:65:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
   drivers/ata/pata_gayle.c:65:35: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *port
   drivers/ata/pata_gayle.c:65:35: sparse:     got unsigned short [usertype] *
   drivers/ata/pata_gayle.c:69:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_gayle.c:69:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
   drivers/ata/pata_gayle.c:69:36: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
   drivers/ata/pata_gayle.c:69:36: sparse:     got unsigned short [usertype] *
   drivers/ata/pata_gayle.c:181:29: sparse: sparse: cast removes address space '__iomem' of expression

vim +75 drivers/ata/pata_buddha.c

740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  62  
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  63  /* FIXME: is this needed? */
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  64  static unsigned int pata_buddha_data_xfer(struct ata_queued_cmd *qc,
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  65  					 unsigned char *buf,
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  66  					 unsigned int buflen, int rw)
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  67  {
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  68  	struct ata_device *dev = qc->dev;
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  69  	struct ata_port *ap = dev->link->ap;
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  70  	void __iomem *data_addr = ap->ioaddr.data_addr;
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  71  	unsigned int words = buflen >> 1;
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  72  
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  73  	/* Transfer multiple of 2 bytes */
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  74  	if (rw == READ)
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07 @75  		raw_insw((u16 *)data_addr, (u16 *)buf, words);
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  76  	else
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  77  		raw_outsw((u16 *)data_addr, (u16 *)buf, words);
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  78  
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  79  	/* Transfer trailing byte, if any. */
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  80  	if (unlikely(buflen & 0x01)) {
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  81  		unsigned char pad[2] = { };
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  82  
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  83  		/* Point buf to the tail of buffer */
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  84  		buf += buflen - 1;
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  85  
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  86  		if (rw == READ) {
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  87  			raw_insw((u16 *)data_addr, (u16 *)pad, 1);
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  88  			*buf = pad[0];
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  89  		} else {
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  90  			pad[0] = *buf;
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  91  			raw_outsw((u16 *)data_addr, (u16 *)pad, 1);
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  92  		}
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  93  		words++;
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  94  	}
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  95  
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  96  	return words << 1;
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  97  }
740c68a0cd42aa Bartlomiej Zolnierkiewicz 2019-02-07  98  

:::::: The code at line 75 was first introduced by commit
:::::: 740c68a0cd42aab21ad9aaae092ff8a2215966b1 ata: add Buddha PATA controller driver

:::::: TO: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

