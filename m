Return-Path: <linux-kernel+bounces-238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BBE813E25
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF41282037
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021F96C6D8;
	Thu, 14 Dec 2023 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZ81qvgO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAB26C6CC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702595873; x=1734131873;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XK8VqjuBoW396tn5EW/FiOIDwHJUxG92ZCmBZQxzlcY=;
  b=QZ81qvgOLuSwIZPs8YJc6qqCklZPT/H/Rab3l3U9tycCXeIeZvEn0izz
   KT6Fn2C+IU+4o3xdLrLRAttlcRKY0A26jE93pRE4OF4K4i/BS1TeMe8L0
   lnPKRXPumoDme7EpU3Q6rJMuvhJ7HCATZW+4dmQj3ZneZO5zetcciHmvi
   ZvKOAuZ+/09cv6pN0Mh6D3attUkGUmBY6+1ycWWk8YQJbWOsT0R4f7A+S
   CX5nBoaO1XXv+OZv2H5OIBgfv3PZwrh2XKdL6SwnGwsSw3bgF5gce3PWK
   ES3P4+6neOxjrWvH9mb2dcUOKOjcKRiscTPbX3UnDmNNa7+txlnPMwRnP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2355319"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="2355319"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 14:52:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="724229622"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="724229622"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 14 Dec 2023 14:52:28 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDuZ8-000Mh3-1s;
	Thu, 14 Dec 2023 22:52:26 +0000
Date: Fri, 15 Dec 2023 06:52:17 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: drivers/mtd/nand/raw/s3c2410.c:169: warning: Excess struct member
 'freq_transition' description in 's3c2410_nand_info'
Message-ID: <202312150611.EZBAQYqf-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c7402612e2e61b76177f22e6e7f705adcbecc6fe
commit: 1ea35b355722675b3b654475a37898742731d016 ARM: s3c: remove s3c24xx specific hacks
date:   11 months ago
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20231215/202312150611.EZBAQYqf-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150611.EZBAQYqf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150611.EZBAQYqf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/mtd/nand/raw/s3c2410.c:118: warning: Excess struct member 'mtd' description in 's3c2410_nand_mtd'
>> drivers/mtd/nand/raw/s3c2410.c:169: warning: Excess struct member 'freq_transition' description in 's3c2410_nand_info'


vim +169 drivers/mtd/nand/raw/s3c2410.c

^1da177e4c3f41 drivers/mtd/nand/s3c2410.c     Linus Torvalds 2005-04-16  133  
3db72151aa4c24 drivers/mtd/nand/s3c2410.c     Ben Dooks      2009-05-30  134  /**
3db72151aa4c24 drivers/mtd/nand/s3c2410.c     Ben Dooks      2009-05-30  135   * struct s3c2410_nand_info - NAND controller state.
5a933b0dae2ee7 drivers/mtd/nand/raw/s3c2410.c Lee Jones      2020-11-09  136   * @controller: Base controller structure.
5a933b0dae2ee7 drivers/mtd/nand/raw/s3c2410.c Lee Jones      2020-11-09  137   * @mtds: An array of MTD instances on this controller.
3db72151aa4c24 drivers/mtd/nand/s3c2410.c     Ben Dooks      2009-05-30  138   * @platform: The platform data for this board.
3db72151aa4c24 drivers/mtd/nand/s3c2410.c     Ben Dooks      2009-05-30  139   * @device: The platform device we bound to.
3db72151aa4c24 drivers/mtd/nand/s3c2410.c     Ben Dooks      2009-05-30  140   * @clk: The clock resource for this controller.
6f32a3e2853da1 drivers/mtd/nand/s3c2410.c     Sachin Kamat   2012-08-21  141   * @regs: The area mapped for the hardware registers.
3db72151aa4c24 drivers/mtd/nand/s3c2410.c     Ben Dooks      2009-05-30  142   * @sel_reg: Pointer to the register controlling the NAND selection.
3db72151aa4c24 drivers/mtd/nand/s3c2410.c     Ben Dooks      2009-05-30  143   * @sel_bit: The bit in @sel_reg to select the NAND chip.
3db72151aa4c24 drivers/mtd/nand/s3c2410.c     Ben Dooks      2009-05-30  144   * @mtd_count: The number of MTDs created from this controller.
3db72151aa4c24 drivers/mtd/nand/s3c2410.c     Ben Dooks      2009-05-30  145   * @save_sel: The contents of @sel_reg to be saved over suspend.
3db72151aa4c24 drivers/mtd/nand/s3c2410.c     Ben Dooks      2009-05-30  146   * @clk_rate: The clock rate from @clk.
ac497c1602555c drivers/mtd/nand/s3c2410.c     Jiri Pinkava   2011-04-13  147   * @clk_state: The current clock state.
3db72151aa4c24 drivers/mtd/nand/s3c2410.c     Ben Dooks      2009-05-30  148   * @cpu_type: The exact type of this controller.
5a933b0dae2ee7 drivers/mtd/nand/raw/s3c2410.c Lee Jones      2020-11-09  149   * @freq_transition: CPUFreq notifier block
3db72151aa4c24 drivers/mtd/nand/s3c2410.c     Ben Dooks      2009-05-30  150   */
^1da177e4c3f41 drivers/mtd/nand/s3c2410.c     Linus Torvalds 2005-04-16  151  struct s3c2410_nand_info {
^1da177e4c3f41 drivers/mtd/nand/s3c2410.c     Linus Torvalds 2005-04-16  152  	/* mtd info */
7da45139d264f3 drivers/mtd/nand/raw/s3c2410.c Miquel Raynal  2018-07-17  153  	struct nand_controller		controller;
^1da177e4c3f41 drivers/mtd/nand/s3c2410.c     Linus Torvalds 2005-04-16  154  	struct s3c2410_nand_mtd		*mtds;
^1da177e4c3f41 drivers/mtd/nand/s3c2410.c     Linus Torvalds 2005-04-16  155  	struct s3c2410_platform_nand	*platform;
^1da177e4c3f41 drivers/mtd/nand/s3c2410.c     Linus Torvalds 2005-04-16  156  
^1da177e4c3f41 drivers/mtd/nand/s3c2410.c     Linus Torvalds 2005-04-16  157  	/* device info */
^1da177e4c3f41 drivers/mtd/nand/s3c2410.c     Linus Torvalds 2005-04-16  158  	struct device			*device;
^1da177e4c3f41 drivers/mtd/nand/s3c2410.c     Linus Torvalds 2005-04-16  159  	struct clk			*clk;
fdf2fd52746bbf drivers/mtd/nand/s3c2410.c     Ben Dooks      2005-02-18  160  	void __iomem			*regs;
2c06a0821711a5 drivers/mtd/nand/s3c2410.c     Ben Dooks      2006-06-27  161  	void __iomem			*sel_reg;
2c06a0821711a5 drivers/mtd/nand/s3c2410.c     Ben Dooks      2006-06-27  162  	int				sel_bit;
^1da177e4c3f41 drivers/mtd/nand/s3c2410.c     Linus Torvalds 2005-04-16  163  	int				mtd_count;
0916083210039b drivers/mtd/nand/s3c2410.c     Ben Dooks      2008-04-15  164  	unsigned long			save_sel;
30821fee4f0cb3 drivers/mtd/nand/s3c2410.c     Ben Dooks      2008-07-15  165  	unsigned long			clk_rate;
ac497c1602555c drivers/mtd/nand/s3c2410.c     Jiri Pinkava   2011-04-13  166  	enum s3c_nand_clk_state		clk_state;
03680b1e00d146 drivers/mtd/nand/s3c2410.c     Ben Dooks      2007-11-19  167  
2c06a0821711a5 drivers/mtd/nand/s3c2410.c     Ben Dooks      2006-06-27  168  	enum s3c_cpu_type		cpu_type;
^1da177e4c3f41 drivers/mtd/nand/s3c2410.c     Linus Torvalds 2005-04-16 @169  };
^1da177e4c3f41 drivers/mtd/nand/s3c2410.c     Linus Torvalds 2005-04-16  170  

:::::: The code at line 169 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

