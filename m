Return-Path: <linux-kernel+bounces-23588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0901A82AEB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142F51C22EEA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9548F15AEE;
	Thu, 11 Jan 2024 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFPuKTiD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE8A15ADC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704976211; x=1736512211;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=n5tknuiJOqHvGtIJ6aXYYfROsKwyLjFr33pFTiI9818=;
  b=nFPuKTiDf2ZIs0+En5uddakDuTrQQiFlegBCPVcuK7IpIZ+8TT3lTyOc
   zNwDkZIIWZvoJRgXeJ9PHwFtmcSEmetKRwtfmHQ2hI0DTAEjkMm0ChQ/b
   Nme/qwf6gLkWTIescpNOSZTANQLdKlkVcRlJF3jHoJ85MuYVtHHmIcPiT
   cPy3+pFZ7SE2wYDv0clPErkgQ05hPRFIz3SA63QC8zMRSu/lQjlmG9PN+
   scsDLUYOL+kTjnF5Gv3iULDTriL8IU4vPNYp3MkjFkfe/ki0DZUj+Tw77
   7hpm3gXPZbcz+KGPAoVoG1UniTmF+HkWhUFVVDhnvcIWAd+SxoqJAR9sR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="5911827"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="5911827"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 04:30:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="782626784"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="782626784"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 11 Jan 2024 04:30:08 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNuCD-0008G1-0C;
	Thu, 11 Jan 2024 12:30:05 +0000
Date: Thu, 11 Jan 2024 20:29:05 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Down <chris@chrisdown.name>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: include/linux/printk.h:434:44: warning: '%s' directive argument is
 null
Message-ID: <202401112002.AOjwMNM0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   de927f6c0b07d9e698416c5b287c521b07694cac
commit: 337015573718b161891a3473d25f59273f2e626b printk: Userspace format indexing support
date:   2 years, 6 months ago
config: x86_64-randconfig-002-20240105 (https://download.01.org/0day-ci/archive/20240111/202401112002.AOjwMNM0-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240111/202401112002.AOjwMNM0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401112002.AOjwMNM0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:19,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from include/linux/blkdev.h:5,
                    from drivers/scsi/scsi_devinfo.c:3:
   drivers/scsi/scsi_devinfo.c: In function 'scsi_dev_info_list_add_str':
>> include/linux/printk.h:434:44: warning: '%s' directive argument is null [-Wformat-overflow=]
     434 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                            ^
   include/linux/printk.h:430:3: note: in definition of macro 'printk_index_wrap'
     430 |   _p_func(_fmt, ##__VA_ARGS__);    \
         |   ^~~~~~~
   drivers/scsi/scsi_devinfo.c:551:4: note: in expansion of macro 'printk'
     551 |    printk(KERN_ERR "%s: bad dev info string '%s' '%s'"
         |    ^~~~~~
   drivers/scsi/scsi_devinfo.c:552:14: note: format string is defined here
     552 |           " '%s'\n", __func__, vendor, model,
         |              ^~


vim +434 include/linux/printk.h

   406	
   407	/*
   408	 * Some subsystems have their own custom printk that applies a va_format to a
   409	 * generic format, for example, to include a device number or other metadata
   410	 * alongside the format supplied by the caller.
   411	 *
   412	 * In order to store these in the way they would be emitted by the printk
   413	 * infrastructure, the subsystem provides us with the start, fixed string, and
   414	 * any subsequent text in the format string.
   415	 *
   416	 * We take a variable argument list as pr_fmt/dev_fmt/etc are sometimes passed
   417	 * as multiple arguments (eg: `"%s: ", "blah"`), and we must only take the
   418	 * first one.
   419	 *
   420	 * subsys_fmt_prefix must be known at compile time, or compilation will fail
   421	 * (since this is a mistake). If fmt or level is not known at compile time, no
   422	 * index entry will be made (since this can legitimately happen).
   423	 */
   424	#define printk_index_subsys_emit(subsys_fmt_prefix, level, fmt, ...) \
   425		__printk_index_emit(fmt, level, subsys_fmt_prefix)
   426	
   427	#define printk_index_wrap(_p_func, _fmt, ...)				\
   428		({								\
   429			__printk_index_emit(_fmt, NULL, NULL);			\
   430			_p_func(_fmt, ##__VA_ARGS__);				\
   431		})
   432	
   433	
 > 434	#define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
   435	#define printk_deferred(fmt, ...)					\
   436		printk_index_wrap(_printk_deferred, fmt, ##__VA_ARGS__)
   437	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

