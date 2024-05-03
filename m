Return-Path: <linux-kernel+bounces-167108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1C18BA49C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCEB2B22D2E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F03B65A;
	Fri,  3 May 2024 00:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPbScSFJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1447ABE4F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 00:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714696750; cv=none; b=FMU0kba/zzy/pW0DnyTLhMhh/qLpsl+LxivxYIkhB2j6HiEp2BVhMero7Yy+smgKdHPczVQL59xsG82j1ORlcbKmmx5x9vTjA1F43KffYvMXebxSUSV+gcjBtqgI+ttled7SqlveaD0uZp36bIyzeJM6nvryNxar8QVjmXZyzWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714696750; c=relaxed/simple;
	bh=qxV06SKk4twaqucluHa4xhjNU3wsCKhN/lIJ8i2rACo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=usHUAnQgRpiMGV1E+bOjIWUhDKllikCfm47C3UnJVq37+6lZv0g9anmhOx6FyrZw3Rbzn63LOUPxaHnTXTZ21Y7j2GUHOzaSg4zxhjpx+v6oz4ZWLw3z30BWYvUapv2Khy//aBggnhJTcsaAqljhkFnYYiz1FSaoSdhokTjORNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPbScSFJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714696749; x=1746232749;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qxV06SKk4twaqucluHa4xhjNU3wsCKhN/lIJ8i2rACo=;
  b=cPbScSFJMzZQqgJ/ox2LqgyCQ3hUDamHOfoMWiIAQyLCS/v+kR7NktIc
   EgQRoZOzmuCPPQiKchL01T4ZpUlrURblKJKI8EasA75sNzMFJU1XLdm6B
   OzdD/HKMrkVPmPCUkLyWeHC34rgN8nY7+68RKSrx3wTSOhaJXj8HxsiFb
   OxUXhqnkc2SWMJ3Qs0sZUoG8Sw2ki37E17qiNIhx2u1Kp07NGaZOdrkQH
   JFKHGWip0TlxT5g5E8pNBioBbYqLRIDRcOTvnkVBFBbT3RzvNL6IwHiQc
   CIuTrgU2FYo5LdsZBrgDz9Yl4ZzdK4Ch7MLdUW25iNKIYvH6us4UO/iAh
   w==;
X-CSE-ConnectionGUID: N2iql7+wRTSZIwOAuzNDEw==
X-CSE-MsgGUID: zfzS1O3mQheJjrK5EOtdiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="21051470"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21051470"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 17:39:08 -0700
X-CSE-ConnectionGUID: uHx8KG0PQLqhnJrmeirDcQ==
X-CSE-MsgGUID: ajZe5dJpRuaIvkyba9JzYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="58489767"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 02 May 2024 17:39:07 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2gx6-000BAe-1q;
	Fri, 03 May 2024 00:39:04 +0000
Date: Fri, 3 May 2024 08:38:41 +0800
From: kernel test robot <lkp@intel.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [tip:perf/core 12/12] arch/x86/events/rapl.c:154:9: error: returning
 'const struct cpumask *' from a function with result type 'cpumask_t *' (aka
 'struct cpumask *') discards qualifiers
Message-ID: <202405030828.RgFuznL9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
head:   5d4d0283c0546559600dee7e9a4d87e402f3f4d9
commit: 5d4d0283c0546559600dee7e9a4d87e402f3f4d9 [12/12] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
config: i386-buildonly-randconfig-001-20240503 (https://download.01.org/0day-ci/archive/20240503/202405030828.RgFuznL9-lkp@intel.com/config)
compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240503/202405030828.RgFuznL9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405030828.RgFuznL9-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/events/rapl.c:154:9: error: returning 'const struct cpumask *' from a function with result type 'cpumask_t *' (aka 'struct cpumask *') discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     154 |         return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     155 |                                          topology_die_cpumask(cpu);
         |                                          ~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/events/rapl.c:106:2: note: expanded from macro 'rapl_pmu_is_pkg_scope'
     106 |         (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||  \
         |         ^
   1 error generated.


vim +154 arch/x86/events/rapl.c

   151	
   152	static inline cpumask_t *get_rapl_pmu_cpumask(int cpu)
   153	{
 > 154		return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
   155						 topology_die_cpumask(cpu);
   156	}
   157	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

