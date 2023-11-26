Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CDD7F90AA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 02:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjKZB1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 20:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZB1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 20:27:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD9D102
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 17:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700962050; x=1732498050;
  h=date:from:to:cc:subject:message-id;
  bh=Qgzat7rauy8JL3M5bjhQTP+i+ruKJ4WR/txwWp1n2LQ=;
  b=SVwxgld67v5rAmYOz4le2RgApLLggt9czbLSfSqwdpRgWmbHAw6lD6DX
   wZmKzbb0PElA7Ccb9wOLjaVm45Hgun4A1e1epjebrCiKKkC/sdWB801nB
   +/tAozxK5O8savUYouKspvR9Z+oWcdDMS3GffULnJoj1EoS5qZlM188Yb
   68U9e2alqMZC1JacPAy8hTO6z6RGhOS+/PARFE+el2jw2gZeCSih9fxYi
   82WNlu7ZaQLEbDiz9zyxG12umkE/yMbtow/gA8GXUqSfw5PGvo8+v7Ihq
   v5eKlToSCMKzVY/pEPAIDnbozwac/D2t0gTlvByiBOYYQgOoMvLsK1+/x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="456873077"
X-IronPort-AV: E=Sophos;i="6.04,227,1695711600"; 
   d="scan'208";a="456873077"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2023 17:27:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="761283878"
X-IronPort-AV: E=Sophos;i="6.04,227,1695711600"; 
   d="scan'208";a="761283878"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Nov 2023 17:27:28 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r73vh-0004cs-2z;
        Sun, 26 Nov 2023 01:27:25 +0000
Date:   Sun, 26 Nov 2023 09:25:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/next20231116-Warray-bounds] BUILD
 SUCCESS 8df31baad3e57ffbd2724685132a07f94474f016
Message-ID: <202311260916.ZYMnfTpN-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/next20231116-Warray-bounds
branch HEAD: 8df31baad3e57ffbd2724685132a07f94474f016  Makefile: Enable -Warray-bounds globally

Unverified Warning (likely false positive, please contact us if interested):

security/security.c:810:9: warning: 'memcpy' offset 32 is out of the bounds [0, 0] [-Warray-bounds=]
security/security.c:810:9: warning: 'memcpy' offset 32 is out of the bounds [0, 0] [-Warray-bounds]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-defconfig
|   `-- security-security.c:warning:memcpy-offset-is-out-of-the-bounds
|-- arm64-randconfig-001-20231125
|   `-- security-security.c:warning:memcpy-offset-is-out-of-the-bounds
|-- arm64-randconfig-003-20231125
|   `-- security-security.c:warning:memcpy-offset-is-out-of-the-bounds
|-- arm64-randconfig-004-20231125
|   `-- security-security.c:warning:memcpy-offset-is-out-of-the-bounds
|-- loongarch-randconfig-001-20231125
|   `-- security-security.c:warning:memcpy-offset-is-out-of-the-bounds
|-- powerpc64-randconfig-001-20231125
|   `-- security-security.c:warning:memcpy-offset-is-out-of-the-bounds
|-- riscv-defconfig
|   `-- security-security.c:warning:memcpy-offset-is-out-of-the-bounds
|-- s390-defconfig
|   `-- security-security.c:warning:memcpy-offset-is-out-of-the-bounds
|-- x86_64-buildonly-randconfig-002-20231125
|   `-- security-security.c:warning:memcpy-offset-is-out-of-the-bounds
`-- x86_64-defconfig
    `-- security-security.c:warning:memcpy-offset-is-out-of-the-bounds

elapsed time: 1448m

configs tested: 176
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231125   gcc  
arc                   randconfig-002-20231125   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                      integrator_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                   randconfig-001-20231125   gcc  
arm                   randconfig-002-20231125   gcc  
arm                   randconfig-003-20231125   gcc  
arm                   randconfig-004-20231125   gcc  
arm                        spear3xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231125   gcc  
arm64                 randconfig-002-20231125   gcc  
arm64                 randconfig-003-20231125   gcc  
arm64                 randconfig-004-20231125   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231125   gcc  
csky                  randconfig-002-20231125   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231125   clang
hexagon               randconfig-002-20231125   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231125   gcc  
i386         buildonly-randconfig-002-20231125   gcc  
i386         buildonly-randconfig-003-20231125   gcc  
i386         buildonly-randconfig-004-20231125   gcc  
i386         buildonly-randconfig-005-20231125   gcc  
i386         buildonly-randconfig-006-20231125   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231125   gcc  
i386                  randconfig-002-20231125   gcc  
i386                  randconfig-003-20231125   gcc  
i386                  randconfig-004-20231125   gcc  
i386                  randconfig-005-20231125   gcc  
i386                  randconfig-006-20231125   gcc  
i386                  randconfig-011-20231125   clang
i386                  randconfig-012-20231125   clang
i386                  randconfig-013-20231125   clang
i386                  randconfig-014-20231125   clang
i386                  randconfig-015-20231125   clang
i386                  randconfig-016-20231125   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231125   gcc  
loongarch             randconfig-002-20231125   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                      pic32mzda_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231125   gcc  
nios2                 randconfig-002-20231125   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231125   gcc  
parisc                randconfig-002-20231125   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   bluestone_defconfig   clang
powerpc                       holly_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc               randconfig-001-20231125   gcc  
powerpc               randconfig-002-20231125   gcc  
powerpc               randconfig-003-20231125   gcc  
powerpc64             randconfig-001-20231125   gcc  
powerpc64             randconfig-002-20231125   gcc  
powerpc64             randconfig-003-20231125   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231125   gcc  
riscv                 randconfig-002-20231125   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231125   clang
s390                  randconfig-002-20231125   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                    randconfig-001-20231125   gcc  
sh                    randconfig-002-20231125   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231125   gcc  
sparc64               randconfig-002-20231125   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231125   gcc  
um                    randconfig-002-20231125   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231125   gcc  
x86_64       buildonly-randconfig-002-20231125   gcc  
x86_64       buildonly-randconfig-003-20231125   gcc  
x86_64       buildonly-randconfig-004-20231125   gcc  
x86_64       buildonly-randconfig-005-20231125   gcc  
x86_64       buildonly-randconfig-006-20231125   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231125   clang
x86_64                randconfig-002-20231125   clang
x86_64                randconfig-003-20231125   clang
x86_64                randconfig-004-20231125   clang
x86_64                randconfig-005-20231125   clang
x86_64                randconfig-006-20231125   clang
x86_64                randconfig-011-20231125   gcc  
x86_64                randconfig-012-20231125   gcc  
x86_64                randconfig-013-20231125   gcc  
x86_64                randconfig-014-20231125   gcc  
x86_64                randconfig-015-20231125   gcc  
x86_64                randconfig-016-20231125   gcc  
x86_64                randconfig-071-20231125   gcc  
x86_64                randconfig-072-20231125   gcc  
x86_64                randconfig-073-20231125   gcc  
x86_64                randconfig-074-20231125   gcc  
x86_64                randconfig-075-20231125   gcc  
x86_64                randconfig-076-20231125   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20231125   gcc  
xtensa                randconfig-002-20231125   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
