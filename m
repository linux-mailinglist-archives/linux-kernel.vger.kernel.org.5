Return-Path: <linux-kernel+bounces-18766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 163A88262BA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 03:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC4F1C212E3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 02:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0094710A2A;
	Sun,  7 Jan 2024 02:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDETXhAZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD43F10A12
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 02:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704595310; x=1736131310;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VuRszPXM4GingMQhdsdvHHLPyUzprXGHa8cmCzT4HKY=;
  b=RDETXhAZ8F/DHmDawewQHBdFRRAxD8cBSKNNL9HqBSlE1Qi0lIKED50j
   28J0O8/YIo5ThQ/xmDHOLdqLLkpw/5WfE+Hwx3++zA4tn6WdNd6tsxkUQ
   pniUO5cXm32q7A2ySNb3hz+jPcjFVnq/q68LVzjqY3PCOA7ZOG82rLTTE
   g+r5ds9XcO013l5BhXAa5enCs6m2d5A64Yujx4RH+OgFPUeO7Kz5OAIqZ
   kY5sWm7etNAKTED3vOgQNwqNbMvhkr/029+jI+cAkSvks3eYNJ2YBncnI
   BF7DN/6A7xZdSS4MV9J1vmtJxsmYNkomdsq4dtnvopaavjkuTTEMUayQQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="5053501"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="5053501"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 18:41:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="15583282"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 06 Jan 2024 18:41:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMJ6c-0003HY-2F;
	Sun, 07 Jan 2024 02:41:42 +0000
Date: Sun, 7 Jan 2024 10:41:27 +0800
From: kernel test robot <lkp@intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: kernel/crash_core.c:749:1: sparse: sparse: symbol
 '__crash_hotplug_lock' was not declared. Should it be static?
Message-ID: <202401071026.CeGunEjw-lkp@intel.com>
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
commit: e2a8f20dd8e9df695f736e51cd9115ae55be92d1 Crash: add lock to serialize crash hotplug handling
date:   3 months ago
config: i386-randconfig-061-20240106 (https://download.01.org/0day-ci/archive/20240107/202401071026.CeGunEjw-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401071026.CeGunEjw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401071026.CeGunEjw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/crash_core.c:749:1: sparse: sparse: symbol '__crash_hotplug_lock' was not declared. Should it be static?

vim +/__crash_hotplug_lock +749 kernel/crash_core.c

   741	
   742	/*
   743	 * Different than kexec/kdump loading/unloading/jumping/shrinking which
   744	 * usually rarely happen, there will be many crash hotplug events notified
   745	 * during one short period, e.g one memory board is hot added and memory
   746	 * regions are online. So mutex lock  __crash_hotplug_lock is used to
   747	 * serialize the crash hotplug handling specifically.
   748	 */
 > 749	DEFINE_MUTEX(__crash_hotplug_lock);
   750	#define crash_hotplug_lock() mutex_lock(&__crash_hotplug_lock)
   751	#define crash_hotplug_unlock() mutex_unlock(&__crash_hotplug_lock)
   752	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

