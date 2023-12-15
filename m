Return-Path: <linux-kernel+bounces-1581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C17981506D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F2B286469
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9495B41864;
	Fri, 15 Dec 2023 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UPWS7jS8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED594185D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702670182; x=1734206182;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=acJlvMw5Znz1M/iFhdl4rivuaRk5KB2V/iCV4xMppJA=;
  b=UPWS7jS8o/djYoYdip8un0HrVo2rl34hQBFqGndNkXR4st1Lservx+oK
   rVAiejoQh1lfGtQdGj5TMiiDcYl0DPS2s+3fSZDnEk6g0UQX5yxWg4NMp
   tq5S/ZdJ5VsIq0zHIKKDx5l9MpN+3SeG0A6flxbnKMjO0jpbm51LEZJ7+
   SMVL4dwXjBB1m1j1KpWA0Lp5UFX55buLRh0S/k5aQ8LjiCVia/cfEJc94
   uE4GdlQp6Y/oZRTF86fxSgeVrP5w9qwkdrkE0IRD4hkUxhUtqntogObXd
   lXpM2wesIbOk3S721uXet0MK9NHCMLGqJ/nYwnMZzbz2mvKwiVj3Izrjf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2144224"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="2144224"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 11:56:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="840775792"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="840775792"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 15 Dec 2023 11:56:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEEID-0000gQ-2R;
	Fri, 15 Dec 2023 19:56:17 +0000
Date: Sat, 16 Dec 2023 03:55:47 +0800
From: kernel test robot <lkp@intel.com>
To: Jan Kara <jack@suse.cz>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: scripts/kernel-doc: kernel/power/swap.c:1573: warning: Excess
 function parameter 'exclusive' description in 'swsusp_close'
Message-ID: <202312160357.9wW84gew-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3f7168591ebf7bbdb91797d02b1afaf00a4289b1
commit: 93745df18e52157778a8a74cb888ac785844a7fe PM: hibernate: Drop unused snapshot_test argument
date:   7 weeks ago
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20231216/202312160357.9wW84gew-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312160357.9wW84gew-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312160357.9wW84gew-lkp@intel.com/

All warnings (new ones prefixed by >>):

   scripts/kernel-doc: kernel/power/swap.c:544: warning: Function parameter or struct member 'handle' not described in 'save_image'
   scripts/kernel-doc: kernel/power/swap.c:544: warning: Function parameter or struct member 'snapshot' not described in 'save_image'
   scripts/kernel-doc: kernel/power/swap.c:544: warning: Function parameter or struct member 'nr_to_write' not described in 'save_image'
   scripts/kernel-doc: kernel/power/swap.c:891: warning: Function parameter or struct member 'nr_pages' not described in 'enough_swap'
   scripts/kernel-doc: kernel/power/swap.c:1062: warning: Function parameter or struct member 'handle' not described in 'load_image'
   scripts/kernel-doc: kernel/power/swap.c:1062: warning: Function parameter or struct member 'snapshot' not described in 'load_image'
   scripts/kernel-doc: kernel/power/swap.c:1062: warning: Function parameter or struct member 'nr_to_read' not described in 'load_image'
>> scripts/kernel-doc: kernel/power/swap.c:1573: warning: Excess function parameter 'exclusive' description in 'swsusp_close'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

