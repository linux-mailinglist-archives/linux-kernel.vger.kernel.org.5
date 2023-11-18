Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9CE7EFF7E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 13:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjKRMRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 07:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjKRMRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 07:17:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0DAD5D
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 04:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700309834; x=1731845834;
  h=date:from:to:cc:subject:message-id;
  bh=7Gm5QIAk7MYe9Iw2E6tllJ+zy62vM/dw3pXi14rcZ8I=;
  b=P5jbofiaqkTkamnRVLuP/Mdt9IsnAhwJXBJ26eJZsFxzs3cmTz/laUFd
   ILlzvJBB91cWnO4xwC1/pRap8zv9MaHHbl3kQmEuZNLNURLPNgh1sd4Tz
   EOmlIrQDMzasItmk65xgn753Od6q+AMEJrpxp5lGtJzQQsTGQ3Z+6d75Z
   CSr4mEP5YuZQwKYgk6RqvubnTJoTrgCoZHo8+0OxBD++1pTwuR5vLIGp7
   xvOGzA4tIHhpbA5OEEZzwD0GNdXuVssIl2/g9XwLwYbOGnlmIlTurSFep
   h7CMUyge9zc19TG4LE4yWDczbNtZ44XmD4zh2M+TpbMuz9CcE30Jrwzks
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="370772026"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="370772026"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 04:17:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="769455641"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="769455641"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 18 Nov 2023 04:17:13 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4KG6-0003t9-35;
        Sat, 18 Nov 2023 12:17:10 +0000
Date:   Sat, 18 Nov 2023 20:16:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/next20231116-Warray-bounds] BUILD
 SUCCESS e636d8836f48541eb6e09f4371dbb8869ca1fc1c
Message-ID: <202311182020.hkYNRgGS-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/next20231116-Warray-bounds
branch HEAD: e636d8836f48541eb6e09f4371dbb8869ca1fc1c  Makefile: Enable -Warray-bounds globally

Unverified Warning (likely false positive, please contact us if interested):

security/security.c:810:9: warning: 'memcpy' offset 32 is out of the bounds [0, 0] [-Warray-bounds=]
security/security.c:810:9: warning: 'memcpy' offset 32 is out of the bounds [0, 0] [-Warray-bounds]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-defconfig
|   `-- security-security.c:warning:memcpy-offset-is-out-of-the-bounds
|-- arm64-randconfig-003-20231117
|   `-- security-security.c:warning:memcpy-offset-is-out-of-the-bounds
|-- riscv-defconfig
|   `-- security-security.c:warning:memcpy-offset-is-out-of-the-bounds
|-- riscv-randconfig-002-20231117
|   `-- security-security.c:warning:memcpy-offset-is-out-of-the-bounds
|-- s390-defconfig
|   `-- security-security.c:warning:memcpy-offset-is-out-of-the-bounds
|-- x86_64-buildonly-randconfig-001-20231117
|   `-- security-security.c:warning:memcpy-offset-is-out-of-the-bounds
|-- x86_64-buildonly-randconfig-005-20231117
|   `-- security-security.c:warning:memcpy-offset-is-out-of-the-bounds
`-- x86_64-defconfig
    `-- security-security.c:warning:memcpy-offset-is-out-of-the-bounds

elapsed time: 2263m

configs tested: 168
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
arc                   randconfig-001-20231117   gcc  
arc                   randconfig-002-20231117   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231117   gcc  
arm                   randconfig-002-20231117   gcc  
arm                   randconfig-003-20231117   gcc  
arm                   randconfig-004-20231117   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231117   gcc  
arm64                 randconfig-002-20231117   gcc  
arm64                 randconfig-003-20231117   gcc  
arm64                 randconfig-004-20231117   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231117   gcc  
csky                  randconfig-002-20231117   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231117   gcc  
i386         buildonly-randconfig-002-20231117   gcc  
i386         buildonly-randconfig-003-20231117   gcc  
i386         buildonly-randconfig-004-20231117   gcc  
i386         buildonly-randconfig-005-20231117   gcc  
i386         buildonly-randconfig-006-20231117   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231117   gcc  
i386                  randconfig-002-20231117   gcc  
i386                  randconfig-003-20231117   gcc  
i386                  randconfig-004-20231117   gcc  
i386                  randconfig-005-20231117   gcc  
i386                  randconfig-006-20231117   gcc  
i386                  randconfig-011-20231117   gcc  
i386                  randconfig-012-20231117   gcc  
i386                  randconfig-013-20231117   gcc  
i386                  randconfig-014-20231117   gcc  
i386                  randconfig-015-20231117   gcc  
i386                  randconfig-016-20231117   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231117   gcc  
loongarch             randconfig-002-20231117   gcc  
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
nios2                 randconfig-001-20231117   gcc  
nios2                 randconfig-002-20231117   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231117   gcc  
parisc                randconfig-002-20231117   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc               randconfig-001-20231117   gcc  
powerpc               randconfig-002-20231117   gcc  
powerpc               randconfig-003-20231117   gcc  
powerpc64             randconfig-001-20231117   gcc  
powerpc64             randconfig-002-20231117   gcc  
powerpc64             randconfig-003-20231117   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231117   gcc  
riscv                 randconfig-002-20231117   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231117   gcc  
s390                  randconfig-002-20231117   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231117   gcc  
sh                    randconfig-002-20231117   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231117   gcc  
sparc64               randconfig-002-20231117   gcc  
um                               allmodconfig   gcc  
um                                allnoconfig   gcc  
um                               allyesconfig   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231117   gcc  
um                    randconfig-002-20231117   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231117   gcc  
x86_64       buildonly-randconfig-002-20231117   gcc  
x86_64       buildonly-randconfig-003-20231117   gcc  
x86_64       buildonly-randconfig-004-20231117   gcc  
x86_64       buildonly-randconfig-005-20231117   gcc  
x86_64       buildonly-randconfig-006-20231117   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231117   gcc  
x86_64                randconfig-002-20231117   gcc  
x86_64                randconfig-003-20231117   gcc  
x86_64                randconfig-004-20231117   gcc  
x86_64                randconfig-005-20231117   gcc  
x86_64                randconfig-006-20231117   gcc  
x86_64                randconfig-011-20231117   gcc  
x86_64                randconfig-012-20231117   gcc  
x86_64                randconfig-013-20231117   gcc  
x86_64                randconfig-014-20231117   gcc  
x86_64                randconfig-015-20231117   gcc  
x86_64                randconfig-016-20231117   gcc  
x86_64                randconfig-071-20231117   gcc  
x86_64                randconfig-072-20231117   gcc  
x86_64                randconfig-073-20231117   gcc  
x86_64                randconfig-074-20231117   gcc  
x86_64                randconfig-075-20231117   gcc  
x86_64                randconfig-076-20231117   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231117   gcc  
xtensa                randconfig-002-20231117   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
