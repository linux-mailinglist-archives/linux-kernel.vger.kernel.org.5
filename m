Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1B1752309
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbjGMNJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbjGMNJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:09:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB56272A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689253772; x=1720789772;
  h=date:from:to:cc:subject:message-id;
  bh=1nbRW5VwZHMWW+80yhCcV3YB4Uaf0x6WjniCi4hvlAg=;
  b=BWv4Cetl1/4yTVS0NZMqxVMZ96WqO5R3x4btg32wIXPZEcP6+xFB+G7v
   HG6FVOptu9vv/b6nZ8MVKbyzvZ7PoU9HZHU4BMPLnaUvgXIngva32BNoa
   7xl0O6Z4l+NpgQDC5fK47/n3ES8VOl3hDBP57gexWQ61LCXpNzcNE2JPT
   sgBJa+6p9nt7yydQw6Wlpg01FaV4la9bPJbuVwtmkLqNugnM1Pr68hv/w
   r/n70xM2TkIJ2Es8IZUXapuTyLfzhoe/t5bXnXpNZx6s1Y5HN4/4NnwhX
   MP/eqjnnXBivT0RJAOoChAkA04xYQq9RROxq81YFrun/whg8F8N62Ar76
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="344773502"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="344773502"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:05:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="787449208"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="787449208"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jul 2023 06:05:54 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJw13-0006co-0y;
        Thu, 13 Jul 2023 13:05:53 +0000
Date:   Thu, 13 Jul 2023 21:05:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.07.10a] BUILD SUCCESS
 ae846a11daf69ea5fbe525e36f9689aed384c9ea
Message-ID: <202307132137.VLT5K2pS-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.07.10a
branch HEAD: ae846a11daf69ea5fbe525e36f9689aed384c9ea  refscale: Add a "jiffies" test

elapsed time: 721m

configs tested: 123
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r022-20230712   gcc  
alpha                randconfig-r032-20230713   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r016-20230713   gcc  
arc                  randconfig-r043-20230713   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                  randconfig-r046-20230713   clang
arm                             rpc_defconfig   gcc  
arm                           sama5_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r014-20230713   gcc  
arm64                randconfig-r033-20230713   clang
csky                                defconfig   gcc  
hexagon              randconfig-r011-20230713   clang
hexagon              randconfig-r013-20230713   clang
hexagon              randconfig-r041-20230713   clang
hexagon              randconfig-r045-20230713   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230713   clang
i386         buildonly-randconfig-r005-20230713   clang
i386         buildonly-randconfig-r006-20230713   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230712   gcc  
i386                 randconfig-i002-20230712   gcc  
i386                 randconfig-i003-20230712   gcc  
i386                 randconfig-i004-20230712   gcc  
i386                 randconfig-i005-20230712   gcc  
i386                 randconfig-i006-20230712   gcc  
i386                 randconfig-i011-20230713   gcc  
i386                 randconfig-i012-20230713   gcc  
i386                 randconfig-i013-20230713   gcc  
i386                 randconfig-i014-20230713   gcc  
i386                 randconfig-i015-20230713   gcc  
i386                 randconfig-i016-20230713   gcc  
i386                 randconfig-r012-20230713   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230713   gcc  
loongarch            randconfig-r026-20230712   gcc  
loongarch            randconfig-r035-20230713   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                 randconfig-r003-20230713   gcc  
m68k                 randconfig-r036-20230713   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           gcw0_defconfig   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r006-20230713   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r021-20230712   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc              randconfig-r002-20230713   clang
powerpc                    sam440ep_defconfig   gcc  
powerpc                     tqm5200_defconfig   clang
powerpc                      tqm8xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r025-20230712   clang
riscv                randconfig-r031-20230713   clang
riscv                randconfig-r042-20230713   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230713   gcc  
sh                               allmodconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r034-20230713   gcc  
sparc                       sparc32_defconfig   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230713   clang
x86_64       buildonly-randconfig-r002-20230713   clang
x86_64       buildonly-randconfig-r003-20230713   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230712   clang
x86_64               randconfig-x002-20230712   clang
x86_64               randconfig-x003-20230712   clang
x86_64               randconfig-x004-20230712   clang
x86_64               randconfig-x005-20230712   clang
x86_64               randconfig-x006-20230712   clang
x86_64               randconfig-x011-20230712   gcc  
x86_64               randconfig-x012-20230712   gcc  
x86_64               randconfig-x013-20230712   gcc  
x86_64               randconfig-x014-20230712   gcc  
x86_64               randconfig-x015-20230712   gcc  
x86_64               randconfig-x016-20230712   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                              defconfig   gcc  
xtensa               randconfig-r004-20230713   gcc  
xtensa               randconfig-r024-20230712   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
