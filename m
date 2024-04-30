Return-Path: <linux-kernel+bounces-163338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DD18B699D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2092820D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30183134CE;
	Tue, 30 Apr 2024 04:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNbc8sTi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D543712B79
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 04:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714452793; cv=none; b=hqv/3OSx3AlP9t3h53741FT3bvd8E9Dv8R54QLnLY25TUzfzVxH6wI2cJB640ZYlTl7kCBsT1oaSn115KLBe8xUFH4pAQgPHw7XF5Cd7mW2/AcxsrCxPye7bsu89OYNYKzDnZAbZWpBXVWKllQkxhmYRUgRN7k4hPhfvu0Pmg0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714452793; c=relaxed/simple;
	bh=DkVvfBoEWFqQWzVcM39rawLmVug7ROd9HQ2bH24zgbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqZzRyKKn/IjfXoxo+5usyNzSVXxzbgOzoaPx9HuGmKVhTxNfAF/OTKmCZgoUO21ezMlHbPkpp7qgtkkkcq3niLVOz0F/OsYQRumbjkfEEgAzyaZYYg+jHAqiN0vKqEOG1gQz3uX5XiROXxK3Iw5YTUlmDHTRaRGVKkSRy9tHfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNbc8sTi; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714452792; x=1745988792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DkVvfBoEWFqQWzVcM39rawLmVug7ROd9HQ2bH24zgbo=;
  b=TNbc8sTiRQ4BGk5RUhGmvjffTsT0FryVEusy83ZBhWmm02xBvLc+bhIj
   obYAf3OR73WDNVFZKZAzbiawqxeZFXQ+qUR0vTC0yWRKtKu+mPjTbDk96
   Mi3AluolO4wkkbERRFOTom2vpT0yI8sJKZK4x+BjrHbOLTjTEkieVk+Py
   jqF89S4W4bKFNKc24MsKdII/QvRSTgKU/a+D1LtGhIhwFRVIBbogZoZJ8
   6D57syboIYwQj2PWrnjxWER4WB9pxzknD4Qx1jVfUQediNJeDFrM40KAD
   aZXUPONhyJ3vs1oKk4lnSx16h5b2AWOxJE+DjThPfqfGFJ/MFIx2vnVZa
   g==;
X-CSE-ConnectionGUID: cnFoSjY/SuOJ2Xma2UZdeA==
X-CSE-MsgGUID: XZX48ExzRGOSr15Rg02oEw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="20690858"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="20690858"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 21:53:11 -0700
X-CSE-ConnectionGUID: 7Zm8U0+EQyeBz6/3PaAnHw==
X-CSE-MsgGUID: JHJS+w1PRTqzdUHLK1hTJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26341129"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 29 Apr 2024 21:53:10 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1fUJ-0007kS-2h;
	Tue, 30 Apr 2024 04:53:07 +0000
Date: Tue, 30 Apr 2024 12:53:02 +0800
From: kernel test robot <lkp@intel.com>
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] regulator/core: use rdev->dev.driver_data
Message-ID: <202404301218.URkWO6dj-lkp@intel.com>
References: <0a480abe4913f0169f9693f6f959fbe1a397ae93.1714399603.git.mirq-linux@rere.qmqm.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a480abe4913f0169f9693f6f959fbe1a397ae93.1714399603.git.mirq-linux@rere.qmqm.pl>

Hi Michał,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-regulator/for-next]
[also build test ERROR on linus/master v6.9-rc6 next-20240429]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Micha-Miros-aw/regulator-core-_regulator_get-simplify-error-returns/20240429-225643
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/0a480abe4913f0169f9693f6f959fbe1a397ae93.1714399603.git.mirq-linux%40rere.qmqm.pl
patch subject: [PATCH v2 12/12] regulator/core: use rdev->dev.driver_data
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240430/202404301218.URkWO6dj-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240430/202404301218.URkWO6dj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404301218.URkWO6dj-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pinctrl/renesas/pfc-sh73a0.c: In function 'sh73a0_vccq_mc0_endisable':
>> drivers/pinctrl/renesas/pfc-sh73a0.c:4027:33: error: 'struct regulator_dev' has no member named 'reg_data'
    4027 |         struct sh_pfc *pfc = reg->reg_data;
         |                                 ^~
   drivers/pinctrl/renesas/pfc-sh73a0.c: In function 'sh73a0_vccq_mc0_is_enabled':
   drivers/pinctrl/renesas/pfc-sh73a0.c:4060:33: error: 'struct regulator_dev' has no member named 'reg_data'
    4060 |         struct sh_pfc *pfc = reg->reg_data;
         |                                 ^~


vim +4027 drivers/pinctrl/renesas/pfc-sh73a0.c

5d5166dc39bcbe drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2012-12-15  4020  
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4021  /* -----------------------------------------------------------------------------
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4022   * VCCQ MC0 regulator
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4023   */
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4024  
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4025  static void sh73a0_vccq_mc0_endisable(struct regulator_dev *reg, bool enable)
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4026  {
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21 @4027  	struct sh_pfc *pfc = reg->reg_data;
5b46ac3a772363 drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-12-11  4028  	void __iomem *addr = pfc->windows[1].virt + 4;
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4029  	unsigned long flags;
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4030  	u32 value;
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4031  
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4032  	spin_lock_irqsave(&pfc->lock, flags);
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4033  
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4034  	value = ioread32(addr);
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4035  
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4036  	if (enable)
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4037  		value |= BIT(28);
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4038  	else
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4039  		value &= ~BIT(28);
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4040  
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4041  	iowrite32(value, addr);
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4042  
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4043  	spin_unlock_irqrestore(&pfc->lock, flags);
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4044  }
ea770ad2ec054e drivers/pinctrl/sh-pfc/pfc-sh73a0.c Laurent Pinchart 2013-04-21  4045  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

