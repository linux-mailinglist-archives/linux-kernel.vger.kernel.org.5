Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410F17EEFE2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345765AbjKQKOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjKQKOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:14:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE4D85
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700216047; x=1731752047;
  h=date:from:to:cc:subject:message-id;
  bh=cSV6sxsmpbQlpRF7YetTZdYcnF82OhozkDVc/CPjtgE=;
  b=B/6MP8NTCohh3lxHBDA7f1fj9PoJpqfqGSL1rQJnX/AJ/ZQgkV3GmCP5
   njkTeGtFkEOQPimP3EqSpV0tqY+5xMZ8AQCzgPzqoCA3V+bYuHLR2Gpwn
   HsW3INd+wvws171ZU6hLSghXdl+4OcrWWNMnJ72O2/hiXpLxQRkpaPYtD
   g6xIEbJeYeR7mVstDOgF37ba8th5Kv7sZ4RpPuPTAZsJGUpWpKQLfGQfb
   klWqI+OsMtFNThVjU6824GDMSl25PrY0XxkN3PGhzOkmWreT934sBpb+a
   f4UOQRM6o/7p3FcpPDVhVLKgxdwB+qws/Lja3h0SWca4T0mfp0vWMESHA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="394125498"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="394125498"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 02:14:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="1012890401"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="1012890401"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 17 Nov 2023 02:14:04 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3vqd-0002aM-1z;
        Fri, 17 Nov 2023 10:13:47 +0000
Date:   Fri, 17 Nov 2023 18:09:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/Wstringop-overflow-next20231116] BUILD
 SUCCESS f51b145606be2bd8e3912282a553d10832cf049e
Message-ID: <202311171839.SrMj8ic3-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/Wstringop-overflow-next20231116
branch HEAD: f51b145606be2bd8e3912282a553d10832cf049e  Makefile: Enable -Wstringop-overflow globally

elapsed time: 1707m

configs tested: 152
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
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
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
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-002-20231116   gcc  
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
