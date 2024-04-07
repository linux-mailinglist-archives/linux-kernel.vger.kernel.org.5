Return-Path: <linux-kernel+bounces-134345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5C289B083
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE80281EF6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E461CFAF;
	Sun,  7 Apr 2024 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIJfe4Zp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D97017577
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 10:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712487492; cv=none; b=GF+vbCS5IdzqUUi6GhZd1GBBbmIUgSua5EHefsidjcWXhwSGoGTP78kOQSZ33XoeqI21X5pv9BsmPudcshBNBiPXFMOf3boy6uEYr5tcRZyEeD/iPXlmwwsy4hehfPrRDtqHJmCiqJveYVWiuGU/Rw+06X/XlVLrxl4OqP+Xcok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712487492; c=relaxed/simple;
	bh=hjTKP6fZ9KKik1egs72yhVaDTZdwdmePeVPd40HuwJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CO7J1dH9D70BVuw5TbnYfXQS0UfqIXBrarV5noGR4ZoFni4uGLmQvTnyUWQY3jT8CmHfUc6csHUvoUdG9Ijj4D82TOThRHzP/8V1gl4/a/YZwA/KAkck6mwPaOHxrOnSF14b4s9+ApBJobevU8Gvq/MCo34t2gMeFBJRw8ebfjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oIJfe4Zp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712487489; x=1744023489;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hjTKP6fZ9KKik1egs72yhVaDTZdwdmePeVPd40HuwJQ=;
  b=oIJfe4ZpKlleNnVFrzs7UTGtIe1yrdpqFl9b8YXI2MNft7vP+tNwfSAL
   muHi6qEOkvC1CkqvEJx3iQy+PeXv0Kg5lKxZVUeV8P0kpc4NVIninHOzg
   TenSQj4jZN6lhMuxvQreC0MtCqGB3bzN4vqUH036XJOHbChoDChcKmh1H
   hZMUB5czWbxAsRk9GkT88lsw3ticxzEf7AxzNiM+vcXO0lKFInkcK+Zo5
   SkVcPOSMbkcNxuYu1fBDKcyDhgfzP7HXJ6sXe2sDFCpJarlBZ5tAnOmCq
   Y9TGtM9nODUIs/qmG/cnHfR6WjGXVdfmrEN+f+ZsI+mtu41WxUJuy+woi
   A==;
X-CSE-ConnectionGUID: Pxfho+gSRUi0jOOugfbPhg==
X-CSE-MsgGUID: ngvOk+OfQBa2rpgxMeX63Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="7999076"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="7999076"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 03:58:08 -0700
X-CSE-ConnectionGUID: pCi6pWYxR8SQRwjnA1i7WA==
X-CSE-MsgGUID: y76nr7A5RoCeOj08xX1vlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="24340114"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 07 Apr 2024 03:58:07 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtQDs-0004JC-2l;
	Sun, 07 Apr 2024 10:58:04 +0000
Date: Sun, 7 Apr 2024 18:57:43 +0800
From: kernel test robot <lkp@intel.com>
To: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: include/linux/compiler_types.h:357:45: error: call to
 '__compiletime_assert_304' declared with attribute error: BUILD_BUG_ON
 failed: sizeof(priv_tbl->probs) % 16
Message-ID: <202404071853.zF9y90RI-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrzej,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f2f80ac809875855ac843f9e5e7480604b5cbff5
commit: 00c47aa85bb26450edc6059c3d245de062e60b5d media: rkvdec: Add required padding
date:   1 year, 5 months ago
config: arm-randconfig-r132-20240407 (https://download.01.org/0day-ci/archive/20240407/202404071853.zF9y90RI-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240407/202404071853.zF9y90RI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404071853.zF9y90RI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/staging/media/rkvdec/rkvdec-vp9.c: In function 'rkvdec_vp9_start':
>> include/linux/compiler_types.h:357:45: error: call to '__compiletime_assert_304' declared with attribute error: BUILD_BUG_ON failed: sizeof(priv_tbl->probs) % 16
     357 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:338:25: note: in definition of macro '__compiletime_assert'
     338 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:357:9: note: in expansion of macro '_compiletime_assert'
     357 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   drivers/staging/media/rkvdec/rkvdec-vp9.c:1011:9: note: in expansion of macro 'BUILD_BUG_ON'
    1011 |         BUILD_BUG_ON(sizeof(priv_tbl->probs) % 16); /* ensure probs size is 128-bit aligned */
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_304 +357 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  343  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  344  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  345  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  346  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  347  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  348   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  349   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  350   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  351   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  352   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  353   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  354   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  355   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  356  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @357  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  358  

:::::: The code at line 357 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

