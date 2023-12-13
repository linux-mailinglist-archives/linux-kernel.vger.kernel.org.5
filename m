Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDBD81122C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379250AbjLMM4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379215AbjLMM4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:56:10 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DCBEA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:56:11 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 4BDB2240108
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 13:56:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1702472168; bh=Ja35sRH73MLPHXYRUj6azr9TKoxuU7Yk//SKbBsoIxk=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Disposition:From;
        b=Yb3xoDFxqb8xCIFjMoLLFjCaI6T/lGldLdz07M5ByoX4HkuSJII21L8Dyu6XtsnAI
         6M/u2fZ8YGwxKNfzjLHMedYroM+pyfGbU0vIrP99a0c8ar3Zzp7TLbc8fH+a9I5FjK
         R/pjlM3iQd25ECn1Az8BmlFsyF33qe3sa7ipQtUI1Pi8M6cc1XucAzbxq9Ab+3HcJi
         5B4fiIA6Emuq/seaT/bLwz/UuWVLhZcOHZRiWR+zIdki6K7SuJTjQwJ1WH932dGJRi
         7BKuKUj1uLuSGg/Knqj2gW7RemwSS6wHzidmq3zt27Kil8e/QHnl3VimGbo1MzTjfI
         N1U91yikLAF6A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4SqwTG3HMsz6tyd;
        Wed, 13 Dec 2023 13:56:01 +0100 (CET)
Date:   Wed, 13 Dec 2023 12:55:58 +0000
From:   Anne Macedo <retpolanne@posteo.net>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Allwinner sunXi SoC support" 
        <linux-sunxi@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH] arm64: dts: allwinner: Orange Pi One Plus PHY support
Message-ID: <cm5e7g2ozviyin6p3dh2qtuh4i3f2sbqq4c2arjtdektgk7i6c@l7aawekyj6t2>
References: <20231212122835.10850-2-retpolanne@posteo.net>
 <20231212162200.10b3868b@donnerap.manchester.arm.com>
 <axsvii25yrknfae6gdreti7lcskoscsdbsujwuispiieimsbdy@gwzm4l7mwlew>
 <20231213013544.2fc7e0d1@minigeek.lan>
 <ceuoq3xxgb5kkel7e7wqpslcg7h6dde3wgdqhyo7jgop6owovk@5a76ks5fiun4>
 <20231213122523.219cbfc0@donnerap.manchester.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213122523.219cbfc0@donnerap.manchester.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 12:25:23PM +0000, Andre Przywara wrote:
> On Wed, 13 Dec 2023 11:02:39 +0000
> Anne Macedo <retpolanne@posteo.net> wrote:
> 
> Hi Anne,
> 
> > On Wed, Dec 13, 2023 at 01:35:44AM +0000, Andre Przywara wrote:
> > > On Tue, 12 Dec 2023 19:27:14 +0000
> > > Anne Macedo <retpolanne@posteo.net> wrote:
> > > 
> > > Hi Anne,
> > >   
> > > > On Tue, Dec 12, 2023 at 04:22:00PM +0000, Andre Przywara wrote:  
> > > > > On Tue, 12 Dec 2023 12:28:30 +0000
> > > > > Anne Macedo <retpolanne@posteo.net> wrote:
> > > > > 
> > > > > Hi Anne,
> > > > >     
> > > > > > Adds compatible values to mdio subnodes for Ethernet PHY representing
> > > > > > Realtek 8211 PHY to Orange Pi One Plus.    
> > > > > 
> > > > > So can you state why this would be needed? This is the RTL8211 ID,    
> > > > 
> > > > Apologies, I completely forgot to include some context. 
> > > >   
> > > > > right? Which should be autodetected via MDIO. Looking back in my inbox
> > > > > you proposed this change before, for U-Boot, specifically, but I fail to
> > > > > find a solution or explanation what really happens here. Two Renesas .dts
> > > > > files have the same compatible, and the commit message talks about the
> > > > > reset line there, is this related?
> > > > > 
> > > > > So can you please give some more background and explanation? That would be
> > > > > part of a good commit message anyway ("why", not "what").    
> > > > 
> > > > Should I resend the commit with a more meaningful explanation? The
> > > > context is the following:
> > > > 
> > > > currently, ethernet doesn't seem to work on both u-boot and Linux on the
> > > > Orange Pi One Plus board. 
> > > > 
> > > > On the kernel, this error shows up:
> > > > 
> > > > Configuring network interfaces... [    5.992589] dwmac-sun8i 5020000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
> > > > [    6.000823] dwmac-sun8i 5020000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -19)
> > > > 
> > > > After applying this fix, the PHY gets attached: 
> > > > 
> > > > Configuring network interfaces... [    6.060020] dwmac-sun8i 5020000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
> > > > [    6.069460] dwmac-sun8i 5020000.ethernet eth0: PHY [stmmac-0:01] driver [RTL8211E Gigabit Ethernet] (irq=POLL)
> > > > 
> > > > The previous compatible list that had ethernet-phy-ieee802.3-c22 fails
> > > > to find a PHY, so this patch includes the correct PHY ID with the
> > > > RTL8211 ID. 
> > > > 
> > > > The behaviour is described on [1].  
> > > 
> > > So this is all an observation, but no real explanation, isn't it?  
> > 
> > I've made some analysis on [3] on this bug, but it was based solely on
> > u-boot. I was having trouble with the regulator and on u-boot nothing
> > would trigger the GPIO PD6 and the vcc-gmac-3v3 regulator, so the NIC
> > was completely dead. Next I did an analysis based on [2] because the
> > u-boot PHY initialization was flaky.
> > 
> > > To cite [1]: "If the PHY reports an incorrect ID (or none at all) ...".
> > > I am pretty sure this is not the case here, instead we are looking at
> > > some missing platform bits, like a missing clock, reset, or most likely
> > > regulator. Or one of the existing resources is wrongly assigned or  
> > 
> > As I mentioned, PHY initialization is flaky on u-boot, so maybe that
> > assumption is correct. 
> > 
> > > configured? If the PHY is not (yet?) powered correctly when the code
> > > does the auto-detection via the MDIO bus, then the initialisation would  
> > 
> > If I recall correctly (I don't know if I kept it in my notes :c), that
> > could be the case. regulator-boot-on makes the NIC work (LEDs blink, at
> > least) but it doesn't get initialized. 
> > 
> > > fail. But since it works when overriding the auto-detection, I feel
> > > like we are papering over something here.
> > > Do you have the schematics for this board? I can only find the one for
> > > the Orange Pi Plus 2E, and I don't know how similar those two are. This
> > > shows *two* regulators, but both are activated by the same GPIO.  
> > 
> > I do. It's available on [4]
> 
> Oh damn it, I got lost in Orange Pi's naming maze again - and was looking
> for the wrong board! So thanks for the link, and this clears things up!

Yay! 

> 
> So yes, the Orange Pi *One* Plus, much like the Orange Pi 3, uses *two*
> regulators for Ethernet: one 3.3V from the PMIC's ALDO2 rail to power the
> PHY, and a discrete 2.5V regulator, enabled by GPIO PD6, for the voltage

Oh! I didn't know about the PMIC's ALDO2.

> level on the MDIO lines. On top of this there is a reset line for the PHY,
> though this is held up by a pull-up resistor, so it *should* work,
> although we should describe this in the DT.

Noting here to take a look at the reset line so I can add it as well to
the DT.

> 
> So the DT looks wrong then: The reg_gmac_3v3 is actually a 2.5V regulator,
> and phy-supply is aldo2. I think it was done the way it is to somehow make
> it work with the current DT binding and code, which just supports one
> regulator. And aldo2 is referenced as the source of reg_gmac_3v3, which
> smells like another hack to me.

	reg_gmac_3v3: gmac-3v3 {
		compatible = "regulator-fixed";
		regulator-name = "vcc-gmac-3v3";
		regulator-min-microvolt = <3300000>;
		regulator-max-microvolt = <3300000>;
		startup-delay-us = <100000>;
		enable-active-high;
		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
		vin-supply = <&reg_aldo2>;
	};

Interesting, I see the reg_aldo2 on vin-supply for reg_gmac_3v3. I don't
understand how it works, is it linking the regulator with the ALDO2 but
it also enables the PD6 GPIO?

> 
> > > It would also be interesting to see if any of Corentin's work for the
> > > Orange Pi 3 helps here?  
> > 
> > Adding [5] for reference here, thanks! Will check it out. 
> 
> This is an older version, there are actually updates. And he also mentions
> your board as well, so I think it just can sail in the wake of the OPi 3
> Ethernet enablement.
> 
> Can you try if this change, just applied to your .dts instead, works?
> https://github.com/montjoie/linux/commit/cf6e192eca1d59be630e6729d2cef9e897b3da8c

Will do! I'll be out of my lab today but will try it at night Brazil
time. 
> 
> Cheers,
> Andre
> 
> P.S. Is there any chance where I can reply/comment on your blog? It seems
> like I can clear some things up...

Please send me suggestions off thread, the blog is a static GHPages
blog, so I didn't implement replies yet. I will be happy to include them
to my notes :) 

> 
> > [3] https://blog.retpolanne.com/hardware/embedded/2023/07/07/embedded-phy.html
> > [4] https://linux-sunxi.org/images/7/7c/OrangePi_OnePlus_Schematics_v2.0.pdf
> > [5] https://lore.kernel.org/netdev/20220509074857.195302-1-clabbe@baylibre.com/
> > 
> > Regards, Anne
> 

Regards, Anne
