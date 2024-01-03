Return-Path: <linux-kernel+bounces-15860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D334823467
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EC9CB23402
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B0C1C6AB;
	Wed,  3 Jan 2024 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BRkUyk2f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03341C697
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704306348; x=1735842348;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qVjfK7ocY0Vcg49ICDxWg5QxywlUpTgbFE8aTdhkFTY=;
  b=BRkUyk2fSEwRn2Hut/JuJRYAAbICIIkNWexQACNVuHO9RcKHASYK/+bL
   wLZfyHvThTYTvC1HmjwqgMq4pW7I82emZZslZGAfH/4vElzaLFhdHPVRw
   sQ9ExHuXZiY9X022ZioTOhwtCl4rwoS6BjNeZk+guGPPNcaQYiXM9dYNI
   /yxAftciWzEj0LaIHY3wybaBpDgA5Ib8hmAMptVRSID/m/A+KvzPm78xt
   NGHFxM8K8lqg1QZrK8+/vO9rOC6y+5lO1+kxZTz5G7QjAAtom3MLSB8jb
   nbkdIyxIiSseSyXTmL6RWm0fmO2b2oX6O5AVZ2YoVe+2hW+N+PCNI/U3H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="10641285"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="10641285"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 10:25:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="773208654"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="773208654"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Jan 2024 10:25:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rL5vz-000MQt-2a;
	Wed, 03 Jan 2024 18:25:43 +0000
Date: Thu, 4 Jan 2024 02:24:51 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/debug.c:421:5-8: Unneeded variable: "ret". Return "  0"
 on line 424
Message-ID: <202401040013.fnKkaKkA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   610a9b8f49fbcf1100716370d3b5f6f884a2835a
commit: 1c6fdbd8f2465ddfb73a01ec620cbf3d14044e1a bcachefs: Initial commit
date:   2 months ago
config: x86_64-randconfig-r064-20231231 (https://download.01.org/0day-ci/archive/20240104/202401040013.fnKkaKkA-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401040013.fnKkaKkA-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/bcachefs/debug.c:421:5-8: Unneeded variable: "ret". Return "  0" on line 424
--
>> fs/bcachefs/super.c:712:35-36: Unneeded semicolon

vim +421 fs/bcachefs/debug.c

   418	
   419	int __init bch2_debug_init(void)
   420	{
 > 421		int ret = 0;
   422	
   423		bch_debug = debugfs_create_dir("bcachefs", NULL);
 > 424		return ret;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

