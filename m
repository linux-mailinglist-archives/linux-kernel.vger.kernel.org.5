Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A188A7AA5A6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 01:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjIUXas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 19:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIUXar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 19:30:47 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7B18F;
        Thu, 21 Sep 2023 16:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=cTXKwjxtldkfqXx+SXk/6A/UnwSLoK4UrexStTF47tk=; b=mA
        PFKnKwZNfEAUXq9Vl812F9mSnn7XT/oV04Fnon/LzgqN7yAlSl68OROHuZmgfman10e1tUw/f6Vja
        DparwyGO4juYkofrJrC+UuUpDENXJroLSr7l2FzDTqmPrfhVx9duW7bJj+I3ArMyUEzZSC3ViUseA
        8C2rW8sML3oYYds=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qjT7L-0078ta-H8; Fri, 22 Sep 2023 01:29:55 +0200
Date:   Fri, 22 Sep 2023 01:29:55 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        George McCollister <george.mccollister@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Marek Vasut <marex@denx.de>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Crispin <john@phrozen.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v2 07/10] dt-bindings: net: enforce phylink
 bindings on certain ethernet controllers
Message-ID: <8935d431-be0c-43e0-a908-f7dff2048f7c@lunn.ch>
References: <20230916110902.234273-1-arinc.unal@arinc9.com>
 <20230916110902.234273-8-arinc.unal@arinc9.com>
 <20230918181319.GA1445647-robh@kernel.org>
 <16710cf9-8911-4fed-8e2d-b19b581446c1@arinc9.com>
 <a8d49992-4fa8-4a9f-b954-79011a3040a8@lunn.ch>
 <85cc3b27-417e-4cf4-9f77-347a338c9d67@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85cc3b27-417e-4cf4-9f77-347a338c9d67@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 09:21:40PM +0300, Arınç ÜNAL wrote:
> On 21.09.2023 16:00, Andrew Lunn wrote:
> > > - Link descriptions must be required on ethernet controllers. We don't care
> > >    whether some Linux driver can or cannot find the PHY or set up a fixed
> > >    link without looking at the devicetree.
> > 
> > That can lead to future surprises, and breakage.
> > 
> > Something which is not used is not tested, and so sometimes wrong, and
> > nobody knows. Say the driver is extended to a new device and actually
> > does need to use this never before used information. You then find it
> > is wrong, and you get a regression.
> > 
> > We have had issues like this before. There are four rgmii phy-link
> > modes. We have had PHY drivers which ignored one of those modes, it
> > silently accepted it, but did not change the hardware to actually use
> > that mode. The PHY continues to use its reset defaults or strapping,
> > and it worked. A lot of device trees ended up using this mode. And it
> > was not the same as reset defaults/strapping.
> > 
> > And then somebody needed that fourth mode, and made it actually
> > work. And all those boards wrongly using that mode broke.
> > 
> > The lesson i learned from that episode is that anything in device tree
> > must actually be used and tested.
> 
> It looks like the root cause here was the lack of dt-bindings to
> only allow the phy-mode values the hardware supports.

That would not help. The hardware supported all 4 RGMII modes. So
listing all four in the dt-binding would be correct. But the driver
for the hardware had a bug, and so silently ignored one of the
modes. That then masked the bugs in board DT files.

> What I see here is the driver change should've been tested on all
> different hardware the driver controls then the improper describing
> of hardware on the devicetree source file addressed.

Which is what did happen. But it took a while to find all those broken
boards.  For a period of time, we had regressions.

Bugs happen. It is a fact of life. But we want those bugs to be easy
to find as possible. If we force DT writers to add properties which
the driver never uses, they are going to be bugs in those
properties. And those bugs are not going to be easy to find, and quite
likely, they will only be found a long time after they are added. We
should not be adding unused properties and bugs just to keep a yaml
checker happy.

	Andrew

