Return-Path: <linux-kernel+bounces-144532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA578A477C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A67B21C52
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECA24C9A;
	Mon, 15 Apr 2024 05:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+94Oxqe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E347E23CE;
	Mon, 15 Apr 2024 05:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713157860; cv=none; b=Ywc1nfRl6f3Zgcp6zRh8/0T/RnlGoJqfk8r+D24ArKrqRLg8CKcVr4CHbd6aanbjub/hx1AWKBjgofRZzuY4BPLJwaX+0l7aC/y+3GX0rD32sT5TPRQ95CDTXj+aa/G+Hg+rpYT0z1maoMo6fCQFX39aoUaD66z42jcbZTeeWkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713157860; c=relaxed/simple;
	bh=xnNTKg9O11qs5df9fpMkowc+911rIlXEZvhJWTm47AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NG1OmNxR2W+nOE5u+AkT4PGCLIg10EzBAI9LjHNw6mJRg1d6iuzrgQMfNivyegwdUjdzrj31vRTsGf3ThF3l8doWtH5oUx2psKgmibqKwAz+WStx0njROn9/6hCyV06X4Tmct76x1w4ErFI9W0Cv7icZI6eg98XVfceYwrYJErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+94Oxqe; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713157858; x=1744693858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xnNTKg9O11qs5df9fpMkowc+911rIlXEZvhJWTm47AQ=;
  b=j+94OxqeueUikh5ZfYvYDZvcQU5W60W7yCCFIRSp57d9tkwsHZ7fuhne
   JDp3x05xe/wXXbwQhA9BmkzVA8bVKbwgpEuEjiUqNH7P84ffHCsjvqGUL
   XhS9FkSyIso5qFp+tqle6Yuh8hHk89iH9bXa4gOOj9JiT3Hgto/KjuZBO
   jrrG8/hOQ9+cNmv/3AzmZDMXY0LKK1Cnq465k9T12GZqdyyYzZkPjecr1
   ym/HHPNnJyQT/Zj5p0h7EQU7AS9oIkoy92cE4yplcyOz8kqLILLrYYyOI
   2Gye9GominP2h7HZavK8AMPLOcLCXSgq7flkii66E5mflv2+wTJQwEVGt
   g==;
X-CSE-ConnectionGUID: Wwq1VUPlRrqNeYtK9tWhyQ==
X-CSE-MsgGUID: NS1BWakiTBi9M2cf75yjCg==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8387002"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8387002"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 22:10:57 -0700
X-CSE-ConnectionGUID: i3cKZkLqRfKTmdq4Yi9KYg==
X-CSE-MsgGUID: +8G4SjyNQU6aRv9yWPpwKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="59240318"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 14 Apr 2024 22:10:55 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwEcG-0003z8-0X;
	Mon, 15 Apr 2024 05:10:52 +0000
Date: Mon, 15 Apr 2024 13:10:21 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 1/2] mmc: sdhci-acpi: Switch to
 SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
Message-ID: <202404151250.mJXR8RpZ-lkp@intel.com>
References: <20240412184706.366879-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412184706.366879-3-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.9-rc4 next-20240412]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/mmc-sdhci-acpi-Switch-to-SYSTEM_SLEEP_PM_OPS-RUNTIME_PM_OPS-and-pm_ptr/20240415-093843
base:   linus/master
patch link:    https://lore.kernel.org/r/20240412184706.366879-3-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/2] mmc: sdhci-acpi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
config: i386-randconfig-002-20240415 (https://download.01.org/0day-ci/archive/20240415/202404151250.mJXR8RpZ-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240415/202404151250.mJXR8RpZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404151250.mJXR8RpZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mmc/host/sdhci-acpi.c:969:8: error: call to undeclared function 'sdhci_suspend_host'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     969 |         ret = sdhci_suspend_host(host);
         |               ^
>> drivers/mmc/host/sdhci-acpi.c:983:9: error: call to undeclared function 'sdhci_resume_host'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     983 |         return sdhci_resume_host(c->host);
         |                ^
   drivers/mmc/host/sdhci-acpi.c:983:9: note: did you mean 'sdhci_remove_host'?
   drivers/mmc/host/sdhci.h:771:6: note: 'sdhci_remove_host' declared here
     771 | void sdhci_remove_host(struct sdhci_host *host, int dead);
         |      ^
>> drivers/mmc/host/sdhci-acpi.c:995:8: error: call to undeclared function 'sdhci_runtime_suspend_host'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     995 |         ret = sdhci_runtime_suspend_host(host);
         |               ^
>> drivers/mmc/host/sdhci-acpi.c:1009:9: error: call to undeclared function 'sdhci_runtime_resume_host'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1009 |         return sdhci_runtime_resume_host(c->host, 0);
         |                ^
   4 errors generated.


vim +/sdhci_suspend_host +969 drivers/mmc/host/sdhci-acpi.c

84d49b3d08a1d3 Hans de Goede 2020-03-16   959  
c4e050376c69bb Adrian Hunter 2012-11-23   960  static int sdhci_acpi_suspend(struct device *dev)
c4e050376c69bb Adrian Hunter 2012-11-23   961  {
c4e050376c69bb Adrian Hunter 2012-11-23   962  	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
d38dcad4e7b48f Adrian Hunter 2017-03-20   963  	struct sdhci_host *host = c->host;
84d49b3d08a1d3 Hans de Goede 2020-03-16   964  	int ret;
c4e050376c69bb Adrian Hunter 2012-11-23   965  
d38dcad4e7b48f Adrian Hunter 2017-03-20   966  	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
d38dcad4e7b48f Adrian Hunter 2017-03-20   967  		mmc_retune_needed(host->mmc);
d38dcad4e7b48f Adrian Hunter 2017-03-20   968  
84d49b3d08a1d3 Hans de Goede 2020-03-16  @969  	ret = sdhci_suspend_host(host);
84d49b3d08a1d3 Hans de Goede 2020-03-16   970  	if (ret)
84d49b3d08a1d3 Hans de Goede 2020-03-16   971  		return ret;
84d49b3d08a1d3 Hans de Goede 2020-03-16   972  
84d49b3d08a1d3 Hans de Goede 2020-03-16   973  	sdhci_acpi_reset_signal_voltage_if_needed(dev);
84d49b3d08a1d3 Hans de Goede 2020-03-16   974  	return 0;
c4e050376c69bb Adrian Hunter 2012-11-23   975  }
c4e050376c69bb Adrian Hunter 2012-11-23   976  
c4e050376c69bb Adrian Hunter 2012-11-23   977  static int sdhci_acpi_resume(struct device *dev)
c4e050376c69bb Adrian Hunter 2012-11-23   978  {
c4e050376c69bb Adrian Hunter 2012-11-23   979  	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
c4e050376c69bb Adrian Hunter 2012-11-23   980  
6e1c7d6103fe70 Adrian Hunter 2016-04-15   981  	sdhci_acpi_byt_setting(&c->pdev->dev);
6e1c7d6103fe70 Adrian Hunter 2016-04-15   982  
c4e050376c69bb Adrian Hunter 2012-11-23  @983  	return sdhci_resume_host(c->host);
c4e050376c69bb Adrian Hunter 2012-11-23   984  }
c4e050376c69bb Adrian Hunter 2012-11-23   985  
c4e050376c69bb Adrian Hunter 2012-11-23   986  static int sdhci_acpi_runtime_suspend(struct device *dev)
c4e050376c69bb Adrian Hunter 2012-11-23   987  {
c4e050376c69bb Adrian Hunter 2012-11-23   988  	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
d38dcad4e7b48f Adrian Hunter 2017-03-20   989  	struct sdhci_host *host = c->host;
84d49b3d08a1d3 Hans de Goede 2020-03-16   990  	int ret;
d38dcad4e7b48f Adrian Hunter 2017-03-20   991  
d38dcad4e7b48f Adrian Hunter 2017-03-20   992  	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
d38dcad4e7b48f Adrian Hunter 2017-03-20   993  		mmc_retune_needed(host->mmc);
c4e050376c69bb Adrian Hunter 2012-11-23   994  
84d49b3d08a1d3 Hans de Goede 2020-03-16  @995  	ret = sdhci_runtime_suspend_host(host);
84d49b3d08a1d3 Hans de Goede 2020-03-16   996  	if (ret)
84d49b3d08a1d3 Hans de Goede 2020-03-16   997  		return ret;
84d49b3d08a1d3 Hans de Goede 2020-03-16   998  
84d49b3d08a1d3 Hans de Goede 2020-03-16   999  	sdhci_acpi_reset_signal_voltage_if_needed(dev);
84d49b3d08a1d3 Hans de Goede 2020-03-16  1000  	return 0;
c4e050376c69bb Adrian Hunter 2012-11-23  1001  }
c4e050376c69bb Adrian Hunter 2012-11-23  1002  
c4e050376c69bb Adrian Hunter 2012-11-23  1003  static int sdhci_acpi_runtime_resume(struct device *dev)
c4e050376c69bb Adrian Hunter 2012-11-23  1004  {
c4e050376c69bb Adrian Hunter 2012-11-23  1005  	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
c4e050376c69bb Adrian Hunter 2012-11-23  1006  
6e1c7d6103fe70 Adrian Hunter 2016-04-15  1007  	sdhci_acpi_byt_setting(&c->pdev->dev);
6e1c7d6103fe70 Adrian Hunter 2016-04-15  1008  
c6303c5d52d5ec Baolin Wang   2019-07-25 @1009  	return sdhci_runtime_resume_host(c->host, 0);
c4e050376c69bb Adrian Hunter 2012-11-23  1010  }
c4e050376c69bb Adrian Hunter 2012-11-23  1011  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

