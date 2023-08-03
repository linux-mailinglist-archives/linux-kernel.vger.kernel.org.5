Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B6776DEAB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 05:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjHCDB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 23:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjHCDBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 23:01:54 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F4310A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 20:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691031713; x=1722567713;
  h=date:from:to:cc:subject:message-id;
  bh=1Fh/RD+e6DRK3mIhtkdKCpFBLE9HswmsJOmCeY5EyxY=;
  b=Xmov0VhwDWhE8RnYucNH1wogb4ePVnwlkwC57fqGClZ7exeGs5cGz4mr
   NkXXKQNKFwLUPFJXzQsKNuq9V7D244zeQ+DtNpNS+jLAZCtjUe3N8iVqY
   pBn45rIEkh//kZxefqVUhJnjD7mT8oRUAI9iyr/DUCK8oFtSd0Joa4ccd
   l2NoLgjlGdY1NH9ynX+StgoKUMt+xvBf4jMVObODB2jrlyPLW3ncFq9Dd
   TWmXUQjL1fyp2kCO88pgYXPaQzIPldxMofWfl1HKuNI/R/bPUDz3/oc2v
   UjNXYulk2qcrYj2Cr20nYHUPZzeYmLtf1UdcgQCRA7CNhsSNnyhugVA3k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="368654613"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="368654613"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 20:01:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="819457678"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="819457678"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2023 20:01:52 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qROb1-0001hW-1R;
        Thu, 03 Aug 2023 03:01:51 +0000
Date:   Thu, 03 Aug 2023 11:01:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 029239c5b0e6484e4443be90e5664fd0bf0f066b
Message-ID: <202308031132.No6Zc1rf-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 029239c5b0e6484e4443be90e5664fd0bf0f066b  x86/retpoline,kprobes: Skip optprobe check for indirect jumps with retpolines and IBT

elapsed time: 725m

configs tested: 154
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230731   gcc  
alpha                randconfig-r036-20230801   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230801   gcc  
arc                  randconfig-r023-20230801   gcc  
arc                  randconfig-r033-20230731   gcc  
arc                  randconfig-r043-20230801   gcc  
arc                  randconfig-r043-20230802   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                          pxa3xx_defconfig   gcc  
arm                  randconfig-r005-20230801   clang
arm                  randconfig-r021-20230801   gcc  
arm                  randconfig-r046-20230801   gcc  
arm                        realview_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230731   clang
arm64                randconfig-r014-20230731   clang
arm64                randconfig-r036-20230731   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230801   gcc  
hexagon              randconfig-r041-20230801   clang
hexagon              randconfig-r045-20230801   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230731   gcc  
i386         buildonly-randconfig-r004-20230801   gcc  
i386         buildonly-randconfig-r005-20230731   gcc  
i386         buildonly-randconfig-r005-20230801   gcc  
i386         buildonly-randconfig-r006-20230731   gcc  
i386         buildonly-randconfig-r006-20230801   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230731   gcc  
i386                 randconfig-i001-20230801   gcc  
i386                 randconfig-i002-20230731   gcc  
i386                 randconfig-i002-20230801   gcc  
i386                 randconfig-i003-20230731   gcc  
i386                 randconfig-i003-20230801   gcc  
i386                 randconfig-i004-20230731   gcc  
i386                 randconfig-i004-20230801   gcc  
i386                 randconfig-i005-20230731   gcc  
i386                 randconfig-i005-20230801   gcc  
i386                 randconfig-i006-20230731   gcc  
i386                 randconfig-i006-20230801   gcc  
i386                 randconfig-i011-20230731   clang
i386                 randconfig-i011-20230802   gcc  
i386                 randconfig-i012-20230731   clang
i386                 randconfig-i012-20230802   gcc  
i386                 randconfig-i013-20230731   clang
i386                 randconfig-i013-20230802   gcc  
i386                 randconfig-i014-20230731   clang
i386                 randconfig-i014-20230802   gcc  
i386                 randconfig-i015-20230731   clang
i386                 randconfig-i015-20230802   gcc  
i386                 randconfig-i016-20230731   clang
i386                 randconfig-i016-20230802   gcc  
i386                 randconfig-r025-20230731   clang
i386                 randconfig-r026-20230801   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230731   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                 randconfig-r025-20230801   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r001-20230801   gcc  
microblaze           randconfig-r003-20230801   gcc  
microblaze           randconfig-r005-20230801   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                      maltaaprp_defconfig   clang
mips                 randconfig-r002-20230801   clang
mips                          rb532_defconfig   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r014-20230731   gcc  
openrisc             randconfig-r034-20230801   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230801   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     mpc5200_defconfig   clang
powerpc              randconfig-r003-20230801   gcc  
powerpc              randconfig-r022-20230731   clang
powerpc              randconfig-r026-20230731   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230801   clang
riscv                randconfig-r042-20230802   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r011-20230731   clang
s390                 randconfig-r044-20230801   clang
s390                 randconfig-r044-20230802   gcc  
sh                               allmodconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                   randconfig-r024-20230801   gcc  
sh                           se7724_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r033-20230801   gcc  
sparc64              randconfig-r002-20230801   gcc  
sparc64              randconfig-r015-20230731   gcc  
sparc64              randconfig-r031-20230801   gcc  
sparc64              randconfig-r035-20230731   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230731   gcc  
x86_64       buildonly-randconfig-r001-20230801   gcc  
x86_64       buildonly-randconfig-r002-20230731   gcc  
x86_64       buildonly-randconfig-r002-20230801   gcc  
x86_64       buildonly-randconfig-r003-20230731   gcc  
x86_64       buildonly-randconfig-r003-20230801   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r012-20230731   clang
x86_64               randconfig-x001-20230731   clang
x86_64               randconfig-x002-20230731   clang
x86_64               randconfig-x003-20230731   clang
x86_64               randconfig-x004-20230731   clang
x86_64               randconfig-x005-20230731   clang
x86_64               randconfig-x006-20230731   clang
x86_64               randconfig-x011-20230731   gcc  
x86_64               randconfig-x012-20230731   gcc  
x86_64               randconfig-x013-20230731   gcc  
x86_64               randconfig-x014-20230731   gcc  
x86_64               randconfig-x015-20230731   gcc  
x86_64               randconfig-x016-20230731   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r022-20230801   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
