Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290B97612AC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbjGYLEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjGYLEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:04:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142F14EE4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690282906; x=1721818906;
  h=date:from:to:cc:subject:message-id;
  bh=Y6Jiy6v+LSw8O1IliUFCur4k/i6FnL3rU8mwtiFu4zw=;
  b=h1+PMlqAAebmEm9txi0+FdVO8E6I7tdccsFfzEpTHPeP05OI5/UDYMw1
   V2x+moLyA6Rr4EcQP37xuMpD4dBztDRCaoMAyt4n4pkTBIfQtCPnAyMyJ
   eQzNClH5d92Tm9+GomWhZMBeE9kGA7RFZ/Dj82LauQ3xZBK+advef1b5+
   HvhQUcNSRNEdaCyArPzgrZdl267qHLcfCkKcgEX1pnTVkivskXLb3q0w1
   F6SmN12+wBnDW/BCoVAI1sxlWxA+JDgLL0o2jqgStTLRgUIwak+OlnMV2
   4dBAbwZpzAwy9/RBEkf3ll5xXbAferrqMnjS1BMnKEDMYMYsZxjPgCtAh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="357687731"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="357687731"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 03:51:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="720013152"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="720013152"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 25 Jul 2023 03:51:53 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOFdx-000AYU-18;
        Tue, 25 Jul 2023 10:51:53 +0000
Date:   Tue, 25 Jul 2023 18:51:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.07.20a] BUILD SUCCESS
 dd111328533f67165a8713b6cd83799a0a74ca5c
Message-ID: <202307251800.jGWXxHNx-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.07.20a
branch HEAD: dd111328533f67165a8713b6cd83799a0a74ca5c  rcu: Eliminate check_cpu_stall() duplicate code

elapsed time: 730m

configs tested: 128
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230724   gcc  
arc                  randconfig-r043-20230724   gcc  
arc                  randconfig-r043-20230725   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r012-20230724   gcc  
arm                  randconfig-r024-20230724   gcc  
arm                  randconfig-r046-20230724   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230724   clang
hexagon              randconfig-r045-20230724   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230724   gcc  
i386         buildonly-randconfig-r005-20230724   gcc  
i386         buildonly-randconfig-r006-20230724   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230724   gcc  
i386                 randconfig-i002-20230724   gcc  
i386                 randconfig-i003-20230724   gcc  
i386                 randconfig-i004-20230724   gcc  
i386                 randconfig-i005-20230724   gcc  
i386                 randconfig-i006-20230724   gcc  
i386                 randconfig-i011-20230724   clang
i386                 randconfig-i011-20230725   gcc  
i386                 randconfig-i012-20230724   clang
i386                 randconfig-i012-20230725   gcc  
i386                 randconfig-i013-20230724   clang
i386                 randconfig-i013-20230725   gcc  
i386                 randconfig-i014-20230724   clang
i386                 randconfig-i014-20230725   gcc  
i386                 randconfig-i015-20230724   clang
i386                 randconfig-i015-20230725   gcc  
i386                 randconfig-i016-20230724   clang
i386                 randconfig-i016-20230725   gcc  
i386                 randconfig-r034-20230724   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r014-20230724   gcc  
microblaze           randconfig-r016-20230724   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r034-20230725   gcc  
mips                 randconfig-r035-20230724   clang
nios2                               defconfig   gcc  
nios2                randconfig-r023-20230725   gcc  
nios2                randconfig-r031-20230724   gcc  
nios2                randconfig-r032-20230724   gcc  
openrisc             randconfig-r033-20230725   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r033-20230724   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r004-20230724   gcc  
powerpc              randconfig-r004-20230725   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r015-20230724   clang
riscv                randconfig-r042-20230724   clang
riscv                randconfig-r042-20230725   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r006-20230725   clang
s390                 randconfig-r044-20230724   clang
s390                 randconfig-r044-20230725   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230724   gcc  
sh                   randconfig-r026-20230724   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230724   gcc  
sparc                randconfig-r013-20230724   gcc  
sparc                randconfig-r021-20230725   gcc  
sparc                randconfig-r022-20230724   gcc  
sparc64              randconfig-r003-20230724   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230724   gcc  
x86_64       buildonly-randconfig-r002-20230724   gcc  
x86_64       buildonly-randconfig-r003-20230724   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r021-20230724   clang
x86_64               randconfig-r022-20230725   gcc  
x86_64               randconfig-r025-20230725   gcc  
x86_64               randconfig-x001-20230725   gcc  
x86_64               randconfig-x002-20230725   gcc  
x86_64               randconfig-x003-20230725   gcc  
x86_64               randconfig-x004-20230725   gcc  
x86_64               randconfig-x005-20230725   gcc  
x86_64               randconfig-x006-20230725   gcc  
x86_64               randconfig-x011-20230724   gcc  
x86_64               randconfig-x011-20230725   clang
x86_64               randconfig-x012-20230724   gcc  
x86_64               randconfig-x012-20230725   clang
x86_64               randconfig-x013-20230724   gcc  
x86_64               randconfig-x013-20230725   clang
x86_64               randconfig-x014-20230724   gcc  
x86_64               randconfig-x014-20230725   clang
x86_64               randconfig-x015-20230724   gcc  
x86_64               randconfig-x015-20230725   clang
x86_64               randconfig-x016-20230724   gcc  
x86_64               randconfig-x016-20230725   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r023-20230724   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
