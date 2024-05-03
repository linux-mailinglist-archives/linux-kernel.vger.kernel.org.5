Return-Path: <linux-kernel+bounces-167835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D008BB004
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9525B284215
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566D51552E8;
	Fri,  3 May 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A0AaBGf1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E13D154C08;
	Fri,  3 May 2024 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750552; cv=none; b=lCVyOAr0E4j2KuhSBim19U+/FdfmnsbwG4srOGgsq7R6uxGBziibzhyb14XPclMe7rgSanxTwuukzoJ4//QPsia/ZUucpUE+octeWinvfwg5hJSqUM4D885cCZb38SOLRxU4sH5+fCe1+Vwt/OPLvnIQ/UDbA1m+43zsdrNHbDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750552; c=relaxed/simple;
	bh=+qiUyuHYdoF2a6KXNUlTVYCi8PbGgXjnFiDn9PglpeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I98qLxEamfBZ2b5OjzIkFaYjXjiiwb6HhW5Kc9JXzo8sHpbpi22aICiEpKWPjtrGxSiGPVuxTg8YqSxgr/76ESh+XtzNiqz0bqbljbrZBgnC1gsbSYAJFG4/hMNT7BJ7rCbwR8yzIA1450Gib3/lx+va6k/p63PhzotG8c8YYdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A0AaBGf1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714750551; x=1746286551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+qiUyuHYdoF2a6KXNUlTVYCi8PbGgXjnFiDn9PglpeM=;
  b=A0AaBGf1O9E4ZxdNzyCRS5m2yuwUj3QWAZAeGg9R3wvQ6jZGs6Cb0JiY
   NvB3o6lh0UaPyJOrlxOWTY5yy5Kbr2+Pm9ad8ZVCnnF57amXvolL0ZaD3
   fAMJnyo7bu7jNRcIm9kOWJ6LkkCZrCUgkDeHD7jsDqFQkJEdPbmGNhdCE
   qwChnI1f2qFfkVMPVBASXVIJViqAY6dFyGFYRifHzF45sWUfR+8FNTbeH
   oe8eUrmYZewXhNOZDdfwEpoK5yB5XOv76UWCxEZ1ChTeu2WTlM6F3ExIE
   M1L2XzT9qnwyEa/TyPVHOi1Sn/53jrdSRISTq+koV2wfA/R06deb1enTd
   Q==;
X-CSE-ConnectionGUID: 1AXXTsaBQJ+FPpljLtAkmQ==
X-CSE-MsgGUID: WfT/VcznQzuf0gQkdadWXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="21713269"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="21713269"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 08:35:51 -0700
X-CSE-ConnectionGUID: U3TqNEvQQwCYqIVjk76aMA==
X-CSE-MsgGUID: UjPF7OFaR/acqaIhouctQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27358043"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 08:35:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2uwr-00000003gr7-3yxQ;
	Fri, 03 May 2024 18:35:45 +0300
Date: Fri, 3 May 2024 18:35:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Parker Newman <pnewman@connecttech.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 11/13] serial: 8250_exar: Use BIT() in exar_ee_read()
Message-ID: <ZjUEURneUmZ4nmbC@smile.fi.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
 <20240502144626.2716994-12-andriy.shevchenko@linux.intel.com>
 <702a9145-5bc1-c765-a1fa-278702741637@linux.intel.com>
 <ZjPLQeTEKvt7B3mj@smile.fi.intel.com>
 <20240503102632.112a34bd@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240503102632.112a34bd@SWDEV2.connecttech.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 03, 2024 at 10:26:32AM -0400, Parker Newman wrote:
> On Thu, 2 May 2024 20:20:01 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, May 02, 2024 at 07:08:21PM +0300, Ilpo Järvinen wrote:
> > > On Thu, 2 May 2024, Andy Shevchenko wrote:  

..

> > > >  	// Send address to read from
> > > > -	for (i = 1 << (UART_EXAR_REGB_EE_ADDR_SIZE - 1); i; i >>= 1)
> > > > -		exar_ee_write_bit(priv, (ee_addr & i));
> > > > +	for (i = UART_EXAR_REGB_EE_ADDR_SIZE - 1; i >= 0; i--)
> > > > +		exar_ee_write_bit(priv, ee_addr & BIT(i));
> > > >  
> > > >  	// Read data 1 bit at a time
> > > >  	for (i = 0; i <= UART_EXAR_REGB_EE_DATA_SIZE; i++) {
> > > > -		data <<= 1;
> > > > -		data |= exar_ee_read_bit(priv);
> > > > +		if (exar_ee_read_bit(priv))
> > > > +			data |= BIT(i);  
> > > 
> > > Does this end up reversing the order of bits? In the original, data was left
> > > shifted which moved the existing bits and added the lsb but the replacement
> > > adds highest bit on each iteration?  
> > 
> > Oh, seems a good catch!
> > 
> > I was also wondering, but missed this somehow. Seems the EEPROM is in BE mode,
> > so two loops has to be aligned.
> > 
> 
> I just tested this and Ilpo is correct, the read loop portion is backwards as 
> expected. This is the corrected loop:
> 
>     // Read data 1 bit at a time
>     for (i = UART_EXAR_REGB_EE_DATA_SIZE; i >= 0; i--) {
>         if (exar_ee_read_bit(priv))
>             data |= BIT(i);
>     }
> 
> I know this looks wrong because its looping from 16->0 rather than the 
> more intuitive 15->0 for a 16bit value. This is actually correct however 
> because according to the AT93C46D datasheet there is always dummy 0 bit
> before the actual 16 bits of data.
> 
> I hope that helps,

Yes, it helps and means that we need that comment to be added to the code. Is
it the same applicable to the write part above (for address)? Because AFAIU
mine is one bit longer than yours. Maybe in the original code is a bug? Have
you tried to read high addresses?


-- 
With Best Regards,
Andy Shevchenko



