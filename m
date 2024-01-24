Return-Path: <linux-kernel+bounces-37077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B8983AB2B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFD72B23D92
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F2A77F3E;
	Wed, 24 Jan 2024 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BEXRqT/F"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F304A77F25;
	Wed, 24 Jan 2024 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104246; cv=none; b=nhplZCg98m236u1rrwf5jmpolw1FVXR1nlprf1XSKIhdl6fii2iAErXFpqUXareAv/y59VnEYGe7oyXJxiGutKI19j/50j4b6BrzAPrZtoy4EGqRYUe2rGNg4c8M5V27AVQDT9/t47KSt3V5EXBxKmKds4bSwU0idd1Zi33+KQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104246; c=relaxed/simple;
	bh=qv1XCCmrpEelMNYD86CEC9P5gBGzAUCiISJyBzk4RZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gs/yf+mIX264q6gN7uFM8OJaX5SGvn+xXXzbCwOs6ExmQOXlFZKfFBVfN/Wzykt97nfJlnOgkD5lk0qTPIRiJNuY5a161wqF67U6D1tTNYXyTqVAI30uYzGTwje5JEllUUPKvmlpNVuS5On0hRezeTNfFroJqXh6Etca9UkBId0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BEXRqT/F; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F0F91C0003;
	Wed, 24 Jan 2024 13:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706104236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aj6ZQfg/DQIXs3PgkhqXH6sZRgoGEcYx3M5juw4r4UA=;
	b=BEXRqT/FMI6b2tciHLBA1R9XyZWtEnOWl2cS45kZukK1HrYvVzy2FJ/dx8HjzXtGXyviVm
	mdMuItxi5TjLPLloMGqUV4Kif3QcnfsTbt/mXf+uvMoJ8lWW2y6s0HYUKAX9ixB7oRgxiS
	KAJ9cCI+cHZi+myA2AdFsgB8ldZZVQR+gPKhrLqFBn8iXV2gt9gNdLQ97u+Kc180/FexiN
	FSq95iZ9m+CGZ8PFOhpIVe5SRtIQ0IhlhserDqm+TnAGcLvvBiPJonqOro4TuROqyVWT5U
	XVBtHDxzbWKQkX4PdGRtMu6EqTXAQ62sNc7r5EKqZPRz25NyPaXzE1TVf5utHQ==
Date: Wed, 24 Jan 2024 14:50:33 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Jonathan Corbet <corbet@lwn.net>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v5 07/13] net: ethtool: Introduce a command to
 list PHYs on an interface
Message-ID: <20240124145033.1c711fd1@device-28.home>
In-Reply-To: <2c955f94-7c95-4f66-b739-f0967ec9c171@lunn.ch>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
	<20231221180047.1924733-8-maxime.chevallier@bootlin.com>
	<20240104153401.08ff9809@kernel.org>
	<20240105104311.03a35622@device-28.home>
	<2c955f94-7c95-4f66-b739-f0967ec9c171@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Andrew,

On Fri, 5 Jan 2024 14:17:10 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > > > +int ethnl_phy_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> > > > +{
> > > > +	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
> > > > +	struct net *net = sock_net(skb->sk);
> > > > +	unsigned long ifindex = 1;    
> > > 
> > > This doesn't look right, if dump gets full you gotta pick up
> > > when previous call left off.  
> > 
> > I wasn't aware that this was the expected DUMP behaviour. So I should
> > keep track of the last dev and last phy_index dumped in the dump_ctx I
> > guess ? I'm not sure how I'm going to test this though, I only have
> > devices with at most 2 PHYs :(  
> 
> At a guess....
> 
> You are supposed to dump until you are out of space in the buffer. You
> then return what you have, and expect another call so you can continue
> with the rest.
> 
> Rather than fill the buffer, just hack the code to only put in a
> single PHY, and then return with the same condition of a full
> buffer. Hopefully you should get a second call, and you can then test
> your logic for picking up from where you left off.
> 
> Another option might be to add PHY support to netdevsim. Add a debugfs
> interface to allow you to create arbitrary PHY topologies? You can
> then even add a test script.

Sorry for the delayed answer, I just took a few hours to give it a try,
and I was able to spin some very basic PHY support for the netdevsim,
allowing to attach arbitrary instances of fixed_phy devices. I can
therefore use that as a mean of testing the dump operation, I'll try to
include that in the next iteration, that should pave the way for some
testability of more PHY stuff hopefully.

Thanks for the suggestion,

Maxime

