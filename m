Return-Path: <linux-kernel+bounces-46482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD5E844059
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F5B1F278D3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5E57BB03;
	Wed, 31 Jan 2024 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AjkAfiqP"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111BD7AE47;
	Wed, 31 Jan 2024 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707136; cv=none; b=GFwksIDjXQw4KGcZjOZY2nJLoSHxFsRPtHtYDcwws/HLg94SQO5McGg6EgKfW/hePmpllXS3K1YvRISOGCooqFPXDnS0fyG/wnsryO8LPBROR/20nJuez3QML784yG8Z32WBrSDlG5wpOKtwiF13Rau5R3eWaJWP2/X09Y1eobU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707136; c=relaxed/simple;
	bh=wRggTsb/WovzuI1/As/8oeTbjExf7tTdMkistmGNdps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U36LFLNEH2eGvcWUE7cejRE7QaePG5DsLYsZD52qgcO7g/QOC6cqR8Zuczjh9bfBwg7Q8ycPJxGz/kfw0lihke4+semfb3P5WqpOE6NHW4sqgrOawF5FAYdS9v16TQh8WAwMCvXhxueXUF8hxvBCzGpUj4c8DsFDZQF+hubHSkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AjkAfiqP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=A3kUnJ8zRrCzneQgYKTrdXh+ZpHWXlwyD/5ZUpXOX74=; b=Aj
	kAfiqPczc+0L8YggHPVm8TlUISFlilDfxMFFKWKexORqtKfB7tyffRsu2JkCuo0plZNa5O/YOIpjw
	emCetMLzE8Y32+ZhyKPATBscMpbf6er9GsHmk8Mgr9xCyV/Dkg/ukmThg91qPWSby8vhFdhBzYscx
	M5TJuA2HCqR7+D0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVAUB-006a4i-Jc; Wed, 31 Jan 2024 14:18:39 +0100
Date: Wed, 31 Jan 2024 14:18:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	git@amd.com
Subject: Re: [PATCH net-next 2/3] dt-bindings: net: cdns,macb: Add
 wol-arp-packet property
Message-ID: <9b4a2c23-5a96-45eb-9bdf-cefc99f25fec@lunn.ch>
References: <20240130104845.3995341-1-vineeth.karumanchi@amd.com>
 <20240130104845.3995341-3-vineeth.karumanchi@amd.com>
 <824aad4d-6b05-4641-b75d-ceaa08b0a4e8@lunn.ch>
 <09ce2e81-01cc-431f-8acb-076a54e5a7e6@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09ce2e81-01cc-431f-8acb-076a54e5a7e6@amd.com>

On Wed, Jan 31, 2024 at 01:09:19PM +0530, Vineeth Karumanchi wrote:
> Hi Andrew,
> 
> 
> On 31/01/24 6:56 am, Andrew Lunn wrote:
> > On Tue, Jan 30, 2024 at 04:18:44PM +0530, Vineeth Karumanchi wrote:
> > > "wol-arp-packet" property enables WOL with ARP packet.
> > > It is an extension to "magic-packet for WOL.
> > 
> > It not clear why this is needed. Is this not a standard feature of the
> > IP? Is there no hardware bit indicating the capability?
> > 
> 
> WOL via both ARP and Magic packet is supported by the IP version on ZU+ and
> Versal. However, user can choose which type of packet to recognize as a WOL
> event - magic packet or ARP.

ethtool says:

           wol p|u|m|b|a|g|s|f|d...
                  Sets Wake-on-LAN options.  Not all devices support this.  The argument to this  option  is  a
                  string of characters specifying which options to enable.
                  p   Wake on PHY activity
                  u   Wake on unicast messages
                  m   Wake on multicast messages
                  b   Wake on broadcast messages
                  a   Wake on ARP
                  g   Wake on MagicPacket™
                  s   Enable SecureOn™ password for MagicPacket™
                  f   Wake on filter(s)
                  d   Disable  (wake  on  nothing).  This option
                      clears all previous options.

So why do we need a DT property?

	Andrew

