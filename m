Return-Path: <linux-kernel+bounces-4194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2778A817901
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7FF61F2440A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0B774E38;
	Mon, 18 Dec 2023 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmSeaqZe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE261740A4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702921272; x=1734457272;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ov/jK2kG2bZtdxr2hpYJXzxrYdYQjsR6Ue03ZFeYysY=;
  b=hmSeaqZe2sYq6Vgar+SMyr702IDjw8Uj3l2QOPZYr5aFW1sLnYd8EkdV
   OHBKXeMRtbKwdf8b6oi2ZvtRGZXIxizxqLPtrnJSsrv776mN/lukfdjOL
   weiKozbERoAJ7XhrGMH7YMEyBLWMvvnnRt2nNwwS2nQy3VxUSGaFseZx9
   f2Kc1cr55NKGAM4KHZ9GkbzcoKiE+fYDg+ObEYfxfGHSwT2cEYgsTreEs
   UB2fMrY3qhG03RAGP8h+2DsU4xmLU+1FtlbSPdJolK7HE4oBM01wZcCHj
   3wlQ722eaR7rZKEv0OrqV2Z6BWZYNbeumbvU9BQy5FHgV47nzOQhpOV+U
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="394417796"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="394417796"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 09:41:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="809915495"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="809915495"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 18 Dec 2023 09:41:10 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFHc4-0004O3-0D;
	Mon, 18 Dec 2023 17:41:08 +0000
Date: Tue, 19 Dec 2023 01:40:59 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-sa1100/ssp.c:89: warning: Function parameter or struct
 member 'data' not described in 'ssp_read_word'
Message-ID: <202312190124.XlzGTotA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ceb6a6f023fd3e8b07761ed900352ef574010bcb
commit: 8faf91c48ca20c714e0dd8cc5f510e3819852912 ARM: sa1100: un-deprecate jornada720
date:   11 months ago
config: arm-jornada720_defconfig (https://download.01.org/0day-ci/archive/20231219/202312190124.XlzGTotA-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231219/202312190124.XlzGTotA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312190124.XlzGTotA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm/mach-sa1100/ssp.c:89: warning: Function parameter or struct member 'data' not described in 'ssp_read_word'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SA1100_SSP
   Depends on [n]: ARCH_SA1100 [=y] && UNUSED_BOARD_FILES [=n]
   Selected by [y]:
   - SA1100_JORNADA720_SSP [=y] && ARCH_SA1100 [=y] && SA1100_JORNADA720 [=y]


vim +89 arch/arm/mach-sa1100/ssp.c

^1da177e4c3f41 Linus Torvalds  2005-04-16   72  
^1da177e4c3f41 Linus Torvalds  2005-04-16   73  /**
^1da177e4c3f41 Linus Torvalds  2005-04-16   74   * ssp_read_word - read a word from the SSP port
^1da177e4c3f41 Linus Torvalds  2005-04-16   75   *
^1da177e4c3f41 Linus Torvalds  2005-04-16   76   * Wait for a data word in the SSP receive FIFO, and return the
^1da177e4c3f41 Linus Torvalds  2005-04-16   77   * received data.  Data is LSB justified.
^1da177e4c3f41 Linus Torvalds  2005-04-16   78   *
^1da177e4c3f41 Linus Torvalds  2005-04-16   79   * Note: Currently, if data is not expected to be received, this
^1da177e4c3f41 Linus Torvalds  2005-04-16   80   * function will wait for ever.
^1da177e4c3f41 Linus Torvalds  2005-04-16   81   *
^1da177e4c3f41 Linus Torvalds  2005-04-16   82   * The caller is expected to perform the necessary locking.
^1da177e4c3f41 Linus Torvalds  2005-04-16   83   *
^1da177e4c3f41 Linus Torvalds  2005-04-16   84   * Returns:
8f1bf8743c4593 Paul Sokolovsky 2006-08-27   85   *   %-ETIMEDOUT	timeout occurred
^1da177e4c3f41 Linus Torvalds  2005-04-16   86   *   16-bit data	success
^1da177e4c3f41 Linus Torvalds  2005-04-16   87   */
8f1bf8743c4593 Paul Sokolovsky 2006-08-27   88  int ssp_read_word(u16 *data)
^1da177e4c3f41 Linus Torvalds  2005-04-16  @89  {
8f1bf8743c4593 Paul Sokolovsky 2006-08-27   90  	int timeout = TIMEOUT;
8f1bf8743c4593 Paul Sokolovsky 2006-08-27   91  
8f1bf8743c4593 Paul Sokolovsky 2006-08-27   92  	while (!(Ser4SSSR & SSSR_RNE)) {
8f1bf8743c4593 Paul Sokolovsky 2006-08-27   93  	        if (!--timeout)
8f1bf8743c4593 Paul Sokolovsky 2006-08-27   94  	        	return -ETIMEDOUT;
^1da177e4c3f41 Linus Torvalds  2005-04-16   95  		cpu_relax();
8f1bf8743c4593 Paul Sokolovsky 2006-08-27   96  	}
8f1bf8743c4593 Paul Sokolovsky 2006-08-27   97  
8f1bf8743c4593 Paul Sokolovsky 2006-08-27   98  	*data = (u16)Ser4SSDR;
^1da177e4c3f41 Linus Torvalds  2005-04-16   99  
8f1bf8743c4593 Paul Sokolovsky 2006-08-27  100  	return 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  101  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  102  

:::::: The code at line 89 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

