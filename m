Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA9E7E1EAF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjKFKmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjKFKmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:42:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434C694
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 02:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699267352; x=1730803352;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VVoA6M9tV7b7+GwVri+O7UGSZ8BdQ6m2m/IBtofKr6w=;
  b=lHCk6suhiuzpfJDVM/2vwWtgzK5/fckfsD6esnlRMQjwhcrnSFBgHU4b
   L3fpycv6/dJDl64L/xHmbN4bUE9hjbS4s9Phrb0kfbNYw6m7muQhZfSDs
   3yKykil5TJE9PCJxYCyAKBqI8g2PtTmO96CDFUVEu6x6iwhvkfFsC1rqn
   7VDhhD9r/q0HighaJgwFnOJoAOqNnZsk5NDqWwtSm2ESxZEBS0aCzxAro
   TfwY2agTMPjAZc0d0nLn/hbhAZQEfRvITGuDS4Z0etx1rJJL7qOqXYeMl
   8rAXurxCGCYIz10dBBQIuCe3zhvvdiurkQ5J/2nK8SFFnz+Y3mtfFSvhY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="368584139"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="368584139"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 02:42:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="885860713"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="885860713"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 06 Nov 2023 02:42:28 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzx3q-0006LI-0Z;
        Mon, 06 Nov 2023 10:42:26 +0000
Date:   Mon, 6 Nov 2023 18:41:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/opp/debugfs.c:48:54: warning: '%d' directive output may be
 truncated writing between 1 and 11 bytes into a region of size 8
Message-ID: <202311061847.BOtfUmbQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2f51b3516dade79269ff45eae2a7668ae711b25
commit: 46f48aca2e5aef3f430e95d1a5fb68227ec8ec85 OPP: Fix missing debugfs supply directory for OPPs
date:   4 years, 11 months ago
config: x86_64-randconfig-r025-20230725 (https://download.01.org/0day-ci/archive/20231106/202311061847.BOtfUmbQ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311061847.BOtfUmbQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311061847.BOtfUmbQ-lkp@intel.com/

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
