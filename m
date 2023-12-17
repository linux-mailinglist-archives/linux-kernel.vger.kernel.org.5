Return-Path: <linux-kernel+bounces-2796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0478161FC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459D71C20F4E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BF6481B8;
	Sun, 17 Dec 2023 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lquz7PJ0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF24481AA
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702844268; x=1734380268;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nD+GePEN4rLLj2S6Ib0fNvX8BFtKYACmBfrmvW3hIfw=;
  b=Lquz7PJ0cpsCIkli6O4+zyWHuxUcLmC4VvX2SNUEEdhFNFRc8vLHRTHD
   +ljRECJt61MLNh4dW/Xyo6gALAnRi0iCgJLjJ0vHlYXBMmhfKXxRZZwq6
   7mwU6CFr+maRXKwyiPeBHSfvDbpM11Cmg4JZh7/kxuBGAM5HdFlapav+0
   j5GcbJsoRASsMac3J2SNGMsLvmsBL7do53tkPZoCp/6i4+zYnzRVVL8hO
   DiSBPQBXBMEnxByxfBvDMszQOv2WL7bWckuG+0r6BQ2p35qybLKwILYSJ
   rPuW68oubCJdbIwve875rdQAhBL9g8Assk5zU0T/n58YlluZ//8yKF3kv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="398215251"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="398215251"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 12:17:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="1022540812"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="1022540812"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 17 Dec 2023 12:17:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rExa4-0003Oq-0L;
	Sun, 17 Dec 2023 20:17:44 +0000
Date: Mon, 18 Dec 2023 04:16:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/acpi/sleep.c:1208: warning: Function parameter or member
 'stage' not described in 'acpi_hibernation_begin_old'
Message-ID: <202312180432.X748Usi0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0e389834672c723435a44818ed2cabc4dad24429
commit: bb1869012d7b78d1474808cb4c8bd8b272645876 ACPI: PM: Call pm_set_suspend_via_firmware() during hibernation
date:   4 years, 7 months ago
config: x86_64-randconfig-015-20231011 (https://download.01.org/0day-ci/archive/20231218/202312180432.X748Usi0-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231218/202312180432.X748Usi0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312180432.X748Usi0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/acpi/sleep.c:424: warning: expecting prototype for acpi_pre_suspend(). Prototype was for acpi_pm_pre_suspend() instead
   drivers/acpi/sleep.c:516: warning: Function parameter or member 'acpi_state' not described in 'acpi_pm_start'
   drivers/acpi/sleep.c:555: warning: Function parameter or member 'pm_state' not described in 'acpi_suspend_begin'
   drivers/acpi/sleep.c:682: warning: Function parameter or member 'pm_state' not described in 'acpi_suspend_begin_old'
>> drivers/acpi/sleep.c:1208: warning: Function parameter or member 'stage' not described in 'acpi_hibernation_begin_old'


vim +1208 drivers/acpi/sleep.c

caea99ef339af8 drivers/acpi/sleep/main.c Rafael J. Wysocki 2008-01-08  1200  
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki 2008-06-12  1201  /**
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki 2008-06-12  1202   *	acpi_hibernation_begin_old - Set the target system sleep state to
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki 2008-06-12  1203   *		ACPI_STATE_S4 and execute the _PTS control method.  This
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki 2008-06-12  1204   *		function is used if the pre-ACPI 2.0 suspend ordering has been
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki 2008-06-12  1205   *		requested.
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki 2008-06-12  1206   */
bb1869012d7b78 drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1207  static int acpi_hibernation_begin_old(pm_message_t stage)
a634cc10164d1c drivers/acpi/sleep/main.c Rafael J. Wysocki 2007-07-19 @1208  {
e49f711cc8f3bf drivers/acpi/sleep/main.c Zhao Yakui        2008-08-12  1209  	int error;
e49f711cc8f3bf drivers/acpi/sleep/main.c Zhao Yakui        2008-08-12  1210  	/*
e49f711cc8f3bf drivers/acpi/sleep/main.c Zhao Yakui        2008-08-12  1211  	 * The _TTS object should always be evaluated before the _PTS object.
e49f711cc8f3bf drivers/acpi/sleep/main.c Zhao Yakui        2008-08-12  1212  	 * When the old_suspended_ordering is true, the _PTS object is
e49f711cc8f3bf drivers/acpi/sleep/main.c Zhao Yakui        2008-08-12  1213  	 * evaluated in the acpi_sleep_prepare.
e49f711cc8f3bf drivers/acpi/sleep/main.c Zhao Yakui        2008-08-12  1214  	 */
e49f711cc8f3bf drivers/acpi/sleep/main.c Zhao Yakui        2008-08-12  1215  	acpi_sleep_tts_switch(ACPI_STATE_S4);
e49f711cc8f3bf drivers/acpi/sleep/main.c Zhao Yakui        2008-08-12  1216  
e49f711cc8f3bf drivers/acpi/sleep/main.c Zhao Yakui        2008-08-12  1217  	error = acpi_sleep_prepare(ACPI_STATE_S4);
bb1869012d7b78 drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1218  	if (error)
bb1869012d7b78 drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1219  		return error;
a634cc10164d1c drivers/acpi/sleep/main.c Rafael J. Wysocki 2007-07-19  1220  
bb1869012d7b78 drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1221  	if (!nvs_nosave) {
dd4c4f17d722ff drivers/acpi/sleep.c      Matthew Garrett   2010-05-28  1222  		error = suspend_nvs_alloc();
bb1869012d7b78 drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1223  		if (error)
bb1869012d7b78 drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1224  			return error;
bb1869012d7b78 drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1225  	}
bb1869012d7b78 drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1226  
bb1869012d7b78 drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1227  	if (stage.event == PM_EVENT_HIBERNATE)
bb1869012d7b78 drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1228  		pm_set_suspend_via_firmware();
bb1869012d7b78 drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1229  
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki 2008-06-12  1230  	acpi_target_sleep_state = ACPI_STATE_S4;
ad07277e82deda drivers/acpi/sleep.c      Rafael J. Wysocki 2013-08-20  1231  	acpi_scan_lock_acquire();
bb1869012d7b78 drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1232  	return 0;
3f4b0ef7f2899c drivers/acpi/sleep/main.c Rafael J. Wysocki 2008-10-26  1233  }
3f4b0ef7f2899c drivers/acpi/sleep/main.c Rafael J. Wysocki 2008-10-26  1234  

:::::: The code at line 1208 was first introduced by commit
:::::: a634cc10164d1c229fbeca33923e6a0ed939e894 swsusp: introduce restore platform operations

:::::: TO: Rafael J. Wysocki <rjw@sisk.pl>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

