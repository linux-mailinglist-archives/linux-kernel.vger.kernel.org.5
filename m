Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE5C7DF46F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376692AbjKBN6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376700AbjKBN6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:58:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC7583
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698933479; x=1730469479;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tplbjDSg9L50zPHW+7EcBwalZybgP2Q14tGBqxsVNH8=;
  b=ObdATYomzKJkBkDbzMcbcdlFERq6mBvkEb1oyAE4jE6rUwZ5mt6vzZwf
   2mnfytlA1LBwu1Ec2FFJ1fZjzEg6ynoYlrRSkVfAN35u/XI4qK1CiTHQ5
   ezkDcX77ffnXpIv4GVnuH1zBVNdemVYk4gJdqQCbswcCsFVW9sv8sVWhl
   GDCdnYB4de8Zg7SLXdBoeZuhVAEAwx0oEerUKj/RQrvskQCBOi39O4jal
   eLGiLKK4O2oDEacN6ILR18Nx684E6JOyBern5ZG7kBIGtWXqc0IMga+6b
   MttWK24Q13VhW0Y78kBZJFJ/bXlfkn0nFclraRH9QjeLtE2/FfiUetEau
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="453019603"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="453019603"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 06:55:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="827146899"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="827146899"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 Nov 2023 06:55:06 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyYA4-0001V6-2l;
        Thu, 02 Nov 2023 13:55:04 +0000
Date:   Thu, 2 Nov 2023 21:54:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Subject: mm/kfence/core.c:329:34: sparse: sparse: cast to restricted __le64
Message-ID: <202311022155.9hNK2VJO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
commit: 7581495ac82d6cb073609284c7f7186a48021d1e mm: kfence: fix false positives on big endian
date:   6 months ago
config: s390-randconfig-r113-20231102 (https://download.01.org/0day-ci/archive/20231102/202311022155.9hNK2VJO-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231102/202311022155.9hNK2VJO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311022155.9hNK2VJO-lkp@intel.com/

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
