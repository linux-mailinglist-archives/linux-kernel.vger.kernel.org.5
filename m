Return-Path: <linux-kernel+bounces-2519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB54815E61
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 10:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B6DB22339
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 09:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605591FC2;
	Sun, 17 Dec 2023 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ua5tuvDK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6450563A3
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702806171; x=1734342171;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HdB0MNqlPg6V733JgtXzoNWmVVy08kfm2EL3UQt6riY=;
  b=Ua5tuvDKmhXkhg31MX2v6cZ/XytAfDnj2Q3ibbSUityZ5PbZ35nskbfr
   KDQw7x+8ywJ90VsFLK6JdY1yBSlK09HnFF5xF3/9M7HN+fQPH5k7DvuaH
   WuMenqb39XrXhA1Uk2fvg1qn3EMQh5DRJPltiH/z9n6Ibzg7XWLuwoddi
   J+WRJnZ71ZOoDm7HjD2IApqdVdVqNEoIdLrI/XWpnp7iLpO0zPoe9Gpfm
   j9XUqEDx1HuzwnApREzD+Hd1n0nskmV2tiW61Y6hlRMKQQDqervI5+odK
   YStMwxU6s3D89U58srxrpzVxpb0TeGKQHId2lpC7153bd77JHNlJUXdQ5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="395145525"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="395145525"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 01:42:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="778766621"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="778766621"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 17 Dec 2023 01:42:49 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEnfb-0002uU-10;
	Sun, 17 Dec 2023 09:42:47 +0000
Date: Sun, 17 Dec 2023 17:42:18 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Shych <michaelsh@mellanox.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: drivers/watchdog/mlx_wdt.c:53: warning: Function parameter or member
 'wdt_type' not described in 'mlxreg_wdt'
Message-ID: <202312171701.xNkzdgdi-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Michael,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b8a9b2e6809d281890dd0a1102dc14d2cd11caf
commit: c60923dd5feedc337b1450e3f4c6e19ffa305439 watchdog: mlx-wdt: introduce a watchdog driver for Mellanox systems.
date:   4 years, 10 months ago
config: x86_64-buildonly-randconfig-004-20230906 (https://download.01.org/0day-ci/archive/20231217/202312171701.xNkzdgdi-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312171701.xNkzdgdi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312171701.xNkzdgdi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/watchdog/mlx_wdt.c:53: warning: Function parameter or member 'wdt_type' not described in 'mlxreg_wdt'


vim +53 drivers/watchdog/mlx_wdt.c

    20	
    21	#define MLXREG_WDT_CLOCK_SCALE		1000
    22	#define MLXREG_WDT_MAX_TIMEOUT_TYPE1	32
    23	#define MLXREG_WDT_MAX_TIMEOUT_TYPE2	255
    24	#define MLXREG_WDT_MIN_TIMEOUT		1
    25	#define MLXREG_WDT_OPTIONS_BASE (WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE | \
    26					 WDIOF_SETTIMEOUT)
    27	
    28	/**
    29	 * struct mlxreg_wdt - wd private data:
    30	 *
    31	 * @wdd:	watchdog device;
    32	 * @device:	basic device;
    33	 * @pdata:	data received from platform driver;
    34	 * @regmap:	register map of parent device;
    35	 * @timeout:	defined timeout in sec.;
    36	 * @action_idx:	index for direct access to action register;
    37	 * @timeout_idx:index for direct access to TO register;
    38	 * @tleft_idx:	index for direct access to time left register;
    39	 * @ping_idx:	index for direct access to ping register;
    40	 * @reset_idx:	index for direct access to reset cause register;
    41	 * @wd_type:	watchdog HW type;
    42	 */
    43	struct mlxreg_wdt {
    44		struct watchdog_device wdd;
    45		struct mlxreg_core_platform_data *pdata;
    46		void *regmap;
    47		int action_idx;
    48		int timeout_idx;
    49		int tleft_idx;
    50		int ping_idx;
    51		int reset_idx;
    52		enum mlxreg_wdt_type wdt_type;
  > 53	};
    54	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

