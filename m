Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B27A7EA567
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 22:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjKMVWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 16:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKMVWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 16:22:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D8BB8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 13:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699910519; x=1731446519;
  h=date:from:to:cc:subject:message-id;
  bh=n6UvnC/OL6brsgxTiWESQ+3Nv32aJ3eNFZUzz7qvcrc=;
  b=H/3Yrxy9vUxwJK769cAWljWc0lZBYp/3tP3QvObAjdho4iyHSEhXw9TG
   wVilBjphmG9boMLnKOnF5IuRKlwyFTqmOJVUnxbR7Dtd/XvkNkwF3UUqH
   Jq+5z72ypwS9P4lwrR+FY4ujiJ2KKF3W6XCdlZSzVkyZVcXfRw1sWUoOb
   WzmvavBkwGZGtFYlHn8yloptEainAw6Z23xax68wNuWISocCF89aj85kk
   5nmRY8w7bhy6U8gHv/hI2iEAaX0lsCFaXdI85DMauHg10CEE8+lSQ4z9p
   fUT7+S95I1sBWrWdoSned2dxwHH6sYpgpkRjY9aYQS5fphyntYaS6Lpb3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="370710130"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="370710130"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 13:21:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="714336363"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="714336363"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 13 Nov 2023 13:21:57 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r2eNX-000CVn-0N;
        Mon, 13 Nov 2023 21:21:55 +0000
Date:   Tue, 14 Nov 2023 05:21:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 04c3024560d3a14acd18d0a51a1d0a89d29b7eb5
Message-ID: <202311140535.r8sx3aju-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 04c3024560d3a14acd18d0a51a1d0a89d29b7eb5  x86/barrier: Do not serialize MSR accesses on AMD

elapsed time: 723m

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
