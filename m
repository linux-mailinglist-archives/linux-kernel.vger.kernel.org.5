Return-Path: <linux-kernel+bounces-81590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1148677DF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9751C22E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D14112AAD4;
	Mon, 26 Feb 2024 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LMs55jDI"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877DA129A63
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956523; cv=none; b=irUPLB8KJx1MzVTF5BjMTvmgvCMZBf7HAad5p+BIsKQODjQWBMn+ex+mDdtVmpK1MEULFfMrz5rMLX37yVwTKlJsc6GnpcLxnVbFJaYKDZ965udRxLl7mmmHSWlNtArt2zhohNa9acyzSAxwnmSDfW/Nj/xZpWbTsuCh8uPX32I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956523; c=relaxed/simple;
	bh=2i0LB7lTxQRchprLI/cdRp85vhRM2QpIg6JVzOjaY7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxLOQ2ia6/68DbxJNYSIonbAfx9QDIaL2dQ4ttbgCxkVLpfFX8C6ZuwPPX8J2z9dJc9SjJtGVuIzqNAV6izp9BxhWUDdYygyuXX9sEbgR4NOsgLNmbcA9BzLNW+rVFyUhFqozWJQwK9zeEeS+CSY2BHgVh7HpAkG1P8pQtlmJwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LMs55jDI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=og2C+QX7RdSlbChapFxZDOWO2lHc9kddFG0iUeGvz80=; b=LMs55jDIZ7LjCFTkYTM16KODR0
	rs+IF/4TFSxK38WAgChMtiHyk/uWUpg8ePGc2+PF74DCejyob9Ea1TCJXIgYlGbrnx5pYiSXk5kpB
	9JqGM9d7qm/MTpkNQoaGkECzg27H4EmIwVeHKGdJ/HMvhTj3Z587BwloRthVY7Iz5vjgwFwPOUnwJ
	ogg1G1X5PWCxYWwWeKmTQ0zkc/O1nl7Ocqll5Lo19SuuugjUXfRib5NyjjBklYpYzTczPzwUJLLYe
	XVQTd8KMkMaVfyN/UCWLSq+8Xl6Vc+lG9BE32sKHBq3tnnhYRg5xPd2u2P/URDvCORm/K7YXItTmW
	UMTWwMnA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33800)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rebel-0003jA-15;
	Mon, 26 Feb 2024 14:08:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rebeh-0006U3-UY; Mon, 26 Feb 2024 14:08:31 +0000
Date: Mon, 26 Feb 2024 14:08:31 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Duoming Zhou <duoming@zju.edu.cn>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com
Subject: Re: [PATCH] ARM: mvebu: Add check in coherency.c to prevent null
 pointer dereference
Message-ID: <ZdybX3aZo03iBduX@shell.armlinux.org.uk>
References: <20240225060450.53044-1-duoming@zju.edu.cn>
 <eb036663-2109-4d75-8386-451fa5c34889@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb036663-2109-4d75-8386-451fa5c34889@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 26, 2024 at 02:39:37PM +0100, Andrew Lunn wrote:
> On Sun, Feb 25, 2024 at 02:04:50PM +0800, Duoming Zhou wrote:
> > The kzalloc() in armada_375_380_coherency_init() will return
> > null if the physical memory has run out. As a result, if we
> > dereference the property pointer, the null pointer dereference
> > bug will happen.
> > 
> > This patch adds a check to avoid null pointer dereference.
> > 
> > Fixes: 497a92308af8 ("ARM: mvebu: implement L2/PCIe deadlock workaround")
> > Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> 
> I have to wounder how we can run out of memory here. This code is
> being called from:
> 
> postcore_initcall(coherency_late_init);
> 
> If you look at:
> 
> https://elixir.bootlin.com/linux/latest/source/include/linux/init.h#L299
> 
> You can see that only true kernel core stuff has been called before
> that. If that has consumed all the available memory, something is very
> seriously wrong, and the machine is not going to last another couple
> of milliseconds before it crashes no matter what checking you do.
> 
> So i do wounder if your time could be better spent in other places?

Sadly, it's an easy patch generation target for newbies getting involved
with kernel development. "Find all kzalloc()s and look to see whether
they check for a NULL pointer, if not generate a patch".

This results in people doing exactly that, not looking at the bigger
picture, and not considering whether a NULL pointer could occur there.

The other issue is that if a NULL pointer is returned at this point,
the resulting oops at least allows a developer to debug it (maybe not
a user if the console isn't up.) Adding this patch which basically
just continues the loop silently means that there's no diagnostic that
something went wrong, and it's up to someone to figure out "why does
XYZ no longer work" to figure it out...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

