Return-Path: <linux-kernel+bounces-25615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F296582D3A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A201C20E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 04:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE9720F4;
	Mon, 15 Jan 2024 04:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWH9e6s9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D731FAE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 04:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705292921; x=1736828921;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vg9rrQNnxx0hCgmrr1/1ynLqsD9wMMWaEV4duRQP5Xk=;
  b=CWH9e6s9tOYmTXCDw4TAJ30kdxg7IwPP1Yi3GBuiVvOglkA2NdIZLjLO
   B1ozhQjFixnRwq7YGkYPwEK0clfoZcs32b9JBU8MV/+E4UgEN14SVqcuw
   On3ui3f1WrDIfqSzlnBFkmjvg8+IMTMl380mffmw9KevLG58V7GoGTGgF
   b9A4FH7oNiQAhqQ0cDeWr4jcSsJUsLoDfedVMflihlWJD9pqqLwMvwLNI
   ZvKy7t3GtQrh432yDLGld17JtaHtKdXLoAxFHcAaES0D4NleEyoeb0Yg7
   rhGXHGwR/NjXSDaq5ImxVigDZzabp9mok5TN+DqaKyjpRqvl/i4ta2/q0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="12891853"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="12891853"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 20:28:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1114823586"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="1114823586"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jan 2024 20:28:39 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPEaT-000C8q-0N;
	Mon, 15 Jan 2024 04:28:37 +0000
Date: Mon, 15 Jan 2024 12:28:27 +0800
From: kernel test robot <lkp@intel.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: include/trace/events/jbd2.h:356:1: sparse: sparse: cast to
 restricted blk_opf_t
Message-ID: <202401151239.cNgBQqgO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   052d534373b7ed33712a63d5e17b2b6cdbce84fd
commit: 6669797b0dd41ced457760b6e1014fdda8ce19ce fs/jbd2: Fix the documentation of the jbd2_write_superblock() callers
date:   1 year, 6 months ago
config: x86_64-randconfig-121-20240107 (https://download.01.org/0day-ci/archive/20240115/202401151239.cNgBQqgO-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240115/202401151239.cNgBQqgO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401151239.cNgBQqgO-lkp@intel.com/

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

