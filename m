Return-Path: <linux-kernel+bounces-18810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CCA826350
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 09:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1096328295B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 08:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2313812B60;
	Sun,  7 Jan 2024 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9tBTsaU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116C8125C3
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704614503; x=1736150503;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F3iruKT4fxqF1QDuoTmtaxLu4zWWEUqI59gl02qbCy4=;
  b=k9tBTsaUANbwW1RN+DTXmSa5d9mo7jfoPRAzNeYHPyyiOKx4mZH7fW+6
   VbzVKB9MeFonjwpT6baxXB8hIftHxOq750dQwUNE0zBx3tCaFY8/gOHxU
   zgIom1bi7BboRilole/JEg+Vb1v02dWGfNONUTK3zxSHpxcpBLHzjf2do
   gxc5ojDHbyiHiDz+TlBxpURDgRYWxRj3p96MkwPFIq+P2lPYt6cqI0O3C
   fXc226ejKCj/wHPJOdoznQ1CtGXOQFhNIj6MoqL342zQ6nNN3JSI+n0ng
   cQoersYSnhr4OcjqWlxstffioWD+hl+uE7Sh37/9p5PtRuCDiI7Shl+Wn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="397434502"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="397434502"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 00:01:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="1112471401"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="1112471401"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jan 2024 00:01:40 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMO6E-0003c4-1R;
	Sun, 07 Jan 2024 08:01:38 +0000
Date: Sun, 7 Jan 2024 16:01:09 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: drivers/md/bcache/request.c:309: warning: Function parameter or
 member 'bch_data_insert' not described in 'CLOSURE_CALLBACK'
Message-ID: <202401071547.Zr3Ffy8F-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52b1853b080a082ec3749c3a9577f6c71b1d4a90
commit: d4e3b928ab487a8aecd1f6a140b40ac365116cfb closures: CLOSURE_CALLBACK() to fix type punning
date:   6 weeks ago
config: i386-buildonly-randconfig-001-20240107 (https://download.01.org/0day-ci/archive/20240107/202401071547.Zr3Ffy8F-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401071547.Zr3Ffy8F-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401071547.Zr3Ffy8F-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/md/bcache/request.c:309: warning: Function parameter or member 'bch_data_insert' not described in 'CLOSURE_CALLBACK'
>> drivers/md/bcache/request.c:309: warning: expecting prototype for bch_data_insert(). Prototype was for CLOSURE_CALLBACK() instead


vim +309 drivers/md/bcache/request.c

cafe563591446c Kent Overstreet 2013-03-23  287  
cafe563591446c Kent Overstreet 2013-03-23  288  /**
a34a8bfd4e6358 Kent Overstreet 2013-10-24  289   * bch_data_insert - stick some data in the cache
47344e330eabc1 Bart Van Assche 2018-03-18  290   * @cl: closure pointer.
cafe563591446c Kent Overstreet 2013-03-23  291   *
cafe563591446c Kent Overstreet 2013-03-23  292   * This is the starting point for any data to end up in a cache device; it could
cafe563591446c Kent Overstreet 2013-03-23  293   * be from a normal write, or a writeback write, or a write to a flash only
cafe563591446c Kent Overstreet 2013-03-23  294   * volume - it's also used by the moving garbage collector to compact data in
cafe563591446c Kent Overstreet 2013-03-23  295   * mostly empty buckets.
cafe563591446c Kent Overstreet 2013-03-23  296   *
cafe563591446c Kent Overstreet 2013-03-23  297   * It first writes the data to the cache, creating a list of keys to be inserted
cafe563591446c Kent Overstreet 2013-03-23  298   * (if the data had to be fragmented there will be multiple keys); after the
cafe563591446c Kent Overstreet 2013-03-23  299   * data is written it calls bch_journal, and after the keys have been added to
cafe563591446c Kent Overstreet 2013-03-23  300   * the next journal write they're inserted into the btree.
cafe563591446c Kent Overstreet 2013-03-23  301   *
3db4d0783eaf2a Shenghui Wang   2018-12-13  302   * It inserts the data in op->bio; bi_sector is used for the key offset,
cafe563591446c Kent Overstreet 2013-03-23  303   * and op->inode is used for the key inode.
cafe563591446c Kent Overstreet 2013-03-23  304   *
3db4d0783eaf2a Shenghui Wang   2018-12-13  305   * If op->bypass is true, instead of inserting the data it invalidates the
3db4d0783eaf2a Shenghui Wang   2018-12-13  306   * region of the cache represented by op->bio and op->inode.
cafe563591446c Kent Overstreet 2013-03-23  307   */
d4e3b928ab487a Kent Overstreet 2023-11-17  308  CLOSURE_CALLBACK(bch_data_insert)
cafe563591446c Kent Overstreet 2013-03-23 @309  {
d4e3b928ab487a Kent Overstreet 2023-11-17  310  	closure_type(op, struct data_insert_op, cl);
cafe563591446c Kent Overstreet 2013-03-23  311  
60ae81eee86dd7 Slava Pestov    2014-05-22  312  	trace_bcache_write(op->c, op->inode, op->bio,
60ae81eee86dd7 Slava Pestov    2014-05-22  313  			   op->writeback, op->bypass);
220bb38c21b83e Kent Overstreet 2013-09-10  314  
220bb38c21b83e Kent Overstreet 2013-09-10  315  	bch_keylist_init(&op->insert_keys);
220bb38c21b83e Kent Overstreet 2013-09-10  316  	bio_get(op->bio);
d4e3b928ab487a Kent Overstreet 2023-11-17  317  	bch_data_insert_start(&cl->work);
cafe563591446c Kent Overstreet 2013-03-23  318  }
cafe563591446c Kent Overstreet 2013-03-23  319  

:::::: The code at line 309 was first introduced by commit
:::::: cafe563591446cf80bfbc2fe3bc72a2e36cf1060 bcache: A block layer cache

:::::: TO: Kent Overstreet <koverstreet@google.com>
:::::: CC: Kent Overstreet <koverstreet@google.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

