Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984A277CCA3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbjHOM2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbjHOM1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:27:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCD7173C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692102454; x=1723638454;
  h=date:from:to:cc:subject:message-id;
  bh=Wco+elKb5GupysSDibxlEtl8GEF1NPaCM0c2LkzKK88=;
  b=H8LMbcuBu3cn2guaP+mMB63TpxkQC5adDMELDM6+rU5dQUut7dvf8Zqx
   4u39ht7iFjmUv+Iz9oGlP1T+Ynlhkg5rKQIBl0GFixNtF3tdcDUSW2H4w
   QPK65RsU3hfRD8KibOWM77jqpdPmA9XJSIwWJ6doDAhXNkMKNfe2AzlS1
   TN3DboP+Obd0mZDym2mpBzJAdDqxto2HqorwiuYdwCsUptnXh1JSamka4
   wfqYwfE6q4yiRG79knVy4O81DQ3GiNq3vLAsT1mhMs62+xM/klWZSPdEP
   cOuKmO4SraQkhzqwBMZvSe6Oq1rhHRNJeOGYHlq4rR1G0aG9evfmOYvCb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375033843"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="375033843"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 05:27:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848053307"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="848053307"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 15 Aug 2023 05:27:29 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVt8t-0000x7-29;
        Tue, 15 Aug 2023 12:27:24 +0000
Date:   Tue, 15 Aug 2023 20:27:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.08.02a] BUILD SUCCESS
 ce1cf26540b96fc52aec6f6f8e365960ca79a0ad
Message-ID: <202308152000.k7LcubMk-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.08.02a
branch HEAD: ce1cf26540b96fc52aec6f6f8e365960ca79a0ad  rcutorture: Copy out ftrace into its own console file

elapsed time: 720m

configs tested: 106
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r024-20230815   gcc  
alpha                randconfig-r036-20230815   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230815   gcc  
arc                  randconfig-r011-20230815   gcc  
arc                  randconfig-r043-20230815   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230815   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r033-20230815   gcc  
hexagon              randconfig-r025-20230815   clang
hexagon              randconfig-r041-20230815   clang
hexagon              randconfig-r045-20230815   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230815   clang
i386         buildonly-randconfig-r005-20230815   clang
i386         buildonly-randconfig-r006-20230815   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230815   clang
i386                 randconfig-i002-20230815   clang
i386                 randconfig-i003-20230815   clang
i386                 randconfig-i004-20230815   clang
i386                 randconfig-i005-20230815   clang
i386                 randconfig-i006-20230815   clang
i386                 randconfig-i011-20230815   gcc  
i386                 randconfig-i012-20230815   gcc  
i386                 randconfig-i013-20230815   gcc  
i386                 randconfig-i014-20230815   gcc  
i386                 randconfig-i015-20230815   gcc  
i386                 randconfig-i016-20230815   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230815   gcc  
microblaze           randconfig-r034-20230815   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r021-20230815   clang
mips                 randconfig-r031-20230815   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r023-20230815   gcc  
openrisc             randconfig-r014-20230815   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r026-20230815   gcc  
riscv                randconfig-r042-20230815   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230815   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r002-20230815   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230815   gcc  
sparc                randconfig-r012-20230815   gcc  
sparc                randconfig-r016-20230815   gcc  
sparc64              randconfig-r003-20230815   gcc  
sparc64              randconfig-r005-20230815   gcc  
sparc64              randconfig-r013-20230815   gcc  
sparc64              randconfig-r032-20230815   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230815   clang
x86_64       buildonly-randconfig-r002-20230815   clang
x86_64       buildonly-randconfig-r003-20230815   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230815   gcc  
x86_64               randconfig-x002-20230815   gcc  
x86_64               randconfig-x003-20230815   gcc  
x86_64               randconfig-x004-20230815   gcc  
x86_64               randconfig-x005-20230815   gcc  
x86_64               randconfig-x006-20230815   gcc  
x86_64               randconfig-x011-20230815   clang
x86_64               randconfig-x012-20230815   clang
x86_64               randconfig-x013-20230815   clang
x86_64               randconfig-x014-20230815   clang
x86_64               randconfig-x015-20230815   clang
x86_64               randconfig-x016-20230815   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
