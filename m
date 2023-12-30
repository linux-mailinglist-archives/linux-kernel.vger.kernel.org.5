Return-Path: <linux-kernel+bounces-13323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1615E82037E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 04:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3AA61F223F1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 03:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7E4138E;
	Sat, 30 Dec 2023 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QL1lx/6t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F7E10F7
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 03:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703907369; x=1735443369;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pkiAaiYUJKoKGB8SSbAlOVq9s7UuR563RTMrE02GWcI=;
  b=QL1lx/6tXeWs+HpqbX1FTbfsWbNLG1dJn4QbyJ1JebLEh+QrRbMwWskP
   xGyzzI9ABS8akVXl2uo6247pdPkpkBzAtuDvzmi3W95OqW0j0Lk2WCCkn
   EKzB0XBWXaEuO2UkvSjJzz2CbU3sr2qkRhRvn85FGvZdv4x4u980SYVeR
   /x4xbXr4zlgO9YNPrAFwESnLggfWBRxJFtZT8vOGeaibq3CqZUmlL/kjY
   yuIjh2ooOSRnput8IW62aDmaMvxPennGlohDOA1E54rxk7MxotnI6QoSN
   SWPRY17SQIjdZphexKHky74C3ww+V1MEHA1bW1Z0ZrpoPnQ9DnT9el5Wt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="461006571"
X-IronPort-AV: E=Sophos;i="6.04,317,1695711600"; 
   d="scan'208";a="461006571"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 19:36:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="778941786"
X-IronPort-AV: E=Sophos;i="6.04,317,1695711600"; 
   d="scan'208";a="778941786"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 29 Dec 2023 19:36:07 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJQ8r-000I1N-1a;
	Sat, 30 Dec 2023 03:36:05 +0000
Date: Sat, 30 Dec 2023 11:35:55 +0800
From: kernel test robot <lkp@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: ld.lld: error: vmlinux.a(kernel/crash_core.o):(function
 crash_save_vmcoreinfo_init: .init.text+0xcb0): relocation R_RISCV_PCREL_HI20
 out of range: -533294 is not in [-524288, 524287]; references kallsyms_names
Message-ID: <202312301151.S5ssBkOi-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jens,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f016f7547aeedefed9450499d002ba983b8fce15
commit: f8fa5d76925991976b3e7076f9d1052515ec1fca cred: switch to using atomic_long_t
date:   2 weeks ago
config: riscv-randconfig-r052-20231230 (https://download.01.org/0day-ci/archive/20231230/202312301151.S5ssBkOi-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231230/202312301151.S5ssBkOi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312301151.S5ssBkOi-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: vmlinux.a(kernel/crash_core.o):(function crash_save_vmcoreinfo_init: .init.text+0xcb0): relocation R_RISCV_PCREL_HI20 out of range: -533294 is not in [-524288, 524287]; references kallsyms_names
   >>> referenced by crash_core.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/crash_core.o):(function crash_save_vmcoreinfo_init: .init.text+0xccc): relocation R_RISCV_PCREL_HI20 out of range: -533294 is not in [-524288, 524287]; references kallsyms_num_syms
   >>> referenced by crash_core.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/crash_core.o):(function crash_save_vmcoreinfo_init: .init.text+0xce8): relocation R_RISCV_PCREL_HI20 out of range: -533294 is not in [-524288, 524287]; references kallsyms_token_table
   >>> referenced by crash_core.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/crash_core.o):(function crash_save_vmcoreinfo_init: .init.text+0xd04): relocation R_RISCV_PCREL_HI20 out of range: -533294 is not in [-524288, 524287]; references kallsyms_token_index
   >>> referenced by crash_core.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/crash_core.o):(function crash_save_vmcoreinfo_init: .init.text+0xd20): relocation R_RISCV_PCREL_HI20 out of range: -533294 is not in [-524288, 524287]; references kallsyms_offsets
   >>> referenced by crash_core.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/crash_core.o):(function crash_save_vmcoreinfo_init: .init.text+0xd3c): relocation R_RISCV_PCREL_HI20 out of range: -533294 is not in [-524288, 524287]; references kallsyms_relative_base
   >>> referenced by crash_core.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

