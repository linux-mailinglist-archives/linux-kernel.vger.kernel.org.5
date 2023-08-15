Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFD277D64A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbjHOWja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbjHOWjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:39:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDB91BCC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692139141; x=1723675141;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6mjwtmEnJtAaYpPPCN0xWMT6+NlKSjDa7K+tWglhnLo=;
  b=Wx7jPtW+6qlYPenaxgaXV4ZQO/FSTySBNeioPMP1VZ5sZtY353nu8G0A
   kOyKwKgZIzKiqG4sRNCLsxKwFWwBBy/xezfrkryJWMrLWPH27K1V58AQA
   ITobQRFplJAxYye6TLMjdA5T2/Bk1RMu6aSDa5xBNPp1z//S2krI3YHEj
   QYkt+swXv0e4IMKjba1hSdaysiEAoq1vCyH0x6m6CqowQn6h6hAAgxWY0
   dw0whq55cJHzrclu9J2gJrP1m0AvIG1PsXS5BjMC9+vIRyhqVvkWIb67h
   dHhdeqeRhuiFqzoilnyTGuQuAThFhaUo8ScAwAh804F93fkkr9a7JYaqk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352719418"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="352719418"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 15:38:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="877517563"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2023 15:38:38 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qW2gL-0001I7-2F;
        Tue, 15 Aug 2023 22:38:33 +0000
Date:   Wed, 16 Aug 2023 06:38:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230815 2/4]
 arch/sparc/mm/init_64.c:3088:31: error: array subscript -1 is outside array
 bounds of 'char[]'
Message-ID: <202308160635.14367Mw4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230815
head:   7d3ebbc1f4bfba0fdd9ade111e93edf6be617187
commit: 79dcfe2fd8c85fe5a9eeb8ed4026d50987d107b5 [2/4] Makefile: Enable -Warray-bounds
config: sparc64-randconfig-r001-20230816 (https://download.01.org/0day-ci/archive/20230816/202308160635.14367Mw4-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230816/202308160635.14367Mw4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308160635.14367Mw4-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/sparc/mm/init_64.c: In function 'sun4v_linear_pte_xor_finalize':
   arch/sparc/mm/init_64.c:2220:23: error: variable 'pagecv_flag' set but not used [-Werror=unused-but-set-variable]
    2220 |         unsigned long pagecv_flag;
         |                       ^~~~~~~~~~~
   arch/sparc/mm/init_64.c: At top level:
   arch/sparc/mm/init_64.c:2644:6: error: no previous prototype for 'vmemmap_free' [-Werror=missing-prototypes]
    2644 | void vmemmap_free(unsigned long start, unsigned long end,
         |      ^~~~~~~~~~~~
   In function 'kernel_lds_init',
       inlined from 'report_memory' at arch/sparc/mm/init_64.c:3100:2:
>> arch/sparc/mm/init_64.c:3088:31: error: array subscript -1 is outside array bounds of 'char[]' [-Werror=array-bounds]
    3088 |         code_resource.end   = compute_kern_paddr(_etext - 1);
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
       inlined from 'report_memory' at arch/sparc/mm/init_64.c:3100:2:
   arch/sparc/mm/init_64.c:3090:31: error: array subscript -1 is outside array bounds of 'char[]' [-Werror=array-bounds]
    3090 |         data_resource.end   = compute_kern_paddr(_edata - 1);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/sections.h: In function 'report_memory':
   include/asm-generic/sections.h:36:32: note: at offset -1 into object '_edata' of size [0, 9223372036854775807]
      36 | extern char _data[], _sdata[], _edata[];
         |                                ^~~~~~
   In function 'kernel_lds_init',
       inlined from 'report_memory' at arch/sparc/mm/init_64.c:3100:2:
   arch/sparc/mm/init_64.c:3092:31: error: array subscript -1 is outside array bounds of 'char[]' [-Werror=array-bounds]
    3092 |         bss_resource.end    = compute_kern_paddr(_end - 1);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/sections.h: In function 'report_memory':
   include/asm-generic/sections.h:41:13: note: at offset -1 into object '_end' of size [0, 9223372036854775807]
      41 | extern char _end[];
         |             ^~~~
   cc1: all warnings being treated as errors


vim +3088 arch/sparc/mm/init_64.c

f6d4fb5cc0475c bob picco 2014-03-03  3084  
f6d4fb5cc0475c bob picco 2014-03-03  3085  static void __init kernel_lds_init(void)
f6d4fb5cc0475c bob picco 2014-03-03  3086  {
f6d4fb5cc0475c bob picco 2014-03-03  3087  	code_resource.start = compute_kern_paddr(_text);
f6d4fb5cc0475c bob picco 2014-03-03 @3088  	code_resource.end   = compute_kern_paddr(_etext - 1);
f6d4fb5cc0475c bob picco 2014-03-03  3089  	data_resource.start = compute_kern_paddr(_etext);
f6d4fb5cc0475c bob picco 2014-03-03  3090  	data_resource.end   = compute_kern_paddr(_edata - 1);
f6d4fb5cc0475c bob picco 2014-03-03  3091  	bss_resource.start  = compute_kern_paddr(__bss_start);
f6d4fb5cc0475c bob picco 2014-03-03  3092  	bss_resource.end    = compute_kern_paddr(_end - 1);
f6d4fb5cc0475c bob picco 2014-03-03  3093  }
f6d4fb5cc0475c bob picco 2014-03-03  3094  

:::::: The code at line 3088 was first introduced by commit
:::::: f6d4fb5cc0475c36437a618db31cbb7f2bf7c282 sparc64 - add mem to iomem resource

:::::: TO: bob picco <bpicco@meloft.net>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
