Return-Path: <linux-kernel+bounces-2856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCCC8162E2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B10D1C21262
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD8D49F81;
	Sun, 17 Dec 2023 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkXb2VYv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7490F4B123;
	Sun, 17 Dec 2023 22:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702853280; x=1734389280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dDK21WhxmK46apj+aDS2uGaxysiciuckJMISoafo2u8=;
  b=nkXb2VYv1vNxUNRKWRxVCztbyXYeCCTzyXCjW/M64sW1Pdc4WN1w/oNU
   N+jZjYYY0PZjN7w3HQT2uAZViGHjP0X/1mQwl7LITHiV8at4CQicIHCdd
   slae2+oqsQjrl4WqcUUS6IYpjSkoX8S4HEhFEhHZEee25q9XnpFIP/U/H
   Y5QfB639zp+H6VL7PCSKO2bdRLZMfBnccPPgmZLYK4Mb/LTfNfEbEsSo/
   a28SvYHTYsmNn+FjIs1alQqEfDJ4ZxeaTvC5/1ayuPQqfAnGswnOOEVz7
   9poVyXnFEtzEa4gosFsfrMcWVpzmFeJY2cp0jcjvV9ryHExaVEHKWdFBs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="8792016"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="8792016"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 14:47:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="1022558489"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="1022558489"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 17 Dec 2023 14:47:54 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEzvL-0003UK-2j;
	Sun, 17 Dec 2023 22:47:51 +0000
Date: Mon, 18 Dec 2023 06:47:39 +0800
From: kernel test robot <lkp@intel.com>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>, a.zummo@towertech.it,
	alexandre.belloni@bootlin.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
	conor+dt@kernel.org, chao.wei@sophgo.com, unicorn_wang@outlook.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: oe-kbuild-all@lists.linux.dev, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dlan@gentoo.org, Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: Re: [PATCH v2 2/3] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
Message-ID: <202312180655.uM6zOZlv-lkp@intel.com>
References: <20231217110952.78784-3-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217110952.78784-3-qiujingbao.dlmu@gmail.com>

Hi Jingbao,

kernel test robot noticed the following build errors:

[auto build test ERROR on abelloni/rtc-next]
[also build test ERROR on robh/for-next linus/master v6.7-rc5 next-20231215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jingbao-Qiu/dt-bindings-rtc-sophgo-add-RTC-support-for-Sophgo-CV1800-series-SoC/20231217-191123
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
patch link:    https://lore.kernel.org/r/20231217110952.78784-3-qiujingbao.dlmu%40gmail.com
patch subject: [PATCH v2 2/3] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20231218/202312180655.uM6zOZlv-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231218/202312180655.uM6zOZlv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312180655.uM6zOZlv-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/rtc/rtc-cv1800.c: In function 'cv1800_rtc_alarm_irq_enable':
>> drivers/rtc/rtc-cv1800.c:89:17: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]
      89 |                 writel(REG_ENABLE_FUN, info->base_data + ALARM_ENABLE);
         |                 ^~~~~~
   drivers/rtc/rtc-cv1800.c: In function 'cv1800_rtc_set_alarm':
>> drivers/rtc/rtc-cv1800.c:113:9: error: implicit declaration of function 'readl' [-Werror=implicit-function-declaration]
     113 |         readl(info->base_data + SEC_CNTR_VAL);
         |         ^~~~~
   cc1: some warnings being treated as errors


vim +/writel +89 drivers/rtc/rtc-cv1800.c

    83	
    84	static int cv1800_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
    85	{
    86		struct cv1800_priv *info = dev_get_drvdata(dev);
    87	
    88		if (enabled)
  > 89			writel(REG_ENABLE_FUN, info->base_data + ALARM_ENABLE);
    90		else
    91			writel(REG_DISABLE_FUN, info->base_data + ALARM_ENABLE);
    92	
    93		return 0;
    94	}
    95	
    96	static int cv1800_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
    97	{
    98		struct cv1800_priv *info = dev_get_drvdata(dev);
    99		unsigned long alarm_time;
   100	
   101		alarm_time = rtc_tm_to_time64(&alrm->time);
   102	
   103		if (alarm_time > SEC_MAX_VAL)
   104			return -EINVAL;
   105	
   106		writel(REG_DISABLE_FUN, info->base_data + ALARM_ENABLE);
   107	
   108		udelay(DEALY_TIME_PREPARE);
   109	
   110		writel(alarm_time, info->base_data + ALARM_TIME);
   111		writel(REG_ENABLE_FUN, info->base_data + ALARM_ENABLE);
   112	
 > 113		readl(info->base_data + SEC_CNTR_VAL);
   114	
   115		return 0;
   116	}
   117	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

