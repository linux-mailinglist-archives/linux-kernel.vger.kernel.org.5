Return-Path: <linux-kernel+bounces-91915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43D8871853
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385DF282392
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4964D13B;
	Tue,  5 Mar 2024 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AgCIe+Wj"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443961EF01;
	Tue,  5 Mar 2024 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709627865; cv=none; b=UoHCXngdC1mt5z3X8c+R+YYY++ZgD1lARk4bLD1TUCi/KYtrILj+8D7TQEBR/xVveTK67qCSXGHFfokBApiiH6o0o6F7tro8brDPP+Icj9JrXBSKNsqkNF83eTjWPcKqtlkmycDoLrHDEJ87tTEWv2/jbnsR1DdZ1DGi5NFY9SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709627865; c=relaxed/simple;
	bh=FpAGb89Nhp9Tx4qmJbXKmvYtorSULzhPc0KcYtduHzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4qo4LV62McUg4fmO60c2Z41ovpxy393+XZvUufM5OmianchbsWpeOBz0VjjJ7XmvulL0E+xJ2zS0JEVLRTqziPrdrkmCMPJt8Jv4pQdxWd3CznzLomEmEs+UTIIY5iSZtNbQURkpvG5yHXnv3XxrgX56AJNvw596kSqC0YmLhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AgCIe+Wj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=slMU9fALR2FKtthS6g2GplC/gm7hOVa33LfK6FZeUCo=; b=AgCIe+WjIze4L7uAzJboSfBRRT
	usMNSmG6kawNKWQU4sVBqXGsijtuyTw277G0py0wCeYSN2OursIgPUd0coX/zDD+5m6REIKWYlaeT
	jlEVhn/pdBxpfTP+ByL5JnH27FTP5ySvZilSUV53SGlHppmiKC8aJYUP+CeXxbTw73AowLPY6jfRJ
	RcWXv63v2MN5dAmo0XOLLQHSHgmzPN9UxUkz9vEkYDxLjD/9w5jmaXX/w/iRgeQjl+3zTCFEaOdBM
	2oMhYqcryDBIIhuLuRSnlbtuq++Qtv8XC5Tz6UWWMGHXF2RjwGePu9YA7eWzZfWS/6QvUO4cYXR3t
	DoIa3oeg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59010)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rhQIG-0006qe-1U;
	Tue, 05 Mar 2024 08:37:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rhQIA-0005Gy-FG; Tue, 05 Mar 2024 08:36:54 +0000
Date: Tue, 5 Mar 2024 08:36:54 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v9 08/13] ptp: Add phc source and helpers to
 register specific PTP clock or get information
Message-ID: <ZebZpspMCqjLES/W@shell.armlinux.org.uk>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
 <20240226-feature_ptp_netnext-v9-8-455611549f21@bootlin.com>
 <20240304185734.5f1a476c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304185734.5f1a476c@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 04, 2024 at 06:57:34PM -0800, Jakub Kicinski wrote:
> On Mon, 26 Feb 2024 14:39:59 +0100 Kory Maincent wrote:
> > Prepare for future hardware timestamp selection by adding source and
> > corresponding pointers to ptp_clock structure. Additionally, introduce
> > helpers for registering specific phydev or netdev PTP clocks, retrieving
> > PTP clock information such as hwtstamp source or phydev/netdev pointers,
> > and obtaining the ptp_clock structure from the phc index.
> 
> Can we assume there's one PHC per netdev?
> We both store the netdev/phydev info in the ptp clock
> and ptp clock in the netdev. Is there a reason for that?

No. In the case of mvpp2 + marvell PHY, the two PTP implementations are
entirely separate.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

