Return-Path: <linux-kernel+bounces-48208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8D884589A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E1028ABBD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000445D48D;
	Thu,  1 Feb 2024 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BOlPkzmo"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0875D46A;
	Thu,  1 Feb 2024 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793152; cv=none; b=uIH1Bx5DjrZ6pNitypEge1phvBiDfIwcDZmvZAaxJDx9KGJUgV1YdzEQAN8JmiLCOS2Ngp+eJ87A2ldwhy5c/NoZyD9z/tOjUJ1jxZ9ZM9XiyJIm3rElrW87zaePIDKQZkhF68V62qztENQmQPJnUk7wnnmUiwMd3buHal30GEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793152; c=relaxed/simple;
	bh=/I3LOE7Iy4GWVmhyKaKeXXQqboCCKJZr0DzFVtVFQ18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkobEfbp95DZECJy0cfUhsDFML3bAQ696BQ8znyF4iQ1JBJnYyuD3NvMYD2iui9gFWPYsTV/AMNy6Pbh9zX0MF7oOQ5y3MhV0WF/iZrthQw4Os8ZaH6dnEutRSt647SFCdUaBUrMmoUU6ve2xo3IiyAJ4xl4rBRZL21tewyPCro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BOlPkzmo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ourWqt0U9KzwsZ13Pf+R3eqNLW9t0wZoaANlJWDjL/4=; b=BO
	lPkzmoaz/mHfd0lTIMD5LjQQgNNUR2u1V5xfpsGvCHutTAqG1dc5H98ZLd8WIOQaMznZP2bcASWuq
	r2Kp34QdGhzoMvAxrbMYGPaQ21eCZbJfzD6XsJl4pYZSK3rKRpLAz5gNUSRDmpsT1a3/VKLUNueSc
	1EDowPp1gKvBpTg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVWrO-006fvY-KU; Thu, 01 Feb 2024 14:12:06 +0100
Date: Thu, 1 Feb 2024 14:12:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
	conor+dt@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	git@amd.com
Subject: Re: [PATCH net-next 2/3] dt-bindings: net: cdns,macb: Add
 wol-arp-packet property
Message-ID: <fb8f56b1-c961-478d-ac3a-8136408771d3@lunn.ch>
References: <20240130104845.3995341-1-vineeth.karumanchi@amd.com>
 <20240130104845.3995341-3-vineeth.karumanchi@amd.com>
 <824aad4d-6b05-4641-b75d-ceaa08b0a4e8@lunn.ch>
 <09ce2e81-01cc-431f-8acb-076a54e5a7e6@amd.com>
 <9b4a2c23-5a96-45eb-9bdf-cefc99f25fec@lunn.ch>
 <7a063832-e1b5-42df-92cf-66486d4feecb@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a063832-e1b5-42df-92cf-66486d4feecb@amd.com>

On Thu, Feb 01, 2024 at 12:11:15PM +0530, Vineeth Karumanchi wrote:
> Hi Andrew, Krzysztof,
> 
> 
> 
> On 31/01/24 6:48 pm, Andrew Lunn wrote:
> > On Wed, Jan 31, 2024 at 01:09:19PM +0530, Vineeth Karumanchi wrote:
> > > Hi Andrew,
> > > 
> > > 
> > > On 31/01/24 6:56 am, Andrew Lunn wrote:
> > > > On Tue, Jan 30, 2024 at 04:18:44PM +0530, Vineeth Karumanchi wrote:
> > > > > "wol-arp-packet" property enables WOL with ARP packet.
> > > > > It is an extension to "magic-packet for WOL.
> > > > 
> > > > It not clear why this is needed. Is this not a standard feature of the
> > > > IP? Is there no hardware bit indicating the capability?
> > > > 
> > > 
> > > WOL via both ARP and Magic packet is supported by the IP version on ZU+ and
> > > Versal. However, user can choose which type of packet to recognize as a WOL
> > > event - magic packet or ARP.
> > 
> > ethtool says:
> > 
> >             wol p|u|m|b|a|g|s|f|d...
> >                    Sets Wake-on-LAN options.  Not all devices support this.  The argument to this  option  is  a
> >                    string of characters specifying which options to enable.
> >                    p   Wake on PHY activity
> >                    u   Wake on unicast messages
> >                    m   Wake on multicast messages
> >                    b   Wake on broadcast messages
> >                    a   Wake on ARP
> >                    g   Wake on MagicPacket™
> >                    s   Enable SecureOn™ password for MagicPacket™
> >                    f   Wake on filter(s)
> >                    d   Disable  (wake  on  nothing).  This option
> >                        clears all previous options.
> > 
> > So why do we need a DT property?
> > 
> 
> The earlier implementation of WOL (magic-packet) was using DT property.
> We added one more packet type using DT property to be in-line with the
> earlier implementation.

I can understand that. It also suggests we did a bad job reviewing
that patch, and should of rejected it. But it was added a long time
ago, and we were less strict back then.

> 
> However, I echo with you that this feature should be in driver (CAPS).
> We will re-work the implementation with the below flow:
> 
> - Add MACB_CAPS_WOL capability to the supported platforms
> - Advertise supported WOL packet types based on the CAPS in ethtool.
> - Users can set packet type using ethtool.

Yes, this sounds good. Maybe add to that, mark magic-packet
deprecated, and a comment that ethtool should be used instead.

Thanks
	Andrew

