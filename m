Return-Path: <linux-kernel+bounces-86747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4820986CA27
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2677287822
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724BB7E575;
	Thu, 29 Feb 2024 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uvGqvKAi"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FCF3FB9D;
	Thu, 29 Feb 2024 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212954; cv=none; b=FuVZE+2jVpjZjOHs5uuvKsKwaVjl9Wqc06gDB+jXhJLQvLA/nYozFjH5LDJ6YGXDmcxgju/rWL/DEkfDSOkx3R6xl0sE2TINJKBkrFHdBvXZANhg0fjeghfyi26xGkpzb8ApuDb4KTDOxZH+rrBeLN/ymKnA0oLUT9puaaggEIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212954; c=relaxed/simple;
	bh=AIkGHWsp3IT7slI0BoSA7OlEYcACu9ABuNukN+ai0n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7woVEMXC6J9WZS7si/yyoENYE60zwu+bP9/ob1K2jFiVkRzZXWplcXY2MyIlvLvcU4RpdxhZLbd1MsG48iGDNdve2a0behnAndEk90mvalnTUyV/lZRsJRmbaBvwoU1CucC2d/2u2LxMm7sWWXmAm7QpUWUvvqneptK1loa+us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uvGqvKAi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=WgmtAItz9YHUcyII9kPKDdl0zysykRTiy16vadX3xLg=; b=uv
	GqvKAixzaqfhuxtJdKI4JcyHjGMDt0EJqDxIrLvT6YUfK8Pz2kDrpf3CTVVrmw30hgJr+nGdRUNZl
	AyVE65SvFy+1Eaq8o35ih7eyNEfnjgmbZPx2+NuZ1+XEez5uTJsCmptkltCoOVdjNWExnEeTgZgkB
	fdHxn+IbxD3CbLM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rfgMx-0092Zv-OT; Thu, 29 Feb 2024 14:22:39 +0100
Date: Thu, 29 Feb 2024 14:22:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?iso-8859-1?B?U2FuanXhbiBHYXJj7WEs?= Jorge <Jorge.SanjuanGarcia@duagon.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"s-vadapalli@ti.com" <s-vadapalli@ti.com>,
	"r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
	"rogerq@kernel.org" <rogerq@kernel.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net RESEND] net: ethernet: ti: am65-cpsw: Add
 IFF_UNICAST_FLT flag to port device
Message-ID: <c2faf5d1-2dd2-4046-a5f7-998dee252c6b@lunn.ch>
References: <20240228111300.2516590-1-jorge.sanjuangarcia@duagon.com>
 <20240228200516.1166a097@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228200516.1166a097@kernel.org>

On Wed, Feb 28, 2024 at 08:05:16PM -0800, Jakub Kicinski wrote:
> On Wed, 28 Feb 2024 11:13:23 +0000 Sanjuán García, Jorge wrote:
> > Since commit 8940e6b669ca ("net: dsa: avoid call to __dev_set_promiscuity()
> > while rtnl_mutex isn't held") when conecting one of this switch's port
> > to a DSA switch as the conduit interface, the network interface is set to
> > promiscuous mode by default and cannot be set to not promiscuous mode again
> > from userspace. The reason for this is that the cpsw ports net devices
> > do not have the flag IFF_UNICAST_FLT set in their private flags.
> > 
> > The cpsw switch should be able to set not promiscuous mode as otherwise
> > a '1' is written to bit ALE_PORT_MACONLY_CAF which makes ethernet frames
> > get an additional VLAN tag when entering the port connected to the DSA
> > switch. Setting the IFF_UNICAST_FLT flag to all ports allows us to have
> > the conduit interface on the DSA subsystem set as not promiscuous.
> 
> It doesn't look like am65-cpsw-nuss supports unicast filtering, 
> tho, does it? So we're lying about support to work around some 
> CPSW weirdness (additional VLAN tag thing)?

I considered that as well, it is also not clear to me if this actually
works. At minimum the description needs additions.

The interesting thing here is, this is a switch port. If there is an
entry in the FDB, that is as good as a unicast filter.

Now, i've no idea if this actually works. This is more Vladimirs
area. What especially needs testing is a port not a member of a
bridge, when you don't really expect there to be any FDB entries.

	Andrew


