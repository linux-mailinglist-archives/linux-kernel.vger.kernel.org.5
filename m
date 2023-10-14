Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC5B7C96FE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 00:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjJNWQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 18:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJNWQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 18:16:05 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF8CC9;
        Sat, 14 Oct 2023 15:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=lpa5eriPWM9dxuddCalTlYIIqTArjMNddT2P9YogWKQ=; b=CGbVUNAbfYENXWWQZdsLI67aA5
        eYQdgeHdWWGUnp/rRrUhotFQgJSXiVVMpQY8zpUP660XQjRiwKOWSHE1Fh6uYOzZo0V7sIh+y0mYG
        JXr+Z0TnIkkx48bmjTFB9tgcrNkdfGiQ/ZURQgHuTBH8CucPlCsVOOKmOa+FV2t/tv/s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qrmvE-002CtS-DC; Sun, 15 Oct 2023 00:15:48 +0200
Date:   Sun, 15 Oct 2023 00:15:48 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/5] dt-bindings: marvell: Rewrite MV88E6xxx
 in schema
Message-ID: <367d2734-13bb-44f9-832c-f17b1a2194e2@lunn.ch>
References: <20231014-marvell-88e6152-wan-led-v2-0-7fca08b68849@linaro.org>
 <20231014-marvell-88e6152-wan-led-v2-1-7fca08b68849@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014-marvell-88e6152-wan-led-v2-1-7fca08b68849@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +  mdio:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +    description: Marvell MV88E6xxx switches have an internal mdio bus to
> +      access switch ports, which is handled in this node.

This is not quite correct. For marvell,mv88e6085 and marvell,mv88e6250
there is one MDIO bus, which can be used both internally and
externally.

For marvell,mv88e6190, there are two MDIO buses. This one is used only
internally, and 'mdio-external' is connected to pins for external use.

Also, its not used to access switch ports. It is used to access PHYs
which can connected to switch ports.

      Andrew
