Return-Path: <linux-kernel+bounces-23141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B161482A831
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654B31F243D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1A0D281;
	Thu, 11 Jan 2024 07:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+oM8XOE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE9CD26A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704957511; x=1736493511;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HDr/MjNbv0VqpkHH0E6ZifwpGIab/brKKHJNgRFSkV0=;
  b=A+oM8XOExuRb+F13/VvSdqH44g4U2lwvKYKhK4e7OlFC5tTmFRRWfjPo
   mWvwivowP0MXCgHuhRTSG8PwhAtGz3AuMu1lVueGtU6RYSaFSKreEnNha
   bymU8a7s3OF3ynrAAwu4fmtNInfrzSQLRm3BYXOAmKS/uSYj+0H/P/2a8
   yVXqlt2EYNXOsbs3++LKWNOaAa2CcaOAiRdR5FvhasL5GT1zzDPJfJsla
   z5a2kuc/5InuOc/DuAxqaK+U3z+a+ne8IjRfZeVTuc4DbKcOJOW1gHOkT
   8l00r5RfGHrkJFGJBcj7t2s6RlEdQRZxnysL0hbIcu4nSvTp+Wu3BD+/K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="6122475"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="6122475"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 23:18:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="905850135"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="905850135"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 10 Jan 2024 23:18:28 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNpKT-0007wc-1J;
	Thu, 11 Jan 2024 07:18:20 +0000
Date: Thu, 11 Jan 2024 15:17:38 +0800
From: kernel test robot <lkp@intel.com>
To: Andres Beltran <lkmlabelt@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
	"Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
	Michael Kelley <mikelley@microsoft.com>
Subject: drivers/hv/channel.c:514: warning: Function parameter or member
 'size' not described in 'request_arr_init'
Message-ID: <202401111558.xOlI0nqd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   de927f6c0b07d9e698416c5b287c521b07694cac
commit: e8b7db38449ac5b950a3f00519171c4be3e226ff Drivers: hv: vmbus: Add vmbus_requestor data structure for VMBus hardening
date:   3 years, 2 months ago
config: x86_64-buildonly-randconfig-006-20240105 (https://download.01.org/0day-ci/archive/20240111/202401111558.xOlI0nqd-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240111/202401111558.xOlI0nqd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401111558.xOlI0nqd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hv/channel.c:514: warning: Function parameter or member 'size' not described in 'request_arr_init'


vim +514 drivers/hv/channel.c

   505	
   506	/**
   507	 * request_arr_init - Allocates memory for the requestor array. Each slot
   508	 * keeps track of the next available slot in the array. Initially, each
   509	 * slot points to the next one (as in a Linked List). The last slot
   510	 * does not point to anything, so its value is U64_MAX by default.
   511	 * @size The size of the array
   512	 */
   513	static u64 *request_arr_init(u32 size)
 > 514	{
   515		int i;
   516		u64 *req_arr;
   517	
   518		req_arr = kcalloc(size, sizeof(u64), GFP_KERNEL);
   519		if (!req_arr)
   520			return NULL;
   521	
   522		for (i = 0; i < size - 1; i++)
   523			req_arr[i] = i + 1;
   524	
   525		/* Last slot (no more available slots) */
   526		req_arr[i] = U64_MAX;
   527	
   528		return req_arr;
   529	}
   530	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

