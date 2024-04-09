Return-Path: <linux-kernel+bounces-136347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED9189D2F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD2D284D59
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140187BB13;
	Tue,  9 Apr 2024 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HfAtdVBB"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D860377F3E;
	Tue,  9 Apr 2024 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647343; cv=none; b=HMR65ukWQNNxrl31qReDH2DDNmqJxubGpqufWjYGR6kh3DIeoJ8HMFCIOwzXE3m7OF4DCIbukTU1seoL0Gg8zt9LBf6ImCFDdV/LoRrXmNSFWrkzw0QyeqXj6ULAso/s2BoczGXsKkTYbmhPOs4lVzFYyYtQvidLYoRorXYygI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647343; c=relaxed/simple;
	bh=oHme9/dDZsEdFHN/BY3NRMrHNqDmitKSrLLeYs0Vi3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhLqILTzlBk3gXG7tTb9Lj1iVRt1tX60Vdoqr72Q2ptA4Qz5NpjyHeqpv8F7FC1ibDl1Y7rDByzQQ/YWaHmr7aAhAaQZzxzQmy1EqZ8uhJb21ZW0hRoCOOmFq5To/ls9P/IGqqSmAR9nrBAwogmWa0VLrmwjn15wKDTelySjyRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HfAtdVBB; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E34731BF205;
	Tue,  9 Apr 2024 07:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712647338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pvw9AzoIribB443iVs8M8ZfxBHEw2RZYwtFmzziLEz8=;
	b=HfAtdVBB5KwAiQIu6/bxkPznaIbrpYTCOwFeUypkvB7yRdwsxYfMXUXjAihY5tdy3/ZDBn
	Hb0gA9BrKgW+iUj165fkdqhkRseH12/m/KUoFqSbLw5op09N6gRpcvyDd57/UQOZ02Ma/r
	AYScZVtPMXaiFjNSHJpi/EbIk+7PZDAxGc8AQvFdwi3IgVu6A0JEZ4W4vc0WGd6g4QEHRO
	g/zK5aPs7siIvaEoGqo3Zw5FYCdRDzI3aE7pOao8uK76/YQIvd42EEPSXbp3Zi4RdUpB5p
	GKL5q/DkjmFsEfYYZ7n6dXqcPNDIRRIbnKpA2ALpmbVWJ8Eflfw+OAtehyMDRg==
Date: Tue, 9 Apr 2024 09:22:14 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: patchwork-bot+netdevbpf@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, hkallweit1@gmail.com,
 vladimir.oltean@nxp.com, kory.maincent@bootlin.com,
 jesse.brandeburg@intel.com, corbet@lwn.net, kabel@kernel.org,
 piergiorgio.beruto@gmail.com, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org, mwojtas@chromium.org
Subject: Re: [PATCH net-next v11 00/13] Introduce PHY listing and
 link_topology tracking
Message-ID: <20240409092214.437e5909@device-28.home>
In-Reply-To: <6c5f731e-a21e-4a4c-87a4-9585b2267c9e@lunn.ch>
References: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
	<171242462917.4000.9759453824684907063.git-patchwork-notify@kernel.org>
	<20240408163219.64fe77b3@device-28.home>
	<6c5f731e-a21e-4a4c-87a4-9585b2267c9e@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Tue, 9 Apr 2024 01:50:54 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > > Here is the summary with links:
> > >   - [net-next,v11,01/13] net: phy: Introduce ethernet link topology representation
> > >     https://git.kernel.org/netdev/net-next/c/6916e461e793
> > >   - [net-next,v11,02/13] net: sfp: pass the phy_device when disconnecting an sfp module's PHY
> > >     https://git.kernel.org/netdev/net-next/c/0ec5ed6c130e
> > >   - [net-next,v11,03/13] net: phy: add helpers to handle sfp phy connect/disconnect
> > >     https://git.kernel.org/netdev/net-next/c/e75e4e074c44
> > >   - [net-next,v11,04/13] net: sfp: Add helper to return the SFP bus name
> > >     https://git.kernel.org/netdev/net-next/c/fdd353965b52
> > >   - [net-next,v11,05/13] net: ethtool: Allow passing a phy index for some commands
> > >     https://git.kernel.org/netdev/net-next/c/841942bc6212
> > >   - [net-next,v11,06/13] netlink: specs: add phy-index as a header parameter
> > >     (no matching commit)
> > >   - [net-next,v11,07/13] net: ethtool: Introduce a command to list PHYs on an interface
> > >     (no matching commit)
> > >   - [net-next,v11,08/13] netlink: specs: add ethnl PHY_GET command set
> > >     (no matching commit)
> > >   - [net-next,v11,09/13] net: ethtool: plca: Target the command to the requested PHY
> > >     (no matching commit)
> > >   - [net-next,v11,10/13] net: ethtool: pse-pd: Target the command to the requested PHY
> > >     (no matching commit)
> > >   - [net-next,v11,11/13] net: ethtool: cable-test: Target the command to the requested PHY
> > >     (no matching commit)
> > >   - [net-next,v11,12/13] net: ethtool: strset: Allow querying phy stats by index
> > >     (no matching commit)
> > >   - [net-next,v11,13/13] Documentation: networking: document phy_link_topology
> > >     (no matching commit)  
> > 
> > It looks like commits 6 to 13 didn't make it upstream with (the "no
> > matching commit" messages above). Is that expected ?  
> 
> They are not in net-next, unlike 1-5.
> 
> You probably need to repost them.

I'll repost indeed.

Thanks Andrew BTW for all the reviews !

Maxime

