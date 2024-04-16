Return-Path: <linux-kernel+bounces-147267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A998A71BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327FB1C21AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD8A130E46;
	Tue, 16 Apr 2024 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Cd9doH1V"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0232E7764E;
	Tue, 16 Apr 2024 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286590; cv=none; b=YS4ov28skZFMMHaT8pQD2dZ8w6jpcSnah7BeymRoRe8ayZwuYrwWHo42sOOiqpv+KX0E4ab74ikMV8ZZtL4zS9E72IlxlcqWHRCdqJ5iNbrn22pwNrbzBPSycV7VlXXpOIfcLLVfQbGmRis9OkDju3ydVtg9qGMnGd/orBE5QrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286590; c=relaxed/simple;
	bh=XKB3FT4Mg1Gff+mXe9Mh5mHwZ84D8ow6gVjtrKU9f4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeQoD7jHtOFosnigX62EBrg9XeIY7DndUxlCt++ruQm7qthDyd1Q4hBkk9DHXX5o5MiqMZpdksQK3C58JNM3ArrbhXzAPcu99ukOYFVNdY60IK8OVh955Ve/S1+3KE0bS0/5HnpaKREtiKEe9udmxkXT4QfbFL6dvZJyWy7Xo1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Cd9doH1V; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pC6bagQ6vg68uB6dljn9J+Y6O1xZqp8PVpkbc7gYlUM=; b=Cd9doH1VnwOV0U2dH8QwWtI+AJ
	QXvht6YpWfeorYwCORZL5zO6r9HLjcBcEzARet+dOyF/kdrSEF+/ELpgs8LIkPdK3n9QfGSjfucRL
	Y+zW4/3RfCNscqjBE9O75x9WTv93blXcjLQg2NPXTovy0crcu5sFJVyYrDwVBf7R82xSCiUmRCnf2
	rJvS1b7c9IaKDC2bNhzeV5olxx6TP2+8KqxvEFgcduEKEmGCE85susTJBzcoSbgCpl9q56rnPFCFL
	pIkLxZiWZbeNDGCkCHcXRhwc/IR5/eUrVC9vBNtUuxb+Csz1DpZobGYv6QN0Ci80q1nDpECTsgh1A
	u/wRqUYA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37618)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rwm6T-0000h2-2A;
	Tue, 16 Apr 2024 17:56:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rwm6R-0004zx-PO; Tue, 16 Apr 2024 17:56:15 +0100
Date: Tue, 16 Apr 2024 17:56:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH net] net: dsa: mv88e6xx: fix supported_interfaces setup
 in mv88e6250_phylink_get_caps()
Message-ID: <Zh6trxU0hB+yt6rV@shell.armlinux.org.uk>
References: <20240416155054.3650354-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416155054.3650354-1-matthias.schiffer@ew.tq-group.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 16, 2024 at 05:50:54PM +0200, Matthias Schiffer wrote:
> +int mv88e6250_port_get_mode(struct mv88e6xxx_chip *chip, int port,
> +			    phy_interface_t *mode)
> +{
> +	int err;
> +	u16 reg;
> +
> +	if (port < 5) {
> +		*mode = PHY_INTERFACE_MODE_INTERNAL;
> +		return 0;
> +	}

Note that if mv88e6xxx_phy_is_internal() returns TRUE for the port,
then this will be handled automatically.

> +
> +	err = mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_STS, &reg);
> +	if (err)
> +		return err;
> +
> +	switch (reg & MV88E6250_PORT_STS_PORTMODE_MASK) {
> +	case MV88E6250_PORT_STS_PORTMODE_MII_10_HALF_PHY:
> +	case MV88E6250_PORT_STS_PORTMODE_MII_100_HALF_PHY:
> +	case MV88E6250_PORT_STS_PORTMODE_MII_10_FULL_PHY:
> +	case MV88E6250_PORT_STS_PORTMODE_MII_100_FULL_PHY:
> +		*mode = PHY_INTERFACE_MODE_REVMII;
> +		break;
> +
> +	case MV88E6250_PORT_STS_PORTMODE_MII_HALF:
> +	case MV88E6250_PORT_STS_PORTMODE_MII_FULL:
> +		*mode = PHY_INTERFACE_MODE_MII;
> +		break;
> +
> +	case MV88E6250_PORT_STS_PORTMODE_MII_DUAL_100_RMII_FULL_PHY:
> +	case MV88E6250_PORT_STS_PORTMODE_MII_200_RMII_FULL_PHY:
> +	case MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_HALF_PHY:
> +	case MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_FULL_PHY:
> +		*mode = PHY_INTERFACE_MODE_REVRMII;
> +		break;
> +
> +	case MV88E6250_PORT_STS_PORTMODE_MII_DUAL_100_RMII_FULL:
> +	case MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_FULL:
> +		*mode = PHY_INTERFACE_MODE_RMII;
> +		break;
> +
> +	case MV88E6250_PORT_STS_PORTMODE_MII_100_RGMII:
> +		*mode = PHY_INTERFACE_MODE_RGMII;
> +		break;
> +
> +	default:
> +		*mode = PHY_INTERFACE_MODE_NA;

What does this mean? I don't allow PHY_INTERFACE_MODE_NA to be set in
the list of supported interfaces because it isn't an interface mode.
If it's invalid, then it's probably best to return an error.

I wonder whether it would just be better to pass the
supported_interfaces bitmap into this function and have it set the
appropriate bit itself, renaming the function to something more
better suited to that purpose.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

