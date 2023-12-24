Return-Path: <linux-kernel+bounces-10649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB5081D81A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 08:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C102827F5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 07:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B28111E;
	Sun, 24 Dec 2023 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SF08rd/r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780711383
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703403101; x=1734939101;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q6ff4HWBSRmFiOPlQx0359xtAIOVOrVPFNR+vvZTV5g=;
  b=SF08rd/r7+Hv6lDsb0t/ePS+ZQm86JEHWqojsjP8G1jAyDODI3JD6YqE
   CmnLXRWepK8GQ7o9ZwLmHLWMgJd0iTUIROfA9j80g4N2Ghpz6MwhqJEQw
   O6bxdvIHnElGmZRWdtCaKc+m69G48M9+Lw4yk5ASqkrEim1ZFtHciYfPs
   ZJRjmkJgNDoE6UJ+HG1dDEsGkZOKS/YgYbwMklp1JpALFhMqxhaOD8dqQ
   2uqfGigl62tBf56yV1L7ZFZi1SN5YpBCrjjmH5bHYcyVRNDrQPtZHfPEt
   REPISxfdhQR1FpVJymdfPDTEo1vMS3G9p3t9a7jmrUpURNClMnH+pG+Er
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="376364709"
X-IronPort-AV: E=Sophos;i="6.04,300,1695711600"; 
   d="scan'208";a="376364709"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 23:31:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="781000842"
X-IronPort-AV: E=Sophos;i="6.04,300,1695711600"; 
   d="scan'208";a="781000842"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 23 Dec 2023 23:31:39 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHIxU-000ByN-2b;
	Sun, 24 Dec 2023 07:31:36 +0000
Date: Sun, 24 Dec 2023 15:29:05 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: [tip:locking/core 1/1] powerpc-linux-ld: warning: orphan section
 `.bss..Lubsan_data3' from `kernel/ptrace.o' being placed in section
 `.bss..Lubsan_data3'
Message-ID: <202312241531.sgPHiubf-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
head:   a51749ab34d9e5dec548fe38ede7e01e8bb26454
commit: 5431fdd2c181dd2eac218e45b44deb2925fa48f0 [1/1] ptrace: Convert ptrace_attach() to use lock guards
config: powerpc-buildonly-randconfig-r005-20221211 (https://download.01.org/0day-ci/archive/20231224/202312241531.sgPHiubf-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231224/202312241531.sgPHiubf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312241531.sgPHiubf-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data3' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data3'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data3' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data3'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data3' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data3'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ADB_CUDA
   Depends on [n]: MACINTOSH_DRIVERS [=n] && (ADB [=n] || PPC_PMAC [=y]) && !PPC_PMAC64 [=n]
   Selected by [y]:
   - PPC_PMAC [=y] && PPC_BOOK3S [=y] && CPU_BIG_ENDIAN [=y] && POWER_RESET [=y] && PPC32 [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

