Return-Path: <linux-kernel+bounces-137649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D7489E50C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF8C9B21A51
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0032158A2D;
	Tue,  9 Apr 2024 21:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brhd4jGe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE8D12F381;
	Tue,  9 Apr 2024 21:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698691; cv=none; b=ujCkn961zpVIkfLyXGnjTAhk3Lsa/REQX1SmNV0ZPWRWX3ghyIMNZn1eLWyE8Keim3x9msNrL3b52/7htWTjS4gQFduwlMcbfkocwd4ZdzXekjPLT/XdBlDKibgzuzHFrO+NK7u2TtbxikX3UvcNQvDV0btCfXrUS39hU0NRjCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698691; c=relaxed/simple;
	bh=a6dju3HKpW7sRypaPtrf7VW08Pozh7etO++KZldlSsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CugDm6ixqjxsYYFq0CVeG4XPzgX4Vv5z/op1lQSYEJVc7MYh5htpOAiBQ1NawTh0jtgAlBuXTE2xNpg9JsgYzvnwDyEs0u79ZGsuiHjrDI/gHT1mKKtpicHzWsWBUgjUqnpzWx85O0XFaioKIoIC3NaNDQN97Jv7d2z+2A8j9/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brhd4jGe; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712698688; x=1744234688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a6dju3HKpW7sRypaPtrf7VW08Pozh7etO++KZldlSsE=;
  b=brhd4jGevs+/W3lLu2ZQ3RbYy4b8N9A/qFznmZk6l+GYTfTfz2qU25i4
   GHAF1Zsuc+LnSQSdnvyZnWEYVaT4mzHN/wEC5owHAR5hBGhZ6HtBi3FTh
   N9N7QOch5wvRSlKARskQOc4FOqDoIV1eeBOD9QA52sMsHnnxN0qMYTHh2
   qrl9PXrHPUW6e41QyhPNEuutTZi7m8/Ij0lyg5GpcG8BrA0QSMSkjwavn
   gV/PMbs3Z6gM+tu9JyBFSx40g1cX2QkP5p+z6Fp47juAkBZDNBx4B6thH
   hQj1FHj1mzoaeXgepB3GJouGXZIEzqERDep4Crgb+rADazTVCZ8LUdHh3
   A==;
X-CSE-ConnectionGUID: ncJ/xF2dSgeVoENsDvWTXA==
X-CSE-MsgGUID: eZRRxjlZQze//y/4FNCtoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8214966"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8214966"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 14:38:08 -0700
X-CSE-ConnectionGUID: CyJlMzQTRf6i5sbKlZpsdA==
X-CSE-MsgGUID: oIdAYGWeRSmqTk8U+kdcTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25022748"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 09 Apr 2024 14:38:03 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruJAH-0006XK-18;
	Tue, 09 Apr 2024 21:38:01 +0000
Date: Wed, 10 Apr 2024 05:37:18 +0800
From: kernel test robot <lkp@intel.com>
To: Guanbing Huang <albanhuang0@gmail.com>, gregkh@linuxfoundation.org,
	andriy.shevchenko@intel.com, rafael.j.wysocki@intel.com
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	tony@atomide.com, john.ogness@linutronix.de,
	yangyicong@hisilicon.com, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	lvjianmin@loongson.cn, albanhuang@tencent.com,
	tombinfan@tencent.com
Subject: Re: [PATCH v6 2/3] serial: port: Add support of PNP IRQ to
 __uart_read_properties()
Message-ID: <202404100548.rbAa11Xr-lkp@intel.com>
References: <e6dc33e399f119e6430bca48223cb2127930939b.1712646750.git.albanhuang@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6dc33e399f119e6430bca48223cb2127930939b.1712646750.git.albanhuang@tencent.com>

Hi Guanbing,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.9-rc3 next-20240409]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guanbing-Huang/PNP-Add-dev_is_pnp-macro/20240409-154558
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/e6dc33e399f119e6430bca48223cb2127930939b.1712646750.git.albanhuang%40tencent.com
patch subject: [PATCH v6 2/3] serial: port: Add support of PNP IRQ to __uart_read_properties()
config: sparc-allnoconfig (https://download.01.org/0day-ci/archive/20240410/202404100548.rbAa11Xr-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240410/202404100548.rbAa11Xr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404100548.rbAa11Xr-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc-linux-ld: drivers/tty/serial/serial_port.o: in function `__uart_read_properties':
   serial_port.c:(.text+0x1c4): undefined reference to `pnp_bus_type'
>> sparc-linux-ld: serial_port.c:(.text+0x1c8): undefined reference to `pnp_bus_type'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

