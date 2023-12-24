Return-Path: <linux-kernel+bounces-10842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE8981DCDF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 23:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17486281D6C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 22:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B0A10783;
	Sun, 24 Dec 2023 22:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FxeyGDb/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B95910782
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 22:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703456860; x=1734992860;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=i5LtL5D/0qbaup3ppR3Dy09mfn99Uys+Jv8wqXg6Riw=;
  b=FxeyGDb/jSj5J3kFp6YpmMEt91XrXu6faqUMsx2WrdZEp499fh/buLMX
   8vNX1ZyStZ+EhdkoT7UMTRHahnYkdxvjk7NlyZJIpKlhBFjmaZvnC7RKo
   jRxamGzuM1ZSUv4xGr13sWcJQU6DulAFFGBu5GCTOG39qzNa0xOV7V15H
   w+kn2+C2OTF7tthde9TsU4lP2MY8RmjFA9rbXmB+RU1t3h9fbsKcMN9QT
   rZ6eEL7O5PuxBD+HM5aRnlf2N77UBA11oLxmpBmxFvwAcW6GnUZdXt5gG
   cDC1ZVrK8QUHMoN5sOmOPwUhgltqbfj9/xUGYEk6ZeTayIXAdaRO7L9Sw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="9765459"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="9765459"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 14:27:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="811905921"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="811905921"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 24 Dec 2023 14:27:37 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHWwX-000Cgr-1v;
	Sun, 24 Dec 2023 22:27:34 +0000
Date: Mon, 25 Dec 2023 06:26:52 +0800
From: kernel test robot <lkp@intel.com>
To: Keerthy <j-keerthy@ti.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>
Subject: drivers/rtc/rtc-omap.c:424: warning: Function parameter or member
 'dev' not described in 'omap_rtc_power_off_program'
Message-ID: <202312250610.si1QZoLJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   861deac3b092f37b2c5e6871732f3e11486f7082
commit: 6256f7f7f217b2216fcb73929508325f4ee98237 rtc: OMAP: Add support for rtc-only mode
date:   4 years, 9 months ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20231225/202312250610.si1QZoLJ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231225/202312250610.si1QZoLJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312250610.si1QZoLJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/rtc/rtc-omap.c:424: warning: Function parameter or member 'dev' not described in 'omap_rtc_power_off_program'


vim +424 drivers/rtc/rtc-omap.c

222a12fca60482 Johan Hovold 2014-12-10  417  
6256f7f7f217b2 Keerthy      2019-04-03  418  /**
6256f7f7f217b2 Keerthy      2019-04-03  419   * omap_rtc_power_off_program: Set the pmic power off sequence. The RTC
6256f7f7f217b2 Keerthy      2019-04-03  420   * generates pmic_pwr_enable control, which can be used to control an external
6256f7f7f217b2 Keerthy      2019-04-03  421   * PMIC.
222a12fca60482 Johan Hovold 2014-12-10  422   */
6256f7f7f217b2 Keerthy      2019-04-03  423  int omap_rtc_power_off_program(struct device *dev)
222a12fca60482 Johan Hovold 2014-12-10 @424  {
222a12fca60482 Johan Hovold 2014-12-10  425  	struct omap_rtc *rtc = omap_rtc_power_off_rtc;
222a12fca60482 Johan Hovold 2014-12-10  426  	struct rtc_time tm;
222a12fca60482 Johan Hovold 2014-12-10  427  	unsigned long now;
09058eab4b4f77 Keerthy      2018-08-16  428  	int seconds;
222a12fca60482 Johan Hovold 2014-12-10  429  	u32 val;
222a12fca60482 Johan Hovold 2014-12-10  430  
9c28bd07c20776 Lokesh Vutla 2015-04-16  431  	rtc->type->unlock(rtc);
222a12fca60482 Johan Hovold 2014-12-10  432  	/* enable pmic_power_en control */
222a12fca60482 Johan Hovold 2014-12-10  433  	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
222a12fca60482 Johan Hovold 2014-12-10  434  	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
222a12fca60482 Johan Hovold 2014-12-10  435  
09058eab4b4f77 Keerthy      2018-08-16  436  again:
6256f7f7f217b2 Keerthy      2019-04-03  437  	/* Clear any existing ALARM2 event */
6256f7f7f217b2 Keerthy      2019-04-03  438  	rtc_writel(rtc, OMAP_RTC_STATUS_REG, OMAP_RTC_STATUS_ALARM2);
6256f7f7f217b2 Keerthy      2019-04-03  439  
09058eab4b4f77 Keerthy      2018-08-16  440  	/* set alarm one second from now */
222a12fca60482 Johan Hovold 2014-12-10  441  	omap_rtc_read_time_raw(rtc, &tm);
09058eab4b4f77 Keerthy      2018-08-16  442  	seconds = tm.tm_sec;
222a12fca60482 Johan Hovold 2014-12-10  443  	bcd2tm(&tm);
222a12fca60482 Johan Hovold 2014-12-10  444  	rtc_tm_to_time(&tm, &now);
09058eab4b4f77 Keerthy      2018-08-16  445  	rtc_time_to_tm(now + 1, &tm);
222a12fca60482 Johan Hovold 2014-12-10  446  
222a12fca60482 Johan Hovold 2014-12-10  447  	if (tm2bcd(&tm) < 0) {
222a12fca60482 Johan Hovold 2014-12-10  448  		dev_err(&rtc->rtc->dev, "power off failed\n");
4425070a5cfe63 Johan Hovold 2018-07-04  449  		rtc->type->lock(rtc);
6256f7f7f217b2 Keerthy      2019-04-03  450  		return -EINVAL;
222a12fca60482 Johan Hovold 2014-12-10  451  	}
222a12fca60482 Johan Hovold 2014-12-10  452  
222a12fca60482 Johan Hovold 2014-12-10  453  	rtc_wait_not_busy(rtc);
222a12fca60482 Johan Hovold 2014-12-10  454  
222a12fca60482 Johan Hovold 2014-12-10  455  	rtc_write(rtc, OMAP_RTC_ALARM2_SECONDS_REG, tm.tm_sec);
222a12fca60482 Johan Hovold 2014-12-10  456  	rtc_write(rtc, OMAP_RTC_ALARM2_MINUTES_REG, tm.tm_min);
222a12fca60482 Johan Hovold 2014-12-10  457  	rtc_write(rtc, OMAP_RTC_ALARM2_HOURS_REG, tm.tm_hour);
222a12fca60482 Johan Hovold 2014-12-10  458  	rtc_write(rtc, OMAP_RTC_ALARM2_DAYS_REG, tm.tm_mday);
222a12fca60482 Johan Hovold 2014-12-10  459  	rtc_write(rtc, OMAP_RTC_ALARM2_MONTHS_REG, tm.tm_mon);
222a12fca60482 Johan Hovold 2014-12-10  460  	rtc_write(rtc, OMAP_RTC_ALARM2_YEARS_REG, tm.tm_year);
222a12fca60482 Johan Hovold 2014-12-10  461  
222a12fca60482 Johan Hovold 2014-12-10  462  	/*
222a12fca60482 Johan Hovold 2014-12-10  463  	 * enable ALARM2 interrupt
222a12fca60482 Johan Hovold 2014-12-10  464  	 *
222a12fca60482 Johan Hovold 2014-12-10  465  	 * NOTE: this fails on AM3352 if rtc_write (writeb) is used
222a12fca60482 Johan Hovold 2014-12-10  466  	 */
222a12fca60482 Johan Hovold 2014-12-10  467  	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
222a12fca60482 Johan Hovold 2014-12-10  468  	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
222a12fca60482 Johan Hovold 2014-12-10  469  			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
09058eab4b4f77 Keerthy      2018-08-16  470  
09058eab4b4f77 Keerthy      2018-08-16  471  	/* Retry in case roll over happened before alarm was armed. */
09058eab4b4f77 Keerthy      2018-08-16  472  	if (rtc_read(rtc, OMAP_RTC_SECONDS_REG) != seconds) {
09058eab4b4f77 Keerthy      2018-08-16  473  		val = rtc_read(rtc, OMAP_RTC_STATUS_REG);
09058eab4b4f77 Keerthy      2018-08-16  474  		if (!(val & OMAP_RTC_STATUS_ALARM2))
09058eab4b4f77 Keerthy      2018-08-16  475  			goto again;
09058eab4b4f77 Keerthy      2018-08-16  476  	}
09058eab4b4f77 Keerthy      2018-08-16  477  
9c28bd07c20776 Lokesh Vutla 2015-04-16  478  	rtc->type->lock(rtc);
222a12fca60482 Johan Hovold 2014-12-10  479  
6256f7f7f217b2 Keerthy      2019-04-03  480  	return 0;
6256f7f7f217b2 Keerthy      2019-04-03  481  }
6256f7f7f217b2 Keerthy      2019-04-03  482  EXPORT_SYMBOL(omap_rtc_power_off_program);
6256f7f7f217b2 Keerthy      2019-04-03  483  

:::::: The code at line 424 was first introduced by commit
:::::: 222a12fca6048249d9007f2a4c5fbcea532e8522 rtc: omap: add support for pmic_power_en

:::::: TO: Johan Hovold <johan@kernel.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

