Return-Path: <linux-kernel+bounces-93531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FDD87310F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F66B283488
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3859E5D901;
	Wed,  6 Mar 2024 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GDba/hMN"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93602E641;
	Wed,  6 Mar 2024 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714858; cv=none; b=ruSriDnlyfh8Yu0KgCU1YFrnACUzXV72qsi5HUZMcI3tC4/jEELlTxhutg4FkcncYJ6+PjNDeM7YHW0AQCtUR/4GMUaDIyXw+TM8LDHUkDdaoLN24fhG/gIQA96O+Q6dj6nuHyS00BF88baB3clfid+0HGYvEP9HaOtwXWR1wyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714858; c=relaxed/simple;
	bh=y75YYFxmcbFw4jJsqaiBwrNaZMabJFUxzrao5runQ4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dx2JEHS4WBRKUm32CG2WFN1IBUBStHFPZ6nE4nL5TZajEkNYWempyCMBwlDiT5/f3SgQWBUNh0iPGmK01bJMNFo/fupv3PaJSsZjbu6Z6XW5c/nKtKg3uQzrjUrYQV/uOF/Y5ooC26+3SPAznnTUjHkw0u6NHutNiot9VCWlUH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GDba/hMN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=v/9N1iM5TX6NtNle71vklmx0npL2usz7wNoysh2Fozw=; b=GDba/hMN1BQIUNaqMdZc52/JsE
	lBc1Qoys5eenNO1iwbCxKSX8yJ9sfhtXEGI5HJGUF0uk/4nJxW4zuAc894m/Pkl6ANsbnTbUv866X
	E5QInK3v8WFKKWyhu50VsMrn9hams4PmseHnWKMKjVxwT1ATIXSY+LowCV+9ltdYHy3jJnP7WpaB1
	LU+LNplTp9mwXzcbJs4bQ0Iioic6u9ApMWvqjpzDLF7AE1Qvsn2Sn+wd816B/3iQwTABhKEUANHXK
	O1rRF2rVgAGd7+8LbjXQAC7lpoKdev/Q6x1VdBasGmjG1urBGycTOs/jTCBfLhDwAk6mN18CjJe5+
	iOoDha6A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38862)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rhmw1-00086U-0p;
	Wed, 06 Mar 2024 08:47:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rhmw0-0006E2-3c; Wed, 06 Mar 2024 08:47:32 +0000
Date: Wed, 6 Mar 2024 08:47:31 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 03/16] net: dsa: vsc73xx: use macros for
 rgmii recognition
Message-ID: <Zegto1XwPTku59CD@shell.armlinux.org.uk>
References: <20240301221641.159542-1-paweldembicki@gmail.com>
 <20240301221641.159542-4-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301221641.159542-4-paweldembicki@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 01, 2024 at 11:16:25PM +0100, Pawel Dembicki wrote:
> It's preparation for future use. At this moment, the RGMII port is used
> only for a connection to the MAC interface, but in the future, someone
> could connect a PHY to it. Using the "phy_interface_mode_is_rgmii" macro
> allows for the proper recognition of all RGMII modes.
> 
> Suggested-by: Russell King <linux@armlinux.org.uk>

Please change this to:

Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Also:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

