Return-Path: <linux-kernel+bounces-128436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F518895ACD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1933C1F201A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7610815AAA1;
	Tue,  2 Apr 2024 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="NXvfIkZn"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED8215A4A4;
	Tue,  2 Apr 2024 17:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079426; cv=none; b=FTX2yEV5fCATSUYhp3r5hI9DYms+QYknaNbjUwBOw90UnBRgaTdUndo0H38xexPvMw1oZiq6LQlkFADJQBnZ+/h8GOKMwRS3Cx2KnImo0jEL/5dJZUCxWD1Xa/+xPNY0AuY6YQBdwArfmGNJg6LUy8PXmWNU9DJo4JVkCv77qPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079426; c=relaxed/simple;
	bh=5uOAjV3Vg35YUkmTzQtYe9c8rpLaT1QiFYRMknfdpK4=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=jxW40lW/FeOeuRS4bRGR2VM3IhlRuca18nEDc92hJ0n+8S9ZRxX9e/aFuuZyRNfMdZ3KMVoctSxdPzDv2bXITd0p/PUYrFGPqBd5ANRB+Inch/pFPeDQxP4bpjU09BBDTR91ZgzwibyJIaRSIBGRjcubFOLNjY8kxmeiyOSMe+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=NXvfIkZn; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=gWasRQVKJg4H/CT80jtjdU7PQlQo2NdH6FxQmY5BGxc=; b=NXvfIkZnXF9TVCybvgpLZ632tv
	xfJ+q0NtwEFUXo8bLJPv8+an2LfW18WBm0Oe3ONSnTLJZL6dK7xc2H05sCuhjJSFXoydplRSSnhqE
	mh5Ag+VIP/PPPbm54nJBtiNiJOCAzpYa5+IeoDJqSIQQ3syxdz2VO0B1TS1W2qXBiocU=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:46930 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rri4E-00089o-7l; Tue, 02 Apr 2024 13:37:02 -0400
Date: Tue, 2 Apr 2024 13:37:01 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby
 <jirislaby@kernel.org>
Message-Id: <20240402133701.21d8bd5d35754f042874b923@hugovil.com>
In-Reply-To: <ZgxBBioFa1HIFth8@smile.fi.intel.com>
References: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
	<20240402154219.3583679-3-andriy.shevchenko@linux.intel.com>
	<20240402131827.fdc429dfb6f62db4d291688f@hugovil.com>
	<ZgxBBioFa1HIFth8@smile.fi.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.4 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v1 02/16] serial: max3100: Update uart_driver_registered
 on driver removal
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Tue, 2 Apr 2024 20:31:50 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Apr 02, 2024 at 01:18:27PM -0400, Hugo Villeneuve wrote:
> > On Tue,  2 Apr 2024 18:38:08 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> ...
> 
> > >  	pr_debug("removing max3100 driver\n");
> > >  	uart_unregister_driver(&max3100_uart_driver);
> > > +	uart_driver_registered = 0;
> > 
> > At the beginning of the probe function, we have:
> > 
> > -----------------------
> > if (!uart_driver_registered) {
> > 		uart_driver_registered = 1;
> > 		retval = uart_register_driver(&max3100_uart_driver);
> > 		if (retval) {
> > 			printk(KERN_ERR "Couldn't register max3100 uart
> > driver\n"); mutex_unlock(&max3100s_lock);
> > 			return retval;
> > ...
> > -----------------------
> > 
> > If uart_register_driver() fails, uart_driver_registered would still be
> > true and would it prevent any other subsequent devices from being
> > properly registered? If yes, then maybe "uart_driver_registered = 1"
> > should be set only after a sucessfull call to uart_register_driver()?
> 
> Looks like yet another issue here (however I haven't hit it so far).
> I guess I can combine both fixes.  What do you think?

Hi Andy,
makes sense to me.

Hugo.


> 
> -- 
> With Best Regards,
> Andy Shevchenko

