Return-Path: <linux-kernel+bounces-2659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C86816013
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9CC1C21FE3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35F844C87;
	Sun, 17 Dec 2023 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMnnSaGL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F18044C81
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702825343; x=1734361343;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BnYlrbYl18UraaiGWECPwf5ZqI3RHCQvKJUtQ/WUzNk=;
  b=JMnnSaGLE3fg8bpEw4gIPdObRhL2vNlc5s3hGWshdmOyTzgn35FIobcs
   +rr6055+6K4+B3d161C6adQSJsgRtYB3nDr35QCWa09yObV7QX08PK6IU
   3IEkMicVQLPxU7Ry6xhxsLKEzmGuOGaziDeJycFqSH3WOqzR+tREhFCH8
   PIZw5M0+0aLEHM/Lvnhk+/tbQgnvKeucSC9qTRyrxGJVxcYvZXqmcaNXh
   uOCsPT8KFkl5e7ryA7z/FnAClvRn18KOZl0MN/ilpjJMZ5dp1f9isuhnk
   oS7MD5grzTYELeF2npYT45Tyzj64KYlzhXGV4lS2VM5h7xnE1s6Q1WLqS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="426552349"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="426552349"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 07:02:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="845673307"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="845673307"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2023 07:02:20 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEseo-00038U-0m;
	Sun, 17 Dec 2023 15:02:18 +0000
Date: Sun, 17 Dec 2023 23:01:27 +0800
From: kernel test robot <lkp@intel.com>
To: Sinan Kaya <okaya@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: drivers/acpi/sleep.c:516: warning: Function parameter or member
 'acpi_state' not described in 'acpi_pm_start'
Message-ID: <202312172239.DwQYz1wW-lkp@intel.com>
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
commit: 5d32a66541c4683456507481a0944ed2985e75c7 PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set
date:   5 years ago
config: x86_64-buildonly-randconfig-006-20230830 (https://download.01.org/0day-ci/archive/20231217/202312172239.DwQYz1wW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312172239.DwQYz1wW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312172239.DwQYz1wW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/acpi/sleep.c:424: warning: expecting prototype for acpi_pre_suspend(). Prototype was for acpi_pm_pre_suspend() instead
>> drivers/acpi/sleep.c:516: warning: Function parameter or member 'acpi_state' not described in 'acpi_pm_start'
>> drivers/acpi/sleep.c:555: warning: Function parameter or member 'pm_state' not described in 'acpi_suspend_begin'
>> drivers/acpi/sleep.c:682: warning: Function parameter or member 'pm_state' not described in 'acpi_suspend_begin_old'
--
   drivers/acpi/dock.c: In function 'hot_remove_dock_devices':
   drivers/acpi/dock.c:249:67: warning: implicit conversion from 'enum <anonymous>' to 'enum dock_callback_type' [-Wenum-conversion]
     249 |                 dock_hotplug_event(dd, ACPI_NOTIFY_EJECT_REQUEST, false);
         |                                                                   ^~~~~
>> drivers/acpi/dock.c:401: warning: Function parameter or member 'ds' not described in 'handle_eject_request'
>> drivers/acpi/dock.c:401: warning: Function parameter or member 'event' not described in 'handle_eject_request'
--
>> drivers/acpi/acpi_watchdog.c:85: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Returns true if this system should prefer ACPI based watchdog instead of
   drivers/acpi/.tmp_acpi_watchdog.o: warning: objtool: missing symbol for section .init.text
--
>> drivers/firmware/efi/memmap.c:161: warning: Function parameter or member 'addr' not described in 'efi_memmap_init_late'
>> drivers/firmware/efi/memmap.c:161: warning: Excess function parameter 'phys_addr' description in 'efi_memmap_init_late'


vim +516 drivers/acpi/sleep.c

d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  511  
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  512  /**
ad07277e82deda drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  513   * acpi_pm_start - Start system PM transition.
ad07277e82deda drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  514   */
ad07277e82deda drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  515  static void acpi_pm_start(u32 acpi_state)
ad07277e82deda drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20 @516  {
ad07277e82deda drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  517  	acpi_target_sleep_state = acpi_state;
ad07277e82deda drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  518  	acpi_sleep_tts_switch(acpi_target_sleep_state);
ad07277e82deda drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  519  	acpi_scan_lock_acquire();
ad07277e82deda drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  520  }
ad07277e82deda drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  521  
ad07277e82deda drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  522  /**
ad07277e82deda drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  523   * acpi_pm_end - Finish up system PM transition.
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  524   */
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  525  static void acpi_pm_end(void)
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  526  {
8ece1d83346bcc drivers/acpi/sleep.c      Hans de Goede           2017-04-30  527  	acpi_turn_off_unused_power_resources();
ad07277e82deda drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  528  	acpi_scan_lock_release();
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  529  	/*
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  530  	 * This is necessary in case acpi_pm_finish() is not called during a
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  531  	 * failing transition to a sleep state.
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  532  	 */
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  533  	acpi_target_sleep_state = ACPI_STATE_S0;
e49f711cc8f3bf drivers/acpi/sleep/main.c Zhao Yakui              2008-08-12  534  	acpi_sleep_tts_switch(acpi_target_sleep_state);
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  535  }
92daa7b53b7698 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-10-23  536  #else /* !CONFIG_ACPI_SLEEP */
92daa7b53b7698 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-10-23  537  #define acpi_target_sleep_state	ACPI_STATE_S0
71630b7a832f69 drivers/acpi/sleep.c      Rafael J. Wysocki       2017-11-06  538  #define acpi_sleep_no_lps0	(false)
0ac1b1d7b7424c drivers/acpi/sleep.c      Zhang Rui               2012-11-30  539  static inline void acpi_sleep_dmi_check(void) {}
5d1e072b6b9cff drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-10-22  540  #endif /* CONFIG_ACPI_SLEEP */
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  541  
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  542  #ifdef CONFIG_SUSPEND
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  543  static u32 acpi_suspend_states[] = {
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  544  	[PM_SUSPEND_ON] = ACPI_STATE_S0,
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  545  	[PM_SUSPEND_STANDBY] = ACPI_STATE_S1,
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  546  	[PM_SUSPEND_MEM] = ACPI_STATE_S3,
e2a5b420f716cd drivers/acpi/sleep/main.c Alexey Starikovskiy     2005-03-18  547  	[PM_SUSPEND_MAX] = ACPI_STATE_S5
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  548  };
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  549  
e9b3aba887f47f drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  550  /**
2c6e33c366bff2 drivers/acpi/sleep/main.c Len Brown               2008-04-23  551   *	acpi_suspend_begin - Set the target system sleep state to the state
e9b3aba887f47f drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  552   *		associated with given @pm_state, if supported.
e9b3aba887f47f drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  553   */
2c6e33c366bff2 drivers/acpi/sleep/main.c Len Brown               2008-04-23  554  static int acpi_suspend_begin(suspend_state_t pm_state)
e9b3aba887f47f drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17 @555  {
e9b3aba887f47f drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  556  	u32 acpi_state = acpi_suspend_states[pm_state];
ad07277e82deda drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  557  	int error;
e9b3aba887f47f drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  558  
1bad2f19f7f79d drivers/acpi/sleep.c      Kristen Carlson Accardi 2012-10-26  559  	error = (nvs_nosave || nvs_nosave_s3) ? 0 : suspend_nvs_alloc();
2a6b69765ad794 drivers/acpi/sleep.c      Matthew Garrett         2010-05-28  560  	if (error)
2a6b69765ad794 drivers/acpi/sleep.c      Matthew Garrett         2010-05-28  561  		return error;
2a6b69765ad794 drivers/acpi/sleep.c      Matthew Garrett         2010-05-28  562  
ad07277e82deda drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  563  	if (!sleep_states[acpi_state]) {
ad07277e82deda drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  564  		pr_err("ACPI does not support sleep state S%u\n", acpi_state);
ad07277e82deda drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  565  		return -ENOSYS;
e9b3aba887f47f drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  566  	}
ef25ba04760159 drivers/acpi/sleep.c      Rafael J. Wysocki       2015-10-07  567  	if (acpi_state > ACPI_STATE_S1)
ef25ba04760159 drivers/acpi/sleep.c      Rafael J. Wysocki       2015-10-07  568  		pm_set_suspend_via_firmware();
ad07277e82deda drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  569  
ad07277e82deda drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  570  	acpi_pm_start(acpi_state);
ad07277e82deda drivers/acpi/sleep.c      Rafael J. Wysocki       2013-08-20  571  	return 0;
e9b3aba887f47f drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  572  }
e9b3aba887f47f drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  573  
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  574  /**
2c6e33c366bff2 drivers/acpi/sleep/main.c Len Brown               2008-04-23  575   *	acpi_suspend_enter - Actually enter a sleep state.
e9b3aba887f47f drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  576   *	@pm_state: ignored
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  577   *
50ad147aa09c82 drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-24  578   *	Flush caches and go to sleep. For STR we have to call arch-specific
50ad147aa09c82 drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-24  579   *	assembly, which in turn call acpi_enter_sleep_state().
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  580   *	It's unfortunate, but it works. Please fix if you're feeling frisky.
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  581   */
2c6e33c366bff2 drivers/acpi/sleep/main.c Len Brown               2008-04-23  582  static int acpi_suspend_enter(suspend_state_t pm_state)
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  583  {
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  584  	acpi_status status = AE_OK;
e9b3aba887f47f drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  585  	u32 acpi_state = acpi_target_sleep_state;
979f11b060c0b3 drivers/acpi/sleep.c      Rafael J. Wysocki       2011-02-08  586  	int error;
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  587  
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  588  	ACPI_FLUSH_CPU_CACHE();
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  589  
bb3632c6101b2f drivers/acpi/sleep.c      Todd E Brandt           2014-06-06  590  	trace_suspend_resume(TPS("acpi_suspend"), acpi_state, true);
e9b3aba887f47f drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  591  	switch (acpi_state) {
e9b3aba887f47f drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  592  	case ACPI_STATE_S1:
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  593  		barrier();
3f6f49c7854c92 drivers/acpi/sleep.c      Len Brown               2012-07-26  594  		status = acpi_enter_sleep_state(acpi_state);
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  595  		break;
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  596  
e9b3aba887f47f drivers/acpi/sleep/main.c Rafael J. Wysocki       2007-07-17  597  	case ACPI_STATE_S3:
d6a77ead21b69c drivers/acpi/sleep.c      Konrad Rzeszutek Wilk   2013-05-14  598  		if (!acpi_suspend_lowlevel)
d6a77ead21b69c drivers/acpi/sleep.c      Konrad Rzeszutek Wilk   2013-05-14  599  			return -ENOSYS;
f1a2003e22f6b5 drivers/acpi/sleep.c      Rafael J. Wysocki       2011-02-08  600  		error = acpi_suspend_lowlevel();
979f11b060c0b3 drivers/acpi/sleep.c      Rafael J. Wysocki       2011-02-08  601  		if (error)
979f11b060c0b3 drivers/acpi/sleep.c      Rafael J. Wysocki       2011-02-08  602  			return error;
7a63f08b2b904d drivers/acpi/sleep.c      Rafael J. Wysocki       2011-02-08  603  		pr_info(PREFIX "Low-level resume complete\n");
ef25ba04760159 drivers/acpi/sleep.c      Rafael J. Wysocki       2015-10-07  604  		pm_set_resume_via_firmware();
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  605  		break;
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  606  	}
bb3632c6101b2f drivers/acpi/sleep.c      Todd E Brandt           2014-06-06  607  	trace_suspend_resume(TPS("acpi_suspend"), acpi_state, false);
872d83d00f6702 drivers/acpi/sleep/main.c Arnaud Patard           2006-04-27  608  
b6dacf63e9fb2e drivers/acpi/sleep.c      Matthew Garrett         2010-05-11  609  	/* This violates the spec but is required for bug compatibility. */
50ffba1bd3120b drivers/acpi/sleep.c      Bob Moore               2009-02-23  610  	acpi_write_bit_register(ACPI_BITREG_SCI_ENABLE, 1);
65df78473ffbf3 drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-11-26  611  
3f6f49c7854c92 drivers/acpi/sleep.c      Len Brown               2012-07-26  612  	/* Reprogram control registers */
3f6f49c7854c92 drivers/acpi/sleep.c      Len Brown               2012-07-26  613  	acpi_leave_sleep_state_prep(acpi_state);
c95d47a868f35c drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-01-08  614  
23b168d425ca0c drivers/acpi/sleep/main.c Pavel Machek            2008-02-05  615  	/* ACPI 3.0 specs (P62) says that it's the responsibility
872d83d00f6702 drivers/acpi/sleep/main.c Arnaud Patard           2006-04-27  616  	 * of the OSPM to clear the status bit [ implying that the
872d83d00f6702 drivers/acpi/sleep/main.c Arnaud Patard           2006-04-27  617  	 * POWER_BUTTON event should not reach userspace ]
c10d7a13846bff drivers/acpi/sleep.c      Daniel Drake            2012-05-10  618  	 *
c10d7a13846bff drivers/acpi/sleep.c      Daniel Drake            2012-05-10  619  	 * However, we do generate a small hint for userspace in the form of
c10d7a13846bff drivers/acpi/sleep.c      Daniel Drake            2012-05-10  620  	 * a wakeup event. We flag this condition for now and generate the
c10d7a13846bff drivers/acpi/sleep.c      Daniel Drake            2012-05-10  621  	 * event later, as we're currently too early in resume to be able to
c10d7a13846bff drivers/acpi/sleep.c      Daniel Drake            2012-05-10  622  	 * generate wakeup events.
872d83d00f6702 drivers/acpi/sleep/main.c Arnaud Patard           2006-04-27  623  	 */
c10d7a13846bff drivers/acpi/sleep.c      Daniel Drake            2012-05-10  624  	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3)) {
51468a9d3a8024 drivers/acpi/sleep.c      Al Stone                2013-11-20  625  		acpi_event_status pwr_btn_status = ACPI_EVENT_FLAG_DISABLED;
c10d7a13846bff drivers/acpi/sleep.c      Daniel Drake            2012-05-10  626  
c10d7a13846bff drivers/acpi/sleep.c      Daniel Drake            2012-05-10  627  		acpi_get_event_status(ACPI_EVENT_POWER_BUTTON, &pwr_btn_status);
c10d7a13846bff drivers/acpi/sleep.c      Daniel Drake            2012-05-10  628  
18864cc4892d20 drivers/acpi/sleep.c      Lv Zheng                2016-08-04  629  		if (pwr_btn_status & ACPI_EVENT_FLAG_STATUS_SET) {
872d83d00f6702 drivers/acpi/sleep/main.c Arnaud Patard           2006-04-27  630  			acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
c10d7a13846bff drivers/acpi/sleep.c      Daniel Drake            2012-05-10  631  			/* Flag for later */
c10d7a13846bff drivers/acpi/sleep.c      Daniel Drake            2012-05-10  632  			pwr_btn_event_pending = true;
c10d7a13846bff drivers/acpi/sleep.c      Daniel Drake            2012-05-10  633  		}
c10d7a13846bff drivers/acpi/sleep.c      Daniel Drake            2012-05-10  634  	}
872d83d00f6702 drivers/acpi/sleep/main.c Arnaud Patard           2006-04-27  635  
a3627f67b1d5dd drivers/acpi/sleep/main.c Shaohua Li              2007-06-20  636  	/*
a3627f67b1d5dd drivers/acpi/sleep/main.c Shaohua Li              2007-06-20  637  	 * Disable and clear GPE status before interrupt is enabled. Some GPEs
a3627f67b1d5dd drivers/acpi/sleep/main.c Shaohua Li              2007-06-20  638  	 * (like wakeup GPE) haven't handler, this can avoid such GPE misfire.
a3627f67b1d5dd drivers/acpi/sleep/main.c Shaohua Li              2007-06-20  639  	 * acpi_leave_sleep_state will reenable specific GPEs later
a3627f67b1d5dd drivers/acpi/sleep/main.c Shaohua Li              2007-06-20  640  	 */
3d97e426aa97d6 drivers/acpi/sleep/main.c Lin Ming                2008-12-16  641  	acpi_disable_all_gpes();
d5a64513c6a171 drivers/acpi/sleep.c      Rafael J. Wysocki       2010-04-09  642  	/* Allow EC transactions to happen. */
c2b46d679b30c5 drivers/acpi/sleep.c      Lv Zheng                2016-08-03  643  	acpi_ec_unblock_transactions();
a3627f67b1d5dd drivers/acpi/sleep/main.c Shaohua Li              2007-06-20  644  
2a6b69765ad794 drivers/acpi/sleep.c      Matthew Garrett         2010-05-28  645  	suspend_nvs_restore();
2a6b69765ad794 drivers/acpi/sleep.c      Matthew Garrett         2010-05-28  646  
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  647  	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  648  }
^1da177e4c3f41 drivers/acpi/sleep/main.c Linus Torvalds          2005-04-16  649  
2c6e33c366bff2 drivers/acpi/sleep/main.c Len Brown               2008-04-23  650  static int acpi_suspend_state_valid(suspend_state_t pm_state)
eb9289eb20df6b drivers/acpi/sleep/main.c Shaohua Li              2005-10-30  651  {
e8c9c502690efd drivers/acpi/sleep/main.c Johannes Berg           2007-04-30  652  	u32 acpi_state;
e8c9c502690efd drivers/acpi/sleep/main.c Johannes Berg           2007-04-30  653  
e8c9c502690efd drivers/acpi/sleep/main.c Johannes Berg           2007-04-30  654  	switch (pm_state) {
e8c9c502690efd drivers/acpi/sleep/main.c Johannes Berg           2007-04-30  655  	case PM_SUSPEND_ON:
e8c9c502690efd drivers/acpi/sleep/main.c Johannes Berg           2007-04-30  656  	case PM_SUSPEND_STANDBY:
e8c9c502690efd drivers/acpi/sleep/main.c Johannes Berg           2007-04-30  657  	case PM_SUSPEND_MEM:
e8c9c502690efd drivers/acpi/sleep/main.c Johannes Berg           2007-04-30  658  		acpi_state = acpi_suspend_states[pm_state];
eb9289eb20df6b drivers/acpi/sleep/main.c Shaohua Li              2005-10-30  659  
eb9289eb20df6b drivers/acpi/sleep/main.c Shaohua Li              2005-10-30  660  		return sleep_states[acpi_state];
e8c9c502690efd drivers/acpi/sleep/main.c Johannes Berg           2007-04-30  661  	default:
e8c9c502690efd drivers/acpi/sleep/main.c Johannes Berg           2007-04-30  662  		return 0;
e8c9c502690efd drivers/acpi/sleep/main.c Johannes Berg           2007-04-30  663  	}
eb9289eb20df6b drivers/acpi/sleep/main.c Shaohua Li              2005-10-30  664  }
eb9289eb20df6b drivers/acpi/sleep/main.c Shaohua Li              2005-10-30  665  
2f55ac072f5344 drivers/acpi/sleep.c      Lionel Debroux          2010-11-16  666  static const struct platform_suspend_ops acpi_suspend_ops = {
2c6e33c366bff2 drivers/acpi/sleep/main.c Len Brown               2008-04-23  667  	.valid = acpi_suspend_state_valid,
2c6e33c366bff2 drivers/acpi/sleep/main.c Len Brown               2008-04-23  668  	.begin = acpi_suspend_begin,
6a7c7eaf71b636 drivers/acpi/sleep.c      Rafael J. Wysocki       2009-04-19  669  	.prepare_late = acpi_pm_prepare,
2c6e33c366bff2 drivers/acpi/sleep/main.c Len Brown               2008-04-23  670  	.enter = acpi_suspend_enter,
618d7fd0d4e51a drivers/acpi/sleep.c      Rafael J. Wysocki       2010-07-02  671  	.wake = acpi_pm_finish,
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  672  	.end = acpi_pm_end,
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  673  };
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  674  
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  675  /**
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  676   *	acpi_suspend_begin_old - Set the target system sleep state to the
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  677   *		state associated with given @pm_state, if supported, and
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  678   *		execute the _PTS control method.  This function is used if the
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  679   *		pre-ACPI 2.0 suspend ordering has been requested.
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  680   */
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  681  static int acpi_suspend_begin_old(suspend_state_t pm_state)
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12 @682  {
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  683  	int error = acpi_suspend_begin(pm_state);
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  684  	if (!error)
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  685  		error = __acpi_pm_prepare();
c5f7a1bb65bca0 drivers/acpi/sleep.c      Rafael J. Wysocki       2010-07-02  686  
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  687  	return error;
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  688  }
d8f3de0d2412bb drivers/acpi/sleep/main.c Rafael J. Wysocki       2008-06-12  689  

:::::: The code at line 516 was first introduced by commit
:::::: ad07277e82dedabacc52c82746633680a3187d25 ACPI / PM: Hold acpi_scan_lock over system PM transitions

:::::: TO: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

