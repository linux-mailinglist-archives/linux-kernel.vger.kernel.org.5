Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D73A7A59AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjISGEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjISGES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:04:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D773FC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 23:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695103452; x=1726639452;
  h=date:from:to:cc:subject:message-id;
  bh=XpENHa49qGi1Ok9KYty8OuWcNLJf2qnUagAnJdEs1Ls=;
  b=L3HG7MfZypZtgTGTMBuuksn+DcaYhNUt1PPpXvk8l0Kk0oyfwAiDjAzF
   43mlMMF3q7muubydQvb0UNLjNhWSm7hyA1Uq34u4+dba5xGJZAXiBA54h
   cjxVPlNFlgoKvKqkxwy5PC2eGxt7lRIzeMizoILEA4KyAIC2JCl35Bm4o
   WRXo7m/Oyn2uPKzTynE99GDd2vGJ2WdGgtS07FbaLMqEZfNqmYhHuCEbD
   W+o4tIJP01bqK7hv4BUeBVAKhw8k2emrWVlDX74iclkf+K79RUae5qefr
   qNXFfUj+foxo+AhIeh788MQC/7fDnxJEJh1czuyHTF6ibTkyfwE/M1q8x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="370175531"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="370175531"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 23:04:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="889382743"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="889382743"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 18 Sep 2023 23:03:25 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qiTqC-0006yd-1b;
        Tue, 19 Sep 2023 06:04:08 +0000
Date:   Tue, 19 Sep 2023 14:02:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 10f4c9b9a33b7df000f74fa0d896351fb1a61e6a
Message-ID: <202309191450.kyqLWzMy-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 10f4c9b9a33b7df000f74fa0d896351fb1a61e6a  x86/asm: Fix build of UML with KASAN

elapsed time: 722m

configs tested: 52
configs skipped: 111

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230919   gcc  
i386         buildonly-randconfig-002-20230919   gcc  
i386         buildonly-randconfig-003-20230919   gcc  
i386         buildonly-randconfig-004-20230919   gcc  
i386         buildonly-randconfig-005-20230919   gcc  
i386         buildonly-randconfig-006-20230919   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230919   gcc  
i386                  randconfig-002-20230919   gcc  
i386                  randconfig-003-20230919   gcc  
i386                  randconfig-004-20230919   gcc  
i386                  randconfig-005-20230919   gcc  
i386                  randconfig-006-20230919   gcc  
i386                  randconfig-011-20230919   gcc  
i386                  randconfig-012-20230919   gcc  
i386                  randconfig-013-20230919   gcc  
i386                  randconfig-014-20230919   gcc  
i386                  randconfig-015-20230919   gcc  
i386                  randconfig-016-20230919   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230919   gcc  
x86_64       buildonly-randconfig-002-20230919   gcc  
x86_64       buildonly-randconfig-003-20230919   gcc  
x86_64       buildonly-randconfig-004-20230919   gcc  
x86_64       buildonly-randconfig-005-20230919   gcc  
x86_64       buildonly-randconfig-006-20230919   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230919   gcc  
x86_64                randconfig-002-20230919   gcc  
x86_64                randconfig-003-20230919   gcc  
x86_64                randconfig-004-20230919   gcc  
x86_64                randconfig-005-20230919   gcc  
x86_64                randconfig-006-20230919   gcc  
x86_64                randconfig-011-20230919   gcc  
x86_64                randconfig-012-20230919   gcc  
x86_64                randconfig-013-20230919   gcc  
x86_64                randconfig-014-20230919   gcc  
x86_64                randconfig-015-20230919   gcc  
x86_64                randconfig-016-20230919   gcc  
x86_64                randconfig-071-20230919   gcc  
x86_64                randconfig-072-20230919   gcc  
x86_64                randconfig-073-20230919   gcc  
x86_64                randconfig-074-20230919   gcc  
x86_64                randconfig-075-20230919   gcc  
x86_64                randconfig-076-20230919   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
