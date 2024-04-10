Return-Path: <linux-kernel+bounces-137939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF2D89E9D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B96F2857D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8BF20309;
	Wed, 10 Apr 2024 05:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FLBGP2Bk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0CC168CC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712727399; cv=none; b=Y5PgUQFOmRLBgw7jXuXHKHNOHrB+EUmkTxzc6AJ/lEu7A/yip3m+KNjZO0wKRDUi+yadhnZJHJtf77EnDih6F/i554iBFcqHa0TC8MIRmAis0cfC1KYjiIZyqwVhyE0uvv7IfG/SieRzd0WIu9cEEA9w1EgOE56yx6VN+4obSQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712727399; c=relaxed/simple;
	bh=tneDLGnMthukd9PZWHKkFOw81KrbNr+svS6oICoufZ4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YNohlfXamjk7j4kBlp/H0FayJxBaRYxdQ1TqgXsucEtaNaiuJ+aPlCcBCg+OWKmQqeo4rDklWu8JZmBVZqvfzFMeDstZmJc0DSjq3mY+6j7wb7t1HvdzrcxnPFDWmZvh8ZPWLcbRg9ktn33o/q7gfzd8QuKpqqPzQ4VgTC+vT9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FLBGP2Bk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712727398; x=1744263398;
  h=date:from:to:cc:subject:message-id;
  bh=tneDLGnMthukd9PZWHKkFOw81KrbNr+svS6oICoufZ4=;
  b=FLBGP2BkKURHSjAMsbAHAdetYzJUesr/z4MIBpjfJKbRAvbsXY3jy8ZO
   iSppAOPe6lSkSxRXNeQaisECmZADaFeuFhmfNIjBVOhk6OqbXRjqKFmNo
   iRw1neiyJr60qzUiMMobv/310sJSBtFKbk4+QfILFAbX966kGRWE6iY5z
   lJ9jUXwP95yrqaXaP69gYBgjtIMKlfNGtEd+9Qt4OnIhqUWuqeBrBESKv
   KmjNEuuhKWvxu0X2WL130Tp3WEVc1WVcACf2NULDL65To98C1FSyMkFGl
   +sM4RDj4C62khYZYGW0NY3GfdfvBlYVVWWL9cs2o6RQOK/UsB8y8Dpq4c
   Q==;
X-CSE-ConnectionGUID: FLF4qbTJRyC8+YA2TXCcxg==
X-CSE-MsgGUID: wtENuz4vRWCA5gjjfaDElw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11911762"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11911762"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 22:36:36 -0700
X-CSE-ConnectionGUID: CYbxMDKTQjqZMYqObbWeNg==
X-CSE-MsgGUID: Z6GmpaE7QgCr+Rjaq1rgvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43698937"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 09 Apr 2024 22:36:35 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruQdM-0006xO-2Q;
	Wed, 10 Apr 2024 05:36:32 +0000
Date: Wed, 10 Apr 2024 13:35:46 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/asm] BUILD SUCCESS
 a0c8cf9780359376496bbd6d2be1343badf68af7
Message-ID: <202404101344.IF3RsBl0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
branch HEAD: a0c8cf9780359376496bbd6d2be1343badf68af7  x86/alternatives: Remove a superfluous newline in _static_cpu_has()

elapsed time: 740m

configs tested: 67
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240410   gcc  
i386         buildonly-randconfig-005-20240410   gcc  
i386         buildonly-randconfig-006-20240410   gcc  
i386                                defconfig   clang
i386                  randconfig-003-20240410   gcc  
i386                  randconfig-004-20240410   gcc  
i386                  randconfig-005-20240410   gcc  
i386                  randconfig-013-20240410   gcc  
i386                  randconfig-015-20240410   gcc  
i386                  randconfig-016-20240410   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
powerpc                        cell_defconfig   gcc  
riscv                               defconfig   clang
riscv             nommu_k210_sdcard_defconfig   gcc  
s390                             alldefconfig   gcc  
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                               j2_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

