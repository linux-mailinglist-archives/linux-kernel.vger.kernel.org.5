Return-Path: <linux-kernel+bounces-38160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B8883BBC5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1085F2848ED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F74175BC;
	Thu, 25 Jan 2024 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VR9hxFam"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47C417588;
	Thu, 25 Jan 2024 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170961; cv=none; b=bUUMdRB+dt5RUZRjz7Ri82R9U/9lH3DPvFbsr93Y2HLtSZGSc+UhBuqWhj7HRq4kROiDxKo3+87eQDuTtSIg3IoOTY1L/Fm6131JGX/ZAZ+FLCmu0w+AFqGmH2NdHMlt1MTX8/Mmn561z+SylnOEr4yeXkfGmvdqsWnuwj+NC3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170961; c=relaxed/simple;
	bh=kzl7T5i340HyxSsb6EuzdgzNJ2C7Gyw5WoLYTyLp2Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=irK2/ZNfkbwksKfv0hwwS659eUh3hRysN8UIoTogzf8mDUKufKqkH9PsurEIXg762rtC9k6GfTd2j2EvJacO4+vSPQnorhRq/z6T86TCSvPMAG4AGeUHBucTXbwXN0zyLPB5jqPp/0kS8yuLv/x/iCH4KKHq5fyhVosJLsGKXIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VR9hxFam; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8423C1BF20B;
	Thu, 25 Jan 2024 08:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706170956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mfTST55I42VzaDvOMmCyzlbKGUX1F47dp8ViDve0Oew=;
	b=VR9hxFamSIyqRfpdhMXd39umlqM0aoECc+duJd6cJREz0HlQyGlGRtsmdqXr/S2ezWfgy2
	Rb4vMC7/Z1BdyaTxxmQZgA0fQyxbRnTIrKA5xDG5ilbNbIBFBPg27lkYT3c8qjySCWG6QA
	oAaYT8Qh9NO6qFc+/Gc/Eq6sjHVG+cb8nI8b05agZuxtr1dK6sYeEknmLOVxIPqZ28hS0r
	rkzjDwo7JCfe7YvWUS5Hu9eiciJGL+YBj3edR3MVpgD8qDuAYjWxX/UKZrPR9EMtzlOFy2
	/mrkfdCYP5Z0093MTysFglWyp7SEGR2kcQ6bsC8XuTV1/NyGIIGxOv6ZkkHWWg==
Date: Thu, 25 Jan 2024 09:22:25 +0100
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
Message-ID: <20240125092225.45cdaa09@device-28.home>
In-Reply-To: <1092441f-c347-4f61-8405-7cc8a07d5850@lunn.ch>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
	<20231221180047.1924733-8-maxime.chevallier@bootlin.com>
	<20240104153401.08ff9809@kernel.org>
	<20240105104311.03a35622@device-28.home>
	<2c955f94-7c95-4f66-b739-f0967ec9c171@lunn.ch>
	<20240124145033.1c711fd1@device-28.home>
	<1092441f-c347-4f61-8405-7cc8a07d5850@lunn.ch>
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

On Wed, 24 Jan 2024 17:54:53 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > > Another option might be to add PHY support to netdevsim. Add a debugfs
> > > interface to allow you to create arbitrary PHY topologies? You can
> > > then even add a test script.  
> > 
> > Sorry for the delayed answer, I just took a few hours to give it a try,
> > and I was able to spin some very basic PHY support for the netdevsim,
> > allowing to attach arbitrary instances of fixed_phy devices. I can
> > therefore use that as a mean of testing the dump operation, I'll try to
> > include that in the next iteration, that should pave the way for some
> > testability of more PHY stuff hopefully.  
> 
> Great that you looked at this.
> 
> FYI: Jakub would like to see changes to netdevsim accompanied with
> self tests making you of the features you add. There is also now a
> build bot running the self tests against net-next, so these tests
> should get run quite frequently.

No problem, I'll include these as well.

I do face a problem with fixed_phy though now that I've played around
with it. As fixed_phys share the same global MDIO bus, what can happen
is that netdevsim-registered PHYs can starve the dummy MDIO bus by
exhausting all 32 mdio addresses, preventing real interfaces from
getting their own fixed-phy instance.

I'll probably register a dedicated mdio bus per netdevsim (or even
per-phy, so that we can imagine controling the returned register
values), let's see how it goes.

Thanks,

Maxime

