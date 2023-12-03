Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3122C802131
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjLCGHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 01:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCGHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 01:07:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22E4107
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701583665; x=1733119665;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mtOeoCx4l4zfsbqJ7foiBlF5AN3k6ugAPkOMvELQueY=;
  b=FtBNgT7TXzdLM3PrrebdOBgDHZRZH2aR3BuL96s4nuToRPdnCPLlp+Pd
   AOEY0MD+9F7eJTuF7LfMRaHe0mgB7C/+mzudElcILye/8hO75O67lJzHv
   co8FoQ/ztazUVcSQC3Y0pu5v2DQiarKhaVin4mpImu3qIrrEJYqTTYi18
   IAuyzR4omdDwMRFZN2dhN/Kq2DjobGuVM0seujyguFtwF5wCoZS6OZvXM
   7nqopn+xWqCFEkZzbktaBypowg0tlHhPblrM0Al9Y8pWMfjaSYATqwTq7
   k3AmtF+DQASLbb8lCiVMqlxL6BYPrbVwVg5PGCMFRRbB5UGSlZBOtNPri
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="373049277"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="373049277"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 22:07:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="770187874"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="770187874"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 02 Dec 2023 22:07:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9fdk-0006I0-2d;
        Sun, 03 Dec 2023 06:07:40 +0000
Date:   Sun, 3 Dec 2023 14:07:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kent Overstreet <kmo@daterainc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/btree_cache.c:456:15: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202312021327.zVWlbqlu-lkp@intel.com>
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
head:   815fb87b753055df2d9e50f6cd80eb10235fe3e9
commit: 1c6fdbd8f2465ddfb73a01ec620cbf3d14044e1a bcachefs: Initial commit
date:   6 weeks ago
config: hexagon-randconfig-r121-20231119 (https://download.01.org/0day-ci/archive/20231202/202312021327.zVWlbqlu-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231202/202312021327.zVWlbqlu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312021327.zVWlbqlu-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/bcachefs/btree_cache.c:456:15: sparse: sparse: Using plain integer as NULL pointer
   fs/bcachefs/btree_cache.c:468:15: sparse: sparse: Using plain integer as NULL pointer
   fs/bcachefs/btree_cache.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
   fs/bcachefs/btree_cache.c: note: in included file (through include/linux/backing-dev-defs.h, fs/bcachefs/bcachefs.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +456 fs/bcachefs/btree_cache.c

   450	
   451	int bch2_btree_cache_cannibalize_lock(struct bch_fs *c, struct closure *cl)
   452	{
   453		struct btree_cache *bc = &c->btree_cache;
   454		struct task_struct *old;
   455	
 > 456		old = cmpxchg(&bc->alloc_lock, NULL, current);
   457		if (old == NULL || old == current)
   458			goto success;
   459	
   460		if (!cl) {
   461			trace_btree_node_cannibalize_lock_fail(c);
   462			return -ENOMEM;
   463		}
   464	
   465		closure_wait(&bc->alloc_wait, cl);
   466	
   467		/* Try again, after adding ourselves to waitlist */
   468		old = cmpxchg(&bc->alloc_lock, NULL, current);
   469		if (old == NULL || old == current) {
   470			/* We raced */
   471			closure_wake_up(&bc->alloc_wait);
   472			goto success;
   473		}
   474	
   475		trace_btree_node_cannibalize_lock_fail(c);
   476		return -EAGAIN;
   477	
   478	success:
   479		trace_btree_node_cannibalize_lock(c);
   480		return 0;
   481	}
   482	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
