Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD04C77CB62
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbjHOK63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236549AbjHOK5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:57:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F670198B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692097073; x=1723633073;
  h=date:from:to:cc:subject:message-id;
  bh=76B7j1HXHIyPXPOAIlho9nsrlPQYrFdhyPSoB9dFM5c=;
  b=N6TWe+Ks1Oylm7L+9vg7V/SpI/5G89pWuVANGLybbIqs9ZWJ7n+l5QeL
   OyqR6kUfa54u8JT/2BL0FSpnXT7sIZPS6FP73/PiII25RId92YVraAf75
   qIJWrlByccm0+lrufJC+KDGc7fXU8Fw6HirYxjRuFTyUkpY3HGHzdisfs
   oaFyHAdzJByfOs0ZhBOhX2oOvm+PRdxD+p4KFab29wf4g7IET3LVqZ+9n
   lX/w7NxQ5V2djsads0GXxJ2Ngl3PAaNYny6rYh50cGtaSo/eic+D1QKfC
   llqHZqPkjyLEhbH1ZD6IZBeMjlXblUrErnXe0tFr5odGg7GYrMhsAZ2Pu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="362404098"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="362404098"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 03:57:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="733801121"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="733801121"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2023 03:57:51 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVrkE-0000tD-2Y;
        Tue, 15 Aug 2023 10:57:50 +0000
Date:   Tue, 15 Aug 2023 18:57:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 7170509cadbb76e5fa7d7b090d2cbdb93d56a2de
Message-ID: <202308151854.XU11FOXp-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 7170509cadbb76e5fa7d7b090d2cbdb93d56a2de  sched: Simplify sched_core_cpu_{starting,deactivate}()

elapsed time: 1177m

configs tested: 283
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230815   gcc  
alpha                randconfig-r013-20230815   gcc  
alpha                randconfig-r022-20230815   gcc  
alpha                randconfig-r024-20230815   gcc  
alpha                randconfig-r031-20230815   gcc  
alpha                randconfig-r033-20230815   gcc  
alpha                randconfig-r034-20230815   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230815   gcc  
arc                  randconfig-r002-20230815   gcc  
arc                  randconfig-r003-20230815   gcc  
arc                  randconfig-r013-20230815   gcc  
arc                  randconfig-r023-20230815   gcc  
arc                  randconfig-r024-20230815   gcc  
arc                  randconfig-r043-20230815   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                          moxart_defconfig   clang
arm                            mps2_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                             mxs_defconfig   clang
arm                             pxa_defconfig   gcc  
arm                  randconfig-r004-20230815   gcc  
arm                  randconfig-r006-20230815   gcc  
arm                  randconfig-r011-20230815   clang
arm                  randconfig-r024-20230815   clang
arm                  randconfig-r025-20230815   clang
arm                  randconfig-r026-20230814   gcc  
arm                  randconfig-r034-20230815   gcc  
arm                  randconfig-r046-20230815   clang
arm                        shmobile_defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            alldefconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230815   clang
arm64                randconfig-r012-20230815   gcc  
arm64                randconfig-r014-20230815   gcc  
arm64                randconfig-r016-20230815   gcc  
arm64                randconfig-r021-20230815   gcc  
arm64                randconfig-r022-20230815   gcc  
arm64                randconfig-r025-20230815   gcc  
arm64                randconfig-r026-20230815   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r013-20230815   gcc  
csky                 randconfig-r014-20230815   gcc  
csky                 randconfig-r015-20230815   gcc  
csky                 randconfig-r016-20230815   gcc  
csky                 randconfig-r031-20230815   gcc  
hexagon              randconfig-r026-20230815   clang
hexagon              randconfig-r041-20230815   clang
hexagon              randconfig-r045-20230815   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230815   clang
i386         buildonly-randconfig-r005-20230815   clang
i386         buildonly-randconfig-r006-20230815   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230814   gcc  
i386                 randconfig-i001-20230815   clang
i386                 randconfig-i002-20230814   gcc  
i386                 randconfig-i002-20230815   clang
i386                 randconfig-i003-20230814   gcc  
i386                 randconfig-i003-20230815   clang
i386                 randconfig-i004-20230814   gcc  
i386                 randconfig-i004-20230815   clang
i386                 randconfig-i005-20230814   gcc  
i386                 randconfig-i005-20230815   clang
i386                 randconfig-i006-20230814   gcc  
i386                 randconfig-i006-20230815   clang
i386                 randconfig-i011-20230815   gcc  
i386                 randconfig-i012-20230815   gcc  
i386                 randconfig-i013-20230815   gcc  
i386                 randconfig-i014-20230815   gcc  
i386                 randconfig-i015-20230815   gcc  
i386                 randconfig-i016-20230815   gcc  
i386                 randconfig-r004-20230815   clang
i386                 randconfig-r005-20230815   clang
i386                 randconfig-r014-20230815   gcc  
i386                 randconfig-r016-20230815   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230815   gcc  
loongarch            randconfig-r012-20230815   gcc  
loongarch            randconfig-r013-20230815   gcc  
loongarch            randconfig-r021-20230814   gcc  
loongarch            randconfig-r022-20230814   gcc  
loongarch            randconfig-r023-20230815   gcc  
loongarch            randconfig-r035-20230815   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r003-20230815   gcc  
m68k                 randconfig-r006-20230815   gcc  
m68k                 randconfig-r013-20230815   gcc  
m68k                 randconfig-r014-20230815   gcc  
m68k                 randconfig-r015-20230815   gcc  
m68k                 randconfig-r021-20230815   gcc  
m68k                 randconfig-r024-20230815   gcc  
m68k                 randconfig-r025-20230814   gcc  
m68k                 randconfig-r025-20230815   gcc  
m68k                 randconfig-r035-20230815   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze           randconfig-r001-20230815   gcc  
microblaze           randconfig-r011-20230815   gcc  
microblaze           randconfig-r012-20230815   gcc  
microblaze           randconfig-r015-20230815   gcc  
microblaze           randconfig-r022-20230815   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                       lemote2f_defconfig   clang
mips                     loongson1b_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                 randconfig-r002-20230815   gcc  
mips                 randconfig-r003-20230815   gcc  
mips                 randconfig-r036-20230815   gcc  
mips                           rs90_defconfig   clang
nios2                         3c120_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230815   gcc  
nios2                randconfig-r005-20230815   gcc  
nios2                randconfig-r011-20230815   gcc  
nios2                randconfig-r015-20230815   gcc  
nios2                randconfig-r023-20230815   gcc  
nios2                randconfig-r031-20230815   gcc  
openrisc             randconfig-r001-20230815   gcc  
openrisc             randconfig-r004-20230815   gcc  
openrisc             randconfig-r006-20230815   gcc  
openrisc             randconfig-r011-20230815   gcc  
openrisc             randconfig-r012-20230815   gcc  
openrisc             randconfig-r026-20230815   gcc  
parisc                           alldefconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r015-20230815   gcc  
parisc               randconfig-r016-20230815   gcc  
parisc               randconfig-r023-20230815   gcc  
parisc               randconfig-r024-20230815   gcc  
parisc               randconfig-r032-20230815   gcc  
parisc               randconfig-r033-20230815   gcc  
parisc               randconfig-r036-20230815   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                       ebony_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc              randconfig-r011-20230815   gcc  
powerpc              randconfig-r015-20230815   gcc  
powerpc              randconfig-r023-20230815   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     taishan_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                randconfig-r002-20230815   clang
riscv                randconfig-r026-20230815   gcc  
riscv                randconfig-r042-20230815   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r013-20230815   gcc  
s390                 randconfig-r022-20230815   gcc  
s390                 randconfig-r044-20230815   gcc  
sh                               allmodconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r002-20230815   gcc  
sh                   randconfig-r005-20230815   gcc  
sh                   randconfig-r011-20230815   gcc  
sh                   randconfig-r012-20230815   gcc  
sh                   randconfig-r025-20230815   gcc  
sh                   randconfig-r032-20230815   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                            titan_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230815   gcc  
sparc                randconfig-r004-20230815   gcc  
sparc                randconfig-r012-20230815   gcc  
sparc                randconfig-r016-20230815   gcc  
sparc                randconfig-r021-20230815   gcc  
sparc                randconfig-r022-20230815   gcc  
sparc                randconfig-r023-20230815   gcc  
sparc                randconfig-r024-20230815   gcc  
sparc                randconfig-r026-20230815   gcc  
sparc                randconfig-r031-20230815   gcc  
sparc                randconfig-r033-20230815   gcc  
sparc                randconfig-r034-20230815   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r002-20230815   gcc  
sparc64              randconfig-r003-20230815   gcc  
sparc64              randconfig-r004-20230815   gcc  
sparc64              randconfig-r005-20230815   gcc  
sparc64              randconfig-r012-20230815   gcc  
sparc64              randconfig-r021-20230815   gcc  
sparc64              randconfig-r023-20230814   gcc  
sparc64              randconfig-r024-20230815   gcc  
sparc64              randconfig-r036-20230815   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r001-20230815   gcc  
um                   randconfig-r005-20230815   gcc  
um                   randconfig-r014-20230815   clang
um                   randconfig-r024-20230814   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230815   clang
x86_64       buildonly-randconfig-r002-20230815   clang
x86_64       buildonly-randconfig-r003-20230815   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r005-20230815   clang
x86_64               randconfig-r006-20230815   clang
x86_64               randconfig-r013-20230815   gcc  
x86_64               randconfig-r015-20230815   gcc  
x86_64               randconfig-r021-20230815   gcc  
x86_64               randconfig-r025-20230815   gcc  
x86_64               randconfig-x001-20230815   gcc  
x86_64               randconfig-x002-20230815   gcc  
x86_64               randconfig-x003-20230815   gcc  
x86_64               randconfig-x004-20230815   gcc  
x86_64               randconfig-x005-20230815   gcc  
x86_64               randconfig-x006-20230815   gcc  
x86_64               randconfig-x011-20230814   gcc  
x86_64               randconfig-x011-20230815   clang
x86_64               randconfig-x012-20230814   gcc  
x86_64               randconfig-x012-20230815   clang
x86_64               randconfig-x013-20230814   gcc  
x86_64               randconfig-x013-20230815   clang
x86_64               randconfig-x014-20230814   gcc  
x86_64               randconfig-x014-20230815   clang
x86_64               randconfig-x015-20230814   gcc  
x86_64               randconfig-x015-20230815   clang
x86_64               randconfig-x016-20230814   gcc  
x86_64               randconfig-x016-20230815   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa               randconfig-r003-20230815   gcc  
xtensa               randconfig-r014-20230815   gcc  
xtensa               randconfig-r015-20230815   gcc  
xtensa               randconfig-r022-20230815   gcc  
xtensa               randconfig-r026-20230815   gcc  
xtensa               randconfig-r033-20230815   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
