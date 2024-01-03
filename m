Return-Path: <linux-kernel+bounces-15861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C42823469
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454921F25360
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9731C69F;
	Wed,  3 Jan 2024 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcCPQ4JK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D4E1C696
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704306347; x=1735842347;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Kx9yZViV49HTY5nRx4+dvlSNwhlL0q5Bs1LtIPAL2Ys=;
  b=QcCPQ4JKSUstM0YJ6mCapCPNLrq0m/swlArwthWsvVXyET6UhqsZx0CL
   Y/gAUkXmfND2N5/YFzO6/3gjlDxZfbBoP//Y3b/BmHKNLyZxhFwLPy/5x
   YoMJbSCQvswUhaJuoTChF/mp2YQambUyDKYjaYhhcJPszAxxSzsZAiWF+
   rfJs0lZmo7uy3N3waz55UA6HMzoCrskXmbUDTa86w/C4kixvaqzV60pf6
   Y/7Hv0iveIIO6BovP2m30wdtP1c7UEGGEAEMJngDvyDDa9cNKjCXSxcH9
   yyhMgzxWBfXMbnyRpWUyyWOXHsvZerwuH+vRLtPm+CFKHxSqIAJYup6Xr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="461353261"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="461353261"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 10:25:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="780057565"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="780057565"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 03 Jan 2024 10:25:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rL5vz-000MQq-2O;
	Wed, 03 Jan 2024 18:25:43 +0000
Date: Thu, 4 Jan 2024 02:24:52 +0800
From: kernel test robot <lkp@intel.com>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kernel/power/autosleep.c:46:13: sparse: sparse: restricted
 suspend_state_t degrades to integer
Message-ID: <202401040029.M1sKZhsV-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   610a9b8f49fbcf1100716370d3b5f6f884a2835a
commit: 366bb35a8e48198cefcd3484ac6b2374d1347873 LoongArch: Add suspend (ACPI S3) support
date:   1 year, 1 month ago
config: loongarch-randconfig-r035-20230529 (https://download.01.org/0day-ci/archive/20240104/202401040029.M1sKZhsV-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240104/202401040029.M1sKZhsV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401040029.M1sKZhsV-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/power/autosleep.c:46:13: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/autosleep.c:46:32: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/autosleep.c:71:13: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/autosleep.c:71:31: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/autosleep.c:94:13: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/autosleep.c:94:22: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/autosleep.c:106:13: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/autosleep.c:106:21: sparse: sparse: restricted suspend_state_t degrades to integer
--
>> kernel/power/suspend.c:92:54: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] @@
   kernel/power/suspend.c:92:54: sparse:     expected int val
   kernel/power/suspend.c:92:54: sparse:     got restricted suspend_state_t [usertype]
   kernel/power/suspend.c:117:54: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] @@
   kernel/power/suspend.c:117:54: sparse:     expected int val
   kernel/power/suspend.c:117:54: sparse:     got restricted suspend_state_t [usertype]
>> kernel/power/suspend.c:178:19: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:178:47: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:179:19: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:179:51: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:184:26: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:184:65: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:191:42: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:191:51: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:192:38: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:193:51: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:191:72: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:215:34: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:215:73: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:216:27: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:216:59: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:221:34: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:221:69: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:222:21: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:222:42: sparse: sparse: restricted suspend_state_t degrades to integer
>> kernel/power/suspend.c:445:33: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] state @@
   kernel/power/suspend.c:445:33: sparse:     expected int val
   kernel/power/suspend.c:445:33: sparse:     got restricted suspend_state_t [usertype] state
   kernel/power/suspend.c:448:33: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] state @@
   kernel/power/suspend.c:448:33: sparse:     expected int val
   kernel/power/suspend.c:448:33: sparse:     got restricted suspend_state_t [usertype] state
   kernel/power/suspend.c:518:53: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] state @@
   kernel/power/suspend.c:518:53: sparse:     expected int val
   kernel/power/suspend.c:518:53: sparse:     got restricted suspend_state_t [usertype] state
   kernel/power/suspend.c:520:53: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] state @@
   kernel/power/suspend.c:520:53: sparse:     expected int val
   kernel/power/suspend.c:520:53: sparse:     got restricted suspend_state_t [usertype] state
   kernel/power/suspend.c:557:52: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] state @@
   kernel/power/suspend.c:557:52: sparse:     expected int val
   kernel/power/suspend.c:557:52: sparse:     got restricted suspend_state_t [usertype] state
   kernel/power/suspend.c:580:9: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:589:52: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] state @@
   kernel/power/suspend.c:589:52: sparse:     expected int val
   kernel/power/suspend.c:589:52: sparse:     got restricted suspend_state_t [usertype] state
   kernel/power/suspend.c:590:9: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:615:13: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:615:22: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:615:39: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:615:48: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:618:9: sparse: sparse: restricted suspend_state_t degrades to integer

vim +46 kernel/power/autosleep.c

7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  26  
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  27  static void try_to_suspend(struct work_struct *work)
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  28  {
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  29  	unsigned int initial_count, final_count;
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  30  
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  31  	if (!pm_get_wakeup_count(&initial_count, true))
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  32  		goto out;
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  33  
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  34  	mutex_lock(&autosleep_lock);
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  35  
e5248a111bf404 Liu ShuoX         2013-07-11  36  	if (!pm_save_wakeup_count(initial_count) ||
e5248a111bf404 Liu ShuoX         2013-07-11  37  		system_state != SYSTEM_RUNNING) {
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  38  		mutex_unlock(&autosleep_lock);
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  39  		goto out;
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  40  	}
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  41  
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  42  	if (autosleep_state == PM_SUSPEND_ON) {
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  43  		mutex_unlock(&autosleep_lock);
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  44  		return;
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  45  	}
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29 @46  	if (autosleep_state >= PM_SUSPEND_MAX)
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  47  		hibernate();
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  48  	else
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  49  		pm_suspend(autosleep_state);
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  50  
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  51  	mutex_unlock(&autosleep_lock);
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  52  
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  53  	if (!pm_get_wakeup_count(&final_count, false))
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  54  		goto out;
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  55  
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  56  	/*
e4b2897ae1a81c Lu Jialin         2021-04-08  57  	 * If the wakeup occurred for an unknown reason, wait to prevent the
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  58  	 * system from trying to suspend and waking up in a tight loop.
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  59  	 */
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  60  	if (final_count == initial_count)
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  61  		schedule_timeout_uninterruptible(HZ / 2);
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  62  
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  63   out:
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  64  	queue_up_suspend_work();
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  65  }
7483b4a4d9abf9 Rafael J. Wysocki 2012-04-29  66  

:::::: The code at line 46 was first introduced by commit
:::::: 7483b4a4d9abf9dcf1ffe6e805ead2847ec3264e PM / Sleep: Implement opportunistic sleep, v2

:::::: TO: Rafael J. Wysocki <rjw@sisk.pl>
:::::: CC: Rafael J. Wysocki <rjw@sisk.pl>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

