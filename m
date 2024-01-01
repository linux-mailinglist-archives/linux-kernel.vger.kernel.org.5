Return-Path: <linux-kernel+bounces-13921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3888214DF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 19:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895B72817A1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 18:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40579466;
	Mon,  1 Jan 2024 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSbo2lha"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41929464
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704132267; x=1735668267;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ClRxqLTt7P2XQaoo1agAlUF9CkJ9L/WqjF5rQhuiTiM=;
  b=nSbo2lha3WosrXkVZz394wfHlRw+hvMoNpRHuK1PN+Op6qI4aKRJS3nm
   +ReI1HhHCp7PBkd9SEDE3Z895/Poi6ykjrH43YgplTSt8OWLlMI1IyVaj
   W6RBqkHg3jUryI1GJvrSSV+NOFYydSuawaFig1jZSZfc0h0h1YbDRaWpZ
   BGGfmtjq+N9078ECpzvsWXSep+t0n3SBIXpwuRdxcb97PCHLx7UW1URKx
   NPpkflEnWfTnsptouBdy9qBTfTGlrOOSPbZQRWt2KPaER3l7VO4ttCp20
   EiFM1GfBsFFJkVGSnTfIQ9Dq5JFMT6zuuKD7+uO3HgD4MGI5b2rUigKXk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="18351978"
X-IronPort-AV: E=Sophos;i="6.04,322,1695711600"; 
   d="scan'208";a="18351978"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 10:04:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="1026566887"
X-IronPort-AV: E=Sophos;i="6.04,322,1695711600"; 
   d="scan'208";a="1026566887"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 01 Jan 2024 10:04:25 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rKMeE-000KSy-1v;
	Mon, 01 Jan 2024 18:04:22 +0000
Date: Tue, 2 Jan 2024 02:03:53 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/debug.c:421:5-8: Unneeded variable: "ret". Return "  0"
 on line 424
Message-ID: <202401020115.nzTxExZr-lkp@intel.com>
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
config: x86_64-randconfig-r064-20231231 (https://download.01.org/0day-ci/archive/20240102/202401020115.nzTxExZr-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401020115.nzTxExZr-lkp@intel.com/

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

