Return-Path: <linux-kernel+bounces-134324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B70C989B054
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1331F214D0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286BD1773A;
	Sun,  7 Apr 2024 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PF4MmWUs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9911DA24
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712484970; cv=none; b=AGdl66THxuVyFGzilTJD5NkfduRG0nwI+6hT0t2d8eKTq6TTgxLSoELU70eCHOLW07vFnlAlzIwJcCobTDTQVwuhJNKl9spchcrPo12R4TlAiiCM7Ez79n22bWCY0X40XUPsJhS590joBlqX620oUH9PKSyGKOEB6p1ZiHnmCPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712484970; c=relaxed/simple;
	bh=xIwoUpAdp5toY3/OAmu6jYhB0B/z+bpifMKPr1wR6ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzJCtCFsSbvL1K7hLHwaq8H3RlLmA/QfuIhbx6GWb79TFr0sUrJtMbj1tKpUlPkTKrQrtC1XaB1vaEp944uJrI91n2a4w91/+Uiq2E4ImsqoKC4VBv8fFIkdMou8V5EzXkqs0xlZVxGbQHgLPtwKjRG8W5oVA0j2kP2Gm+2QosI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PF4MmWUs; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712484969; x=1744020969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xIwoUpAdp5toY3/OAmu6jYhB0B/z+bpifMKPr1wR6ZE=;
  b=PF4MmWUsk8n7zuGjpKyO9VYMio2/GRQMnKk1a9NI8bkGy5x5g9zhxKoQ
   cJ9Sos2p+OmHUKaAPjmDIBrQCg3gn+ZJ4P/biJUj6uAqaC55Ot7nWpEuS
   H4jGCtYbNQ7jExmUH0FO5zJYd+oNjcUgEpT05BkXPvQiN0mWEDclAvuO/
   d9Bhp76ggpKzOaLW15lJ0/xmp1t9plnHPwp1/oRKLGqKb8gZPUsqjQADp
   iYRW5v8kTOKaXu0m+yK96R5VECufIGphT53Aqh++dAoGY4YKXRIDHbhzC
   VHgFY/R2Db8cquBl1Oq3E6gaSmJl1N2ha7/nnNBt6EBQdwpTfrvL3Bpr3
   A==;
X-CSE-ConnectionGUID: rd3B8yxBR0eSNV9MavMOcQ==
X-CSE-MsgGUID: sUJsA7FdQNqtzt7mJ8IqcA==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="30257002"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="30257002"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 03:16:09 -0700
X-CSE-ConnectionGUID: lr9E5ZQJR3SrWWf13jGObg==
X-CSE-MsgGUID: tcTVdeD4RrK0TBrHXl+m9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="24334527"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 07 Apr 2024 03:16:06 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtPZD-0004HW-35;
	Sun, 07 Apr 2024 10:16:04 +0000
Date: Sun, 7 Apr 2024 18:15:38 +0800
From: kernel test robot <lkp@intel.com>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 2/5] sched: Split out kernel/sched/fair_balance.c from
 kernel/sched/fair.c
Message-ID: <202404071825.SlxOD5Yg-lkp@intel.com>
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
[also build test ERROR on next-20240405]
[cannot apply to linux/master linus/master peterz-queue/sched/core v6.9-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ingo-Molnar/sched-Split-out-kernel-sched-syscalls-c-from-kernel-sched-core-c/20240407-164646
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20240407084319.1462211-3-mingo%40kernel.org
patch subject: [PATCH 2/5] sched: Split out kernel/sched/fair_balance.c from kernel/sched/fair.c
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20240407/202404071825.SlxOD5Yg-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240407/202404071825.SlxOD5Yg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404071825.SlxOD5Yg-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: kernel/sched/fair.o: in function `switched_from_fair':
   fair.c:(.text+0x16c): undefined reference to `update_tg_load_avg'
   aarch64-linux-ld: kernel/sched/fair.o: in function `rq_offline_fair':
   fair.c:(.text+0x230): undefined reference to `clear_tg_offline_cfs_rqs'
>> aarch64-linux-ld: fair.c:(.text+0x24c): undefined reference to `clear_tg_offline_cfs_rqs'
   aarch64-linux-ld: kernel/sched/fair.o: in function `switched_to_fair':
   fair.c:(.text+0x87c): undefined reference to `update_tg_load_avg'
   aarch64-linux-ld: kernel/sched/fair_balance.o: in function `update_load_avg':
   fair_balance.c:(.text+0x1520): undefined reference to `update_tg_load_avg'
>> aarch64-linux-ld: fair_balance.c:(.text+0x15ec): undefined reference to `update_tg_load_avg'
   aarch64-linux-ld: fair_balance.c:(.text+0x1608): undefined reference to `update_tg_load_avg'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

