Return-Path: <linux-kernel+bounces-112237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E6D887749
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 07:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC421F2231F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 06:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BDA944E;
	Sat, 23 Mar 2024 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="KxJDs5kU"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8CE4C6B;
	Sat, 23 Mar 2024 06:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711176587; cv=none; b=UuvkRsetT3+B6rh/NqIqMg5FxO+KIXk+kQurMLrva2yyeeGFGdXOs1LAnwBOfMRYJElPZFNBin4ivLvKVmVSFHmTLpeYPPglk0Df1aaZI1UnretPVzwO96fpSA5RlZDncDze6LCRPogCW2qk9FVX7n7/nSUwOvz8cWdkXx5UFhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711176587; c=relaxed/simple;
	bh=NqzzK0iz78KIPvtZ1w0JtdqyZDW7tedW5UnASOm5zGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/abi34v6ClC1f3Zfm7UTQ0MSu8QWWT8BSzwKEtjNt/RcRxoqb84c815IpkiKeIdgeqnNNeDEkpr0wM3ble1DH4VzmdamdjyOkqrYKmd2g4J+6Do5c2JkSJJdhxy3wE9D9dQb7kTRjgjFCRmaVkXy/laHCX6z8sXZ/gAK2BNgeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=KxJDs5kU; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id AF5B060412;
	Sat, 23 Mar 2024 06:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711176578;
	bh=NqzzK0iz78KIPvtZ1w0JtdqyZDW7tedW5UnASOm5zGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KxJDs5kUZdfOQ1L2jFBxRGef4vObdcMlhJiKC2R1m0lQiwuZHEusMKDibM79sSFbT
	 8mjLaNPaxxtvaVcZm+n8s89byOt0z9FO0uGyRfJe90wE1t9ntm81v6rTQLUW5gYbD4
	 PDWscr2BWoXto6AemF++NYujKC8EAM7hy5dAwiPo5A/wMU+t4OM0c0mtlyGE1hVjBa
	 TZCpkxA5e1devphdXOcb3TeL1kQ3uftEzn/RxDMJ/htD6LStfpL5lIOIfi8W7NimuC
	 JaIPkSznA7+8VrNajtNofg/glL1O1XuP/f5Aqv0aNEeiQPrJ83pw99hMWNlKnkWR2h
	 Z1KWIGTU0fmjQ==
Date: Sat, 23 Mar 2024 08:49:25 +0200
From: Tony Lindgren <tony@atomide.com>
To: Nick Bowler <nbowler@draconx.ca>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	regressions@lists.linux.dev, linux-serial@vger.kernel.org
Subject: Re: PROBLEM: Sun Ultra 60 hangs on boot since Linux 6.8
Message-ID: <20240323064925.GE5132@atomide.com>
References: <d84baa5d-a092-3647-8062-ed7081d329d4@draconx.ca>
 <20240322051531.GA5132@atomide.com>
 <d7337014-09ac-8a35-7159-e75ecd2707b6@draconx.ca>
 <20240322064843.GC5132@atomide.com>
 <20240322090657.GD5132@atomide.com>
 <193a134c-f0da-4a45-b45a-a3605f91cfa4@draconx.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <193a134c-f0da-4a45-b45a-a3605f91cfa4@draconx.ca>

* Nick Bowler <nbowler@draconx.ca> [240322 14:12]:
> On 2024-03-22 05:06, Tony Lindgren wrote:
> [...]
> > I can't reproduce this on qemu-system-sparc64, probably as it does not use
> > the sunsab driver.
> > 
> > I noticed something though, I think we need to test for the port device
> > instead for being runtime PM enabled.
> > 
> > Can you please test if the updated patch below make things work again?
> 
> Yes, with the below patch applied on top of 6.8 things are working.

OK great thanks for testing, I'll send out a proper patch.

Regards,

Tony

> > 8< -------------------
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -156,7 +156,7 @@ static void __uart_start(struct uart_state *state)
> >  	 * enabled, serial_port_runtime_resume() calls start_tx() again
> >  	 * after enabling the device.
> >  	 */
> > -	if (pm_runtime_active(&port_dev->dev))
> > +	if (!pm_runtime_enabled(port->dev) || pm_runtime_active(&port_dev->dev))
> >  		port->ops->start_tx(port);
> >  	pm_runtime_mark_last_busy(&port_dev->dev);
> >  	pm_runtime_put_autosuspend(&port_dev->dev)

