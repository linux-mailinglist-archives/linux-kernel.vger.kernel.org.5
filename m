Return-Path: <linux-kernel+bounces-43-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9582B813B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408431F20F07
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C31F6A036;
	Thu, 14 Dec 2023 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXhVKxxS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05A06AB97
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702583713; x=1734119713;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KrEvdN/QMfbJApQ3NCnVm+pyddsL1NNtcchrCybsBdY=;
  b=LXhVKxxS4Ek6G0ESY52xb3cSyX09oMBpc3C/ilF34Rj6uhLYK0+kRfg6
   8BOdDWvolbOWzrXVFFgGlFCgx0n7cBdtwRqRO4T/BucqSCYhmHIJQDMWq
   v+Vf2nhwgsVaV+JlA/y6yXyAtnbXJKZz1lP/T07tmoR/Vm7yHp9erP/Gs
   NwVDdvhM/NfYHSX6Bz06stF9fVUmcZ390BjLjkcNe+E/GBd92AY3c2aoY
   t/jHu6BHva7RARHWWetdRpBF6TPGMxxNm7QtZelr8W3B8Nd5KqP/nqS9E
   7k3syJru+Gf+4+DY61e+WIfvB57AcxF8aWtCThyN7OOd/hG4qnKlydQzk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="374683619"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="374683619"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 11:55:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="767720028"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="767720028"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 14 Dec 2023 11:55:10 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDrnX-000MWe-31;
	Thu, 14 Dec 2023 19:55:07 +0000
Date: Fri, 15 Dec 2023 03:54:44 +0800
From: kernel test robot <lkp@intel.com>
To: Zack Rusin <zackr@vmware.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Martin Krastev <krastevm@vmware.com>,
	Maaz Mombasawala <mombasawalam@vmware.com>
Subject: drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:76: warning: Excess struct
 member 'transfer' description in 'vmw_stdu_dirty'
Message-ID: <202312150347.5icezNlK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: 39985eea5a6dd1e844f216028252870e980b9e7f drm/vmwgfx: Abstract placement selection
date:   10 months ago
config: i386-buildonly-randconfig-004-20231214 (https://download.01.org/0day-ci/archive/20231215/202312150347.5icezNlK-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150347.5icezNlK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150347.5icezNlK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:76: warning: Excess struct member 'transfer' description in 'vmw_stdu_dirty'


vim +76 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c

35c051258e8fd7 Sinclair Yeh     2015-06-26  51  
6bf6bf03b37b5b Thomas Hellstrom 2015-06-26  52  /**
6bf6bf03b37b5b Thomas Hellstrom 2015-06-26  53   * struct vmw_stdu_dirty - closure structure for the update functions
6bf6bf03b37b5b Thomas Hellstrom 2015-06-26  54   *
6bf6bf03b37b5b Thomas Hellstrom 2015-06-26  55   * @base: The base type we derive from. Used by vmw_kms_helper_dirty().
6bf6bf03b37b5b Thomas Hellstrom 2015-06-26  56   * @transfer: Transfer direction for DMA command.
6bf6bf03b37b5b Thomas Hellstrom 2015-06-26  57   * @left: Left side of bounding box.
6bf6bf03b37b5b Thomas Hellstrom 2015-06-26  58   * @right: Right side of bounding box.
6bf6bf03b37b5b Thomas Hellstrom 2015-06-26  59   * @top: Top side of bounding box.
6bf6bf03b37b5b Thomas Hellstrom 2015-06-26  60   * @bottom: Bottom side of bounding box.
a1ac6339123051 Sinclair Yeh     2017-06-02  61   * @fb_left: Left side of the framebuffer/content bounding box
a1ac6339123051 Sinclair Yeh     2017-06-02  62   * @fb_top: Top of the framebuffer/content bounding box
1856a91691e40e Lee Jones        2021-01-15  63   * @pitch: framebuffer pitch (stride)
f1d34bfd70b1b4 Thomas Hellstrom 2018-06-19  64   * @buf: buffer object when DMA-ing between buffer and screen targets.
6bf6bf03b37b5b Thomas Hellstrom 2015-06-26  65   * @sid: Surface ID when copying between surface and screen targets.
6bf6bf03b37b5b Thomas Hellstrom 2015-06-26  66   */
6bf6bf03b37b5b Thomas Hellstrom 2015-06-26  67  struct vmw_stdu_dirty {
6bf6bf03b37b5b Thomas Hellstrom 2015-06-26  68  	struct vmw_kms_dirty base;
6bf6bf03b37b5b Thomas Hellstrom 2015-06-26  69  	s32 left, right, top, bottom;
a1ac6339123051 Sinclair Yeh     2017-06-02  70  	s32 fb_left, fb_top;
6bf6bf03b37b5b Thomas Hellstrom 2015-06-26  71  	u32 pitch;
6bf6bf03b37b5b Thomas Hellstrom 2015-06-26  72  	union {
09881d2940bbd6 Zack Rusin       2023-01-30  73  		struct vmw_bo *buf;
6bf6bf03b37b5b Thomas Hellstrom 2015-06-26  74  		u32 sid;
6bf6bf03b37b5b Thomas Hellstrom 2015-06-26  75  	};
6bf6bf03b37b5b Thomas Hellstrom 2015-06-26 @76  };
6bf6bf03b37b5b Thomas Hellstrom 2015-06-26  77  

:::::: The code at line 76 was first introduced by commit
:::::: 6bf6bf03b37b5ba0f3399fa9bb3d62edfa117c87 drm/vmwgfx: Convert screen targets to new helpers v3

:::::: TO: Thomas Hellstrom <thellstrom@vmware.com>
:::::: CC: Thomas Hellstrom <thellstrom@vmware.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

