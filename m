Return-Path: <linux-kernel+bounces-44240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AB2841F40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F981295784
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DBE5D8F7;
	Tue, 30 Jan 2024 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xF12tB6u"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1736565BD1;
	Tue, 30 Jan 2024 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606378; cv=none; b=mg2TBW2X8e9J8iFuC/9keHgmT3EbfDHQJQlg9wHtW3EUPbKy71eU2MYvM7yZTMcGwWtteDme6sA1VWtCpNd/VevnN9+cvbiotTMhAOPRoWqe5gqsPmA7oZKomYDNDUdoWm3bFpZGoAlhTqPUTDdgvT3BV+aljENjfjiLCo8UyA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606378; c=relaxed/simple;
	bh=mZEotDZ+SGxElmOQBjckvcNfNNM2pdGS73nEJ+umJ9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTGcAProQDqjQJBnJCXTX/8sSyhzXK7IiUyK6KpO/y/oG+OkoF/h+aavRwN5aJ++GHaULdrTnhOFDxoT7N7lP3ZbNyarIoHcYRTTRmlOLPR2eag7R5nQ6aOiPa1eifz8TxY3mvhGz/S+j+c17zNC2VK+wZG1RXzicCucm4j/OWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xF12tB6u; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kU36CYdnPcH+FrO8kgFOVGAhAwd9owDMjxmJHm6nww0=; b=xF12tB6utNFsLwI11k2Rhw2bFF
	zhzjR638ZTG/PznXjSSPmesH6QDSGNANbH6YdKQxpt7Fnsj1N2BW4D4hsQ9nI0lMw9UXEIKQvJLQK
	bN5DwlJ3h7zarhJAb1YDz69K90AJxRfxjAVDbAq4UVvzuqscI3kPMP/rLZ9tz3M2W0pFSKqMVxG2d
	J2/IPsWJYGZTx9IzSyjLteQ5lg3sX2HMbFViiePGxFFeKSHgTednvFMWA/dfXuIyF1bgF8NKqt1bl
	6NX3+1xoEHPXda6UBymKGxfCdJ/F667BF4o0+xW5RPPkLoqDrzWn8TdfDmI0Eqoj6jql+Tlaz4re2
	X1l1TrbQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48146)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rUkHE-0001V1-1T;
	Tue, 30 Jan 2024 09:19:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rUkHC-0005OK-Re; Tue, 30 Jan 2024 09:19:30 +0000
Date: Tue, 30 Jan 2024 09:19:30 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 09/13] net: phy: marvell-88q2xxx: add cable
 test support
Message-ID: <Zbi/In/qWrW1qmP0@shell.armlinux.org.uk>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-10-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122212848.3645785-10-dima.fedrau@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 22, 2024 at 10:28:42PM +0100, Dimitri Fedrau wrote:
> +static int mv88q222x_cable_test_get_status(struct phy_device *phydev,
> +					   bool *finished)
> +{
> +	int ret;
> +	u32 dist;
> +
> +	ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TDR_STATUS);
> +	if (ret < 0)
> +		return ret;
> +
> +	*finished = true;
> +	/* fault length in meters */
> +	dist = ((ret & MDIO_MMD_PCS_MV_TDR_STATUS_DIST_MASK) >>
> +		MDIO_MMD_PCS_MV_TDR_STATUS_DIST_SHIFT) * 100;

	dist = FIELD_GET(MDIO_MMD_PCS_MV_TDR_STATUS_DIST_MASK, ret) * 100;


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

