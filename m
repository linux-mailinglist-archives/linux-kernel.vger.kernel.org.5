Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9946E7F3B50
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343491AbjKVB3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbjKVB3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:29:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DC291
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700616572; x=1732152572;
  h=date:from:to:cc:subject:message-id;
  bh=yHs6D55J2uukJQ61JP1HlgZ+0Cj1ClrquimYdi3UsBc=;
  b=I1P4cR0jOv80GHay+gEXApr+eJccbjV4K30xe8DhM5Zoind4TqvQbfxR
   5O9AI6CZTPDpOOCS+nMyxShDvWw2uhB06sV1LDUgfvgPdQEbqxSnwr3nX
   /z3Xnr4J8+DhgST9o2eiu/qlpQWk5t4dap9RrnLird4i5Jb2uowAQRZMd
   BaKFB2u4oGqVvseWkSbDaerwELo4K59cPQ/xelkfXaFFcnzjZkjTda68Z
   gTsMnznZESR1aw6iMkgLfexib+Fg5aNeltkGwjmB/urYygHvWNtL/r26U
   yiyIUz1HnGAxsLMsvv24UcxeeAogqj7ae7Aueh1oSgWl0YaEgzmgkNwS4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="478166583"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="478166583"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 17:29:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="910634114"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="910634114"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2023 17:29:30 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5c3R-0008Ug-0O;
        Wed, 22 Nov 2023 01:29:25 +0000
Date:   Wed, 22 Nov 2023 09:28:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 e8df9d9f4209c04161321d8c12640ae560f65939
Message-ID: <202311220928.Ym3dReAH-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: e8df9d9f4209c04161321d8c12640ae560f65939  perf/x86/intel: Correct incorrect 'or' operation for PMU capabilities

elapsed time: 736m

configs tested: 38
configs skipped: 136

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231122   clang
i386         buildonly-randconfig-002-20231122   clang
i386         buildonly-randconfig-003-20231122   clang
i386         buildonly-randconfig-004-20231122   clang
i386         buildonly-randconfig-005-20231122   clang
i386         buildonly-randconfig-006-20231122   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231122   clang
i386                  randconfig-002-20231122   clang
i386                  randconfig-003-20231122   clang
i386                  randconfig-004-20231122   clang
i386                  randconfig-005-20231122   clang
i386                  randconfig-006-20231122   clang
i386                  randconfig-011-20231122   gcc  
i386                  randconfig-012-20231122   gcc  
i386                  randconfig-013-20231122   gcc  
i386                  randconfig-014-20231122   gcc  
i386                  randconfig-015-20231122   gcc  
i386                  randconfig-016-20231122   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231122   clang
x86_64       buildonly-randconfig-002-20231122   clang
x86_64       buildonly-randconfig-003-20231122   clang
x86_64       buildonly-randconfig-004-20231122   clang
x86_64       buildonly-randconfig-005-20231122   clang
x86_64       buildonly-randconfig-006-20231122   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231122   gcc  
x86_64                randconfig-002-20231122   gcc  
x86_64                randconfig-003-20231122   gcc  
x86_64                randconfig-004-20231122   gcc  
x86_64                randconfig-005-20231122   gcc  
x86_64                randconfig-006-20231122   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
