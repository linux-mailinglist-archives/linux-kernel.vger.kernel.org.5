Return-Path: <linux-kernel+bounces-160331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7FE8B3C10
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449871C2301D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF3D14A4D4;
	Fri, 26 Apr 2024 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eoT/O7Rt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2997C1494A6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146593; cv=none; b=qlD/cwNoXihtLujx8R0p33sFCJL2vmI/hZI6TsOeyjlPjJ0J0lING+aGdd24h0EbTEE1rtHByVT4kQXrTmmKxfO0Ovm+2KZ0aS+rI0WAxLLWdtWe9APnZygN7eom2x3wB6ohX3E16Oe1qmjj8UhFP0bjevFxHNNGFxV2ZMaikUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146593; c=relaxed/simple;
	bh=ywp/OHwzcUNSwhcX3iZaKfJFs0VQBPeePi0ku6OXRCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpJUWtY5rIPP2sQPBAu7nwtSGBYyHGjwq1sE39ixvtSnBiJvKDcRmDqOg8J6EwUM3f5Sw7Vvy2716jUFoExAx4GBAReGpOzWpHTaGCL57jpJe7n4zOd1ws5CzTxsd3c6f80Sg99b8Ao8ruVhgFli3hENZ2qN7MBfnmcQK5HPTis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eoT/O7Rt; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714146592; x=1745682592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ywp/OHwzcUNSwhcX3iZaKfJFs0VQBPeePi0ku6OXRCQ=;
  b=eoT/O7RtkoP4uPuu3rj8Lshv38uSNR8chx1Y+pD04HJ8mibVJTtmVDR1
   2wUdmURr0az5EJjXqKBh75izbJcBk7glxczcg7jaNO6Lu/T5k9tVcp2Lj
   khdxniRGvnEtPAbGOCTvc/pa3ad21/QtCyIxLXvszi+2jo7TAoqOmz/3M
   9W7TEto5hcKHTh5PnnR4qV0lCkPo76rNw9TZEi8/gIUK9HEl5RMq0ZUDh
   jHS8ZDmXoTH/F0ztHLzV/V1UG77URvx4zfYByYXJYChzO2SWrqO49ydF6
   u5g0V0bVkqun4dMQed4TMFulnXvp+KgWXr7hsRZy25nTB6r+8k6+vWGX5
   w==;
X-CSE-ConnectionGUID: N9gjqf1VSG2lVWBV7zJtbg==
X-CSE-MsgGUID: umpbfrJISdmnobFXpeTLiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="13675000"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="13675000"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 08:49:51 -0700
X-CSE-ConnectionGUID: 1gAbxF31SKeQC4yS/jLQhA==
X-CSE-MsgGUID: Oz6qWipCRTOkXbdnel6Y1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="25532506"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 08:49:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s0Npc-00000001Mtj-1hG0;
	Fri, 26 Apr 2024 18:49:48 +0300
Date: Fri, 26 Apr 2024 18:49:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] zorro: Use helpers from ioport.h
Message-ID: <ZivNHGjvj-6u4sUl@smile.fi.intel.com>
References: <20230831121623.36293-1-andriy.shevchenko@linux.intel.com>
 <CAMuHMdVoDDV-VgPJL75u_t3KeAPhb1xEFX2VigVC3oS51pG6wA@mail.gmail.com>
 <ZivJKZ8Pp_bfLcvO@smile.fi.intel.com>
 <CAMuHMdVsYdPnFD_LEdDez7JXYdh67DPoc2GhLNv29B6=65u6+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVsYdPnFD_LEdDez7JXYdh67DPoc2GhLNv29B6=65u6+g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 26, 2024 at 05:42:21PM +0200, Geert Uytterhoeven wrote:
> On Fri, Apr 26, 2024 at 5:33 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Sep 04, 2023 at 11:31:03AM +0200, Geert Uytterhoeven wrote:
> > > On Thu, Aug 31, 2023 at 2:16 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

..

> > > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > i.e. will queue in the m68k for-v6.7 branch, with the above fixed.
> >
> > Seems never got queued, should I send a v2 with the above fixed?
> 
> Oops, will queue in the m68k tree for v6.10.
> No need to resend, I still have a fixed copy in my local tree.

Thank you!

It's far from (my personal experience) the record of the time
from publishing in the mailing list and getting it in upstream,
so we are all fine :-)

-- 
With Best Regards,
Andy Shevchenko



