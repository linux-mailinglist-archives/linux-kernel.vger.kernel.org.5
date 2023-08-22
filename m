Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65BA7837EC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjHVC25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjHVC2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:28:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4B1DB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692671333; x=1724207333;
  h=date:from:to:cc:subject:message-id;
  bh=+dpCM7rktcAASJpelDTH9NvpEdzngmoDRsQXzg+O/as=;
  b=fUnEJ1cynRyy7uSfPtw4Eqfdz5reKipM8AeYKPbF+6tj3StFPoXs8C8T
   tqR95XrFBJjW47clmcRuC7QQqI0hW7EWPOtzIlSgAv4GdQ8Wz1A8JWVFA
   klkgTHcplZtkZroMI2VPimG2+m3/qk7/uf2esoqE7jdQ0k24NZdeJWaHj
   L3onz9eNoXfnOkNwqQaaCX9FUzY0UTz+fY3rrcj51W7yGY6AkF7vtskiZ
   RHLvb8RZ8smj1mBi6abGijnPxnC5TTkKFgs+JZErdiIDkINx8Br3u4DdD
   2If4Ey0KYoIyqTngQszw/u6zk/VpPibwkP0tpJL/gE0wf/BuoUWRnWp0m
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="376493609"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="376493609"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 19:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="771175916"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="771175916"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 21 Aug 2023 19:28:52 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYH8K-0001Ey-2T;
        Tue, 22 Aug 2023 02:28:43 +0000
Date:   Tue, 22 Aug 2023 10:28:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 4240e2ebe67941ce2c4f5c866c3af4b5ac7a0c67
Message-ID: <202308221000.wChnqWfK-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 4240e2ebe67941ce2c4f5c866c3af4b5ac7a0c67  x86/MCE: Always save CS register on AMD Zen IF Poison errors

elapsed time: 1454m

configs tested: 150
configs skipped: 165

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230822   gcc  
arc                  randconfig-r015-20230822   gcc  
arc                  randconfig-r023-20230822   gcc  
arm                         at91_dt_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                  randconfig-r014-20230822   gcc  
arm                        shmobile_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r032-20230822   gcc  
csky                             allmodconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r014-20230822   gcc  
csky                 randconfig-r016-20230822   gcc  
csky                 randconfig-r026-20230822   gcc  
hexagon               randconfig-001-20230822   clang
hexagon               randconfig-002-20230822   clang
hexagon              randconfig-r003-20230822   clang
i386                             allmodconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230822   gcc  
i386         buildonly-randconfig-002-20230822   gcc  
i386         buildonly-randconfig-003-20230822   gcc  
i386         buildonly-randconfig-004-20230822   gcc  
i386         buildonly-randconfig-005-20230822   gcc  
i386         buildonly-randconfig-006-20230821   clang
i386         buildonly-randconfig-006-20230822   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230822   gcc  
i386                  randconfig-002-20230822   gcc  
i386                  randconfig-003-20230822   gcc  
i386                  randconfig-004-20230822   gcc  
i386                  randconfig-005-20230822   gcc  
i386                  randconfig-006-20230822   gcc  
i386                  randconfig-011-20230822   clang
i386                  randconfig-012-20230822   clang
i386                  randconfig-013-20230822   clang
i386                  randconfig-014-20230822   clang
i386                  randconfig-015-20230822   clang
i386                  randconfig-016-20230822   clang
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230822   gcc  
loongarch            randconfig-r013-20230822   gcc  
loongarch            randconfig-r026-20230822   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r034-20230822   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r013-20230822   gcc  
microblaze           randconfig-r021-20230822   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                 randconfig-r012-20230822   gcc  
mips                 randconfig-r021-20230822   gcc  
nios2                            allmodconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r024-20230822   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc             randconfig-r005-20230822   gcc  
openrisc             randconfig-r033-20230822   gcc  
parisc                           allmodconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r015-20230822   gcc  
parisc               randconfig-r031-20230822   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                  mpc866_ads_defconfig   gcc  
powerpc              randconfig-r003-20230822   gcc  
powerpc64                           defconfig   gcc  
powerpc64            randconfig-r031-20230822   gcc  
powerpc64            randconfig-r032-20230822   gcc  
powerpc64            randconfig-r036-20230822   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230822   gcc  
riscv                randconfig-r036-20230822   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230822   clang
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r001-20230822   gcc  
sh                           se7724_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r022-20230822   gcc  
sparc                randconfig-r025-20230822   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r035-20230822   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230822   gcc  
x86_64       buildonly-randconfig-002-20230822   gcc  
x86_64       buildonly-randconfig-003-20230822   gcc  
x86_64       buildonly-randconfig-004-20230822   gcc  
x86_64       buildonly-randconfig-005-20230822   gcc  
x86_64       buildonly-randconfig-006-20230822   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230822   clang
x86_64                randconfig-002-20230822   clang
x86_64                randconfig-003-20230822   clang
x86_64                randconfig-004-20230822   clang
x86_64                randconfig-005-20230822   clang
x86_64                randconfig-006-20230822   clang
x86_64               randconfig-r035-20230822   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r022-20230822   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
