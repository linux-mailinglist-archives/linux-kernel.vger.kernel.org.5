Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E0A7931F9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbjIEW3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjIEW27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:28:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D358FA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 15:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693952935; x=1725488935;
  h=date:from:to:cc:subject:message-id;
  bh=MeoDeMfprVC3r08Z8SqeQKLZiU3DjSUU3L4QRA3gFOE=;
  b=IddJhXRIExGRswis0tczSTXHSxI5ODks3OxFUhMPErw0YM3GAjQp1AOW
   HkOGHvOuIa3CjqICuPCRTdjYDQothjlN78R7vhDN3RzHaIgj+bs26vmKO
   DlynbcQXpersTzKztNTeX2vB/N+kajlv71RNPbH5hYbzrRu484Jqcase3
   pbjOs1JAkCx+J4E0oZMw2t0VWt9G75MzriO3uZ6VvOiMC1jF27PMtPGbx
   Mtgoi35lw1KVtIZQwdiyYF/IRsaB8A/s+Srgl/Md4kS2EpBtnNTOkbTyC
   2iDSntX6bx5H/YAx6EVgPt9YHpyvRJJpkhVB1ZL/fKeaC87q7hHkAc4k7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="374307631"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="374307631"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 15:28:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="831406602"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="831406602"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Sep 2023 15:28:20 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdeWw-00029N-0E;
        Tue, 05 Sep 2023 22:28:18 +0000
Date:   Wed, 06 Sep 2023 06:28:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/bugs] BUILD SUCCESS
 423a4484b9235af31b1fd60d6049b820586e57d2
Message-ID: <202309060603.0qqr8BVI-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/bugs
branch HEAD: 423a4484b9235af31b1fd60d6049b820586e57d2  x86/calldepth: Rename __x86_return_skl() to call_depth_return_thunk()

elapsed time: 727m

configs tested: 172
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
arc                   randconfig-001-20230905   gcc  
arm                              alldefconfig   clang
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                          collie_defconfig   clang
arm                                 defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                   randconfig-001-20230905   clang
arm                  randconfig-r031-20230905   gcc  
arm                  randconfig-r033-20230905   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r035-20230905   gcc  
hexagon               randconfig-001-20230905   clang
hexagon               randconfig-002-20230905   clang
hexagon              randconfig-r012-20230905   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230905   clang
i386         buildonly-randconfig-002-20230905   clang
i386         buildonly-randconfig-003-20230905   clang
i386         buildonly-randconfig-004-20230905   clang
i386         buildonly-randconfig-005-20230905   clang
i386         buildonly-randconfig-006-20230905   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230905   clang
i386                  randconfig-002-20230905   clang
i386                  randconfig-003-20230905   clang
i386                  randconfig-004-20230905   clang
i386                  randconfig-005-20230905   clang
i386                  randconfig-006-20230905   clang
i386                  randconfig-011-20230905   gcc  
i386                  randconfig-012-20230905   gcc  
i386                  randconfig-013-20230905   gcc  
i386                  randconfig-014-20230905   gcc  
i386                  randconfig-015-20230905   gcc  
i386                  randconfig-016-20230905   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230905   gcc  
loongarch            randconfig-r005-20230905   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
mips                 randconfig-r006-20230905   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r016-20230905   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r004-20230905   clang
powerpc                     tqm8555_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc64            randconfig-r024-20230905   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230905   clang
riscv                randconfig-r011-20230905   gcc  
riscv                randconfig-r013-20230905   gcc  
riscv                randconfig-r021-20230905   gcc  
riscv                randconfig-r036-20230905   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230905   gcc  
s390                 randconfig-r002-20230905   clang
s390                 randconfig-r025-20230905   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r001-20230905   gcc  
sh                   randconfig-r022-20230905   gcc  
sh                   randconfig-r034-20230905   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r032-20230905   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r023-20230905   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230905   clang
x86_64       buildonly-randconfig-002-20230905   clang
x86_64       buildonly-randconfig-003-20230905   clang
x86_64       buildonly-randconfig-004-20230905   clang
x86_64       buildonly-randconfig-005-20230905   clang
x86_64       buildonly-randconfig-006-20230905   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230905   gcc  
x86_64                randconfig-002-20230905   gcc  
x86_64                randconfig-003-20230905   gcc  
x86_64                randconfig-004-20230905   gcc  
x86_64                randconfig-005-20230905   gcc  
x86_64                randconfig-006-20230905   gcc  
x86_64                randconfig-011-20230905   clang
x86_64                randconfig-012-20230905   clang
x86_64                randconfig-013-20230905   clang
x86_64                randconfig-014-20230905   clang
x86_64                randconfig-015-20230905   clang
x86_64                randconfig-016-20230905   clang
x86_64                randconfig-071-20230905   clang
x86_64                randconfig-072-20230905   clang
x86_64                randconfig-073-20230905   clang
x86_64                randconfig-074-20230905   clang
x86_64                randconfig-075-20230905   clang
x86_64                randconfig-076-20230905   clang
x86_64               randconfig-r003-20230905   clang
x86_64               randconfig-r015-20230905   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r014-20230905   gcc  
xtensa               randconfig-r026-20230905   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
