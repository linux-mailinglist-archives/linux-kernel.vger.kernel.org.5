Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6E879DD7B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238018AbjIMBWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjIMBV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:21:59 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C5C10E6;
        Tue, 12 Sep 2023 18:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=6zXsjXXg4yAxPy7RTYj+3TPJv5GOPPfAy0rQXae3yUw=; b=RK94NkYKrPO8rFX0Ykdbce0JCi
        Sc3JDva8axrlw4H6CDU2Lrz/PVJCqC5kgEFFtz4QBUZTgOnP12qTIlxbel5EJK5ggAwi/X9hr3Z62
        lWRhMeAFQhAf3c9gUZJC/PcFmTRrXKjiacyiUtqJQixe13gn9l2o8bIyIOhz2wjnDd7M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qgEZL-006Gpu-HU; Wed, 13 Sep 2023 03:21:27 +0200
Date:   Wed, 13 Sep 2023 03:21:27 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mithat.guner@xeront.com,
        erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: document internal MDIO bus
Message-ID: <c7eddf45-c259-47de-ac59-2569c09ed5f7@lunn.ch>
References: <20230812091708.34665-3-arinc.unal@arinc9.com>
 <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <20230813112026.ohsx6srbt2staxma@skbuf>
 <8a8e14f1-0493-4298-a2cc-6e7ae7929334@arinc9.com>
 <20230813190157.4y3zoro53qsz43pe@skbuf>
 <f5f468c1-b5a2-4336-b1d9-fd82da95b21d@arinc9.com>
 <617c51cf-2c09-4865-ac60-96599db597e7@lunn.ch>
 <563ac27a-22f2-463e-b5c1-9df721842976@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <563ac27a-22f2-463e-b5c1-9df721842976@arinc9.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > The marvell switch can have up to 2 MDIO busses. If i remember
> > correctly, there is also one switch which has one MDIO bus per port.
> 
> I'm writing the json-schema for Marvell switches. I've checked a few
> devicetree source files on Linus's Linux tree, I only see two buses used at
> the most.

Sorry, i was ambiguous. Its not a Marvell switch which can have one
MDIO bus per port. I don't remember which switch it is, and it might
be a pure switchdev switch, not a DSA switch.

> The internal bus and another bus with
> marvell,mv88e6xxx-mdio-external. I've never seen a devicetree with
> marvell,mv88e6250 though. Could the switch that has one MDIO bus per port
> be this one? Also, is every bus of this switch a
> marvell,mv88e6xxx-mdio-external bus or, one internal bus and the remaining
> are marvell mv88e6xxx-mdio-external buses?

Only the 6390 family has two busses. It has an internal MDIO bus with
the same register API as all the other switches. However, unlike the
other families, it is not exposed on pins. And the 6390 has a second
MDIO bus using a slight variant of the registers, which is connected
to the outside world via pins. This second bus then has a compatible
to separate it from the normal MDIO bus.

	Andrew
