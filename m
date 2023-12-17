Return-Path: <linux-kernel+bounces-2458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06845815D71
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 06:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3EF1C210D8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 05:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E37139C;
	Sun, 17 Dec 2023 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RflyomeA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9770CEDD
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 05:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702789703; x=1734325703;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZGw2qXZRFHulrf191uQ+wySX4ZxgPmFL+ZDX6mDAxm0=;
  b=RflyomeAgShmaxsfretdml/XWeYYxPWfBhZpphEDd0j7PqvUN907aG/o
   RJenjWKUH8OHSqei9o/6rgvVzROTJAtgAoaRpRa05RAfMdsLK/E4ticde
   6ypMQWQTtBK2v2JJSIFL6hM5gG+vELI3IN/v/neh6CrmmCHvlspoIrZzm
   Eqnxg0SwHPM/cODFdryd7vlux76EsdcJyL3s4lKl/z3xFqS6yf8N1yrJh
   HOX1G2aSeiCH8yPFGK7w1ykArWvI0UUsyMlEgglTEnIEp8LJxkUH01LGA
   nRlk2QykqzCj/ZmdGRHwByHQBJQ6AuFOSSV0UoSOF8/y+z8hrxr33PlaJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="2594522"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="2594522"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 21:08:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="918884854"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="918884854"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Dec 2023 21:08:20 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEjNy-0002g0-1I;
	Sun, 17 Dec 2023 05:08:18 +0000
Date: Sun, 17 Dec 2023 13:07:31 +0800
From: kernel test robot <lkp@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Luben Tuikov <luben.tuikov@amd.com>
Subject: scripts/kernel-doc: drivers/gpu/drm/scheduler/sched_main.c:266:
 warning: Function parameter or struct member 'result' not described in
 'drm_sched_job_done'
Message-ID: <202312171356.YQPJrHkh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b8a9b2e6809d281890dd0a1102dc14d2cd11caf
commit: 539f9ee4b52a8bec95ff064e22dd2fb1e258e818 drm/scheduler: properly forward fence errors
date:   8 months ago
config: arc-randconfig-001-20231215 (https://download.01.org/0day-ci/archive/20231217/202312171356.YQPJrHkh-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312171356.YQPJrHkh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312171356.YQPJrHkh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> scripts/kernel-doc: drivers/gpu/drm/scheduler/sched_main.c:266: warning: Function parameter or struct member 'result' not described in 'drm_sched_job_done'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

