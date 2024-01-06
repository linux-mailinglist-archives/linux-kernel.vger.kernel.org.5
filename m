Return-Path: <linux-kernel+bounces-18718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64DE8261B1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 22:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B9A2830C0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 21:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9D7101CD;
	Sat,  6 Jan 2024 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hoQ2+bNb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EB3101C6
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704576207; x=1736112207;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IYox++9NPxL9ZZQ0SaHmzRmKVlaZ8r8CyO0y8u2ghD0=;
  b=hoQ2+bNbq5nNqdyRA7zgFzO0dOSInU3/qYp8O9ju3p4llyDcfG3h39Ot
   MZ4vfx+LWHxF/wDR1/0lUhu0Wq3AzjXgKSnYY5fIvU5cXWoVRSZAcp3w6
   WSUp4Z1L/mtHf3770Wbu6ckKn4F43PtgoF78BUvCPJJJSXQh8pIcFsQnd
   VDoCZwXEe8f1QYf0GmkAL7sfp7bl3b9VP2SWogtvb/BpercRIjv8c5XHa
   gFmn6uzO79TUnmk0a0VUwuiRWbscAQJLCUkXFY3BjNg3wIxcW4D3yeJyu
   /RCHEfDcOS97JKr5I7d677Q5tAXeqpUNDipISlcuzsCCHVbbP062+WjVd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="19188515"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="19188515"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 13:23:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="924511284"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="924511284"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jan 2024 13:23:25 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rME8Z-00031y-04;
	Sat, 06 Jan 2024 21:23:23 +0000
Date: Sun, 7 Jan 2024 05:22:37 +0800
From: kernel test robot <lkp@intel.com>
To: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/misc/dw-xdata-pcie.c:20:41: warning: 'snprintf' output may
 be truncated before the last format character
Message-ID: <202401070541.9jGvpTOU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   95c8a35f1c017327eab3b6a2ff5c04255737c856
commit: e8a30eef6ef6da4998fcdaaffaaf8d29777c5d7d misc: Add Synopsys DesignWare xData IP driver
date:   2 years, 9 months ago
config: x86_64-randconfig-001-20240105 (https://download.01.org/0day-ci/archive/20240107/202401070541.9jGvpTOU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401070541.9jGvpTOU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401070541.9jGvpTOU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/misc/dw-xdata-pcie.c: In function 'dw_xdata_pcie_probe':
>> drivers/misc/dw-xdata-pcie.c:20:41: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
      20 | #define DW_XDATA_DRIVER_NAME            "dw-xdata-pcie"
         |                                         ^~~~~~~~~~~~~~~
   drivers/misc/dw-xdata-pcie.c:342:38: note: in expansion of macro 'DW_XDATA_DRIVER_NAME'
     342 |         snprintf(name, sizeof(name), DW_XDATA_DRIVER_NAME ".%d", id);
         |                                      ^~~~~~~~~~~~~~~~~~~~
   drivers/misc/dw-xdata-pcie.c:390:64: note: format string is defined here
     390 |         if (sscanf(dw->misc_dev.name, DW_XDATA_DRIVER_NAME ".%d", &id) != 1)
         |                                                                ^
   drivers/misc/dw-xdata-pcie.c:342:9: note: 'snprintf' output between 16 and 25 bytes into a destination of size 24
     342 |         snprintf(name, sizeof(name), DW_XDATA_DRIVER_NAME ".%d", id);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/snprintf +20 drivers/misc/dw-xdata-pcie.c

    19	
  > 20	#define DW_XDATA_DRIVER_NAME		"dw-xdata-pcie"
    21	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

