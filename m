Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9747E1236
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 04:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjKEDsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 23:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjKEDsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 23:48:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111B0D6
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 20:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699156079; x=1730692079;
  h=date:from:to:cc:subject:message-id;
  bh=4RNNC5wgfYU1xOmST7t0rDG4nZ6KWu90Ov2a06JkZWs=;
  b=mzheATLc+otfRppfN++E9qtEHb82BnHvbBYbTLyAlZmBDaSuMe/t8YKR
   OkPt6wdUx4q9x+/pyKhZU3UJsludLDo+S5uNYEQ3BuKvaZFd8SNWyQD8/
   6+bNCAHLeMpT/H3hNjYdLDsY+xoFW+TLgkDAtmyfAxhs6gaSZILBMDZQJ
   AY7KkDhTILo1aCGY7t4c85f/zcc3D8XJ1ynqvL84yHn0kkAwNzpK5+Tmo
   Q0ChSvMuHYF/WtzX/XlU0xaMcHm/WuiZfss13k+9+8zATbzBieM8xvKJy
   FJqYUrP1EbT3jq898kSmA+mgmy5+RRRnHPhCpIzNJ1CMr/cAB4cLkrJUd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="420241985"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="420241985"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 20:47:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="1009205515"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="1009205515"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 04 Nov 2023 20:47:57 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzU79-0004zI-15;
        Sun, 05 Nov 2023 03:47:55 +0000
Date:   Sun, 05 Nov 2023 11:47:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 7939f0d7b28cf0482209674d90f15b9e75dbd68e
Message-ID: <202311051117.y3CjnVFg-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 7939f0d7b28cf0482209674d90f15b9e75dbd68e  rcu: Restrict access to RCU CPU stall notifiers

elapsed time: 1763m

configs tested: 209
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
arc                                 defconfig   gcc  
arc                   randconfig-001-20231104   gcc  
arc                   randconfig-002-20231104   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20231104   gcc  
arm                   randconfig-001-20231105   gcc  
arm                   randconfig-002-20231104   gcc  
arm                   randconfig-002-20231105   gcc  
arm                   randconfig-003-20231104   gcc  
arm                   randconfig-003-20231105   gcc  
arm                   randconfig-004-20231104   gcc  
arm                   randconfig-004-20231105   gcc  
arm                             rpc_defconfig   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm                       versatile_defconfig   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231104   gcc  
arm64                 randconfig-001-20231105   gcc  
arm64                 randconfig-002-20231104   gcc  
arm64                 randconfig-002-20231105   gcc  
arm64                 randconfig-003-20231104   gcc  
arm64                 randconfig-003-20231105   gcc  
arm64                 randconfig-004-20231104   gcc  
arm64                 randconfig-004-20231105   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231104   gcc  
csky                  randconfig-002-20231104   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231104   gcc  
i386         buildonly-randconfig-002-20231104   gcc  
i386         buildonly-randconfig-003-20231104   gcc  
i386         buildonly-randconfig-004-20231104   gcc  
i386         buildonly-randconfig-005-20231104   gcc  
i386         buildonly-randconfig-006-20231104   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231105   gcc  
i386                  randconfig-002-20231105   gcc  
i386                  randconfig-003-20231105   gcc  
i386                  randconfig-004-20231105   gcc  
i386                  randconfig-005-20231105   gcc  
i386                  randconfig-006-20231105   gcc  
i386                  randconfig-011-20231104   gcc  
i386                  randconfig-012-20231104   gcc  
i386                  randconfig-013-20231104   gcc  
i386                  randconfig-014-20231104   gcc  
i386                  randconfig-015-20231104   gcc  
i386                  randconfig-016-20231104   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20231104   gcc  
loongarch             randconfig-002-20231104   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                            q40_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                          malta_defconfig   clang
mips                    maltaup_xpa_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231104   gcc  
nios2                 randconfig-002-20231104   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231104   gcc  
parisc                randconfig-002-20231104   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                    gamecube_defconfig   clang
powerpc               randconfig-001-20231104   gcc  
powerpc               randconfig-002-20231104   gcc  
powerpc               randconfig-003-20231104   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc64             randconfig-001-20231104   gcc  
powerpc64             randconfig-002-20231104   gcc  
powerpc64             randconfig-003-20231104   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231104   gcc  
riscv                 randconfig-002-20231104   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231104   gcc  
s390                  randconfig-002-20231104   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                    randconfig-001-20231104   gcc  
sh                    randconfig-002-20231104   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231104   gcc  
sparc                 randconfig-002-20231104   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231104   gcc  
sparc64               randconfig-002-20231104   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231104   gcc  
um                    randconfig-002-20231104   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231104   gcc  
x86_64       buildonly-randconfig-002-20231104   gcc  
x86_64       buildonly-randconfig-003-20231104   gcc  
x86_64       buildonly-randconfig-004-20231104   gcc  
x86_64       buildonly-randconfig-005-20231104   gcc  
x86_64       buildonly-randconfig-006-20231104   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231105   gcc  
x86_64                randconfig-002-20231105   gcc  
x86_64                randconfig-003-20231105   gcc  
x86_64                randconfig-004-20231105   gcc  
x86_64                randconfig-005-20231105   gcc  
x86_64                randconfig-006-20231105   gcc  
x86_64                randconfig-011-20231104   gcc  
x86_64                randconfig-012-20231104   gcc  
x86_64                randconfig-013-20231104   gcc  
x86_64                randconfig-014-20231104   gcc  
x86_64                randconfig-015-20231104   gcc  
x86_64                randconfig-016-20231104   gcc  
x86_64                randconfig-071-20231104   gcc  
x86_64                randconfig-071-20231105   gcc  
x86_64                randconfig-072-20231104   gcc  
x86_64                randconfig-072-20231105   gcc  
x86_64                randconfig-073-20231104   gcc  
x86_64                randconfig-073-20231105   gcc  
x86_64                randconfig-074-20231104   gcc  
x86_64                randconfig-074-20231105   gcc  
x86_64                randconfig-075-20231104   gcc  
x86_64                randconfig-075-20231105   gcc  
x86_64                randconfig-076-20231104   gcc  
x86_64                randconfig-076-20231105   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231104   gcc  
xtensa                randconfig-002-20231104   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
