Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE41E7A0FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjINVO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjINVOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:14:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F2E2701
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694726091; x=1726262091;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hkWtUfTAxdIrSqq1awMLE7yMnKtLzTILGkKcxB7uy2M=;
  b=bEP11t3CC6Ce7mrekPo1ZVQlpf7ukBF8CpMMq9+sUoYwPErNCO2fcOYX
   SzNVG8eoT1KeicRXiZhrvf3GfZwjQ8XsbzA4O8L+p8Qa4GpMxLoSU9211
   4wy0w8VsbvIHqMDrnzKI1+8VnbauRZcBq64unehQrZzRR4B/6Cw2bqJfN
   g0dDSGtlsAzTyF/Yg7m4a4nZMIgQNJ8jWw2V1DzpBLRI4zGZeqik3CYPw
   kc4JP2iyG2tPmqVbOmETJCqHXYilA26679tBq0KLMqwB2y8dwkL8LA+SG
   CtxqqVgI9eN2wu+scjQMJOOzX4UXX02w7YOLmw7W+Mlga+4n49reFo42u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="378998337"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="378998337"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 14:14:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="918383233"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="918383233"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 14 Sep 2023 14:14:50 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgtfj-000253-2e;
        Thu, 14 Sep 2023 21:14:47 +0000
Date:   Fri, 15 Sep 2023 05:14:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/xtensa/lib/umulsidi3.S:18:7: warning: "XCHAL_NO_MUL" is not
 defined, evaluates to 0
Message-ID: <202309150556.t0yCdv3g-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9fdfb15a3dbf818e06be514f4abbfc071004cbe7
commit: 8939c58d68f97ce530f02d46c9f2b56c3ec88399 xtensa: add __umulsidi3 helper
date:   9 months ago
config: xtensa-randconfig-001-20230914 (https://download.01.org/0day-ci/archive/20230915/202309150556.t0yCdv3g-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230915/202309150556.t0yCdv3g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309150556.t0yCdv3g-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/xtensa/lib/umulsidi3.S:18:7: warning: "XCHAL_NO_MUL" is not defined, evaluates to 0 [-Wundef]
      18 | #elif XCHAL_NO_MUL
         |       ^~~~~~~~~~~~
   arch/xtensa/lib/umulsidi3.S:159:5: warning: "XCHAL_NO_MUL" is not defined, evaluates to 0 [-Wundef]
     159 | #if XCHAL_NO_MUL
         |     ^~~~~~~~~~~~


vim +/XCHAL_NO_MUL +18 arch/xtensa/lib/umulsidi3.S

    11	
    12	#ifdef __XTENSA_CALL0_ABI__
    13		abi_entry(32)
    14		s32i	a12, sp, 16
    15		s32i	a13, sp, 20
    16		s32i	a14, sp, 24
    17		s32i	a15, sp, 28
  > 18	#elif XCHAL_NO_MUL
    19		/* This is not really a leaf function; allocate enough stack space
    20		   to allow CALL12s to a helper function.  */
    21		abi_entry(32)
    22	#else
    23		abi_entry_default
    24	#endif
    25	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
