Return-Path: <linux-kernel+bounces-18765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3818262B9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 03:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33EC81C21286
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 02:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE0410A0A;
	Sun,  7 Jan 2024 02:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nrDJc38Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C15F10A05
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 02:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704595307; x=1736131307;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rP4e4imf7/0w/nrJhCf0ozmrrYzpZjzDeaTHDYdDd0s=;
  b=nrDJc38ZGoiF7XO8+8eSxPvvJvl6ih2VMQA4uYl9C8XeuD+v75DFtB8x
   KRJVyAWoAiimOI3tpkgoSuWO91DahchJ20uWll+26AOTbf5pmacH6uho/
   Ezjvhrpj85A48inGrc0V+Hr3OeOUQU/VKZ258/KjIjFmSSqpPP1oVq7Jr
   fIwvxe5dSElfxuJYv/GXNO14LUo8+3pYDOS+hK8ZwdaPKSXZmzq7BkLlr
   42J63K+0uOxGMwHEQlwKDUUz+30f9boznReDVaDz/mdYG2/KGYe3lTEBb
   j6z0oqpfkNimm0HPcb+9xyQhR/lGT3YXEON5nr7kIFiJVGkMP2L3UmpIn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="5053500"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="5053500"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 18:41:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="15583283"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 06 Jan 2024 18:41:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMJ6c-0003Ha-2L;
	Sun, 07 Jan 2024 02:41:42 +0000
Date: Sun, 7 Jan 2024 10:41:28 +0800
From: kernel test robot <lkp@intel.com>
To: Scott Branden <scott.branden@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: <command-line>: warning: '_ttyVK' directive output may be truncated
 writing 6 bytes into a region of size between 3 and 12
Message-ID: <202401071057.z8QE4au9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52b1853b080a082ec3749c3a9577f6c71b1d4a90
commit: 91ca10d6fa0720e35596c720e494d9c18624418a misc: bcm-vk: add ttyVK support
date:   2 years, 11 months ago
config: x86_64-randconfig-004-20240105 (https://download.01.org/0day-ci/archive/20240107/202401071057.z8QE4au9-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401071057.z8QE4au9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401071057.z8QE4au9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/misc/bcm-vk/bcm_vk_dev.c: In function 'bcm_vk_probe':
>> <command-line>: warning: '_ttyVK' directive output may be truncated writing 6 bytes into a region of size between 3 and 12 [-Wformat-truncation=]
   drivers/misc/bcm-vk/bcm_vk_dev.c:1454:31: note: in expansion of macro 'KBUILD_MODNAME'
    1454 |  snprintf(name, sizeof(name), KBUILD_MODNAME ".%d_ttyVK", id);
         |                               ^~~~~~~~~~~~~~
   drivers/misc/bcm-vk/bcm_vk_dev.c:1454:2: note: 'snprintf' output between 15 and 24 bytes into a destination of size 20
    1454 |  snprintf(name, sizeof(name), KBUILD_MODNAME ".%d_ttyVK", id);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

