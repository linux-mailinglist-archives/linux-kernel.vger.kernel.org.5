Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EE879925F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 00:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344138AbjIHWom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 18:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245406AbjIHWok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:44:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AEF1FE3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 15:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694213076; x=1725749076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ig9COPkSQI7Qa5GeNMp1dKZXcUs5jkyJAYheDDXz4oA=;
  b=CPRcNqpUmecQs+rkKaTOxefIAIH/u0MuyXQ6T5phhNQukdGH5qSo4KDl
   lJ8QrIRvF1JEfhi54FjOS6wHyPh96iJM7g+yZ9PvCB2Z1DAmpXKjGflEW
   7tj7dAknog+t6V+SXhQLTiPLN7Vo27jbP3RBQbQlRyc69tX5lBEbCbAJo
   sN2F1AQeiGDHm7yElcGuef2J5W2J7t+KFTON1R1OCBbaYyATiZfyyfsss
   XyFmsBnGGhU4UlDENX4ewdpPy6X9u6oh6ghN8XmEJ6+LeWT8fqwZ7n6ld
   /1utVToirJt9p4dq9BxGUlWM8vSA2ZjkzYoG7NUWpmk4NiGoKaT27zTN2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="357228390"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="357228390"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 15:44:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="692417942"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="692417942"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Sep 2023 15:44:34 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qekDH-0002gj-2H;
        Fri, 08 Sep 2023 22:44:31 +0000
Date:   Sat, 9 Sep 2023 06:43:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Add tlb_flush_threshold for tlb flush range
Message-ID: <202309090624.CrkoQ4fj-lkp@intel.com>
References: <20230908012907.2994001-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908012907.2994001-1-maobibo@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bibo,

kernel test robot noticed the following build errors:

[auto build test ERROR on 744a759492b5c57ff24a6e8aabe47b17ad8ee964]

url:    https://github.com/intel-lab-lkp/linux/commits/Bibo-Mao/LoongArch-Add-tlb_flush_threshold-for-tlb-flush-range/20230908-093017
base:   744a759492b5c57ff24a6e8aabe47b17ad8ee964
patch link:    https://lore.kernel.org/r/20230908012907.2994001-1-maobibo%40loongson.cn
patch subject: [PATCH] LoongArch: Add tlb_flush_threshold for tlb flush range
config: loongarch-randconfig-r021-20230909 (https://download.01.org/0day-ci/archive/20230909/202309090624.CrkoQ4fj-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309090624.CrkoQ4fj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309090624.CrkoQ4fj-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/loongarch/mm/tlb.c: In function '__update_hugetlb':
>> arch/loongarch/mm/tlb.c:146:14: error: implicit declaration of function 'pmd_to_entrylo' [-Werror=implicit-function-declaration]
     146 |         lo = pmd_to_entrylo(pte_val(*ptep));
         |              ^~~~~~~~~~~~~~
   arch/loongarch/mm/tlb.c: At top level:
   arch/loongarch/mm/tlb.c:259:6: warning: no previous prototype for 'setup_tlb_handler' [-Wmissing-prototypes]
     259 | void setup_tlb_handler(int cpu)
         |      ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/pmd_to_entrylo +146 arch/loongarch/mm/tlb.c

09cfefb7fa70c3 Huacai Chen 2022-05-31  131  
09cfefb7fa70c3 Huacai Chen 2022-05-31  132  static void __update_hugetlb(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
09cfefb7fa70c3 Huacai Chen 2022-05-31  133  {
29d05a2438754e Bibo Mao    2023-09-08  134  #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
09cfefb7fa70c3 Huacai Chen 2022-05-31  135  	int idx;
09cfefb7fa70c3 Huacai Chen 2022-05-31  136  	unsigned long lo;
09cfefb7fa70c3 Huacai Chen 2022-05-31  137  	unsigned long flags;
09cfefb7fa70c3 Huacai Chen 2022-05-31  138  
09cfefb7fa70c3 Huacai Chen 2022-05-31  139  	local_irq_save(flags);
09cfefb7fa70c3 Huacai Chen 2022-05-31  140  
09cfefb7fa70c3 Huacai Chen 2022-05-31  141  	address &= (PAGE_MASK << 1);
09cfefb7fa70c3 Huacai Chen 2022-05-31  142  	write_csr_entryhi(address);
09cfefb7fa70c3 Huacai Chen 2022-05-31  143  	tlb_probe();
09cfefb7fa70c3 Huacai Chen 2022-05-31  144  	idx = read_csr_tlbidx();
09cfefb7fa70c3 Huacai Chen 2022-05-31  145  	write_csr_pagesize(PS_HUGE_SIZE);
09cfefb7fa70c3 Huacai Chen 2022-05-31 @146  	lo = pmd_to_entrylo(pte_val(*ptep));
09cfefb7fa70c3 Huacai Chen 2022-05-31  147  	write_csr_entrylo0(lo);
09cfefb7fa70c3 Huacai Chen 2022-05-31  148  	write_csr_entrylo1(lo + (HPAGE_SIZE >> 1));
09cfefb7fa70c3 Huacai Chen 2022-05-31  149  
09cfefb7fa70c3 Huacai Chen 2022-05-31  150  	if (idx < 0)
09cfefb7fa70c3 Huacai Chen 2022-05-31  151  		tlb_write_random();
09cfefb7fa70c3 Huacai Chen 2022-05-31  152  	else
09cfefb7fa70c3 Huacai Chen 2022-05-31  153  		tlb_write_indexed();
09cfefb7fa70c3 Huacai Chen 2022-05-31  154  	write_csr_pagesize(PS_DEFAULT_SIZE);
09cfefb7fa70c3 Huacai Chen 2022-05-31  155  
09cfefb7fa70c3 Huacai Chen 2022-05-31  156  	local_irq_restore(flags);
09cfefb7fa70c3 Huacai Chen 2022-05-31  157  #endif
09cfefb7fa70c3 Huacai Chen 2022-05-31  158  }
09cfefb7fa70c3 Huacai Chen 2022-05-31  159  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
