Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A0C7D1D6B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjJUOPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUOPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:15:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4356ADD
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697897711; x=1729433711;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J9WFiVd6hDbeXrw1bT6TOGKWOG7XBxIUW1EdLDkXGN4=;
  b=kOi/Qpi5jrk1Izv2qVoWkgi8qmnKBD59lpJGEXQn5ja1xWIKoam3Zngh
   25GGzH8B1Dt3zEAgApYyhZYF7SrF46P0Vj4aG0BdMUnQsP5Ii/HzEvaoA
   H2G9zwHyNYlm0iyAoc0UQsgyLwUwhar6F4F/Dv/S58Tj3KbheoT65Ir0/
   OmH2GQpFLHMLdRe2bh5RYMsvj+MUMypNtpVhvKl6+DYhvBc7hH1H6r8It
   saj0FATwONrGklAT0Sx6z8xIm6AGVvKUuxiX8H+/9MRtXvUqmvPxLywhH
   4ELH/aAjXq4SnXlpSvISz8BqkzFyxGy0IQrd5/4H/UV5NuoY9s6LgEmO5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="383838720"
X-IronPort-AV: E=Sophos;i="6.03,241,1694761200"; 
   d="scan'208";a="383838720"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 07:15:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="874213236"
X-IronPort-AV: E=Sophos;i="6.03,241,1694761200"; 
   d="scan'208";a="874213236"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 21 Oct 2023 07:15:09 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1quCkt-0004uQ-0O;
        Sat, 21 Oct 2023 14:15:07 +0000
Date:   Sat, 21 Oct 2023 22:15:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/acpi/sleep.c:1208: warning: Function parameter or member
 'stage' not described in 'acpi_hibernation_begin_old'
Message-ID: <202310212220.81UIgoDf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
commit: bb1869012d7b78d1474808cb4c8bd8b272645876 ACPI: PM: Call pm_set_suspend_via_firmware() during hibernation
date:   4 years, 5 months ago
config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231021/202310212220.81UIgoDf-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231021/202310212220.81UIgoDf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310212220.81UIgoDf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/acpi/sleep.c:516: warning: Function parameter or member 'acpi_state' not described in 'acpi_pm_start'
   drivers/acpi/sleep.c:555: warning: Function parameter or member 'pm_state' not described in 'acpi_suspend_begin'
   drivers/acpi/sleep.c:682: warning: Function parameter or member 'pm_state' not described in 'acpi_suspend_begin_old'
>> drivers/acpi/sleep.c:1208: warning: Function parameter or member 'stage' not described in 'acpi_hibernation_begin_old'


vim +1208 drivers/acpi/sleep.c

caea99ef339af8e drivers/acpi/sleep/main.c Rafael J. Wysocki 2008-01-08  1200  
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki 2008-06-12  1201  /**
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki 2008-06-12  1202   *	acpi_hibernation_begin_old - Set the target system sleep state to
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki 2008-06-12  1203   *		ACPI_STATE_S4 and execute the _PTS control method.  This
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki 2008-06-12  1204   *		function is used if the pre-ACPI 2.0 suspend ordering has been
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki 2008-06-12  1205   *		requested.
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki 2008-06-12  1206   */
bb1869012d7b78d drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1207  static int acpi_hibernation_begin_old(pm_message_t stage)
a634cc10164d1c2 drivers/acpi/sleep/main.c Rafael J. Wysocki 2007-07-19 @1208  {
e49f711cc8f3bf8 drivers/acpi/sleep/main.c Zhao Yakui        2008-08-12  1209  	int error;
e49f711cc8f3bf8 drivers/acpi/sleep/main.c Zhao Yakui        2008-08-12  1210  	/*
e49f711cc8f3bf8 drivers/acpi/sleep/main.c Zhao Yakui        2008-08-12  1211  	 * The _TTS object should always be evaluated before the _PTS object.
e49f711cc8f3bf8 drivers/acpi/sleep/main.c Zhao Yakui        2008-08-12  1212  	 * When the old_suspended_ordering is true, the _PTS object is
e49f711cc8f3bf8 drivers/acpi/sleep/main.c Zhao Yakui        2008-08-12  1213  	 * evaluated in the acpi_sleep_prepare.
e49f711cc8f3bf8 drivers/acpi/sleep/main.c Zhao Yakui        2008-08-12  1214  	 */
e49f711cc8f3bf8 drivers/acpi/sleep/main.c Zhao Yakui        2008-08-12  1215  	acpi_sleep_tts_switch(ACPI_STATE_S4);
e49f711cc8f3bf8 drivers/acpi/sleep/main.c Zhao Yakui        2008-08-12  1216  
e49f711cc8f3bf8 drivers/acpi/sleep/main.c Zhao Yakui        2008-08-12  1217  	error = acpi_sleep_prepare(ACPI_STATE_S4);
bb1869012d7b78d drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1218  	if (error)
bb1869012d7b78d drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1219  		return error;
a634cc10164d1c2 drivers/acpi/sleep/main.c Rafael J. Wysocki 2007-07-19  1220  
bb1869012d7b78d drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1221  	if (!nvs_nosave) {
dd4c4f17d722ffe drivers/acpi/sleep.c      Matthew Garrett   2010-05-28  1222  		error = suspend_nvs_alloc();
bb1869012d7b78d drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1223  		if (error)
bb1869012d7b78d drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1224  			return error;
bb1869012d7b78d drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1225  	}
bb1869012d7b78d drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1226  
bb1869012d7b78d drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1227  	if (stage.event == PM_EVENT_HIBERNATE)
bb1869012d7b78d drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1228  		pm_set_suspend_via_firmware();
bb1869012d7b78d drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1229  
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki 2008-06-12  1230  	acpi_target_sleep_state = ACPI_STATE_S4;
ad07277e82dedab drivers/acpi/sleep.c      Rafael J. Wysocki 2013-08-20  1231  	acpi_scan_lock_acquire();
bb1869012d7b78d drivers/acpi/sleep.c      Rafael J. Wysocki 2019-05-16  1232  	return 0;
3f4b0ef7f2899c9 drivers/acpi/sleep/main.c Rafael J. Wysocki 2008-10-26  1233  }
3f4b0ef7f2899c9 drivers/acpi/sleep/main.c Rafael J. Wysocki 2008-10-26  1234  

:::::: The code at line 1208 was first introduced by commit
:::::: a634cc10164d1c229fbeca33923e6a0ed939e894 swsusp: introduce restore platform operations

:::::: TO: Rafael J. Wysocki <rjw@sisk.pl>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
