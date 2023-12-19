Return-Path: <linux-kernel+bounces-6103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEE28194A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63931F225EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362DB3EA8E;
	Tue, 19 Dec 2023 23:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XT0+0XE3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093043EA95
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703028874; x=1734564874;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RqK0RHBgi2XTvZJdYDKldZmNY3YJ4YPCIyqnNn7bnZE=;
  b=XT0+0XE3pGzSVVVgtk8GXM/+I8KXuyidGrNd0WlC7XGyUMRcAT6iPzKF
   FV9AuGsIB3BEvX8C4s5sgTs17ZIOoZHTk0JDUU/heOEZJEWp/PtTWBaBH
   aAl7MbZqupWIThn4sBE3G/m6ebYo852mM5hXXMzsT8a5cnRCxOYiTri3x
   fDqy3ktfaqdPgMnidSDf+KX7qiYTFxGijndqs59rhCSgxVxmHdcoF9M1+
   UOxctYDc6nlLh4MLPXpeKLjmj87ZpSFkpCRaB2WLNoDl2MKDbOicoqK/I
   HKExR3eYCXZBn7KSC3zjFPYPnoxX4kNQa8C7YJeWf2t1B9Uu2/1RYn3kj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2585985"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="2585985"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 15:34:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="866795396"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="866795396"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Dec 2023 15:34:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFjbX-00065F-1n;
	Tue, 19 Dec 2023 23:34:27 +0000
Date: Wed, 20 Dec 2023 07:33:41 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: kernel/seccomp.c:1386:1: sparse: sparse: Using plain integer as NULL
 pointer
Message-ID: <202312200703.AoSwZY1b-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   55cb5f43689d7a9ea5bf35ef050f12334f197347
commit: aa0d6e70d3b34e710a6a57a53a3096cb2e0ea99f s390: autogenerate compat syscall wrappers
date:   4 years, 11 months ago
config: s390-randconfig-r111-20231116 (https://download.01.org/0day-ci/archive/20231220/202312200703.AoSwZY1b-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231220/202312200703.AoSwZY1b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312200703.AoSwZY1b-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/seccomp.c:1386:1: sparse: sparse: Using plain integer as NULL pointer
>> kernel/seccomp.c:1386:1: sparse: sparse: Using plain integer as NULL pointer
--
>> ipc/syscall.c:110:1: sparse: sparse: Using plain integer as NULL pointer
>> ipc/syscall.c:110:1: sparse: sparse: Using plain integer as NULL pointer

vim +1386 kernel/seccomp.c

48dc92b9fc3926 Kees Cook      2014-06-25  1385  
48dc92b9fc3926 Kees Cook      2014-06-25 @1386  SYSCALL_DEFINE3(seccomp, unsigned int, op, unsigned int, flags,
a5662e4d81c4d4 Tycho Andersen 2018-12-09  1387  			 void __user *, uargs)
48dc92b9fc3926 Kees Cook      2014-06-25  1388  {
48dc92b9fc3926 Kees Cook      2014-06-25  1389  	return do_seccomp(op, flags, uargs);
48dc92b9fc3926 Kees Cook      2014-06-25  1390  }
48dc92b9fc3926 Kees Cook      2014-06-25  1391  

:::::: The code at line 1386 was first introduced by commit
:::::: 48dc92b9fc3926844257316e75ba11eb5c742b2c seccomp: add "seccomp" syscall

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

