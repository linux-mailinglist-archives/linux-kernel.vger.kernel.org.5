Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF99278045E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357545AbjHRDYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357604AbjHRDX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:23:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE943C0C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 20:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692329027; x=1723865027;
  h=date:from:to:cc:subject:message-id;
  bh=sklDhkRj3hVG5IVjPhwX7jszQAV5G3orua/SMA2hUEA=;
  b=fvE9iFqGKfCXpXYLsjUIq4iuqD/+i8M4+GhQIc/foH/ROC0zJVifUpKb
   eyaQU1qercxvkNvcdbdMw6OFh+KHyL2zt3htkBUpA7dwx3nrgvZ1DLzTL
   SGXPCzbONjqdXrb/qZrUtfMRxPQOoKDVSmZL7TgBC9R/GlRGGCLk4fnuT
   ugBW1eawL6i5TMF0NL2dpPftfSnzZUq6sDp2qgIxJbhT/LqA3ZzWnrbCq
   nqjSS74YzL1ZpCgMbx5oYuouKv4hYOytD0sLRZl6M4uvagS73H8P1uUFs
   4bhl41pkv/IKFlLWjJTwFstONbx5yLq/Bvj21+/S1ggUzxk1zZzi9MPR8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="352589903"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="352589903"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 20:23:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849114747"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="849114747"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2023 20:23:44 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWq5P-00023Q-2i;
        Fri, 18 Aug 2023 03:23:43 +0000
Date:   Fri, 18 Aug 2023 11:23:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 63304558ba5dcaaff9e052ee43cfdcc7f9c29e85
Message-ID: <202308181129.UO7XFCvm-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 63304558ba5dcaaff9e052ee43cfdcc7f9c29e85  sched/eevdf: Curb wakeup-preemption

elapsed time: 725m

configs tested: 145
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r015-20230818   gcc  
alpha                randconfig-r026-20230818   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r021-20230818   gcc  
arc                  randconfig-r022-20230818   gcc  
arc                  randconfig-r043-20230818   gcc  
arm                              alldefconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                  randconfig-r004-20230818   clang
arm                  randconfig-r013-20230818   gcc  
arm                  randconfig-r014-20230818   gcc  
arm                  randconfig-r021-20230818   gcc  
arm                  randconfig-r024-20230818   gcc  
arm                  randconfig-r035-20230818   clang
arm                  randconfig-r046-20230818   gcc  
arm                           tegra_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r033-20230818   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230818   gcc  
csky                 randconfig-r012-20230818   gcc  
hexagon              randconfig-r005-20230818   clang
hexagon              randconfig-r036-20230818   clang
hexagon              randconfig-r041-20230818   clang
hexagon              randconfig-r045-20230818   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230818   gcc  
i386         buildonly-randconfig-r005-20230818   gcc  
i386         buildonly-randconfig-r006-20230818   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230818   gcc  
i386                 randconfig-i002-20230818   gcc  
i386                 randconfig-i003-20230818   gcc  
i386                 randconfig-i004-20230818   gcc  
i386                 randconfig-i005-20230818   gcc  
i386                 randconfig-i006-20230818   gcc  
i386                 randconfig-i011-20230818   clang
i386                 randconfig-i012-20230818   clang
i386                 randconfig-i013-20230818   clang
i386                 randconfig-i014-20230818   clang
i386                 randconfig-i015-20230818   clang
i386                 randconfig-i016-20230818   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230818   gcc  
loongarch            randconfig-r015-20230818   gcc  
loongarch            randconfig-r021-20230818   gcc  
loongarch            randconfig-r025-20230818   gcc  
loongarch            randconfig-r026-20230818   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r023-20230818   gcc  
microblaze           randconfig-r003-20230818   gcc  
microblaze           randconfig-r036-20230818   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r001-20230818   clang
mips                 randconfig-r012-20230818   gcc  
mips                 randconfig-r023-20230818   gcc  
mips                           rs90_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230818   gcc  
nios2                randconfig-r006-20230818   gcc  
nios2                randconfig-r024-20230818   gcc  
nios2                randconfig-r026-20230818   gcc  
openrisc             randconfig-r003-20230818   gcc  
openrisc             randconfig-r004-20230818   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r034-20230818   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc              randconfig-r016-20230818   clang
powerpc                    socrates_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230818   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r031-20230818   gcc  
s390                 randconfig-r044-20230818   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230818   gcc  
sh                   randconfig-r024-20230818   gcc  
sh                   randconfig-r025-20230818   gcc  
sh                   randconfig-r032-20230818   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r014-20230818   gcc  
sparc64              randconfig-r016-20230818   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r011-20230818   gcc  
um                   randconfig-r014-20230818   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230818   gcc  
x86_64       buildonly-randconfig-r002-20230818   gcc  
x86_64       buildonly-randconfig-r003-20230818   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r002-20230818   gcc  
x86_64               randconfig-r005-20230818   gcc  
x86_64               randconfig-r013-20230818   clang
x86_64               randconfig-x001-20230818   clang
x86_64               randconfig-x002-20230818   clang
x86_64               randconfig-x003-20230818   clang
x86_64               randconfig-x004-20230818   clang
x86_64               randconfig-x005-20230818   clang
x86_64               randconfig-x006-20230818   clang
x86_64               randconfig-x011-20230818   gcc  
x86_64               randconfig-x012-20230818   gcc  
x86_64               randconfig-x013-20230818   gcc  
x86_64               randconfig-x014-20230818   gcc  
x86_64               randconfig-x015-20230818   gcc  
x86_64               randconfig-x016-20230818   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r035-20230818   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
