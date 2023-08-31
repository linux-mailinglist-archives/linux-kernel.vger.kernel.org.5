Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED1678E6FF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244591AbjHaHNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjHaHNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:13:31 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D871A3;
        Thu, 31 Aug 2023 00:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nQmwGWZMB7/FjyQkzIZQo5e/NXyg0NMGcJ/zVLN4YVM=; b=TLvYmZJoAD9oJIu60xxX1dp8bi
        BX9vjHQ10bcTo5gtekRo6qb+qBAWzvJUQ32D/qhLOo7FpL9FU6ngg9zVl6vHgEl4S8I/s6uIHoS9m
        IH0H2zFT7bHOu1i+f5ttnG0U9Dj3UFpdvCAT367a0LoIl2fUGrI7f7O078ILYoOVqHVuICnn3SSAE
        LnwGySpujw8zr6vt4nX6dodbDmebk47PUY79PfFlqNg1KuaSaFM8qm/SAJFVrYZ2d1x/TF4fXhmqg
        FbQaLtPRkcmP9If36evOZSk92+WUnT2rdWMB5srGxIYD76jU8YG3/yh8wA5czv+i23WGRu+tKbCmH
        GLRJfmWQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59796)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qbbrc-0002Vr-1x;
        Thu, 31 Aug 2023 08:13:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qbbra-0006aH-J6; Thu, 31 Aug 2023 08:13:10 +0100
Date:   Thu, 31 Aug 2023 08:13:10 +0100
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
Message-ID: <ZPA9hmlew3mT2TVr@shell.armlinux.org.uk>
References: <20230830125224.1012459f@wsk>
 <20230830105941.GH31399@pengutronix.de>
 <20230830135151.683303db@wsk>
 <20230830121738.GJ31399@pengutronix.de>
 <ZO83htinyfAp4mWw@shell.armlinux.org.uk>
 <20230830130649.GK31399@pengutronix.de>
 <ZO9Ejx9G8laNRasu@shell.armlinux.org.uk>
 <20230830142650.GL31399@pengutronix.de>
 <20230830183818.1f42919b@wsk>
 <20230831044004.GA17603@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831044004.GA17603@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 06:40:04AM +0200, Oleksij Rempel wrote:
> Hi Lukasz,
> 
> On Wed, Aug 30, 2023 at 06:38:18PM +0200, Lukasz Majewski wrote:
> > Hi Oleksij,
>  
> > The implementation as you suggested seems to work :-)
> > 
> > The ksz_get_phy_flags() - where the MICREL_NO_EEE is set is executed
> > before ksz9477_config_init().
> > 
> > And then the eee_broken_modes are taken into account.
> > 
> > # ethtool --show-eee lan1
> > EEE Settings for lan1:
> >         EEE status: disabled
> >         Tx LPI: 0 (us)
> >         Supported EEE link modes:  100baseT/Full 
> >                                    1000baseT/Full 
> >         Advertised EEE link modes:  Not reported
> >         Link partner advertised EEE link modes:  Not reported
> > 
> > I will prepare tomorrow a proper patch.
> 
> can you please by the way remove this line:
> https://elixir.bootlin.com/linux/v6.5/source/drivers/net/phy/micrel.c#L1803
> 
> it is obsolet by eee_broken_modes.

... and if possible verify on the link partner side that indeed no
EEE modes are being advertised by the Micrel device.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
