Return-Path: <linux-kernel+bounces-111733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C17887014
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775671C21B96
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C99F56751;
	Fri, 22 Mar 2024 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qg+gMoCJ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531AD524DF;
	Fri, 22 Mar 2024 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123007; cv=none; b=UyG96QPf29aAb14fWekieLv2/6y2JO7yNahDmz8wDcuXVrWpQgZ2wD3bcUWKzIyywSI4xKrk0BoaM4ppAoWs2VRukPtU1vJopodGrfGbF5ePpNTn9cTgkn1ZHawtQFUN/5Qvk3VZ8qFIOvuAsZNb3koWd0Ocztfj1WOioQXKVFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123007; c=relaxed/simple;
	bh=TN6iWFQ6tks/7SD6PC2cwdtWsPju4N4ielJpFORj08Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFhnEfJ4WD+AjaxguyqJKyARb3tJNm9IMkQes7eCsqAh4ndOtIumL+dHi3zog4h3U9tlHBcahh4jXTZdmf+aRRKuPf91e2O0hiNClZ+uFFtNc1JQvyymHp9IVDphZVeXUKpkAlhYB+vgJWlvoSNio5UwgYvqZ1uZK5Dp+XmNok0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qg+gMoCJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bFqRY/K29N5KY4oWl3hHzhxOBffmPcj/lfWbmVtrjFY=; b=qg+gMoCJCGMDoZ5fvzr4D2pcHv
	fjWbyQ5pmoQok07RbG+aciz9Jd3XbkrxVzu+FOK+4a2p5+LhaAYtwcGBaLrNO0XY+TSK7fiKyjq0Z
	fmYW94VP/KBohx0uO/VCJQXHqPs2/BTmlwBHyx+Ers5NAYxSif2r0FcusvFMA6IjL/2M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rnhFx-00AyDl-8A; Fri, 22 Mar 2024 16:56:33 +0100
Date: Fri, 22 Mar 2024 16:56:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Subject: Re: [PATCH net-next] net: phy: dp8382x: keep WOL setting across
 suspends
Message-ID: <5746c9da-1d45-4d06-a925-4150e680b8ec@lunn.ch>
References: <20240306171446.859750-1-catalin.popescu@leica-geosystems.com>
 <8de1d4e3-6d80-45a5-a638-48451d9b5c15@lunn.ch>
 <b53818a7-66a4-4c7a-b687-efaea6cb9e4e@leica-geosystems.com>
 <f8bfbe80-f308-4b8d-b8f0-5a5f6ca5fa0e@leica-geosystems.com>
 <e9b85f71-f494-4fa6-acce-13ee8e147c21@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9b85f71-f494-4fa6-acce-13ee8e147c21@leica-geosystems.com>

> > It looks like the issue I'm trying to address in this patch is not
> > specific to dp8382x. Right now, depending on if the PHY is reset or not
> > during resume (either through mdio_device reset_gpio/reset_ctrl or
> > phy_driver soft_reset callback), the WOL configuration is either the PHY
> > reset value or the BIOS value. I could still make the patch but it
> > doesn't really make sense to address only dp8382x.

This is an interesting point. soft_reset the driver is in control
off. It can preserve the WoL setting over the soft reset.
A hardware reset is a different matter.

However, if we woke up due to WoL, the PHY never went to sleep, its
state is intact, so why are we doing a hardware reset?

      Andrew


