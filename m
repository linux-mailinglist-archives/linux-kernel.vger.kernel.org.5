Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18767EF79B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 19:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjKQSzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 13:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQSzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 13:55:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D670C5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 10:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700247299; x=1731783299;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TVHSThQpand257A1qHKjotIQSF0lUGD9BSFiDIKxBMU=;
  b=mcvd6RN0cWN9C+fn7PWagzZfHUSMt3tPA8BB+IQpMTmB/XtB1XSN2xgT
   4SR91ViIm9/zqHl3+XorFPMCU2e7oubVf6xDHgbq6xJi0L4pPQ8QSBr5s
   rDaboTvilqeMWb30JBVpNcAUczo2ha8nRGKnpe6y5P3ENDg7Zg+M19Mqk
   5miFVU8XsEbsvgPEPqAE9Pxvlpe5u9Y8SJd+BAiNrDJPJeN7cCDUIBxni
   dEm56M9qNAMW2F6/5klwttIJKAg9ayBe2isR53bHorb3Xhei2ZfgEvzYD
   JjzLwME1h/ct38o86au2XxFUKEwEf65MvbVG7Gd97RchVKTuXCAvOvlbe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="455650635"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="455650635"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 10:54:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="836148933"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="836148933"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 Nov 2023 10:54:56 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r43zS-00033L-0e;
        Fri, 17 Nov 2023 18:54:54 +0000
Date:   Sat, 18 Nov 2023 02:54:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Eric Biggers <ebiggers@google.com>, Jan Kara <jack@suse.cz>
Subject: fs/super.c:1785:15: sparse: sparse: Using plain integer as NULL
 pointer
Message-ID: <202311180239.Iu9L00NA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bc40e44f1ddef16a787f3501b97f1fff909177c
commit: 439bc39b3cf0014b1b75075812f7ef0f8baa9674 fs: move sb_init_dio_done_wq out of direct-io.c
date:   10 months ago
config: hexagon-randconfig-r121-20231117 (https://download.01.org/0day-ci/archive/20231118/202311180239.Iu9L00NA-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231118/202311180239.Iu9L00NA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311180239.Iu9L00NA-lkp@intel.com/

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
