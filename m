Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F5E774823
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjHHT0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbjHHT0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:26:37 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5864812C05;
        Tue,  8 Aug 2023 11:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q+WYnEhAPaxnloJWO3VZQkptgMclca2jZyZdbgJ+fmQ=; b=sq9khFkBu8IaoEGIQ4wXS5w3Cj
        R1KhG6JLfEwAJ3USVYGl2rqt/NEVP9VT1FyaFRB6qsnwGIkFR2JczufeMpNqENoZ8sdwwDBSoy/B/
        NeWTcXbhfc+HmyhYvYvnMqHiDXSZiRYTh/nKOZKHXXExgPBJtcSk9ardpaEEKHAgQRtZomwHwmMyp
        9i4Tf2aG2C1ixQTLBI5DwnNVsN/N6AUUq6mCItrJZOMA8WVtOzEustLwiu8+CZiD22ISYXT5B9m8g
        U1my0/K8R8WdGmFxlMgEihkOnJDGhOOnBKohBYcTlDM8cLy/7uH4SryKKUKKMXvrDNIRMUoAaOnAo
        e4cuxqZQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33368)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qTNjD-0008Ly-2A;
        Tue, 08 Aug 2023 15:30:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qTNjB-0008Ax-Q9; Tue, 08 Aug 2023 15:30:29 +0100
Date:   Tue, 8 Aug 2023 15:30:29 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 0/2] net: stmmac: allow sharing MDIO lines
Message-ID: <ZNJRhSwu3rJl2Pkj@shell.armlinux.org.uk>
References: <20230807193102.6374-1-brgl@bgdev.pl>
 <54421791-75fa-4ed3-8432-e21184556cde@lunn.ch>
 <CAMRc=Mc6COaxM6GExHF2M+=v2TBpz87RciAv=9kHr41HkjQhCg@mail.gmail.com>
 <ZNJChfKPkAuhzDCO@shell.armlinux.org.uk>
 <CAMRc=MczKgBFvuEanKu=mERYX-6qf7oUO2S4B53sPc+hrkYqxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MczKgBFvuEanKu=mERYX-6qf7oUO2S4B53sPc+hrkYqxg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 04:09:11PM +0200, Bartosz Golaszewski wrote:
> On Tue, Aug 8, 2023 at 3:26 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, Aug 08, 2023 at 10:13:09AM +0200, Bartosz Golaszewski wrote:
> > > Ok so upon some further investigation, the actual culprit is in stmmac
> > > platform code - it always tries to register an MDIO bus - independent
> > > of whether there is an actual mdio child node - unless the MAC is
> > > marked explicitly as having a fixed-link.
> > >
> > > When I fixed that, MAC1's probe is correctly deferred until MAC0 has
> > > created the MDIO bus.
> > >
> > > Even so, isn't it useful to actually reference the shared MDIO bus in some way?
> > >
> > > If the schematics look something like this:
> > >
> > > --------           -------
> > > | MAC0 |--MDIO-----| PHY |
> > > -------- |     |   -------
> > >          |     |
> > > -------- |     |   -------
> > > | MAC1 |--     ----| PHY |
> > > --------           -------
> > >
> > > Then it would make sense to model it on the device tree?
> >
> > So I think what you're saying is that MAC0 and MAC1's have MDIO bus
> > masters, and the hardware designer decided to tie both together to
> > a single set of clock and data lines, which then go to two PHYs.
> 
> The schematics I have are not very clear on that, but now that you
> mention this, it's most likely the case.
> 
> >
> > In that case, I would strongly advise only registering one MDIO bus,
> > and avoid registering the second one - thereby preventing any issues
> > caused by both MDIO bus masters trying to talk at the same time.
> >
> 
> I sent a patch for that earlier today.
> 
> > The PHYs should be populated in firmware on just one of the buses.
> >
> > You will also need to ensure that whatever registers the bus does
> > make sure that the clocks necessary for communicating on the bus
> > are under control of the MDIO bus code and not the ethernet MAC
> > code. We've run into problems in the past where this has not been
> > the case, and it means - taking your example above - that when MAC1
> > wants to talk to its PHY, if MAC0 isn't alive it can't.
> 
> Good point, but it's worse than that: when MAC0 is unbound, it will
> unregister the MDIO bus and destroy all PHY devices. These are not
> refcounted so they will literally go from under MAC1. Not sure how
> this can be dealt with?

That has been a problem in the past, where a MII bus has been
registered by a driver, and then because its probe defers, the MII
bus gets torn down.

The "simple" solution to this is... try to avoid registering the MII
bus until you're sure that the probing will not defer. It is far from
perfect, since there's still the opportunity to unbind the driver
causing the MII bus to vanish along with the PHYs.

I have mentioned trying to address the issue of PHY drivers being
unbound in the past, and there's been some improvements with that,
but if the phy_device vanishes while something is using it, it
certainly will not end well. phylib is not the only case of this,
there are numerous instances of it. One of the recent ones that
I happened to be reminded of today is the pcs-rzn1-miic thing...
If you have a look at miic_create() and consider what would happen
if:

        if (!pdev || !platform_get_drvdata(pdev))
                return ERR_PTR(-EPROBE_DEFER);

 ... another thread ended up executing miic_remove() for this
    platform device at this very point ...

        miic_port = kzalloc(sizeof(*miic_port), GFP_KERNEL);
        if (!miic_port)
                return ERR_PTR(-ENOMEM);

        miic = platform_get_drvdata(pdev);
        device_link_add(dev, miic->dev, DL_FLAG_AUTOREMOVE_CONSUMER);

The devm allocation for "miic" would be freed, so either miic
ends up a stale pointer if it happened after this point, or
if miic_remove() completes, then platform_get_drvdata() returns
NULL and we oops the kernel here.

It's an unlikely race, but it's still a race. Sadly, the kernel
is getting riddled with things like this. I used to point these
things out, but having been shouted down many times I've given
up raising it.

Another example is the direct rendering manager bridge code
(drm_bridge).

I suggest a similar approach to not caring too much about this
for your own sanity... providing it doesn't actually cause a
problem!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
