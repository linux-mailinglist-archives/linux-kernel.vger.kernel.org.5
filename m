Return-Path: <linux-kernel+bounces-50283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E568476F1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6E61F2639E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5D214D44D;
	Fri,  2 Feb 2024 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JbwzFcza"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADDE14C5AC;
	Fri,  2 Feb 2024 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896901; cv=none; b=pf4sxoPVCcl6KZoMQ3giGWSPWZOz1bA2mZ5V5qk+ekRH8jSrPj2fRo+fFWhTj00oTInpKbe5Nu/ZEH0k+g9sjgumlNjRh21Q/NbPOWuX9pJTvHU7ApeNAUO3s9aSVfK8UAoZv4WGfQU9KhyuxEfEe75RhQ9gqMwdcAEeG11kak8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896901; c=relaxed/simple;
	bh=dDn+aWUuoRcqfpCGw1CQxwbYqg/MHvauHFd77pkNr7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWTTln5f8qojWajYSexdcXCcE9hco2c1ByeqCyqBKW4zlColFwN7h7qLTYQrRPr0qL/k8n6zMeyZbVpBHykvuNh7EyngmkfwDVljjqndvusiVw6P25OCukrD73HckLEBs0LsKqZezfyPlug0Sqi6RYH4y/rDfvE2cGASoijKvok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JbwzFcza; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jaqvolM8hY9hqGHXJM+uBNaupLSVthfennwbKzMgO38=; b=JbwzFczaQ8Wg99MTa5hUteskkn
	iuI4EcKW3f5S+u664dlKPBlNJkYLgXNyL6cKcD9raQKCwDyJD898k+S8S23S8N3kZ2jLce8VQVkZH
	j/843N8Gu7BARrQdReyDMCrJgOcxyQ5J8m2ZaebL9zXJrhs4PMEa2vRicvbC+m+s1UTlJM1rdlXY2
	diYXyKThAvcDESCJ2rtYlS3BHzAx+wyGfDBc4YeTOWUvb7CZOQ6o3wMDTZWzI18zzEJ0tTSNHMIPr
	/q8qQBIbxamhzuan1rg7dzX6BuuJonTbhefaGgQZJaqLI0W1+rnH6UI4MxX6NBs0VsokvrxuQK5sx
	KwuBW/Kg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35212)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rVxr4-0006K5-04;
	Fri, 02 Feb 2024 18:01:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rVxr1-0008V4-HX; Fri, 02 Feb 2024 18:01:31 +0000
Date: Fri, 2 Feb 2024 18:01:31 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sergio Palumbo <palumbo.ser@outlook.it>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for OEM DFP-34X-2C2 GPON
 ONU SFP
Message-ID: <Zb0t+zKHx+0wTXH5@shell.armlinux.org.uk>
References: <AS1PR03MB8189AD85CEB6E139F27307D3827F2@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZbZn8oCiyc1aNPuW@shell.armlinux.org.uk>
 <AS1PR03MB8189B99C360FB403B8A0DD6882422@AS1PR03MB8189.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1PR03MB8189B99C360FB403B8A0DD6882422@AS1PR03MB8189.eurprd03.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 02, 2024 at 06:41:51PM +0100, Sergio Palumbo wrote:
> Dear Russell,
> sorry for the indenting. I will no longer use indenting in future postings.
> As explained in the description setting up the module via telnet with
> LAN_SDS_MODE=6 puts the module in 2500X autonegotiating mode.

Okay, so this requires manual configuration to switch the module into
2500base-X.

> Without applying the patch the module shows up to linux at 1000X
> because the EEPROM is not correctly reporting the 2500X speeds.

Okay, so in its default as-new state without reconfiguring the module,
it reports 1000base-X and Linux drives it as such. This sounds fine.

> Ethtool lines in the description repporting only 1000X and host
> connecting only at 1000X.

That would be expected.

> After the quirk as you can see from the ethtool lines I put in the
> description the module shows up to linux with both speeds 1000X and 2500X.

Yes, adding the quirk will have that effect, but it will also have the
effect that we will choose 2500base-X for host interfaces that support
it, whether or not the module has been reconfigured to operate at
2500base-X. This will result in a mismatch between the module and the
host, and the link will not come up.

> According to the above if the host has the ability to connect at 2500X
> the module is connecting at 2500X, if the host has the ability to connect
> at 1000X only it will connect at 1000X.

The current situation:

Host supports		Module		Mode		Functional
1000base-X		default		1000base-X	Yes
1000base-X		LAN_SDS_MODE=6	1000base-X	No
1000base-X + 2500base-X	default		1000base-X	Yes	***
1000base-X + 2500base-X	LAN_SDS_MODE=6	1000base-X	No

With the quirk:
Host supports		Module		Mode		Functional
1000base-X		default		1000base-X	Yes
1000base-X		LAN_SDS_MODE=6	1000base-X	No
1000base-X + 2500base-X	default		2500base-X	No	***
1000base-X + 2500base-X	LAN_SDS_MODE=6	2500base-X	Yes

The lines marked "***" are what I'm concerned about - by adding this
quirk, it has the effect of trading one working configuration (the
one where the module is in its default factory configuration) for one
which requires special configuration of the module _and_ which breaks
the factory configuration.

On the plus side, ethtool _can_ be used to switch the interface mode
back to 1000base-X, but given that this was working it seems backwards
to need manual intervention.

> On the other side after the quirk and the module set to LAN_SDS_MODE=1
> 1000X mode. Linux host is connecting at 1000X only.

No it won't. The module will still be detected, the quirk will be used,
which will indicate to the kernel that the module supports both
1000base-X and 2500base-X. With a host interface that supports both,
the kernel will choose 2500base-X, but the module will be using
1000base-X - and the link will not come up.

At the very least, this needs to be mentioned in the commit message,
so that the implications of this can be properly considered.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

