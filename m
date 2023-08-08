Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ADE774C90
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbjHHVLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbjHHVLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:11:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799A447FF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691528956; x=1723064956;
  h=date:from:to:cc:subject:message-id;
  bh=HAxYDc5i8izBVxCDU8NB06bL9NcnL4D5gcSFEKynEN4=;
  b=Ihjkory2zwyKThUL5HEyyco39BoXUByTG+Z9D7cjyEej85iS/dTn1X5b
   +rrebuuxiTOhHzMv8f0ef40YPBCLU5lCo6WzwDBb/fcrGOn9Iiue16kwM
   CEYggERLAOUpT3ZEAMwwUwjuVZpkuR/vrSTOUfEgsEaRpTZkWECTFsIWx
   pFE+RV1xUV5sZqaRz1TU/2hFGD4aXklVnFNy314FOf/ngdPpgbxpkJvqd
   p9KO5dOpfUvY1UlMy/mbRBZXV5EvGhNVsAmeBc/0bq0ZzkU0okbHwCWFR
   Yj7wfR0dcrogEUXOuhPHmJbhd13RWdpAq4ibpRDXp95OYCR7pHB/Hmb79
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="457335381"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="457335381"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 14:09:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="801476356"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="801476356"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Aug 2023 14:09:15 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTTx4-0005ci-20;
        Tue, 08 Aug 2023 21:09:14 +0000
Date:   Wed, 09 Aug 2023 05:08:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:smp/core] BUILD SUCCESS
 e0a99a839f04c90bf9f16919997c4b34f9c8f1f0
Message-ID: <202308090523.VyUksRFe-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
branch HEAD: e0a99a839f04c90bf9f16919997c4b34f9c8f1f0  Documentation: core-api/cpuhotplug: Fix state names

elapsed time: 723m

configs tested: 87
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230808   gcc  
alpha                randconfig-r003-20230808   gcc  
alpha                randconfig-r035-20230808   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r013-20230808   gcc  
arc                  randconfig-r021-20230808   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r025-20230808   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230808   clang
arm64                randconfig-r006-20230808   clang
arm64                randconfig-r011-20230808   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r025-20230808   gcc  
csky                 randconfig-r034-20230808   gcc  
hexagon              randconfig-r005-20230808   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i006-20230808   clang
i386                 randconfig-i015-20230808   gcc  
i386                 randconfig-i016-20230808   gcc  
i386                 randconfig-r004-20230808   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r033-20230808   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r004-20230808   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r012-20230808   clang
mips                 randconfig-r021-20230808   clang
mips                 randconfig-r022-20230808   clang
mips                 randconfig-r026-20230808   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r026-20230808   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r014-20230808   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r002-20230808   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r024-20230808   gcc  
s390                 randconfig-r031-20230808   clang
s390                 randconfig-r044-20230808   gcc  
sh                               allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r032-20230808   gcc  
um                   randconfig-r036-20230808   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x006-20230808   gcc  
x86_64               randconfig-x011-20230808   clang
x86_64               randconfig-x012-20230808   clang
x86_64               randconfig-x013-20230808   clang
x86_64               randconfig-x014-20230808   clang
x86_64               randconfig-x015-20230808   clang
x86_64               randconfig-x016-20230808   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r016-20230808   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
