Return-Path: <linux-kernel+bounces-17194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E346C824972
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40FF8B22404
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA592C68F;
	Thu,  4 Jan 2024 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RCfZHlH4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F66E2C1B4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704399318; x=1735935318;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YrYn1UbcovhLgRgdhdsZCKfJw+zqxFluD3f2RDwRofU=;
  b=RCfZHlH4+rCEeYTkg9UoHbp2SibMtPyWZYiSdN49Nt5JeFSJ5BBPzvEW
   RVA0lMyIzTc5t2ejJefM2BR8I/4aFpF0rsO0DOTQ/I20kFn4swNsRg+Mm
   EtjlKH7bnCeXR7C8cJpH4qE1ifP1QfqxEU8eivem6La1FQvgrjND9FJgb
   zV7MfoE1gmMBxUo6jmQlTX6GYxDjz9E99enX2ZBaPCBeNX8mNe3p7YRRp
   nisAcj9fZzm4YTyYlYFK7nnadt93afdBcoxeozHGz4PjpXcSGCHkGQBCn
   fD1QJ1Wwky3HElxtNQ1spmHg99JkOji8Sdl/5jPeR7qNcXJf5AYUunMI3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="387800605"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="387800605"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 12:15:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="903936595"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="903936595"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2024 12:15:16 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLU7W-0000OW-1s;
	Thu, 04 Jan 2024 20:15:14 +0000
Date: Fri, 5 Jan 2024 04:15:07 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>
Subject: kernel/locking/locktorture.c:127:23: sparse: sparse: symbol
 'call_rcu_chain' was not declared. Should it be static?
Message-ID: <202401050408.EhjifVYd-lkp@intel.com>
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
commit: 7f993623e9ebcd633c0f760991e5078b95a37db3 locktorture: Add call_rcu_chains module parameter
date:   3 months ago
config: csky-randconfig-r013-20230825 (https://download.01.org/0day-ci/archive/20240105/202401050408.EhjifVYd-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240105/202401050408.EhjifVYd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401050408.EhjifVYd-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/locking/locktorture.c:127:23: sparse: sparse: symbol 'call_rcu_chain' was not declared. Should it be static?
   kernel/locking/locktorture.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
   kernel/locking/locktorture.c:496:12: sparse: sparse: context imbalance in 'torture_mutex_lock' - wrong count at exit
   kernel/locking/locktorture.c:512:13: sparse: sparse: context imbalance in 'torture_mutex_unlock' - wrong count at exit
   kernel/locking/locktorture.c:570:12: sparse: sparse: context imbalance in 'torture_ww_mutex_lock' - wrong count at exit
   kernel/locking/locktorture.c: note: in included file:
   include/linux/ww_mutex.h:191:9: sparse: sparse: context imbalance in 'torture_ww_mutex_unlock' - wrong count at exit
   kernel/locking/locktorture.c:665:12: sparse: sparse: context imbalance in 'torture_rtmutex_lock' - wrong count at exit
   kernel/locking/locktorture.c:689:13: sparse: sparse: context imbalance in 'torture_rtmutex_unlock' - wrong count at exit
   kernel/locking/locktorture.c:729:12: sparse: sparse: context imbalance in 'torture_rwsem_down_write' - wrong count at exit
   kernel/locking/locktorture.c:745:13: sparse: sparse: context imbalance in 'torture_rwsem_up_write' - wrong count at exit
   kernel/locking/locktorture.c:751:12: sparse: sparse: context imbalance in 'torture_rwsem_down_read' - wrong count at exit
   kernel/locking/locktorture.c:769:13: sparse: sparse: context imbalance in 'torture_rwsem_up_read' - wrong count at exit
   kernel/locking/locktorture.c:799:12: sparse: sparse: context imbalance in 'torture_percpu_rwsem_down_write' - wrong count at exit
   kernel/locking/locktorture.c:806:13: sparse: sparse: context imbalance in 'torture_percpu_rwsem_up_write' - wrong count at exit
   kernel/locking/locktorture.c: note: in included file:
   include/linux/percpu-rwsem.h:70:9: sparse: sparse: context imbalance in 'torture_percpu_rwsem_down_read' - wrong count at exit
   include/linux/percpu-rwsem.h:121:9: sparse: sparse: context imbalance in 'torture_percpu_rwsem_up_read' - wrong count at exit

vim +/call_rcu_chain +127 kernel/locking/locktorture.c

   122	
   123	struct call_rcu_chain {
   124		struct rcu_head crc_rh;
   125		bool crc_stop;
   126	};
 > 127	struct call_rcu_chain *call_rcu_chain;
   128	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

