Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557FA7E85DF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 23:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjKJWt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 17:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjKJWt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 17:49:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905FF111
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 14:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699656564; x=1731192564;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=98G/EYC0Ltuxon/nzAj/8ahT57j8VJkvjXb/PMLsyIw=;
  b=gcGJHARdXAovsF10eO3N5Qm/ttfw3c+ZBgzw6i3TfwPGq9CO5DiB2gI7
   W6GBOZnIK2bwiOpbHz917pF/xLAouRkXAnu/RTktiV+Hw1MXBVOOjAzaw
   +YYOxdi4OABAutUBBzuCMkvWeU3CweZaAZJLIJe1UB6dnrZj0ij56K9+F
   5PYhKRzhb9yhwZKxfKDTLSWuzpjCKl7OYmLWyGz1sxQY+0ywVLQ3mSkIY
   RvmgTDig6BeOHLAXjfbHRlt6ATQzdM9n1BwI8QvEm5DvvlF8aHi8fPuas
   p3YSi7PO9b0AU2fMldaN2cCU8QTAL7wy8h8LE+kCPLLd7CUF1T7QorWYL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="8889024"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="8889024"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 14:49:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="757306920"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="757306920"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 Nov 2023 14:49:21 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1aJS-0009zV-30;
        Fri, 10 Nov 2023 22:49:18 +0000
Date:   Sat, 11 Nov 2023 06:48:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arc/include/asm/checksum.h:27:26: sparse: sparse: restricted
 __wsum degrades to integer
Message-ID: <202311110638.YiWEivqX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ac347a0655dbc7d885e217c89dddd16e2800bd58
commit: b38460bc463c54e0c15ff3b37e81f7e2059bb9bb kunit: Fix checksum tests on big endian CPUs
date:   3 months ago
config: arc-randconfig-r121-20231111 (https://download.01.org/0day-ci/archive/20231111/202311110638.YiWEivqX-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231111/202311110638.YiWEivqX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311110638.YiWEivqX-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   lib/checksum_kunit.c: note: in included file:
>> arch/arc/include/asm/checksum.h:27:26: sparse: sparse: restricted __wsum degrades to integer
   arch/arc/include/asm/checksum.h:27:36: sparse: sparse: restricted __wsum degrades to integer
>> arch/arc/include/asm/checksum.h:29:11: sparse: sparse: bad assignment (-=) to restricted __wsum
   arch/arc/include/asm/checksum.h:30:16: sparse: sparse: restricted __wsum degrades to integer
>> arch/arc/include/asm/checksum.h:30:18: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __sum16 @@     got unsigned int @@
   arch/arc/include/asm/checksum.h:30:18: sparse:     expected restricted __sum16
   arch/arc/include/asm/checksum.h:30:18: sparse:     got unsigned int
>> arch/arc/include/asm/checksum.h:27:26: sparse: sparse: restricted __wsum degrades to integer
   arch/arc/include/asm/checksum.h:27:36: sparse: sparse: restricted __wsum degrades to integer
>> arch/arc/include/asm/checksum.h:29:11: sparse: sparse: bad assignment (-=) to restricted __wsum
   arch/arc/include/asm/checksum.h:30:16: sparse: sparse: restricted __wsum degrades to integer
>> arch/arc/include/asm/checksum.h:30:18: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __sum16 @@     got unsigned int @@
   arch/arc/include/asm/checksum.h:30:18: sparse:     expected restricted __sum16
   arch/arc/include/asm/checksum.h:30:18: sparse:     got unsigned int
>> arch/arc/include/asm/checksum.h:27:26: sparse: sparse: restricted __wsum degrades to integer
   arch/arc/include/asm/checksum.h:27:36: sparse: sparse: restricted __wsum degrades to integer
>> arch/arc/include/asm/checksum.h:29:11: sparse: sparse: bad assignment (-=) to restricted __wsum
   arch/arc/include/asm/checksum.h:30:16: sparse: sparse: restricted __wsum degrades to integer
>> arch/arc/include/asm/checksum.h:30:18: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __sum16 @@     got unsigned int @@
   arch/arc/include/asm/checksum.h:30:18: sparse:     expected restricted __sum16
   arch/arc/include/asm/checksum.h:30:18: sparse:     got unsigned int
>> arch/arc/include/asm/checksum.h:27:26: sparse: sparse: restricted __wsum degrades to integer
   arch/arc/include/asm/checksum.h:27:36: sparse: sparse: restricted __wsum degrades to integer
>> arch/arc/include/asm/checksum.h:29:11: sparse: sparse: bad assignment (-=) to restricted __wsum
   arch/arc/include/asm/checksum.h:30:16: sparse: sparse: restricted __wsum degrades to integer
>> arch/arc/include/asm/checksum.h:30:18: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __sum16 @@     got unsigned int @@
   arch/arc/include/asm/checksum.h:30:18: sparse:     expected restricted __sum16
   arch/arc/include/asm/checksum.h:30:18: sparse:     got unsigned int
>> arch/arc/include/asm/checksum.h:27:26: sparse: sparse: restricted __wsum degrades to integer
   arch/arc/include/asm/checksum.h:27:36: sparse: sparse: restricted __wsum degrades to integer
>> arch/arc/include/asm/checksum.h:29:11: sparse: sparse: bad assignment (-=) to restricted __wsum
   arch/arc/include/asm/checksum.h:30:16: sparse: sparse: restricted __wsum degrades to integer
>> arch/arc/include/asm/checksum.h:30:18: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __sum16 @@     got unsigned int @@
   arch/arc/include/asm/checksum.h:30:18: sparse:     expected restricted __sum16
   arch/arc/include/asm/checksum.h:30:18: sparse:     got unsigned int

vim +27 arch/arc/include/asm/checksum.h

ca15c8ecd588dd Vineet Gupta 2013-01-18  18  
ca15c8ecd588dd Vineet Gupta 2013-01-18  19  /*
ca15c8ecd588dd Vineet Gupta 2013-01-18  20   *	Fold a partial checksum
ca15c8ecd588dd Vineet Gupta 2013-01-18  21   *
ca15c8ecd588dd Vineet Gupta 2013-01-18  22   *  The 2 swords comprising the 32bit sum are added, any carry to 16th bit
ca15c8ecd588dd Vineet Gupta 2013-01-18  23   *  added back and final sword result inverted.
ca15c8ecd588dd Vineet Gupta 2013-01-18  24   */
ca15c8ecd588dd Vineet Gupta 2013-01-18  25  static inline __sum16 csum_fold(__wsum s)
ca15c8ecd588dd Vineet Gupta 2013-01-18  26  {
d4067395519b40 Jinchao Wang 2021-06-26 @27  	unsigned int r = s << 16 | s >> 16;	/* ror */
ca15c8ecd588dd Vineet Gupta 2013-01-18  28  	s = ~s;
ca15c8ecd588dd Vineet Gupta 2013-01-18 @29  	s -= r;
ca15c8ecd588dd Vineet Gupta 2013-01-18 @30  	return s >> 16;
ca15c8ecd588dd Vineet Gupta 2013-01-18  31  }
ca15c8ecd588dd Vineet Gupta 2013-01-18  32  

:::::: The code at line 27 was first introduced by commit
:::::: d4067395519b40d4ee9b7c26347233e4ae59f900 arc: Prefer unsigned int to bare use of unsigned

:::::: TO: Jinchao Wang <wjc@cdjrlc.com>
:::::: CC: Vineet Gupta <vgupta@synopsys.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
