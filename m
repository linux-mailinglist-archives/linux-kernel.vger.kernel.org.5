Return-Path: <linux-kernel+bounces-18479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBF2825E32
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4728F1F241E1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 04:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E637A1874;
	Sat,  6 Jan 2024 04:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JH0neAiR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F851FAE
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 04:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704515421; x=1736051421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GxgAll06JSrUu0EJvq2url0vnem0z+UeoNCYdhG/ZPQ=;
  b=JH0neAiRfFCIFIByFnLNZciUTtPuw2jSU8xG/kvPlW3nSWrAALe+TSBf
   WLBSee0va6ifkeF+qnqeO9ZZLkLjTr4doP8hxq++OOfqqQBJMzP2pTtca
   EXhYYqBqvzvKP4K2pXcyk0G+lfmz6B1nGnt9VMO6wmL0blh18wZN7j5FJ
   JS4sKxzSOpqn25DuOdxqkIt8GKoVHGiWkmKzhtPzUJp1vV5/ejo3mvuTv
   GB5hic5eK13Pgbtr0WR6SwKihV0TeCvFtX4/MRveqfSFyRRymMSaVYVdk
   Auwqh7hB/v3/aGm9dLFYvHlMZgCcLDnJRX+VZzGY44f2Ys8fxJZfCZ/lN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="401417602"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="401417602"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 20:30:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="784376576"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="784376576"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jan 2024 20:30:17 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLyK7-00021c-26;
	Sat, 06 Jan 2024 04:30:15 +0000
Date: Sat, 6 Jan 2024 12:29:39 +0800
From: kernel test robot <lkp@intel.com>
To: Leonardo Bras <leobras@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Arnd Bergmann <arnd@arndb.de>, Guo Hui <guohui@uniontech.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] arm64: remove unnecessary ifdefs around
 is_compat_task()
Message-ID: <202401061219.Y2LD7LTx-lkp@intel.com>
References: <20240105041458.126602-3-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105041458.126602-3-leobras@redhat.com>

Hi Leonardo,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on linus/master v6.7-rc8 next-20240105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Leonardo-Bras/arm64-remove-unnecessary-ifdefs-around-is_compat_task/20240105-121957
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20240105041458.126602-3-leobras%40redhat.com
patch subject: [PATCH v1 1/1] arm64: remove unnecessary ifdefs around is_compat_task()
config: arm64-randconfig-001-20240105 (https://download.01.org/0day-ci/archive/20240106/202401061219.Y2LD7LTx-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 7e186d366d6c7def0543acc255931f617e76dff0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240106/202401061219.Y2LD7LTx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401061219.Y2LD7LTx-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/arm64/kernel/ptrace.c:2121:11: error: use of undeclared identifier 'user_aarch32_view'; did you mean 'user_aarch64_view'?
    2121 |                 return &user_aarch32_view;
         |                         ^~~~~~~~~~~~~~~~~
         |                         user_aarch64_view
   arch/arm64/kernel/ptrace.c:1591:38: note: 'user_aarch64_view' declared here
    1591 | static const struct user_regset_view user_aarch64_view = {
         |                                      ^
>> arch/arm64/kernel/ptrace.c:2123:11: error: use of undeclared identifier 'user_aarch32_ptrace_view'
    2123 |                 return &user_aarch32_ptrace_view;
         |                         ^
   2 errors generated.


vim +2121 arch/arm64/kernel/ptrace.c

478fcb2cdb2351 Will Deacon     2012-03-05  2111  
478fcb2cdb2351 Will Deacon     2012-03-05  2112  const struct user_regset_view *task_user_regset_view(struct task_struct *task)
478fcb2cdb2351 Will Deacon     2012-03-05  2113  {
5d220ff9420f8b Catalin Marinas 2015-07-14  2114  	/*
5d220ff9420f8b Catalin Marinas 2015-07-14  2115  	 * Core dumping of 32-bit tasks or compat ptrace requests must use the
5d220ff9420f8b Catalin Marinas 2015-07-14  2116  	 * user_aarch32_view compatible with arm32. Native ptrace requests on
5d220ff9420f8b Catalin Marinas 2015-07-14  2117  	 * 32-bit children use an extended user_aarch32_ptrace_view to allow
5d220ff9420f8b Catalin Marinas 2015-07-14  2118  	 * access to the TLS register.
5d220ff9420f8b Catalin Marinas 2015-07-14  2119  	 */
5d220ff9420f8b Catalin Marinas 2015-07-14  2120  	if (is_compat_task())
478fcb2cdb2351 Will Deacon     2012-03-05 @2121  		return &user_aarch32_view;
5d220ff9420f8b Catalin Marinas 2015-07-14  2122  	else if (is_compat_thread(task_thread_info(task)))
5d220ff9420f8b Catalin Marinas 2015-07-14 @2123  		return &user_aarch32_ptrace_view;
e802ab35101cdf Leonardo Bras   2024-01-05  2124  
478fcb2cdb2351 Will Deacon     2012-03-05  2125  	return &user_aarch64_view;
478fcb2cdb2351 Will Deacon     2012-03-05  2126  }
478fcb2cdb2351 Will Deacon     2012-03-05  2127  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

