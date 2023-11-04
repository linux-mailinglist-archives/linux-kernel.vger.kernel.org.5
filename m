Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4238E7E0F38
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 12:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjKDLrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 07:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDLrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 07:47:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BFED47
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 04:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699098457; x=1730634457;
  h=date:from:to:cc:subject:message-id;
  bh=L8EU0zQGlXwDReMVmoPgNFfTzuOL95hx+VxtXqWCOn4=;
  b=M+2B7hpjHmc4gPjtX6DuRtensU/Xkgu50p5DmluDWZSygsz6EgbSOcJS
   uzys14QPrIUtwCarVJZrX8NDJ5uNbU3F/gCuSJbAtQei3Q1T53y+RzojS
   7HiHsTmm3k4vhESKpyvmK+LChFJKD7yowa/yjoWHRSG7lyoOgtdSZHyQr
   +BTNZFe6iO3lAeHFjYeVcyfx5wqjri4dr5SKfktZbpnSZ5GseGc5J9Tkw
   wcOAt8yBv//detap1GsddjSoV6580YAa532tRmDKOmp1+6nfGb1SEeEjG
   7PSm8y7iPLIXGE57yRpA2uqLrcQQ95ltBndKbHS4XYTfF8v+kYq5qmR6y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="453381021"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="453381021"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 04:47:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="852524935"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="852524935"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Nov 2023 04:47:35 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzF7l-0004HK-2G;
        Sat, 04 Nov 2023 11:47:33 +0000
Date:   Sat, 04 Nov 2023 19:47:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/Wstringop-overflow-next20231031] BUILD
 SUCCESS d436bd31d7ebf2592ffb2dbc77d3625012baacc9
Message-ID: <202311041904.WiGptJgG-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/Wstringop-overflow-next20231031
branch HEAD: d436bd31d7ebf2592ffb2dbc77d3625012baacc9  Makefile: Enable -Wstringop-overflow globally

elapsed time: 4951m

configs tested: 154
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
arc                   randconfig-001-20231101   gcc  
arc                   randconfig-002-20231101   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231101   gcc  
arm                   randconfig-002-20231101   gcc  
arm                   randconfig-003-20231101   gcc  
arm                   randconfig-004-20231101   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231101   gcc  
arm64                 randconfig-002-20231101   gcc  
arm64                 randconfig-003-20231101   gcc  
arm64                 randconfig-004-20231101   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231101   gcc  
csky                  randconfig-002-20231101   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231101   gcc  
i386         buildonly-randconfig-002-20231101   gcc  
i386         buildonly-randconfig-003-20231101   gcc  
i386         buildonly-randconfig-004-20231101   gcc  
i386         buildonly-randconfig-005-20231101   gcc  
i386         buildonly-randconfig-006-20231101   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231101   gcc  
i386                  randconfig-002-20231101   gcc  
i386                  randconfig-003-20231101   gcc  
i386                  randconfig-004-20231101   gcc  
i386                  randconfig-005-20231101   gcc  
i386                  randconfig-006-20231101   gcc  
i386                  randconfig-011-20231101   gcc  
i386                  randconfig-012-20231101   gcc  
i386                  randconfig-013-20231101   gcc  
i386                  randconfig-014-20231101   gcc  
i386                  randconfig-015-20231101   gcc  
i386                  randconfig-016-20231101   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231101   gcc  
loongarch             randconfig-002-20231101   gcc  
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
nios2                 randconfig-001-20231101   gcc  
nios2                 randconfig-002-20231101   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231101   gcc  
parisc                randconfig-002-20231101   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc               randconfig-001-20231101   gcc  
powerpc               randconfig-002-20231101   gcc  
powerpc               randconfig-003-20231101   gcc  
powerpc64             randconfig-001-20231101   gcc  
powerpc64             randconfig-002-20231101   gcc  
powerpc64             randconfig-003-20231101   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231101   gcc  
riscv                 randconfig-002-20231101   gcc  
riscv                          rv32_defconfig   gcc  
s390                              allnoconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231101   gcc  
s390                  randconfig-002-20231101   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231101   gcc  
sh                    randconfig-002-20231101   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231101   gcc  
sparc                 randconfig-002-20231101   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231101   gcc  
sparc64               randconfig-002-20231101   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231101   gcc  
um                    randconfig-002-20231101   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231101   gcc  
x86_64       buildonly-randconfig-002-20231101   gcc  
x86_64       buildonly-randconfig-003-20231101   gcc  
x86_64       buildonly-randconfig-004-20231101   gcc  
x86_64       buildonly-randconfig-005-20231101   gcc  
x86_64       buildonly-randconfig-006-20231101   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231101   gcc  
x86_64                randconfig-002-20231101   gcc  
x86_64                randconfig-003-20231101   gcc  
x86_64                randconfig-004-20231101   gcc  
x86_64                randconfig-005-20231101   gcc  
x86_64                randconfig-006-20231101   gcc  
x86_64                randconfig-011-20231101   gcc  
x86_64                randconfig-012-20231101   gcc  
x86_64                randconfig-013-20231101   gcc  
x86_64                randconfig-014-20231101   gcc  
x86_64                randconfig-015-20231101   gcc  
x86_64                randconfig-016-20231101   gcc  
x86_64                randconfig-071-20231101   gcc  
x86_64                randconfig-072-20231101   gcc  
x86_64                randconfig-073-20231101   gcc  
x86_64                randconfig-074-20231101   gcc  
x86_64                randconfig-075-20231101   gcc  
x86_64                randconfig-076-20231101   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                randconfig-001-20231101   gcc  
xtensa                randconfig-002-20231101   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
