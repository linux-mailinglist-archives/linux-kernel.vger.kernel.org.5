Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349CF77EA79
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345922AbjHPUNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346071AbjHPUMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:12:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BFFF3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692216767; x=1723752767;
  h=date:from:to:cc:subject:message-id;
  bh=PxxwToUPGJmczV6k/pIbHKpKPsDh6Fccf038jinsKzg=;
  b=IZsMTqqlhGA7EHirFaRGorqf3RkkwRGNsMu/qlMwdzutCNSZUuWVso+p
   d5aNS+8Wf8NqCRAQV3bwjJH0ycJmb4xyAKuDEiqPFaRtIve753RcLeNnT
   rws0cPLAg7CFhVVeGH64rxyzrXI6QQ2dRHlBRbtG7IHZZfLvN0XtwmnlP
   XHtQ5tGO9utori3TxeGPTjwIqYEmFxi/mSxki+pCpy6yYhf5ADrIJPHtM
   brB2BuemkOvsLgBu12j5wybKAkmxlQWzc55zLr+s9eM3IvIqGVOPVg+Tg
   DaPxe0aiDgG0FlkeuZqZQP3QpcsvNCEwnT2Qii3IhvwJbTVH9rIJSGY5Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="458983236"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="458983236"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 13:09:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980851000"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="980851000"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2023 13:09:50 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWMpy-0000Wb-03;
        Wed, 16 Aug 2023 20:09:50 +0000
Date:   Thu, 17 Aug 2023 04:09:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD REGRESSION
 d80c3c9de067e08498d9bbfef7ab0b716fe4cc05
Message-ID: <202308170444.KQxfMslJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: d80c3c9de067e08498d9bbfef7ab0b716fe4cc05  x86/srso: Explain the untraining sequences a bit more

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202308170133.1Ix5PpIZ-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/x86/lib/retpoline.o: warning: objtool: srso_untrain_ret+0xd: call without frame pointer save/setup

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-x015-20230816
    `-- arch-x86-lib-retpoline.o:warning:objtool:srso_untrain_ret:call-without-frame-pointer-save-setup

elapsed time: 726m

configs tested: 161
configs skipped: 12

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230816   gcc  
alpha                randconfig-r006-20230816   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                  randconfig-r026-20230817   gcc  
arc                  randconfig-r031-20230816   gcc  
arc                  randconfig-r035-20230817   gcc  
arc                  randconfig-r043-20230817   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                  randconfig-r036-20230816   clang
arm                        realview_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r021-20230817   gcc  
arm64                randconfig-r035-20230816   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r022-20230816   gcc  
csky                 randconfig-r023-20230816   gcc  
csky                 randconfig-r032-20230817   gcc  
csky                 randconfig-r036-20230817   gcc  
hexagon              randconfig-r011-20230816   clang
hexagon              randconfig-r024-20230816   clang
hexagon              randconfig-r033-20230816   clang
hexagon              randconfig-r041-20230816   clang
hexagon              randconfig-r045-20230816   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230816   gcc  
i386         buildonly-randconfig-r004-20230817   clang
i386         buildonly-randconfig-r005-20230816   gcc  
i386         buildonly-randconfig-r005-20230817   clang
i386         buildonly-randconfig-r006-20230816   gcc  
i386         buildonly-randconfig-r006-20230817   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230816   gcc  
i386                 randconfig-i001-20230817   clang
i386                 randconfig-i002-20230816   gcc  
i386                 randconfig-i002-20230817   clang
i386                 randconfig-i003-20230816   gcc  
i386                 randconfig-i003-20230817   clang
i386                 randconfig-i004-20230816   gcc  
i386                 randconfig-i004-20230817   clang
i386                 randconfig-i005-20230816   gcc  
i386                 randconfig-i005-20230817   clang
i386                 randconfig-i006-20230816   gcc  
i386                 randconfig-i006-20230817   clang
i386                 randconfig-i011-20230816   clang
i386                 randconfig-i012-20230816   clang
i386                 randconfig-i013-20230816   clang
i386                 randconfig-i014-20230816   clang
i386                 randconfig-i015-20230816   clang
i386                 randconfig-i016-20230816   clang
i386                 randconfig-r025-20230817   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230816   gcc  
loongarch            randconfig-r005-20230816   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230816   gcc  
m68k                 randconfig-r016-20230816   gcc  
microblaze           randconfig-r011-20230816   gcc  
microblaze           randconfig-r021-20230816   gcc  
microblaze           randconfig-r022-20230817   gcc  
microblaze           randconfig-r033-20230816   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                     cu1000-neo_defconfig   gcc  
mips                 randconfig-r003-20230816   clang
mips                 randconfig-r014-20230816   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r013-20230816   gcc  
nios2                randconfig-r026-20230816   gcc  
nios2                randconfig-r033-20230817   gcc  
nios2                randconfig-r034-20230816   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230816   gcc  
parisc               randconfig-r006-20230816   gcc  
parisc               randconfig-r035-20230816   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 mpc8315_rdb_defconfig   gcc  
powerpc              randconfig-r013-20230816   clang
powerpc              randconfig-r026-20230817   gcc  
powerpc                     redwood_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r021-20230817   gcc  
riscv                randconfig-r042-20230816   clang
riscv                randconfig-r042-20230817   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r034-20230816   gcc  
s390                 randconfig-r044-20230816   clang
s390                 randconfig-r044-20230817   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                   randconfig-r002-20230816   gcc  
sh                          rsk7269_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230816   gcc  
sparc                randconfig-r016-20230816   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64              randconfig-r001-20230816   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r005-20230816   clang
um                   randconfig-r014-20230816   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230816   gcc  
x86_64       buildonly-randconfig-r001-20230817   clang
x86_64       buildonly-randconfig-r002-20230816   gcc  
x86_64       buildonly-randconfig-r002-20230817   clang
x86_64       buildonly-randconfig-r003-20230816   gcc  
x86_64       buildonly-randconfig-r003-20230817   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r023-20230817   gcc  
x86_64               randconfig-r025-20230816   clang
x86_64               randconfig-x001-20230817   gcc  
x86_64               randconfig-x002-20230817   gcc  
x86_64               randconfig-x003-20230817   gcc  
x86_64               randconfig-x004-20230817   gcc  
x86_64               randconfig-x005-20230817   gcc  
x86_64               randconfig-x006-20230817   gcc  
x86_64               randconfig-x011-20230816   gcc  
x86_64               randconfig-x012-20230816   gcc  
x86_64               randconfig-x013-20230816   gcc  
x86_64               randconfig-x014-20230816   gcc  
x86_64               randconfig-x015-20230816   gcc  
x86_64               randconfig-x016-20230816   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r015-20230816   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
