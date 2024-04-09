Return-Path: <linux-kernel+bounces-136233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4CE89D18F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594061C22420
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063E7524AF;
	Tue,  9 Apr 2024 04:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oAMAo2iP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1E0EAE5;
	Tue,  9 Apr 2024 04:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712637526; cv=none; b=exSP/hzglhIWIIY4kX0lqAOTXA5XO89qUc++QpKLgqEcBaItqm7kCaBr7VdicigmKlVJ6GKiKzOfeYfCF9IwfzdVhR05cwTnWKvC4T1a8UyX4v0izOyBcAL83DbIZAK+HByXZ+j0tkOs4HfpmpBFPodcUnCKBVEJCc9Xq434jB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712637526; c=relaxed/simple;
	bh=FwDRjCBN71NNWbuqJwe1vhuFGM+457CREEz1uKWOfUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etgjGytc7APIXUYkdHwcLPN2N6ZVRcjRuF8CCfg+qyHo4oRGCczuZdEnic71F8Y+Lf7uC4L5y8par6GT0JKbzsq0tA2Vrtxd+gnsJofQaiEY0oPVf53kYnfMzb8vfOhYXP8cifP2oeGoccnakH9w5YM3qxzoz5/vC/EKqRHFWAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oAMAo2iP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712637524; x=1744173524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FwDRjCBN71NNWbuqJwe1vhuFGM+457CREEz1uKWOfUI=;
  b=oAMAo2iPP3fui8EI/E5HMMr5k0Xf2FGzQk6JjabSMxQuaalq8AYxM24p
   z7w4t0bubp5QC7co71gKnTKnA7IPQ2gBOmJo6vUp3UkfJ/50pnSOfcYyU
   Y5y+3ew7vzyzVhFS06TzuZ55/V1ha0GqSrfkiH5V6i4aJ7QJFeX2Buevf
   pQrcnfA7G4KDgpFDCHEHVkN11hFZXqFlqX9ubSlK38FCWZaEhT88qJFQL
   jFO1XMIsiPeEaGOvIZdWV1jzxHVeThA/GNHSFPf8AkUF7FnBWVo/UrZyE
   KsHILzX2/8PpL1xog+NPFA0BWrwAKb26mau/07+HWGpPUX6Ptc32YVVo7
   w==;
X-CSE-ConnectionGUID: ff0V6GGwTha4WV7QqYbc9A==
X-CSE-MsgGUID: 4ocxdPmdS8+Q5WFitXeBYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="25440832"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="25440832"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 21:38:44 -0700
X-CSE-ConnectionGUID: e33hYWNgRzu9vk7HTBhA9w==
X-CSE-MsgGUID: n4YA2P8CTm+jg8h8Evwn1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="20017073"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Apr 2024 21:38:40 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ru3Fm-0005jy-0R;
	Tue, 09 Apr 2024 04:38:38 +0000
Date: Tue, 9 Apr 2024 12:38:35 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
Cc: oe-kbuild-all@lists.linux.dev,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] gpiolib: Fix a mess with the GPIO_* flags
Message-ID: <202404091205.rnu1DOaq-lkp@intel.com>
References: <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brgl/gpio/for-next]
[also build test WARNING on wireless-next/main wireless/main linus/master v6.9-rc3 next-20240408]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/gpiolib-Fix-a-mess-with-the-GPIO_-flags/20240409-071911
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20240408231727.396452-2-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v2 1/2] gpiolib: Fix a mess with the GPIO_* flags
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240409/202404091205.rnu1DOaq-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240409/202404091205.rnu1DOaq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404091205.rnu1DOaq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/geode.h:12,
                    from arch/x86/platform/geode/alix.c:28:
>> include/linux/cs5535.h:149: warning: "GPIO_PULL_UP" redefined
     149 | #define GPIO_PULL_UP            0x18
         | 
   In file included from include/linux/gpio/machine.h:5,
                    from arch/x86/platform/geode/alix.c:25:
   include/dt-bindings/gpio/gpio.h:37: note: this is the location of the previous definition
      37 | #define GPIO_PULL_UP 16
         | 
>> include/linux/cs5535.h:150: warning: "GPIO_PULL_DOWN" redefined
     150 | #define GPIO_PULL_DOWN          0x1C
         | 
   include/dt-bindings/gpio/gpio.h:40: note: this is the location of the previous definition
      40 | #define GPIO_PULL_DOWN 32
         | 


vim +/GPIO_PULL_UP +149 include/linux/cs5535.h

f060f27007b393 Andres Salomon 2009-12-14  141  
5f0a96b044d8ed Andres Salomon 2009-12-14  142  /* GPIOs */
5f0a96b044d8ed Andres Salomon 2009-12-14  143  #define GPIO_OUTPUT_VAL		0x00
5f0a96b044d8ed Andres Salomon 2009-12-14  144  #define GPIO_OUTPUT_ENABLE	0x04
5f0a96b044d8ed Andres Salomon 2009-12-14  145  #define GPIO_OUTPUT_OPEN_DRAIN	0x08
5f0a96b044d8ed Andres Salomon 2009-12-14  146  #define GPIO_OUTPUT_INVERT	0x0C
5f0a96b044d8ed Andres Salomon 2009-12-14  147  #define GPIO_OUTPUT_AUX1	0x10
5f0a96b044d8ed Andres Salomon 2009-12-14  148  #define GPIO_OUTPUT_AUX2	0x14
5f0a96b044d8ed Andres Salomon 2009-12-14 @149  #define GPIO_PULL_UP		0x18
5f0a96b044d8ed Andres Salomon 2009-12-14 @150  #define GPIO_PULL_DOWN		0x1C
5f0a96b044d8ed Andres Salomon 2009-12-14  151  #define GPIO_INPUT_ENABLE	0x20
5f0a96b044d8ed Andres Salomon 2009-12-14  152  #define GPIO_INPUT_INVERT	0x24
5f0a96b044d8ed Andres Salomon 2009-12-14  153  #define GPIO_INPUT_FILTER	0x28
5f0a96b044d8ed Andres Salomon 2009-12-14  154  #define GPIO_INPUT_EVENT_COUNT	0x2C
5f0a96b044d8ed Andres Salomon 2009-12-14  155  #define GPIO_READ_BACK		0x30
5f0a96b044d8ed Andres Salomon 2009-12-14  156  #define GPIO_INPUT_AUX1		0x34
5f0a96b044d8ed Andres Salomon 2009-12-14  157  #define GPIO_EVENTS_ENABLE	0x38
5f0a96b044d8ed Andres Salomon 2009-12-14  158  #define GPIO_LOCK_ENABLE	0x3C
5f0a96b044d8ed Andres Salomon 2009-12-14  159  #define GPIO_POSITIVE_EDGE_EN	0x40
5f0a96b044d8ed Andres Salomon 2009-12-14  160  #define GPIO_NEGATIVE_EDGE_EN	0x44
5f0a96b044d8ed Andres Salomon 2009-12-14  161  #define GPIO_POSITIVE_EDGE_STS	0x48
5f0a96b044d8ed Andres Salomon 2009-12-14  162  #define GPIO_NEGATIVE_EDGE_STS	0x4C
5f0a96b044d8ed Andres Salomon 2009-12-14  163  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

