Return-Path: <linux-kernel+bounces-1643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8985815165
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8373F285995
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BE34655E;
	Fri, 15 Dec 2023 20:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XvRTC+PU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FC64652A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 20:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702673366; x=1734209366;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=im4yuzz2NaICKGTqfVhlKbQyCi5H5jypE3Z7ynJaThw=;
  b=XvRTC+PUHniW8eRzkzU6M2dj2Fg/Z5ltC+EvAV/kVxJSxW00PxAdPsV4
   7AOC31s1tPKM0UEumewwyr/zHm0TuxCv/jVOVLuPn7GXllYCU+9ShHt+v
   N8xA7kGKs8Ouy5gobYhzLh9/6RIFW357XwUs6nRBcDF9ZhAIo704Kh1U7
   YjDjy8xktL3X5gCJsWqkqcO+3MF+jBMfqfya9EWMNDXvSnnViv/+ulV0m
   AiosFxCx1O4rt56kWld2ofMgmy7SOynQ1t/HOzx6ngw/AfTIItQMf05W3
   hUwNyAyr2KsYhZkoAlH67b9c64mXs3P+qU6TcL3xlX4iC/eRX7Yh59gND
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="395066802"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="395066802"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 12:49:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="751054344"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="751054344"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Dec 2023 12:49:21 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEF7Y-0000k5-2o;
	Fri, 15 Dec 2023 20:49:20 +0000
Date: Sat, 16 Dec 2023 04:49:11 +0800
From: kernel test robot <lkp@intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/mtd/nand/raw/sh_flctl.c:512:17: sparse: sparse: cast from
 restricted __be32
Message-ID: <202312160441.W5Plqog2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Miquel,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   26e7a301419d2ef4696e581109c61b4e772e1fb8
commit: 72c5af00272339af6bbed6fe7275cd731f57be2d mtd: rawnand: Clarify Kconfig entry MTD_NAND
date:   4 years, 8 months ago
config: arm-randconfig-r123-20231107 (https://download.01.org/0day-ci/archive/20231216/202312160441.W5Plqog2-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231216/202312160441.W5Plqog2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312160441.W5Plqog2-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/mtd/nand/raw/sh_flctl.c:458:16: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/sh_flctl.c:481:26: sparse: sparse: cast to restricted __be32
   drivers/mtd/nand/raw/sh_flctl.c:496:38: sparse: sparse: cast to restricted __be32
>> drivers/mtd/nand/raw/sh_flctl.c:512:17: sparse: sparse: cast from restricted __be32
   drivers/mtd/nand/raw/sh_flctl.c:525:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long @@     got restricted __be32 [usertype] @@
   drivers/mtd/nand/raw/sh_flctl.c:525:24: sparse:     expected unsigned long
   drivers/mtd/nand/raw/sh_flctl.c:525:24: sparse:     got restricted __be32 [usertype]

vim +512 drivers/mtd/nand/raw/sh_flctl.c

6028aa01f759a1d drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  502  
e8a9d8f31c592ee drivers/mtd/nand/sh_flctl.c Bastian Hecht     2012-10-19  503  static void write_fiforeg(struct sh_flctl *flctl, int rlen,
e8a9d8f31c592ee drivers/mtd/nand/sh_flctl.c Bastian Hecht     2012-10-19  504  						unsigned int offset)
6028aa01f759a1d drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  505  {
6028aa01f759a1d drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  506  	int i, len_4align;
e8a9d8f31c592ee drivers/mtd/nand/sh_flctl.c Bastian Hecht     2012-10-19  507  	unsigned long *buf = (unsigned long *)&flctl->done_buff[offset];
6028aa01f759a1d drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  508  
6028aa01f759a1d drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  509  	len_4align = (rlen + 3) / 4;
6028aa01f759a1d drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  510  	for (i = 0; i < len_4align; i++) {
6028aa01f759a1d drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  511  		wait_wfifo_ready(flctl);
e8a9d8f31c592ee drivers/mtd/nand/sh_flctl.c Bastian Hecht     2012-10-19 @512  		writel(cpu_to_be32(buf[i]), FLDTFIFO(flctl));
6028aa01f759a1d drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  513  	}
6028aa01f759a1d drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  514  }
6028aa01f759a1d drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  515  

:::::: The code at line 512 was first introduced by commit
:::::: e8a9d8f31c592eea89f1b0d3fd425e7a96944e88 mtd: sh_flctl: Minor cleanups

:::::: TO: Bastian Hecht <hechtb@googlemail.com>
:::::: CC: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

