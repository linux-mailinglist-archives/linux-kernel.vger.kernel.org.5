Return-Path: <linux-kernel+bounces-136026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BFD89CF12
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1B71C23D51
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D45149E04;
	Mon,  8 Apr 2024 23:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OAFxBOvi"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E77017745;
	Mon,  8 Apr 2024 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712620261; cv=none; b=u9gUlGgErf7MoaGqznL2ZwBdwT9k5v2JTObOFBoyeHomHq4rK4zZF8NPBjebQiqTGO7U7ZscOrNnMJp6eS31OMp+SGeK7EAwpoQq0q/UJEoP+Kyu2yL5KnF7zvVuVUW1+BkW4MYccxDgLC/GAhJyzY1kQjMjNC9SSDUAimv871w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712620261; c=relaxed/simple;
	bh=/qXwERbPA80vuw6Cz3GXcV4FMFiq++njEHzcXXx2Cok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgzksxdbsNrDIr7MB7RiEOJ82dO5+vFftXjbivrr5ONbteFlDorhJmdeGcUnUN19pTMcNUfQZ65zY6vOnaTQ9e20sPRbWG8hAiAek4LY8IwRRBoCtNfcIQWBhFNK7bWf4YZMjIEvEKewvYQLVMSGCZCv6UEwauTGaTRjPqSpN70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OAFxBOvi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MkixZwnAYrqv/HAO7RC5V2PGJDgx96oe52MeasZ1GV0=; b=OAFxBOvi6qM/nztw4/0Z8QyH1R
	m9Eyj/E+GE2qxQlBnljmtOvPVUfLfc9gouTwQ2i8oufLwdFhM+ODxSl7a9/0Z+ENMBFhhGbza/ZsD
	mzNWK9lvSJT3stosb6D+6zNJTQQb4DMrKzj2tgk6cnjXLyVrTZBliGAaai3zgVGUxtyk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rtylK-00CWcj-Jh; Tue, 09 Apr 2024 01:50:54 +0200
Date: Tue, 9 Apr 2024 01:50:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: patchwork-bot+netdevbpf@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, linux@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org, christophe.leroy@csgroup.eu,
	herve.codina@bootlin.com, f.fainelli@gmail.com,
	hkallweit1@gmail.com, vladimir.oltean@nxp.com,
	kory.maincent@bootlin.com, jesse.brandeburg@intel.com,
	corbet@lwn.net, kabel@kernel.org, piergiorgio.beruto@gmail.com,
	o.rempel@pengutronix.de, nicveronese@gmail.com, horms@kernel.org,
	mwojtas@chromium.org
Subject: Re: [PATCH net-next v11 00/13] Introduce PHY listing and
 link_topology tracking
Message-ID: <6c5f731e-a21e-4a4c-87a4-9585b2267c9e@lunn.ch>
References: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
 <171242462917.4000.9759453824684907063.git-patchwork-notify@kernel.org>
 <20240408163219.64fe77b3@device-28.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408163219.64fe77b3@device-28.home>

> > Here is the summary with links:
> >   - [net-next,v11,01/13] net: phy: Introduce ethernet link topology representation
> >     https://git.kernel.org/netdev/net-next/c/6916e461e793
> >   - [net-next,v11,02/13] net: sfp: pass the phy_device when disconnecting an sfp module's PHY
> >     https://git.kernel.org/netdev/net-next/c/0ec5ed6c130e
> >   - [net-next,v11,03/13] net: phy: add helpers to handle sfp phy connect/disconnect
> >     https://git.kernel.org/netdev/net-next/c/e75e4e074c44
> >   - [net-next,v11,04/13] net: sfp: Add helper to return the SFP bus name
> >     https://git.kernel.org/netdev/net-next/c/fdd353965b52
> >   - [net-next,v11,05/13] net: ethtool: Allow passing a phy index for some commands
> >     https://git.kernel.org/netdev/net-next/c/841942bc6212
> >   - [net-next,v11,06/13] netlink: specs: add phy-index as a header parameter
> >     (no matching commit)
> >   - [net-next,v11,07/13] net: ethtool: Introduce a command to list PHYs on an interface
> >     (no matching commit)
> >   - [net-next,v11,08/13] netlink: specs: add ethnl PHY_GET command set
> >     (no matching commit)
> >   - [net-next,v11,09/13] net: ethtool: plca: Target the command to the requested PHY
> >     (no matching commit)
> >   - [net-next,v11,10/13] net: ethtool: pse-pd: Target the command to the requested PHY
> >     (no matching commit)
> >   - [net-next,v11,11/13] net: ethtool: cable-test: Target the command to the requested PHY
> >     (no matching commit)
> >   - [net-next,v11,12/13] net: ethtool: strset: Allow querying phy stats by index
> >     (no matching commit)
> >   - [net-next,v11,13/13] Documentation: networking: document phy_link_topology
> >     (no matching commit)
> 
> It looks like commits 6 to 13 didn't make it upstream with (the "no
> matching commit" messages above). Is that expected ?

They are not in net-next, unlike 1-5.

You probably need to repost them.

    Andrew

