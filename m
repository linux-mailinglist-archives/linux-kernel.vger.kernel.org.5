Return-Path: <linux-kernel+bounces-20322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D97CF827D52
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3861F23573
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA262907;
	Tue,  9 Jan 2024 03:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BrqNjFH2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987BA28F5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 03:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704770645; x=1736306645;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=75KfFcfqya+xhgKEfr7MozNNm2mJVQ/cF/oRDCl2r+U=;
  b=BrqNjFH2ZN1Q9/L6EDqf3IdL4t/HR+2ko+4N2RLzH/c/uLi7rg1KSA8L
   xvEJnq9tTQHMvBKoTVXJxmKgUE2Ok7obZCIOg9XnOLf31wz8PR4PFhFTm
   JyX65roB+YYRU1VhnGoga2tFq1DxYbJr4jnW3Y+rFiS4ykbP4CYWJDm1g
   TVcBpseG3hR2u2j0/SQhbYZsJqFhVmMFojLsh8nm2UwOby+358kiIbQ7I
   OUBZZ9oR+14IfiSr/e9Ul1ouLuqxot7osmXUyFeI9iRYf+RHqA8TNnwDO
   7gdlDM8gZ/PvdAiiZiSzWp+iIwW+5TFwM6RjKuyt1s7H8O5FeQOGq0TwZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="4830956"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="4830956"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 19:23:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="785065952"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="785065952"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jan 2024 19:23:56 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rN2iY-0005PW-1N;
	Tue, 09 Jan 2024 03:23:54 +0000
Date: Tue, 9 Jan 2024 11:23:22 +0800
From: kernel test robot <lkp@intel.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: include/trace/events/jbd2.h:356:1: sparse: sparse: cast to
 restricted blk_opf_t
Message-ID: <202401091111.p7s9wEEq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f0a78b3e2a0c842cc7b4c2686f4a35681f02ca72
commit: 6669797b0dd41ced457760b6e1014fdda8ce19ce fs/jbd2: Fix the documentation of the jbd2_write_superblock() callers
date:   1 year, 6 months ago
config: x86_64-randconfig-121-20240107 (https://download.01.org/0day-ci/archive/20240109/202401091111.p7s9wEEq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240109/202401091111.p7s9wEEq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401091111.p7s9wEEq-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/jbd2/journal.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/jbd2.h):
>> include/trace/events/jbd2.h:356:1: sparse: sparse: cast to restricted blk_opf_t
>> include/trace/events/jbd2.h:356:1: sparse: sparse: cast to restricted blk_opf_t
>> include/trace/events/jbd2.h:356:1: sparse: sparse: restricted blk_opf_t degrades to integer
>> include/trace/events/jbd2.h:356:1: sparse: sparse: restricted blk_opf_t degrades to integer

vim +356 include/trace/events/jbd2.h

71f2be213a00090 Theodore Ts'o   2009-12-23  355  
24bcc89c7e7c649 Jan Kara        2012-03-13 @356  TRACE_EVENT(jbd2_write_superblock,
2201c590dd6e802 Seiji Aguchi    2012-02-20  357  
6669797b0dd41ce Bart Van Assche 2022-07-14  358  	TP_PROTO(journal_t *journal, blk_opf_t write_flags),
2201c590dd6e802 Seiji Aguchi    2012-02-20  359  
6669797b0dd41ce Bart Van Assche 2022-07-14  360  	TP_ARGS(journal, write_flags),
2201c590dd6e802 Seiji Aguchi    2012-02-20  361  
2201c590dd6e802 Seiji Aguchi    2012-02-20  362  	TP_STRUCT__entry(
2201c590dd6e802 Seiji Aguchi    2012-02-20  363  		__field(	dev_t,  dev			)
6669797b0dd41ce Bart Van Assche 2022-07-14  364  		__field(    blk_opf_t,  write_flags		)
2201c590dd6e802 Seiji Aguchi    2012-02-20  365  	),
2201c590dd6e802 Seiji Aguchi    2012-02-20  366  
2201c590dd6e802 Seiji Aguchi    2012-02-20  367  	TP_fast_assign(
2201c590dd6e802 Seiji Aguchi    2012-02-20  368  		__entry->dev		= journal->j_fs_dev->bd_dev;
6669797b0dd41ce Bart Van Assche 2022-07-14  369  		__entry->write_flags	= write_flags;
2201c590dd6e802 Seiji Aguchi    2012-02-20  370  	),
2201c590dd6e802 Seiji Aguchi    2012-02-20  371  
6669797b0dd41ce Bart Van Assche 2022-07-14  372  	TP_printk("dev %d,%d write_flags %x", MAJOR(__entry->dev),
6669797b0dd41ce Bart Van Assche 2022-07-14  373  		  MINOR(__entry->dev), (__force u32)__entry->write_flags)
2201c590dd6e802 Seiji Aguchi    2012-02-20  374  );
2201c590dd6e802 Seiji Aguchi    2012-02-20  375  

:::::: The code at line 356 was first introduced by commit
:::::: 24bcc89c7e7c64982e6192b4952a0a92379fc341 jbd2: split updating of journal superblock and marking journal empty

:::::: TO: Jan Kara <jack@suse.cz>
:::::: CC: Theodore Ts'o <tytso@mit.edu>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

