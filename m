Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B35801138
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378511AbjLAQk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378433AbjLAQkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:40:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83336FF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701448831; x=1732984831;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nFEattXnDb/mQ/So5Uee5RogWDbtc+5+P7wibT+wb1M=;
  b=RrjdfAXkWy7o4DteH3pVFFjeAMSoxGOy8JLXfv3FTLIzKSXo0jvmbt2o
   hr+O7KA67QDQYpLuxYa5i/nZphYylk6JB6AWJ9LvfOLavkSlAZolV+WpN
   s4U4ttz79zUzpnT1QYHkhWZXaS6viS1Z8f/6BFRK7z/BIQNHbFxwTK+Gw
   PRIlChmDDp9Q/1FH1qJgg7upbRXQPYLn1jhjMO25Ynb9YGElyHc7+1H6Z
   d1a5prqQvhJw7ZEv3/LRXtVx2rzyswLycUtGXcgD5dX3NN4TtHTOaN8ud
   YLQl+G3OMWG5HBEYSyaBclL4YwYnbnv3b+ERBpJwHLeVzL+YnucvmKwBY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="401926"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="401926"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 08:40:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="1017085928"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="1017085928"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 01 Dec 2023 08:40:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r96Z1-0003yX-1g;
        Fri, 01 Dec 2023 16:40:27 +0000
Date:   Sat, 2 Dec 2023 00:39:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        David Jeffery <djeffery@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: block/blk-mq.c:2334:33: sparse: sparse: Using plain integer as NULL
 pointer
Message-ID: <202312020005.Avlspwql-lkp@intel.com>
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
head:   994d5c58e50e91bb02c7be4a91d5186292a895c8
commit: bd63141d585bef14f4caf111f6d0e27fe2300ec6 blk-mq: clear stale request in tags->rq[] before freeing one request pool
date:   2 years, 6 months ago
config: hexagon-randconfig-r121-20231119 (https://download.01.org/0day-ci/archive/20231202/202312020005.Avlspwql-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231202/202312020005.Avlspwql-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312020005.Avlspwql-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> block/blk-mq.c:2334:33: sparse: sparse: Using plain integer as NULL pointer

vim +2334 block/blk-mq.c

  2314	
  2315	/* called before freeing request pool in @tags */
  2316	static void blk_mq_clear_rq_mapping(struct blk_mq_tag_set *set,
  2317			struct blk_mq_tags *tags, unsigned int hctx_idx)
  2318	{
  2319		struct blk_mq_tags *drv_tags = set->tags[hctx_idx];
  2320		struct page *page;
  2321		unsigned long flags;
  2322	
  2323		list_for_each_entry(page, &tags->page_list, lru) {
  2324			unsigned long start = (unsigned long)page_address(page);
  2325			unsigned long end = start + order_to_size(page->private);
  2326			int i;
  2327	
  2328			for (i = 0; i < set->queue_depth; i++) {
  2329				struct request *rq = drv_tags->rqs[i];
  2330				unsigned long rq_addr = (unsigned long)rq;
  2331	
  2332				if (rq_addr >= start && rq_addr < end) {
  2333					WARN_ON_ONCE(refcount_read(&rq->ref) != 0);
> 2334					cmpxchg(&drv_tags->rqs[i], rq, NULL);
  2335				}
  2336			}
  2337		}
  2338	
  2339		/*
  2340		 * Wait until all pending iteration is done.
  2341		 *
  2342		 * Request reference is cleared and it is guaranteed to be observed
  2343		 * after the ->lock is released.
  2344		 */
  2345		spin_lock_irqsave(&drv_tags->lock, flags);
  2346		spin_unlock_irqrestore(&drv_tags->lock, flags);
  2347	}
  2348	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
