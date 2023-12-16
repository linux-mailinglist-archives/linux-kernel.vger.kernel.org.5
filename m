Return-Path: <linux-kernel+bounces-2388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D60D815C1B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 23:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D9DAB22C5F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 22:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C450358BD;
	Sat, 16 Dec 2023 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9HV/XlY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFB637D04
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702765443; x=1734301443;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=D8fiWymcdUr4qqBoDqojYh5DqPjj0hUvtMnIaHi7elM=;
  b=K9HV/XlYN4Fks+L8sv6RJTHA+xIaIUVKjWp16YRYBWl/ZZI8H62QTKcz
   gNCEVCo69VD+oijCt5caTv2zQB9DGJrfY1MBGUjtyvw7W1G1zoDo82ulG
   04TEjkGS1msUQSRtQ5h4GUMeqH/Lq8NDGmjp+GRx6AEKYhWQ7SVvzFJ0f
   xWX3A4uZcOdS+njVVWOO0ZHMolyAbOkMQqlT3ZTIKVQ7v6wVKYyphk7FU
   fIQiQWgcxGOeBCJFcHexPItVanl0o8pHM+4febNHKGNA7XJsakpJNcEbP
   O1rIwTfet9P3JlvNUAVIMlPx65P0MZmpYDBM91i8Oq53GlJMqAtndCtcr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="461847905"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="461847905"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 14:24:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="918826484"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="918826484"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Dec 2023 14:24:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEd4h-0002H0-1s;
	Sat, 16 Dec 2023 22:23:59 +0000
Date: Sun, 17 Dec 2023 06:23:03 +0800
From: kernel test robot <lkp@intel.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/opp/debugfs.c:48:54: warning: '%d' directive output may be
 truncated writing between 1 and 11 bytes into a region of size 8
Message-ID: <202312170608.s9xI4TQb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Viresh,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b8a9b2e6809d281890dd0a1102dc14d2cd11caf
commit: 46f48aca2e5aef3f430e95d1a5fb68227ec8ec85 OPP: Fix missing debugfs supply directory for OPPs
date:   5 years ago
config: x86_64-randconfig-a006-20230623 (https://download.01.org/0day-ci/archive/20231217/202312170608.s9xI4TQb-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312170608.s9xI4TQb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312170608.s9xI4TQb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/opp/debugfs.c: In function 'opp_debug_create_one':
>> drivers/opp/debugfs.c:48:54: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Wformat-truncation=]
      48 |                 snprintf(name, sizeof(name), "supply-%d", i);
         |                                                      ^~
   In function 'opp_debug_create_supplies',
       inlined from 'opp_debug_create_one' at drivers/opp/debugfs.c:119:7:
   drivers/opp/debugfs.c:48:46: note: directive argument in the range [-2147483644, 2147483646]
      48 |                 snprintf(name, sizeof(name), "supply-%d", i);
         |                                              ^~~~~~~~~~~
   drivers/opp/debugfs.c:48:17: note: 'snprintf' output between 9 and 19 bytes into a destination of size 15
      48 |                 snprintf(name, sizeof(name), "supply-%d", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +48 drivers/opp/debugfs.c

deaa51465105a7 drivers/base/power/opp/debugfs.c Viresh Kumar 2015-11-11  37  
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  38  static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  39  				      struct opp_table *opp_table,
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  40  				      struct dentry *pdentry)
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  41  {
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  42  	struct dentry *d;
1fae788ed640e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2017-05-23  43  	int i;
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  44  
1fae788ed640e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2017-05-23  45  	for (i = 0; i < opp_table->regulator_count; i++) {
d741029a239040 drivers/opp/debugfs.c            Arvind Yadav 2017-09-21  46  		char name[15];
d741029a239040 drivers/opp/debugfs.c            Arvind Yadav 2017-09-21  47  
d741029a239040 drivers/opp/debugfs.c            Arvind Yadav 2017-09-21 @48  		snprintf(name, sizeof(name), "supply-%d", i);
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  49  
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  50  		/* Create per-opp directory */
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  51  		d = debugfs_create_dir(name, pdentry);
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  52  
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  53  		if (!d)
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  54  			return false;
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  55  
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  56  		if (!debugfs_create_ulong("u_volt_target", S_IRUGO, d,
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  57  					  &opp->supplies[i].u_volt))
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  58  			return false;
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  59  
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  60  		if (!debugfs_create_ulong("u_volt_min", S_IRUGO, d,
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  61  					  &opp->supplies[i].u_volt_min))
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  62  			return false;
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  63  
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  64  		if (!debugfs_create_ulong("u_volt_max", S_IRUGO, d,
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  65  					  &opp->supplies[i].u_volt_max))
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  66  			return false;
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  67  
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  68  		if (!debugfs_create_ulong("u_amp", S_IRUGO, d,
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  69  					  &opp->supplies[i].u_amp))
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  70  			return false;
1fae788ed640e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2017-05-23  71  	}
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  72  
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  73  	return true;
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  74  }
dfbe4678d709e2 drivers/base/power/opp/debugfs.c Viresh Kumar 2016-12-01  75  

:::::: The code at line 48 was first introduced by commit
:::::: d741029a2390406d4d94279ae5b346831a9e61e6 PM / OPP: Use snprintf() to avoid kasprintf() and kfree()

:::::: TO: Arvind Yadav <arvind.yadav.cs@gmail.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

