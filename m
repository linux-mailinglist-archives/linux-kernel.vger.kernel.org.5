Return-Path: <linux-kernel+bounces-133229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DC889A0E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E982829C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E855816F8F4;
	Fri,  5 Apr 2024 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BmTamosB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7249316F8E7;
	Fri,  5 Apr 2024 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330399; cv=none; b=ZdCuPozdGO3C0XqxIOrjuISe4Pb+tGLhSbKgcbxJUh7lfxZkhDH/vh7AXzMVdYF8LoVv1diB759qAjGa0HfRA0aDm83QxSfyYsoXr6TIY99mNAOdoTzxpuZByW9U7ZdHSx4G4I+UHSIcq++SS26dbSXy/CE6/jXdt4SjHAAm3A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330399; c=relaxed/simple;
	bh=zMWTmQx2nT3RjbtOfOBywHBvYZe7yVPPkQiP6FlmHBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gm6jSGkEKmIvP8+SqbQoRZ9NGlwSKOsAAI3CnCSrYzKmlXa5u7XpUfFOGG3dduUmCiRSh1JU6cM4yJ3angoIz0tpHIITBaqvu9TOk7F8LjbdaGNLYqWf9RlUI4N3zTIWwVjbBKx2FVSW6600EUKyKdFbyhHtuhWX09ItkamFYV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BmTamosB; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712330398; x=1743866398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zMWTmQx2nT3RjbtOfOBywHBvYZe7yVPPkQiP6FlmHBM=;
  b=BmTamosBHVMF/PMM+P2CzzqqMP1n7fIxXlWFTFArCW22OOEYM5Z2yH5G
   2gn++f0YhscVTDN4SfZ3KOiE6j2QLjTMdMlccq6wEJnAw4ziRzbllAHoh
   xF5HEszfWn3N3xwFj80MYYn5ItCO//ZdZbB+yUbZU6mdAvujNZqO95jS7
   Avw4NzQThtjrhtZIRVmCpfxeqbpxdoqCmseyNXjhYcI8LuA3HrrRIYv7x
   iVTT4ayoW3/I4GBqIgdz0gOmduifLXBDYQkoqBx3HIH0WwogFWVuRTeim
   T0ILoJ29ho+RofqB0nwdbQv4kkpZJhk5XfXl7YbRouerwmUqxgsBcDwA2
   A==;
X-CSE-ConnectionGUID: d0zkD2IIQlCz6m1c9Cnlkg==
X-CSE-MsgGUID: JCeEKZ7dR6yXGhI6aqdTAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18274035"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="18274035"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:17:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="915256747"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="915256747"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:17:56 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rslKE-00000001mTp-0ZeY;
	Fri, 05 Apr 2024 18:17:54 +0300
Date: Fri, 5 Apr 2024 18:17:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Tony Lindgren <tony@atomide.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v1 1/1] serial: core: Clearing the circular buffer before
 NULLifying it
Message-ID: <ZhAWIThfejjbmj8u@smile.fi.intel.com>
References: <20240404150034.41648-1-andriy.shevchenko@linux.intel.com>
 <f0f200b0-34dc-430b-b55e-b133faf4db44@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0f200b0-34dc-430b-b55e-b133faf4db44@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 05, 2024 at 07:25:03AM +0200, Jiri Slaby wrote:
> On 04. 04. 24, 16:59, Andy Shevchenko wrote:
> > The circular buffer is NULLified in uart_tty_port_shutdown()
> > under the spin lock. However, the PM or other timer based callbacks
> > may still trigger after this event without knowning that buffer pointer
> > is not valid. Since the serial code is a bit inconsistent in checking
> > the buffer state (some rely on the head-tail positions, some on the
> > buffer pointer), it's better to have both aligned, i.e. buffer pointer
> > to be NULL and head-tail possitions to be the same, meaning it's empty.
> > This will prevent asynchronous calls to dereference NULL pointer as
> > reported recently in 8250 case:
> > 
> >    BUG: kernel NULL pointer dereference, address: 00000cf5
> >    Workqueue: pm pm_runtime_work
> >    EIP: serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1809)
> >    ...
> >    ? serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1809)
> >    __start_tx (drivers/tty/serial/8250/8250_port.c:1551)
> >    serial8250_start_tx (drivers/tty/serial/8250/8250_port.c:1654)
> >    serial_port_runtime_suspend (include/linux/serial_core.h:667 drivers/tty/serial/serial_port.c:63)
> >    __rpm_callback (drivers/base/power/runtime.c:393)
> >    ? serial_port_remove (drivers/tty/serial/serial_port.c:50)
> >    rpm_suspend (drivers/base/power/runtime.c:447)
> 
> Yeah, I noticed start_tx() is called repeatedly after shutdown() yesterday
> too. So thanks for looking into this.

> And it's pretty weird. I think it's new with the runtime PM (sure, /me reads
> Fixes: now). I am not sure if it is documented, but most of the code in tty/
> assumes NO ordinary ->ops (like start_tx()) are called after shutdown().
> Actually, to me it occurs like serial8250_start_tx() should not be called in
> the first place. It makes no sense after all.
> 
> BTW cannot be x_char en/queued at that time too (the other check in the if)?
> But again, serial8250_start_tx() should not be called after shutdown().

Yes, and I have no clue how we can check this as startup can be called again
and so on. The PM callback is timer based AFAIU, meaning it may happen at any
time.

But do you agree that this patch has value on its own?

-- 
With Best Regards,
Andy Shevchenko



