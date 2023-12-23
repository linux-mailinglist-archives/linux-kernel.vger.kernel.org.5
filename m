Return-Path: <linux-kernel+bounces-10381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A9A81D388
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 11:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B141C21554
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 10:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D734CA5F;
	Sat, 23 Dec 2023 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hv19Ut4T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D90BCA43
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703327658; x=1734863658;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8++kfyff+pLYrGH/kYYFM9D41+Uz29KHQ71ic7N+tE0=;
  b=hv19Ut4TpmTfKgbcZ/LXZCZ2zNHTpBjbD6DYj8BaD4BLLHCTo9kaRaAO
   8IXVZMX4dbO47S9IqPGFw8j22/nXqhpZ1L+2cGhJoK9xE1dDiRWO9XHoJ
   G4kxaZ3EFHXmLCk18zSKBzElh9d9TNyxS3FjvsVaawrKLCCjAmFGiKxYM
   asMJaertTWO7zvEVJGpWKHE17BFXRQMo2oDd1DtEwpNIYc/sz24EREieh
   l2klpaJTvSk/Ad/hjIlMiqz4miuxcBZufPudb7+lCgJ0k5M+edUPDlC0f
   rsMOZPybm7tqZrd7KRsUolfqkumHvBuZ4M9kw8rcUrYsTbGvBE+8Mzc6x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="400018994"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="400018994"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 02:34:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="843249069"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="843249069"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 23 Dec 2023 02:34:16 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGzKO-000AeD-0z;
	Sat, 23 Dec 2023 10:34:07 +0000
Date: Sat, 23 Dec 2023 18:30:58 +0800
From: kernel test robot <lkp@intel.com>
To: Anson Huang <anson.huang@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: drivers/clocksource/timer-imx-gpt.c:279:18: warning: variable
 'tstat' set but not used
Message-ID: <202312231803.XzPddRa5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5254c0cbc92d2a08e75443bdb914f1c4839cdf5a
commit: df181e38281602bb404c5c8158a87317274dc653 clocksource/drivers/imx-gpt: Add support for ARM64
date:   5 years ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20231223/202312231803.XzPddRa5-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231223/202312231803.XzPddRa5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312231803.XzPddRa5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clocksource/timer-imx-gpt.c: In function 'mxc_timer_interrupt':
>> drivers/clocksource/timer-imx-gpt.c:279:18: warning: variable 'tstat' set but not used [-Wunused-but-set-variable]
     279 |         uint32_t tstat;
         |                  ^~~~~


vim +/tstat +279 drivers/clocksource/timer-imx-gpt.c

d0f349fbce2905 arch/arm/plat-mxc/time.c Juergen Beisert 2008-07-05  271  
d0f349fbce2905 arch/arm/plat-mxc/time.c Juergen Beisert 2008-07-05  272  /*
d0f349fbce2905 arch/arm/plat-mxc/time.c Juergen Beisert 2008-07-05  273   * IRQ handler for the timer
d0f349fbce2905 arch/arm/plat-mxc/time.c Juergen Beisert 2008-07-05  274   */
d0f349fbce2905 arch/arm/plat-mxc/time.c Juergen Beisert 2008-07-05  275  static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
d0f349fbce2905 arch/arm/plat-mxc/time.c Juergen Beisert 2008-07-05  276  {
e510d2015d38a2 arch/arm/mach-imx/time.c Shawn Guo       2015-05-22  277  	struct clock_event_device *ced = dev_id;
24f74ad1c75e98 arch/arm/mach-imx/time.c Shawn Guo       2015-05-22  278  	struct imx_timer *imxtm = to_imx_timer(ced);
d0f349fbce2905 arch/arm/plat-mxc/time.c Juergen Beisert 2008-07-05 @279  	uint32_t tstat;
d0f349fbce2905 arch/arm/plat-mxc/time.c Juergen Beisert 2008-07-05  280  
24f74ad1c75e98 arch/arm/mach-imx/time.c Shawn Guo       2015-05-22  281  	tstat = readl_relaxed(imxtm->base + imxtm->gpt->reg_tstat);
d0f349fbce2905 arch/arm/plat-mxc/time.c Juergen Beisert 2008-07-05  282  
db2ae4b4f6b79b arch/arm/mach-imx/time.c Shawn Guo       2015-05-22  283  	imxtm->gpt->gpt_irq_acknowledge(imxtm);
d0f349fbce2905 arch/arm/plat-mxc/time.c Juergen Beisert 2008-07-05  284  
e510d2015d38a2 arch/arm/mach-imx/time.c Shawn Guo       2015-05-22  285  	ced->event_handler(ced);
d0f349fbce2905 arch/arm/plat-mxc/time.c Juergen Beisert 2008-07-05  286  
d0f349fbce2905 arch/arm/plat-mxc/time.c Juergen Beisert 2008-07-05  287  	return IRQ_HANDLED;
d0f349fbce2905 arch/arm/plat-mxc/time.c Juergen Beisert 2008-07-05  288  }
d0f349fbce2905 arch/arm/plat-mxc/time.c Juergen Beisert 2008-07-05  289  

:::::: The code at line 279 was first introduced by commit
:::::: d0f349fbce2905607e0473d2358f97f48866e52c i.MXC family: Adding timer support

:::::: TO: Juergen Beisert <j.beisert@pengutronix.de>
:::::: CC: Robert Schwebel <r.schwebel@pengutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

