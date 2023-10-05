Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF8A7BA12E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjJEOpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238550AbjJEOkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:40:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682E059C1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696515195; x=1728051195;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8SlMtXq1ACzJVzAcs3eWrlurrAh4g8Ar2mg5/PWlH4s=;
  b=Qudit+OB7bpUBFpzKKEJyPmxktUio+uxI6zUNP7bZVlH+1pzO+JfdZOA
   Qx5e8TVUREyhCLiwGjxWARNM6tRFhv0r/ei3WrvtW0wo3q3oBk4VJdXuK
   qyrXZSjqbrb4AMQ6l3lg6qm6KGZQ1FTHODxRrHn7b0Fgf6rQB0SiPu5pv
   CZyY/V7nHlkX0MAgK0H8tusq8tNH3hYRc7YorJZJkpKQ2fhx8ytoOxPRx
   a4w2yq61APsgIQi8M855RisnovuT+jD8RS/kF7gKZGIkGg4Wzi/1wZ/GK
   dthqMfGPz+3Tpb7ZQ/49hRunAs6vvGpybrW7tuPf2b31IUuh+Z/5VNYXQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="373748444"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="373748444"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 21:33:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="925444917"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="925444917"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Oct 2023 21:33:45 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoG3T-000L1A-09;
        Thu, 05 Oct 2023 04:33:43 +0000
Date:   Thu, 05 Oct 2023 12:33:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 01a99a750a4f414c221781de2e5570e0ceae04b5
Message-ID: <202310051222.QNatSVaA-lkp@intel.com>
User-Agent: s-nail v14.9.24
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git lo=
cking/core
branch HEAD: 01a99a750a4f414c221781de2e5570e0ceae04b5  futex/requeue: Remov=
e unnecessary =E2=80=98NULL=E2=80=99 initialization from futex_proxy_tryloc=
k_atomic()

elapsed time: 726m

configs tested: 132
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc =20
alpha                            allyesconfig   gcc =20
alpha                               defconfig   gcc =20
arc                              allmodconfig   gcc =20
arc                               allnoconfig   gcc =20
arc                              allyesconfig   gcc =20
arc                          axs101_defconfig   gcc =20
arc                                 defconfig   gcc =20
arc                 nsimosci_hs_smp_defconfig   gcc =20
arc                   randconfig-001-20231005   gcc =20
arm                              alldefconfig   clang
arm                              allmodconfig   gcc =20
arm                               allnoconfig   gcc =20
arm                              allyesconfig   gcc =20
arm                                 defconfig   gcc =20
arm                      footbridge_defconfig   gcc =20
arm                         orion5x_defconfig   clang
arm                          pxa168_defconfig   clang
arm                          pxa3xx_defconfig   gcc =20
arm                   randconfig-001-20231005   gcc =20
arm                         s5pv210_defconfig   clang
arm                           sunxi_defconfig   gcc =20
arm                         vf610m4_defconfig   gcc =20
arm64                            allmodconfig   gcc =20
arm64                             allnoconfig   gcc =20
arm64                            allyesconfig   gcc =20
arm64                               defconfig   gcc =20
csky                             allmodconfig   gcc =20
csky                              allnoconfig   gcc =20
csky                             allyesconfig   gcc =20
csky                                defconfig   gcc =20
i386                             allmodconfig   gcc =20
i386                              allnoconfig   gcc =20
i386                             allyesconfig   gcc =20
i386         buildonly-randconfig-001-20231005   gcc =20
i386         buildonly-randconfig-002-20231005   gcc =20
i386         buildonly-randconfig-003-20231005   gcc =20
i386         buildonly-randconfig-004-20231005   gcc =20
i386         buildonly-randconfig-005-20231005   gcc =20
i386         buildonly-randconfig-006-20231005   gcc =20
i386                              debian-10.3   gcc =20
i386                                defconfig   gcc =20
i386                  randconfig-001-20231005   gcc =20
i386                  randconfig-002-20231005   gcc =20
i386                  randconfig-003-20231005   gcc =20
i386                  randconfig-004-20231005   gcc =20
i386                  randconfig-005-20231005   gcc =20
i386                  randconfig-006-20231005   gcc =20
loongarch                        allmodconfig   gcc =20
loongarch                         allnoconfig   gcc =20
loongarch                        allyesconfig   gcc =20
loongarch                           defconfig   gcc =20
loongarch             randconfig-001-20231005   gcc =20
m68k                             allmodconfig   gcc =20
m68k                              allnoconfig   gcc =20
m68k                             allyesconfig   gcc =20
m68k                                defconfig   gcc =20
microblaze                       allmodconfig   gcc =20
microblaze                        allnoconfig   gcc =20
microblaze                       allyesconfig   gcc =20
microblaze                          defconfig   gcc =20
mips                             allmodconfig   gcc =20
mips                              allnoconfig   gcc =20
mips                             allyesconfig   gcc =20
mips                  decstation_64_defconfig   gcc =20
nios2                            allmodconfig   gcc =20
nios2                             allnoconfig   gcc =20
nios2                            allyesconfig   gcc =20
nios2                               defconfig   gcc =20
openrisc                         alldefconfig   gcc =20
openrisc                         allmodconfig   gcc =20
openrisc                          allnoconfig   gcc =20
openrisc                         allyesconfig   gcc =20
openrisc                            defconfig   gcc =20
parisc                           allmodconfig   gcc =20
parisc                            allnoconfig   gcc =20
parisc                           allyesconfig   gcc =20
parisc                              defconfig   gcc =20
parisc64                            defconfig   gcc =20
powerpc                          allmodconfig   gcc =20
powerpc                           allnoconfig   gcc =20
powerpc                          allyesconfig   gcc =20
powerpc                      bamboo_defconfig   gcc =20
powerpc                      ep88xc_defconfig   gcc =20
powerpc                    klondike_defconfig   gcc =20
powerpc                     skiroot_defconfig   clang
powerpc                  storcenter_defconfig   gcc =20
powerpc                         wii_defconfig   gcc =20
riscv                            allmodconfig   gcc =20
riscv                             allnoconfig   gcc =20
riscv                            allyesconfig   gcc =20
riscv                               defconfig   gcc =20
riscv                    nommu_virt_defconfig   clang
riscv                          rv32_defconfig   gcc =20
s390                             alldefconfig   clang
s390                             allmodconfig   gcc =20
s390                              allnoconfig   gcc =20
s390                             allyesconfig   gcc =20
s390                                defconfig   gcc =20
sh                               allmodconfig   gcc =20
sh                                allnoconfig   gcc =20
sh                               allyesconfig   gcc =20
sh                                  defconfig   gcc =20
sh                   rts7751r2dplus_defconfig   gcc =20
sh                          sdk7780_defconfig   gcc =20
sh                             sh03_defconfig   gcc =20
sparc                            allmodconfig   gcc =20
sparc                             allnoconfig   gcc =20
sparc                            allyesconfig   gcc =20
sparc                               defconfig   gcc =20
sparc64                          allmodconfig   gcc =20
sparc64                          allyesconfig   gcc =20
sparc64                             defconfig   gcc =20
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc =20
um                             i386_defconfig   gcc =20
um                           x86_64_defconfig   gcc =20
x86_64                            allnoconfig   gcc =20
x86_64                           allyesconfig   gcc =20
x86_64                              defconfig   gcc =20
x86_64                randconfig-001-20231005   gcc =20
x86_64                randconfig-002-20231005   gcc =20
x86_64                randconfig-003-20231005   gcc =20
x86_64                randconfig-004-20231005   gcc =20
x86_64                randconfig-005-20231005   gcc =20
x86_64                randconfig-006-20231005   gcc =20
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc =20
xtensa                            allnoconfig   gcc =20
xtensa                           allyesconfig   gcc =20

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
