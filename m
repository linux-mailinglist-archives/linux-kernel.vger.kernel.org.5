Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B55751363
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjGLWMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjGLWMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:12:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90C1C0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689199934; x=1720735934;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AXuCFZ7a/7670YV5vRY/iDSe0Xk86wjQk/YTfI6HqNc=;
  b=MXbwZt2Zj5Uor8iLnQPEFQ/mXQwS0RQLYd7MSZLLCqGVG/05FiMQ1999
   B/HAbWwHaCUNxz0TYXoqJ40r8pqlnxQ+dnZnv+4jOHI8s3OT3l9eO4NuC
   5V0Z/fg7soOek0TWxpjhJV881qAnCzsVy0Z5im2MWDu7K9zVx08QprqAQ
   qcQXe2SAR2s51cnRcS7+Q4cFk1L7durq+ysZdqx5LlxwrXc1AqVRieGgr
   hCjAwfJwhyql9LRVCqreEil4CDOhHXGu6QcKefEVin9mh8EYOQzeBdVP0
   euCg/w0gcPhUXAA0KVKA/T831ux8zDHV8ciEA/AIQ3iaGMo49IwOYpjzZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="431165951"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="431165951"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 15:12:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="895759840"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="895759840"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 Jul 2023 15:12:08 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJi47-00060z-2C;
        Wed, 12 Jul 2023 22:12:07 +0000
Date:   Thu, 13 Jul 2023 06:11:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230712 2/7]
 arch/sparc/mm/init_64.c:3057:31: error: array subscript -1 is outside array
 bounds of 'char[]'
Message-ID: <202307130628.xn3HZQKC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230712
head:   88351e5cbaffd248445e625adc8f97b5850eac0a
commit: 33815aa60d00d90040db22c11152fea0bd69532b [2/7] Makefile: Enable -Warray-bounds
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230713/202307130628.xn3HZQKC-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230713/202307130628.xn3HZQKC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307130628.xn3HZQKC-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/sparc/mm/init_64.c: In function 'arch_hugetlb_valid_size':
   arch/sparc/mm/init_64.c:355:24: error: variable 'hv_pgsz_idx' set but not used [-Werror=unused-but-set-variable]
     355 |         unsigned short hv_pgsz_idx;
         |                        ^~~~~~~~~~~
   arch/sparc/mm/init_64.c: At top level:
   arch/sparc/mm/init_64.c:2630:6: error: no previous prototype for 'vmemmap_free' [-Werror=missing-prototypes]
    2630 | void vmemmap_free(unsigned long start, unsigned long end,
         |      ^~~~~~~~~~~~
   In function 'kernel_lds_init',
       inlined from 'report_memory' at arch/sparc/mm/init_64.c:3069:2:
>> arch/sparc/mm/init_64.c:3057:31: error: array subscript -1 is outside array bounds of 'char[]' [-Werror=array-bounds]
    3057 |         code_resource.end   = compute_kern_paddr(_etext - 1);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/sparc/include/asm/sections.h:6,
                    from include/linux/interrupt.h:21,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/hugetlb.h:10,
                    from arch/sparc/mm/init_64.c:16:
   include/asm-generic/sections.h: In function 'report_memory':
   include/asm-generic/sections.h:35:32: note: at offset -1 into object '_etext' of size [0, 9223372036854775807]
      35 | extern char _text[], _stext[], _etext[];
         |                                ^~~~~~
   In function 'kernel_lds_init',
       inlined from 'report_memory' at arch/sparc/mm/init_64.c:3069:2:
   arch/sparc/mm/init_64.c:3059:31: error: array subscript -1 is outside array bounds of 'char[]' [-Werror=array-bounds]
    3059 |         data_resource.end   = compute_kern_paddr(_edata - 1);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/sections.h: In function 'report_memory':
   include/asm-generic/sections.h:36:32: note: at offset -1 into object '_edata' of size [0, 9223372036854775807]
      36 | extern char _data[], _sdata[], _edata[];
         |                                ^~~~~~
   In function 'kernel_lds_init',
       inlined from 'report_memory' at arch/sparc/mm/init_64.c:3069:2:
   arch/sparc/mm/init_64.c:3061:31: error: array subscript -1 is outside array bounds of 'char[]' [-Werror=array-bounds]
    3061 |         bss_resource.end    = compute_kern_paddr(_end - 1);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/sections.h: In function 'report_memory':
   include/asm-generic/sections.h:41:13: note: at offset -1 into object '_end' of size [0, 9223372036854775807]
      41 | extern char _end[];
         |             ^~~~
   cc1: all warnings being treated as errors


vim +3057 arch/sparc/mm/init_64.c

f6d4fb5cc0475c3 bob picco 2014-03-03  3053  
f6d4fb5cc0475c3 bob picco 2014-03-03  3054  static void __init kernel_lds_init(void)
f6d4fb5cc0475c3 bob picco 2014-03-03  3055  {
f6d4fb5cc0475c3 bob picco 2014-03-03  3056  	code_resource.start = compute_kern_paddr(_text);
f6d4fb5cc0475c3 bob picco 2014-03-03 @3057  	code_resource.end   = compute_kern_paddr(_etext - 1);
f6d4fb5cc0475c3 bob picco 2014-03-03  3058  	data_resource.start = compute_kern_paddr(_etext);
f6d4fb5cc0475c3 bob picco 2014-03-03  3059  	data_resource.end   = compute_kern_paddr(_edata - 1);
f6d4fb5cc0475c3 bob picco 2014-03-03  3060  	bss_resource.start  = compute_kern_paddr(__bss_start);
f6d4fb5cc0475c3 bob picco 2014-03-03  3061  	bss_resource.end    = compute_kern_paddr(_end - 1);
f6d4fb5cc0475c3 bob picco 2014-03-03  3062  }
f6d4fb5cc0475c3 bob picco 2014-03-03  3063  

:::::: The code at line 3057 was first introduced by commit
:::::: f6d4fb5cc0475c36437a618db31cbb7f2bf7c282 sparc64 - add mem to iomem resource

:::::: TO: bob picco <bpicco@meloft.net>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
