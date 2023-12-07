Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED3A8090B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443751AbjLGSwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjLGSwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:52:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EFCFA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701975165; x=1733511165;
  h=date:from:to:cc:subject:message-id;
  bh=Ik+MHeEVEeFLyLvjc936KGJQflVCZxi/Og/04aRMQrA=;
  b=K/RLVxF8jj6Fx1NfRzScH7zKIx+z0oaqer/u1/Kio8VDCLeEUe6c3fPy
   tlnsEj+3wUCylXEZYcEGPv8+i2If18X+2/wv2WIkqMWqHSOypzwMFBesJ
   svEtYNZLdHcFgoc09WtFc3ojVSD2z/1mAsvv+jXBY9PpNlO8nbYehZdtN
   GUnAqeh1eClGu5UvokBpud3J/qCe4SmCyoKtk71SWiJJzl1gTup3Ay4rC
   +1SHZ/xuzt3zYpCwxbP6C4dmOqZ89vrBgL0x8oDgsSSX0VTzjAEb7TQBJ
   2Q2gENMKZaGMQVX0JaFlDeWXUSvQ3Ncpr3uLfZvFdTUuMaIqPjGbfd+Uf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="480477225"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="480477225"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 10:52:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="800823651"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="800823651"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 07 Dec 2023 10:52:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBJUH-000Cgl-0K;
        Thu, 07 Dec 2023 18:52:41 +0000
Date:   Fri, 08 Dec 2023 02:51:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.12.05a] BUILD REGRESSION
 5434f4f6b4e66545d4c3b29108b41483d2365e36
Message-ID: <202312080247.igYT8gwG-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.12.05a
branch HEAD: 5434f4f6b4e66545d4c3b29108b41483d2365e36  context_tracking: Fix kerneldoc headers for __ct_user_{enter,exit}()

Unverified Error/Warning (likely false positive, please contact us if interested):

ERROR: modpost: vmlinux: local symbol 'rcu_cpu_stall_notifiers' was exported

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- riscv-randconfig-c033-20221102
    `-- ERROR:vmlinux:local-symbol-rcu_cpu_stall_notifiers-was-exported

elapsed time: 1474m

configs tested: 199
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231207   gcc  
arc                   randconfig-002-20231207   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                   randconfig-001-20231207   gcc  
arm                   randconfig-002-20231207   gcc  
arm                   randconfig-003-20231207   gcc  
arm                   randconfig-004-20231207   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231207   gcc  
arm64                 randconfig-002-20231207   gcc  
arm64                 randconfig-003-20231207   gcc  
arm64                 randconfig-004-20231207   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231207   gcc  
csky                  randconfig-002-20231207   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231207   gcc  
i386         buildonly-randconfig-002-20231207   gcc  
i386         buildonly-randconfig-003-20231207   gcc  
i386         buildonly-randconfig-004-20231207   gcc  
i386         buildonly-randconfig-005-20231207   gcc  
i386         buildonly-randconfig-006-20231207   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231207   gcc  
i386                  randconfig-002-20231207   gcc  
i386                  randconfig-003-20231207   gcc  
i386                  randconfig-004-20231207   gcc  
i386                  randconfig-005-20231207   gcc  
i386                  randconfig-006-20231207   gcc  
i386                  randconfig-011-20231207   clang
i386                  randconfig-012-20231207   clang
i386                  randconfig-013-20231207   clang
i386                  randconfig-014-20231207   clang
i386                  randconfig-015-20231207   clang
i386                  randconfig-016-20231207   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20231207   gcc  
loongarch             randconfig-002-20231207   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                         rt305x_defconfig   gcc  
mips                   sb1250_swarm_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231207   gcc  
nios2                 randconfig-002-20231207   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231207   gcc  
parisc                randconfig-002-20231207   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ep88xc_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      ppc40x_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc               randconfig-001-20231207   gcc  
powerpc               randconfig-002-20231207   gcc  
powerpc               randconfig-003-20231207   gcc  
powerpc                    socrates_defconfig   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc64             randconfig-001-20231207   gcc  
powerpc64             randconfig-002-20231207   gcc  
powerpc64             randconfig-003-20231207   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20231207   gcc  
riscv                 randconfig-002-20231207   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20231207   gcc  
sh                    randconfig-002-20231207   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231207   gcc  
sparc64               randconfig-002-20231207   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231207   gcc  
um                    randconfig-002-20231207   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231207   gcc  
x86_64       buildonly-randconfig-002-20231207   gcc  
x86_64       buildonly-randconfig-003-20231207   gcc  
x86_64       buildonly-randconfig-004-20231207   gcc  
x86_64       buildonly-randconfig-005-20231207   gcc  
x86_64       buildonly-randconfig-006-20231207   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231207   gcc  
x86_64                randconfig-012-20231207   gcc  
x86_64                randconfig-013-20231207   gcc  
x86_64                randconfig-014-20231207   gcc  
x86_64                randconfig-015-20231207   gcc  
x86_64                randconfig-016-20231207   gcc  
x86_64                randconfig-071-20231207   gcc  
x86_64                randconfig-072-20231207   gcc  
x86_64                randconfig-073-20231207   gcc  
x86_64                randconfig-074-20231207   gcc  
x86_64                randconfig-075-20231207   gcc  
x86_64                randconfig-076-20231207   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231207   gcc  
xtensa                randconfig-002-20231207   gcc  
xtensa                         virt_defconfig   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
