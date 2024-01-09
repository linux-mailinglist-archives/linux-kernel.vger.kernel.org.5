Return-Path: <linux-kernel+bounces-20970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB8E8287E7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB9528678E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AFD39875;
	Tue,  9 Jan 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="me+qHDvi"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5C439876
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704809822; x=1736345822;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dMfsjjQLQz+MnxTGuMYc96Xmer/aSXSrqNz0HjYB4iQ=;
  b=me+qHDvi6ynhART2z31QcRu/5TTU0SpAE2ZjG3gQseh+FdTMAetGptFO
   02Xg0NSh/qeeMeUdahKQ6sGMVwiwSyAmeCx/3sigsh6h9A0QSm4zZ/N7K
   E8mQahSsYw+b0YiHz6jAVibrkyObrJGH0Hjl+cZJRcZYw/YSbAMAmqOda
   u3Nb09LADLh8ixzQmY6f9HPcTd2I3xbjDIZcT65xOarrVLuNWH6VsMeJU
   0ic8l951Hz/wGxw9lRbYHTWX3PViGE9KdskY5a5IlpddfF210P+K9WdCO
   aQfJ1fbSStNqX3jyYDxLwNYqZi1uKbjYh3qLrydZXQFTfG0c48BQuSNMo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="388648711"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="388648711"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 06:17:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="758002156"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="758002156"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Jan 2024 06:17:00 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNCtf-0005vK-2k;
	Tue, 09 Jan 2024 14:16:29 +0000
Date: Tue, 9 Jan 2024 22:16:02 +0800
From: kernel test robot <lkp@intel.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: include/trace/events/nilfs2.h:191:1: sparse: sparse: cast to
 restricted blk_opf_t
Message-ID: <202401092241.I4mm9OWl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f8413c4a66f2fb776d3dc3c9ed20bf435eb305e
commit: ed4512590bd5839f8ea9eef1626b0f4db626b1d1 fs/nilfs2: Use the enum req_op and blk_opf_t types
date:   1 year, 6 months ago
config: x86_64-randconfig-121-20240107 (https://download.01.org/0day-ci/archive/20240109/202401092241.I4mm9OWl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240109/202401092241.I4mm9OWl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401092241.I4mm9OWl-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/nilfs2/segment.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/nilfs2.h):
>> include/trace/events/nilfs2.h:191:1: sparse: sparse: cast to restricted blk_opf_t
>> include/trace/events/nilfs2.h:191:1: sparse: sparse: cast to restricted blk_opf_t
>> include/trace/events/nilfs2.h:191:1: sparse: sparse: restricted blk_opf_t degrades to integer
>> include/trace/events/nilfs2.h:191:1: sparse: sparse: restricted blk_opf_t degrades to integer

vim +191 include/trace/events/nilfs2.h

a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  190  
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06 @191  TRACE_EVENT(nilfs2_mdt_submit_block,
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  192  	    TP_PROTO(struct inode *inode,
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  193  		     unsigned long ino,
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  194  		     unsigned long blkoff,
ed4512590bd5839 Bart Van Assche 2022-07-14  195  		     enum req_op mode),
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  196  
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  197  	    TP_ARGS(inode, ino, blkoff, mode),
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  198  
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  199  	    TP_STRUCT__entry(
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  200  		    __field(struct inode *, inode)
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  201  		    __field(unsigned long, ino)
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  202  		    __field(unsigned long, blkoff)
ed4512590bd5839 Bart Van Assche 2022-07-14  203  		    __field(enum req_op, mode)
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  204  	    ),
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  205  
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  206  	    TP_fast_assign(
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  207  		    __entry->inode = inode;
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  208  		    __entry->ino = ino;
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  209  		    __entry->blkoff = blkoff;
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  210  		    __entry->mode = mode;
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  211  		    ),
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  212  
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  213  	    TP_printk("inode = %p ino = %lu blkoff = %lu mode = %x",
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  214  		      __entry->inode,
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  215  		      __entry->ino,
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  216  		      __entry->blkoff,
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  217  		      __entry->mode)
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  218  );
a9cd207c23ca4fa Hitoshi Mitake  2015-11-06  219  

:::::: The code at line 191 was first introduced by commit
:::::: a9cd207c23ca4fa5bd5f1092e867e87542e349a3 nilfs2: add tracepoints for analyzing reading and writing metadata files

:::::: TO: Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

