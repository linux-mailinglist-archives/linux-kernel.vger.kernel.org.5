Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF127EA568
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 22:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjKMVWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 16:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjKMVWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 16:22:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D50D5F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 13:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699910518; x=1731446518;
  h=date:from:to:cc:subject:message-id;
  bh=NLqRSoS/2QcEx55fT+Ohzx64MJjlTAX6aJsRu72v8H8=;
  b=VTPKqtAt/7r27TZC54aTrv0vhSnoXvy34K5K8XMblLBqBbRMrbwAkcFF
   RmmGb/O5oqcHDtyjlIRXGgkVcrsrmzqBNlvfACCxxFkGZdepwZS43ZYb3
   OB74xU3fC+jPuVNvvFYCnHeGU00kGs1eSssgBAZRqNYgad4dNhIPGoQui
   B6Hp0wyJln2J677wSvvoWZCTb/LArXEeIvC33EFctloAg18EBqUR6/Cyq
   TuFKEN1dDzaHDXaOeHtPFzn98rVDn4cJ3BYcF7uT1DFkVwG1vjaqIQp6Q
   qON3c9Zfok2MMb4rlxsZXB0seWdqZGsEh2YtB7wxM+t5SIAj5RIOqhHC5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="389376982"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="389376982"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 13:21:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="834817702"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="834817702"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 13 Nov 2023 13:21:57 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r2eNX-000CVk-0B;
        Mon, 13 Nov 2023 21:21:55 +0000
Date:   Tue, 14 Nov 2023 05:21:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 9f3b130048bfa2e44a8cfb1b616f826d9d5d8188
Message-ID: <202311140528.HVsVL7XL-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 9f3b130048bfa2e44a8cfb1b616f826d9d5d8188  x86/mce: Mark fatal MCE's page as poison to avoid panic in the kdump kernel

elapsed time: 724m

configs tested: 51
configs skipped: 142

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231113   gcc  
i386         buildonly-randconfig-002-20231113   gcc  
i386         buildonly-randconfig-003-20231113   gcc  
i386         buildonly-randconfig-004-20231113   gcc  
i386         buildonly-randconfig-005-20231113   gcc  
i386         buildonly-randconfig-006-20231113   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231113   gcc  
i386                  randconfig-002-20231113   gcc  
i386                  randconfig-003-20231113   gcc  
i386                  randconfig-004-20231113   gcc  
i386                  randconfig-005-20231113   gcc  
i386                  randconfig-006-20231113   gcc  
i386                  randconfig-011-20231113   gcc  
i386                  randconfig-012-20231113   gcc  
i386                  randconfig-013-20231113   gcc  
i386                  randconfig-014-20231113   gcc  
i386                  randconfig-015-20231113   gcc  
i386                  randconfig-016-20231113   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231113   gcc  
x86_64       buildonly-randconfig-002-20231113   gcc  
x86_64       buildonly-randconfig-003-20231113   gcc  
x86_64       buildonly-randconfig-004-20231113   gcc  
x86_64       buildonly-randconfig-005-20231113   gcc  
x86_64       buildonly-randconfig-006-20231113   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231113   gcc  
x86_64                randconfig-002-20231113   gcc  
x86_64                randconfig-003-20231113   gcc  
x86_64                randconfig-004-20231113   gcc  
x86_64                randconfig-005-20231113   gcc  
x86_64                randconfig-006-20231113   gcc  
x86_64                randconfig-011-20231113   gcc  
x86_64                randconfig-012-20231113   gcc  
x86_64                randconfig-013-20231113   gcc  
x86_64                randconfig-014-20231113   gcc  
x86_64                randconfig-015-20231113   gcc  
x86_64                randconfig-016-20231113   gcc  
x86_64                randconfig-071-20231113   gcc  
x86_64                randconfig-072-20231113   gcc  
x86_64                randconfig-073-20231113   gcc  
x86_64                randconfig-074-20231113   gcc  
x86_64                randconfig-075-20231113   gcc  
x86_64                randconfig-076-20231113   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
