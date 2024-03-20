Return-Path: <linux-kernel+bounces-109193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D53B8815F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE03A28124E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D9C69E04;
	Wed, 20 Mar 2024 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="J4MviXSq"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA69628;
	Wed, 20 Mar 2024 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710953681; cv=none; b=Z5zXpLUbDNOOz1Lt+lD5Ho+7dIzO+REAofYU1TONbgK4kF9QcIFN/sFU5wttZvquRPA6EGUM53LqOQHgrdHH5JQC98RenKe6cBn1VtrY6MOLXEslKuVYXI8nmGzAc0p/irWfaqr7+ZkQZiM8v+uuiDJ7fnN7Fb7EcapwaoJkttU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710953681; c=relaxed/simple;
	bh=hVvpQc/myDQMdBDigQy4sHR6Pca16XS2T42ZMishL8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIdoslfBuJ1wh7Wy1usu1cdl7ity5KZpbYpipwi81rHlNJd3andVQH3vBNiohCKJe/+w1GBHdwFQh/VlTNlYkeSevNPbmZAGsy5WpN8RYofInnNIuyBEkD5wkRHcGu7ePVJ1iqLEggnj1ECWF8voBTRVz9RvJpb6RUAJ+XFcp/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=J4MviXSq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/TsYsIa12qttkUZur28k+MhSiJXF4P4wa++ZZvt18t0=; b=J4MviXSqbprojtwtHefqABgh5u
	4Ti8LCtni5WZ2M57LsHsKIOYsRItoy0mRGDt0aWk6ATO7bxtiJRP0aWZq9+i6ymb6iRSuZXg+UcPJ
	ckqIMRYn8m55LUyfrVbHYUq8miwjn12X1m/r5HuGQnXL3StggWA/t2YLNbiv6wz2d/mDStskU7dnc
	RGcmIkyh4oe8BK7D10qXrdWPDpP5pil66efitGJY4xaTK8ll1CUr64mhqHbhUawXHgEW+sbtSz831
	IqBYIsql2fFa7ywIiCmAEVz3vHZot7w2462CFcD7QcnBmztaMWQsHbLQkSTyXr/EHzlAdAAi3ksh+
	tnuzMiJQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48652)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rmzCs-0006je-0V;
	Wed, 20 Mar 2024 16:54:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rmzCo-0002pw-U8; Wed, 20 Mar 2024 16:54:22 +0000
Date: Wed, 20 Mar 2024 16:54:22 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: John Ernberg <john.ernberg@actia.se>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net v3 2/2] net: fec: Suspend the PHY on probe
Message-ID: <ZfsUvm9YC5O7il3h@shell.armlinux.org.uk>
References: <20240306133734.4144808-1-john.ernberg@actia.se>
 <20240306133734.4144808-3-john.ernberg@actia.se>
 <20240306190539.4ab9f369@device-28.home>
 <9490ed31-dede-4a14-9c62-5ef83e30593a@actia.se>
 <ZflSE8AaYLE3Ri8L@shell.armlinux.org.uk>
 <f89bec78-0dae-4518-a461-2e64a3dfb9fc@actia.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f89bec78-0dae-4518-a461-2e64a3dfb9fc@actia.se>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 20, 2024 at 03:25:54PM +0000, John Ernberg wrote:
> Hi Russel,

Growl. Hi Peter.

> What we really want is the PHY to be suspended on suspend to RAM 
> regardless of us having had an initial link up or not.

So what you're asking is for the PHY to be suspended when the system
is entering suspend, which is a long time after the system booted and
thus phy_probe() was called, and could be some time before the system
resumes.

I'm not sure what the relevance is of phy_probe() that was brought up
previously then.

> This worked prior to 4c0d2e96ba05 ("net: phy: consider that suspend2ram 
> may cut
> off PHY power") which was added in Linux 5.11, and 557d5dc83f68 ("net: 
> fec: use
> mac-managed PHY PM") which was added in Linux 5.12.

Looking at the former commit, that looks to me like it is only
affecting the resume paths, not the suspend paths, so wouldn't have
any impact itself on what happens when suspend happens.

The latter commit states that it is a work around for an issue with a
particular PHY. What happens if you revert just this commit, does your
problem then go away?

Also, please clarify. It seems that you are reporting a regression -
it used to work for you prior to 557d5dc83f68, but 557d5dc83f68 stops
it working for you?

> Since FEC requires mac_managed_pm the generic PM suspend-resume paths 
> are not
> taken. The resume sequencing with generic PM has been broken with the 
> FEC since
> generic PM of the mdio bus was added, as the FEC will do phy_start() 
> (via FEC
> resume) and then generic PM runs phy_init_hw() via mdio bus resume 
> (previously:
> less damaging phy_resume()) due to how the FEC IP block works.

That suggests that even with 557d5dc83f68 reverted, it's broken.
Digging into the history, what you're referring to dates from January
2016, so are you reporting a regression that occured 8 _years_ ago,
at which point I'd question why it's taken 8 years.

Given the time that has passed, I don't think reverting commits is
a sane approach. Quite what the right solution is though, I'm not
sure.

From the description and the commits pointed to, I just don't see
that there is anything that could've changed with respect to the first
boot - if that has changed, then I think more research into what caused
it is needed.

If it's the subsequent state after a suspend-resume cycle, then yes,
I would agree that its possible that these changes broke this for you.
Would clearing ndev->phydev->mac_managed_pm just before
phy_disconnect() in fec_enet_close() fix it for you, so the suspend/
resume paths for the PHY get used when the network interface is down?

Maybe, however, that's something that should happen in any case inside
phylib on phy_disconnect() as a matter of course, since the PHY will
at that point be no longer under the control of the network driver for
PM purposes. Could you give this idea a try please?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

