Return-Path: <linux-kernel+bounces-94374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AFF873E3C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10002858A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CA514404A;
	Wed,  6 Mar 2024 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cS+M8Tc7"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B9D135401;
	Wed,  6 Mar 2024 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709748346; cv=none; b=CqFTRQPG5kkRlua1EAJz/yAfjB7ZrqcJPD/vjRrYU38yW/heeTHSB7oPmAFnvLLFAFzsMwHixtIg6Ja/rdldjbIHn6OTucV+8z/VHDotFBuzPbyieTZQl/DjECS7xcBZm1LZ9KHls2/VQZOHLOZBqX3/FZd7HYYCjlCE8ap2yAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709748346; c=relaxed/simple;
	bh=fWOah0GcpAzkndjnpPl33ZP1z9GHtzVEvCqBK+JKfYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tkBohVrLSrmp8vRQ+px7UCAGf3Pl0XUw5GHyUm6iMq5xML7cHtqeQvS4wdbyD8C6IHp8tV+YCD6WlaAALzZD8qX6MSzkDNZxOQaZarpH2Z23KUP7lNYbwyNim+zxGkwppgs6XI8F1y2/hdI1DOajLfZl6ndl7w+HyLRlMOUneR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cS+M8Tc7; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B18D60005;
	Wed,  6 Mar 2024 18:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709748342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7V4qbK+9Vqy45G8cyaay+aCmjgPiYkcXrXzLVeNz6w=;
	b=cS+M8Tc7OOoISdmknCuzeydsnemFUlj4RLRLCYfUD84udWbpRyf32iiA8m0eC1Phl0Y07m
	8yiIbBmC9AMLt6KJmm/zHDPCYStyprxWIWLQPRMfRdWCffErLbQLCrLtKJoFNcRdCvgKPc
	EiKXFgO8bKaf8EsTsnAHf14XIJwvGbuscQZexRbAia0Vt9f7j5Y9dRWOkOPTX4XQl/TkUM
	b8ifkGb6yMn6xx6vis3LzEft3/tGuDPhgNqDLxUP/6DpcNpixWbkdo1ovVI8vrIjzZfJMq
	2rAEm2LhcxE9IEHRAVZl2WDoH3LPPgviatE8b0JljooaRPqogGdqzZSXaMv1/g==
Date: Wed, 6 Mar 2024 19:05:39 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: John Ernberg <john.ernberg@actia.se>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Russell King
 <linux@armlinux.org.uk>
Subject: Re: [PATCH net v3 2/2] net: fec: Suspend the PHY on probe
Message-ID: <20240306190539.4ab9f369@device-28.home>
In-Reply-To: <20240306133734.4144808-3-john.ernberg@actia.se>
References: <20240306133734.4144808-1-john.ernberg@actia.se>
	<20240306133734.4144808-3-john.ernberg@actia.se>
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

Hello John,

I'm adding Andrew and Russell to the thread as PHY maintainers and
reviewers.

On Wed, 6 Mar 2024 13:37:45 +0000
John Ernberg <john.ernberg@actia.se> wrote:

> Since the power management is now performed by the FEC instead of generic
> pm the PHY will not suspend until the link has been up.
> 
> Therefor suspend it on probe. It will be resumed by {of_,}phy_connect()
> when the link is brought up.
> 
> Since {of_,}phy_connect() and phy_disconnect() will resume and suspend the
> PHY when the link is brought up and down respectively, and phy_stop() and
> phy_start() will resume and suspend the PHY in the suspend-resume paths
> there is no need for any additional calls anywhere.
> 
> Signed-off-by: John Ernberg <john.ernberg@actia.se>

[...]

> @@ -2539,8 +2539,10 @@ static int fec_enet_mii_init(struct platform_device *pdev)
>  	/* find all the PHY devices on the bus and set mac_managed_pm to true */
>  	for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
>  		phydev = mdiobus_get_phy(fep->mii_bus, addr);
> -		if (phydev)
> +		if (phydev) {
>  			phydev->mac_managed_pm = true;
> +			phy_suspend(phydev);
> +		}

I don't think that's correct. here phy_suspend() is being called before
the PHY got attached, so the PHY wasn't initialized at all at that
point (which I guess is your issue as the PHY is still in the state it
was configured into by the bootloader)

Following the code paths, it looks like this works for you because the
PHY you're using has a .suspend callback populated, but for any PHY
that uses the genphy driver, this will do nothing at all (the PHY isn't
yet attached to the genphy ops, therefore genphy_suspend won't be
called).

Best regards,

Maxime

