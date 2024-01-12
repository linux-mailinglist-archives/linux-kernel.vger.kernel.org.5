Return-Path: <linux-kernel+bounces-24177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D93B82B895
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D0C2886E9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C3410F1;
	Fri, 12 Jan 2024 00:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BTYdAj08"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96CAEC5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 00:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705019235; x=1736555235;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=i1UWrZ+W7NNjDlVpd+ksZYxVocCkskh0YhN/uIN1rs4=;
  b=BTYdAj08d8UhsPxHRvx1EMcMlgeIAsBZbERHp+NKHMdiuz5lKxjDPnEi
   Yhqq+8qrDn9WvhoBFxF9hpQ6pk8z/pY9jObnlQuTtgGZlnUsZqTn45GyC
   u4rFk4H0fR1MJezNGlGrExp/hdRNwlfQbAQfSvH+F3Pbha5ItEgPe2x30
   a72HfBbMkrna3t0gKS6YnFhTK6Yy6axx6ygL7lsup5QpZiuvFJg2DC473
   CgQ1VUNxpAKWhZSiwIatEFcbZJRIUXabzJrBxg9DHrWK0IGSKDGQpsFIc
   ExsiyC3yXdWtN8DZf9jqDy3un0bSRVeLJcmhr1ir2hPpi1sEMWeZnkdcU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="5766683"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="5766683"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 16:27:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="906140356"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="906140356"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Jan 2024 16:27:13 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rO5OB-0008tO-1e;
	Fri, 12 Jan 2024 00:27:11 +0000
Date: Fri, 12 Jan 2024 08:27:03 +0800
From: kernel test robot <lkp@intel.com>
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Felipe Balbi <balbi@kernel.org>
Subject: drivers/usb/gadget/udc/max3420_udc.c:555:41: sparse: sparse:
 restricted __le16 degrades to integer
Message-ID: <202401120851.7BJ9MPCT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   457e4f99765cc41d0b90e1385f51b848d6a921d0
commit: 48ba02b2e2b1a1c80718e93fefe99c8319597c4a usb: gadget: add udc driver for max3420
date:   3 years, 10 months ago
config: i386-randconfig-061-20240106 (https://download.01.org/0day-ci/archive/20240112/202401120851.7BJ9MPCT-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401120851.7BJ9MPCT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401120851.7BJ9MPCT-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/usb/gadget/udc/max3420_udc.c:555:41: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/max3420_udc.c:556:31: sparse: sparse: restricted __le16 degrades to integer
>> drivers/usb/gadget/udc/max3420_udc.c:570:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] status @@     got restricted __le16 [usertype] @@
   drivers/usb/gadget/udc/max3420_udc.c:570:16: sparse:     expected unsigned short [assigned] [usertype] status
   drivers/usb/gadget/udc/max3420_udc.c:570:16: sparse:     got restricted __le16 [usertype]
   drivers/usb/gadget/udc/max3420_udc.c:588:31: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/max3420_udc.c:602:32: sparse: sparse: restricted __le16 degrades to integer
>> drivers/usb/gadget/udc/max3420_udc.c:631:29: sparse: sparse: cast from restricted __le16
   drivers/usb/gadget/udc/max3420_udc.c:632:29: sparse: sparse: cast from restricted __le16
   drivers/usb/gadget/udc/max3420_udc.c:633:30: sparse: sparse: cast from restricted __le16

vim +555 drivers/usb/gadget/udc/max3420_udc.c

   538	
   539	static void max3420_getstatus(struct max3420_udc *udc)
   540	{
   541		struct max3420_ep *ep;
   542		u16 status = 0;
   543	
   544		switch (udc->setup.bRequestType & USB_RECIP_MASK) {
   545		case USB_RECIP_DEVICE:
   546			/* Get device status */
   547			status = udc->gadget.is_selfpowered << USB_DEVICE_SELF_POWERED;
   548			status |= (udc->remote_wkp << USB_DEVICE_REMOTE_WAKEUP);
   549			break;
   550		case USB_RECIP_INTERFACE:
   551			if (udc->driver->setup(&udc->gadget, &udc->setup) < 0)
   552				goto stall;
   553			break;
   554		case USB_RECIP_ENDPOINT:
 > 555			ep = &udc->ep[udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK];
   556			if (udc->setup.wIndex & USB_DIR_IN) {
   557				if (!ep->ep_usb.caps.dir_in)
   558					goto stall;
   559			} else {
   560				if (!ep->ep_usb.caps.dir_out)
   561					goto stall;
   562			}
   563			if (ep->halted)
   564				status = 1 << USB_ENDPOINT_HALT;
   565			break;
   566		default:
   567			goto stall;
   568		}
   569	
 > 570		status = cpu_to_le16(status);
   571		spi_wr_buf(udc, MAX3420_REG_EP0FIFO, &status, 2);
   572		spi_wr8_ack(udc, MAX3420_REG_EP0BC, 2, 1);
   573		return;
   574	stall:
   575		dev_err(udc->dev, "Can't respond to getstatus request\n");
   576		spi_wr8(udc, MAX3420_REG_EPSTALLS, STLEP0IN | STLEP0OUT | STLSTAT);
   577	}
   578	
   579	static void max3420_set_clear_feature(struct max3420_udc *udc)
   580	{
   581		struct max3420_ep *ep;
   582		int set = udc->setup.bRequest == USB_REQ_SET_FEATURE;
   583		unsigned long flags;
   584		int id;
   585	
   586		switch (udc->setup.bRequestType) {
   587		case USB_RECIP_DEVICE:
   588			if (udc->setup.wValue != USB_DEVICE_REMOTE_WAKEUP)
   589				break;
   590	
   591			if (udc->setup.bRequest == USB_REQ_SET_FEATURE)
   592				udc->remote_wkp = 1;
   593			else
   594				udc->remote_wkp = 0;
   595	
   596			return spi_ack_ctrl(udc);
   597	
   598		case USB_RECIP_ENDPOINT:
   599			if (udc->setup.wValue != USB_ENDPOINT_HALT)
   600				break;
   601	
   602			id = udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK;
   603			ep = &udc->ep[id];
   604	
   605			spin_lock_irqsave(&ep->lock, flags);
   606			ep->todo &= ~STALL_EP;
   607			if (set)
   608				ep->todo |= STALL;
   609			else
   610				ep->todo |= UNSTALL;
   611			spin_unlock_irqrestore(&ep->lock, flags);
   612	
   613			spi_max3420_stall(ep);
   614			return;
   615		default:
   616			break;
   617		}
   618	
   619		dev_err(udc->dev, "Can't respond to SET/CLEAR FEATURE\n");
   620		spi_wr8(udc, MAX3420_REG_EPSTALLS, STLEP0IN | STLEP0OUT | STLSTAT);
   621	}
   622	
   623	static void max3420_handle_setup(struct max3420_udc *udc)
   624	{
   625		struct usb_ctrlrequest setup;
   626		u8 addr;
   627	
   628		spi_rd_buf(udc, MAX3420_REG_SUDFIFO, (void *)&setup, 8);
   629	
   630		udc->setup = setup;
 > 631		udc->setup.wValue = cpu_to_le16(setup.wValue);
   632		udc->setup.wIndex = cpu_to_le16(setup.wIndex);
   633		udc->setup.wLength = cpu_to_le16(setup.wLength);
   634	
   635		switch (udc->setup.bRequest) {
   636		case USB_REQ_GET_STATUS:
   637			/* Data+Status phase form udc */
   638			if ((udc->setup.bRequestType &
   639					(USB_DIR_IN | USB_TYPE_MASK)) !=
   640					(USB_DIR_IN | USB_TYPE_STANDARD)) {
   641				break;
   642			}
   643			return max3420_getstatus(udc);
   644		case USB_REQ_SET_ADDRESS:
   645			/* Status phase from udc */
   646			if (udc->setup.bRequestType != (USB_DIR_OUT |
   647					USB_TYPE_STANDARD | USB_RECIP_DEVICE)) {
   648				break;
   649			}
   650			addr = spi_rd8_ack(udc, MAX3420_REG_FNADDR, 1);
   651			dev_dbg(udc->dev, "Assigned Address=%d\n", udc->setup.wValue);
   652			return;
   653		case USB_REQ_CLEAR_FEATURE:
   654		case USB_REQ_SET_FEATURE:
   655			/* Requests with no data phase, status phase from udc */
   656			if ((udc->setup.bRequestType & USB_TYPE_MASK)
   657					!= USB_TYPE_STANDARD)
   658				break;
   659			return max3420_set_clear_feature(udc);
   660		default:
   661			break;
   662		}
   663	
   664		if (udc->driver->setup(&udc->gadget, &setup) < 0) {
   665			/* Stall EP0 */
   666			spi_wr8(udc, MAX3420_REG_EPSTALLS,
   667				STLEP0IN | STLEP0OUT | STLSTAT);
   668		}
   669	}
   670	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

