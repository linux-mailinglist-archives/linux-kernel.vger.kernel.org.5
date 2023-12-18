Return-Path: <linux-kernel+bounces-3178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1E381686E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9B21F2140A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750F71097A;
	Mon, 18 Dec 2023 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="StO8LOYL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C8F1097E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702888962; x=1734424962;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tkTcv5bmrHK402YQhuTdznF+GjF8kq8FhpYtGcDQ9zY=;
  b=StO8LOYLeQgT6EV8AkvtnkGDX67y31ZQl6DmGliiCBuy501IJk4VCAap
   O8m0Aqs5LawdWCzjLiDgQpsPBe+iuRcHDln5l5FgfISOtzo0o+ufO9Er4
   yrubg4MbtVRr3qutcIpMgALtulr8TIFM5otXpmVrXrXLpOhnmKMfD5GQ2
   YBhF5DGw1hIdKu+CMeJ2in6NMV3kghJ3KL0OwaAYkgdyFZ6OABFEaeDa/
   8GGd4pG+j4a5SnnLDgjobjHbYHjCAi3o2oohP+NFLOqUHffd+ShUNLDX0
   81D8GmynJFmsjCa5bw2ggnY5FwOeTniduW5sKHmUKuwAnt98qs2w+otLi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="2679731"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="2679731"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 00:42:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="919181505"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="919181505"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 18 Dec 2023 00:42:40 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rF9Cw-0003vV-1g;
	Mon, 18 Dec 2023 08:42:38 +0000
Date: Mon, 18 Dec 2023 16:42:15 +0800
From: kernel test robot <lkp@intel.com>
To: Will Deacon <will@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm64/kernel/proton-pack.c:353:1: sparse: sparse: symbol
 '__pcpu_scope_arm64_ssbd_callback_required' was not declared. Should it be
 static?
Message-ID: <202312181617.g7ddtGdE-lkp@intel.com>
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
commit: 5c8b0cbd9d6bac5f40943b5a7d8eac8cb86cbe7f arm64: Pull in task_stack_page() to Spectre-v4 mitigation code
date:   3 years, 3 months ago
config: arm64-randconfig-r112-20231117 (https://download.01.org/0day-ci/archive/20231218/202312181617.g7ddtGdE-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231218/202312181617.g7ddtGdE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312181617.g7ddtGdE-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/arm64/kernel/proton-pack.c:353:1: sparse: sparse: symbol '__pcpu_scope_arm64_ssbd_callback_required' was not declared. Should it be static?

vim +/__pcpu_scope_arm64_ssbd_callback_required +353 arch/arm64/kernel/proton-pack.c

c28762070ca651 Will Deacon 2020-09-18  351  
c28762070ca651 Will Deacon 2020-09-18  352  /* This is the per-cpu state tracking whether we need to talk to firmware */
c28762070ca651 Will Deacon 2020-09-18 @353  DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
c28762070ca651 Will Deacon 2020-09-18  354  

:::::: The code at line 353 was first introduced by commit
:::::: c28762070ca651fe7a981b8f31d972c9b7d2c386 arm64: Rewrite Spectre-v4 mitigation code

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

