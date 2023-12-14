Return-Path: <linux-kernel+bounces-247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C1B813E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0136B1C21BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8196C6EC;
	Thu, 14 Dec 2023 23:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q7TM0q6b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577542DB60
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702596392; x=1734132392;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2kbxU/j1E2mXB1lp9MGqUVziKNe/hEkKZdqvcp6MOUw=;
  b=Q7TM0q6bF2YDmCGCixSCPY+/Y3O3nenSTdPpgAq7f3Way6kesWR3bzxc
   Rrsdon/UdTrU/mkMwubshDodfOgAydFcDOovCl8akfC4inQUOgxG3ZWz7
   iJEjacf5ASjHZVb7dVmpWkT5ZUkLxKv/gxQTCYTQBNa+nj8rrkKxCqXt1
   DrtsCHIdlB8qsBbzl/iMrWfuxKQmUoC5zxmiuTDxe63Ho9kPI5MRolIQ6
   FS5ZM0tOjFH2UwMbymueTbLn0n14svtsUKEexURZ8zf5zFMGUpi2LYUZ3
   WzvsPcE1nr2LbLGPiZVMpG0nL6gMmkM+6McaFomahSGJjrRpBQtRApwm2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="461665339"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="461665339"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 15:26:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1105909708"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="1105909708"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 14 Dec 2023 15:26:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDv63-000Mjk-34;
	Thu, 14 Dec 2023 23:26:27 +0000
Date: Fri, 15 Dec 2023 07:25:31 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: drivers/mtd/nand/raw/sunxi_nand.c:201: warning: Excess struct member
 'sels' description in 'sunxi_nand_chip'
Message-ID: <202312150752.IeutuS1p-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: 28a05da765c0cd21654ef5fed3b53af5cd278d63 mtd: rawnand: sunxi: Annotate struct sunxi_nand_chip with __counted_by
date:   3 months ago
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20231215/202312150752.IeutuS1p-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150752.IeutuS1p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150752.IeutuS1p-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mtd/nand/raw/sunxi_nand.c:201: warning: Excess struct member 'sels' description in 'sunxi_nand_chip'


vim +201 drivers/mtd/nand/raw/sunxi_nand.c

1fef62c1423b69 drivers/mtd/nand/sunxi_nand.c     Boris Brezillon 2014-10-21  179  
67c88008c3e24a drivers/mtd/nand/raw/sunxi_nand.c Boris Brezillon 2018-12-15  180  /**
67c88008c3e24a drivers/mtd/nand/raw/sunxi_nand.c Boris Brezillon 2018-12-15  181   * struct sunxi_nand_chip - stores NAND chip device related information
1fef62c1423b69 drivers/mtd/nand/sunxi_nand.c     Boris Brezillon 2014-10-21  182   *
1fef62c1423b69 drivers/mtd/nand/sunxi_nand.c     Boris Brezillon 2014-10-21  183   * @node: used to store NAND chips into a list
1fef62c1423b69 drivers/mtd/nand/sunxi_nand.c     Boris Brezillon 2014-10-21  184   * @nand: base NAND chip structure
cbd87780bed580 drivers/mtd/nand/raw/sunxi_nand.c Miquel Raynal   2020-09-30  185   * @ecc: ECC controller structure
1fef62c1423b69 drivers/mtd/nand/sunxi_nand.c     Boris Brezillon 2014-10-21  186   * @clk_rate: clk_rate required for this NAND chip
67c88008c3e24a drivers/mtd/nand/raw/sunxi_nand.c Boris Brezillon 2018-12-15  187   * @timing_cfg: TIMING_CFG register value for this NAND chip
67c88008c3e24a drivers/mtd/nand/raw/sunxi_nand.c Boris Brezillon 2018-12-15  188   * @timing_ctl: TIMING_CTL register value for this NAND chip
1fef62c1423b69 drivers/mtd/nand/sunxi_nand.c     Boris Brezillon 2014-10-21  189   * @nsels: number of CS lines required by the NAND chip
1fef62c1423b69 drivers/mtd/nand/sunxi_nand.c     Boris Brezillon 2014-10-21  190   * @sels: array of CS lines descriptions
1fef62c1423b69 drivers/mtd/nand/sunxi_nand.c     Boris Brezillon 2014-10-21  191   */
1fef62c1423b69 drivers/mtd/nand/sunxi_nand.c     Boris Brezillon 2014-10-21  192  struct sunxi_nand_chip {
1fef62c1423b69 drivers/mtd/nand/sunxi_nand.c     Boris Brezillon 2014-10-21  193  	struct list_head node;
1fef62c1423b69 drivers/mtd/nand/sunxi_nand.c     Boris Brezillon 2014-10-21  194  	struct nand_chip nand;
ac1c7072e38e49 drivers/mtd/nand/raw/sunxi_nand.c Samuel Holland  2023-02-04  195  	struct sunxi_nand_hw_ecc ecc;
1fef62c1423b69 drivers/mtd/nand/sunxi_nand.c     Boris Brezillon 2014-10-21  196  	unsigned long clk_rate;
9c618292dba6aa drivers/mtd/nand/sunxi_nand.c     Roy Spliet      2015-06-26  197  	u32 timing_cfg;
d052e508a4069f drivers/mtd/nand/sunxi_nand.c     Roy Spliet      2015-06-26  198  	u32 timing_ctl;
1fef62c1423b69 drivers/mtd/nand/sunxi_nand.c     Boris Brezillon 2014-10-21  199  	int nsels;
28a05da765c0cd drivers/mtd/nand/raw/sunxi_nand.c Kees Cook       2023-09-15  200  	struct sunxi_nand_chip_sel sels[] __counted_by(nsels);
1fef62c1423b69 drivers/mtd/nand/sunxi_nand.c     Boris Brezillon 2014-10-21 @201  };
1fef62c1423b69 drivers/mtd/nand/sunxi_nand.c     Boris Brezillon 2014-10-21  202  

:::::: The code at line 201 was first introduced by commit
:::::: 1fef62c1423b694da517b18dc80d59a7eaf7dd74 mtd: nand: add sunxi NAND flash controller support

:::::: TO: Boris BREZILLON <boris.brezillon@free-electrons.com>
:::::: CC: Brian Norris <computersforpeace@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

