Return-Path: <linux-kernel+bounces-55369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD4884BBD5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 890B5B2236D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E66EB67E;
	Tue,  6 Feb 2024 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="V5RRNA1w"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1CD134A5;
	Tue,  6 Feb 2024 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240422; cv=none; b=eS+wffU6lmgWKQD6UI1EbhmfzaMV7WqME/y0KPm5FQWhie4sVOBsQGCogUsQKvlXjaDS1Xtdf8BMxuFYX5Xe/sdegFsuVy8UjxgyDyEb0g18+9XWP9yI/S4BCb6GKr8VTsi4E+1xlmNQX6n2eEUycioxGNCjriqbq2FKKV0L/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240422; c=relaxed/simple;
	bh=ONj84obzGHgSf5EfHx5xWbTOV5/Wriz2WUB7G2FJQks=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A97YcjCV/Jbbkku4oCEsxofa+JtWoXuDaiOEdwW6wxDFhcgj7civpIT2UtIAK8MPX5MJxqrYqtOyC1NuFGyqDQsoKxNjEoBMH/LyZx5l/oeMd3sTKKp6yzZlh66IyqVQ1XMmLLOBjIxIHIMdUGGRc3rL9LP0R3MZGsiVQVNknLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=V5RRNA1w; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id C5CF122A99;
	Tue,  6 Feb 2024 18:26:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1707240410;
	bh=i7mFMnNUf+KOmmvfoXruWWwgYzvxTV6MhK3aSRKty6s=; h=From:To:Subject;
	b=V5RRNA1wB+5ieD7QeTPac0mPyaLkvJiSaAioJ8HR4dpYvysnAE3HJgINPceNz2FJG
	 L97F9h0i8QVTmJEZZkeiqgkLxHJOlvkSLz5n736J7BBQXRhimX7D222dmW6UT8q7P3
	 pjGn8sfYSlRsL7VS0iLXvVEdOeOwMBQuoQnSeb4uXhgBrlYe7gr3weNIw36E9y5+nL
	 3D5pqMy9eQW4BE4f0IWfZJrr2Fu9uGwlbuve8sk7FHd0vS44ws/YerME7XvZl1QvM5
	 tk8jzariLAFVzR8nOtn5hpFBiPNTU07L6f99dhx2NM8V7pzz5x11WUFNDF3pdUqjZL
	 keppLIrANlmxg==
Date: Tue, 6 Feb 2024 18:26:45 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] net: phy: micrel: reset KSZ9x31 when resuming
Message-ID: <20240206172645.GA24848@francesco-nb>
References: <20240109205223.40219-1-wsa+renesas@sang-engineering.com>
 <20240109232838.GA3626@francesco-nb>
 <ZafXQS1_4fHpEzL0@ninjato>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZafXQS1_4fHpEzL0@ninjato>

On Wed, Jan 17, 2024 at 02:33:53PM +0100, Wolfram Sang wrote:
> > > +static int ksz9x31_resume(struct phy_device *phydev)
> > > +{
> > > +	phy_device_reset(phydev, 1);
> > > +	phy_device_reset(phydev, 0);
> > 
> > Is something like that fine?
> > Don't we need to reconfigure the ethernet phy completely on resume
> > if we do reset it? kszphy_config_reset() is taking care of something,
> > but I think that the phy being reset on resume is not handled
> > correctly.
> 
> If the interface is up before suspending, then suspend will assert the
> reset-line. If the interface is disabled before suspending, then close
> will assert the reset line. Deassertion will happen on resume/open.
> 
> So, unless I am overlooking something, my code does not really add
> something new. It only makes sure that the reset line always gets
> asserted before deasserting. Because in the case that the interface has
> never been up before, there is no instance which could assert reset. Or,
> at least, I could not find one.
> 
> Makes sense? Tests work fine here, at least.

What I do not know, is what happen to any configuration that was done to
the phy before.

What if you have disabled gigabit ethernet from auto negotiation before
suspend, it will be enabled again after the phy get out of reset.

Is the ethernet phy subsystem taking care of this? Ensuring that this
configuration is restored into the phy?

I was starting to debug something around this a few days ago, with the
difference that in that case the reset was asserted/de-asserted by the
hardware and the end results was not really the expected one ...

Francesco


