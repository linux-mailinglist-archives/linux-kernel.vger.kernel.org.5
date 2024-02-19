Return-Path: <linux-kernel+bounces-71611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7945785A7BD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1CC1C2146F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3B03B7A9;
	Mon, 19 Feb 2024 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ghd1fJnL"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF193984D;
	Mon, 19 Feb 2024 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357476; cv=none; b=Vbc3sTAuHDJEk73ctCpwxpcXMfDOn0PAoSbXXRCfwOJmsagoPMvhCK5m6Cw/vj7xXws8jN5Tt1Dct6fT20d4wSh5H1AfkTFmoxuAkjWfmJzaDyQhEhe0nt1FlGWNWQqAeK6FrSmTAOJwqcDyTTU1FDUm5fZVOTNcTiVETFl8YRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357476; c=relaxed/simple;
	bh=GvrzzQiSIp0fJMCOPW9fDjx5IN1hYWlflJ2j1cj5MBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dw8fL6Diaftcm9JkLPtRgs/RheJchLKeQysejSL9ltuoVMU0Pk15MayMcsh/HofViKHp4p6FRNlM6MuqwrzDaoPXIsitnJ966f36KiIvRxR/UdtueeB7Ta8m1rm7tgOqkfpdTyjbHRwXaPGQVFR0ssLaGQK/H9ZKMxtzMsJc9oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ghd1fJnL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=pH5Y2yN2vdQCTWiEZvOwFMYMekr4MsvZg3ozDbgomZY=; b=gh
	d1fJnLTEaw9+hSiCZeZFiCGvrExh3Yy5rk3LtUUqLb1yNIu3JiogpNRNRtLJ8SQPbI/OUuZ1AnqRg
	O4dybcYLMWSF3XWe1Sd9M1MPZHb2lsx5WwBY6G4/CwYjoDB2yoOz80LRwi/xrdC0uTNmfx7oNHdAX
	zwULkTfhY6WRTm4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rc5oo-008D3A-5R; Mon, 19 Feb 2024 16:44:34 +0100
Date: Mon, 19 Feb 2024 16:44:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v4 05/17] net: pse-pd: Introduce PSE types
 enumeration
Message-ID: <11225a0d-bdc4-459c-9258-c9da217cc89e@lunn.ch>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
 <20240215-feature_poe-v4-5-35bb4c23266c@bootlin.com>
 <20240215105846.6dd48886@kernel.org>
 <20240216104211.2c11d1cc@kmaincent-XPS-13-7390>
 <20240216173638.4bb12af2@kernel.org>
 <20240219160456.0b5e8de3@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219160456.0b5e8de3@kmaincent-XPS-13-7390>

On Mon, Feb 19, 2024 at 04:04:56PM +0100, Köry Maincent wrote:
> On Fri, 16 Feb 2024 17:36:38 -0800
> Jakub Kicinski <kuba@kernel.org> wrote:
> > > > but why the separate header? Is it going to be used in other parts of
> > > > uAPI than just in ethtool?    
> > > 
> > > We might use it in pse core if capabilities between PoE and PoDL differ but
> > > I am not sure about it.
> > > Do you prefer to move it to ethtool header and add prefix ETHTOOL_ to the
> > > enum values?  
> > 
> > I don't know enough to have an opinion :) Whatever you end up doing,
> > it's probably worth documenting the reason for the choice in the commit
> > message?
> 
> Mmh, I am still not sure of the best choice on this. I think I will move it to
> ethtool as you suggested.

kAPI is hard to change. So it is worth thinking about it.

Can you think of any possible kAPI not using ethtool netlink? Its not
going to be ioctl. We generally don't export new things in /sysfs if
we have netlink, etc.

So to me, it is only going to be used be the ethtool API, so i would
follow the usual conventions for ethtool.

   Andrew

