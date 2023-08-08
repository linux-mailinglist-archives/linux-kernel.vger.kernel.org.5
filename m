Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B631774817
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjHHT0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbjHHTZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:25:55 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBE180B1;
        Tue,  8 Aug 2023 11:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2g3utr/eujTjRaQIcLvNeTDh3WTi5rEqtO34hdQFdT0=; b=feMXlHseapYWghPVTJHdmZssl3
        eciqABRWVwnQp/E6K8PCedielRvsbcw4dRtXbsJx9wtIOcfBcpecqr/Y96PrFtlqGbw/fvpeARePk
        VrGvx1L8Iwxkwl+oLu6WfXlu3s1MZGJIvGQPEKIlPBx0wBjc8R9IPt+gOkpP/1lxZy9/VtXdc6iHC
        tVaH1INRn4PlNVJyzqGt+Fll1SHqzz/MY1vONsQEelXeVHjjRwLia+738lj2OdLLU41e9LnLmpwCN
        W0VzF58ExqPFfhCeMBahj4E2RyFvg3Q3Ozf5g99pcX/bp7OmeyhlW3uTx4hM6/JqRh312Dn/KsWCn
        8g3m1x+g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47552)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qTOLw-00009S-1Q;
        Tue, 08 Aug 2023 16:10:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qTOLu-0008DC-75; Tue, 08 Aug 2023 16:10:30 +0100
Date:   Tue, 8 Aug 2023 16:10:30 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Andrew Lunn <andrew@lunn.ch>,
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
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 0/2] net: stmmac: allow sharing MDIO lines
Message-ID: <ZNJa5qyYFngghiGc@shell.armlinux.org.uk>
References: <20230807193102.6374-1-brgl@bgdev.pl>
 <54421791-75fa-4ed3-8432-e21184556cde@lunn.ch>
 <CAMRc=Mc6COaxM6GExHF2M+=v2TBpz87RciAv=9kHr41HkjQhCg@mail.gmail.com>
 <ZNJChfKPkAuhzDCO@shell.armlinux.org.uk>
 <CAMRc=MczKgBFvuEanKu=mERYX-6qf7oUO2S4B53sPc+hrkYqxg@mail.gmail.com>
 <65b53003-23cf-40fa-b9d7-f0dbb45a4cb2@lunn.ch>
 <CAMRc=MecYHi=rPaT44kuX_XMog=uwB9imVZknSjnmTBW+fb5WQ@mail.gmail.com>
 <xfme5pgj4eqlgao3vmyg6vazaqk6qz2wq6kitgujtorouogjty@cklyof3xz2zm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xfme5pgj4eqlgao3vmyg6vazaqk6qz2wq6kitgujtorouogjty@cklyof3xz2zm>
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

On Tue, Aug 08, 2023 at 09:44:16AM -0500, Andrew Halaney wrote:
> On Tue, Aug 08, 2023 at 04:30:05PM +0200, Bartosz Golaszewski wrote:
> > On Tue, Aug 8, 2023 at 4:25 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > > > On Tue, Aug 08, 2023 at 10:13:09AM +0200, Bartosz Golaszewski wrote:
> > > > > > Ok so upon some further investigation, the actual culprit is in stmmac
> > > > > > platform code - it always tries to register an MDIO bus - independent
> > > > > > of whether there is an actual mdio child node - unless the MAC is
> > > > > > marked explicitly as having a fixed-link.
> > > > > >
> > > > > > When I fixed that, MAC1's probe is correctly deferred until MAC0 has
> > > > > > created the MDIO bus.
> > > > > >
> > > > > > Even so, isn't it useful to actually reference the shared MDIO bus in some way?
> > > > > >
> > > > > > If the schematics look something like this:
> > > > > >
> > > > > > --------           -------
> > > > > > | MAC0 |--MDIO-----| PHY |
> > > > > > -------- |     |   -------
> > > > > >          |     |
> > > > > > -------- |     |   -------
> > > > > > | MAC1 |--     ----| PHY |
> > > > > > --------           -------
> > > > > >
> > > > > > Then it would make sense to model it on the device tree?
> > > > >
> > > > > So I think what you're saying is that MAC0 and MAC1's have MDIO bus
> > > > > masters, and the hardware designer decided to tie both together to
> > > > > a single set of clock and data lines, which then go to two PHYs.
> > > >
> > > > The schematics I have are not very clear on that, but now that you
> > > > mention this, it's most likely the case.
> > >
> > > I hope not. That would be very broken. As Russell pointed out, MDIO is
> > > not multi-master. You need to check with the hardware designer if the
> > > schematics are not clear.
> > 
> > Sorry, it was not very clear. It's the case that two MDIO masters
> > share the MDC and data lines.
> 
> I'll make the water muddier (hopefully clearer?). I have access to the
> board schematic (not SIP/SOM stuff though), but that should help here.
> 
> MAC0 owns its own MDIO bus (we'll call it MDIO0). It is pinmuxed to
> gpio8/gpio9 for mdc/mdio. MAC1 owns its own bus (MDIO1) which is
> pinmuxed to gpio21/22.
> 
> On MDIO0 there are two SGMII ethernet phys. One is connected to MAC0,
> one is connected to MAC1.
> 
> MDIO1 is not connected to anything on the board. So there is only one
> MDIO master, MAC0 on MDIO0, and it manages the ethernet phy for both
> MAC0/MAC1.
> 
> Does that make sense? I don't think from a hardware design standpoint
> this is violating anything, it isn't a multimaster setup on MDIO.

That all sounds sane, thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
