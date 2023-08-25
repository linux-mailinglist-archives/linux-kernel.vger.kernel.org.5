Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526C5788E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjHYRvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239720AbjHYRvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:51:23 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31DB2698;
        Fri, 25 Aug 2023 10:51:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50091b91a83so1769342e87.3;
        Fri, 25 Aug 2023 10:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692985865; x=1693590665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+HU+lLtrZXHjuxL9OMB53dDboEIGrCqtI9QtLAZsZXw=;
        b=bPf7pvZMQaGW8LsKpCJEclLFrdjDybSKAlLkTvTBpVUP49fZxzWEQtnsT1tFtt1k+c
         RmcVLuLVoCFxzgbJ45KWX609MwhO5WUOo47aoBjUO5qmjitxYJqXm0OkLyVqzW1VABPM
         h5S+Yw26d3X9Ioa7aMZTk/FkKppqvEVwtuW639TO/BXVnpNaL6EOhDJt+kNCA8+7tvDc
         JSQiD8MCSRQWBIYrNGdsO8crZvA4CdYZaJc0vttVUSkNPdTgQ2LIFHDxlOzkj22fgrTz
         C+lN1W7x8EyA0viKeA75N8UcwEbwCzhSjKLI6apKFCxRq1mv2awsMN/Keqtu1pCtCT6a
         Ubew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692985865; x=1693590665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HU+lLtrZXHjuxL9OMB53dDboEIGrCqtI9QtLAZsZXw=;
        b=Dv8n8huIQ8dczZoex0pkRusXrqI8JNGyjSfFWUEIuWd4mteH6iIiEdaAXRCp+DoVxW
         FFuv9/qpOBQn8of2LdTx2V0zKbJlYqWewsPbdKiCPuAQ5w0bYsgktusGGqJFRb44kUT6
         jW6YINe5OvO0wV7cgOIP6Q5MX0SeYo5+s9XFNGDu1S4EVbPYRLQU1xro6hgxw1EPL72u
         LYacDvocQocRygs+gh5FT8v/Y3WJL8HDM9OIbXaBJxYfVt6DurqCnccj+BtZn2V/lJyd
         mNzs1lnNj+Q8uCRy9/T01V55Zxi35IsVX4KfYseOO4tWxiwQ7z4KkzDwVDCppp/XuMCu
         wDeg==
X-Gm-Message-State: AOJu0YyUZTLBgLu6UMFvQP27vk0mVwy1BXGGR8HYCErjaF7W+KR9hfHu
        9xkaLpDuUAY5btopdaI4gQ8=
X-Google-Smtp-Source: AGHT+IEkrzjdqgRY4pQ3wcJMRIKWGmZqSszGLKO0Gd865Lj0vSC09gMrcs5hGCR1SX9F79qQgdSAfQ==
X-Received: by 2002:a05:6512:3ae:b0:500:8f65:c624 with SMTP id v14-20020a05651203ae00b005008f65c624mr7265415lfp.53.1692985864553;
        Fri, 25 Aug 2023 10:51:04 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id r4-20020ac24d04000000b004fbab4b7d45sm365806lfi.67.2023.08.25.10.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 10:51:03 -0700 (PDT)
Date:   Fri, 25 Aug 2023 20:51:00 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Rohan G Thomas <rohan.g.thomas@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: Synopsis XLGMII MAC, IEEE 802.3 and XLGMII interfaces
Message-ID: <6r43uvb5jdyga5afsxonagta4ygsyxamyc53lijow5jd7sirdf@w7z54rn5ljiv>
References: <ZOXlpkbcAZ4okric@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOXlpkbcAZ4okric@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russel

On Wed, Aug 23, 2023 at 11:55:34AM +0100, Russell King (Oracle) wrote:
> Hi,
> 
> Okay, I think it's time to get to the bottom of this, and below are my
> ramblings so far.

Thanks for the raised topic. Especially the last part which was very
actual in my recent work.

Regarding DW XLGMAC. Alas it's the only DW MAC IP-core for which I
currently don't have a databook. So I'll respond to you based on my
experience working with the DW GMAC/XGMAC/XPCS hardware and with the
STMMAC+XPCS drivers.

> 
> According to IEEE 802.3 80.1.3, XLGMII is the 40 Gb/s MII and CGMII
> is the 100 Gb/s MII. 81.1 goes on to state:
> 
> The XLGMII/CGMII has the following characteristics:
> 
>   a)    The XLGMII supports a speed of 40 Gb/s.
>   b)    The CGMII supports a speed of 100 Gb/s.
>   c)    Data and delimiters are synchronous to a clock reference.
>   d)    It provides independent 64-bit wide transmit and receive data paths.
>   e)    It supports full duplex operation only.
> 
> That seems very clear.

Right.

> 
> According to
> https://www.synopsys.com/dw/ipdir.php?ds=dwc_ether_enterprise_mac
> XLGMII operates at 25 Gb/s, 40 Gb/s, 50 Gb/s and 100 Gb/s. This
> appears to "disagree" with IEEE 802.3.
> 
> It appears, at least to me, that CGMII and XLGMII are physically
> similar interfaces, the only difference seems to be the speed of
> operation, so it would be entirely possible to have a MAC that
> can operate at both speeds - or indeed at other speeds such as
> Synopsys' "XLGMII" MAC.

DW XLGMAC IP-core supports three various sub-interfaces (see at the
bottom of the page in the link you cited): "Interfaces to the PHY layer
through a configurable interface supporting XLGMII/CGMII, XGMII or
GMII interface". Based on what is done in the DW XGMAC I assume that
it's either the same physical port which signals are somehow
multiplexed for working with different protocols or just separate
physical interfaces which can't work simultaneously but can be
connected to a PCS/PMA in a SoC/platform-dependent way. At least
that's the way the XGMII and GMII interfaces are implemented on the DW
XGMAC IP-core: either they are multiplexed on the same wires or the
GMII port is separately synthesized within the same MAC.

The XLGMII and CGMII interfaces are indeed similar the only difference
is speed which most likely is regulated by means of the reference
clock (TX_CLK/RX_CLK) rate which by IEEE 802.3 C81 shall be just
"one-sixty-fourth of the MAC transmit/receive data rate". So it's
625MHz for XLGMII and 1.5625GHz for CGMII. From that perspective
nothing prevents a vendor to implement an XLGMII/CGMII interface
working with any speed. For instance the 50/25Gbps speeds can be
reached just be halfing the base 100Gbps value.

XGMII and GMII are a bit different story. Physically they represent
completely different interfaces. But as I noted earlier DW XGMAC can
be synthesized with having these interfaces being either multiplexed
in a single port or provided as separate ports. But in both cases only
a single interface can be activated at a time.

The most modern DW XGMAC IP-core document I have is of v2.11a
(released at 2015). It states that the controller can expose two
interfaces: XGMII working with 10Gbps and GMII working with 2.5Gbps
and 1Gbps (that's what the STMMAC driver had supported before commit
5b0d7d7da64b ("net: stmmac: Add the missing speeds that XGMAC
supports")). Moreover in order for all those GMII speeds to work
correctly first XGMAC_TX_CONFIG must have the respective field updated
_and_ the clk_tx_156pt25_i reference clock must be driven with
312.5-MHz clock for 2.5G mode and with 125-MHz clock for 1G mode
(312.5 / 2.5 = 125).

Note my HW databook doesn't say anything about the XGMII 5.0/2.5Gbps and
MII 100/10Mbps modes. But seeing Jose added them in 2019 to the STMMAC
driver most likely these modes were introduced later perhaps in v3.x
or in the latest v2.x IP-cores. I bet these speeds are configured in
the same way as the GMII modes described above: set the respective
mode in the XMGAC_TX_CONFIG register (added by Jose) and drive the
reference clock with specific rate (it's platform-specific setting).

Considering all the above it's most likely DW XLGMAC works in a
similar way for the various speeds: XLGMII/CGMII - 100/50/40/25Gbps.
At least based on the available in the STMMAC
(drivers/net/ethernet/stmicro/stmmac) and Synopsys DW XLGMAC
(drivers/net/ethernet/synosps) code, the only thing that needs to be
done is to set the respective mode in the MAC Tx Control register. The
reference clock update is likely a platform-specific thing. Seeing
there is no any glue-driver available in kernel supporting DW XLGMAC
alas we can't proof the later statement.

Finally consolidating all of the above we can now get a notion about
the way the DW XGLMAC working in all the modes: XLGMII/CGMII
100/50/40/25Gbps, XGMII 10/5/2.5/1Gbps, GMII/MII 1000/100Mbps.

> 
> Now, the problem is... phylink interprets PHY_INTERFACE_MODE_XLGMII
> to mean the IEEE 802.3 defined 40 Gb/s mode - in that it _only_
> supports 40 Gb/s over that interface mode. Clearly, that's the right
> thing to be doing, because this is what IEEE defines and vendor
> stuff doesn't apply for generic code.
> 
> phylib hasn't defined PHY_INTERFACE_MODE_CGMII yet, so phylink doesn't
> provide that (maybe it should.) However, when it does, phylink will
> then allow 100 Gb/s over CGMII.
> 
> Are there other standards that define 25 and 50 Gb/s over an XLGMII-
> like link?

I failed to find any. So my bet these are the Synopsys-specific speed
modes.

> 
> Given the way things are at present, it means that the switch statement
> in stmmac_mac_link_up() for PHY_INTERFACE_MODE_XLGMII, only one case
> will ever be used - SPEED_40000. I'm guessing this isn't a problem as
> no one has reported any problems.

No one has reported any problems because there seems to be no actual
user of that STMMAC code in the kernel. There is no DT-bindings
defined, there is no DW XLGMAC specific compatible string defined,
there is no any xlgmac/xgmac glue-driver added. So IMO one of the
next situation might be relevant in this case:
1. Jose tested out the submitted XLGMAC patch with having a generic
"snps,dwgmac" or "snps,dwxgmac"-compatible node defined, made sure
it's working for the 40Gbps speed and that was it.
2. Alternatively are you sure the speed is validated before being
passed to the stmmac_mac_link_up() in the phylink_resolve() method
after the Auto-negotiation is finished?

Regarding the generic questions you raised before. IMO:
1. PHY_INTERFACE_MODE_CGMII should be defined with at least 100Gbps
speed allowed.
2.1 Either "xlgmii" and "cgmii" interfaces need to be extended with
wider speed settings but being marked with an in-situ comment that
these are vendor-specific speeds,
2.2 or some new interfaces could be defined like
"xlgmii-ext"/"cgmii-ext" or even "xxvgmii"/"lgmii" with the extended
set of speeds.

As for me option 2.1 seems much better but we need to decide to what
interface the vendor-specific speeds are supposed to be added. I can't
say for sure what interface Synopsys DW XLGMAC defines as working with
25/50Gbps speeds especially seeing XLGMII and CGMII are physically
compatible with only reference clock different. So IMO CGMII looks a
bit more suitable for them since those speeds are the direct quotient
of 100Gbps - base CGMII interface speed.

> 
> Then... there's the inclusion of 10G, 2.5G and 1G in the XLGMII switch.
> The above link to Synopsys website suggests that XGMII is used for 10G
> and GMII for 1G.

As I explained above XGMII interface can work with the 10/5/2.5Gbps speeds
and GMII - with the 2.5/1Gbps speeds. I have doubts these speeds need
to be added to the XLGMII/CGMII interface modes.

> 
> Given that this is just the MAC, and we would normally have a PCS after
> it (which may be XPCS), the interface used between the MAC and PCS isn't
> all that relevant, since PHY_INTERFACE_MODE_xxx primerily defines the
> interface to any PHY that is connected, and as a secondary function the
> interface to fiber (since [MAC - PCS - Serdes] - PHY - media and
> [MAC - PCS - Serdes] - media are common, it has made sense to use the
> PHY interface mode to define the protocol used on that part of the
> link that a PHY _could_ be connected to.)
> 
> So, I'm not convinced that the fact that this MAC core uses XLGMII,
> XGMII and GMII has any relevance to the PHY_INTERFACE_MODE_ passed
> by phylink into functions such as stmmac_mac_link_up(), _unless_ a
> PHY is connected directly to the MAC.
> 
> If XPCS is connected, that interface mode would be whatever XPCS is
> using to talk to the "outside world" not what the connection is
> between the MAC and XPCS.

That's what I thought too and that's exactly the issues I met a few
months ago while I was working on adding the XGMII interface support
to the XPCS driver. After a lot of digging into the problem I came to
the next semantics implemented in the STMMAC and XPCS drivers:

1. XLGMII - phy-mode only activates C73 AN,
            PHY-less setup is only supported.
   Basically the mode is utilized to activate the C73
   Auto-negotiation. So after it's finished the respective speed
   would be set in DW XLGMAC registers. Seeing PHY can't be attached
   in this setup the interface mode isn't that relevant except it
   just makes the PHY-link core and the XPCS driver creating a proper
   supported link-modes field and activate respective speed in the
   MAC.

   IMO seeing this PHY-mode doesn't imply external PHY attached and always
   activates Clause 73 auto-negotiation, this MAC-PCS interface mode is useful
   for the "Backplane" setups when you have XLGMAC/XPCS/PMA directly attached
   to a network fabrics and you actually don't know what physical link
   mode is there. At least that's the way I decided to implement for
   the "xgmii" PHY-mode support in the DW XPCS driver: it doesn't imply
   any external PHY detected and initialized, it just activates the
   C73 auto-negotiation and re-configures XPCS from 10GBase-R, to
   10GBase-KX4, to 1000Base-X until the link gets up or fails. Though in
   that case DW XPCS needs to have some CSR updated to get different
   modes activated. There is no any similar setups (for instance in
   order to switch between Base-KR, Base-KR2 and Base-KR4 looking for
   a supported physical link) performed in the "xlgmii" mode
   implementation in the driver.

Here are some other my observations I came up to on my way of the
STMMAC/XPCS drivers alteration:

2. 1000Base-X, SGMII - phy-mode indicates PCS/PMA<=>PHY interface,
                       PHY and PHY-less setups are supported.
   No problem with that. There are both AN and actual PCS setups in
   the driver.

3. 2500Base-X - phy-mode indicates PCS/PMA<=>PHY interface,
                PHY and PHY-less setups are supported.
   No series problem with this too except in fact this mode doesn't
   imply auto-negotiation but has Autoneg flag set. Most likely it's
   needed to prevent the pcs_validate() method to clear out the external
   PHY link-mode Autoneg flag.

4. USXGMII - phy-mode indicates PCS/PMA<=>PHY interface,
             PHY-less setup is only supported.
   DW XGMAC actually doesn't support USXGMII interface, instead
   it has a multi-protocol port(s) XGMII/GMII/MII as I noted before.
   So the only thing that is required for the MAC is to activate the
   respective interface and speed by means of the MAC Tx Control
   register. The rest is supposed to be done by the DW XPCS/PMA/PHY
   IP-cores chain: https://www.synopsys.com/dw/ipdir.php?ds=dwc_multi_protocol_10g_phy
   It seems weird why this mode doesn't permit an external PHY
   attached but only relies on the auto-negotiation.

5. 10GBase-KR - phy-mode only activates C73 AN,
                PHY-less setup is only supported.
   This mode is very weird. First it isn't supported by the STMMAC
   driver. Second no actual PCS setup is performed except the
   auto-negotiation ones. So the XPCS driver relies on the default
   device state. Third both PHY-mode and the link-modes match. It's
   kind of strange seeing no PHY is implied by the STMMAC driver
   in this case. I failed to find any NIC driver in kernel which
   would have XPCS attached and have the PHY_INTERFACE_MODE_10GKR mode
   supported. So at the first glance this mode support seems redundant.

6. Another questionable part in the XPCS driver is the way the
   pcs_validate() method is implemented. In case of the platform with
   an external PHY available it filters out all the link-modes the PHY
   can advertise including the actual physical link modes. It doesn't
   look correct especially in case of 2. and 3. IMO this filtering should
   have been activated only on the PHY-less systems only or even dropped
   seeing none of the PCS driver do that.

I might have missed something but I failed to find a well
justification at the very least to the entries 5 and 6.

> If we want to know what that is, then
> stmmac needs to be asking XPCS for that information (and maybe
> phylink needs to get that from its PCS on behalf of the MAC driver.)

My thoughts about this is in the entry 1 above.

-Serge(y)

> 
> I think there's a lot that needs to be thought about here.
> 
> Part 2 of this will be USXGMII... which I'll do as a separate email.
> 
> Thanks.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
