Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6CD78DF9E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbjH3TF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243642AbjH3LUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:20:20 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3A91BB;
        Wed, 30 Aug 2023 04:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=04rA3QMGu6b8RzLVqZdwsj34mORbZ+1WIjhmdElzWKA=; b=M76T7FdSLwSJ2klAhj8Gg+yM/5
        EMEc+J0aZdzFLyN41/fOmVUyfcToAPl5pVqbZOK/BRn7v57j8HB95Od9hEaYmGVYIKKcztQ1ItJZk
        KDLQl9S4mg9fSQpTpBryiD7VGliK+bzgiAlFQTZW8w+4gFyMFP7VS9j4UfbDsQk+CMScTqA7G1Tk8
        dM1bg8tcvuoxqu0UTNMVZ2bk17KhBnmJkN+JsfLu3rXrE2/qb+fvD682C+hPZdLDDW3UttQiYTqTz
        5a4tFAg1phPgDnYDxHARy8LVobVfNohj6XtpvLaRoKZbLbdVHTvQ1DyENNJSFSLTyNmSSLvSoc6Ur
        i35sZNeg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56328)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qbJEx-0001Vs-1w;
        Wed, 30 Aug 2023 12:20:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qbJEx-0005dp-E1; Wed, 30 Aug 2023 12:20:03 +0100
Date:   Wed, 30 Aug 2023 12:20:03 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Lukasz Majewski <lukma@denx.de>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <ZO8l42ooy3PX1l8X@shell.armlinux.org.uk>
References: <20230830092119.458330-1-lukma@denx.de>
 <20230830092119.458330-2-lukma@denx.de>
 <20230830101813.GG31399@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830101813.GG31399@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 12:18:13PM +0200, Oleksij Rempel wrote:
> On Wed, Aug 30, 2023 at 11:21:19AM +0200, Lukasz Majewski wrote:
> > The KSZ9477 errata points out (in 'Module 4') the link up/down problem
> > when EEE (Energy Efficient Ethernet) is enabled in the device to which
> > the KSZ9477 tries to auto negotiate.
> > 
> > The suggested workaround is to clear advertisement of EEE for PHYs in
> > this chip driver.
> > 
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  drivers/net/phy/micrel.c | 31 ++++++++++++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> > index 87b090ad2874..469dcd8a5711 100644
> > --- a/drivers/net/phy/micrel.c
> > +++ b/drivers/net/phy/micrel.c
> > @@ -1418,6 +1418,35 @@ static int ksz9131_get_features(struct phy_device *phydev)
> >  	return 0;
> >  }
> >  
> > +static int ksz9477_get_features(struct phy_device *phydev)
> > +{
> > +	__ETHTOOL_DECLARE_LINK_MODE_MASK(zero) = { 0, };
> > +	int ret;
> > +
> > +	ret = genphy_read_abilities(phydev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* KSZ9477 Errata DS80000754C
> > +	 *
> > +	 * Module 4: Energy Efficient Ethernet (EEE) feature select must be
> > +	 * manually disabled
> > +	 *   The EEE feature is enabled by default, but it is not fully
> > +	 *   operational. It must be manually disabled through register
> > +	 *   controls. If not disabled, the PHY ports can auto-negotiate
> > +	 *   to enable EEE, and this feature can cause link drops when linked
> > +	 *   to another device supporting EEE.
> > +	 *
> > +	 *   Although, the KSZ9477 MMD register
> > +	 *   (MMD_DEVICE_ID_EEE_ADV.MMD_EEE_ADV) advertise that EEE is
> > +	 *   operational one needs to manualy clear them to follow the chip
> > +	 *   errata.
> > +	 */
> > +	linkmode_and(phydev->supported_eee, phydev->supported, zero);
> > +
> > +	return 0;
> > +}
> > +
> >  #define KSZ8873MLL_GLOBAL_CONTROL_4	0x06
> >  #define KSZ8873MLL_GLOBAL_CONTROL_4_DUPLEX	BIT(6)
> >  #define KSZ8873MLL_GLOBAL_CONTROL_4_SPEED	BIT(4)
> > @@ -4871,7 +4900,7 @@ static struct phy_driver ksphy_driver[] = {
> >  	.handle_interrupt = kszphy_handle_interrupt,
> >  	.suspend	= genphy_suspend,
> >  	.resume		= genphy_resume,
> > -	.get_features	= ksz9131_get_features,
> > +	.get_features	= ksz9477_get_features,
> 
> Sorry, i didn't described all details how to implement it.
> 
> This code will break EEE support for the KSZ8563R switch.
> 
> Please search for MICREL_KSZ8_P1_ERRATA in the kernel source.
> Then add new flag, for example MICREL_NO_EEE and use it in a similar
> way how MICREL_KSZ8_P1_ERRATA was set and used. With this
> implementation, first patch is not needed.
> 
> The code will be something like this:
>    if (dev_flags & MICREL_NO_EEE)
>       /* lots of comments */
>       linkmode_and(phydev->supported_eee, phydev->supported, zero);

I can't believe two people are writing code like this...

	linkmode_zero(phydev->supported_eee);

will work just as well.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
