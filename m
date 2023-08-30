Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BD478DF62
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241102AbjH3TKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245166AbjH3OjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:39:19 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC68193;
        Wed, 30 Aug 2023 07:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lFcx4zTPkgw6rQGeLwVoG5WLUudW6yfyt4AfeA6EqmQ=; b=hbQd/qul234oG3fzVBrVo09ovH
        cvHlPoVnKO7bTnzbefdHYmglbyFYBguR5eFnwkRND8Kgu2DJI0suPtSEsOlSMSlp44r/cPtXvt1UA
        SdmEGP4nRb78To5zG1p7KkSlDRyMeCQtSqVpGX9oYLLYdMXt8ROtgVotbigJSGxtOlXJBVA5AFgL0
        yxrA5SmEH3boU+KOhj1q63SvHXZhl4JFQI3altWlM74ABUpSXHiBT8v2rc5tsBcSRvJPbsWewVZoc
        Ni7NPSq8/4JYQNTw/igJtLhlvj93N7KgPZJBsZxfRBUCvOB5Jmj22kRiw6vT+Jpie9sZoHVpMHOU4
        asJAVDiQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38888)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qbMLQ-0001kB-32;
        Wed, 30 Aug 2023 15:38:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qbMLP-0005m5-MF; Wed, 30 Aug 2023 15:38:55 +0100
Date:   Wed, 30 Aug 2023 15:38:55 +0100
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
Message-ID: <ZO9Uf5DjJ6Kf6uvh@shell.armlinux.org.uk>
References: <20230830092119.458330-2-lukma@denx.de>
 <20230830101813.GG31399@pengutronix.de>
 <20230830125224.1012459f@wsk>
 <20230830105941.GH31399@pengutronix.de>
 <20230830135151.683303db@wsk>
 <20230830121738.GJ31399@pengutronix.de>
 <ZO83htinyfAp4mWw@shell.armlinux.org.uk>
 <20230830130649.GK31399@pengutronix.de>
 <ZO9Ejx9G8laNRasu@shell.armlinux.org.uk>
 <20230830142650.GL31399@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830142650.GL31399@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 04:26:50PM +0200, Oleksij Rempel wrote:
> @Lukasz,
> 
> can you please try to set eee_broken_modes to all-ones. Somewhat like
> this:
> ksz9477_config_init()
> ...
>    ...quirks...
> 
>    if (phydev->dev_flages & .. NO_EEE...)
>        phydev->eee_broken_modes = -1;

That's fine in config_init().

>    err = genphy_restart_aneg(phydev);

That isn't necessary, and in any case, calling it will just cause the
AN enable and AN restart bits in BMCR to be set, nothing will be
reprogrammed.

However, at a later point, when the PHY is started (by phy_start()
being called) the state will be set to PHY_UP, and the state machine
triggered. That sets needs_aneg which will then call phy_start_aneg().

That then goes on to call phy_config_aneg(), which will either call
the driver specific config_aneg() function, or one of the two generic
genphy.*config_aneg() functions. These will then program the EEE
advertisement.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
