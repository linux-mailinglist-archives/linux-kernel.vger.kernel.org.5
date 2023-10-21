Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85407D1C58
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjJUKDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjJUKDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:03:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7D11A3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697882584; x=1729418584;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Uj83SHBdVGa4qj1AKHVOg3yUcbGFLvPscjpK4c5+Qvw=;
  b=YAZITh4R0WLwRz9vOXqvpMs5+a5ELAm15FhXiIwi6GMouqKvpvN/+PkC
   O5lIHurT5jKJ3wZ8u01RFqgh2Aw2Wuwy/I4L3EEA+MnwG9b3FwFhr7ZcO
   qEXDFuDYWNOemUS1zTQGiBDvKHJtIAqBZyMv4PjRs3QQQZHMe8702X/O4
   yyJV4KRJLIu7K53DJ3GjP6kj2TdcIRXXwp/9mq6goqkgFZOVGOdcarqcX
   2s/ZVvBYEVvbDDb4mz+7rPXygUV1gfD6lkPRMiDMYf6CCLKi5P5de/UQQ
   S1fWhmSFZJSpAIPzRON/tqbifZlxLByPqgd5VsQ8LC2HZKvMqq+SY1OAm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="472845366"
X-IronPort-AV: E=Sophos;i="6.03,240,1694761200"; 
   d="scan'208";a="472845366"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 03:03:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="707459005"
X-IronPort-AV: E=Sophos;i="6.03,240,1694761200"; 
   d="scan'208";a="707459005"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Oct 2023 03:03:02 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qu8ot-0004iU-1w;
        Sat, 21 Oct 2023 10:02:59 +0000
Date:   Sat, 21 Oct 2023 18:02:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: drivers/acpi/sleep.c:516: warning: Function parameter or member
 'acpi_state' not described in 'acpi_pm_start'
Message-ID: <202310211713.bpvKEcFt-lkp@intel.com>
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

Hi Sinan,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
commit: 5d32a66541c4683456507481a0944ed2985e75c7 PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set
date:   4 years, 10 months ago
config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231021/202310211713.bpvKEcFt-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231021/202310211713.bpvKEcFt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310211713.bpvKEcFt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/sleep.c:516: warning: Function parameter or member 'acpi_state' not described in 'acpi_pm_start'
>> drivers/acpi/sleep.c:555: warning: Function parameter or member 'pm_state' not described in 'acpi_suspend_begin'
>> drivers/acpi/sleep.c:682: warning: Function parameter or member 'pm_state' not described in 'acpi_suspend_begin_old'


vim +516 drivers/acpi/sleep.c

d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  511  
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  512  /**
ad07277e82dedab drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  513   * acpi_pm_start - Start system PM transition.
ad07277e82dedab drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  514   */
ad07277e82dedab drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  515  static void acpi_pm_start(u32 acpi_state)
ad07277e82dedab drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20 @516  {
ad07277e82dedab drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  517  	acpi_target_sleep_state = acpi_state;
ad07277e82dedab drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  518  	acpi_sleep_tts_switch(acpi_target_sleep_state);
ad07277e82dedab drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  519  	acpi_scan_lock_acquire();
ad07277e82dedab drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  520  }
ad07277e82dedab drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  521  
ad07277e82dedab drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  522  /**
ad07277e82dedab drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  523   * acpi_pm_end - Finish up system PM transition.
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  524   */
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  525  static void acpi_pm_end(void)
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  526  {
8ece1d83346bcc4 drivers/acpi/sleep.c      Hans de Goede           2017-04-30  527  	acpi_turn_off_unused_power_resources();
ad07277e82dedab drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  528  	acpi_scan_lock_release();
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  529  	/*
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  530  	 * This is necessary in case acpi_pm_finish() is not called during a
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  531  	 * failing transition to a sleep state.
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  532  	 */
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  533  	acpi_target_sleep_state = ACPI_STATE_S0;
e49f711cc8f3bf8 drivers/acpi/sleep/main.c Zhao Yakui              2008-08-12  534  	acpi_sleep_tts_switch(acpi_target_sleep_state);
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  535  }
92daa7b53b76984 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-10-23  536  #else /* !CONFIG_ACPI_SLEEP */
92daa7b53b76984 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-10-23  537  #define acpi_target_sleep_state	ACPI_STATE_S0
71630b7a832f699 drivers/acpi/sleep.c      Rafael J. Wysocki       2017-11-06  538  #define acpi_sleep_no_lps0	(false)
0ac1b1d7b7424cd drivers/acpi/sleep.c      Zhang Rui               2012-11-30  539  static inline void acpi_sleep_dmi_check(void) {}
5d1e072b6b9cffe drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-10-22  540  #endif /* CONFIG_ACPI_SLEEP */
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  541  
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  542  #ifdef CONFIG_SUSPEND
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  543  static u32 acpi_suspend_states[] = {
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  544  	[PM_SUSPEND_ON] = ACPI_STATE_S0,
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  545  	[PM_SUSPEND_STANDBY] = ACPI_STATE_S1,
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  546  	[PM_SUSPEND_MEM] = ACPI_STATE_S3,
e2a5b420f716cd1 drivers/acpi/sleep/main.c Alexey Starikovskiy     2005-03-18  547  	[PM_SUSPEND_MAX] = ACPI_STATE_S5
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  548  };
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  549  
e9b3aba887f47f9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  550  /**
2c6e33c366bff2f drivers/acpi/sleep/main.c Len Brown               2008-04-23  551   *	acpi_suspend_begin - Set the target system sleep state to the state
e9b3aba887f47f9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  552   *		associated with given @pm_state, if supported.
e9b3aba887f47f9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  553   */
2c6e33c366bff2f drivers/acpi/sleep/main.c Len Brown               2008-04-23  554  static int acpi_suspend_begin(suspend_state_t pm_state)
e9b3aba887f47f9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17 @555  {
e9b3aba887f47f9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  556  	u32 acpi_state = acpi_suspend_states[pm_state];
ad07277e82dedab drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  557  	int error;
e9b3aba887f47f9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  558  
1bad2f19f7f79d1 drivers/acpi/sleep.c      Kristen Carlson Accardi 2012-10-26  559  	error = (nvs_nosave || nvs_nosave_s3) ? 0 : suspend_nvs_alloc();
2a6b69765ad7943 drivers/acpi/sleep.c      Matthew Garrett         2010-05-28  560  	if (error)
2a6b69765ad7943 drivers/acpi/sleep.c      Matthew Garrett         2010-05-28  561  		return error;
2a6b69765ad7943 drivers/acpi/sleep.c      Matthew Garrett         2010-05-28  562  
ad07277e82dedab drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  563  	if (!sleep_states[acpi_state]) {
ad07277e82dedab drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  564  		pr_err("ACPI does not support sleep state S%u\n", acpi_state);
ad07277e82dedab drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  565  		return -ENOSYS;
e9b3aba887f47f9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  566  	}
ef25ba047601590 drivers/acpi/sleep.c      Rafael J. Wysocki       2015-10-07  567  	if (acpi_state > ACPI_STATE_S1)
ef25ba047601590 drivers/acpi/sleep.c      Rafael J. Wysocki       2015-10-07  568  		pm_set_suspend_via_firmware();
ad07277e82dedab drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  569  
ad07277e82dedab drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  570  	acpi_pm_start(acpi_state);
ad07277e82dedab drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  571  	return 0;
e9b3aba887f47f9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  572  }
e9b3aba887f47f9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  573  
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  574  /**
2c6e33c366bff2f drivers/acpi/sleep/main.c Len Brown               2008-04-23  575   *	acpi_suspend_enter - Actually enter a sleep state.
e9b3aba887f47f9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  576   *	@pm_state: ignored
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  577   *
50ad147aa09c829 drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-24  578   *	Flush caches and go to sleep. For STR we have to call arch-specific
50ad147aa09c829 drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-24  579   *	assembly, which in turn call acpi_enter_sleep_state().
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  580   *	It's unfortunate, but it works. Please fix if you're feeling frisky.
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  581   */
2c6e33c366bff2f drivers/acpi/sleep/main.c Len Brown               2008-04-23  582  static int acpi_suspend_enter(suspend_state_t pm_state)
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  583  {
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  584  	acpi_status status = AE_OK;
e9b3aba887f47f9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  585  	u32 acpi_state = acpi_target_sleep_state;
979f11b060c0b35 drivers/acpi/sleep.c      Rafael J. Wysocki       2011-02-08  586  	int error;
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  587  
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  588  	ACPI_FLUSH_CPU_CACHE();
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  589  
bb3632c6101b2fa drivers/acpi/sleep.c      Todd E Brandt           2014-06-06  590  	trace_suspend_resume(TPS("acpi_suspend"), acpi_state, true);
e9b3aba887f47f9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  591  	switch (acpi_state) {
e9b3aba887f47f9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  592  	case ACPI_STATE_S1:
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  593  		barrier();
3f6f49c7854c929 drivers/acpi/sleep.c      Len Brown               2012-07-26  594  		status = acpi_enter_sleep_state(acpi_state);
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  595  		break;
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  596  
e9b3aba887f47f9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  597  	case ACPI_STATE_S3:
d6a77ead21b69c3 drivers/acpi/sleep.c      Konrad Rzeszutek Wilk   2013-05-14  598  		if (!acpi_suspend_lowlevel)
d6a77ead21b69c3 drivers/acpi/sleep.c      Konrad Rzeszutek Wilk   2013-05-14  599  			return -ENOSYS;
f1a2003e22f6b50 drivers/acpi/sleep.c      Rafael J. Wysocki       2011-02-08  600  		error = acpi_suspend_lowlevel();
979f11b060c0b35 drivers/acpi/sleep.c      Rafael J. Wysocki       2011-02-08  601  		if (error)
979f11b060c0b35 drivers/acpi/sleep.c      Rafael J. Wysocki       2011-02-08  602  			return error;
7a63f08b2b904d2 drivers/acpi/sleep.c      Rafael J. Wysocki       2011-02-08  603  		pr_info(PREFIX "Low-level resume complete\n");
ef25ba047601590 drivers/acpi/sleep.c      Rafael J. Wysocki       2015-10-07  604  		pm_set_resume_via_firmware();
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  605  		break;
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  606  	}
bb3632c6101b2fa drivers/acpi/sleep.c      Todd E Brandt           2014-06-06  607  	trace_suspend_resume(TPS("acpi_suspend"), acpi_state, false);
872d83d00f67021 drivers/acpi/sleep/main.c Arnaud Patard           2006-04-27  608  
b6dacf63e9fb2e7 drivers/acpi/sleep.c      Matthew Garrett         2010-05-11  609  	/* This violates the spec but is required for bug compatibility. */
50ffba1bd3120b0 drivers/acpi/sleep.c      Bob Moore               2009-02-23  610  	acpi_write_bit_register(ACPI_BITREG_SCI_ENABLE, 1);
65df78473ffbf3b drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-11-26  611  
3f6f49c7854c929 drivers/acpi/sleep.c      Len Brown               2012-07-26  612  	/* Reprogram control registers */
3f6f49c7854c929 drivers/acpi/sleep.c      Len Brown               2012-07-26  613  	acpi_leave_sleep_state_prep(acpi_state);
c95d47a868f35cd drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-01-08  614  
23b168d425ca0ca drivers/acpi/sleep/main.c Pavel Machek            2008-02-05  615  	/* ACPI 3.0 specs (P62) says that it's the responsibility
872d83d00f67021 drivers/acpi/sleep/main.c Arnaud Patard           2006-04-27  616  	 * of the OSPM to clear the status bit [ implying that the
872d83d00f67021 drivers/acpi/sleep/main.c Arnaud Patard           2006-04-27  617  	 * POWER_BUTTON event should not reach userspace ]
c10d7a13846bffa drivers/acpi/sleep.c      Daniel Drake            2012-05-10  618  	 *
c10d7a13846bffa drivers/acpi/sleep.c      Daniel Drake            2012-05-10  619  	 * However, we do generate a small hint for userspace in the form of
c10d7a13846bffa drivers/acpi/sleep.c      Daniel Drake            2012-05-10  620  	 * a wakeup event. We flag this condition for now and generate the
c10d7a13846bffa drivers/acpi/sleep.c      Daniel Drake            2012-05-10  621  	 * event later, as we're currently too early in resume to be able to
c10d7a13846bffa drivers/acpi/sleep.c      Daniel Drake            2012-05-10  622  	 * generate wakeup events.
872d83d00f67021 drivers/acpi/sleep/main.c Arnaud Patard           2006-04-27  623  	 */
c10d7a13846bffa drivers/acpi/sleep.c      Daniel Drake            2012-05-10  624  	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3)) {
51468a9d3a80249 drivers/acpi/sleep.c      Al Stone                2013-11-20  625  		acpi_event_status pwr_btn_status = ACPI_EVENT_FLAG_DISABLED;
c10d7a13846bffa drivers/acpi/sleep.c      Daniel Drake            2012-05-10  626  
c10d7a13846bffa drivers/acpi/sleep.c      Daniel Drake            2012-05-10  627  		acpi_get_event_status(ACPI_EVENT_POWER_BUTTON, &pwr_btn_status);
c10d7a13846bffa drivers/acpi/sleep.c      Daniel Drake            2012-05-10  628  
18864cc4892d207 drivers/acpi/sleep.c      Lv Zheng                2016-08-04  629  		if (pwr_btn_status & ACPI_EVENT_FLAG_STATUS_SET) {
872d83d00f67021 drivers/acpi/sleep/main.c Arnaud Patard           2006-04-27  630  			acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
c10d7a13846bffa drivers/acpi/sleep.c      Daniel Drake            2012-05-10  631  			/* Flag for later */
c10d7a13846bffa drivers/acpi/sleep.c      Daniel Drake            2012-05-10  632  			pwr_btn_event_pending = true;
c10d7a13846bffa drivers/acpi/sleep.c      Daniel Drake            2012-05-10  633  		}
c10d7a13846bffa drivers/acpi/sleep.c      Daniel Drake            2012-05-10  634  	}
872d83d00f67021 drivers/acpi/sleep/main.c Arnaud Patard           2006-04-27  635  
a3627f67b1d5ddd drivers/acpi/sleep/main.c Shaohua Li              2007-06-20  636  	/*
a3627f67b1d5ddd drivers/acpi/sleep/main.c Shaohua Li              2007-06-20  637  	 * Disable and clear GPE status before interrupt is enabled. Some GPEs
a3627f67b1d5ddd drivers/acpi/sleep/main.c Shaohua Li              2007-06-20  638  	 * (like wakeup GPE) haven't handler, this can avoid such GPE misfire.
a3627f67b1d5ddd drivers/acpi/sleep/main.c Shaohua Li              2007-06-20  639  	 * acpi_leave_sleep_state will reenable specific GPEs later
a3627f67b1d5ddd drivers/acpi/sleep/main.c Shaohua Li              2007-06-20  640  	 */
3d97e426aa97d60 drivers/acpi/sleep/main.c Lin Ming                2008-12-16  641  	acpi_disable_all_gpes();
d5a64513c6a1712 drivers/acpi/sleep.c      Rafael J. Wysocki       2010-04-09  642  	/* Allow EC transactions to happen. */
c2b46d679b30c5c drivers/acpi/sleep.c      Lv Zheng                2016-08-03  643  	acpi_ec_unblock_transactions();
a3627f67b1d5ddd drivers/acpi/sleep/main.c Shaohua Li              2007-06-20  644  
2a6b69765ad7943 drivers/acpi/sleep.c      Matthew Garrett         2010-05-28  645  	suspend_nvs_restore();
2a6b69765ad7943 drivers/acpi/sleep.c      Matthew Garrett         2010-05-28  646  
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  647  	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  648  }
^1da177e4c3f415 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  649  
2c6e33c366bff2f drivers/acpi/sleep/main.c Len Brown               2008-04-23  650  static int acpi_suspend_state_valid(suspend_state_t pm_state)
eb9289eb20df6b5 drivers/acpi/sleep/main.c Shaohua Li              2005-10-30  651  {
e8c9c502690efd2 drivers/acpi/sleep/main.c Johannes Berg           2007-04-30  652  	u32 acpi_state;
e8c9c502690efd2 drivers/acpi/sleep/main.c Johannes Berg           2007-04-30  653  
e8c9c502690efd2 drivers/acpi/sleep/main.c Johannes Berg           2007-04-30  654  	switch (pm_state) {
e8c9c502690efd2 drivers/acpi/sleep/main.c Johannes Berg           2007-04-30  655  	case PM_SUSPEND_ON:
e8c9c502690efd2 drivers/acpi/sleep/main.c Johannes Berg           2007-04-30  656  	case PM_SUSPEND_STANDBY:
e8c9c502690efd2 drivers/acpi/sleep/main.c Johannes Berg           2007-04-30  657  	case PM_SUSPEND_MEM:
e8c9c502690efd2 drivers/acpi/sleep/main.c Johannes Berg           2007-04-30  658  		acpi_state = acpi_suspend_states[pm_state];
eb9289eb20df6b5 drivers/acpi/sleep/main.c Shaohua Li              2005-10-30  659  
eb9289eb20df6b5 drivers/acpi/sleep/main.c Shaohua Li              2005-10-30  660  		return sleep_states[acpi_state];
e8c9c502690efd2 drivers/acpi/sleep/main.c Johannes Berg           2007-04-30  661  	default:
e8c9c502690efd2 drivers/acpi/sleep/main.c Johannes Berg           2007-04-30  662  		return 0;
e8c9c502690efd2 drivers/acpi/sleep/main.c Johannes Berg           2007-04-30  663  	}
eb9289eb20df6b5 drivers/acpi/sleep/main.c Shaohua Li              2005-10-30  664  }
eb9289eb20df6b5 drivers/acpi/sleep/main.c Shaohua Li              2005-10-30  665  
2f55ac072f53445 drivers/acpi/sleep.c      Lionel Debroux          2010-11-16  666  static const struct platform_suspend_ops acpi_suspend_ops = {
2c6e33c366bff2f drivers/acpi/sleep/main.c Len Brown               2008-04-23  667  	.valid = acpi_suspend_state_valid,
2c6e33c366bff2f drivers/acpi/sleep/main.c Len Brown               2008-04-23  668  	.begin = acpi_suspend_begin,
6a7c7eaf71b636f drivers/acpi/sleep.c      Rafael J. Wysocki       2009-04-19  669  	.prepare_late = acpi_pm_prepare,
2c6e33c366bff2f drivers/acpi/sleep/main.c Len Brown               2008-04-23  670  	.enter = acpi_suspend_enter,
618d7fd0d4e51a4 drivers/acpi/sleep.c      Rafael J. Wysocki       2010-07-02  671  	.wake = acpi_pm_finish,
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  672  	.end = acpi_pm_end,
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  673  };
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  674  
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  675  /**
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  676   *	acpi_suspend_begin_old - Set the target system sleep state to the
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  677   *		state associated with given @pm_state, if supported, and
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  678   *		execute the _PTS control method.  This function is used if the
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  679   *		pre-ACPI 2.0 suspend ordering has been requested.
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  680   */
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  681  static int acpi_suspend_begin_old(suspend_state_t pm_state)
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12 @682  {
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  683  	int error = acpi_suspend_begin(pm_state);
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  684  	if (!error)
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  685  		error = __acpi_pm_prepare();
c5f7a1bb65bca03 drivers/acpi/sleep.c      Rafael J. Wysocki       2010-07-02  686  
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  687  	return error;
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  688  }
d8f3de0d2412bb9 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  689  

:::::: The code at line 516 was first introduced by commit
:::::: ad07277e82dedabacc52c82746633680a3187d25 ACPI / PM: Hold acpi_scan_lock over system PM transitions

:::::: TO: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
