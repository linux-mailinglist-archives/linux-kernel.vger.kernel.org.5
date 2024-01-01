Return-Path: <linux-kernel+bounces-13810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309638212B6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 02:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E81282B30
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 01:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1515480D;
	Mon,  1 Jan 2024 01:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2VYrUkI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9ED7F9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 01:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704071129; x=1735607129;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C6w+l2ZPWUhwvuXGFonOHIutohbVCvyqePgYrWra590=;
  b=L2VYrUkIyZGOwkpSX6s9biiMTWCC6T6Q4sCzHop+F9RD//lAopxGtZ/Z
   aNT5r/Ma9ERGCku4A3BueJSptfOka6mRHIqjh2ocRRo0vp/wbMsDnVdPd
   7YzNZ0whJKmAXT1ke/fppkQqKbHkjYZh1ktQfroGt4GXhbrH78dhAig1a
   YCvZ4lKvOlTJOkzo08TVcIVugCphK6XVSLyxZLFoVtohj6uoJQ8JuN2VK
   URPouiqDFlp7U3LAjsfmCdSgCpKcW2GDgcCkWZtmaw5z9Petcs1K12DCb
   WqfXhShfb0h7IMORnYtOnN2ukZacwcKibfWPzVTQw3KJcYWXS3jV1Caix
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="18311582"
X-IronPort-AV: E=Sophos;i="6.04,321,1695711600"; 
   d="scan'208";a="18311582"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2023 17:05:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="952576837"
X-IronPort-AV: E=Sophos;i="6.04,321,1695711600"; 
   d="scan'208";a="952576837"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 31 Dec 2023 17:05:27 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rK6k8-000Jsm-2r;
	Mon, 01 Jan 2024 01:05:24 +0000
Date: Mon, 1 Jan 2024 09:05:02 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/debug.c:421:5-8: Unneeded variable: "ret". Return "  0"
 on line 424
Message-ID: <202401010853.ASDxctCq-lkp@intel.com>
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
config: x86_64-randconfig-r064-20231231 (https://download.01.org/0day-ci/archive/20240101/202401010853.ASDxctCq-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401010853.ASDxctCq-lkp@intel.com/

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

