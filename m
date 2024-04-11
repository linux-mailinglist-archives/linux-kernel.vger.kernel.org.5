Return-Path: <linux-kernel+bounces-141336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A0B8A1CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CD11F21EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891401BED89;
	Thu, 11 Apr 2024 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VGFLnbXP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390524437C;
	Thu, 11 Apr 2024 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853573; cv=none; b=DLl92851+LmQ3kfF/TAd+OQX57fIM9ZkV3C/N3AoBK3Tw3t2K+VuqNcu4W2WUM9cy4yKDqABgz5ff1nWLHPaDtmvi5ZOgV4bv2JVJ4sASPFkRftDf3MGd26wgplzptpuhzDRpV7XA5YWdF/G/NfUGB5I1GcpmVTXW9rlpBLCMew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853573; c=relaxed/simple;
	bh=FWunoAUN7z21xQA7WEUzBqvQaEPNfNMcpOGAEBJBDyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBPNLPrGdWTzntaSUCnXdWo2RAwblCgFQLdQZUgM/IYrDE+NuaNVn93FCbzKXw4pPiWtEds8nIJzj+FUnpBmo7FMLgyV82dCFeYB1dMkQ/U/ajVQoLtJ0oAyAzE/9pzqV+Sow8JNplcW1YyWriVl0PkwUZ89jV8kwXvZHTHuDQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VGFLnbXP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712853572; x=1744389572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FWunoAUN7z21xQA7WEUzBqvQaEPNfNMcpOGAEBJBDyU=;
  b=VGFLnbXPN+YvVdmkBOUc9ZrN7X4B6YNsliNzBnim4CMaWQPnmOM0F5fE
   pxY1zfBTz2n/MtWMAAMN8sHzn/o0t1BUHA4KKE3SbH7vpOSxEP+Y3Yp8u
   Zw6LzTKMXqvlUrFlgcFrwpryarh4ry0S1s+vFN0LAo5S313Fp/8XWuaQm
   eU7lxyDwvlEcW53hX+Rgn3Lr7zl3393APXsmsGxJN2vclkbCXmX4BN83w
   iDqqF5dmsuXT6YTymRTETUPAyfATHj0Vdmxqj7MPyFsKx0tCKQMdyuNzM
   2W9g0EpDBH+hLRXIFHK2x7SPO7FLEUrNREE71faiViwZ/vchKxxRwxpY1
   w==;
X-CSE-ConnectionGUID: nZZQsQCGT9iXQ0HQ11kkGQ==
X-CSE-MsgGUID: nlyGdgEyTlqc4zsrx4BW+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8454390"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8454390"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 09:39:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="915467127"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="915467127"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 09:39:27 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ruxSP-00000003PUu-0iqP;
	Thu, 11 Apr 2024 19:39:25 +0300
Date: Thu, 11 Apr 2024 19:39:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc: Ferry Toth <fntoth@gmail.com>, gregkh@linuxfoundation.org,
	s.hauer@pengutronix.de, jonathanh@nvidia.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_linyyuan@quicinc.com, paul@crapouillou.net,
	quic_eserrao@quicinc.com, erosca@de.adit-jv.com
Subject: Re: [PATCH v4] usb: gadget: u_ether: Replace netif_stop_queue with
 netif_device_detach
Message-ID: <ZhgSPCq6sVejRjbj@smile.fi.intel.com>
References: <20231006153808.9758-1-hgajjar@de.adit-jv.com>
 <20231006155646.12938-1-hgajjar@de.adit-jv.com>
 <ZaQS5x-XK08Jre6I@smile.fi.intel.com>
 <20240115132720.GA98840@vmlxhi-118.adit-jv.com>
 <f25283fc-4550-4725-960b-2ea783fd62e1@gmail.com>
 <aeee83d8-dee3-42ed-b705-988b17800721@gmail.com>
 <20240405113855.GA121923@vmlxhi-118.adit-jv.com>
 <321e908e-0d10-4e36-8dc4-6997c73fe2eb@gmail.com>
 <ZhbOZsp-XHemVhQz@smile.fi.intel.com>
 <20240411142637.GA110162@vmlxhi-118.adit-jv.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411142637.GA110162@vmlxhi-118.adit-jv.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 11, 2024 at 04:26:37PM +0200, Hardik Gajjar wrote:
> On Wed, Apr 10, 2024 at 08:37:42PM +0300, Andy Shevchenko wrote:
> > On Sun, Apr 07, 2024 at 10:51:51PM +0200, Ferry Toth wrote:
> > > Op 05-04-2024 om 13:38 schreef Hardik Gajjar:

..

> > > Exactly. And this didn't happen before the 2 patches.
> > > 
> > > To be precise: /sys/class/net/usb0 is not removed and it is a link, the link
> > > target /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/net/usb0 no
> > > longer exists
> 
> So, it means that the /sys/class/net/usb0 is present, but the symlink is
> broken. In that case, the dwc3 driver should recreate the device, and the
> symlink should become active again
> I have the dwc3 IP base usb controller, Let me check with this patch and
> share result here.  May be we need some fix in dwc3

It's quite possible, please test on your side.
We are happy to test any fixes if you come up with.

-- 
With Best Regards,
Andy Shevchenko



