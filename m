Return-Path: <linux-kernel+bounces-138298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67CF89EF71
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB88284D5C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378AF1591F4;
	Wed, 10 Apr 2024 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QwEFMdhw"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D57156996;
	Wed, 10 Apr 2024 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743514; cv=none; b=P8gk/KrrsC/mmeopwUa7QPVym5HpDtBhPmqrio2CsMunzKcN7WPDd5jK2wYHJ0HwV4VV15srV0jVXmNrwAux9icQ8ZkiPYXzd/24CMiWuzu26PfbGMIhagx/g9D4rcffSCXD1e+34vq5K0WgXh+upPxwg+oQJ6PLmn/8gALZotw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743514; c=relaxed/simple;
	bh=30woaapoAH8NpTmPC9U/LfaEmvc6WtNWd+ZQ9CZZTGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsBM8WC9CEeLq2ZKtuJOuQk/Q39uWPu2fV4iOJ+T9tsMI/dzkywMt0gAEZ1jKYGC7N/ldmoe19sV++3apAu5alzGdR7MRVZBleZQ+PNhK129dbJNs6mGGfaC9CdM/khHi/QMfYxrisiOo9i+3soZ6ozmMKn9xET+5utSLFj3eZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QwEFMdhw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xGW6DVRYYKhZUWlvDMf+rQo/nW9gpAKrBh3OHMIwwlE=; b=QwEFMdhwMuz0wcDl9wC/hPW66K
	07mOUX3JJ0RMXfGCtOeDxYS4j4nIVZBYL2lWPSxsCatpmM9cfqPt3h0CKj9RlOq2zwmzkzRp6fEjJ
	joJ+91K/2P8ILqnSb+J+Mk2mTzhxRkeoEwIY6nA5EPseC1p1ArJHtG7+x78yWbpA9IYV6JYlsi6wn
	w6P3j6GrORcbtmYss3I5cFLvJNAOv9YvhTO6XxqCTrmYbZOrskXqk0ATDXr3E5H8dVOS4f/wy7Pc3
	noPZPm4VUJKTzsL7/KQmPTr/zpUSfQ720TUIyV0E1i8q+r7uk/+wuWe7VzARQr+HS8JL6V47eaEWk
	LKcTh93A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45298)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ruUou-0007it-0q;
	Wed, 10 Apr 2024 11:04:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ruUom-0005tk-D4; Wed, 10 Apr 2024 11:04:36 +0100
Date: Wed, 10 Apr 2024 11:04:36 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
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
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net-next v10 07/13] net: Add struct kernel_ethtool_ts_info
Message-ID: <ZhZkNEYnY3FV7Q8E@shell.armlinux.org.uk>
References: <20240409-feature_ptp_netnext-v10-0-0fa2ea5c89a9@bootlin.com>
 <20240409-feature_ptp_netnext-v10-7-0fa2ea5c89a9@bootlin.com>
 <20240409182725.139856d5@kernel.org>
 <20240410101200.0178e594@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410101200.0178e594@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 10, 2024 at 10:12:00AM +0200, Kory Maincent wrote:
> On Tue, 9 Apr 2024 18:27:25 -0700
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Tue, 09 Apr 2024 10:26:29 +0200 Kory Maincent wrote:
> > > In prevision to add new UAPI for hwtstamp we will be limited to the struct
> > > ethtool_ts_info that is currently passed in fixed binary format through the
> > > ETHTOOL_GET_TS_INFO ethtool ioctl. It would be good if new kernel code
> > > already started operating on an extensible kernel variant of that
> > > structure, similar in concept to struct kernel_hwtstamp_config vs struct
> > > hwtstamp_config.
> > > 
> > > Since struct ethtool_ts_info is in include/uapi/linux/ethtool.h, here
> > > we introduce the kernel-only structure in include/linux/ethtool.h.
> > > The manual copy is then made in the function called by ETHTOOL_GET_TS_INFO.
> > >  
> > 
> > This one now conflicts :(
> > 
> > Applying: net: Add struct kernel_ethtool_ts_info
> > error: sha1 information is lacking or useless (drivers/net/phy/marvell_ptp.c).
> > error: could not build fake ancestor
> 
> gnn patching my out of tree patch in the series! Sorry for that.

Given that this path corresponds to the driver I wrote, do I assume
that you've picked up my work on PTP support for Marvell PHYs? You
should be aware that I still have the patches out of tree but it's
been pointless me reposting it until the issue of which PTP gets
used has been solved. (Publishing will just increase the pressure
to merge it without the PTP problems being solved, and thus break
Marvell PP2 PTP.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

