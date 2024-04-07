Return-Path: <linux-kernel+bounces-134535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCB589B2B0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88101C21296
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C38139FD6;
	Sun,  7 Apr 2024 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kmsuqKaB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CDF38DD3
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712503275; cv=none; b=eITvbE+ihLKzUEIXpNzyyZuyWRDQnGds3VMc0QWmN/Z0WIgqupUfrjZQNS3TFLXz8gMpikTjCHbcpzQWuf9Ksl227NqYxEmde1iHzqxpxx83WKBAyqGrlili+ducUNjafPz0KkIrw69NGbxEb31736HiWCSnjdNwXDZqm69BgDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712503275; c=relaxed/simple;
	bh=wat1R7DZ6VZuQ7VIDgkqfyRCviEmcJNKK93KLgPTrVc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nYtMQU84YTGTdm6VupJdvmrBuMFv0s3lyu3Jh4GYlHGlUp32SUj8+JG7S1QhU4xUFtVlnQKzgjJm5tO1S/bnF4oynCVaCwKS9J87uvfZ0VOyFs5zp7uA8MXV9SE3Mhjho4Wy78CjMkjGFE8w8gHrts634HTLEBUXevv8faN8/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kmsuqKaB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712503274; x=1744039274;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wat1R7DZ6VZuQ7VIDgkqfyRCviEmcJNKK93KLgPTrVc=;
  b=kmsuqKaBOVpnpVyW6nCrDsClD7/I3czEB2dTXZwXduTpLJOo81BCsgWc
   LS2HFsF7WAcrbAxOhO3TwptcLcjfsWaO/OXcPJwd8ge7JdgALnGs/X0m9
   paDr0W0+jfiGUbUQbZP8Mm2JS/DcGqmP4r0rcNU+CAoO4Qf9PEte+HOHY
   nfMfLiRZwmaZU8jXFVKCjNMjoscTbkxiDAcYPR82aFUKjzCgpQ7JQ1w1z
   JoTLKceA5ukiRqjEAsrM+D5OUbdgKEdzCIkRHupzpfyjnwnPjWBcGIG3z
   SKAiJqo7yku3pw8ozvKUffpLJ6FwE6CM6Czinm2G+0td46M03I0p6qXkC
   g==;
X-CSE-ConnectionGUID: m2bBRAvIR/eJNKIgmHoGwQ==
X-CSE-MsgGUID: DMOT2D1jRBuJE/xyxzU2nQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7907139"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="7907139"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 08:21:13 -0700
X-CSE-ConnectionGUID: AWHfP/q1Rd2mW6fItzofTQ==
X-CSE-MsgGUID: boxD/Y99RyuS4VV/BVhF1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="19703031"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 07 Apr 2024 08:21:11 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtUKT-0004QQ-1P;
	Sun, 07 Apr 2024 15:21:09 +0000
Date: Sun, 7 Apr 2024 23:20:42 +0800
From: kernel test robot <lkp@intel.com>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>
Subject: include/linux/compiler_types.h:397:45: error: call to
 '__compiletime_assert_405' declared with attribute error: BUILD_BUG_ON
 failed: sizeof(mstat) > sizeof(skb->cb)
Message-ID: <202404072357.9jgMQDqd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Shayne,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f2f80ac809875855ac843f9e5e7480604b5cbff5
commit: 021af945997ffaeaa37c9673d71afad7cde6bdef wifi: mt76: mt7996: add eht rx rate support
date:   12 months ago
config: arm-randconfig-r132-20240407 (https://download.01.org/0day-ci/archive/20240407/202404072357.9jgMQDqd-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240407/202404072357.9jgMQDqd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404072357.9jgMQDqd-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function 'mt76_rx_convert',
       inlined from 'mt76_rx_complete' at drivers/net/wireless/mediatek/mt76/mac80211.c:1334:3:
>> include/linux/compiler_types.h:397:45: error: call to '__compiletime_assert_405' declared with attribute error: BUILD_BUG_ON failed: sizeof(mstat) > sizeof(skb->cb)
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
   drivers/net/wireless/mediatek/mt76/mac80211.c:1094:9: note: in expansion of macro 'BUILD_BUG_ON'
    1094 |         BUILD_BUG_ON(sizeof(mstat) > sizeof(skb->cb));
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_405 +397 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  383  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  384  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  385  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  386  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  387  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  388   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  389   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  390   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  391   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  392   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  393   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  394   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  395   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  396  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @397  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  398  

:::::: The code at line 397 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

