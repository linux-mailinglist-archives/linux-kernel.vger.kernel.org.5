Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB197901F6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244823AbjIASUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjIASUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:20:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FB1F2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 11:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693592451; x=1725128451;
  h=date:from:to:cc:subject:message-id;
  bh=jY69ap5UiVcHdnECRGqbpWJ0KNXMVHbGfR6U+hN0FC0=;
  b=ZL4IbXv9qeZnVBx2G0umd/mbKZZefilEhkwyCn7aOEYE0xx3Zl4uvPVl
   qOBFEGZGd/yuaMeP/XPfWZmIU4VvG3GSaULAvTRxuz4KCymxsaZ50zNLX
   3D1Yk4pWCqB+m9gjuzu6LGQt6SKCuEqZ5RpYyfWWigPbucpRU35QYt2/p
   Q4nF9qpcaH8HAU97IjWkLqI2aKG0aWm05GoBz+AbLhl5EODys7ZNPkd+Z
   wFF/AsQMCQ8PzdeYGwxhuc6ZZ7ZcmhD5vag552I36C71wUnu7+z7o+s/d
   ASby8LgJgBPWNYK/k2+x0UiStjTkrJ4U3tymfDrP6CEQKAMXy1UgcFMyW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="361303656"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="361303656"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 11:20:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="986772579"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="986772579"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Sep 2023 11:20:49 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qc8lD-0001Xj-2f;
        Fri, 01 Sep 2023 18:20:47 +0000
Date:   Sat, 02 Sep 2023 02:19:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 18032b47adf1db7b7f5fb2d1344e65aafe6417df
Message-ID: <202309020254.gOHfwP2X-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 18032b47adf1db7b7f5fb2d1344e65aafe6417df  x86/fpu/xstate: Fix PKRU covert channel

elapsed time: 1246m

configs tested: 61
configs skipped: 132

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230901   clang
i386         buildonly-randconfig-002-20230901   clang
i386         buildonly-randconfig-003-20230901   clang
i386         buildonly-randconfig-004-20230901   clang
i386         buildonly-randconfig-005-20230901   clang
i386         buildonly-randconfig-006-20230901   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230901   clang
i386                  randconfig-002-20230901   clang
i386                  randconfig-003-20230901   clang
i386                  randconfig-004-20230901   clang
i386                  randconfig-005-20230901   clang
i386                  randconfig-006-20230901   clang
i386                  randconfig-011-20230901   gcc  
i386                  randconfig-012-20230901   gcc  
i386                  randconfig-013-20230901   gcc  
i386                  randconfig-014-20230901   gcc  
i386                  randconfig-015-20230901   gcc  
i386                  randconfig-016-20230901   gcc  
i386                 randconfig-r011-20230901   gcc  
loongarch             randconfig-001-20230902   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230901   clang
x86_64       buildonly-randconfig-002-20230901   clang
x86_64       buildonly-randconfig-003-20230901   clang
x86_64       buildonly-randconfig-004-20230901   clang
x86_64       buildonly-randconfig-005-20230901   clang
x86_64       buildonly-randconfig-006-20230901   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230901   gcc  
x86_64                randconfig-002-20230901   gcc  
x86_64                randconfig-003-20230901   gcc  
x86_64                randconfig-004-20230901   gcc  
x86_64                randconfig-005-20230901   gcc  
x86_64                randconfig-006-20230901   gcc  
x86_64                randconfig-011-20230901   clang
x86_64                randconfig-012-20230901   clang
x86_64                randconfig-013-20230901   clang
x86_64                randconfig-014-20230901   clang
x86_64                randconfig-015-20230901   clang
x86_64                randconfig-016-20230901   clang
x86_64                randconfig-071-20230901   clang
x86_64                randconfig-072-20230901   clang
x86_64                randconfig-073-20230901   clang
x86_64                randconfig-074-20230901   clang
x86_64                randconfig-075-20230901   clang
x86_64                randconfig-076-20230901   clang
x86_64               randconfig-r013-20230901   gcc  
x86_64               randconfig-r015-20230901   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
