Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6EB7FB2FA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343716AbjK1Hlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjK1Hl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:41:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1648E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701157294; x=1732693294;
  h=date:from:to:cc:subject:message-id;
  bh=+6eQFguPPgTKf3NCtDpyXuHcutqvJ9P4OlhkFe4OYSk=;
  b=S2/woq25R7NUi1WtBh+zk0kUBJJQ5cIhSvaUbWAmrr3jih8nsrk+lZ0w
   EbbvHIGFiyBIZq2DBbUV7KGuSkJHG3MOyTeXqMo8yWvRKxxLLTUtq/oCI
   KDpkHoVBHeKmDQQreg4Xxto9pslLob2YiPA5oPrxUR2q2XskT+uSxrOPR
   o9OexLg48picyShdWMuebohcPFzSFlJPdpjAPYnk1aJBEBW3ahYSyeOUq
   G82X4j7U/s67f4KVV/uloMG7YZT6AKLQZOVEfxnUXJTT3mCmWeCimbwQl
   KveLDMMQDI43+8gSZcCuFe1X9shbgqHm1RUCV5FFJcoFYPVJP7/ou8vTE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="14429457"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="14429457"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 23:41:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="761858580"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="761858580"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 Nov 2023 23:41:32 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r7sin-0007H9-26;
        Tue, 28 Nov 2023 07:41:29 +0000
Date:   Tue, 28 Nov 2023 15:40:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/__randomize_layout-CRASH] BUILD SUCCESS
 3a2500bc84a25b3a4bb205275195807bf5d48d03
Message-ID: <202311281551.iIwQ04Zk-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/__randomize_layout-CRASH
branch HEAD: 3a2500bc84a25b3a4bb205275195807bf5d48d03  neighbour: Fix __randomize_layout crash in struct neighbour

elapsed time: 2865m

configs tested: 260
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20231126   gcc  
arc                   randconfig-001-20231127   gcc  
arc                   randconfig-002-20231126   gcc  
arc                   randconfig-002-20231127   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   clang
arm                      integrator_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                   randconfig-001-20231127   gcc  
arm                   randconfig-002-20231127   gcc  
arm                   randconfig-003-20231127   gcc  
arm                   randconfig-004-20231127   gcc  
arm                        shmobile_defconfig   gcc  
arm                        spear3xx_defconfig   clang
arm                        spear6xx_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231127   gcc  
arm64                 randconfig-002-20231127   gcc  
arm64                 randconfig-003-20231127   gcc  
arm64                 randconfig-004-20231127   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231126   gcc  
csky                  randconfig-001-20231127   gcc  
csky                  randconfig-002-20231126   gcc  
csky                  randconfig-002-20231127   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20231126   gcc  
i386                  randconfig-011-20231127   clang
i386                  randconfig-012-20231126   gcc  
i386                  randconfig-012-20231127   clang
i386                  randconfig-013-20231126   gcc  
i386                  randconfig-013-20231127   clang
i386                  randconfig-014-20231126   gcc  
i386                  randconfig-014-20231127   clang
i386                  randconfig-015-20231126   gcc  
i386                  randconfig-015-20231127   clang
i386                  randconfig-016-20231126   gcc  
i386                  randconfig-016-20231127   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231126   gcc  
loongarch             randconfig-001-20231127   gcc  
loongarch             randconfig-002-20231126   gcc  
loongarch             randconfig-002-20231127   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                        omega2p_defconfig   clang
mips                         rt305x_defconfig   gcc  
mips                        vocore2_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231126   gcc  
nios2                 randconfig-001-20231127   gcc  
nios2                 randconfig-002-20231126   gcc  
nios2                 randconfig-002-20231127   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20231126   gcc  
parisc                randconfig-001-20231127   gcc  
parisc                randconfig-002-20231126   gcc  
parisc                randconfig-002-20231127   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      bamboo_defconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc               randconfig-001-20231127   gcc  
powerpc               randconfig-002-20231127   gcc  
powerpc               randconfig-003-20231127   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc64                        alldefconfig   gcc  
powerpc64             randconfig-001-20231127   gcc  
powerpc64             randconfig-002-20231127   gcc  
powerpc64             randconfig-003-20231127   gcc  
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20231127   gcc  
riscv                 randconfig-002-20231127   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231126   gcc  
s390                  randconfig-002-20231126   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20231126   gcc  
sh                    randconfig-001-20231127   gcc  
sh                    randconfig-002-20231126   gcc  
sh                    randconfig-002-20231127   gcc  
sh                          rsk7269_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231126   gcc  
sparc64               randconfig-001-20231127   gcc  
sparc64               randconfig-002-20231126   gcc  
sparc64               randconfig-002-20231127   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231127   gcc  
um                    randconfig-002-20231127   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231126   clang
x86_64       buildonly-randconfig-001-20231127   gcc  
x86_64       buildonly-randconfig-002-20231126   clang
x86_64       buildonly-randconfig-002-20231127   gcc  
x86_64       buildonly-randconfig-003-20231126   clang
x86_64       buildonly-randconfig-003-20231127   gcc  
x86_64       buildonly-randconfig-004-20231126   clang
x86_64       buildonly-randconfig-004-20231127   gcc  
x86_64       buildonly-randconfig-005-20231126   clang
x86_64       buildonly-randconfig-005-20231127   gcc  
x86_64       buildonly-randconfig-006-20231126   clang
x86_64       buildonly-randconfig-006-20231127   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231126   clang
x86_64                randconfig-011-20231127   gcc  
x86_64                randconfig-012-20231126   clang
x86_64                randconfig-012-20231127   gcc  
x86_64                randconfig-013-20231126   clang
x86_64                randconfig-013-20231127   gcc  
x86_64                randconfig-014-20231126   clang
x86_64                randconfig-014-20231127   gcc  
x86_64                randconfig-015-20231126   clang
x86_64                randconfig-015-20231127   gcc  
x86_64                randconfig-016-20231126   clang
x86_64                randconfig-016-20231127   gcc  
x86_64                randconfig-071-20231126   clang
x86_64                randconfig-071-20231127   gcc  
x86_64                randconfig-072-20231126   clang
x86_64                randconfig-072-20231127   gcc  
x86_64                randconfig-073-20231126   clang
x86_64                randconfig-073-20231127   gcc  
x86_64                randconfig-074-20231126   clang
x86_64                randconfig-074-20231127   gcc  
x86_64                randconfig-075-20231126   clang
x86_64                randconfig-075-20231127   gcc  
x86_64                randconfig-076-20231126   clang
x86_64                randconfig-076-20231127   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20231126   gcc  
xtensa                randconfig-001-20231127   gcc  
xtensa                randconfig-002-20231126   gcc  
xtensa                randconfig-002-20231127   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
