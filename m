Return-Path: <linux-kernel+bounces-19952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7815827749
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705E81F23BC6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C2854BEB;
	Mon,  8 Jan 2024 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCPyCAxK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A187255787
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704738080; x=1736274080;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rA6kBrzJ5OOOtJGdHfM4ZOZhz9B/1WMS3VZTBriAc90=;
  b=dCPyCAxKbL4f3SYjedPxSUdHS2hWvebpDK0qtLP9HVII3OQVQ500iCa7
   QayJw7ipsbRFwb9lxsfXaU/6u/u5QOWI+p3Y6fwgqtUshMlAVDdpuW0yh
   wJKBpXGOO+R4j3OWNxW1IQePfBaOILAF2hwkExqkx5qY4ee6sSXIcfthw
   7+Yo01ELc5fPiDRcZtTeR8/qX/LscGTjoYX3ZQU/CwKi2H4W9t6oZGhLD
   KB590HHDfO6TU1RgWulF2jdrL9cIV6R1CKsFR7voecZq4t9HQWrBTzod8
   2h54n8ce8xnT7jgvJbcyetTAPAJn24es+PuFfgbQ21gyXfVxoC2ED9hRw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="4726255"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="4726255"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 10:21:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="954732636"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="954732636"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Jan 2024 10:21:18 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMuFQ-0004zO-01;
	Mon, 08 Jan 2024 18:21:16 +0000
Date: Tue, 9 Jan 2024 02:20:16 +0800
From: kernel test robot <lkp@intel.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: drivers/md/raid1.c:1993:60: sparse: sparse: incorrect type in
 argument 5 (different base types)
Message-ID: <202401090226.k6ktCQYr-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0dd3ee31125508cd67f7e7172247f05b7fd1753a
commit: 4ce4c73f662bdb0ae5bfb058bc7ec6f6829ca078 md/core: Combine two sync_page_io() arguments
date:   1 year, 6 months ago
config: x86_64-randconfig-121-20240107 (https://download.01.org/0day-ci/archive/20240109/202401090226.k6ktCQYr-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240109/202401090226.k6ktCQYr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401090226.k6ktCQYr-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/md/raid1.c:646:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:646:24: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:646:24: sparse:    struct md_rdev *
   drivers/md/raid1.c:777:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:777:24: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:777:24: sparse:    struct md_rdev *
   drivers/md/raid1.c:1223:30: sparse: sparse: incorrect type in initializer (different base types) @@     expected int const op @@     got restricted blk_opf_t enum req_op @@
   drivers/md/raid1.c:1223:30: sparse:     expected int const op
   drivers/md/raid1.c:1223:30: sparse:     got restricted blk_opf_t enum req_op
   drivers/md/raid1.c:1224:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long const do_sync @@     got restricted blk_opf_t @@
   drivers/md/raid1.c:1224:52: sparse:     expected unsigned long const do_sync
   drivers/md/raid1.c:1224:52: sparse:     got restricted blk_opf_t
   drivers/md/raid1.c:1241:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:1241:24: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:1241:24: sparse:    struct md_rdev *
   drivers/md/raid1.c:1404:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:1404:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:1404:40: sparse:    struct md_rdev *
   drivers/md/raid1.c:1635:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:1635:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:1635:40: sparse:    struct md_rdev *
   drivers/md/raid1.c:1707:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:1707:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:1707:40: sparse:    struct md_rdev *
   drivers/md/raid1.c:1824:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:1824:25: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:1824:25: sparse:    struct md_rdev *
   drivers/md/raid1.c:1835:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:1835:25: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:1835:25: sparse:    struct md_rdev *
>> drivers/md/raid1.c:1993:60: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected restricted blk_opf_t [usertype] opf @@     got int rw @@
   drivers/md/raid1.c:2298:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:2298:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:2298:32: sparse:    struct md_rdev *
   drivers/md/raid1.c:2334:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:2334:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:2334:32: sparse:    struct md_rdev *
   drivers/md/raid1.c:2351:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:2351:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:2351:32: sparse:    struct md_rdev *
   drivers/md/raid1.c:2767:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:2767:24: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:2767:24: sparse:    struct md_rdev *

vim +1993 drivers/md/raid1.c

  1989	
  1990	static int r1_sync_page_io(struct md_rdev *rdev, sector_t sector,
  1991				   int sectors, struct page *page, int rw)
  1992	{
> 1993		if (sync_page_io(rdev, sector, sectors << 9, page, rw, false))
  1994			/* success */
  1995			return 1;
  1996		if (rw == WRITE) {
  1997			set_bit(WriteErrorSeen, &rdev->flags);
  1998			if (!test_and_set_bit(WantReplacement,
  1999					      &rdev->flags))
  2000				set_bit(MD_RECOVERY_NEEDED, &
  2001					rdev->mddev->recovery);
  2002		}
  2003		/* need to record an error - either for the block or the device */
  2004		if (!rdev_set_badblocks(rdev, sector, sectors, 0))
  2005			md_error(rdev->mddev, rdev);
  2006		return 0;
  2007	}
  2008	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

