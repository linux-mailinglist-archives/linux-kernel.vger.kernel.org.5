Return-Path: <linux-kernel+bounces-27359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EF682EEA9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1561F24306
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E973C1BC2C;
	Tue, 16 Jan 2024 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VdUFHjEW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CED1B971;
	Tue, 16 Jan 2024 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705406709; x=1736942709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ObtUgAvWgI8p0FDfghm9eenqCcQ4fSvkALWKCuchi5Y=;
  b=VdUFHjEWw79wK9MXFr2aEx4KZQfh9n3r9yrZ7YXrm/hNc2ka4bL4rMHi
   MAT+UJyIUGN6x3jIU183LjTycUc3BcbjNvh0Iq/Q1J+sYyVfLzLjkxdav
   a95MaO9hEU/3zChDKhrK11VkzwgcfomktvLK2IbAreIbgkiLSDdI6hsL7
   GC2t/TQEKA77RnhQdTbIUHkmN2ZBvSRgduLUWtFKG3gwl7IV4T3Df6Tld
   755VMcFHMZxglGKxamGeUc/PnyPQK7Blr6pQ6bAV4ZuAv1VaVxpPTzCru
   2aXd64MrYl2Xx2GpJVqf0NJJd5occqy2e71nOMCDnw0JLuBwpwbUHAuSX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="21316649"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="21316649"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 04:05:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="32433354"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 16 Jan 2024 04:05:04 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPiBi-0000f2-0A;
	Tue, 16 Jan 2024 12:05:02 +0000
Date: Tue, 16 Jan 2024 20:04:30 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, kernel@pengutronix.de,
	Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: Re: [PATCH 1/3] usb: gadget: function: 9pfs
Message-ID: <202401161948.no61pNtO-lkp@intel.com>
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
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20240116/202401161948.no61pNtO-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240116/202401161948.no61pNtO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401161948.no61pNtO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/usb/gadget/function/f_9pfs.c:21:
   drivers/usb/gadget/function/f_9pfs.c: In function 'usb9pfs_rx_header':
>> drivers/usb/gadget/function/f_9pfs.c:196:34: warning: format '%u' expects argument of type 'unsigned int', but argument 5 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
     196 |         p9_debug(P9_DEBUG_TRANS, "mux %p got %u bytes\n", usb9pfs,
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~
     197 |                  rc.capacity - rc.offset);
         |                  ~~~~~~~~~~~~~~~~~~~~~~~
         |                              |
         |                              size_t {aka long unsigned int}
   include/net/9p/9p.h:55:36: note: in definition of macro 'p9_debug'
      55 |         _p9_debug(level, __func__, fmt, ##__VA_ARGS__)
         |                                    ^~~
   drivers/usb/gadget/function/f_9pfs.c:196:47: note: format string is defined here
     196 |         p9_debug(P9_DEBUG_TRANS, "mux %p got %u bytes\n", usb9pfs,
         |                                              ~^
         |                                               |
         |                                               unsigned int
         |                                              %lu
   drivers/usb/gadget/function/f_9pfs.c: At top level:
>> drivers/usb/gadget/function/f_9pfs.c:286:6: warning: no previous prototype for 'disable_endpoints' [-Wmissing-prototypes]
     286 | void disable_endpoints(struct usb_composite_dev *cdev,
         |      ^~~~~~~~~~~~~~~~~
>> drivers/usb/gadget/function/f_9pfs.c:825:12: warning: no previous prototype for 'usb9pfs_modinit' [-Wmissing-prototypes]
     825 | int __init usb9pfs_modinit(void)
         |            ^~~~~~~~~~~~~~~
>> drivers/usb/gadget/function/f_9pfs.c:838:13: warning: no previous prototype for 'usb9pfs_modexit' [-Wmissing-prototypes]
     838 | void __exit usb9pfs_modexit(void)
         |             ^~~~~~~~~~~~~~~


vim +196 drivers/usb/gadget/function/f_9pfs.c

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
 > 196		p9_debug(P9_DEBUG_TRANS, "mux %p got %u bytes\n", usb9pfs,
   197			 rc.capacity - rc.offset);
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

