Return-Path: <linux-kernel+bounces-28960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0514B830534
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B34DB23758
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6191EB41;
	Wed, 17 Jan 2024 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Va+ueg3V"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36B61DFEC;
	Wed, 17 Jan 2024 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705494427; cv=none; b=AbUm4DlfDW7e1i30sjOuM7xJwa11TZHx+4QEsooj9nWgBnbtwpO+6KRinq8Ng+NgAD9z7cVfy/nL3GZXuFF15ytV7kSw3cNfcB4duKz+1jVqEb+Q4VuyVxttP8/tT+6pyF7cUdO7kAF+tZEPZjz7ehKrw3lqAuzQbTqyPyWmw38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705494427; c=relaxed/simple;
	bh=SPxDYahHv0nLu9NS4KwJmiOrGhMzRJC83ePBpU4CLVQ=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UOfcufC9ZOXLonuFxdzxEyB/Mq4vZy334/NMso71PekLIv8hcAdhdyVOf0NWuo5aQi/I/kRkfFf4Lc5KSGWQJhi0puwxS+uR6HSIyTjD9kE4hsfqwcBpJVlw1tWsX6vK0hIAycNsB3no/abkcZqbkLzHAOrsFqA7WHzWszi1NIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Va+ueg3V; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705494426; x=1737030426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SPxDYahHv0nLu9NS4KwJmiOrGhMzRJC83ePBpU4CLVQ=;
  b=Va+ueg3VyKLME0NjPbSrhJItg9qKUGE4RrXteaDXtsEI6q3ZXgDJCmBb
   Tzw2Ju2uf/+DHUQ8chHre9wpAx8pp39P385kIE6GJwKLrS9ejZTkp0BAc
   zXRBkVW85+5+xJ8BamiazlwVuTzMjP5C5WYOJCzujpx59qrlpjMnYvoMj
   W+YoZM65N+PO7syDtPDSr0XhmUfjLHNTfadHbjji9Au7B+yD06W4i+OJk
   ooiMNgYP+pl3vF1YlohACBbtPhiJ8S0VLJ1kDc+Ag6Tmp2Qd6xhmyFzIg
   3vdJDASX1GnT0QD9t/QLOSpK8f+1yWO9yBWLVfgxT83R+qN65gwbZvHVE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="40816"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="40816"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 04:27:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="907745448"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="907745448"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 17 Jan 2024 04:27:01 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQ50V-0001yl-0l;
	Wed, 17 Jan 2024 12:26:59 +0000
Date: Wed, 17 Jan 2024 20:26:50 +0800
From: kernel test robot <lkp@intel.com>
To: Pohsun Su <pohsuns@nvidia.com>, daniel.lezcano@linaro.org,
	tglx@linutronix.de, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: oe-kbuild-all@lists.linux.dev, sumitg@nvidia.com,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	Pohsun Su <pohsuns@nvidia.com>
Subject: Re: [PATCH 1/2] clocksource/drivers/timer-tegra186: add
 WDIOC_GETTIMELEFT support
Message-ID: <202401172015.KdPd7tda-lkp@intel.com>
References: <20240116115838.16544-2-pohsuns@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116115838.16544-2-pohsuns@nvidia.com>

Hi Pohsun,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/timers/core]
[also build test ERROR on linus/master v6.7 next-20240117]
[cannot apply to daniel-lezcano/clockevents/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pohsun-Su/clocksource-drivers-timer-tegra186-add-WDIOC_GETTIMELEFT-support/20240116-200217
base:   tip/timers/core
patch link:    https://lore.kernel.org/r/20240116115838.16544-2-pohsuns%40nvidia.com
patch subject: [PATCH 1/2] clocksource/drivers/timer-tegra186: add WDIOC_GETTIMELEFT support
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20240117/202401172015.KdPd7tda-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240117/202401172015.KdPd7tda-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401172015.KdPd7tda-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/clocksource/timer-tegra186.c: In function 'tegra186_wdt_get_timeleft':
>> drivers/clocksource/timer-tegra186.c:263:22: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
     263 |         expiration = FIELD_GET(WDTSR_CURRENT_EXPIRATION_COUNT, readl_relaxed(wdt->regs + WDTSR));
         |                      ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_GET +263 drivers/clocksource/timer-tegra186.c

   240	
   241	static unsigned int tegra186_wdt_get_timeleft(struct watchdog_device *wdd)
   242	{
   243		struct tegra186_wdt *wdt = to_tegra186_wdt(wdd);
   244		u32 timeleft;
   245		u32 expiration;
   246	
   247		if (!watchdog_active(&wdt->base)) {
   248			/* return zero if the watchdog timer is not activated. */
   249			return 0;
   250		}
   251	
   252		/*
   253		 * System power-on reset occurs on the fifth expiration of the watchdog timer and so
   254		 * when the watchdog timer is configured, the actual value programmed into the counter
   255		 * is 1/5 of the timeout value. Once the counter reaches 0, expiration count will be
   256		 * increased by 1 and the down counter restarts.
   257		 * Hence to get the time left before system reset we must combine 2 parts:
   258		 * 1. value of the current down counter
   259		 * 2. (number of counter expirations remaining) * (timeout/5)
   260		 */
   261	
   262		/* Get the current number of counter expirations. Should be a value between 0 and 4. */
 > 263		expiration = FIELD_GET(WDTSR_CURRENT_EXPIRATION_COUNT, readl_relaxed(wdt->regs + WDTSR));
   264	
   265		/* Convert the current counter value to seconds, rounding up to the nearest second. */
   266		timeleft = FIELD_GET(TMRSR_PCV, readl_relaxed(wdt->tmr->regs + TMRSR));
   267		timeleft = (timeleft + USEC_PER_SEC / 2) / USEC_PER_SEC;
   268	
   269		/*
   270		 * Calculate the time remaining by adding the time for the counter value
   271		 * to the time of the counter expirations that remain.
   272		 */
   273		timeleft += wdt->base.timeout * (4 - expiration) / 5;
   274		return timeleft;
   275	}
   276	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

