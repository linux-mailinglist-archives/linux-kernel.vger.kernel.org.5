Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B634B764FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjG0JjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjG0Jii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:38:38 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB05A9C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690450506; x=1721986506;
  h=date:from:to:cc:subject:message-id;
  bh=9nWr5ifGwiizlsDQhPRniUZohUXYmnJaSY+mECiRpYQ=;
  b=MEeZyf8yF75crwDRkJQWEn3ApP2oiRdcRsm1JYYAXRgNK4fmyL/toGIu
   7jgkS6qRk0p8ccail6qEtk7KS2I6mdIjfbALdxVsgoUtfw24ch0vZ4t7K
   5PAWil6Qo0HiCjbjnuSknfShqf6UDtsH0FOc8ez7swuYkBgi6s8l4ial2
   DFgILH/uGFFH2yYWyRbsGlZkO1sGrrjX/IMRaS26fIIhX3yNv9CFOoF5G
   djPG3u7uubolQKIbqYN9tkVyiCEgVYcwYCTyjK69Hk3ndaY+h75EdPm5f
   L7jD+XZCrs8ZgG0pn/fZY7TsLpDiH0dT4AUXEcH10jw8xDbMdCXJEDR0T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="347872850"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="347872850"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 02:35:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="817032459"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="817032459"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2023 02:34:53 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOxMp-00028b-1t;
        Thu, 27 Jul 2023 09:33:40 +0000
Date:   Thu, 27 Jul 2023 17:29:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 606c1a58664f21f7db3f38b333420f582821de3e
Message-ID: <202307271739.6aPc5IAp-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 606c1a58664f21f7db3f38b333420f582821de3e  rcu: Eliminate check_cpu_stall() duplicate code

elapsed time: 728m

configs tested: 138
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230726   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230726   gcc  
arc                  randconfig-r043-20230727   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r004-20230726   clang
arm                  randconfig-r014-20230726   gcc  
arm                  randconfig-r046-20230726   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r021-20230726   clang
csky                                defconfig   gcc  
hexagon              randconfig-r003-20230726   clang
hexagon              randconfig-r041-20230726   clang
hexagon              randconfig-r045-20230726   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230726   gcc  
i386         buildonly-randconfig-r005-20230726   gcc  
i386         buildonly-randconfig-r006-20230726   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230726   gcc  
i386                 randconfig-i001-20230727   clang
i386                 randconfig-i002-20230726   gcc  
i386                 randconfig-i002-20230727   clang
i386                 randconfig-i003-20230726   gcc  
i386                 randconfig-i003-20230727   clang
i386                 randconfig-i004-20230726   gcc  
i386                 randconfig-i004-20230727   clang
i386                 randconfig-i005-20230726   gcc  
i386                 randconfig-i005-20230727   clang
i386                 randconfig-i006-20230726   gcc  
i386                 randconfig-i006-20230727   clang
i386                 randconfig-i011-20230726   clang
i386                 randconfig-i011-20230727   gcc  
i386                 randconfig-i012-20230726   clang
i386                 randconfig-i012-20230727   gcc  
i386                 randconfig-i013-20230726   clang
i386                 randconfig-i013-20230727   gcc  
i386                 randconfig-i014-20230726   clang
i386                 randconfig-i014-20230727   gcc  
i386                 randconfig-i015-20230726   clang
i386                 randconfig-i015-20230727   gcc  
i386                 randconfig-i016-20230726   clang
i386                 randconfig-i016-20230727   gcc  
i386                 randconfig-r024-20230726   clang
i386                 randconfig-r032-20230726   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230727   gcc  
loongarch            randconfig-r015-20230726   gcc  
loongarch            randconfig-r016-20230726   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                 randconfig-r012-20230726   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r026-20230726   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230726   gcc  
nios2                randconfig-r014-20230726   gcc  
openrisc             randconfig-r005-20230726   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230727   gcc  
parisc               randconfig-r011-20230726   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r006-20230726   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230726   gcc  
riscv                randconfig-r013-20230726   clang
riscv                randconfig-r035-20230726   gcc  
riscv                randconfig-r042-20230726   clang
riscv                randconfig-r042-20230727   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230726   clang
s390                 randconfig-r044-20230727   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r003-20230727   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230726   gcc  
sparc64              randconfig-r031-20230726   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230726   gcc  
x86_64       buildonly-randconfig-r002-20230726   gcc  
x86_64       buildonly-randconfig-r003-20230726   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230726   clang
x86_64               randconfig-x002-20230726   clang
x86_64               randconfig-x003-20230726   clang
x86_64               randconfig-x004-20230726   clang
x86_64               randconfig-x005-20230726   clang
x86_64               randconfig-x006-20230726   clang
x86_64               randconfig-x011-20230726   gcc  
x86_64               randconfig-x011-20230727   clang
x86_64               randconfig-x012-20230726   gcc  
x86_64               randconfig-x012-20230727   clang
x86_64               randconfig-x013-20230726   gcc  
x86_64               randconfig-x013-20230727   clang
x86_64               randconfig-x014-20230726   gcc  
x86_64               randconfig-x014-20230727   clang
x86_64               randconfig-x015-20230726   gcc  
x86_64               randconfig-x015-20230727   clang
x86_64               randconfig-x016-20230726   gcc  
x86_64               randconfig-x016-20230727   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r002-20230726   gcc  
xtensa               randconfig-r002-20230727   gcc  
xtensa               randconfig-r015-20230726   gcc  
xtensa               randconfig-r022-20230726   gcc  
xtensa               randconfig-r033-20230726   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
