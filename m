Return-Path: <linux-kernel+bounces-18660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBD88260AD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB99283678
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7543AC14E;
	Sat,  6 Jan 2024 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LETTDTeq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0F4C2D3
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704559727; x=1736095727;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x0n2sLYSHnRQR+pDy17ki+35kyrUtMrsKb3NLMRjXQs=;
  b=LETTDTeq6i3eDsCuKl1KGEB52PV352tklVUtTWboWgw8pASODrJznHvy
   7TKvyW7KPqlECJynEb3wMT4+lk4W00ppsGE2xfUV+4jtcWuvrd4j082Gs
   U5HxrKVBWpqWHib9MkvERiiZj/p3qH0BfjuxvnEWVejepKSJ1HXtJ52Ro
   emB8w7V3YzMT0/Ll7srZUXmRU9uHlB+nHp8aR3AI2Ruw9Pf5CzHj7FGtY
   AR9seqB2LrHlbv/YKh/H1FtFdLJ+NmD4FvcPbTHGjFa1QdUEKI9ToCpxV
   5PKzrNp+UIjH6548UQSu7vkDitHeq2m0cB11dbdJpekhVdgR6lSMkoTr2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="397392952"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="397392952"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 08:48:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="781022052"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="781022052"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 06 Jan 2024 08:48:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rM9ql-0002lF-1p;
	Sat, 06 Jan 2024 16:48:43 +0000
Date: Sun, 7 Jan 2024 00:48:13 +0800
From: kernel test robot <lkp@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/usb/fotg210/fotg210-udc.c:632:17: sparse: sparse: restricted
 __le16 degrades to integer
Message-ID: <202401070055.Xxcgz44O-lkp@intel.com>
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
commit: 1dd33a9f1b95ab59cd60f14a7a83fed14697867b usb: fotg210: Collect pieces of dual mode controller
date:   1 year, 2 months ago
config: microblaze-randconfig-r091-20230814 (https://download.01.org/0day-ci/archive/20240107/202401070055.Xxcgz44O-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240107/202401070055.Xxcgz44O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401070055.Xxcgz44O-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/usb/fotg210/fotg210-udc.c:632:17: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/fotg210/fotg210-udc.c:635:51: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le16 [usertype] wValue @@
   drivers/usb/fotg210/fotg210-udc.c:635:51: sparse:     expected unsigned int [usertype] addr
   drivers/usb/fotg210/fotg210-udc.c:635:51: sparse:     got restricted __le16 [usertype] wValue
   drivers/usb/fotg210/fotg210-udc.c:670:33: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/fotg210/fotg210-udc.c:680:25: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/fotg210/fotg210-udc.c:716:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] ep0_data @@     got int @@
   drivers/usb/fotg210/fotg210-udc.c:716:35: sparse:     expected restricted __le16 [usertype] ep0_data
   drivers/usb/fotg210/fotg210-udc.c:716:35: sparse:     got int
   drivers/usb/fotg210/fotg210-udc.c:722:29: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/fotg210/fotg210-udc.c:724:43: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] ep0_data @@     got int @@
   drivers/usb/fotg210/fotg210-udc.c:724:43: sparse:     expected restricted __le16 [usertype] ep0_data
   drivers/usb/fotg210/fotg210-udc.c:724:43: sparse:     got int

vim +632 drivers/usb/fotg210/fotg210-udc.c

b84a8dee23fd41 drivers/usb/gadget/fotg210-udc.c Yuan-Hsin Chen 2013-05-30  628  
b84a8dee23fd41 drivers/usb/gadget/fotg210-udc.c Yuan-Hsin Chen 2013-05-30  629  static void fotg210_set_address(struct fotg210_udc *fotg210,
b84a8dee23fd41 drivers/usb/gadget/fotg210-udc.c Yuan-Hsin Chen 2013-05-30  630  				struct usb_ctrlrequest *ctrl)
b84a8dee23fd41 drivers/usb/gadget/fotg210-udc.c Yuan-Hsin Chen 2013-05-30  631  {
b84a8dee23fd41 drivers/usb/gadget/fotg210-udc.c Yuan-Hsin Chen 2013-05-30 @632  	if (ctrl->wValue >= 0x0100) {
b84a8dee23fd41 drivers/usb/gadget/fotg210-udc.c Yuan-Hsin Chen 2013-05-30  633  		fotg210_request_error(fotg210);
b84a8dee23fd41 drivers/usb/gadget/fotg210-udc.c Yuan-Hsin Chen 2013-05-30  634  	} else {
b84a8dee23fd41 drivers/usb/gadget/fotg210-udc.c Yuan-Hsin Chen 2013-05-30  635  		fotg210_set_dev_addr(fotg210, ctrl->wValue);
b84a8dee23fd41 drivers/usb/gadget/fotg210-udc.c Yuan-Hsin Chen 2013-05-30  636  		fotg210_set_cxdone(fotg210);
b84a8dee23fd41 drivers/usb/gadget/fotg210-udc.c Yuan-Hsin Chen 2013-05-30  637  	}
b84a8dee23fd41 drivers/usb/gadget/fotg210-udc.c Yuan-Hsin Chen 2013-05-30  638  }
b84a8dee23fd41 drivers/usb/gadget/fotg210-udc.c Yuan-Hsin Chen 2013-05-30  639  

:::::: The code at line 632 was first introduced by commit
:::::: b84a8dee23fd41600a8aebcba1410b5bb5b3bdeb usb: gadget: add Faraday fotg210_udc driver

:::::: TO: Yuan-Hsin Chen <yhchen@faraday-tech.com>
:::::: CC: Felipe Balbi <balbi@ti.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

