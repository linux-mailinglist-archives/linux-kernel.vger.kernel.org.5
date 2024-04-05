Return-Path: <linux-kernel+bounces-133689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD9389A761
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391FB28199A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97A225779;
	Fri,  5 Apr 2024 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WNWyVRQR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10EC1426F;
	Fri,  5 Apr 2024 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712356666; cv=none; b=T5Rbsuqn+34S2wHnKLNokPRqJOuD2ScC6TlgDLm8MiFf/5WC8cxRf8mZDb7LoDEGK1X3YCQug+yOdZ28D/F5omQfX6EJ9D+c1EUhB9VNy1iDINgHnwVX7EQaWiJiDvWVkOTYpAGgdbXvJvKxg+pvs0ck2hL48rWzbwCOqT02c3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712356666; c=relaxed/simple;
	bh=pcosRLT+plCTRdcbPNPsDmzaWjgYtYbKdOn2t8ObmoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=embxmvH5lemReY14D9UMw8/K7h4ZgFR6e3QxelarrqzhkCU2LPwaeS4h3Mo5b+d/Fv3fzjU8h0LDrJfM+jb1prOmkKE/4dW85Nd1zwa4vFKO/rTnrmb9KzfWsYMZ5HILmX5843t/enBZPOWORxsFPKWRQ3ukpllLcELp/tPVl0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WNWyVRQR; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712356665; x=1743892665;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pcosRLT+plCTRdcbPNPsDmzaWjgYtYbKdOn2t8ObmoQ=;
  b=WNWyVRQRgOUxjG5OT6mkkWS9dejbbCGRPhKJnARgOdy696qf58jKxu0y
   K14HxmzoXUQyoNwPh/O2BKpDO7YeGZPfHzdSA6uo9GnkDxR6DTuRN3EM7
   +Vfgm6MTBJ7Quh1qT6DMggLS4T140O8LpiJdlI1031g8ZYTVeqUY/Rs2K
   sR1NPkkzYn/dJJzTdDdcyBtiaYh+JXnFtQjhferbha3dyOWe6pSj0ixks
   rC+JqUNEd6JaiQCMd8R9Nf+4ax8k/DnaRS/nweLUKxeOT4KS8N2lcf1Mi
   XENtfJ8eDXOXe6yke1a2BbdVlSpZWfvLUM0JXQZ2Qjxi0CzIqA/0OoKAl
   g==;
X-CSE-ConnectionGUID: 2qlAAbQJTe+0OKE9gDt8Jg==
X-CSE-MsgGUID: ZSqxPTT8QLKtUIouRzYhxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="19063730"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19063730"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 15:37:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="915268493"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="915268493"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 15:37:42 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rssBn-00000001sGz-2k5y;
	Sat, 06 Apr 2024 01:37:39 +0300
Date: Sat, 6 Apr 2024 01:37:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Tony Lindgren <tony@atomide.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v1 1/1] serial: core: Clearing the circular buffer before
 NULLifying it
Message-ID: <ZhB9M8C9IhXtJIXR@smile.fi.intel.com>
References: <20240404150034.41648-1-andriy.shevchenko@linux.intel.com>
 <f0f200b0-34dc-430b-b55e-b133faf4db44@kernel.org>
 <ZhAWIThfejjbmj8u@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhAWIThfejjbmj8u@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 05, 2024 at 06:17:54PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 05, 2024 at 07:25:03AM +0200, Jiri Slaby wrote:
> > On 04. 04. 24, 16:59, Andy Shevchenko wrote:
> > > The circular buffer is NULLified in uart_tty_port_shutdown()
> > > under the spin lock. However, the PM or other timer based callbacks
> > > may still trigger after this event without knowning that buffer pointer
> > > is not valid. Since the serial code is a bit inconsistent in checking
> > > the buffer state (some rely on the head-tail positions, some on the
> > > buffer pointer), it's better to have both aligned, i.e. buffer pointer
> > > to be NULL and head-tail possitions to be the same, meaning it's empty.
> > > This will prevent asynchronous calls to dereference NULL pointer as
> > > reported recently in 8250 case:
> > > 
> > >    BUG: kernel NULL pointer dereference, address: 00000cf5
> > >    Workqueue: pm pm_runtime_work
> > >    EIP: serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1809)
> > >    ...
> > >    ? serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1809)
> > >    __start_tx (drivers/tty/serial/8250/8250_port.c:1551)
> > >    serial8250_start_tx (drivers/tty/serial/8250/8250_port.c:1654)
> > >    serial_port_runtime_suspend (include/linux/serial_core.h:667 drivers/tty/serial/serial_port.c:63)
> > >    __rpm_callback (drivers/base/power/runtime.c:393)
> > >    ? serial_port_remove (drivers/tty/serial/serial_port.c:50)
> > >    rpm_suspend (drivers/base/power/runtime.c:447)
> > 
> > Yeah, I noticed start_tx() is called repeatedly after shutdown() yesterday
> > too. So thanks for looking into this.
> 
> > And it's pretty weird. I think it's new with the runtime PM (sure, /me reads
> > Fixes: now). I am not sure if it is documented, but most of the code in tty/
> > assumes NO ordinary ->ops (like start_tx()) are called after shutdown().
> > Actually, to me it occurs like serial8250_start_tx() should not be called in
> > the first place. It makes no sense after all.
> > 
> > BTW cannot be x_char en/queued at that time too (the other check in the if)?
> > But again, serial8250_start_tx() should not be called after shutdown().
> 
> Yes, and I have no clue how we can check this as startup can be called again
> and so on. The PM callback is timer based AFAIU, meaning it may happen at any
> time.
> 
> But do you agree that this patch has value on its own?

FWIW, https://lore.kernel.org/all/0000000000009e2dd805ffc595a3@google.com/T/

-- 
With Best Regards,
Andy Shevchenko



