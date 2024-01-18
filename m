Return-Path: <linux-kernel+bounces-30408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D228831E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA0FB236BD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9472C84D;
	Thu, 18 Jan 2024 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DQ1+FQXx"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FB62C841;
	Thu, 18 Jan 2024 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705598458; cv=none; b=Oa+FtIv+Cqx3Z+ZQA9rerdEGR/FtVsfpyyD0rA6EBWZoxKqznxsgxENnyBvO4c7jHbAK8/1hg9WO/I++DJbSzUrA2mpK+t2eBC4ianYs9hyeqlBYzE9G3Ef261NTix8b4QUAcBWJVkDSfj/OHlopr1CU0UJJLQ8UqJE700wnWCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705598458; c=relaxed/simple;
	bh=QCi0NAejhSMBU6bIleU7dVTM/9bEmhooAzEn3eRNGV0=;
	h=DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Sender; b=UVCEAElghKM6jNCs9g9SSaF7yX0Hrw0ESAVx4c/P9NHYsjooNUxAPfg8biVKvmLz+TWjjaJZPv7UvOwi8jCDgyST+qUDbJePeo26/1rX2LgHwxcVJroSHZCj8id9vkE9PxB9jkp72tSNOIq1Vr0Tc3uWGIT2P1dVAfklCoWgU3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DQ1+FQXx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QW5QZVtvDMrqM5iqjOSP4enaNWSUCJ1eFOycJjQ34Lc=; b=DQ1+FQXxKz/5UT2gG/qY9Nm63q
	ZnbqqtX0YlzE7kngEfJ7zhTkO0PCVEWPazi8mnmvmRDi7kwQAzAkEpLJRd+0FH9YbCl1aXTnUxllk
	TYEXLaC69tAaw7A+UVOnWlA6CEuHYlR/ZrxyXANoPo1a44rGOWYolIIEZcD7o1uh19LW8yAH/goFX
	0oygVnl4cQ38/l1IWT1L4HUR0Ckg+bCR3C0fHCiDenl3mT6rB1dDXAhatdye8KAvc8Hb7+haGVDpb
	I4DamBIEeoPvBGAzooYMLzEQpOY4d3MhRwhGdcRXfYAmspaHBo7UEKlR+19UxZji1jwltZC3PCOmg
	+pf3tZjA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58808)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rQW4O-0005vR-0C;
	Thu, 18 Jan 2024 17:20:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rQW4M-0005tn-E5; Thu, 18 Jan 2024 17:20:46 +0000
Date: Thu, 18 Jan 2024 17:20:46 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: adin1100: Fix nullptr exception for phy
 interrupts
Message-ID: <Zald7u8B+uKzCn42@shell.armlinux.org.uk>
References: <20240118104341.10832-1-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118104341.10832-1-andre.werner@systec-electronic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

In addition to Andrew's comments:

On Thu, Jan 18, 2024 at 11:43:41AM +0100, Andre Werner wrote:
> +static int adin_config_intr(struct phy_device *phydev)
> +{
> +	int ret, regval;
> +
> +	ret = adin_phy_ack_intr(phydev);
> +
> +	if (ret)
> +		return ret;
> +
> +	regval = phy_read_mmd(phydev, MDIO_MMD_VEND2, ADIN_PHY_SUBSYS_IRQ_MASK);
> +	if (regval < 0)
> +		return regval;
> +
> +	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
> +		regval |= ADIN_LINK_STAT_CHNG_IRQ_EN;
> +	else
> +		regval &= ~ADIN_LINK_STAT_CHNG_IRQ_EN;
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
> +			    ADIN_PHY_SUBSYS_IRQ_MASK,
> +			    regval);
> +	return ret;

	u16 irq_mask;

	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
		irq_mask = ADIN_LINK_STAT_CHNG_IRQ_EN;
	else
		irq_mask = 0;

	return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
			      ADIN_PHY_SUBSYS_IRQ_MASK,
			      ADIN_LINK_STAT_CHNG_IRQ_EN, irq_mask);

> +}
> +
> +static irqreturn_t adin_phy_handle_interrupt(struct phy_device *phydev)
> +{
> +	int irq_status;
> +
> +	irq_status = phy_read_mmd(phydev, MDIO_MMD_VEND2, ADIN_PHY_SUBSYS_IRQ_STATUS);

Probably want to wrap this - if you're going to bother wrapping your
phy_write_mmd() above because it overflows 80 columns, then please do
so consistently.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

