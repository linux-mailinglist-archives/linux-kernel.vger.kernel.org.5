Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E166774BD5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbjHHU6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjHHU5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:57:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F758684
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 13:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691527834; x=1723063834;
  h=date:from:to:cc:subject:message-id;
  bh=aJxnbcCC+LdOITOPKsi57rvLb2y0AI4RU5qTEVtD1t8=;
  b=fG6GtgtD3OzsnIo9//auhAzSWonfkgeiMsd3AkOnYzCj2RP+2ClrbqiU
   cKpmGXN5gX8u1VIKChlXj873GyrwilsejfVyW20OSJZ7vjUjd3y82WZzT
   dV+/aHd2uA9t2kjPp3fOQFMkKgs1dLh1fy3WzpyD1a4GO3VTFdgFdhnVV
   JkcHzl8o586717s5U0bdxBEdG0r0pe9n4Te6mdgk4M4wJDFXtT/HVxJKk
   k+yGbLfP4YA0D6fgNvDpm4SRHVuvhxAacU9IYvaAZ8yxTrNo2ok/59puv
   uNIbjl4t7ugo93At9kUkMRNmsWgiKGmF6lCyF8QPZkRuwIoRj3dCWlnZa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="361069764"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="361069764"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 13:50:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="845650426"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="845650426"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 Aug 2023 13:50:12 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTTee-0005bk-0v;
        Tue, 08 Aug 2023 20:50:12 +0000
Date:   Wed, 09 Aug 2023 04:49:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 a1b87d54f4e45ff5e0d081fb1d9db3bf1a8fb39a
Message-ID: <202308090418.HGtYc90h-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
branch HEAD: a1b87d54f4e45ff5e0d081fb1d9db3bf1a8fb39a  x86/efistub: Avoid legacy decompressor when doing EFI boot

elapsed time: 721m

configs tested: 93
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230808   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230808   gcc  
arc                  randconfig-r043-20230808   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r006-20230808   gcc  
arm                  randconfig-r011-20230808   clang
arm                  randconfig-r012-20230808   clang
arm                  randconfig-r046-20230808   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r016-20230808   gcc  
csky                 randconfig-r033-20230808   gcc  
hexagon              randconfig-r015-20230808   clang
hexagon              randconfig-r041-20230808   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230808   clang
i386         buildonly-randconfig-r005-20230808   clang
i386         buildonly-randconfig-r006-20230808   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i006-20230808   clang
i386                 randconfig-i011-20230808   gcc  
i386                 randconfig-i012-20230808   gcc  
i386                 randconfig-i013-20230808   gcc  
i386                 randconfig-i014-20230808   gcc  
i386                 randconfig-i015-20230808   gcc  
i386                 randconfig-i016-20230808   gcc  
i386                 randconfig-r012-20230808   gcc  
i386                 randconfig-r014-20230808   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r032-20230808   gcc  
loongarch            randconfig-r034-20230808   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r024-20230808   clang
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230808   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r016-20230808   gcc  
parisc               randconfig-r026-20230808   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r001-20230808   clang
powerpc              randconfig-r013-20230808   gcc  
powerpc              randconfig-r022-20230808   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r014-20230808   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r011-20230808   gcc  
sh                               allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r025-20230808   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r015-20230808   clang
um                   randconfig-r021-20230808   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230808   clang
x86_64       buildonly-randconfig-r002-20230808   clang
x86_64       buildonly-randconfig-r003-20230808   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r002-20230808   clang
x86_64               randconfig-x006-20230808   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r005-20230808   gcc  
xtensa               randconfig-r031-20230808   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
