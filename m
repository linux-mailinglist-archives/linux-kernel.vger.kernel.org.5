Return-Path: <linux-kernel+bounces-5261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FC58188AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D2CB21E9B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6738F1947D;
	Tue, 19 Dec 2023 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVrseX6L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7B4199A2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702992644; x=1734528644;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kDCeoMc8JARwS5FTdLq0Niw+ZszurLOosW7mrGs21Kk=;
  b=CVrseX6LK3YYfNu+co5hR9CSl8Th5jN+EbzGE6yHWQJaOyvXf5O7XO5m
   zuOhSwHKnu1mrIR3XSOdvhUanprMmtoUV1QXCHplg1EtDHiMZqF0L7OZr
   BwI1S+JdKnb1qaOv2zgAFb2rSbJES8EYBwsWPYor/TOZAAQZN1jotq5BT
   0GmmZ7yIG9cfUVUSSbabWjZo4Y9Dz135TB26SS1v3H5o3paZ/7R0u0vaR
   /3opKh46qoobVaqkZVTE2AZB4OaPGrk6isMVbqvvOdYvF58TLQMWiK5Ss
   /nNEi6siKZpR7CPJgzInfPcsCQOxIWm06WXGveKhdNEBPhG+LPCUlwM8Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="14345357"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="14345357"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 05:30:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="769237581"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="769237581"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 19 Dec 2023 05:30:42 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFaBD-0005Md-2h;
	Tue, 19 Dec 2023 13:30:39 +0000
Date: Tue, 19 Dec 2023 21:29:54 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Brian Vazquez <brianvv@google.com>
Subject: net/core/dev.c:10290:18: sparse: sparse: cast removes address space
 '__percpu' of expression
Message-ID: <202312192120.8ogDR8Em-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cf4f94d8e8646803f8fb0facf134b0cd7fb691a
commit: 625788b5844511cf4c30cffa7fa0bc3a69cebc82 net: add per-cpu storage and net->core_stats
date:   1 year, 9 months ago
config: riscv-buildonly-randconfig-r006-20230429 (https://download.01.org/0day-ci/archive/20231219/202312192120.8ogDR8Em-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231219/202312192120.8ogDR8Em-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312192120.8ogDR8Em-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/core/dev.c:3254:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:3254:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:3254:23: sparse:     got unsigned int
   net/core/dev.c:3254:23: sparse: sparse: cast from restricted __wsum
>> net/core/dev.c:10290:18: sparse: sparse: cast removes address space '__percpu' of expression
   net/core/dev.c:3759:17: sparse: sparse: context imbalance in '__dev_queue_xmit' - different lock contexts for basic block
   net/core/dev.c:4961:17: sparse: sparse: context imbalance in 'net_tx_action' - different lock contexts for basic block

vim +/__percpu +10290 net/core/dev.c

 10282	
 10283	struct net_device_core_stats *netdev_core_stats_alloc(struct net_device *dev)
 10284	{
 10285		struct net_device_core_stats __percpu *p;
 10286	
 10287		p = alloc_percpu_gfp(struct net_device_core_stats,
 10288				     GFP_ATOMIC | __GFP_NOWARN);
 10289	
 10290		if (p && cmpxchg(&dev->core_stats, NULL, p))
 10291			free_percpu(p);
 10292	
 10293		/* This READ_ONCE() pairs with the cmpxchg() above */
 10294		p = READ_ONCE(dev->core_stats);
 10295		if (!p)
 10296			return NULL;
 10297	
 10298		return this_cpu_ptr(p);
 10299	}
 10300	EXPORT_SYMBOL(netdev_core_stats_alloc);
 10301	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

