Return-Path: <linux-kernel+bounces-157189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572278B0E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142E72816C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C385C15FA81;
	Wed, 24 Apr 2024 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i1+OIBrB"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985ED15FA6A;
	Wed, 24 Apr 2024 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972435; cv=none; b=X2MMYVUXdIcoMK14lM16VIGKJKi/Pat7TzztQx0KSzo5hTgj0gUQSCPlukWPZYXEeRMeTWwm3WN39KrUhL8IxBay5H4s3lSFbl13Bcm15ej+r2LYyEKPHkbohFxFb6gwTO2P2dJOb4fAvR9ruHrqXzf5ebjYcbb66yq7CJ284uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972435; c=relaxed/simple;
	bh=4h+g4dBxEM0VKp0CC7XVGQq2HCwTkO2JIaxOIAm2rmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQp+85rlqfuVzklI+DXnGYlXNeCkhmu2Wf96E5rTp5CRBtoF5RqfWD2aheVTpCUEOiFY9Fb3ir+SfUHssezwCFMlerucN1ZK6qEEHzLKwYDglk1csLfAtdbiE91F0wg832IrCczDA6CIlBVq7LaTM4lbMmSMaX2Taw34BlQaOLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=i1+OIBrB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GfiyYkDz6Qviubs8oqY/XRZBxZ3YPfixcDSapFKLXdc=; b=i1+OIBrBF73IWWiLeueR7FP3EJ
	9Fq0olZLFhRmWwsWRrNmMFO/KSspMtR+EIVQvNtTx8ltWcXEZeymxUOv6jNNZ4QzyXvuyy66h81dv
	qcjF0IQp3wZoiWseUGQt2cFLjtrvmtf3R2nkKweTpd1Oll7xryFjRWnGHY/WyuqKGksM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzeWW-00Dpi8-GU; Wed, 24 Apr 2024 17:27:04 +0200
Date: Wed, 24 Apr 2024 17:27:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH net-next] net: phy: marvell: add support for MV88E6020
 internal PHYs
Message-ID: <5ff26668-b96c-44ae-b9d8-4807b6a1a4c0@lunn.ch>
References: <20240424121022.160920-1-matthias.schiffer@ew.tq-group.com>
 <19c4b8da-203e-4a81-9531-9ba4a4f750fd@lunn.ch>
 <1cb8bafb44075858221b31c056d75a40d7ba2ee1.camel@ew.tq-group.com>
 <64dbfe14-e777-49e2-ab7d-ec6fa517a8f1@lunn.ch>
 <5426c24a215b363e7b9b03a97d023d2e29b6a0a7.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5426c24a215b363e7b9b03a97d023d2e29b6a0a7.camel@ew.tq-group.com>

On Wed, Apr 24, 2024 at 04:57:24PM +0200, Matthias Schiffer wrote:
> On Wed, 2024-04-24 at 16:52 +0200, Andrew Lunn wrote:
> > > We currently do not override the PHY ID for this family in the DSA
> > > driver - my understanding was that this is only necessary for
> > > switches that don't provide a usable PHY ID at all. As I have no
> > > idea if this PHY ID works for the whole family or just the single
> > > switch, I went with the more specific naming here.
> > 
> > The 'broken' switches have the Marvell OUI, but no module number. From
> > your description it sounds like the 6250 is the same?
> > 
> 
> No, the PHYs have a proper ID, 0x01410db0. The "Functional Spec" for the 88E6020 switch family gives
> us the 0x01410c00 part, but the lower 10 bits are undocumented ("reserved")

Great, Marvell breaking things in new ways :-(

It would be so much nicer if they broke things consistently.

> and I don't know if they differ for each individual switch of the
> family, as I only have a 88E6020 here.

Marvell are pretty consistent within a family. So i expect this same
ID is used for them all. However, i would use MARVELL_PHY_ID_MASK so
the lower nibble is ignored.

Please document these assumptions in the commit message.

       Andrew

