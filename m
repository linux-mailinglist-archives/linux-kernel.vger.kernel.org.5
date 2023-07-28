Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85EC7676B9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjG1UFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjG1UFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:05:37 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695FE423C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 13:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690574736; x=1722110736;
  h=date:from:to:cc:subject:message-id;
  bh=OfZ5240NZSKOpcVAbL/uXHsdfpYE+TIx/M6MDKw1LUU=;
  b=nnLLC3nN1rc//6lLTT6z723Aypk0zrEtkO5OZnUD4mAP271iB1FXvTV1
   8BPAbxmr1ysEIBfuR5DYH9TvqpqtBIO20mh7mB7Yv5Q5OmDdzWl3sdOQE
   +MZqBLYa9HxlaQD9soQnI7j0uwmwQ1c/zavVZ+yE6IRjLwyb99DQ+IZeZ
   2SjtmeiH3VOIEQZm3K8BO7BwKvsFqlRj9g982KPiHSiulXdyYq30a1hww
   9X8jip94QN+iT1hxSPeI/PHgP7T4QSf/xJ5mB8SKmMqnnbLHczAXDccS/
   VcUkFHA1GMp96E5qFuhQa/OAcdtrnABudl/MJMKmwEwS2MShtQ0FcMZaE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="371373342"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="371373342"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 13:05:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="851341818"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="851341818"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 28 Jul 2023 13:05:29 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPTiK-0003Xf-1I;
        Fri, 28 Jul 2023 20:05:28 +0000
Date:   Sat, 29 Jul 2023 04:04:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:smp/core] BUILD SUCCESS
 7f48405c3c3437d578d0f1e4287aa0a3bfa5623f
Message-ID: <202307290450.JqY6v8kw-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
branch HEAD: 7f48405c3c3437d578d0f1e4287aa0a3bfa5623f  cpu/SMT: Allow enabling partial SMT states via sysfs

elapsed time: 723m

configs tested: 182
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230728   gcc  
alpha                randconfig-r033-20230728   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                  randconfig-r014-20230728   gcc  
arc                  randconfig-r022-20230727   gcc  
arc                  randconfig-r043-20230727   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r021-20230727   clang
arm                  randconfig-r046-20230727   clang
arm                          sp7021_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r024-20230727   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230727   gcc  
csky                 randconfig-r011-20230728   gcc  
hexagon              randconfig-r041-20230727   clang
hexagon              randconfig-r041-20230728   clang
hexagon              randconfig-r045-20230727   clang
hexagon              randconfig-r045-20230728   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230727   clang
i386         buildonly-randconfig-r004-20230728   gcc  
i386         buildonly-randconfig-r005-20230727   clang
i386         buildonly-randconfig-r005-20230728   gcc  
i386         buildonly-randconfig-r006-20230727   clang
i386         buildonly-randconfig-r006-20230728   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230728   gcc  
i386                 randconfig-i002-20230727   clang
i386                 randconfig-i002-20230728   gcc  
i386                 randconfig-i003-20230727   clang
i386                 randconfig-i003-20230728   gcc  
i386                 randconfig-i004-20230727   clang
i386                 randconfig-i004-20230728   gcc  
i386                 randconfig-i005-20230727   clang
i386                 randconfig-i005-20230728   gcc  
i386                 randconfig-i006-20230727   clang
i386                 randconfig-i006-20230728   gcc  
i386                 randconfig-i011-20230727   gcc  
i386                 randconfig-i011-20230728   clang
i386                 randconfig-i012-20230727   gcc  
i386                 randconfig-i012-20230728   clang
i386                 randconfig-i013-20230727   gcc  
i386                 randconfig-i013-20230728   clang
i386                 randconfig-i014-20230727   gcc  
i386                 randconfig-i014-20230728   clang
i386                 randconfig-i015-20230727   gcc  
i386                 randconfig-i015-20230728   clang
i386                 randconfig-i016-20230727   gcc  
i386                 randconfig-i016-20230728   clang
i386                 randconfig-r001-20230727   clang
i386                 randconfig-r031-20230727   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230728   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230728   gcc  
m68k                 randconfig-r026-20230727   gcc  
m68k                 randconfig-r035-20230728   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze           randconfig-r001-20230728   gcc  
microblaze           randconfig-r006-20230728   gcc  
microblaze           randconfig-r013-20230727   gcc  
microblaze           randconfig-r013-20230728   gcc  
microblaze           randconfig-r016-20230727   gcc  
microblaze           randconfig-r025-20230727   gcc  
microblaze           randconfig-r032-20230728   gcc  
microblaze           randconfig-r036-20230727   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                            gpr_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230727   gcc  
nios2                randconfig-r005-20230728   gcc  
nios2                randconfig-r012-20230727   gcc  
nios2                randconfig-r015-20230728   gcc  
openrisc             randconfig-r001-20230728   gcc  
openrisc             randconfig-r002-20230728   gcc  
openrisc             randconfig-r003-20230728   gcc  
openrisc             randconfig-r005-20230727   gcc  
openrisc             randconfig-r005-20230728   gcc  
openrisc             randconfig-r016-20230728   gcc  
openrisc             randconfig-r032-20230728   gcc  
openrisc             randconfig-r035-20230728   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230727   gcc  
parisc               randconfig-r015-20230727   gcc  
parisc               randconfig-r031-20230728   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc               mpc834x_itxgp_defconfig   clang
powerpc              randconfig-r003-20230727   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230728   gcc  
riscv                randconfig-r031-20230728   gcc  
riscv                randconfig-r033-20230727   clang
riscv                randconfig-r035-20230727   clang
riscv                randconfig-r042-20230727   gcc  
riscv                randconfig-r042-20230728   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230728   gcc  
s390                 randconfig-r034-20230727   clang
s390                 randconfig-r044-20230727   gcc  
s390                 randconfig-r044-20230728   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r014-20230727   gcc  
sh                   randconfig-r015-20230728   gcc  
sh                          rsk7269_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r023-20230727   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230727   clang
x86_64       buildonly-randconfig-r001-20230728   gcc  
x86_64       buildonly-randconfig-r002-20230727   clang
x86_64       buildonly-randconfig-r002-20230728   gcc  
x86_64       buildonly-randconfig-r003-20230727   clang
x86_64       buildonly-randconfig-r003-20230728   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r034-20230728   gcc  
x86_64               randconfig-x001-20230727   gcc  
x86_64               randconfig-x001-20230728   clang
x86_64               randconfig-x002-20230727   gcc  
x86_64               randconfig-x002-20230728   clang
x86_64               randconfig-x003-20230727   gcc  
x86_64               randconfig-x003-20230728   clang
x86_64               randconfig-x004-20230727   gcc  
x86_64               randconfig-x004-20230728   clang
x86_64               randconfig-x005-20230727   gcc  
x86_64               randconfig-x005-20230728   clang
x86_64               randconfig-x006-20230727   gcc  
x86_64               randconfig-x006-20230728   clang
x86_64               randconfig-x011-20230727   clang
x86_64               randconfig-x011-20230728   gcc  
x86_64               randconfig-x012-20230727   clang
x86_64               randconfig-x012-20230728   gcc  
x86_64               randconfig-x013-20230727   clang
x86_64               randconfig-x013-20230728   gcc  
x86_64               randconfig-x014-20230727   clang
x86_64               randconfig-x014-20230728   gcc  
x86_64               randconfig-x015-20230727   clang
x86_64               randconfig-x015-20230728   gcc  
x86_64               randconfig-x016-20230727   clang
x86_64               randconfig-x016-20230728   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r011-20230727   gcc  
xtensa               randconfig-r032-20230727   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
