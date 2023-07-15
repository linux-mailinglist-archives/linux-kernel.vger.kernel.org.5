Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6609A75478F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 10:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjGOI47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 04:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjGOI46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 04:56:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2602D66
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 01:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689411417; x=1720947417;
  h=date:from:to:cc:subject:message-id;
  bh=KH3mpFhvH2AZRP8IogF4BMESB62cW2yrxN97OsoLFIw=;
  b=im7z4Hvvl2+KqYVifIL9qRJUazRO4LXgUP61mezrZWeaO9pVoWsMnDAa
   BrqBRwIMtfU1yJDKB0joA4qX4hZ+Fzy38EkrLJKa8wOkkCe1xiLyu4gGl
   5I26GRnf1ye3cXNLaLy7lv6/AMIlUYdciPZghzSSu2NuZZcyol1w5rHnx
   pH/u8Tb0XEAKADVyclCcRzBbCzvvpwBKZWTDr05sFvmEDYGVX0bjcdcO+
   eeH4OBMRdplC73AaaoD8x5ZH4fDYHmOGebdFxGuYmTWkGqzCGJZeizxHD
   fVrAHGi3wOa2/Ne1KVsjFvUVefD6tW3zOp/EVowQN2GW7pXpAWkLL6DWl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="355581636"
X-IronPort-AV: E=Sophos;i="6.01,207,1684825200"; 
   d="scan'208";a="355581636"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2023 01:56:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="846729199"
X-IronPort-AV: E=Sophos;i="6.01,207,1684825200"; 
   d="scan'208";a="846729199"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Jul 2023 01:56:56 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qKb5D-00084J-17;
        Sat, 15 Jul 2023 08:56:55 +0000
Date:   Sat, 15 Jul 2023 16:56:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230714] BUILD REGRESSION
 e044b6e1f6517c40f0a4938b9dd767d756b15b13
Message-ID: <202307151618.F8SAh5y9-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230714
branch HEAD: e044b6e1f6517c40f0a4938b9dd767d756b15b13  fs: omfs: Fix -Wstringop-overflow warning

Error/Warning: (recently discovered and may have been fixed)

arch/sparc/kernel/irq_32.c:258:14: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]

Unverified Error/Warning (likely false positive, please contact us if interested):

arch/m68k/include/asm/io_no.h:23:72: warning: array subscript 0 is outside array bounds of 'volatile u8[0]' {aka 'volatile unsigned char[]'} [-Warray-bounds]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- m68k-randconfig-r071-20230713
|   `-- arch-m68k-include-asm-io_no.h:warning:array-subscript-is-outside-array-bounds-of-volatile-u8-aka-volatile-unsigned-char
`-- sparc-randconfig-r014-20230714
    `-- arch-sparc-kernel-irq_32.c:error:array-subscript-is-outside-array-bounds-of-struct-tt_entry

elapsed time: 720m

configs tested: 126
configs skipped: 4

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230714   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r031-20230714   gcc  
arc                  randconfig-r043-20230714   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          moxart_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                  randconfig-r046-20230714   gcc  
arm64                            alldefconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r032-20230714   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r004-20230714   clang
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
i386                 randconfig-r024-20230714   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r036-20230714   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r016-20230714   gcc  
mips                 randconfig-r034-20230714   clang
nios2                               defconfig   gcc  
nios2                randconfig-r035-20230714   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r006-20230714   gcc  
openrisc             randconfig-r013-20230714   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                      katmai_defconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                  mpc885_ads_defconfig   clang
powerpc              randconfig-r011-20230714   clang
powerpc                     tqm5200_defconfig   clang
powerpc                     tqm8548_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r033-20230714   gcc  
riscv                randconfig-r042-20230714   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230714   gcc  
s390                 randconfig-r044-20230714   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230714   gcc  
sh                   randconfig-r012-20230714   gcc  
sh                   randconfig-r021-20230714   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230714   gcc  
sparc                randconfig-r022-20230714   gcc  
sparc64              randconfig-r002-20230714   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r015-20230714   gcc  
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
x86_64               randconfig-x011-20230714   gcc  
x86_64               randconfig-x012-20230714   gcc  
x86_64               randconfig-x013-20230714   gcc  
x86_64               randconfig-x014-20230714   gcc  
x86_64               randconfig-x015-20230714   gcc  
x86_64               randconfig-x016-20230714   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r005-20230714   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
