Return-Path: <linux-kernel+bounces-146909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B6A8A6CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25A1283A2E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3024C12C559;
	Tue, 16 Apr 2024 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/qWE53G"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6768812BF2A;
	Tue, 16 Apr 2024 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275321; cv=none; b=Chc+6ZnfsYFLuW8hj1U7zVnSdgbS7n+Sph4hFtAlp7RcK/LHy6HutOgsNzLwhcWBrizml0J+t2Hek9n8WhkP3Dgl2ntHWhRo6nZ/AsetULjy1aKpzRmh+O/6z2tRk1K/LlXFuh9fspvEVpR8QfFq2fpR5l6PVn0Y4bJjkhFv70E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275321; c=relaxed/simple;
	bh=Oip3+4PrV0FMvAgVwYG7/089d61ifwAWxkR30pZ6edY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKg618ksre6d9I5p5WIH+ZFJlUwpa95HaDwhHDCoHbhaMM93lIui2aGkerxzZ0eaLAE/sUpMOCM+bFzCopjo7kCNNwNG0QigwVtg+nFSO2urAa1Z1cVWi8FwzDwKbmWHDNWpxRuHrv3l/CgB4BgnsK0d/Np34D3yDDgooSRTOHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/qWE53G; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713275320; x=1744811320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Oip3+4PrV0FMvAgVwYG7/089d61ifwAWxkR30pZ6edY=;
  b=f/qWE53GG4LM/Wz9rT0xVBBw97QnqzuREfIMadU1gkDpltWAI7rDEffa
   e5Q7HFVYrIHjBBdvv0phMIMigRenBbqTn+d0qfnH05uwI8+Qu2YQu0tFE
   SXUwX9ye7djt/wSbaPLIZSAl1zw23CakDLgSONL/ejLEj0+Si4oZIQ9Zy
   hPPyA/ln+uIrwwWCgeLmUHsd6kOzQvJYrl4m8tsNCPv3Fz0DSVrsDG/Zo
   5W6jx2YV7egrypl1gBEHK1eCtx2yR+hK9Q7QArFNoLOVTUCWI7zJkxh/C
   4c9U0HcpChUGE1U04vPC7Zq+NYwe4ytJtSdl23FtBSeWnEqzIkhuzJ8Lu
   A==;
X-CSE-ConnectionGUID: KO7/Yg9URuS2xb10rfkG5A==
X-CSE-MsgGUID: lnhd2FcaQdagmezp8qEubQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8838455"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8838455"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 06:48:39 -0700
X-CSE-ConnectionGUID: rDgqA8g5SjaGFC/H2FdqcA==
X-CSE-MsgGUID: zEFE+wLAQ6S0aqY9WueuoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="53445503"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 06:48:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rwjAn-00000004i6e-19hx;
	Tue, 16 Apr 2024 16:48:33 +0300
Date: Tue, 16 Apr 2024 16:48:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ferry Toth <fntoth@gmail.com>
Cc: Hardik Gajjar <hgajjar@de.adit-jv.com>, gregkh@linuxfoundation.org,
	s.hauer@pengutronix.de, jonathanh@nvidia.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_linyyuan@quicinc.com, paul@crapouillou.net,
	quic_eserrao@quicinc.com, erosca@de.adit-jv.com
Subject: Re: [PATCH v4] usb: gadget: u_ether: Replace netif_stop_queue with
 netif_device_detach
Message-ID: <Zh6BsK8F3gCzGJfE@smile.fi.intel.com>
References: <ZaQS5x-XK08Jre6I@smile.fi.intel.com>
 <20240115132720.GA98840@vmlxhi-118.adit-jv.com>
 <f25283fc-4550-4725-960b-2ea783fd62e1@gmail.com>
 <aeee83d8-dee3-42ed-b705-988b17800721@gmail.com>
 <20240405113855.GA121923@vmlxhi-118.adit-jv.com>
 <321e908e-0d10-4e36-8dc4-6997c73fe2eb@gmail.com>
 <ZhbOZsp-XHemVhQz@smile.fi.intel.com>
 <20240411142637.GA110162@vmlxhi-118.adit-jv.com>
 <ZhgSPCq6sVejRjbj@smile.fi.intel.com>
 <be8904bd-71ea-4ae1-b0bc-9170461fd0d9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be8904bd-71ea-4ae1-b0bc-9170461fd0d9@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 11, 2024 at 10:52:36PM +0200, Ferry Toth wrote:
> Op 11-04-2024 om 18:39 schreef Andy Shevchenko:
> > On Thu, Apr 11, 2024 at 04:26:37PM +0200, Hardik Gajjar wrote:
> > > On Wed, Apr 10, 2024 at 08:37:42PM +0300, Andy Shevchenko wrote:
> > > > On Sun, Apr 07, 2024 at 10:51:51PM +0200, Ferry Toth wrote:
> > > > > Op 05-04-2024 om 13:38 schreef Hardik Gajjar:

..

> > > > > Exactly. And this didn't happen before the 2 patches.
> > > > > 
> > > > > To be precise: /sys/class/net/usb0 is not removed and it is a link, the link
> > > > > target /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/net/usb0 no
> > > > > longer exists
> > > So, it means that the /sys/class/net/usb0 is present, but the symlink is
> > > broken. In that case, the dwc3 driver should recreate the device, and the
> > > symlink should become active again
> 
> Yes, on first enabling gadget (when device mode is activated):
> 
> root@yuna:~# ls /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
> driver  net  power  sound  subsystem  suspended  uevent
> 
> Then switching to host mode:
> 
> root@yuna:~# ls /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
> ls: cannot access
> '/sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/': No such file
> or directory
> 
> Then back to device mode:
> 
> root@yuna:~# ls /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
> driver  power  sound  subsystem  suspended  uevent
> 
> net is missing. But, network functions:
> 
> root@yuna:~# ping 10.42.0.1
> PING 10.42.0.1 (10.42.0.1): 56 data bytes
> 
> Mass storage device is created and removed each time as expected.

So, what's the conclusion? Shall we move towards revert of those two changes?

> > > I have the dwc3 IP base usb controller, Let me check with this patch and
> > > share result here.  May be we need some fix in dwc3
> Would have been nice if someone could test on other controller as well. But
> another instance of dwc3 is also very welcome.
> > It's quite possible, please test on your side.
> > We are happy to test any fixes if you come up with.

-- 
With Best Regards,
Andy Shevchenko



