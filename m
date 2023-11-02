Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2705E7DF4BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376703AbjKBOQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjKBOQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:16:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081D8B7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698934607; x=1730470607;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IxweHQehCYDnNEG751FMSRLjQEB5hRmVTBoUdA7XCXU=;
  b=Q2E2xqXH/cpdkG+uWBz+MBVccMMHJqHtnRc076sDbTpN624kuJ/CliOV
   MP7BVcXrP/t1I/jIwsA/QAqYw8GI7Ydqnan2W6cIfQVOhjkvh6uAKSp8h
   i195rHz/6XfSau73GNvg1Bltnh3WRURGTzMo1SRx4XObCd48u9rOgHBfb
   +pJTrpWHFTFtaM1VEhbsBJISbWrEQAmf8aq6U2rLK8KQiFjCJjVPZPSyE
   7vkM5zdSXQsAcsTTiZmequeMlg36AJ8bGzKNiyNFE/ASHKNUPX+H51uaw
   ipBg0vxQ8ATQxJFnPmA6ZtWNpt+/ihasZujez9OtcfGFPih6Z0CksXiFP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="7361184"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="7361184"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 07:16:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="2553271"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 02 Nov 2023 07:16:33 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyYUp-0001Vs-04;
        Thu, 02 Nov 2023 14:16:31 +0000
Date:   Thu, 2 Nov 2023 22:15:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/nios2/include/asm/checksum.h:30:24: sparse: sparse: restricted
 __wsum degrades to integer
Message-ID: <202311022246.5tfOUz5a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
commit: b38460bc463c54e0c15ff3b37e81f7e2059bb9bb kunit: Fix checksum tests on big endian CPUs
date:   10 weeks ago
config: nios2-randconfig-r121-20231102 (https://download.01.org/0day-ci/archive/20231102/202311022246.5tfOUz5a-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231102/202311022246.5tfOUz5a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311022246.5tfOUz5a-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   lib/checksum_kunit.c: note: in included file:
>> arch/nios2/include/asm/checksum.h:30:24: sparse: sparse: restricted __wsum degrades to integer
>> arch/nios2/include/asm/checksum.h:30:24: sparse: sparse: restricted __wsum degrades to integer
>> arch/nios2/include/asm/checksum.h:30:24: sparse: sparse: restricted __wsum degrades to integer
>> arch/nios2/include/asm/checksum.h:30:24: sparse: sparse: restricted __wsum degrades to integer
>> arch/nios2/include/asm/checksum.h:30:24: sparse: sparse: restricted __wsum degrades to integer

vim +30 arch/nios2/include/asm/checksum.h

eea9507a69d637 Ley Foon Tan 2014-11-06  17  
eea9507a69d637 Ley Foon Tan 2014-11-06  18  /*
eea9507a69d637 Ley Foon Tan 2014-11-06  19   * Fold a partial checksum
eea9507a69d637 Ley Foon Tan 2014-11-06  20   */
eea9507a69d637 Ley Foon Tan 2014-11-06  21  static inline __sum16 csum_fold(__wsum sum)
eea9507a69d637 Ley Foon Tan 2014-11-06  22  {
eea9507a69d637 Ley Foon Tan 2014-11-06  23  	__asm__ __volatile__(
eea9507a69d637 Ley Foon Tan 2014-11-06  24  		"add	%0, %1, %0\n"
eea9507a69d637 Ley Foon Tan 2014-11-06  25  		"cmpltu	r8, %0, %1\n"
eea9507a69d637 Ley Foon Tan 2014-11-06  26  		"srli	%0, %0, 16\n"
eea9507a69d637 Ley Foon Tan 2014-11-06  27  		"add	%0, %0, r8\n"
eea9507a69d637 Ley Foon Tan 2014-11-06  28  		"nor	%0, %0, %0\n"
eea9507a69d637 Ley Foon Tan 2014-11-06  29  		: "=r" (sum)
eea9507a69d637 Ley Foon Tan 2014-11-06 @30  		: "r" (sum << 16), "0" (sum)
eea9507a69d637 Ley Foon Tan 2014-11-06  31  		: "r8");
eea9507a69d637 Ley Foon Tan 2014-11-06  32  	return (__force __sum16) sum;
eea9507a69d637 Ley Foon Tan 2014-11-06  33  }
eea9507a69d637 Ley Foon Tan 2014-11-06  34  

:::::: The code at line 30 was first introduced by commit
:::::: eea9507a69d637d52705de8703b168bf6bfe5643 nios2: Library functions

:::::: TO: Ley Foon Tan <lftan@altera.com>
:::::: CC: Ley Foon Tan <lftan@altera.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
