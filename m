Return-Path: <linux-kernel+bounces-19004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E13482665B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 23:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F771F2147D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BC0125CE;
	Sun,  7 Jan 2024 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lCf6z4E4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFD611C89
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704666183; x=1736202183;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HMj843mC5kF19nX71tADQb2uwOdpYpgbOkjxDPCIjP4=;
  b=lCf6z4E4wE9U9Umbzt2jkwzuWlmY+IJqMyWkmbjSMQqLI33qZ+nJa4Iu
   5rJGaIZxMDH8KGxN6kW7xniZFEi/WIV6yYHdr7J5OEUJbO4xV4of1qFGE
   jsnghCy0cqgoaic0YhOpIBQRCdkUqlnc1sOMcRmZIKb1bkfxtm+/CRk+6
   +uzr2gxW0Ms9pUfDW4t/8IbFRtBUZ8Xl2A1PxG5P9//n03Devz5obPb4S
   D2NWCaRpdtcyFz+eXExJZwEw1zvv9JnL5M8SVaqD5UkjjpFB7v1TBHLbe
   M/kcVt8YuNTuJg0c93gdKzfZTo/B0QpBPHUuN7IQn9Duv3Pcvx+AXONsa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="16360308"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="16360308"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 14:23:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="1028230076"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="1028230076"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jan 2024 14:22:59 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMbXl-0004Cy-1e;
	Sun, 07 Jan 2024 22:22:57 +0000
Date: Mon, 8 Jan 2024 06:22:01 +0800
From: kernel test robot <lkp@intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: kernel/crash_core.c:749:1: sparse: sparse: symbol
 '__crash_hotplug_lock' was not declared. Should it be static?
Message-ID: <202401080654.IjjU5oK7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0dd3ee31125508cd67f7e7172247f05b7fd1753a
commit: e2a8f20dd8e9df695f736e51cd9115ae55be92d1 Crash: add lock to serialize crash hotplug handling
date:   3 months ago
config: i386-randconfig-061-20240106 (https://download.01.org/0day-ci/archive/20240108/202401080654.IjjU5oK7-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240108/202401080654.IjjU5oK7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401080654.IjjU5oK7-lkp@intel.com/

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

