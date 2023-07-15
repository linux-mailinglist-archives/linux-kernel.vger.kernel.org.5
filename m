Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B603D754748
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 09:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjGOHo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 03:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOHo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 03:44:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0FA2D66
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 00:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689407095; x=1720943095;
  h=date:from:to:cc:subject:message-id;
  bh=MnV5uKcfaQr5cQghk/C4i+rWEYGrQXd6vRLYW18bbXw=;
  b=KASphR0sn8wm226O16whlMtdIXgYf6U2mMM3mBc50uOMdnCVpYRCJKZs
   Gf5XhP4Hym3Esd5CxHLeh14UusKUiICCs0nCCvjOjL1P1i6qHtkeMxq21
   Cvi8hq/o1OrcUjf4bF9dWx+Gt98n1uVkeBmR0v4BTMlbRG/y+GgG7SNT+
   py4kF7IHtFIDHmxrXCfqNhBaVmyoX8fok8qQU5W7gkSt8+bLuSDub/9Nu
   U3jwsWBMh7O2NCkco/O34anNLB/23LERrkfyJvj2rLNdXGbFiSnAkB9gS
   ON7Vj5o+rkSQYT+RpLNPDcsgxPFmRCEH9GtW9qbDLlSR5NQatbtXVcIw0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="345238018"
X-IronPort-AV: E=Sophos;i="6.01,207,1684825200"; 
   d="scan'208";a="345238018"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2023 00:44:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="752309699"
X-IronPort-AV: E=Sophos;i="6.01,207,1684825200"; 
   d="scan'208";a="752309699"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 15 Jul 2023 00:44:53 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qKZxV-00081G-0S;
        Sat, 15 Jul 2023 07:44:53 +0000
Date:   Sat, 15 Jul 2023 15:44:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.07.12a] BUILD SUCCESS
 3107d159d067c456b9d05656db84d0fc5f5f21a7
Message-ID: <202307151507.CfZKPPD8-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.07.12a
branch HEAD: 3107d159d067c456b9d05656db84d0fc5f5f21a7  torture: Cause mkinitrd.sh to indicate failure on compile errors

elapsed time: 724m

configs tested: 137
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230714   gcc  
alpha                randconfig-r023-20230714   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r033-20230714   gcc  
arc                  randconfig-r043-20230714   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                  randconfig-r046-20230714   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r021-20230714   gcc  
hexagon              randconfig-r041-20230714   clang
hexagon              randconfig-r045-20230714   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230714   gcc  
i386         buildonly-randconfig-r005-20230714   gcc  
i386         buildonly-randconfig-r006-20230714   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230714   gcc  
i386                 randconfig-i002-20230714   gcc  
i386                 randconfig-i003-20230714   gcc  
i386                 randconfig-i004-20230714   gcc  
i386                 randconfig-i005-20230714   gcc  
i386                 randconfig-i006-20230714   gcc  
i386                 randconfig-i011-20230714   clang
i386                 randconfig-i012-20230714   clang
i386                 randconfig-i013-20230714   clang
i386                 randconfig-i014-20230714   clang
i386                 randconfig-i015-20230714   clang
i386                 randconfig-i016-20230714   clang
i386                 randconfig-r002-20230714   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230714   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze           randconfig-r015-20230714   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips                     decstation_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230714   gcc  
nios2                randconfig-r014-20230714   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r005-20230714   gcc  
openrisc             randconfig-r035-20230714   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r013-20230714   gcc  
parisc               randconfig-r025-20230714   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc                     mpc5200_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                  storcenter_defconfig   gcc  
powerpc                      tqm8xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230714   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r006-20230714   gcc  
s390                 randconfig-r024-20230714   clang
s390                 randconfig-r044-20230714   clang
sh                               allmodconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r022-20230714   gcc  
sh                   randconfig-r026-20230714   gcc  
sh                   randconfig-r032-20230714   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r031-20230714   gcc  
sparc                randconfig-r034-20230714   gcc  
sparc                       sparc32_defconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64              randconfig-r004-20230714   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r011-20230714   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230714   gcc  
x86_64       buildonly-randconfig-r002-20230714   gcc  
x86_64       buildonly-randconfig-r003-20230714   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230714   clang
x86_64               randconfig-x002-20230714   clang
x86_64               randconfig-x003-20230714   clang
x86_64               randconfig-x004-20230714   clang
x86_64               randconfig-x005-20230714   clang
x86_64               randconfig-x006-20230714   clang
x86_64               randconfig-x011-20230713   clang
x86_64               randconfig-x012-20230713   clang
x86_64               randconfig-x013-20230713   clang
x86_64               randconfig-x014-20230713   clang
x86_64               randconfig-x015-20230713   clang
x86_64               randconfig-x016-20230713   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa               randconfig-r036-20230714   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
