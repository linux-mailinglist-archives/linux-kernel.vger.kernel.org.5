Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1A381239A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbjLMX5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjLMX5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:57:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D1F9C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702511837; x=1734047837;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9RisqlQfkD94FUbVA8qz9zvfpbYwCG0HlGt8mGku71s=;
  b=RO7iVEb+TxZcVFDo3Fw4adjAxsDiD+2LzYLwJ7uSiXCR/gWcO7X36drb
   NmYZpEpzKV5C3WQgnFgweDqC70aQxi/tkF+o8tXmlHuHdWVR7xt7LP/IS
   2Ph2lhSc6mfQUABQ66CeHvKZ8qMTZyDC6G9pmesi2C/NL9u2D/hMCozV6
   h976zJz8LoyAAD4N+R0SZ4GbEk19N9PBNsuliHa2w1fDlT8C3zTO+0vIq
   zD4heQkbHBrkjXM6R5k3R1w6mZ1pfrm99RnbxRaBzIHGjLbZDvSfjGRSr
   j3lAhFhRw+WmZI38h5TkJyKilL+6LWXvK0Qdsvj7zwEi7UdlBviaGWdR3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="459365781"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="459365781"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:57:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="723848776"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="723848776"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 13 Dec 2023 15:57:15 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDZ6H-000LIe-2B;
        Wed, 13 Dec 2023 23:57:13 +0000
Date:   Thu, 14 Dec 2023 07:56:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arc/include/asm/checksum.h:27:26: sparse: sparse: restricted
 __wsum degrades to integer
Message-ID: <202312140758.j0bflCSo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: b38460bc463c54e0c15ff3b37e81f7e2059bb9bb kunit: Fix checksum tests on big endian CPUs
date:   4 months ago
config: arc-randconfig-r121-20231111 (https://download.01.org/0day-ci/archive/20231214/202312140758.j0bflCSo-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231214/202312140758.j0bflCSo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312140758.j0bflCSo-lkp@intel.com/

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
