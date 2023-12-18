Return-Path: <linux-kernel+bounces-3096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8A4816759
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581E51F22D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B7D79D1;
	Mon, 18 Dec 2023 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rpo2WIII"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E06C8E2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702884331; x=1734420331;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AuxBpZnJVI+9zv90Pp/dwj11JNJ/pzXmNMUTL3iOQGY=;
  b=Rpo2WIIIsXdI+q11cQsAayCRMJcFE27PNx1rsp/o588UOg+wAPEAglxJ
   1Lr17H2E/db2AzvBrmsamtj+0/2vTJfqqq6SzhMX24ft0mbYBwGqogLnQ
   4b3F+hUBDL2a0qT2CnSyQx6uqZZ4ha+ax3w1nH3Tc/6cogYiyCzUf8pxB
   g/3HFEOdEl4oBV/rxd/pSMLcJKDhJd2WUtjRhRrcI9kTYlZPgGqUaAXJA
   JmxEv/04TWaYsOmZl1WnoPpi2JTO24OQ/21AJuljKpOSJstaTQtVjbVr5
   t1nm/lGtqwR4c77t39PgiYaseTbzCWvwfXJgA9rjvAfOWKfoitWvVenYn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="374966344"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="374966344"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 23:25:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="809711680"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="809711680"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Dec 2023 23:25:28 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rF80E-0003rN-1d;
	Mon, 18 Dec 2023 07:25:26 +0000
Date: Mon, 18 Dec 2023 15:25:03 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: kernel/dma/debug.c:95: warning: Function parameter or member
 'stack_len' not described in 'dma_debug_entry'
Message-ID: <202312181548.9Xq6Tt63-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ceb6a6f023fd3e8b07761ed900352ef574010bcb
commit: 746017ed8d4d3c2070bb03aee9536f24da43c778 dma/debug: Simplify stracktrace retrieval
date:   4 years, 8 months ago
config: x86_64-buildonly-randconfig-006-20230830 (https://download.01.org/0day-ci/archive/20231218/202312181548.9Xq6Tt63-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231218/202312181548.9Xq6Tt63-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312181548.9Xq6Tt63-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/dma/debug.c:95: warning: Function parameter or member 'dev_addr' not described in 'dma_debug_entry'
>> kernel/dma/debug.c:95: warning: Function parameter or member 'stack_len' not described in 'dma_debug_entry'
>> kernel/dma/debug.c:95: warning: Function parameter or member 'stack_entries' not described in 'dma_debug_entry'


vim +95 kernel/dma/debug.c

6c132d1bcdc716 lib/dma-debug.c    David Woodhouse 2009-01-19  64  
0abdd7a81b7e3f lib/dma-debug.c    Dan Williams    2014-01-21  65  /**
0abdd7a81b7e3f lib/dma-debug.c    Dan Williams    2014-01-21  66   * struct dma_debug_entry - track a dma_map* or dma_alloc_coherent mapping
0abdd7a81b7e3f lib/dma-debug.c    Dan Williams    2014-01-21  67   * @list: node on pre-allocated free_entries list
0abdd7a81b7e3f lib/dma-debug.c    Dan Williams    2014-01-21  68   * @dev: 'dev' argument to dma_map_{page|single|sg} or dma_alloc_coherent
0abdd7a81b7e3f lib/dma-debug.c    Dan Williams    2014-01-21  69   * @type: single, page, sg, coherent
0abdd7a81b7e3f lib/dma-debug.c    Dan Williams    2014-01-21  70   * @pfn: page frame of the start address
0abdd7a81b7e3f lib/dma-debug.c    Dan Williams    2014-01-21  71   * @offset: offset of mapping relative to pfn
0abdd7a81b7e3f lib/dma-debug.c    Dan Williams    2014-01-21  72   * @size: length of the mapping
0abdd7a81b7e3f lib/dma-debug.c    Dan Williams    2014-01-21  73   * @direction: enum dma_data_direction
0abdd7a81b7e3f lib/dma-debug.c    Dan Williams    2014-01-21  74   * @sg_call_ents: 'nents' from dma_map_sg
0abdd7a81b7e3f lib/dma-debug.c    Dan Williams    2014-01-21  75   * @sg_mapped_ents: 'mapped_ents' from dma_map_sg
0abdd7a81b7e3f lib/dma-debug.c    Dan Williams    2014-01-21  76   * @map_err_type: track whether dma_mapping_error() was checked
0abdd7a81b7e3f lib/dma-debug.c    Dan Williams    2014-01-21  77   * @stacktrace: support backtraces when a violation is detected
0abdd7a81b7e3f lib/dma-debug.c    Dan Williams    2014-01-21  78   */
f2f45e5f3c921c lib/dma-debug.c    Joerg Roedel    2009-01-09  79  struct dma_debug_entry {
f2f45e5f3c921c lib/dma-debug.c    Joerg Roedel    2009-01-09  80  	struct list_head list;
f2f45e5f3c921c lib/dma-debug.c    Joerg Roedel    2009-01-09  81  	struct device    *dev;
f2f45e5f3c921c lib/dma-debug.c    Joerg Roedel    2009-01-09  82  	int              type;
0abdd7a81b7e3f lib/dma-debug.c    Dan Williams    2014-01-21  83  	unsigned long	 pfn;
0abdd7a81b7e3f lib/dma-debug.c    Dan Williams    2014-01-21  84  	size_t		 offset;
f2f45e5f3c921c lib/dma-debug.c    Joerg Roedel    2009-01-09  85  	u64              dev_addr;
f2f45e5f3c921c lib/dma-debug.c    Joerg Roedel    2009-01-09  86  	u64              size;
f2f45e5f3c921c lib/dma-debug.c    Joerg Roedel    2009-01-09  87  	int              direction;
f2f45e5f3c921c lib/dma-debug.c    Joerg Roedel    2009-01-09  88  	int		 sg_call_ents;
f2f45e5f3c921c lib/dma-debug.c    Joerg Roedel    2009-01-09  89  	int		 sg_mapped_ents;
6c9c6d6301287e lib/dma-debug.c    Shuah Khan      2012-10-08  90  	enum map_err_types  map_err_type;
6c132d1bcdc716 lib/dma-debug.c    David Woodhouse 2009-01-19  91  #ifdef CONFIG_STACKTRACE
746017ed8d4d3c kernel/dma/debug.c Thomas Gleixner 2019-04-25  92  	unsigned int	stack_len;
746017ed8d4d3c kernel/dma/debug.c Thomas Gleixner 2019-04-25  93  	unsigned long	stack_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
6c132d1bcdc716 lib/dma-debug.c    David Woodhouse 2009-01-19  94  #endif
f2f45e5f3c921c lib/dma-debug.c    Joerg Roedel    2009-01-09 @95  };
f2f45e5f3c921c lib/dma-debug.c    Joerg Roedel    2009-01-09  96  

:::::: The code at line 95 was first introduced by commit
:::::: f2f45e5f3c921c73c913e9a9c00f21ec01c86b4d dma-debug: add header file and core data structures

:::::: TO: Joerg Roedel <joerg.roedel@amd.com>
:::::: CC: Joerg Roedel <joerg.roedel@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

