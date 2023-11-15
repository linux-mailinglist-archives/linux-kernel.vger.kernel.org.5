Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6013F7E8F84
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 11:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjKLKnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 05:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLKnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 05:43:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858532D57
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 02:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699785795; x=1731321795;
  h=date:from:to:cc:subject:message-id;
  bh=6z2MpJQYQPfV2eFxc6dnW+Cpnhqyx/NW5Sz8uTekVrs=;
  b=OtTitddJewPTRidjl1NwStfHELx3tjJmCSgL0ZKQeyVRuh52W7gMUGO8
   YBfWKc3bVsCuVXtqXcLGTLQ7XNaompUGVewLKUnWCzFDnetktQtVIf40w
   sdjXz+pTEMt1LF+F/X92P24Tve8rSsKKOC/kdVWn5fYMDrh9QeNu875ZH
   2LpNng4oQEV3qkcqWrNuOEJPEHGzs4DTNOMQLn8zcx7GdDVi6gx1lwpuo
   amvMoZKIejubZq9T4FnRFHEY6InZaA1kvIG6e6jSXdXMRCR8Vc1sOlar8
   HA96NpGB51Jl1JdbSxdH4YxxOwXfFaEr6ESkVvDu16W0vzWpddhqg9iGs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="390130165"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="390130165"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 02:43:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="740531070"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="740531070"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 12 Nov 2023 02:43:13 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r27vr-000B5O-0e;
        Sun, 12 Nov 2023 10:43:11 +0000
Date:   Sun, 12 Nov 2023 18:42:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 5c0930ccaad5a74d74e8b18b648c5eb21ed2fe94
Message-ID: <202311121810.7lBDiCW6-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: 5c0930ccaad5a74d74e8b18b648c5eb21ed2fe94  hrtimers: Push pending hrtimers away from outgoing CPU earlier

elapsed time: 1039m

configs tested: 194
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
arc                   randconfig-001-20231112   gcc  
arc                   randconfig-002-20231112   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                   randconfig-001-20231112   gcc  
arm                   randconfig-002-20231112   gcc  
arm                   randconfig-003-20231112   gcc  
arm                   randconfig-004-20231112   gcc  
arm                         vf610m4_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231112   gcc  
arm64                 randconfig-002-20231112   gcc  
arm64                 randconfig-003-20231112   gcc  
arm64                 randconfig-004-20231112   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231112   gcc  
csky                  randconfig-002-20231112   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231112   gcc  
i386         buildonly-randconfig-002-20231112   gcc  
i386         buildonly-randconfig-003-20231112   gcc  
i386         buildonly-randconfig-004-20231112   gcc  
i386         buildonly-randconfig-005-20231112   gcc  
i386         buildonly-randconfig-006-20231112   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231112   gcc  
i386                  randconfig-002-20231112   gcc  
i386                  randconfig-003-20231112   gcc  
i386                  randconfig-004-20231112   gcc  
i386                  randconfig-005-20231112   gcc  
i386                  randconfig-006-20231112   gcc  
i386                  randconfig-011-20231112   gcc  
i386                  randconfig-012-20231112   gcc  
i386                  randconfig-013-20231112   gcc  
i386                  randconfig-014-20231112   gcc  
i386                  randconfig-015-20231112   gcc  
i386                  randconfig-016-20231112   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231112   gcc  
loongarch             randconfig-002-20231112   gcc  
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
mips                           gcw0_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231112   gcc  
nios2                 randconfig-002-20231112   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231112   gcc  
parisc                randconfig-002-20231112   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20231112   gcc  
powerpc               randconfig-002-20231112   gcc  
powerpc               randconfig-003-20231112   gcc  
powerpc                     redwood_defconfig   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     tqm8555_defconfig   gcc  
powerpc64             randconfig-001-20231112   gcc  
powerpc64             randconfig-002-20231112   gcc  
powerpc64             randconfig-003-20231112   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231112   gcc  
riscv                 randconfig-002-20231112   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231112   gcc  
s390                  randconfig-002-20231112   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                    randconfig-001-20231112   gcc  
sh                    randconfig-002-20231112   gcc  
sh                          rsk7203_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231112   gcc  
sparc                 randconfig-002-20231112   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231112   gcc  
sparc64               randconfig-002-20231112   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231112   gcc  
um                    randconfig-002-20231112   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231112   gcc  
x86_64       buildonly-randconfig-002-20231112   gcc  
x86_64       buildonly-randconfig-003-20231112   gcc  
x86_64       buildonly-randconfig-004-20231112   gcc  
x86_64       buildonly-randconfig-005-20231112   gcc  
x86_64       buildonly-randconfig-006-20231112   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231112   gcc  
x86_64                randconfig-002-20231112   gcc  
x86_64                randconfig-003-20231112   gcc  
x86_64                randconfig-004-20231112   gcc  
x86_64                randconfig-005-20231112   gcc  
x86_64                randconfig-006-20231112   gcc  
x86_64                randconfig-011-20231112   gcc  
x86_64                randconfig-012-20231112   gcc  
x86_64                randconfig-013-20231112   gcc  
x86_64                randconfig-014-20231112   gcc  
x86_64                randconfig-015-20231112   gcc  
x86_64                randconfig-016-20231112   gcc  
x86_64                randconfig-071-20231112   gcc  
x86_64                randconfig-072-20231112   gcc  
x86_64                randconfig-073-20231112   gcc  
x86_64                randconfig-074-20231112   gcc  
x86_64                randconfig-075-20231112   gcc  
x86_64                randconfig-076-20231112   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                randconfig-001-20231112   gcc  
xtensa                randconfig-002-20231112   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
