Return-Path: <linux-kernel+bounces-16093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD32823894
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33FD1C246F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8361DDF8;
	Wed,  3 Jan 2024 22:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQYyBL72"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C21DA47
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 22:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704322383; x=1735858383;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=j1JN1XSRMUxos/5sZUT5WOCFY+LRA3Trw7kSOvdioWg=;
  b=GQYyBL72MJ29O4ZrA1NgEhmRTgEulHs3aUZv7QOOIEru0eTNw4w1py3J
   mv5bmx/K3H1ZTwK1BvqhazvlEoI8MGojWltxCm2Y/hTb1KYFlcytia1nB
   vQ0WfiqNBbjzyFTmw50UIFUeG5QjP3GwyDmfnGSAHiR2DaFnR98B0HknG
   9ji1WfvNoTu11/FF8SCywrxmhVF+DgmaGFkUiZIo4iiL75quwheR5+5I7
   Lfk6uYJzH9mLYFarcC2yk08xQlwGJn0IoGrlk/NjBOrDaXdFFJ1kf/P1A
   vrTu8UKFfOBYeYmJYwimfds+yTv/OGZUXeijPH7YBq/QVGLwBuk9EAyU1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="387544390"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="387544390"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 14:53:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="923712776"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="923712776"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jan 2024 14:53:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLA6d-000MeS-0a;
	Wed, 03 Jan 2024 22:52:59 +0000
Date: Thu, 4 Jan 2024 06:52:44 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: include/asm-generic/unaligned.h:119:16: sparse: sparse: cast
 truncates bits from constant value (aa01a0 becomes a0)
Message-ID: <202401040606.HJvtQjsU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   610a9b8f49fbcf1100716370d3b5f6f884a2835a
commit: 66603243f5283f7f28c795f09e7c2167233df0bd Input: add driver for Hynitron cstxxx touchscreens
date:   1 year, 2 months ago
config: x86_64-randconfig-x051-20230705 (https://download.01.org/0day-ci/archive/20240104/202401040606.HJvtQjsU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240104/202401040606.HJvtQjsU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401040606.HJvtQjsU-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/input/touchscreen/hynitron_cstxxx.c: note: in included file (through arch/x86/include/generated/asm/unaligned.h):
>> include/asm-generic/unaligned.h:119:16: sparse: sparse: cast truncates bits from constant value (aa01a0 becomes a0)
   include/asm-generic/unaligned.h:120:20: sparse: sparse: cast truncates bits from constant value (aa01 becomes 1)
>> include/asm-generic/unaligned.h:119:16: sparse: sparse: cast truncates bits from constant value (ab00d0 becomes d0)
   include/asm-generic/unaligned.h:120:20: sparse: sparse: cast truncates bits from constant value (ab00 becomes 0)

vim +119 include/asm-generic/unaligned.h

803f4e1eab7a89 Arnd Bergmann 2021-05-08  116  
803f4e1eab7a89 Arnd Bergmann 2021-05-08  117  static inline void __put_unaligned_le24(const u32 val, u8 *p)
803f4e1eab7a89 Arnd Bergmann 2021-05-08  118  {
803f4e1eab7a89 Arnd Bergmann 2021-05-08 @119  	*p++ = val;
803f4e1eab7a89 Arnd Bergmann 2021-05-08  120  	*p++ = val >> 8;
803f4e1eab7a89 Arnd Bergmann 2021-05-08  121  	*p++ = val >> 16;
803f4e1eab7a89 Arnd Bergmann 2021-05-08  122  }
803f4e1eab7a89 Arnd Bergmann 2021-05-08  123  

:::::: The code at line 119 was first introduced by commit
:::::: 803f4e1eab7a8938ba3a3c30dd4eb5e9eeef5e63 asm-generic: simplify asm/unaligned.h

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

