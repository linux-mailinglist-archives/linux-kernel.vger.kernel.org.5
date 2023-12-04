Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00214803BA6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjLDRdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjLDRda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:33:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7C4CD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701711215; x=1733247215;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jvJR+Va7uKHOQtLjsEFdxgJ0n/y5RfBCgQC+bCYlQ+4=;
  b=ZEshwDCEr5OmQRih4dC3GfoFluJehtXMTlox/aqhWuKCOb3N4cg24LiX
   IfMtghlRB2RHKQ8/oYKKZCXHgBSEE7Fq78ZIqBoTB/TLuq+NVF6X2t7ZD
   +roh06l7E/s92LVUawZvWxhrZc9Yr2S2D3kTYTFzhHXZYBW77HfmWyVLE
   jBawqBKbSVrPb59Ar8yuVGT/y+J44V53NjemI3qi27BEhDsjb+Q/RxKde
   3AxUdmy1jxrqBCxnikSp4BemrXosOS/M5lyuzH9P6ztfuQMSikZc41URL
   oS83nMmByFkwILDktKTJ/k6KBhfNj0ATA8sI1q6kj04lW8fUx1GRIwcq2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="384174448"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="384174448"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 09:33:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="764027147"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="764027147"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2023 09:33:31 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rACoy-0007xP-2f;
        Mon, 04 Dec 2023 17:33:28 +0000
Date:   Tue, 5 Dec 2023 01:32:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Eric Biggers <ebiggers@google.com>, Jan Kara <jack@suse.cz>
Subject: fs/super.c:1785:15: sparse: sparse: Using plain integer as NULL
 pointer
Message-ID: <202312050045.w3LqhNoX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: 439bc39b3cf0014b1b75075812f7ef0f8baa9674 fs: move sb_init_dio_done_wq out of direct-io.c
date:   10 months ago
config: hexagon-randconfig-r121-20231117 (https://download.01.org/0day-ci/archive/20231205/202312050045.w3LqhNoX-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231205/202312050045.w3LqhNoX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312050045.w3LqhNoX-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/super.c:1785:15: sparse: sparse: Using plain integer as NULL pointer

vim +1785 fs/super.c

  1767	
  1768	/*
  1769	 * Create workqueue for deferred direct IO completions. We allocate the
  1770	 * workqueue when it's first needed. This avoids creating workqueue for
  1771	 * filesystems that don't need it and also allows us to create the workqueue
  1772	 * late enough so the we can include s_id in the name of the workqueue.
  1773	 */
  1774	int sb_init_dio_done_wq(struct super_block *sb)
  1775	{
  1776		struct workqueue_struct *old;
  1777		struct workqueue_struct *wq = alloc_workqueue("dio/%s",
  1778							      WQ_MEM_RECLAIM, 0,
  1779							      sb->s_id);
  1780		if (!wq)
  1781			return -ENOMEM;
  1782		/*
  1783		 * This has to be atomic as more DIOs can race to create the workqueue
  1784		 */
> 1785		old = cmpxchg(&sb->s_dio_done_wq, NULL, wq);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
