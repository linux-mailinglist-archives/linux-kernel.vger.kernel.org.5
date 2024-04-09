Return-Path: <linux-kernel+bounces-136421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1016B89D3E8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2329DB23CF1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FD329CE0;
	Tue,  9 Apr 2024 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XsW/77te"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690317E0F6;
	Tue,  9 Apr 2024 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650381; cv=none; b=ouXS52GJ9zNLjb2LhScDEz/MV6qzueUaiKzPqb81vmYZQEmn9EjJFtJ8DJszwt0IHo3/cA1XB9QeXIe9FCKlg4JEo7uj7J4NIiX/xKLHgxSi+IHOIn939Har7sg7WEgQz5yuy53kRN14qY2mgseojbHSMyJe6x+GgGACEuXUI8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650381; c=relaxed/simple;
	bh=jFMEUXcHKpY2CByBls3VxrCp6NDpZv4FstKTHJezeYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e75cEBLwjbOICq+iP8hfOewmC4dbyAAItKHOhoL4dGvRG0HsbXobvi/hxZoR5sl0J8YaexWqnB3pzIrRm6ToDPbet4xZZGjfmR6emVLjyP9wZKvXI+KLc9wRbuz82Zb4fp/EIlvrXQ2bJzUj02/JxvdsoilfYlgEgAN/gDfq0/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XsW/77te; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712650379; x=1744186379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jFMEUXcHKpY2CByBls3VxrCp6NDpZv4FstKTHJezeYE=;
  b=XsW/77tez4K8q8LiVjasJhUxS6Oh1+EIoW5sHLEFgngHYqEhCzY++HO2
   H8zNmZJ28iu+nC4VhOcfp4VI8Aykz92lWrW1E2FEu0LWz9a/ZRVsAE0MD
   h90UZkM2Zz+9E8rnq64kpswuGwmr8rmiL1woKwwIKxI+2czHMuPOUysDT
   5A7IOuirel0a2TktbH0j+D0ZTppbEpVrHKybkqbpkO40AP3i2A6lNM0Xf
   V/I8YBzQTfD6+8D191O/JTRaBphAFMnlfWsNEPNGKz6WRJFdC2I/Bxdjc
   WDTNesGEQ+nBWpiGtrAlNEEcLY+gTya0T+U2bbBcwiwYllY9Qyi6B1Unq
   A==;
X-CSE-ConnectionGUID: P2//5VHkTVmt6puFgadbJA==
X-CSE-MsgGUID: FrN9EnG5RVmeMceh/7CQCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="11794489"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="11794489"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 01:12:59 -0700
X-CSE-ConnectionGUID: 9hBXjKEUT462toanihZRYw==
X-CSE-MsgGUID: CBkeg03FRrWz4l8Ovm+pwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="20041447"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 09 Apr 2024 01:12:54 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ru6b6-0005sv-1j;
	Tue, 09 Apr 2024 08:12:52 +0000
Date: Tue, 9 Apr 2024 16:12:27 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] gpiolib: Fix a mess with the GPIO_* flags
Message-ID: <202404091557.rf8NTu9B-lkp@intel.com>
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
[also build test WARNING on wireless-next/main wireless/main linus/master v6.9-rc3 next-20240409]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/gpiolib-Fix-a-mess-with-the-GPIO_-flags/20240409-071911
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20240408231727.396452-2-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v2 1/2] gpiolib: Fix a mess with the GPIO_* flags
config: i386-buildonly-randconfig-002-20240409 (https://download.01.org/0day-ci/archive/20240409/202404091557.rf8NTu9B-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240409/202404091557.rf8NTu9B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404091557.rf8NTu9B-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/platform/geode/net5501.c:25:
   In file included from arch/x86/include/asm/geode.h:12:
>> include/linux/cs5535.h:149:9: warning: 'GPIO_PULL_UP' macro redefined [-Wmacro-redefined]
     149 | #define GPIO_PULL_UP            0x18
         |         ^
   include/dt-bindings/gpio/gpio.h:37:9: note: previous definition is here
      37 | #define GPIO_PULL_UP 16
         |         ^
   In file included from arch/x86/platform/geode/net5501.c:25:
   In file included from arch/x86/include/asm/geode.h:12:
>> include/linux/cs5535.h:150:9: warning: 'GPIO_PULL_DOWN' macro redefined [-Wmacro-redefined]
     150 | #define GPIO_PULL_DOWN          0x1C
         |         ^
   include/dt-bindings/gpio/gpio.h:40:9: note: previous definition is here
      40 | #define GPIO_PULL_DOWN 32
         |         ^
   2 warnings generated.


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

