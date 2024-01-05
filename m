Return-Path: <linux-kernel+bounces-17475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D83F824DCB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 05:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01152865DA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 04:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8CB538D;
	Fri,  5 Jan 2024 04:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwnOgb9J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5567D1D68C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 04:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704430393; x=1735966393;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WvidLthEWzSzfy5yF9FiZEbO1DBPFr/TInVS5SU/bSI=;
  b=YwnOgb9JJxecE1MGqh7a3O3asI0T706CJUywRpYZonBpMgarawZUzOUw
   3pPTyvmW65wLgsp/OkSXaOCOZOy8pKVC1u53H54EgBHkBMyby27OIfZy5
   GyGi4nSOEO36P18cZlUDUlHbWfthS/joNvr9vMAYA/NqXn5mpjTB/su9k
   IoWxyHgEayxfjwPC5ibv/aIfqfC6/8KE1NbRv/WvCuMStTCgbh0H95qIZ
   v9C9MngH5Y9j1uvA6hM1b+B2wSVgVWQE3xXg6ZAC/10X2WlkS+BZtxZt0
   2FkboHeI9V8b2nPtgR++AiahfIj8WK/a4rtUiQbJ12Y1pS4S9wwOjComX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="387882760"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="387882760"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 20:53:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="953840950"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="953840950"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Jan 2024 20:53:11 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLcCj-0000nQ-0Z;
	Fri, 05 Jan 2024 04:53:09 +0000
Date: Fri, 5 Jan 2024 12:52:22 +0800
From: kernel test robot <lkp@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/usb/fotg210/fotg210-udc.c:632:17: sparse: sparse: restricted
 __le16 degrades to integer
Message-ID: <202401051251.541p3ElX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1f874787ed9a2d78ed59cb21d0d90ac0178eceb0
commit: 1dd33a9f1b95ab59cd60f14a7a83fed14697867b usb: fotg210: Collect pieces of dual mode controller
date:   1 year, 2 months ago
config: microblaze-randconfig-r091-20230814 (https://download.01.org/0day-ci/archive/20240105/202401051251.541p3ElX-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240105/202401051251.541p3ElX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401051251.541p3ElX-lkp@intel.com/

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

