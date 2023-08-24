Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD633786F0C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbjHXMaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbjHXM3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:29:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9287910D7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692880174; x=1724416174;
  h=date:from:to:cc:subject:message-id;
  bh=7c6zxDeoHWlHXi00A4UblsQy61P/ZJKHGhodrDdUbtI=;
  b=EXhoWGpeKF9QZPLgvl5kzuFWKhaDUU5cTHx2x4gjBDh/mn6jZrMSPGgH
   u1s5jyXMEd1l8NpDT/ziyeS/QxZe6oj6gbcJhjn0KMg2ht/xLmHmkPy6+
   hqz/l/vf3Fk4P+K71f1FtiuBSRbk0AC49EDjGjnS/haYxn5iN57b0Aj4P
   dadinUvetmgjzT3Bqm1hlo2MITKk7AgNDJp3VZBegRVPGGZa2REDqBvCu
   gqS/6YbqTTMKzha/kTzSJrYfNPOJH4mCUKIOIDReqbUX2WyRr73x1qf7O
   EiKhFuVzdt07JKcvUFuJDF35NbblP1+PbOFWI31MgX5ZzwCpeHsqzkgFy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="378179177"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="378179177"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 05:29:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="983678905"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="983678905"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 24 Aug 2023 05:29:32 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZ9Su-0002QJ-0f;
        Thu, 24 Aug 2023 12:29:32 +0000
Date:   Thu, 24 Aug 2023 20:29:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:locktorture.2023.08.17a] BUILD SUCCESS WITH
 WARNING ccd7c62460a1ca6a8fb800de0d50d973ba62dcb8
Message-ID: <202308242011.WtvGd2fP-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git locktorture.2023.08.17a
branch HEAD: ccd7c62460a1ca6a8fb800de0d50d973ba62dcb8  rcutorture: Add test of RCU CPU stall notifiers

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202308180853.brWVZKoo-lkp@intel.com

Warning: (recently discovered and may have been fixed)

kernel/rcu/tree.c:4100:6: warning: no previous declaration for 'rcu_barrier_throttled' [-Wmissing-declarations]

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-x071-20230818
    `-- kernel-rcu-tree.c:warning:no-previous-declaration-for-rcu_barrier_throttled

elapsed time: 9534m

configs tested: 103
configs skipped: 6

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230818   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r021-20230818   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r031-20230818   gcc  
csky                 randconfig-r032-20230818   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230818   gcc  
i386         buildonly-randconfig-r005-20230818   gcc  
i386         buildonly-randconfig-r006-20230818   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-r022-20230818   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r015-20230818   gcc  
loongarch            randconfig-r026-20230818   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230818   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r035-20230818   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230818   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r025-20230818   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r006-20230818   gcc  
s390                 randconfig-r016-20230818   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r002-20230818   gcc  
sh                   randconfig-r024-20230818   gcc  
sh                   randconfig-r033-20230818   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230818   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r004-20230818   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230818   gcc  
x86_64       buildonly-randconfig-r002-20230818   gcc  
x86_64       buildonly-randconfig-r003-20230818   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r034-20230818   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r012-20230818   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
