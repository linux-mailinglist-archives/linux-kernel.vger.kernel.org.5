Return-Path: <linux-kernel+bounces-167261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD758BA6A3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5592C282D7F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156D313959B;
	Fri,  3 May 2024 05:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SrcVShOG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8087B1C69D
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 05:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714714399; cv=none; b=gVPmQuNlwrFLkbnCx6sFlqnSswT5qF9ftc8j2f2doYqIjstZF1dznQcxeI0FgCUJtR/Im78DQcvBDhye5G+H7poqvjU6p5ILfS+QBXALlE/iYF5oWALF/VbUENZ8TP8lNp6UplDTeFlnJzvuJK8wlEMElrt5GpNDDwjT6idfbpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714714399; c=relaxed/simple;
	bh=OEqwxjQRosYukrFy642tb5yeSjEhzUyJJtZn4XqWdhY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=u5AogZF5KWgjsVyvOCF6kPXtjWgmArxzVEEc2kB7drLYYA5ObfvTeDb47ZJWmdln/Xn1Wy0kZLh/nhG679z9KcpSXSRqpznApMkYIcyb71Qj0+/KsZpezRdDhnU1co9obbaIpCL0rLkzSNvP+NmjGOjnonnmrCRfCShD4UgcIeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SrcVShOG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714714398; x=1746250398;
  h=date:from:to:cc:subject:message-id;
  bh=OEqwxjQRosYukrFy642tb5yeSjEhzUyJJtZn4XqWdhY=;
  b=SrcVShOGM6Ur3a4RrujOIFB+9Qjuqgg4hs7lykIPj/XIT/+2SfKNpiK3
   jAT3LiJuBABfMDL2Wp/xV8urkeuV6EwNfxXQVp26BpkcxCo42/u6bfKSq
   fQMzYI7zijL83aq3BqOFMCQ5vMMUiYLmdOUrRIt0Ah6HXlvAAXBUWX+7G
   igXtc5tKgGWTXKrStJMXB++wkDLMYFDmgG4pM3vQ4CX6aS7nArAfJQHQx
   y8SomprnF04QB1XUOTRk2BoBzI2/rKBpPSabkeqzqIoUMAEOLs+qCix7j
   6P9guefq52dFh45wlqJUM6bbDZ0Yz3xhOOToP54+IXHpkUOxNrwO/N4+r
   Q==;
X-CSE-ConnectionGUID: h1mpxCtZTJeX6PnaehiEUA==
X-CSE-MsgGUID: nieqZC+SRg66Jvpq6wEemQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="21926962"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21926962"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 22:33:17 -0700
X-CSE-ConnectionGUID: jjRH+SYJQ769iCQETeEq4w==
X-CSE-MsgGUID: 5/kcvgsGTfO7aUopXKrNNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27231374"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 02 May 2024 22:33:15 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2lXl-000BLk-0y;
	Fri, 03 May 2024 05:33:13 +0000
Date: Fri, 03 May 2024 13:32:29 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD REGRESSION
 5d4d0283c0546559600dee7e9a4d87e402f3f4d9
Message-ID: <202405031327.pUQAq2Vg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 5d4d0283c0546559600dee7e9a4d87e402f3f4d9  perf/x86/rapl: Fix the energy-pkg event for AMD CPUs

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202405030821.FtWhxfmP-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202405030828.RgFuznL9-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/x86/events/rapl.c:154:69: warning: return discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
arch/x86/events/rapl.c:154:9: error: returning 'const struct cpumask *' from a function with result type 'cpumask_t *' (aka 'struct cpumask *') discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- x86_64-buildonly-randconfig-001-20240503
|   `-- arch-x86-events-rapl.c:warning:return-discards-const-qualifier-from-pointer-target-type
`-- x86_64-randconfig-076-20240503
    `-- arch-x86-events-rapl.c:warning:return-discards-const-qualifier-from-pointer-target-type
clang_recent_errors
|-- i386-buildonly-randconfig-001-20240503
|   `-- arch-x86-events-rapl.c:error:returning-const-struct-cpumask-from-a-function-with-result-type-cpumask_t-(aka-struct-cpumask-)-discards-qualifiers-Werror-Wincompatible-pointer-types-discards-qualifiers
|-- i386-randconfig-005-20240503
|   `-- arch-x86-events-rapl.c:error:returning-const-struct-cpumask-from-a-function-with-result-type-cpumask_t-(aka-struct-cpumask-)-discards-qualifiers-Werror-Wincompatible-pointer-types-discards-qualifiers
|-- i386-randconfig-052-20240503
|   `-- arch-x86-events-rapl.c:error:returning-const-struct-cpumask-from-a-function-with-result-type-cpumask_t-(aka-struct-cpumask-)-discards-qualifiers-Werror-Wincompatible-pointer-types-discards-qualifiers
|-- i386-randconfig-061-20240503
|   `-- arch-x86-events-rapl.c:error:returning-const-struct-cpumask-from-a-function-with-result-type-cpumask_t-(aka-struct-cpumask-)-discards-qualifiers-Werror-Wincompatible-pointer-types-discards-qualifiers
|-- x86_64-randconfig-003-20240503
|   `-- arch-x86-events-rapl.c:error:returning-const-struct-cpumask-from-a-function-with-result-type-cpumask_t-(aka-struct-cpumask-)-discards-qualifiers-Werror-Wincompatible-pointer-types-discards-qualifiers
|-- x86_64-randconfig-006-20240503
|   `-- arch-x86-events-rapl.c:error:returning-const-struct-cpumask-from-a-function-with-result-type-cpumask_t-(aka-struct-cpumask-)-discards-qualifiers-Werror-Wincompatible-pointer-types-discards-qualifiers
|-- x86_64-randconfig-011-20240503
|   `-- arch-x86-events-rapl.c:error:returning-const-struct-cpumask-from-a-function-with-result-type-cpumask_t-(aka-struct-cpumask-)-discards-qualifiers-Werror-Wincompatible-pointer-types-discards-qualifiers
|-- x86_64-randconfig-015-20240503
|   `-- arch-x86-events-rapl.c:error:returning-const-struct-cpumask-from-a-function-with-result-type-cpumask_t-(aka-struct-cpumask-)-discards-qualifiers-Werror-Wincompatible-pointer-types-discards-qualifiers
|-- x86_64-randconfig-071-20240503
|   `-- arch-x86-events-rapl.c:error:returning-const-struct-cpumask-from-a-function-with-result-type-cpumask_t-(aka-struct-cpumask-)-discards-qualifiers-Werror-Wincompatible-pointer-types-discards-qualifiers
`-- x86_64-randconfig-075-20240503
    `-- arch-x86-events-rapl.c:error:returning-const-struct-cpumask-from-a-function-with-result-type-cpumask_t-(aka-struct-cpumask-)-discards-qualifiers-Werror-Wincompatible-pointer-types-discards-qualifiers

elapsed time: 1053m

configs tested: 139
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240503   gcc  
arc                   randconfig-002-20240503   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        multi_v5_defconfig   gcc  
arm                   randconfig-004-20240503   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           sama5_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240503   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240503   gcc  
csky                  randconfig-002-20240503   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240503   clang
i386         buildonly-randconfig-002-20240503   clang
i386         buildonly-randconfig-006-20240503   clang
i386                                defconfig   clang
i386                  randconfig-002-20240503   clang
i386                  randconfig-003-20240503   clang
i386                  randconfig-005-20240503   clang
i386                  randconfig-006-20240503   clang
i386                  randconfig-011-20240503   clang
i386                  randconfig-016-20240503   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240503   gcc  
loongarch             randconfig-002-20240503   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240503   gcc  
nios2                 randconfig-002-20240503   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240503   gcc  
parisc                randconfig-002-20240503   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc               randconfig-003-20240503   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240503   gcc  
riscv                 randconfig-002-20240503   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240503   gcc  
s390                  randconfig-002-20240503   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                    randconfig-001-20240503   gcc  
sh                    randconfig-002-20240503   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240503   gcc  
sparc64               randconfig-002-20240503   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240503   gcc  
x86_64       buildonly-randconfig-002-20240503   gcc  
x86_64       buildonly-randconfig-003-20240503   gcc  
x86_64       buildonly-randconfig-005-20240503   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-004-20240503   gcc  
x86_64                randconfig-005-20240503   gcc  
x86_64                randconfig-076-20240503   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240503   gcc  
xtensa                randconfig-002-20240503   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

