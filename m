Return-Path: <linux-kernel+bounces-3179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC20881686F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6B81C225E0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87E31118F;
	Mon, 18 Dec 2023 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTGBzOtO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D781079C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702888964; x=1734424964;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sBxg0UKCVeuSqHeGwHH7h6rWM3HFa0ZKtMmH8h79/C4=;
  b=hTGBzOtOOFaBr2o6MCqP5uMZrb65wNm3lf3RUj/wMUA3HuDlCJ9Wikp6
   0Ls1dt2L/DnRTP2ogR3hXMu5zDO3W9X/ZLnmpYJD67eBxHiwYzUCPTStD
   xFCuqXEUZRIkdhlieSEyeqe9oeeuQVEdmuLJgY7IvJMGYIJXFhX+K/w1i
   9McxXQLFKT4Y89ZDeWmNQ1m/10Z7aa7z9BB3/GZ1z74BDiLdouMBPhYB3
   U3klh+pYN7yXMf1WSqzPPqx0MFKfZIaf3q/p87UF/iElgwWwQa4xW7NlG
   EganrhNgmKf/WO44ZksY6bBCxdYeBmqSv93X2GrcZugM9L06CJcs68wS3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="2679728"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="2679728"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 00:42:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="919181507"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="919181507"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 18 Dec 2023 00:42:40 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rF9Cw-0003vY-1s;
	Mon, 18 Dec 2023 08:42:38 +0000
Date: Mon, 18 Dec 2023 16:42:16 +0800
From: kernel test robot <lkp@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/m68k/sun3/sun3ints.c:33:13: sparse: sparse: cast truncates bits
 from constant value (ffffff7f becomes 7f)
Message-ID: <202312181649.u6k6hLIm-lkp@intel.com>
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
commit: 72e70a0e7ac7c422843eb8bbf192e820e9ccd24d m68k: sun3: Change led_pattern[] to unsigned char
date:   2 months ago
config: m68k-randconfig-r133-20231117 (https://download.01.org/0day-ci/archive/20231218/202312181649.u6k6hLIm-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231218/202312181649.u6k6hLIm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312181649.u6k6hLIm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/m68k/sun3/sun3ints.c: note: in included file (through include/linux/mmzone.h, include/linux/topology.h, include/linux/irq.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
>> arch/m68k/sun3/sun3ints.c:33:13: sparse: sparse: cast truncates bits from constant value (ffffff7f becomes 7f)

vim +33 arch/m68k/sun3/sun3ints.c

    31	
    32	static unsigned char led_pattern[8] = {
  > 33		(u8)~(0x80), (u8)~(0x01),
    34		(u8)~(0x40), (u8)~(0x02),
    35		(u8)~(0x20), (u8)~(0x04),
    36		(u8)~(0x10), (u8)~(0x08)
    37	};
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

