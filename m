Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAF6801809
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjLAXsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjLAXsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:48:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FD81AD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 15:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701474500; x=1733010500;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OCxQAzh0g1Swiyhk7+3YI6icCg7/EsTLTcp+7y+mHP0=;
  b=cKZMaD/PHxhF53W1QMUae18DCo2FhM7eKjN9m5ffcaR1wrCl93yg0p+G
   sopcl0fC07D0deJnGIPqj3/RnoKUXw19NycQzmmB9mswtEm1gZtTYfarA
   OAJpXVVk8eAxUL7D04UNwDmfFdQ8Wyz+boJG5dqQ9UHODWrDQ6Asz+2BL
   vgqluWJ1rHFU5zVoDF72WA11MvRfv8EMCHrALxqIaJqfM0bPWOr1VkWVr
   3Bp4w0gKnA7rFJ3BTb/Wnh7cB6VUxHKeNXkA5MBtd/rcNZa7PbvmSKaoX
   SoBYK82NpIoYjKYRDA7leiBIyoMbZHvbZaA7jdWCfGFU88PZ905jBWR+M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="390728616"
X-IronPort-AV: E=Sophos;i="6.04,243,1695711600"; 
   d="scan'208";a="390728616"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 15:48:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="835918586"
X-IronPort-AV: E=Sophos;i="6.04,243,1695711600"; 
   d="scan'208";a="835918586"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 01 Dec 2023 15:48:18 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9DEt-0004Q2-2E;
        Fri, 01 Dec 2023 23:48:11 +0000
Date:   Sat, 2 Dec 2023 07:47:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Subject: mm/kfence/core.c:329:34: sparse: sparse: cast to restricted __le64
Message-ID: <202312020738.7YABe2N2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c9a925b7bcd9552f19ba50519c6a49ed7ca61691
commit: 7581495ac82d6cb073609284c7f7186a48021d1e mm: kfence: fix false positives on big endian
date:   7 months ago
config: s390-randconfig-r113-20231102 (https://download.01.org/0day-ci/archive/20231202/202312020738.7YABe2N2-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231202/202312020738.7YABe2N2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312020738.7YABe2N2-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/kfence/core.c:329:34: sparse: sparse: cast to restricted __le64
   mm/kfence/core.c:333:34: sparse: sparse: cast to restricted __le64
   mm/kfence/core.c:352:21: sparse: sparse: cast to restricted __le64
   mm/kfence/core.c:372:21: sparse: sparse: cast to restricted __le64
   mm/kfence/core.c:1181:9: sparse: sparse: context imbalance in 'kfence_handle_page_fault' - different lock contexts for basic block

vim +329 mm/kfence/core.c

0ce20dd840897b Alexander Potapenko 2021-02-25  318  
1ba3cbf3ec3b21 Peng Zhang          2023-04-03  319  static inline void set_canary(const struct kfence_metadata *meta)
0ce20dd840897b Alexander Potapenko 2021-02-25  320  {
0ce20dd840897b Alexander Potapenko 2021-02-25  321  	const unsigned long pageaddr = ALIGN_DOWN(meta->addr, PAGE_SIZE);
1ba3cbf3ec3b21 Peng Zhang          2023-04-03  322  	unsigned long addr = pageaddr;
1ba3cbf3ec3b21 Peng Zhang          2023-04-03  323  
1ba3cbf3ec3b21 Peng Zhang          2023-04-03  324  	/*
1ba3cbf3ec3b21 Peng Zhang          2023-04-03  325  	 * The canary may be written to part of the object memory, but it does
1ba3cbf3ec3b21 Peng Zhang          2023-04-03  326  	 * not affect it. The user should initialize the object before using it.
1ba3cbf3ec3b21 Peng Zhang          2023-04-03  327  	 */
1ba3cbf3ec3b21 Peng Zhang          2023-04-03  328  	for (; addr < meta->addr; addr += sizeof(u64))
1ba3cbf3ec3b21 Peng Zhang          2023-04-03 @329  		*((u64 *)addr) = KFENCE_CANARY_PATTERN_U64;
1ba3cbf3ec3b21 Peng Zhang          2023-04-03  330  
1ba3cbf3ec3b21 Peng Zhang          2023-04-03  331  	addr = ALIGN_DOWN(meta->addr + meta->size, sizeof(u64));
1ba3cbf3ec3b21 Peng Zhang          2023-04-03  332  	for (; addr - pageaddr < PAGE_SIZE; addr += sizeof(u64))
1ba3cbf3ec3b21 Peng Zhang          2023-04-03  333  		*((u64 *)addr) = KFENCE_CANARY_PATTERN_U64;
1ba3cbf3ec3b21 Peng Zhang          2023-04-03  334  }
1ba3cbf3ec3b21 Peng Zhang          2023-04-03  335  

:::::: The code at line 329 was first introduced by commit
:::::: 1ba3cbf3ec3b21d866436fb46b4bb7bdc38608f9 mm: kfence: improve the performance of __kfence_alloc() and __kfence_free()

:::::: TO: Peng Zhang <zhangpeng.00@bytedance.com>
:::::: CC: Andrew Morton <akpm@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
