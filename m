Return-Path: <linux-kernel+bounces-166639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7D28B9D62
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67BBF281DA1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2250515B14C;
	Thu,  2 May 2024 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l9U77uTj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0502015B117;
	Thu,  2 May 2024 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663752; cv=none; b=Im/q4XQgD1L66OOuYpZYC7TeVRkUznnFc0V1tpt8moRMNI1kHzhZB6vuH6BQeN+KStMqBdIUPLaE/7VX3EcPc9+J8xpD6dvTsdIWvL+m2xpAKJwiW8R8SPXRFt6kM4QHQnVZpxv9nHpku1eVplcA9TSSam1tyMp0qZ8rdrIAMEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663752; c=relaxed/simple;
	bh=cPGa8qLZCWdSfi3FLowd1sGPDmQvoIjKXRVt4ZJcvo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJsuST65HBrJzM+KmYVjqpffhM2rrHgWQGyED3wIj6r1YxO2Ej5RQfV42itU7dzrzo0YlthboToieaOzCXMsy51AAY2jJxBiUTvBPRNd7uYK/G91pIPSonvveFxeBSqi4x0awx7ligWgUBs+Nn0F4u/tvNjYQqtGM/Wmls+CgZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l9U77uTj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714663751; x=1746199751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cPGa8qLZCWdSfi3FLowd1sGPDmQvoIjKXRVt4ZJcvo0=;
  b=l9U77uTj8rsuUsMksX4V7ADV/1V1GOAG5FGpJaI30v34khSnEbjJ1gwk
   rARBBA1fXZ4WxdmEcCfuqpD+IEPEImFUuMyjf0CxHIB6digPPvtkT1qb0
   vho4sDIlOzOvnUfRWVn7wRqBoe/87FSVmErWs13jdw9Dbg7G3OgDIIpvd
   j5wPiq6ntXcGL3VvSaUPKJlxde4yh7zMCct8se0r8lbi3Jsgj6cUq/VmV
   OcvDeHsYDXX14b0JBZGUu6nHcv16OtwBlsBQVWLyUgzv++maIc/LklO9z
   4g+g9VBLPO93pX+2EdQY2HvQPCvAL7sIJk3wFqvtJO+Bvzv5pxtvZ7tgB
   A==;
X-CSE-ConnectionGUID: EpXw65IiSmW8drCIqrapCw==
X-CSE-MsgGUID: OzXC1p55SWeS3CHSZDdqNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="21585714"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21585714"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:29:10 -0700
X-CSE-ConnectionGUID: qW6WCQrGQ8OLazAZ0dlIGQ==
X-CSE-MsgGUID: B6Bb5c08RSC2Z3CHlB3T0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27160860"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:29:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2YMr-00000003MXs-3dAB;
	Thu, 02 May 2024 18:29:05 +0300
Date: Thu, 2 May 2024 18:29:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 03/13] serial: 8250_exar: Kill CTI_PCI_DEVICE()
Message-ID: <ZjOxQWc1OtGWatKC@smile.fi.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
 <20240502144626.2716994-4-andriy.shevchenko@linux.intel.com>
 <20240502111314.63d66b54@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502111314.63d66b54@SWDEV2.connecttech.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 02, 2024 at 11:13:14AM -0400, Parker Newman wrote:
> On Thu,  2 May 2024 17:43:57 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> > The CTI_PCI_DEVICE() duplicates EXAR_DEVICE(). Kill the former.

..

> > -// For Connect Tech cards with Connect Tech vendor/device PCI IDs (FPGA based)
> > -#define CTI_PCI_DEVICE(devid, bd) {                     \
> > -	PCI_DEVICE_SUB(                                 \
> > -		PCI_VENDOR_ID_CONNECT_TECH,             \
> > -		PCI_DEVICE_ID_CONNECT_TECH_PCI_##devid, \


#define PCI_DEVICE_SUB(vend, dev, subvend, subdev) \
        .vendor = (vend), .device = (dev), \
        .subvendor = (subvend), .subdevice = (subdev)

#define PCI_DEVICE_DATA(vend, dev, data) \
        .vendor = PCI_VENDOR_ID_##vend, .device = PCI_DEVICE_ID_##vend##_##dev, \
        .subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, 0, 0, \
        .driver_data = (kernel_ulong_t)(data)


> > -		PCI_ANY_ID,                             \
> > -		PCI_ANY_ID), 0, 0,                      \
> > -		(kernel_ulong_t)&bd                     \
> > -	}
> > -
> >  #define EXAR_DEVICE(vend, devid, bd) { PCI_DEVICE_DATA(vend, devid, &bd) }

> This is not correct. The CTI_PCI_DEVICE() macro is for cards that have the
> Connect Tech PCI Vendor ID (not Sub-Vendor ID). EXAR_DEVICE() is for cards with
> Exar PCI Vendor ID.

Above I added current code of these macros, can you elaborate how it's incorrect?

-- 
With Best Regards,
Andy Shevchenko



