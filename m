Return-Path: <linux-kernel+bounces-2554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62875815EC5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171011F21F11
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D285032C92;
	Sun, 17 Dec 2023 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NslIs9BQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9550932C82
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702813209; x=1734349209;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/eLZtQYxkRy67lkxFvIy6Bo602JD50Nf4iZ5AcyJdJE=;
  b=NslIs9BQhXyUqgfwGyyVHw4NYzrd2UhRnH/FzDk811N1Il8DAS9p/IYO
   mUejTGz4V5ia4f7//42swSRvB+oLEfOzDfM/xQCGFfJYAVoZdxAv3rutw
   2OfHDgIaGLIwP1P5Hu6OwRjbckow38hJLm5ur3cys7F1ZTBkpaljwos8u
   bEblu2jhkN/KJIk9BYfNmUXDVGe7ssgdnoyjPByOaVkuEB33AU2lZj+4f
   mUBjnSwE2uCI9iz7qAlqaHErMSEe5bShYE7c/jcTbSilCgLxPHcAwterq
   54bDiMRZgWncf9N+9Ca2BAnesVK84Ea2Zasfp3I3/SymgWr775XWtBPoA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="375562669"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="375562669"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 03:40:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="724976148"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="724976148"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 Dec 2023 03:40:07 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEpV6-0002z6-2y;
	Sun, 17 Dec 2023 11:40:04 +0000
Date: Sun, 17 Dec 2023 19:39:34 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Subject: include/linux/compiler_types.h:397:45: error: call to
 '__compiletime_assert_810' declared with attribute error: BUILD_BUG_ON
 failed: skb_ext_total_length() > 255
Message-ID: <202312171924.4FozI5FG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b8a9b2e6809d281890dd0a1102dc14d2cd11caf
commit: 5d21d0a65b573507bae774708199328b38dedfe6 net: generalize calculation of skb extensions length
date:   4 months ago
config: um-randconfig-r025-20230617 (https://download.01.org/0day-ci/archive/20231217/202312171924.4FozI5FG-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312171924.4FozI5FG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312171924.4FozI5FG-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function 'skb_extensions_init',
       inlined from 'skb_init' at net/core/skbuff.c:4848:2:
>> include/linux/compiler_types.h:397:45: error: call to '__compiletime_assert_810' declared with attribute error: BUILD_BUG_ON failed: skb_ext_total_length() > 255
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:378:25: note: in definition of macro '__compiletime_assert'
     378 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   net/core/skbuff.c:4800:9: note: in expansion of macro 'BUILD_BUG_ON'
    4800 |         BUILD_BUG_ON(skb_ext_total_length() > 255);
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_810 +397 include/linux/compiler_types.h

eb5c2d4b45e3d2d Will Deacon 2020-07-21  383  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  384  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21  385  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  386  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  387  /**
eb5c2d4b45e3d2d Will Deacon 2020-07-21  388   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  389   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2d Will Deacon 2020-07-21  390   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  391   *
eb5c2d4b45e3d2d Will Deacon 2020-07-21  392   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  393   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  394   * compiler has support to do so.
eb5c2d4b45e3d2d Will Deacon 2020-07-21  395   */
eb5c2d4b45e3d2d Will Deacon 2020-07-21  396  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21 @397  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  398  

:::::: The code at line 397 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

