Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BEA767BFD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 05:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbjG2Do6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 23:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjG2Do4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 23:44:56 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0CE123;
        Fri, 28 Jul 2023 20:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690602295; x=1722138295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B1tIYUOTE5ds17iq06h6LoUQaptKxSnLkllCbTxj6xk=;
  b=HUNqcYVb/61u460WB/6qjxyJkj3+zWEpbfTz/liGArD/UCj7VOGrVy7D
   oGGt5pLfZHTbFijciakNmkYE+mPKBDv+wP44xzwcs9grLx0LXdzy6WkXv
   UTMTg7f3wZw1IAeHwOjiwWjs09x+NKqJkzTMLU9t7W9xwoUp1g+JK/L9S
   UQAcU9cf25QGJHZ/orGVT8aiqbBQHNmgaaEOhbCDTpm0M8TQ1dWxxKuKP
   T3otV5GIzXcE/vDVTgXb5FhogqUhpwlidYQgvwmU1F3cNz3tKHzLmnYxr
   M2+W4JF3Bs+RFkUsED4tW0kDypYeiAexVNT9aiW9RyFVZRThkTn+fKuBk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="353632110"
X-IronPort-AV: E=Sophos;i="6.01,239,1684825200"; 
   d="scan'208";a="353632110"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 20:44:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="871041149"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jul 2023 20:44:54 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPast-0003nz-37;
        Sat, 29 Jul 2023 03:44:51 +0000
Date:   Sat, 29 Jul 2023 11:44:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincent Donnefort <vdonnefort@google.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, kernel-team@android.com,
        Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v5 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <202307291143.HTPVZOsb-lkp@intel.com>
References: <20230728164754.460767-2-vdonnefort@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728164754.460767-2-vdonnefort@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[cannot apply to rostedt-trace/for-next rostedt-trace/for-next-urgent]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Donnefort/ring-buffer-Introducing-ring-buffer-mapping-functions/20230729-005300
base:   linus/master
patch link:    https://lore.kernel.org/r/20230728164754.460767-2-vdonnefort%40google.com
patch subject: [PATCH v5 1/2] ring-buffer: Introducing ring-buffer mapping functions
config: arm-randconfig-r046-20230728 (https://download.01.org/0day-ci/archive/20230729/202307291143.HTPVZOsb-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307291143.HTPVZOsb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307291143.HTPVZOsb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/arm/include/asm/page.h:193,
                    from arch/arm/include/asm/thread_info.h:14,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/percpu.h:6,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from kernel/trace/ring_buffer.c:7:
   kernel/trace/ring_buffer.c: In function 'rb_free_page_ids':
>> kernel/trace/ring_buffer.c:5946:50: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
    5946 |                 virt_to_page(cpu_buffer->page_ids[i])->mapping = NULL;
         |                              ~~~~~~~~~~~~~~~~~~~~^~~
         |                                                  |
         |                                                  long unsigned int
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   kernel/trace/ring_buffer.c:5946:17: note: in expansion of macro 'virt_to_page'
    5946 |                 virt_to_page(cpu_buffer->page_ids[i])->mapping = NULL;
         |                 ^~~~~~~~~~~~
   In file included from arch/arm/include/asm/page.h:188:
   arch/arm/include/asm/memory.h:296:53: note: expected 'const void *' but argument is of type 'long unsigned int'
     296 | static inline unsigned long virt_to_pfn(const void *p)
         |                                         ~~~~~~~~~~~~^
   kernel/trace/ring_buffer.c: In function 'rb_free_meta_page':
   kernel/trace/ring_buffer.c:5968:22: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
    5968 |         virt_to_page(addr)->mapping = NULL;
         |                      ^~~~
         |                      |
         |                      long unsigned int
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   kernel/trace/ring_buffer.c:5968:9: note: in expansion of macro 'virt_to_page'
    5968 |         virt_to_page(addr)->mapping = NULL;
         |         ^~~~~~~~~~~~
   arch/arm/include/asm/memory.h:296:53: note: expected 'const void *' but argument is of type 'long unsigned int'
     296 | static inline unsigned long virt_to_pfn(const void *p)
         |                                         ~~~~~~~~~~~~^
   kernel/trace/ring_buffer.c: In function 'ring_buffer_map_fault':
   kernel/trace/ring_buffer.c:6156:49: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
    6156 |         return virt_to_page(cpu_buffer->page_ids[pgoff]);
         |                             ~~~~~~~~~~~~~~~~~~~~^~~~~~~
         |                                                 |
         |                                                 long unsigned int
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   kernel/trace/ring_buffer.c:6156:16: note: in expansion of macro 'virt_to_page'
    6156 |         return virt_to_page(cpu_buffer->page_ids[pgoff]);
         |                ^~~~~~~~~~~~
   arch/arm/include/asm/memory.h:296:53: note: expected 'const void *' but argument is of type 'long unsigned int'
     296 | static inline unsigned long virt_to_pfn(const void *p)
         |                                         ~~~~~~~~~~~~^


vim +/virt_to_pfn +5946 kernel/trace/ring_buffer.c

  5940	
  5941	static void rb_free_page_ids(struct ring_buffer_per_cpu *cpu_buffer)
  5942	{
  5943		int i;
  5944	
  5945		for (i = 0; i < cpu_buffer->nr_pages + 1; i++)
> 5946			virt_to_page(cpu_buffer->page_ids[i])->mapping = NULL;
  5947	
  5948		kfree(cpu_buffer->page_ids);
  5949		cpu_buffer->page_ids = NULL;
  5950	}
  5951	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
