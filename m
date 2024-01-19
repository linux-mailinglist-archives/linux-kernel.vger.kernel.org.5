Return-Path: <linux-kernel+bounces-30985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C83183271C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1FCFB248A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0CF3C693;
	Fri, 19 Jan 2024 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HguVySOc"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD39F3C087;
	Fri, 19 Jan 2024 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705658211; cv=none; b=jRDIqJw7Wt7TvfsjwDty0r1UcTmvEu9kRx62Ul8iOLpzhWs7Aj/VB3DLbVvCF9YifoY8povUZtOD6s5jiTauzqXZ5HRHmokFaWEsCdyvNSAcgc3FDkqP03BZXZI3UgvTeGRM/Ab6Jezj85ea6hMM4usjIcU5nn21fkhiQB4lpWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705658211; c=relaxed/simple;
	bh=xvXw3OrViAcDcY+1iPZglFRACw6imsSrchWA7GHz1Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXgCmbKotg2CIl9PfagA8TjDbokWZ/HJa/DnQprGS/1ChlLbb3RIKyMWDtzwtOBnyxvYzGg7yGmm9v0P7/E/61zQZwj7jeRCH8Snh7jzOWoDUlAbp3Hr6Rudjba0W8nTn9LJHLvBsi5HTtVHPYjmtOMuLh3AJJ41PPx4Rzes7jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HguVySOc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2trAH9af6dbF7LZPJlZtibHnB3VOCJ6P35im2rdtrAA=; b=HguVySOc+3B4Jk1p/7UnaZwe0r
	g0ujbcQqLWZ+oPdUF3UNT89UsXrtL4nlk7ru8Nn/sxxor1hpuKwNloA2Xl/hlgKdz0SVf8ZHPaLXN
	1FUyYR22Fq9Bgi1dA8DT5+lVSg65ZX9kGrbliejYcTZ0WX8rgZK+KkvtVZlUP/ILjEvOCtAacyQ+W
	gM/7MiX/yq2OmKhtKcfQUpTNE4x8ecO3wzgv/WF6HMGZvtlLioJ0g5+3Ae5QrX1ImCtENTpAkznQi
	KEAsT0c0bBepxx5AAGIXlytvh3IAJhjDqHO+RTDQ75zvQGJHsIPXALaLRXx60deyrGLW7ZZLaybwu
	iDelsQpQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45684)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rQlcB-0006YB-36;
	Fri, 19 Jan 2024 09:56:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rQlcB-0006Zz-P7; Fri, 19 Jan 2024 09:56:43 +0000
Date: Fri, 19 Jan 2024 09:56:43 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: adin1100: Fix nullptr exception for phy
 interrupts
Message-ID: <ZapHWw85UAIRqsyt@shell.armlinux.org.uk>
References: <20240118104341.10832-1-andre.werner@systec-electronic.com>
 <Zald7u8B+uKzCn42@shell.armlinux.org.uk>
 <48245ebe-babf-52ec-407b-9ce32ffe24d2@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48245ebe-babf-52ec-407b-9ce32ffe24d2@systec-electronic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 19, 2024 at 04:05:29AM +0100, Andre Werner wrote:
> On Thu, 18 Jan 2024, Russell King (Oracle) wrote:
> 
> > In addition to Andrew's comments:
> > 
> > On Thu, Jan 18, 2024 at 11:43:41AM +0100, Andre Werner wrote:
> > > +static int adin_config_intr(struct phy_device *phydev)
> > > +{
> > > +	int ret, regval;
> > > +
> > > +	ret = adin_phy_ack_intr(phydev);
> > > +
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	regval = phy_read_mmd(phydev, MDIO_MMD_VEND2, ADIN_PHY_SUBSYS_IRQ_MASK);
> > > +	if (regval < 0)
> > > +		return regval;
> > > +
> > > +	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
> > > +		regval |= ADIN_LINK_STAT_CHNG_IRQ_EN;
> > > +	else
> > > +		regval &= ~ADIN_LINK_STAT_CHNG_IRQ_EN;
> > > +
> > > +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
> > > +			    ADIN_PHY_SUBSYS_IRQ_MASK,
> > > +			    regval);
> > > +	return ret;
> > 
> > 	u16 irq_mask;
> > 
> > 	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
> > 		irq_mask = ADIN_LINK_STAT_CHNG_IRQ_EN;
> > 	else
> > 		irq_mask = 0;
> 
> Unfortunately, I can not do this, because that phy ask for read-modify-write access to
> registers and some bits in this register are already set after reset and
> should not being modified.
> 
> > 
> > 	return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> > 			      ADIN_PHY_SUBSYS_IRQ_MASK,
> > 			      ADIN_LINK_STAT_CHNG_IRQ_EN, irq_mask);

So you don't understand... phy_modify_mmd() will do a read-modify-write
and because the mask passed is ADIN_LINK_STAT_CHNG_IRQ_EN, this is the
_only_ bit that will be affected.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

