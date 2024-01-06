Return-Path: <linux-kernel+bounces-18488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 621C0825E50
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB561F24238
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D384401;
	Sat,  6 Jan 2024 05:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G3Iu396j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4B14409
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704519809; x=1736055809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d/8JurniXPve31+AHDV/0T4KeJPPdZhyFmthF7Cv64U=;
  b=G3Iu396jqEnJZE9ezpYdJeHKTS2CeUFEKEfJ+uk30U92F1Egar08NbQ8
   nV8nXlThOr4ET5CENXPEjOekFXTNLIkee6VYOspMvqs/nwIm8LB3YJXJ7
   hfLvsKjCpPNC2EJrCCejBAveMne2REvPpyHf5gnMKaLPYrQXckqNgK/wi
   EAVDEEN7AYG6PgmGfgPqASpU+T/W/tf+N0gxR+gkx9kPGIF5N6gQ8RdZf
   Vw/jhBM1JJpk12bW6PslULPvJWhGeRH7lUO4c3d0D3TpL+R6FggZq/+6A
   Ekz1KVRhY7NkPWgbTxssNmiV/d4xFkOetrXmGvvmvX1fpB7VIp+oZOFBg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="394812306"
X-IronPort-AV: E=Sophos;i="6.04,336,1695711600"; 
   d="scan'208";a="394812306"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 21:43:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="871404304"
X-IronPort-AV: E=Sophos;i="6.04,336,1695711600"; 
   d="scan'208";a="871404304"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jan 2024 21:43:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLzSn-000250-1D;
	Sat, 06 Jan 2024 05:43:17 +0000
Date: Sat, 6 Jan 2024 13:42:25 +0800
From: kernel test robot <lkp@intel.com>
To: Leonardo Bras <leobras@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Arnd Bergmann <arnd@arndb.de>, Guo Hui <guohui@uniontech.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] arm64: remove unnecessary ifdefs around
 is_compat_task()
Message-ID: <202401061355.h6lWuexc-lkp@intel.com>
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
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20240106/202401061355.h6lWuexc-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240106/202401061355.h6lWuexc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401061355.h6lWuexc-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/arm64/kernel/ptrace.c: In function 'task_user_regset_view':
>> arch/arm64/kernel/ptrace.c:2121:25: error: 'user_aarch32_view' undeclared (first use in this function); did you mean 'user_aarch64_view'?
    2121 |                 return &user_aarch32_view;
         |                         ^~~~~~~~~~~~~~~~~
         |                         user_aarch64_view
   arch/arm64/kernel/ptrace.c:2121:25: note: each undeclared identifier is reported only once for each function it appears in
>> arch/arm64/kernel/ptrace.c:2123:25: error: 'user_aarch32_ptrace_view' undeclared (first use in this function)
    2123 |                 return &user_aarch32_ptrace_view;
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~


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

