Return-Path: <linux-kernel+bounces-163277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB2B8B6818
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 104A2B22920
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ADEDDD4;
	Tue, 30 Apr 2024 02:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="es3ARhll"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BC7D517
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714445711; cv=none; b=sNqX3NSCESh4Hap3Ld1c2mdnayZzktZZWrY/3z8M5EGnEOk7PuCB7EMKO/cKvsmcsjgfqRaBrPRoxicxLK6QCkek5Nk6ws2J9101qwP53IoPZ3db//alO1PQ4xrrRDG1TZvLc2C0gg0mW7uLA8s43+fD8qqBMuSmkUhYjj2C+mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714445711; c=relaxed/simple;
	bh=ExWorg8csLev0xgzdbCQ6Dl33M2pKTLdVDyAyE9ASyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkqneLBujAXbi5/wkjww9T/P7Dc4aP/La2QN1ToEERedX4a7I8zFdjhHALzOgdAddVeMONnvlJCiAqTybN93UuToyN81rSQPYqrj4iZRgov2cx0dvi6dY6VvAQoicAQ0/jGhy8O/AcjOrlG9mA2s+MRgoSEt9/CrtCBSpXAKdP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=es3ARhll; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714445709; x=1745981709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ExWorg8csLev0xgzdbCQ6Dl33M2pKTLdVDyAyE9ASyM=;
  b=es3ARhllIKfGuQ0Vg53Gb7EOSMSRycbMu7fdQhmiQG6i5YoKUd708ai8
   QAoLBUXLahL96JHliA5BiuyRva5kAfKpxXMIQgUNBGxWOXrPfNoP5oM6o
   DLVOQTDiaKvdMN2s/fkSaiqbd3Bd8OVxei7MnXNY9ZmQISccZk1BhocIb
   ZluW7YU9i63WQSdioBseFlCkxEtfVmzmTBSrgrmXqF6zox5ysWP8Eo0gY
   9s2jbDYUjYvRKakhzWxF8nNrfUvHQOPcFWOSmFEpZPB4AzCzTErQpbrY5
   dLMQRZcIFjQ2Jd0o/GPBxmau/16vUbaiXbVI7QaU1AJc62OriMnm7bH9Q
   A==;
X-CSE-ConnectionGUID: 4Fr40NX0Ryuv/jJh9hC+7Q==
X-CSE-MsgGUID: q7hQDB4kQPuyfBHJpUgFog==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="27649043"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="27649043"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 19:55:08 -0700
X-CSE-ConnectionGUID: hjsGboJWRqK0rLAoDpFUKw==
X-CSE-MsgGUID: uDyaMgUMR9WCv7ZKHDwQ5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26315478"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 29 Apr 2024 19:55:06 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1de4-0007e8-0u;
	Tue, 30 Apr 2024 02:55:04 +0000
Date: Tue, 30 Apr 2024 10:54:59 +0800
From: kernel test robot <lkp@intel.com>
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] regulator/core: use rdev->dev.driver_data
Message-ID: <202404301020.eKVj3WAI-lkp@intel.com>
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
config: arm-randconfig-001-20240430 (https://download.01.org/0day-ci/archive/20240430/202404301020.eKVj3WAI-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 37ae4ad0eef338776c7e2cffb3896153d43dcd90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240430/202404301020.eKVj3WAI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404301020.eKVj3WAI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pinctrl/renesas/pfc-sh73a0.c:12:
   In file included from include/linux/regulator/driver.h:18:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/pinctrl/renesas/pfc-sh73a0.c:4027:28: error: no member named 'reg_data' in 'struct regulator_dev'
    4027 |         struct sh_pfc *pfc = reg->reg_data;
         |                              ~~~  ^
   drivers/pinctrl/renesas/pfc-sh73a0.c:4060:28: error: no member named 'reg_data' in 'struct regulator_dev'
    4060 |         struct sh_pfc *pfc = reg->reg_data;
         |                              ~~~  ^
   1 warning and 2 errors generated.


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

