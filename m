Return-Path: <linux-kernel+bounces-165939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9170B8B93A1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 997F2B2140C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDB71946B;
	Thu,  2 May 2024 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5Qwunhq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E791D1862F
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 03:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714619641; cv=none; b=XdCX/ckIyPAjwzPdMhwS0kQD1FBL/+D2A20XuX3XxSUgoDQS4PH6/sTweE/E9PGNxnr5k5cBsn+BAjjICLzZhaWuuyP3xyAXyAUBcsVdTMzOZObPrnKmyFDvXWvOcVUFPRuv7Oc8fPrrllW9j6zhXFOMeABqvt98cQ6nnW4OoMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714619641; c=relaxed/simple;
	bh=4LIBJhkVV8BXQFOP75l14jwu7TRyky3fb72S4ZK6q9c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VNg7V37CGOLaBtZffOAVL0cP1xO7MOSJyhM2OcrvgzO+ljObTDCKHQhWmANRPKUB2e7gZj9fK61N9TH4IxeQG+WRkAaKajES8+O6cCbUHfCSHRvm3RCJC9DKF7D97vBVWLNcwcAIcWTVtU47x3ygVTkiH03/G+whQuDTTl5s4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5Qwunhq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714619639; x=1746155639;
  h=date:from:to:cc:subject:message-id;
  bh=4LIBJhkVV8BXQFOP75l14jwu7TRyky3fb72S4ZK6q9c=;
  b=e5QwunhqnQAeyTZofidyqC3Spac9Lf84lIDyaTcERHwBsk4vpmpcnhyP
   ORhx181JO7+C7i57s5XR2sl/5J7lYSO1dL6VLBdLi9hROP57Pq62IsKOP
   DmoVDn5HcTBNq91Z5k1S6Pi0dd6ci9XmaFYvpL/VxcxVo+UnYyL3FNtMN
   NHSM3dkO7hdJwbkJv5yZlZZkgKoRsKrmfEWmaypMW4Zzyu7/E4o0/66Rh
   9xbLki2Lp4SQ2InPGqwsuI4xGXF2uyQJ3bsx3kTwc6JXp5AmkQ5lB9zTA
   OVsNhxPOIl568LVHfJk8NF00cdRUCvaf4OWouCjC3NKVIpW4DmSOX9VY3
   g==;
X-CSE-ConnectionGUID: VMa9KoovSgK908wSWw7zyA==
X-CSE-MsgGUID: lLNDabjdTeOwq2c8zFggrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10591045"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10591045"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 20:13:58 -0700
X-CSE-ConnectionGUID: vpgfbyBfRi2+GsWmabrLpA==
X-CSE-MsgGUID: xd6f6r8qShydqsmNp1fpWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="57871701"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 01 May 2024 20:13:56 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2MtO-000ALV-0Y;
	Thu, 02 May 2024 03:13:54 +0000
Date: Thu, 02 May 2024 11:13:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.04.18a] BUILD SUCCESS WITH WARNING
 274af360588db0dafe36ffb5c61799fa77757ce7
Message-ID: <202405021124.xgrTmorn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.04.18a
branch HEAD: 274af360588db0dafe36ffb5c61799fa77757ce7  fixup! xtensa: Emulate one-byte cmpxchg

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202405011801.nWVMOtGS-lkp@intel.com

Warning: (recently discovered and may have been fixed)

arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct bucket_table *' makes integer from pointer without a cast [-Wint-conversion]
arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct callback_head *' makes integer from pointer without a cast [-Wint-conversion]
arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct dentry *' makes integer from pointer without a cast [-Wint-conversion]
arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct epitem *' makes integer from pointer without a cast [-Wint-conversion]
arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct file_lock_context *' makes integer from pointer without a cast [-Wint-conversion]
arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct genradix_node *' makes integer from pointer without a cast [-Wint-conversion]
arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct genradix_root *' makes integer from pointer without a cast [-Wint-conversion]
arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct list_head *' makes integer from pointer without a cast [-Wint-conversion]
arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct llist_node *' makes integer from pointer without a cast [-Wint-conversion]
arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct mm_struct *' makes integer from pointer without a cast [-Wint-conversion]
arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct request *' makes integer from pointer without a cast [-Wint-conversion]
arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct task_struct *' makes integer from pointer without a cast [-Wint-conversion]
arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct wake_q_node *' makes integer from pointer without a cast [-Wint-conversion]
arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'struct workqueue_struct *' makes integer from pointer without a cast [-Wint-conversion]
arch/arc/include/asm/cmpxchg.h:74:25: warning: assignment to 'long unsigned int' from 'union nested_table *' makes integer from pointer without a cast [-Wint-conversion]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-allnoconfig
|   |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-bucket_table-makes-integer-from-pointer-without-a-cast
|   |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-callback_head-makes-integer-from-pointer-without-a-cast
|   |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-dentry-makes-integer-from-pointer-without-a-cast
|   |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-epitem-makes-integer-from-pointer-without-a-cast
|   |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-file_lock_context-makes-integer-from-pointer-without-a-cast
|   |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-genradix_node-makes-integer-from-pointer-without-a-cast
|   |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-genradix_root-makes-integer-from-pointer-without-a-cast
|   |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-list_head-makes-integer-from-pointer-without-a-cast
|   |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-llist_node-makes-integer-from-pointer-without-a-cast
|   |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-mm_struct-makes-integer-from-pointer-without-a-cast
|   |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-request-makes-integer-from-pointer-without-a-cast
|   |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-task_struct-makes-integer-from-pointer-without-a-cast
|   |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-wake_q_node-makes-integer-from-pointer-without-a-cast
|   |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-workqueue_struct-makes-integer-from-pointer-without-a-cast
|   `-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-union-nested_table-makes-integer-from-pointer-without-a-cast
`-- arc-randconfig-001-20240502
    |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-bucket_table-makes-integer-from-pointer-without-a-cast
    |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-callback_head-makes-integer-from-pointer-without-a-cast
    |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-dentry-makes-integer-from-pointer-without-a-cast
    |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-epitem-makes-integer-from-pointer-without-a-cast
    |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-file_lock_context-makes-integer-from-pointer-without-a-cast
    |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-genradix_node-makes-integer-from-pointer-without-a-cast
    |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-genradix_root-makes-integer-from-pointer-without-a-cast
    |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-list_head-makes-integer-from-pointer-without-a-cast
    |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-llist_node-makes-integer-from-pointer-without-a-cast
    |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-mm_struct-makes-integer-from-pointer-without-a-cast
    |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-request-makes-integer-from-pointer-without-a-cast
    |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-task_struct-makes-integer-from-pointer-without-a-cast
    |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-wake_q_node-makes-integer-from-pointer-without-a-cast
    |-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-struct-workqueue_struct-makes-integer-from-pointer-without-a-cast
    `-- arch-arc-include-asm-cmpxchg.h:warning:assignment-to-long-unsigned-int-from-union-nested_table-makes-integer-from-pointer-without-a-cast

elapsed time: 1543m

configs tested: 104
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240502   gcc  
arc                   randconfig-002-20240502   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                   randconfig-001-20240502   gcc  
arm                   randconfig-002-20240502   gcc  
arm                   randconfig-003-20240502   gcc  
arm                   randconfig-004-20240502   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240502   gcc  
arm64                 randconfig-002-20240502   clang
arm64                 randconfig-003-20240502   clang
arm64                 randconfig-004-20240502   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240502   gcc  
csky                  randconfig-002-20240502   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240502   clang
hexagon               randconfig-002-20240502   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240502   gcc  
i386         buildonly-randconfig-004-20240502   gcc  
i386                                defconfig   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240502   gcc  
loongarch             randconfig-002-20240502   gcc  
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
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                                defconfig   clang
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240502   gcc  
x86_64       buildonly-randconfig-002-20240502   gcc  
x86_64       buildonly-randconfig-003-20240502   clang
x86_64       buildonly-randconfig-004-20240502   gcc  
x86_64       buildonly-randconfig-005-20240502   gcc  
x86_64       buildonly-randconfig-006-20240502   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240502   gcc  
x86_64                randconfig-002-20240502   clang
x86_64                randconfig-003-20240502   clang
x86_64                randconfig-004-20240502   gcc  
x86_64                randconfig-005-20240502   clang
x86_64                randconfig-006-20240502   clang
x86_64                randconfig-011-20240502   clang
x86_64                randconfig-012-20240502   clang
x86_64                randconfig-013-20240502   gcc  
x86_64                randconfig-014-20240502   gcc  
x86_64                randconfig-015-20240502   gcc  
x86_64                randconfig-016-20240502   clang
x86_64                randconfig-071-20240502   gcc  
x86_64                randconfig-072-20240502   gcc  
x86_64                randconfig-073-20240502   gcc  
x86_64                randconfig-074-20240502   clang
x86_64                randconfig-075-20240502   clang
x86_64                randconfig-076-20240502   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

