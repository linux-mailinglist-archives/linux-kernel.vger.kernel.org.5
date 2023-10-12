Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F427C6490
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 07:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377057AbjJLFVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 01:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjJLFVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 01:21:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912D490
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 22:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697088081; x=1728624081;
  h=date:from:to:cc:subject:message-id;
  bh=uMm4ogi2McRaEroe5rYZnzEQxPQg2L4Bd0jiSW7AnKo=;
  b=eswiK6BvGg+oaND5Zvbsn/EU7nVlnTiJPCt53RZqmUJeUYkB81uwWgAA
   9xnYnMbraOO7YSuw93eiadlcZsNKd6MIRVtvye5LgEK5cG4hGFYwSHqJ7
   XYj444FS6mvKWOMCGtQ29gg50zjTil0Xr2LZdvE8xjUW8m31Fl39H2la8
   23Ip8+cVlwctvHYnm6bq28pEmmV/el4a89cFdLeaonzsyCJcMwEMjD93p
   0JAnSEGe0g2q0M3bsiE2GuPr2UFUP0gaxX7HX7pbTwPAvGegh2UHRN0Ty
   emzNOtpiGZJ2tkURxzQBTjlLmDcL7zr3A3eSsoUvE1n7FyOE+GaWi0d5N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="382074805"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="382074805"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 22:21:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="870421884"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="870421884"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 11 Oct 2023 22:21:20 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqo8M-0003DD-0w;
        Thu, 12 Oct 2023 05:21:18 +0000
Date:   Thu, 12 Oct 2023 13:20:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/percpu] BUILD SUCCESS
 e29aad08b1da7772b362537be32335c0394e65fe
Message-ID: <202310121337.mLTb85Hw-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/percpu
branch HEAD: e29aad08b1da7772b362537be32335c0394e65fe  x86/percpu: Disable named address spaces for KASAN

Unverified Warning (likely false positive, please contact us if interested):

fs/buffer.c:1386 lookup_bh_lru() warn: ignoring unreachable code.
fs/buffer.c:1386 lookup_bh_lru() warn: inconsistent indenting

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-141-20231011
    |-- fs-buffer.c-lookup_bh_lru()-warn:ignoring-unreachable-code.
    `-- fs-buffer.c-lookup_bh_lru()-warn:inconsistent-indenting

elapsed time: 1879m

configs tested: 99
configs skipped: 113

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231011   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231011   gcc  
i386         buildonly-randconfig-002-20231011   gcc  
i386         buildonly-randconfig-003-20231011   gcc  
i386         buildonly-randconfig-004-20231011   gcc  
i386         buildonly-randconfig-005-20231011   gcc  
i386         buildonly-randconfig-005-20231012   gcc  
i386         buildonly-randconfig-006-20231011   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231011   gcc  
i386                  randconfig-002-20231011   gcc  
i386                  randconfig-003-20231011   gcc  
i386                  randconfig-004-20231011   gcc  
i386                  randconfig-005-20231011   gcc  
i386                  randconfig-006-20231011   gcc  
i386                  randconfig-011-20231011   gcc  
i386                  randconfig-012-20231011   gcc  
i386                  randconfig-013-20231011   gcc  
i386                  randconfig-014-20231011   gcc  
i386                  randconfig-015-20231011   gcc  
i386                  randconfig-016-20231011   gcc  
loongarch             randconfig-001-20231012   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                 randconfig-001-20231011   gcc  
riscv                 randconfig-001-20231012   gcc  
s390                  randconfig-001-20231011   gcc  
s390                  randconfig-001-20231012   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231011   gcc  
x86_64       buildonly-randconfig-002-20231011   gcc  
x86_64       buildonly-randconfig-003-20231011   gcc  
x86_64       buildonly-randconfig-004-20231011   gcc  
x86_64       buildonly-randconfig-005-20231011   gcc  
x86_64       buildonly-randconfig-006-20231011   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231011   gcc  
x86_64                randconfig-001-20231012   gcc  
x86_64                randconfig-002-20231011   gcc  
x86_64                randconfig-002-20231012   gcc  
x86_64                randconfig-003-20231011   gcc  
x86_64                randconfig-004-20231011   gcc  
x86_64                randconfig-005-20231011   gcc  
x86_64                randconfig-006-20231011   gcc  
x86_64                randconfig-011-20231011   gcc  
x86_64                randconfig-012-20231011   gcc  
x86_64                randconfig-013-20231011   gcc  
x86_64                randconfig-014-20231011   gcc  
x86_64                randconfig-015-20231011   gcc  
x86_64                randconfig-016-20231011   gcc  
x86_64                randconfig-071-20231011   gcc  
x86_64                randconfig-072-20231011   gcc  
x86_64                randconfig-073-20231011   gcc  
x86_64                randconfig-074-20231011   gcc  
x86_64                randconfig-075-20231011   gcc  
x86_64                randconfig-076-20231011   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
