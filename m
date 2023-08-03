Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC0D76F300
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjHCSuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbjHCSt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:49:58 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE792D5A;
        Thu,  3 Aug 2023 11:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uflcrixw6nCghznSfpjIdEg8Z/0V2WwrsF757Ri68QM=; b=yZ4xfzN3KxRSxQXFgH5pEZ5UDS
        ZKN0bp0nCAS+X+TZJW1kOMqfgeHntqkThktxc97CIl4mwO5l0tAEBLNQrT/a+1QKS+W1gkFBtFBaH
        cFWM8c0u9tem1TxlvQZ1Bn1kiglukxknmU8+N2qnSkaaIGyssQTxO36q6I3283BBDkJHKxups7Chy
        +OicRaaFOJFCLdM9P2LHorQAMT58tGG6j2cHVCCNlE6MbDYZq9X+xpL+16o0hZrjUsP2zSMqxyfB9
        aNM/cIslnhJf8etVT36eotThMRVvTT7xVXsPijazTJAyik4+Zh0YP4CHxmpNEysWdfJy3bytoZx3x
        9GMwE8CQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46050)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qRdNy-0007Lp-0p;
        Thu, 03 Aug 2023 19:49:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qRdNs-0003AM-NG; Thu, 03 Aug 2023 19:49:16 +0100
Date:   Thu, 3 Aug 2023 19:49:16 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ioana Ciornei <ciorneiioana@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andre Edich <andre.edich@microchip.com>,
        Antoine Tenart <atenart@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Divya Koppera <Divya.Koppera@microchip.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Kresin <dev@kresin.me>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Michael Walle <michael@walle.cc>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nisar Sayed <Nisar.Sayed@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Willy Liu <willy.liu@realtek.com>,
        Yuiko Oshino <yuiko.oshino@microchip.com>
Subject: Re: [PATCH net-next v2 02/19] net: phy: add a shutdown procedure
Message-ID: <ZMv2rC8CACihovLl@shell.armlinux.org.uk>
References: <20201101125114.1316879-1-ciorneiioana@gmail.com>
 <20201101125114.1316879-3-ciorneiioana@gmail.com>
 <20230803181640.yzxsk2xphwryxww4@pengutronix.de>
 <7e365fa4-7a50-382c-5a99-288a417a82a7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e365fa4-7a50-382c-5a99-288a417a82a7@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 11:24:04AM -0700, Florian Fainelli wrote:
> On 8/3/23 11:16, Uwe Kleine-König wrote:
> > Hello,
> > 
> > this patch became commit e2f016cf775129c050d6c79483073423db15c79a and is
> > contained in v5.11-rc1.
> > 
> > It broke wake-on-lan on my NAS (an ARM machine with an Armada 370 SoC,
> > armada-370-netgear-rn104.dts). The used phy driver is marvell.c. I only
> > report it now as I just upgraded that machine from Debian 11 (with
> > kernel 5.10.x) to Debian 12 (with kernel 6.1.x).
> > 
> > Commenting out phy_disable_interrupts(...) in v6.1.41's phy_shutdown()
> > fixes the problem for me.
> > 
> > On Sun, Nov 01, 2020 at 02:50:57PM +0200, Ioana Ciornei wrote:
> > > In case of a board which uses a shared IRQ we can easily end up with an
> > > IRQ storm after a forced reboot.
> > > 
> > > For example, a 'reboot -f' will trigger a call to the .shutdown()
> > > callbacks of all devices. Because phylib does not implement that hook,
> > > the PHY is not quiesced, thus it can very well leave its IRQ enabled.
> > > 
> > > At the next boot, if that IRQ line is found asserted by the first PHY
> > > driver that uses it, but _before_ the driver that is _actually_ keeping
> > > the shared IRQ asserted is probed, the IRQ is not going to be
> > > acknowledged, thus it will keep being fired preventing the boot process
> > > of the kernel to continue. This is even worse when the second PHY driver
> > > is a module.
> > > 
> > > To fix this, implement the .shutdown() callback and disable the
> > > interrupts if these are used.
> > 
> > I don't know how this should interact with wake-on-lan, but I would
> > expect that there is a way to fix this without reintroducing the problem
> > fixed by this change. However I cannot say if this needs fixing in the
> > generic phy code or the phy driver. Any hints?
> 
> It depends upon what the PHY drivers and underlying hardware are capable and
> willing to do. Some PHY drivers will shutdown the TX path completely since
> you do not need that part to receive Wake-on-LAN packets and pass them up to
> the PHY and/or MAC Wake-on-LAN matching logic. This would invite us to let
> individual PHY drivers make a decision as to what they want to do in a
> .shutdown() routine that would then need to be added to each and every
> driver that wants to do something special. In the absence of said routine,
> you could default to calling phy_disable_interrupts() unless the PHY has WoL
> enabled?
> 
> phydev::wol_enabled reflects whether the PHY and/or the MAC has Wake-on-LAN
> enabled which could you could key off to "nullify" what the shutdown does.

If the shutdown method is being called, doesn't that imply that we're
going to be hibernating rather than suspend-to-RAM - because suspend-to
RAM doesn't involve powering down the system, whereas hibernating does.

I think the problem is that when placing the system into hibernate mode
with WoL enabled, there are PHYs which use their interrupt pin to signal
that a WoL event has happened. The problem comes with the aforementioned
commit that the core PHY code now _always_ disables interrupts on the
PHY, even if WoL is active and we're entering hibernate mode.

That's clearly the wrong thing to be doing when people expect WoL to
be able to wake their systems up from hibernate.

The more I think about it, the more I'm coming to the conclusion that
the blamed commit is wrong as it is coded today.

It also occurs to me that systems need to cope with the PHY's INT signal
being asserted through boot, because in the case of WoL-triggered resume
from hibernate mode, the PHY's INT signal will be asserted _while_ the
system is booting up (and remember, recovery from hibernate mode is
essentially no different from a normal system boot with the exception
that the kernel notices a special signature in the swap partition, and
then reloads state from there.)

So, boot has to cope properly with the PHY's interrupt being asserted
in order for WoL from hibernate to work.

It seems to me that a revert of the blamed commit is in order, and a
different approach is needed?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
