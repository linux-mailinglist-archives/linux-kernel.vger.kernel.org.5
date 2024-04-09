Return-Path: <linux-kernel+bounces-137656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6F489E52D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86278283FCE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC6A158D69;
	Tue,  9 Apr 2024 21:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACOsyl3m"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817F3158A37;
	Tue,  9 Apr 2024 21:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699350; cv=none; b=G+H0fOr+V4U7V29PgxD5OU38gI12nK7OVhu1vo/Zz6ATZifuLmHQsaa+q7aQtnKG5vBBsp5OF1qvol8kPBbwu16XwdlG+f3nLDaK7yoRTc1NTm+1q2s7tvYlJPZZw4z8RosZ7YKSgd0siJMTTC235Wd73GedCaJqy8Ry8PTi8sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699350; c=relaxed/simple;
	bh=00rpKT2djzle4gAZgHp0Dpz1CEXsfHRG9yn9e51VYlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naPY1E/pbDgsgxLqxf+A97/M3lO6Ms5H8HagoJDgOZkm3VOT5CYv/8In5nj2+3EcNJ2f99sRlu0qZcwGq5um/6h5I83tHtyIiOVIuxUjW6u+0fgE3NDQ/LywdMJ7ZIbF5pUENifL9z7e02UJPOhx4UX9auML/o8xif25bLdTjNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACOsyl3m; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712699348; x=1744235348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=00rpKT2djzle4gAZgHp0Dpz1CEXsfHRG9yn9e51VYlM=;
  b=ACOsyl3mLdLF/a18XbzEhLI+fUzt5AjNCp2UBIgcv/k3DTCr2Crtb0uu
   PIVdzU/d62ZiEh7ym63jmP2M9USPGh8CTiTzyxoK5fQiAAkShqv4axOHj
   iOTH1hiqO8couyYCVnPhggSgbHKpZdh3vV1KIahOVPBvU4XfeTog4gk5j
   iU/sgleY3hM6OMjmvDxeQEjs+RXwwWdfvX45pXkC4a1Ekp7pE32PSKZOM
   WXHRgxEmvInSdM02mlvkf2y8+o2XGHNTB02HQJrYNVSWNZhgJ5d7w49nK
   M6G8Vxmk/3h74nuACNUZ6LAO+ruoqggIrPWD27WpRC3KN0JJrzyxEoEjl
   g==;
X-CSE-ConnectionGUID: OK7FqNUkS1WO7LsNLpwVeg==
X-CSE-MsgGUID: 2QabbWkMQgO7NCknI109eQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8208592"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8208592"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 14:49:08 -0700
X-CSE-ConnectionGUID: Zscw8kNeSOiIs1Jig6IIgg==
X-CSE-MsgGUID: pbQpTyRLQ9CtJF8GfhWEvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="51558572"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 09 Apr 2024 14:49:04 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruJKw-0006Xn-0e;
	Tue, 09 Apr 2024 21:49:02 +0000
Date: Wed, 10 Apr 2024 05:48:03 +0800
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
Message-ID: <202404100523.b06UvPSB-lkp@intel.com>
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
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240410/202404100523.b06UvPSB-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240410/202404100523.b06UvPSB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404100523.b06UvPSB-lkp@intel.com/

All errors (new ones prefixed by >>):

   or1k-linux-ld: drivers/tty/serial/serial_port.o: in function `__uart_read_properties':
>> serial_port.c:(.text+0x230): undefined reference to `pnp_bus_type'
>> or1k-linux-ld: serial_port.c:(.text+0x234): undefined reference to `pnp_bus_type'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

