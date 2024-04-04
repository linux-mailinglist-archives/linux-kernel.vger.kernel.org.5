Return-Path: <linux-kernel+bounces-132001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618A8898E73
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D7B28C651
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4884C13246F;
	Thu,  4 Apr 2024 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O6oBCk36"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37891131E41
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257210; cv=none; b=E/ZorVbNKQju/cy/h7c1H4igpzbMuQtzDlNuIdRwFV9rPpTtwBpJYC0WXLGdoYDaNV8/FQE+I5wEChsMRuJCK7g1iL2KUd1U2iIcHJcBMi3EZI+z4MxCAiMLipiQd9OcvKLiIcDGRXfZ2NMova8Ijcxbh8Y/JvRk831w/hOSWwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257210; c=relaxed/simple;
	bh=nbFOZtSS2b2wW9MV880qLgighuz6pCR04uAatLsOP20=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B5bWnLzOKbE18wSBgpRORfRlrD1ZuELXzhihtaL8EzpnXl0Qi3I9j+u6C4d2pYGQMXqfj4cFgSOog73yCDMLni5Pf5C/qDq56bybrLERqj7GNlN9IUhsOeY6atewr312KDCAlZn8mDqfc1YMJK7DAebNVwXGV1RA9v7HB0poiA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O6oBCk36; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712257208; x=1743793208;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nbFOZtSS2b2wW9MV880qLgighuz6pCR04uAatLsOP20=;
  b=O6oBCk36dgk5b7dKYI6anaNP+l/9bHlwNhht2PmMauCX9qw+nyHXtgZq
   14W2HAG3BrD9+V1dIT0rOACbmbwo4s2Xn7ZIT8/KH/KNaUdVNVxNXXFgq
   dOmqUGU4gCABpMKHZ54ZirWP6lTqN5g/zQW2mQ3ga3U6mInOUwwCDi6mM
   KYpc5ViR6D81oFLltZJ/23l9mdrq6sT/Xr77Zm9x+XOiladNNpcygRcLW
   RpuXvjLEFSrWjI3INYcxkhcQ9jdxxoK7leolVgD3qE6z+UFNOTIFUL4MZ
   CA1Ttd0EqZp/+1ogPQQOMc97UiK8YJINO13838EwUG420/oZ/W99wQVY3
   A==;
X-CSE-ConnectionGUID: W+A72nmvStSFwNErcAgB2A==
X-CSE-MsgGUID: 3FreT7KYTIq+eS8dr8FoqQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18300902"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18300902"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 12:00:07 -0700
X-CSE-ConnectionGUID: e+Gd2EGdQ+a8ZM27DWAM4Q==
X-CSE-MsgGUID: ho7c7qqtTeyWMURhxe+0Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18857102"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 04 Apr 2024 12:00:06 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsSJf-0001OK-11;
	Thu, 04 Apr 2024 19:00:03 +0000
Date: Fri, 5 Apr 2024 02:59:44 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: drivers/usb/gadget/udc/fsl_udc_core.c:878:13: warning: variable
 'udc' is uninitialized when used here
Message-ID: <202404050227.TTvcCPBu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c85af715cac0a951eea97393378e84bb49384734
commit: 6025f20f16c25d262680f6e1040d4bcdc0ecd0f3 usb: gadget: fsl-udc: Replace custom log wrappers by dev_{err,warn,dbg,vdbg}
date:   4 weeks ago
config: powerpc-randconfig-002-20240405 (https://download.01.org/0day-ci/archive/20240405/202404050227.TTvcCPBu-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240405/202404050227.TTvcCPBu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404050227.TTvcCPBu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/gadget/udc/fsl_udc_core.c:878:13: warning: variable 'udc' is uninitialized when used here [-Wuninitialized]
                   dev_vdbg(&udc->gadget.dev, "%s, bad params\n", __func__);
                             ^~~
   include/linux/dev_printk.h:257:18: note: expanded from macro 'dev_vdbg'
   #define dev_vdbg        dev_dbg
                           ^
   include/linux/dev_printk.h:155:18: note: expanded from macro 'dev_dbg'
           dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
                           ^~~
   include/linux/dynamic_debug.h:274:7: note: expanded from macro 'dynamic_dev_dbg'
                              dev, fmt, ##__VA_ARGS__)
                              ^~~
   include/linux/dynamic_debug.h:250:59: note: expanded from macro '_dynamic_func_call'
           _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
                                                                    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:248:65: note: expanded from macro '_dynamic_func_call_cls'
           __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
                                                                          ^~~~~~~~~~~
   include/linux/dynamic_debug.h:224:15: note: expanded from macro '__dynamic_func_call_cls'
                   func(&id, ##__VA_ARGS__);                       \
                               ^~~~~~~~~~~
   drivers/usb/gadget/udc/fsl_udc_core.c:871:21: note: initialize the variable 'udc' to silence this warning
           struct fsl_udc *udc;
                              ^
                               = NULL
   1 warning generated.


vim +/udc +878 drivers/usb/gadget/udc/fsl_udc_core.c

   864	
   865	/* queues (submits) an I/O request to an endpoint */
   866	static int
   867	fsl_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
   868	{
   869		struct fsl_ep *ep = container_of(_ep, struct fsl_ep, ep);
   870		struct fsl_req *req = container_of(_req, struct fsl_req, req);
   871		struct fsl_udc *udc;
   872		unsigned long flags;
   873		int ret;
   874	
   875		/* catch various bogus parameters */
   876		if (!_req || !req->req.complete || !req->req.buf
   877				|| !list_empty(&req->queue)) {
 > 878			dev_vdbg(&udc->gadget.dev, "%s, bad params\n", __func__);
   879			return -EINVAL;
   880		}
   881		if (unlikely(!_ep || !ep->ep.desc)) {
   882			dev_vdbg(&udc->gadget.dev, "%s, bad ep\n", __func__);
   883			return -EINVAL;
   884		}
   885		if (usb_endpoint_xfer_isoc(ep->ep.desc)) {
   886			if (req->req.length > ep->ep.maxpacket)
   887				return -EMSGSIZE;
   888		}
   889	
   890		udc = ep->udc;
   891		if (!udc->driver || udc->gadget.speed == USB_SPEED_UNKNOWN)
   892			return -ESHUTDOWN;
   893	
   894		req->ep = ep;
   895	
   896		ret = usb_gadget_map_request(&ep->udc->gadget, &req->req, ep_is_in(ep));
   897		if (ret)
   898			return ret;
   899	
   900		req->req.status = -EINPROGRESS;
   901		req->req.actual = 0;
   902		req->dtd_count = 0;
   903	
   904		/* build dtds and push them to device queue */
   905		if (!fsl_req_to_dtd(req, gfp_flags)) {
   906			spin_lock_irqsave(&udc->lock, flags);
   907			fsl_queue_td(ep, req);
   908		} else {
   909			return -ENOMEM;
   910		}
   911	
   912		/* irq handler advances the queue */
   913		if (req != NULL)
   914			list_add_tail(&req->queue, &ep->queue);
   915		spin_unlock_irqrestore(&udc->lock, flags);
   916	
   917		return 0;
   918	}
   919	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

