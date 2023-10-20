Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584297D0B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376612AbjJTJNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376600AbjJTJNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:13:22 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDB2D51;
        Fri, 20 Oct 2023 02:13:19 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C4A5D1BF204;
        Fri, 20 Oct 2023 09:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1697793197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bx7ZRkz0a0dqCLmu+56GfvXdIrUJcnhPCzJDePZ7gDw=;
        b=F6UoGv6FopBzZfDliMmees9tsQVobr1kV2qymReDVkFHsU2l/x0m59HEUZ4h0+4EqQHdBC
        NVx/qVwB0kAB7XsnrA362qUkw/1BNKTFjPMwRuTDC9lmgVsq+Taar4O71UywfwSjmzmYWh
        6kf7CMXwCYXGD1RCdHV7MW9QVg8job22XIwQIHfsq3shVnoZYzGG546Nqfac1DgB8t2Y+/
        SqslCDg9ZkJj+NdsFheT04rBwmyj7c/0F0r8kWYCIyW2T72JbSEneKcuYovufgESLbfqVR
        h8pMTYWPRezwFq274XEr56faPc7cyO9kqf4+44Y9v7myepuh/joEmAOlo6229g==
Message-ID: <4da86f94-c272-4e45-bd1d-bd52d0a01a81@arinc9.com>
Date:   Fri, 20 Oct 2023 12:13:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 6/7] dt-bindings: marvell: Rewrite MV88E6xxx
 in schema
To:     Vladimir Oltean <olteanv@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-6-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-6-3ee0c67383be@linaro.org>
 <20231019153552.nndysafvblrkl2zn@skbuf>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231019153552.nndysafvblrkl2zn@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.10.2023 18:35, Vladimir Oltean wrote:
> Yikes, both these examples are actually broken, for a reason that was
> extensively discussed with Arınç in the past, and that he tried to
> automatically detect through dt-schema but was ultimately told it's too
> complicated.
> https://patchwork.kernel.org/project/netdevbpf/cover/20230916110902.234273-1-arinc.unal@arinc9.com/

True, and then I've figured that that approach was wrong from the start.
Read below.

> 
> Long story short: the "mdio" node is also the ds->slave_mii_bus (soon to
> be ds->user_mii_bus after Florian's inclusivity changes). Having a
> slave_mii_bus makes DSA know what to do with port nodes like this, which
> don't have an explicit phy-handle:
> 
> 	port@3 {
> 	    reg = <3>;
> 	    label = "lan4";
> 	};
> 
> but actually, call phy_connect() on the ds->slave_mii_bus at address 3
> (the port "reg").
> 
> The issue is that phy_connect() won't work if ds->slave_mii_bus has an
> OF presence, and ethernet-phy@3 isn't defined under it (which it isn't,
> you only put ethernet-phy@9). The super detailed reason is that the
> OF-based __of_mdiobus_register() does this:
> 
> 	/* Mask out all PHYs from auto probing.  Instead the PHYs listed in
> 	 * the device tree are populated after the bus has been registered */
> 	mdio->phy_mask = ~0;
> 
> So either:
> 
> - you delete the "mdio" node and the ethernet-phys under it, or
> - you add all ethernet-phys under the mdio node, and put phy-handles
>    from ports to each of them, and phy-modes of "internal"
> 
> What you have now is exactly what won't work, i.e. an OF-based
> slave_mii_bus with a non-OF-based phy_connect().
> 
> I don't want to see DT examples that are structurally broken, sorry,
> because then we wonder why users are confused.
> 
> Personally, I would opt for adding the more modern explicit phy-handle
> and phy-mode everywhere. Those also work with the U-Boot DM_DSA driver.

As can be seen on the conversation on the patch series you've referred to
above, this is ultimately what I've proposed to enforce on all ethernet
controllers (I hadn't mentioned phy-mode there yet). As long as Andrew
holds his stance, this won't happen. The whole conversation on that patch
series is a great read as to how a devicetree should be defined and how
drivers should interact with it.

But sure, they can at least be put on the examples for this specific
schema.

Arınç
