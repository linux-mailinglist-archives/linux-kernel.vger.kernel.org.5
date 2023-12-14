Return-Path: <linux-kernel+bounces-129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53558813C95
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FE91F22741
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268B96D1D0;
	Thu, 14 Dec 2023 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CyQ0I5D2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087CE54279
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702589239; x=1734125239;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mcu8MjLmHoajQGLhM3ySFy9PCu+yhpGLMhdvSW3U2FM=;
  b=CyQ0I5D2u0NzOD1nVChKUfJ6lhHrrxn2EhyI0fKjIMG8zLXZppyIg9oT
   6ZHix2qGvQna94SrGfSJ2JMvKeG3Dv3UtJnLAOBM+jULjkEs2wScC5mno
   ZeZilAM9+k6B0sTkzveID2YExvisUdD0ujNMET5xj3d3d3/i62XrzVOhw
   3jQ55WQ1xDNcEl9eiWVROaASlXX9ybzvVA4bLDPKj4EndBoHWlOixsbAN
   N7MakM+lCb1TdSW7naBwuASTee5xAwgUSGgQv7Kr22M6A0eFC4pP3O1VW
   tBuHdb2+rK3ijA1DwcdpMjJqIGKsvGfxX/evF9o1mr+yDmjuJVYUa5pFn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2344415"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="2344415"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 13:27:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="724212347"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="724212347"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 14 Dec 2023 13:27:15 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDtEf-000Mcw-0E;
	Thu, 14 Dec 2023 21:27:13 +0000
Date: Fri, 15 Dec 2023 05:26:48 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: fs/notify/mark.c:462:13: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202312150531.zCYPyiP3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mark,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: df79ed2c064363cdc7d2d896923c1885d4e30520 locking/atomics: Simplify cmpxchg() instrumentation
date:   5 years ago
config: x86_64-randconfig-x003-20230627 (https://download.01.org/0day-ci/archive/20231215/202312150531.zCYPyiP3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150531.zCYPyiP3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150531.zCYPyiP3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/notify/mark.c:462:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsnotify_mark_connector [noderef] __rcu *__new @@     got struct fsnotify_mark_connector *[assigned] conn @@
   fs/notify/mark.c:462:13: sparse:     expected struct fsnotify_mark_connector [noderef] __rcu *__new
   fs/notify/mark.c:462:13: sparse:     got struct fsnotify_mark_connector *[assigned] conn
   fs/notify/mark.c:224:9: sparse: sparse: context imbalance in 'fsnotify_put_mark' - unexpected unlock
   fs/notify/mark.c:310:25: sparse: sparse: context imbalance in 'fsnotify_prepare_user_wait' - unexpected unlock
   fs/notify/mark.c:325:9: sparse: sparse: context imbalance in 'fsnotify_finish_user_wait' - wrong count at exit
   fs/notify/mark.c:478:39: sparse: sparse: context imbalance in 'fsnotify_grab_connector' - different lock contexts for basic block
   fs/notify/mark.c:562:20: sparse: sparse: context imbalance in 'fsnotify_add_mark_list' - unexpected unlock
   fs/notify/mark.c:646:25: sparse: sparse: context imbalance in 'fsnotify_find_mark' - unexpected unlock
   fs/notify/mark.c:718:17: sparse: sparse: context imbalance in 'fsnotify_destroy_marks' - unexpected unlock
   fs/notify/mark.o: warning: objtool: fsnotify_grab_connector()+0x17d: sibling call from callable instruction with modified stack frame
   fs/notify/mark.o: warning: objtool: fsnotify_put_mark_wake()+0x9e: sibling call from callable instruction with modified stack frame
   fs/notify/mark.o: warning: objtool: fsnotify_clear_marks_by_group()+0x1b2: sibling call from callable instruction with modified stack frame

vim +462 fs/notify/mark.c

8edc6e1688fc8f Jan Kara       2014-11-13  438  
9dd813c15b2c10 Jan Kara       2017-03-14  439  static int fsnotify_attach_connector_to_object(
08991e83b72866 Jan Kara       2017-02-01  440  				struct fsnotify_mark_connector __rcu **connp,
86ffe245c430f0 Jan Kara       2017-03-14  441  				struct inode *inode,
86ffe245c430f0 Jan Kara       2017-03-14  442  				struct vfsmount *mnt)
9dd813c15b2c10 Jan Kara       2017-03-14  443  {
9dd813c15b2c10 Jan Kara       2017-03-14  444  	struct fsnotify_mark_connector *conn;
9dd813c15b2c10 Jan Kara       2017-03-14  445  
755b5bc681eb46 Jan Kara       2017-03-14  446  	conn = kmem_cache_alloc(fsnotify_mark_connector_cachep, GFP_KERNEL);
9dd813c15b2c10 Jan Kara       2017-03-14  447  	if (!conn)
9dd813c15b2c10 Jan Kara       2017-03-14  448  		return -ENOMEM;
04662cab59fc3e Jan Kara       2017-02-01  449  	spin_lock_init(&conn->lock);
9dd813c15b2c10 Jan Kara       2017-03-14  450  	INIT_HLIST_HEAD(&conn->list);
86ffe245c430f0 Jan Kara       2017-03-14  451  	if (inode) {
d6f7b98bc8147a Amir Goldstein 2018-04-20  452  		conn->type = FSNOTIFY_OBJ_TYPE_INODE;
08991e83b72866 Jan Kara       2017-02-01  453  		conn->inode = igrab(inode);
86ffe245c430f0 Jan Kara       2017-03-14  454  	} else {
d6f7b98bc8147a Amir Goldstein 2018-04-20  455  		conn->type = FSNOTIFY_OBJ_TYPE_VFSMOUNT;
86ffe245c430f0 Jan Kara       2017-03-14  456  		conn->mnt = mnt;
86ffe245c430f0 Jan Kara       2017-03-14  457  	}
9dd813c15b2c10 Jan Kara       2017-03-14  458  	/*
04662cab59fc3e Jan Kara       2017-02-01  459  	 * cmpxchg() provides the barrier so that readers of *connp can see
04662cab59fc3e Jan Kara       2017-02-01  460  	 * only initialized structure
9dd813c15b2c10 Jan Kara       2017-03-14  461  	 */
04662cab59fc3e Jan Kara       2017-02-01 @462  	if (cmpxchg(connp, NULL, conn)) {
04662cab59fc3e Jan Kara       2017-02-01  463  		/* Someone else created list structure for us */
08991e83b72866 Jan Kara       2017-02-01  464  		if (inode)
08991e83b72866 Jan Kara       2017-02-01  465  			iput(inode);
755b5bc681eb46 Jan Kara       2017-03-14  466  		kmem_cache_free(fsnotify_mark_connector_cachep, conn);
04662cab59fc3e Jan Kara       2017-02-01  467  	}
9dd813c15b2c10 Jan Kara       2017-03-14  468  
9dd813c15b2c10 Jan Kara       2017-03-14  469  	return 0;
9dd813c15b2c10 Jan Kara       2017-03-14  470  }
9dd813c15b2c10 Jan Kara       2017-03-14  471  

:::::: The code at line 462 was first introduced by commit
:::::: 04662cab59fc3e8421fd7a0539d304d51d2750a4 fsnotify: Lock object list with connector lock

:::::: TO: Jan Kara <jack@suse.cz>
:::::: CC: Jan Kara <jack@suse.cz>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

