Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A49B7899E0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 01:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjHZXps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 19:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHZXpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 19:45:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEE01B3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 16:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693093522; x=1724629522;
  h=date:from:to:cc:subject:message-id;
  bh=H0xAiQmVEuPkES1z2d4ssNijDqkRBcET5m7/LTIL7as=;
  b=PUdh4hyU6KmnF6NHT+Svzi0WnioTFmCScI4M+KPl3E9K4T0iC5H5JlTy
   IgN6kJZcRBu6RSPwhOkW3qKxrQ0PcOJ53ks4RX2apuysWmx3ArabuFUZI
   v6eVzCIsBeO/F8WKfr70A/kT5swko7vs9JrFX4ktGs6A6GdP3P4QmP7Wr
   dAgji+Pxo68DeNo/o/FTH51QZzjhGq90lTe1vmIUxtEwpEXIOGVOEkTXb
   l8u8WiWRpwqPTpSt9BLuIAU/izvhrgsXn2B5GudQ7lbhlVRTBxk2iAdOu
   aZM1Et8BDWLAFVwomrp+2KMwCi+K1r7WCUD/9Cxxretmtf8B/17oPOCY7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="355237254"
X-IronPort-AV: E=Sophos;i="6.02,204,1688454000"; 
   d="scan'208";a="355237254"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2023 16:45:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="737848567"
X-IronPort-AV: E=Sophos;i="6.02,204,1688454000"; 
   d="scan'208";a="737848567"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 26 Aug 2023 16:45:21 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qa2y0-0005BJ-2H;
        Sat, 26 Aug 2023 23:45:20 +0000
Date:   Sun, 27 Aug 2023 07:44:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 212f07a21622cbd4bb271b558b2d3ae0652e9875
Message-ID: <202308270752.WsInp0kx-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 212f07a21622cbd4bb271b558b2d3ae0652e9875  x86/platform/uv: Refactor code using deprecated strncpy() interface to use strscpy()

elapsed time: 3087m

configs tested: 47
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386         buildonly-randconfig-001-20230825   clang
i386         buildonly-randconfig-002-20230825   clang
i386         buildonly-randconfig-003-20230825   clang
i386         buildonly-randconfig-004-20230825   clang
i386         buildonly-randconfig-005-20230825   clang
i386         buildonly-randconfig-006-20230825   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20230825   clang
i386                  randconfig-002-20230825   clang
i386                  randconfig-003-20230825   clang
i386                  randconfig-004-20230825   clang
i386                  randconfig-005-20230825   clang
i386                  randconfig-006-20230825   clang
i386                  randconfig-011-20230825   gcc  
i386                  randconfig-012-20230825   gcc  
i386                  randconfig-013-20230825   gcc  
i386                  randconfig-014-20230825   gcc  
i386                  randconfig-015-20230825   gcc  
i386                  randconfig-016-20230825   gcc  
x86_64                            allnoconfig   gcc  
x86_64       buildonly-randconfig-001-20230825   clang
x86_64       buildonly-randconfig-002-20230825   clang
x86_64       buildonly-randconfig-003-20230825   clang
x86_64       buildonly-randconfig-004-20230825   clang
x86_64       buildonly-randconfig-005-20230825   clang
x86_64       buildonly-randconfig-006-20230825   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230825   gcc  
x86_64                randconfig-002-20230825   gcc  
x86_64                randconfig-003-20230825   gcc  
x86_64                randconfig-004-20230825   gcc  
x86_64                randconfig-005-20230825   gcc  
x86_64                randconfig-006-20230825   gcc  
x86_64                randconfig-011-20230825   clang
x86_64                randconfig-012-20230825   clang
x86_64                randconfig-013-20230825   clang
x86_64                randconfig-014-20230825   clang
x86_64                randconfig-015-20230825   clang
x86_64                randconfig-016-20230825   clang
x86_64                randconfig-071-20230825   clang
x86_64                randconfig-072-20230825   clang
x86_64                randconfig-073-20230825   clang
x86_64                randconfig-074-20230825   clang
x86_64                randconfig-075-20230825   clang
x86_64                randconfig-076-20230825   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
