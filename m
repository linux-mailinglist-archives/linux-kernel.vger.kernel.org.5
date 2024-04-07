Return-Path: <linux-kernel+bounces-134321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F99689B04A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFAEE282739
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF02718AE4;
	Sun,  7 Apr 2024 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VH557s+/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF231F93E
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712484311; cv=none; b=trU/lJQp94H7oDTIS/AaAnct3yI/y+YqyHnB/+KEppWqc/ftq44npBkiC66gZZa+okNfrCQrZuhTPyYvhFZOz02OqgV3t3aRv12WRkBon2GoK3RidAMzLMAdX4mGa3o5Ab/6CwTLfNLTGg+6riDLClNzlu3803dSRImoWxZDbpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712484311; c=relaxed/simple;
	bh=05dYJTMnQ4oT/t4pv3P+UXvDhDRfMYze25dERHYk1jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZEuSHMdpjns2nyZvCIJsum+uBXZYwI6MHXb2Ye9zALNmNCavprBXc4WOT73/0CwQtV2JSek1Zus92Qdj3KQpKK3PLZIlJMbjY+aStWfGnn9yF28GQ+mPoEYALk32di8nal54EcTU4oftXBQ/SvK4xJBZihcV5s1fyA4CIQd8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VH557s+/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712484309; x=1744020309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=05dYJTMnQ4oT/t4pv3P+UXvDhDRfMYze25dERHYk1jM=;
  b=VH557s+//rndqFoD1oGErozjaxVWY5IEVrQtenC/8WatFMqZmO7PMdGn
   nR8VNHETpN5kepX7FkzmzGy3R8nZWjwDrghDJlvxpSu2hIwmloWHqYVmJ
   Q6j196Mg8mv/ZlRb7pzq8fzt0OaUtVz0fGvGCw+2CaP5rhCUPuG1thZRg
   oVuME0xMlGTmHHM7/6hcMNusKWPAFrphwhk48R7HrWg22+GyOwuf3vISX
   zle/Sl07yVaPUn/HaMvrH+tfh8rG1v8glL9nX4BMXdXX/oLFr5ceYon2B
   V3DbHl9SSxF50uI7KIaKnH316MrpkA/AAXIbiuSDJGpXRfbLGLGWcGJnC
   w==;
X-CSE-ConnectionGUID: UCE1KqjnSfOw2J2M6u7a7w==
X-CSE-MsgGUID: mqFkmVWeSimS2NAZh+kANQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="7869608"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="7869608"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 03:05:08 -0700
X-CSE-ConnectionGUID: xjxJ2CRxTzWNJrV8m1q6Ng==
X-CSE-MsgGUID: +mlLl4wBTxSdKAHl6nKxKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="19719057"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 07 Apr 2024 03:05:06 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtPOZ-0004GM-1D;
	Sun, 07 Apr 2024 10:05:03 +0000
Date: Sun, 7 Apr 2024 18:04:40 +0800
From: kernel test robot <lkp@intel.com>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 2/5] sched: Split out kernel/sched/fair_balance.c from
 kernel/sched/fair.c
Message-ID: <202404071704.0xE8telk-lkp@intel.com>
References: <20240407084319.1462211-3-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407084319.1462211-3-mingo@kernel.org>

Hi Ingo,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[cannot apply to linux/master linus/master peterz-queue/sched/core v6.9-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ingo-Molnar/sched-Split-out-kernel-sched-syscalls-c-from-kernel-sched-core-c/20240407-164646
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20240407084319.1462211-3-mingo%40kernel.org
patch subject: [PATCH 2/5] sched: Split out kernel/sched/fair_balance.c from kernel/sched/fair.c
config: arc-defconfig (https://download.01.org/0day-ci/archive/20240407/202404071704.0xE8telk-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240407/202404071704.0xE8telk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404071704.0xE8telk-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from kernel/sched/core.c:87:
>> kernel/sched/sched.h:3611:22: warning: 'task_h_load' defined but not used [-Wunused-function]
    3611 | static unsigned long task_h_load(struct task_struct *p)
         |                      ^~~~~~~~~~~
--
   arc-elf-ld: kernel/sched/fair.o: in function `switched_from_fair':
>> fair.c:(.text+0x1f0): undefined reference to `update_tg_load_avg'
>> arc-elf-ld: fair.c:(.text+0x1f0): undefined reference to `update_tg_load_avg'
   arc-elf-ld: kernel/sched/fair.o: in function `rq_offline_fair':
>> fair.c:(.text+0x766): undefined reference to `clear_tg_offline_cfs_rqs'
>> arc-elf-ld: fair.c:(.text+0x766): undefined reference to `clear_tg_offline_cfs_rqs'
   arc-elf-ld: fair.c:(.text+0x774): undefined reference to `clear_tg_offline_cfs_rqs'
   arc-elf-ld: fair.c:(.text+0x774): undefined reference to `clear_tg_offline_cfs_rqs'
   arc-elf-ld: kernel/sched/fair.o: in function `switched_to_fair':
   fair.c:(.text+0x158a): undefined reference to `update_tg_load_avg'
   arc-elf-ld: fair.c:(.text+0x158a): undefined reference to `update_tg_load_avg'
   arc-elf-ld: kernel/sched/fair_balance.o: in function `update_load_avg':
>> fair_balance.c:(.text+0x12c8): undefined reference to `update_tg_load_avg'
>> arc-elf-ld: fair_balance.c:(.text+0x12c8): undefined reference to `update_tg_load_avg'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

