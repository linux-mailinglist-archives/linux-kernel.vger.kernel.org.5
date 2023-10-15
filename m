Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708C07C97C3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 05:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjJODgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 23:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjJODga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 23:36:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A338A6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 20:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697340989; x=1728876989;
  h=date:from:to:cc:subject:message-id;
  bh=aWaa/NhKGly54WKVGz6d44oNGZgU1ey/vuZseCVooT0=;
  b=Qpsa0bdlP8DK9voH5gDwHQZc2sxyPY3KQl4SKFLEww+z9c+PsXBJ699+
   yIb272QJan2KKZCer+nAyqpn4rhZh9NEyQUZ9wHx2QB4y/gWuj4RYtxRv
   CsyeJXj4CyPFQXmOXcGM0Jkn31gx/xB8WIf2wa/tkVZTCYQgOurDPMCvg
   zp1Mo0Ghdgrzl1cR4eqodk4j7IjE66Z4KCRjJl/H24MaHhZfKfVKDY08r
   9i5BWphD1lRfi0rN8znpXB2tsZ7XGZ4lmUvXVgkzGNUp64Obwqg6P6MyB
   gb6xlLhWb2n1Ll7NbiMz0ugykQisTEYal1lpetbDVBhZwoly9rvsL1fOE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="382591480"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="382591480"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 20:36:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="871627551"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="871627551"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 14 Oct 2023 20:36:27 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qrrvV-0006zp-2B;
        Sun, 15 Oct 2023 03:36:25 +0000
Date:   Sun, 15 Oct 2023 11:35:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 7543365739a4ff61d40ad53ab68c17d2e7dfb0c9
Message-ID: <202310151144.cca28XrW-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 7543365739a4ff61d40ad53ab68c17d2e7dfb0c9  perf/x86/amd/uncore: Fix uninitialized return value in amd_uncore_init()

elapsed time: 2625m

configs tested: 18
configs skipped: 113

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                                defconfig   gcc  
i386                  randconfig-001-20231013   gcc  
i386                  randconfig-002-20231013   gcc  
i386                  randconfig-003-20231013   gcc  
i386                  randconfig-004-20231013   gcc  
i386                  randconfig-005-20231013   gcc  
i386                  randconfig-006-20231013   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231013   gcc  
x86_64                randconfig-002-20231013   gcc  
x86_64                randconfig-003-20231013   gcc  
x86_64                randconfig-004-20231013   gcc  
x86_64                randconfig-005-20231013   gcc  
x86_64                randconfig-006-20231013   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
