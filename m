Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0111E7EFD65
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 04:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjKRDUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 22:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKRDUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 22:20:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E6710CE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 19:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700277627; x=1731813627;
  h=date:from:to:cc:subject:message-id;
  bh=6kRa1mY3XJDg8YcsZ42EniHfqDUcM/sxihrNvQmV+cQ=;
  b=Xwzf99iA1fJ+RUlXqPwnMIXjE11cq+i7HsC+qQllWFFCyW5uSKOtN7EK
   HQH+mpUEM6Y4Pjgx9DJvcPfuefBqYw3ZCtciMXIge4PVTs+uHQDXW+X1o
   /ykRrFvqTDwzWzZI1OVQXpsPDLO8dv2lFO3fV/xhNGKcS/HIoUy298Wri
   uzhO0cVrEQET497xXIq1c9AeHlUAqHshjXvShr5uvaugupA12JLmmHdS5
   Lvf6BwwXlzlS2Vs9rck8bbUPreFGxz8asIUrXkzNThDrCAqgnLWfdr0FT
   kYV0Qnr9iwrTe1ZiJq+RmAgBMg7VT9hfKl4B1phFzJz9ZxWVfNjHBDQtO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="376451096"
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="376451096"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 19:20:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="14083052"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2023 19:20:25 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4Bsc-0003TT-3B;
        Sat, 18 Nov 2023 03:20:22 +0000
Date:   Sat, 18 Nov 2023 11:19:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 bc5607d7777423b742f5b0f7a760d074154c613f
Message-ID: <202311181146.uBej2pNX-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: bc5607d7777423b742f5b0f7a760d074154c613f  x86/mm: Use %RIP-relative address in untagged_addr()

elapsed time: 742m

configs tested: 167
configs skipped: 124

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20231118   gcc  
arc                   randconfig-002-20231118   gcc  
arm                      integrator_defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                   randconfig-001-20231118   gcc  
arm                   randconfig-002-20231118   gcc  
arm                   randconfig-003-20231118   gcc  
arm                   randconfig-004-20231118   gcc  
arm                           u8500_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                 randconfig-001-20231118   gcc  
arm64                 randconfig-002-20231118   gcc  
arm64                 randconfig-003-20231118   gcc  
arm64                 randconfig-004-20231118   gcc  
csky                  randconfig-001-20231118   gcc  
csky                  randconfig-002-20231118   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             alldefconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231118   gcc  
i386         buildonly-randconfig-002-20231118   gcc  
i386         buildonly-randconfig-003-20231118   gcc  
i386         buildonly-randconfig-004-20231118   gcc  
i386         buildonly-randconfig-005-20231118   gcc  
i386         buildonly-randconfig-006-20231118   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231118   gcc  
i386                  randconfig-002-20231118   gcc  
i386                  randconfig-003-20231118   gcc  
i386                  randconfig-004-20231118   gcc  
i386                  randconfig-005-20231118   gcc  
i386                  randconfig-006-20231118   gcc  
i386                  randconfig-011-20231118   gcc  
i386                  randconfig-012-20231118   gcc  
i386                  randconfig-013-20231118   gcc  
i386                  randconfig-014-20231118   gcc  
i386                  randconfig-015-20231118   gcc  
i386                  randconfig-016-20231118   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231118   gcc  
loongarch             randconfig-002-20231118   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231118   gcc  
nios2                 randconfig-002-20231118   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231118   gcc  
parisc                randconfig-002-20231118   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc               randconfig-001-20231118   gcc  
powerpc               randconfig-002-20231118   gcc  
powerpc               randconfig-003-20231118   gcc  
powerpc64             randconfig-001-20231118   gcc  
powerpc64             randconfig-002-20231118   gcc  
powerpc64             randconfig-003-20231118   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231118   gcc  
riscv                 randconfig-002-20231118   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231118   gcc  
s390                  randconfig-002-20231118   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                    randconfig-001-20231118   gcc  
sh                    randconfig-002-20231118   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231118   gcc  
sparc64               randconfig-002-20231118   gcc  
um                               allmodconfig   gcc  
um                                allnoconfig   gcc  
um                               allyesconfig   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231118   gcc  
um                    randconfig-002-20231118   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231118   gcc  
x86_64       buildonly-randconfig-002-20231118   gcc  
x86_64       buildonly-randconfig-003-20231118   gcc  
x86_64       buildonly-randconfig-004-20231118   gcc  
x86_64       buildonly-randconfig-005-20231118   gcc  
x86_64       buildonly-randconfig-006-20231118   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231118   gcc  
x86_64                randconfig-002-20231118   gcc  
x86_64                randconfig-003-20231118   gcc  
x86_64                randconfig-004-20231118   gcc  
x86_64                randconfig-005-20231118   gcc  
x86_64                randconfig-006-20231118   gcc  
x86_64                randconfig-011-20231118   gcc  
x86_64                randconfig-012-20231118   gcc  
x86_64                randconfig-013-20231118   gcc  
x86_64                randconfig-014-20231118   gcc  
x86_64                randconfig-015-20231118   gcc  
x86_64                randconfig-016-20231118   gcc  
x86_64                randconfig-071-20231118   gcc  
x86_64                randconfig-072-20231118   gcc  
x86_64                randconfig-073-20231118   gcc  
x86_64                randconfig-074-20231118   gcc  
x86_64                randconfig-075-20231118   gcc  
x86_64                randconfig-076-20231118   gcc  
x86_64                           rhel-8.3-bpf   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231118   gcc  
xtensa                randconfig-002-20231118   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
