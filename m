Return-Path: <linux-kernel+bounces-16234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4799A823B49
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 04:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED9D2880F0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 03:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3498E10A04;
	Thu,  4 Jan 2024 03:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKXJYVfB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91C618640
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 03:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704340174; x=1735876174;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HpyfkjZPit+bsDxyrOjSyzNXxZrIbPJsDr9Ekj6i/aU=;
  b=dKXJYVfB1FR2DUacsv2Xff9L6i6vA8iG2kTuIUMPMaCHI17JXKyKWjaT
   JPaBMfnw7W9m74PfJOg24zIdY5c8gsYEXY10YrxkXOZIBsxmMBYxohRL9
   Np6uc1ccsyJZBfdKQXc6jpDpeDRP3V9Y2/AAwZE4YTCQOD6g31v98B40Q
   o40qCde1bIGyrFh6uILOUGPgEMPx+k2g60tRpyuBu05DhBGAKC0yXQ3l5
   8IjluETSg18jmGFfT+vSYGVYY29ZluodejC5Fnp60KIZ3k/h8LYNi/lcz
   NsoodNK8Dx5IaU70J/NOz9WguWYznJdb5FtvBwpsf/9EVh11+OQr2KXlj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="483298266"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="483298266"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 19:49:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="22324731"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 03 Jan 2024 19:49:05 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLEj8-000MsU-0S;
	Thu, 04 Jan 2024 03:49:02 +0000
Date: Thu, 4 Jan 2024 11:48:29 +0800
From: kernel test robot <lkp@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/splice.c:53:19: sparse: sparse: cast from restricted fmode_t
Message-ID: <202401041120.Cr5feSew-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ac865f00af293d081356bec56eea90815094a60e
commit: 0f99fc513ddd28de155c58547824a9fd63daacea splice: clear FMODE_NOWAIT on file if splice/vmsplice is used
date:   8 months ago
config: csky-randconfig-r013-20230825 (https://download.01.org/0day-ci/archive/20240104/202401041120.Cr5feSew-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240104/202401041120.Cr5feSew-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401041120.Cr5feSew-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/splice.c:53:19: sparse: sparse: cast from restricted fmode_t
>> fs/splice.c:53:19: sparse: sparse: cast from restricted fmode_t
>> fs/splice.c:53:19: sparse: sparse: cast to restricted fmode_t
   fs/splice.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:246:46: sparse: sparse: self-comparison always evaluates to false

vim +53 fs/splice.c

    39	
    40	/*
    41	 * Splice doesn't support FMODE_NOWAIT. Since pipes may set this flag to
    42	 * indicate they support non-blocking reads or writes, we must clear it
    43	 * here if set to avoid blocking other users of this pipe if splice is
    44	 * being done on it.
    45	 */
    46	static noinline void noinline pipe_clear_nowait(struct file *file)
    47	{
    48		fmode_t fmode = READ_ONCE(file->f_mode);
    49	
    50		do {
    51			if (!(fmode & FMODE_NOWAIT))
    52				break;
  > 53		} while (!try_cmpxchg(&file->f_mode, &fmode, fmode & ~FMODE_NOWAIT));
    54	}
    55	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

