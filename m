Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DFD78DFFE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344124AbjH3T0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244619AbjH3NbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:31:15 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706A2198;
        Wed, 30 Aug 2023 06:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qXDnTENf1cpDwSglV1bKnUnQe/xh9v6pAXIFuXIgylc=; b=OG050MqMB1dVOtvFlGV2rC0qD4
        mZmWrfGqn72HGqSt1lahm1QBPQXkMhwzi1s75kucl+kg5N4RcCfbW1WQfpGbDB3cOvdjKWGUvKPR6
        jaaarw2cbWpS3ByStjNbdZ4aYR2oCUpNDTwB6PDfV+3JmcenFiuxwBH1AGSp3x9eI+31XqvXfwDWi
        7iLvnFqrwVkmiNMgBakVdH4XS4wjQ16Xd99Z0z8AUodi5ej+HWHq2LsjkiVCArfYyhDTlDZ3vqsUf
        dAl7vAPKw4oXerqXOPi9WCscpSOL8BJLM3pCjUTohwsG7yOYxp68lSm8vsrIN9ljW7xS3U3Wr8jA5
        bqPCzRIg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57212)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qbLHb-0001f6-2h;
        Wed, 30 Aug 2023 14:30:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qbLHb-0005j4-IW; Wed, 30 Aug 2023 14:30:55 +0100
Date:   Wed, 30 Aug 2023 14:30:55 +0100
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
Message-ID: <ZO9Ejx9G8laNRasu@shell.armlinux.org.uk>
References: <20230830092119.458330-1-lukma@denx.de>
 <20230830092119.458330-2-lukma@denx.de>
 <20230830101813.GG31399@pengutronix.de>
 <20230830125224.1012459f@wsk>
 <20230830105941.GH31399@pengutronix.de>
 <20230830135151.683303db@wsk>
 <20230830121738.GJ31399@pengutronix.de>
 <ZO83htinyfAp4mWw@shell.armlinux.org.uk>
 <20230830130649.GK31399@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830130649.GK31399@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 03:06:49PM +0200, Oleksij Rempel wrote:
> On Wed, Aug 30, 2023 at 01:35:18PM +0100, Russell King (Oracle) wrote:
> > On Wed, Aug 30, 2023 at 02:17:38PM +0200, Oleksij Rempel wrote:
> > > On Wed, Aug 30, 2023 at 01:51:51PM +0200, Lukasz Majewski wrote:
> > > > Hi Oleksij,
> > > 
> > > > It looks like the most optimal solution would be the one proposed by
> > > > Tristam:
> > > > https://www.spinics.net/lists/netdev/msg932044.html
> > > 
> > > In this case, please add the reason why it would work on this HW and
> > > will not break by any changes in PHYlib or micrel.c driver.
> > > 
> > > If I remember it correctly, in KSZ9477 variants, if you write to EEE
> > > advertisement register, it will affect the state of a EEE capability
> > > register. Which break IEEE 802.3 specification and the reason why
> > > ksz9477_get_features() actually exist. But can be used as workaround if
> > > it is written early enough before PHYlib tried to read EEE capability
> > > register.
> > > 
> > > Please confirm my assumption by applying your workaround and testing it
> > > with ethtool --show-eee lanX.
> > > 
> > > It should be commented in the code with all kind of warnings:
> > > Don't move!!! We use one bug to workaround another bug!!! If PHYlib
> > > start scanning PHYs before this code is executed, then thing may break!!
> > 
> > Why would phylib's scanning cause breakage?
> > 
> > phylib's scanning for PHYs is about reading the ID registers etc. It
> > doesn't do anything until the PHY has been found, and then the first
> > thing that happens when the phy_device structure is created is an
> > appropriate driver is located, and the driver's ->probe function
> > is called.
> > 
> > If that is successful, then the fewatures are read. If the PHY
> > driver's ->features member is set, then that initialises the
> > "supported" mask and we read the EEE abilities.
> > 
> > If ->features is not set, then we look to see whether the driver
> > provides a ->get_features method, and call that.
> > 
> > Otherwise we use the generic genphy_c45_pma_read_abilities() or
> > genphy_read_abilities() depending whether the PHY's is_c45 is set
> > or not.
> > 
> > So, if you want to do something very early before features are read,
> > then either don't set .features, and do it early in .get_features
> > before calling anything else, or do it in the ->probe function.
> 
> Let me summarize my view on the problem, so may be you can suggest a better
> way to solve it.
> - KSZ9477, KSZ8565, KSZ9893, KSZ9563, seems to have different quirks by
>   the same PHYid. micrel.c driver do now know what exact HW is actually
>   in use.
> - A set of PHY workarounds was moved from dsa/microchip/ksz9477.c to
>   micrel.c, one of this workaround was clearing EEE advertisement
>   register, which by accident was clearing EEE capability register.
>   Since EEE cap was cleared by the dsa/microchip/ksz9477.c code before
>   micrel.c was probed, PHYlib was assuming that his PHY do not supports
>   EEE and dint tried to use it.
>   After moving this code to micrel.c, it is now trying to change EEE
>   advertisement state without letting PHYlib to know about it and PHYlib
>   re enables it as actually excepted.
> - so far, only KSZ9477 seems to be broken beyond repair, so it is better
>   to disable EEE without giving it as a choice for user configuration.

We do have support in phylib for "broken EEE modes" which DT could set
for the broken PHYs, and as it is possible to describe the DSA PHYs in
DT. This sets phydev->eee_broken_modes.

phydev->eee_broken_modes gets looked at when genphy_config_aneg() or
genphy_c45_an_config_aneg() gets called - which will happen when the
PHY is being "started".

So, you could add the DT properties as appropriate to disable all the
EEE modes.

Alternatively, in your .config_init function, you could detect your
flag and force eee_broken_modes to all-ones.

The problem with clearing ->supported_eee is that will stop
genphy_c45_write_eee_adv() writing the advertisement register -
which means if bits are set in the register, they won't be cleared
because phylib thinks the registers aren't supported. So you won't
actually be disabling anything by clearing ->supported_eee.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
