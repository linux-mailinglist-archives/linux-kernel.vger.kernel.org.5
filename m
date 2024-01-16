Return-Path: <linux-kernel+bounces-27323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 375F282EDCC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03E1284023
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01AC1B97C;
	Tue, 16 Jan 2024 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWw0KRFu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796081B942;
	Tue, 16 Jan 2024 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705404907; x=1736940907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZY/fiyQnA9sc5ZnYUaIZivwe3nv7/wn4Lxg4uGWvHfU=;
  b=TWw0KRFu+WMvWRgl/VkUPxaBuM3n+T9T43i1ZXXNT091UpEVBykw8/TF
   EHrW8i/DzwquSAuVnagoERFfSdkhT5S9T46vOXwb5XzzMHkLCHdivXTUL
   oVZcfYUK/qzqH6LyaHn8HoUaadzsEu2JfcuUCl1ZYEHb1zW5M5CpAfUNw
   Ms77InTq5lllmK6mxAnk4prIeh4VHB1FI2b/GIiyb3efwtAocdQ+sy/wk
   9Vsna37twwAGYy3hpWUTcMjoirH6nRGjlbHSWLHhYGuwRxZLikmKb1/8W
   WT15GhkJ1KzvYCL/kpFO7ejRBF9/ABhRgPIaUdiwSN4AAcbWaAyOUqXBb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="7204364"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="7204364"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 03:35:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="1115259479"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="1115259479"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jan 2024 03:35:02 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPhif-0000dC-0X;
	Tue, 16 Jan 2024 11:35:01 +0000
Date: Tue, 16 Jan 2024 19:34:06 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	v9fs@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	kernel@pengutronix.de,
	Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: Re: [PATCH 1/3] usb: gadget: function: 9pfs
Message-ID: <202401161937.9wbYLZdb-lkp@intel.com>
References: <20240116-ml-topic-u9p-v1-1-ad8c306f9a4e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116-ml-topic-u9p-v1-1-ad8c306f9a4e@pengutronix.de>

Hi Michael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 052d534373b7ed33712a63d5e17b2b6cdbce84fd]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Grzeschik/usb-gadget-function-9pfs/20240116-095914
base:   052d534373b7ed33712a63d5e17b2b6cdbce84fd
patch link:    https://lore.kernel.org/r/20240116-ml-topic-u9p-v1-1-ad8c306f9a4e%40pengutronix.de
patch subject: [PATCH 1/3] usb: gadget: function: 9pfs
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20240116/202401161937.9wbYLZdb-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 9bde5becb44ea071f5e1fa1f5d4071dc8788b18c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240116/202401161937.9wbYLZdb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401161937.9wbYLZdb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/gadget/function/f_9pfs.c:197:4: warning: format specifies type 'unsigned int' but the argument has type 'size_t' (aka 'unsigned long') [-Wformat]
     196 |         p9_debug(P9_DEBUG_TRANS, "mux %p got %u bytes\n", usb9pfs,
         |                                              ~~
         |                                              %zu
     197 |                  rc.capacity - rc.offset);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/net/9p/9p.h:55:36: note: expanded from macro 'p9_debug'
      55 |         _p9_debug(level, __func__, fmt, ##__VA_ARGS__)
         |                                    ~~~    ^~~~~~~~~~~
>> drivers/usb/gadget/function/f_9pfs.c:286:6: warning: no previous prototype for function 'disable_endpoints' [-Wmissing-prototypes]
     286 | void disable_endpoints(struct usb_composite_dev *cdev,
         |      ^
   drivers/usb/gadget/function/f_9pfs.c:286:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     286 | void disable_endpoints(struct usb_composite_dev *cdev,
         | ^
         | static 
>> drivers/usb/gadget/function/f_9pfs.c:825:12: warning: no previous prototype for function 'usb9pfs_modinit' [-Wmissing-prototypes]
     825 | int __init usb9pfs_modinit(void)
         |            ^
   drivers/usb/gadget/function/f_9pfs.c:825:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     825 | int __init usb9pfs_modinit(void)
         | ^
         | static 
>> drivers/usb/gadget/function/f_9pfs.c:838:13: warning: no previous prototype for function 'usb9pfs_modexit' [-Wmissing-prototypes]
     838 | void __exit usb9pfs_modexit(void)
         |             ^
   drivers/usb/gadget/function/f_9pfs.c:838:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     838 | void __exit usb9pfs_modexit(void)
         | ^
         | static 
   4 warnings generated.


vim +197 drivers/usb/gadget/function/f_9pfs.c

   184	
   185	static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, struct usb_request *req)
   186	{
   187		struct p9_req_t *p9_rx_req;
   188		struct p9_fcall	rc;
   189		int ret;
   190	
   191		/* start by reading header */
   192		rc.sdata = req->buf;
   193		rc.offset = 0;
   194		rc.capacity = rc.size = P9_HDRSZ;
   195	
   196		p9_debug(P9_DEBUG_TRANS, "mux %p got %u bytes\n", usb9pfs,
 > 197			 rc.capacity - rc.offset);
   198	
   199		ret = p9_parse_header(&rc, &rc.size, NULL, NULL, 0);
   200		if (ret) {
   201			p9_debug(P9_DEBUG_ERROR,
   202				 "error parsing header: %d\n", ret);
   203			return NULL;
   204		}
   205	
   206		p9_debug(P9_DEBUG_TRANS,
   207			 "mux %p pkt: size: %d bytes tag: %d\n",
   208			 usb9pfs, rc.size, rc.tag);
   209	
   210		p9_rx_req = p9_tag_lookup(usb9pfs->client, rc.tag);
   211		if (!p9_rx_req || (p9_rx_req->status != REQ_STATUS_SENT)) {
   212			p9_debug(P9_DEBUG_ERROR, "Unexpected packet tag %d\n", rc.tag);
   213			return NULL;
   214		}
   215	
   216		if (rc.size > p9_rx_req->rc.capacity) {
   217			p9_debug(P9_DEBUG_ERROR,
   218				 "requested packet size too big: %d for tag %d with capacity %zd\n",
   219				 rc.size, rc.tag, p9_rx_req->rc.capacity);
   220			return NULL;
   221		}
   222	
   223		if (!p9_rx_req->rc.sdata) {
   224			p9_debug(P9_DEBUG_ERROR,
   225				 "No recv fcall for tag %d (req %p), disconnecting!\n",
   226				 rc.tag, p9_rx_req);
   227			p9_req_put(usb9pfs->client, p9_rx_req);
   228			return NULL;
   229		}
   230	
   231		return p9_rx_req;
   232	}
   233	
   234	static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
   235	{
   236		struct f_usb9pfs *usb9pfs = ep->driver_data;
   237		struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
   238		struct p9_req_t *p9_rx_req;
   239		unsigned long flags;
   240	
   241		switch (req->status) {
   242		case 0:				/* normal completion? */
   243			spin_lock_irqsave(&usb9pfs->req_lock, flags);
   244			p9_rx_req = usb9pfs_rx_header(usb9pfs, req);
   245			if (!p9_rx_req) {
   246				spin_unlock_irqrestore(&usb9pfs->req_lock, flags);
   247				goto free_req;
   248			}
   249	
   250			memcpy(p9_rx_req->rc.sdata, req->buf, req->actual);
   251			p9_rx_req->rc.size = req->actual;
   252	
   253			p9_client_cb(usb9pfs->client, p9_rx_req, REQ_STATUS_RCVD);
   254			p9_req_put(usb9pfs->client, p9_rx_req);
   255	
   256			usb9pfs->p9_tx_req = NULL;
   257	
   258			usb9pfs_transmit(usb9pfs);
   259	
   260			spin_unlock_irqrestore(&usb9pfs->req_lock, flags);
   261	
   262			return;
   263	free_req:
   264		default:
   265			dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
   266				ep->name, req->status, req->actual, req->length);
   267			usb_ep_free_request(ep == usb9pfs->in_ep ?
   268					    usb9pfs->out_ep : usb9pfs->in_ep,
   269					    req->context);
   270			free_ep_req(ep, req);
   271			return;
   272		}
   273	
   274		p9_client_cb(usb9pfs->client, p9_rx_req, REQ_STATUS_ERROR);
   275	}
   276	
   277	static void disable_ep(struct usb_composite_dev *cdev, struct usb_ep *ep)
   278	{
   279		int value;
   280	
   281		value = usb_ep_disable(ep);
   282		if (value < 0)
   283			dev_info(&cdev->gadget->dev, "disable %s --> %d\n", ep->name, value);
   284	}
   285	
 > 286	void disable_endpoints(struct usb_composite_dev *cdev,
   287			struct usb_ep *in, struct usb_ep *out,
   288			struct usb_ep *iso_in, struct usb_ep *iso_out)
   289	{
   290		disable_ep(cdev, in);
   291		disable_ep(cdev, out);
   292	}
   293	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

