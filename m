Return-Path: <linux-kernel+bounces-18974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 253F68265E0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 21:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C501F21494
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 20:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DB1111B0;
	Sun,  7 Jan 2024 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5hI6L9n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA17F11702
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704657831; x=1736193831;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=StplwQhurQ+kA6BviP8xJwLJUUr6O7nFpnpEPFM0aZw=;
  b=m5hI6L9nONJj2or9c95OAkqSCHFtDFqcBC4sZlGVzKIpoD6l3IaqSHVu
   Bw9CIIWrDZ94cPXv2xXXN5xeA8MmAvy9PfM06oVGcaU2vcC5tBslm556I
   eqQk3ZG7edhWI/uf5vCIwSPJljcPNuzL1ZDq3ye8KkTNvBpNIkT8yZnEj
   uIYIPJ1hOYkNw/2IoPcJq8/bWdW80eKxpf2/kE7bk2ktYgRaotwS7MhcH
   Hb3lrKg3I+GPVG8FLElnEDVAaZjgYH+EmU3yYkfNyDX4YRUvwR/3N2nfE
   SguDrD8InL+dgX24/zBpNCsFNMv2lLi5G6XBiofo0l6Epl35KHIIHi7lP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="377238337"
X-IronPort-AV: E=Sophos;i="6.04,339,1695711600"; 
   d="scan'208";a="377238337"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 12:03:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="924673743"
X-IronPort-AV: E=Sophos;i="6.04,339,1695711600"; 
   d="scan'208";a="924673743"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jan 2024 12:03:50 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMZN5-00046K-30;
	Sun, 07 Jan 2024 20:03:47 +0000
Date: Mon, 8 Jan 2024 04:03:01 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Subject: drivers/gpu/drm/gma500/oaktrail_crtc.c:659:30: sparse: sparse:
 symbol 'mrst_clock_funcs' was not declared. Should it be static?
Message-ID: <202401080401.zg9LIvDE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Thomas,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52b1853b080a082ec3749c3a9577f6c71b1d4a90
commit: e40f97ef12772f8eb04b6a155baa1e0e2e8f3ecc drm/gma500: Drop DRM_GMA600 config option
date:   2 years, 11 months ago
config: i386-randconfig-r132-20240106 (https://download.01.org/0day-ci/archive/20240108/202401080401.zg9LIvDE-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240108/202401080401.zg9LIvDE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401080401.zg9LIvDE-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/gma500/oaktrail_crtc.c:659:30: sparse: sparse: symbol 'mrst_clock_funcs' was not declared. Should it be static?

vim +/mrst_clock_funcs +659 drivers/gpu/drm/gma500/oaktrail_crtc.c

1b082ccf590110 Alan Cox         2011-11-03  657  
ac6113ebb70d4b Patrik Jakobsson 2013-11-06  658  /* Not used yet */
ac6113ebb70d4b Patrik Jakobsson 2013-11-06 @659  const struct gma_clock_funcs mrst_clock_funcs = {

:::::: The code at line 659 was first introduced by commit
:::::: ac6113ebb70d4bc7018db4e73f923653347da743 drm/gma500/mrst: Add SDVO clock calculation

:::::: TO: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
:::::: CC: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

