Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428B27EF044
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345875AbjKQK1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345756AbjKQK1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:27:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64070127
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700216824; x=1731752824;
  h=date:from:to:cc:subject:message-id;
  bh=eOzZm3h57jFao+cG005rOiMATny+jhqXk8PyuU2aAvM=;
  b=VjfYjxbdMvhb9NlmdhjD6pmGkT56/5usYk3wW6SfRv2MEkCDGTU9kMLY
   3DQXVKcvan67xsiXgLYmJ+GcykFr8aI5WynyvZV+YLrTsYTElG0UMTv+S
   V+80YXvGK6pHWTj9hln36r88klTRHMKjfacIfm3Wypw8hUDOlViQusZKh
   ltQD8CvS/M1hwalaYA9J0JHN2Dag0Zd30odfpVx2XwdGO/ufSt/v85kWH
   Kk0EeW3pSmEnsUDSeU84PpyEUhh8NK4IcnMIglyPK1t5sHrooFvVCxhgv
   vcTk9uWvd3nIzUDUNMzE00vFNfUwCH1CnRD+/U8vAkwlp7BLwKWiE/oHR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="388428274"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="388428274"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 02:27:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="6978752"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 17 Nov 2023 02:27:03 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3w3g-0002c3-1f;
        Fri, 17 Nov 2023 10:26:54 +0000
Date:   Fri, 17 Nov 2023 18:25:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/Wstringop-overflow-next20231031] BUILD
 SUCCESS f0816c04b4c4898ee63077ae979d28573b7821ac
Message-ID: <202311171846.uifBgw0B-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/Wstringop-overflow-next20231031
branch HEAD: f0816c04b4c4898ee63077ae979d28573b7821ac  Makefile: Enable -Wstringop-overflow globally

elapsed time: 2037m

configs tested: 169
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
arc                   randconfig-001-20231116   gcc  
arc                   randconfig-002-20231116   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231116   gcc  
arm                   randconfig-002-20231116   gcc  
arm                   randconfig-003-20231116   gcc  
arm                   randconfig-004-20231116   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231116   gcc  
arm64                 randconfig-002-20231116   gcc  
arm64                 randconfig-003-20231116   gcc  
arm64                 randconfig-004-20231116   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231116   gcc  
csky                  randconfig-002-20231116   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231116   gcc  
i386         buildonly-randconfig-002-20231116   gcc  
i386         buildonly-randconfig-003-20231116   gcc  
i386         buildonly-randconfig-004-20231116   gcc  
i386         buildonly-randconfig-005-20231116   gcc  
i386         buildonly-randconfig-006-20231116   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231116   gcc  
i386                  randconfig-002-20231116   gcc  
i386                  randconfig-003-20231116   gcc  
i386                  randconfig-004-20231116   gcc  
i386                  randconfig-005-20231116   gcc  
i386                  randconfig-006-20231116   gcc  
i386                  randconfig-011-20231116   gcc  
i386                  randconfig-012-20231116   gcc  
i386                  randconfig-013-20231116   gcc  
i386                  randconfig-014-20231116   gcc  
i386                  randconfig-015-20231116   gcc  
i386                  randconfig-016-20231116   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231116   gcc  
loongarch             randconfig-002-20231116   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231116   gcc  
nios2                 randconfig-002-20231116   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231116   gcc  
parisc                randconfig-002-20231116   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc               randconfig-001-20231116   gcc  
powerpc               randconfig-002-20231116   gcc  
powerpc               randconfig-003-20231116   gcc  
powerpc64             randconfig-001-20231116   gcc  
powerpc64             randconfig-002-20231116   gcc  
powerpc64             randconfig-003-20231116   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231116   gcc  
riscv                 randconfig-002-20231116   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231116   gcc  
s390                  randconfig-002-20231116   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231116   gcc  
sh                    randconfig-002-20231116   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231116   gcc  
sparc64               randconfig-002-20231116   gcc  
um                               allmodconfig   gcc  
um                                allnoconfig   gcc  
um                               allyesconfig   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231116   gcc  
um                    randconfig-002-20231116   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231116   gcc  
x86_64       buildonly-randconfig-002-20231116   gcc  
x86_64       buildonly-randconfig-003-20231116   gcc  
x86_64       buildonly-randconfig-004-20231116   gcc  
x86_64       buildonly-randconfig-005-20231116   gcc  
x86_64       buildonly-randconfig-006-20231116   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231116   gcc  
x86_64                randconfig-002-20231116   gcc  
x86_64                randconfig-003-20231116   gcc  
x86_64                randconfig-004-20231116   gcc  
x86_64                randconfig-005-20231116   gcc  
x86_64                randconfig-006-20231116   gcc  
x86_64                randconfig-011-20231116   gcc  
x86_64                randconfig-012-20231116   gcc  
x86_64                randconfig-013-20231116   gcc  
x86_64                randconfig-014-20231116   gcc  
x86_64                randconfig-015-20231116   gcc  
x86_64                randconfig-016-20231116   gcc  
x86_64                randconfig-071-20231116   gcc  
x86_64                randconfig-072-20231116   gcc  
x86_64                randconfig-073-20231116   gcc  
x86_64                randconfig-074-20231116   gcc  
x86_64                randconfig-075-20231116   gcc  
x86_64                randconfig-076-20231116   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231116   gcc  
xtensa                randconfig-002-20231116   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
