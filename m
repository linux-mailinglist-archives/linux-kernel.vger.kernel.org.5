Return-Path: <linux-kernel+bounces-81060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 741AA866F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241221F27F16
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCF459B4A;
	Mon, 26 Feb 2024 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JhqRkitE"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E170E59165;
	Mon, 26 Feb 2024 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940017; cv=none; b=Q7tTPYjQQjZzvZxHSc+dGX1vWaIQU6LTYL9jJw/ksUadr0OMk0DSxcboc/fpFzGSc0mjOiYcB8UPEYIIvLYz3ItvfJEL2/84kpSlwxiyn17bXo0mDVfo6z2xi7ZRuSudZfxthSYvrtXn40GG/emqL+WBATWGGMMTBK9/n8O3BVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940017; c=relaxed/simple;
	bh=xfJhCzC/yxaxXwbyUtC5UKNzBmH/J2L7qZComeP/OVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snERGvfxXVf9cZU1shSJAPub1Zq46YwbXluyNWmZeVBWNFY17gozdkAlwxfBc26jR+yiTmi9ZhZcEU/koWkxK6mcpi+l5iKd6WZhcPAqX+62A76U4GKasZNk+E8Rd9Oj6Qb8+KxAqZyI9I7+mgzFh+LJpBSOXk+7fvGBkXIuA68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JhqRkitE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k5ry8E4kJ7js8BHN7TWLQwnIXbcYBZy2VBYXd0Bt+Zg=; b=JhqRkitE78OMPtdszwXygfRpd7
	VHZ0ZH23JymbQICsgffDDzwOjQznCjr7fGy3CcC8MFPjP982QxMTi04ELTHYOeFby3D6PEQaRF4wO
	LTu299M+MfHCq/ah2OHS3Obqx6nikz5uraWp9GZFfoPWP5YvFvZ3JDRcIAGC3+wzWNeow9aWAdz5G
	vKaS+d63Z1vEVqNek49WXtITeNTnHw51i88ia/r5DZvF11TQC+yTGzqzO/bNvShS9D9IHXZp+9Un0
	Q0ZRh+p28kvtbQAaAdGB9veD3hSiQWnataVcPcJ9JT3HTJKj8HmF0i/loQQTJkiIk2KogkfGRbLHc
	DDbDFsuw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34234)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1reXMV-0002fw-2u;
	Mon, 26 Feb 2024 09:33:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1reXMV-0006K1-4p; Mon, 26 Feb 2024 09:33:27 +0000
Date: Mon, 26 Feb 2024 09:33:27 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Steffen =?iso-8859-1?Q?B=E4tz?= <steffen@innosonix.de>
Cc: Fabio Estevam <festevam@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: dsa: mv88e6xxx: 6320/21 read cmode on
 serdes ports
Message-ID: <Zdxa5/mt84O4UMEh@shell.armlinux.org.uk>
References: <20240226091325.53986-1-steffen@innosonix.de>
 <20240226091325.53986-2-steffen@innosonix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226091325.53986-2-steffen@innosonix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 26, 2024 at 10:13:24AM +0100, Steffen Bätz wrote:
> @@ -660,6 +660,16 @@ static void mv88e632x_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
>  
>  	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 |
>  				   MAC_1000FD;
> +
> +	/* Port 0/1 are serdes only ports */
> +	if (port == 0 || port == 1) {
> +		cmode = mv88e63xx_get_port_serdes_cmode(chip, port);
> +		if (cmode < 0)
> +			dev_err(chip->dev, "p%d: failed to read serdes cmode\n",
> +				port);
> +		else
> +			mv88e6xxx_translate_cmode(cmode, supported);
> +	}

Ah, ignore my comment on the other patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

