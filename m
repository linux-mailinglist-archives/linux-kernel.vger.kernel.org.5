Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252257D13B5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377887AbjJTQIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377814AbjJTQIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:08:18 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D34E1A8;
        Fri, 20 Oct 2023 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ShgNviY6uRULZSOoTM3SW6UAuXHvVtML/+Hkod5jeco=; b=a0uAi1WVuGqpIjS/NvcbG3Kmz9
        lKUe4TZ9TFX0frVrmQpDcG1NR14DNnYyPROpjwj0e4fbcMRUuWDlQBiJSNyF4H/1cPVwjHcwXRcPp
        q6WOqLeQXtP+GR8JnO5iWU8jpvgpsdjzc60mhg8BgKc9rKBAj1jZYZO3NDykH0zZ3vSo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qts2Y-002noa-91; Fri, 20 Oct 2023 18:07:58 +0200
Date:   Fri, 20 Oct 2023 18:07:58 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
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
Subject: Re: [PATCH net-next v4 6/7] dt-bindings: marvell: Rewrite MV88E6xxx
 in schema
Message-ID: <c3f1049b-2bfa-4421-9f40-497ddd2911b5@lunn.ch>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-6-3ee0c67383be@linaro.org>
 <20231019153552.nndysafvblrkl2zn@skbuf>
 <CACRpkdbskk22SLmopUTD78kMWL_gcOa=YWHLFtrkDAD5=W=HFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbskk22SLmopUTD78kMWL_gcOa=YWHLFtrkDAD5=W=HFw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Isn't there some in-kernel DTS file with a *good* example of how
> a Marvell mv88e6xxx switch is supposed to look I can just
> copy instead? We shouldn't conjure synthetic examples.

arch/arm/boot/dts/marvell/armada-381-netgear-gs110emx.dts is an
example of a 6390 with external PHYs. The nodes are in a somewhat
unconventional order, but nothing requires them to be any specific
order.

arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-spu3.dts is another 6390 which
only uses the internal PHYs, so there are no mdio busses listed or
needed.

arch/arm/boot/dts/marvell/armada-370-rd.dts is another example of how
it can be done. It lists the PHYs on the MDIO bus, but does not have
any phy-handles, it lets the DSA core link them. Some people might
consider this a bad example? But it works, i use this machine for
development work.

arch/arm/boot/dts/marvell/armada-385-linksys.dtsi is another
alternative, which does not have the MDIO bus.

	Andrew
