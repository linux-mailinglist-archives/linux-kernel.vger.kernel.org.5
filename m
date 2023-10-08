Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9229D7BD0D0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 00:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344790AbjJHWVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 18:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbjJHWVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 18:21:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323F7AC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 15:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696803682; x=1728339682;
  h=date:from:to:cc:subject:message-id;
  bh=cMhYEO+Kn0iz/QMlno4gE8MzbcduOet3XXC+vwi9r0Y=;
  b=hsygbIDmQcGMHX4yu3aF9PNdglXGWpL9YUlhaO4UxPhll6WJQawhYaJe
   ijrkqUf0EC/0jhbYrFuyb6HGHrLOoNVRTvTOlvFxzZvdpYeWkRBCV2zL8
   mjrnTCGi16OPTVet4Ha2TLAFTeih1AYf+WZN2GXo+6+XwFiiSUwOxE6D5
   /bMy8te+0fHuTW9Y6EM/U6Fmfz2pzPyGF99f0zWM+hC8Y9rDMcw2OLvYL
   ei2nlPTiURwCgCGpfzAih0SFUrGwWoBxDHIikpn2uyBJ15IvNQr0hNepH
   7aK5JPplZwim8o4y5J3WFA/R4x40yx2a/th0B9pgyiy72V+lHn+ASxmf/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="382913260"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="382913260"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 15:21:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="818638632"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="818638632"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 08 Oct 2023 15:21:20 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpc9G-0005oV-1h;
        Sun, 08 Oct 2023 22:21:18 +0000
Date:   Mon, 09 Oct 2023 06:20:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 a56d5551e1993ca84dd0c69df5a3d8223d13fb5f
Message-ID: <202310090637.S5cP23MF-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: a56d5551e1993ca84dd0c69df5a3d8223d13fb5f  perf/x86/rapl: Annotate 'struct rapl_pmus' with __counted_by

elapsed time: 721m

configs tested: 147
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
arc                         haps_hs_defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20231008   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          ep93xx_defconfig   clang
arm                          pxa3xx_defconfig   gcc  
arm                   randconfig-001-20231008   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231008   gcc  
i386         buildonly-randconfig-002-20231008   gcc  
i386         buildonly-randconfig-003-20231008   gcc  
i386         buildonly-randconfig-004-20231008   gcc  
i386         buildonly-randconfig-005-20231008   gcc  
i386         buildonly-randconfig-006-20231008   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231008   gcc  
i386                  randconfig-002-20231008   gcc  
i386                  randconfig-003-20231008   gcc  
i386                  randconfig-004-20231008   gcc  
i386                  randconfig-005-20231008   gcc  
i386                  randconfig-006-20231008   gcc  
i386                  randconfig-011-20231008   gcc  
i386                  randconfig-012-20231008   gcc  
i386                  randconfig-013-20231008   gcc  
i386                  randconfig-014-20231008   gcc  
i386                  randconfig-015-20231008   gcc  
i386                  randconfig-016-20231008   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231008   gcc  
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
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                      tqm8xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231008   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231008   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231008   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231008   gcc  
x86_64       buildonly-randconfig-002-20231008   gcc  
x86_64       buildonly-randconfig-003-20231008   gcc  
x86_64       buildonly-randconfig-004-20231008   gcc  
x86_64       buildonly-randconfig-005-20231008   gcc  
x86_64       buildonly-randconfig-006-20231008   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231008   gcc  
x86_64                randconfig-002-20231008   gcc  
x86_64                randconfig-003-20231008   gcc  
x86_64                randconfig-004-20231008   gcc  
x86_64                randconfig-005-20231008   gcc  
x86_64                randconfig-006-20231008   gcc  
x86_64                randconfig-011-20231008   gcc  
x86_64                randconfig-012-20231008   gcc  
x86_64                randconfig-013-20231008   gcc  
x86_64                randconfig-014-20231008   gcc  
x86_64                randconfig-015-20231008   gcc  
x86_64                randconfig-016-20231008   gcc  
x86_64                randconfig-071-20231008   gcc  
x86_64                randconfig-072-20231008   gcc  
x86_64                randconfig-073-20231008   gcc  
x86_64                randconfig-074-20231008   gcc  
x86_64                randconfig-075-20231008   gcc  
x86_64                randconfig-076-20231008   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                generic_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
