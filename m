Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDDA7F956C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 22:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjKZVGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 16:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjKZVGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 16:06:04 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C3D102;
        Sun, 26 Nov 2023 13:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=KXK89DRC3/GRMxUOJBEEqz491WSkqxES3M9FwZV+iRI=; b=WzLvRLT5giy+SfzH6CG4hkFGZ3
        /S7p8KljccfM6SKM8EQ2p2DU7WFz22ww/dp3aFA5r+REy+cfZ+kb8BmKaJ/mJgAgb5sZQgAGAdhwg
        m+h5eWu6YrhfO07t4QOakoC+rrRbPf3zsLBEnAGCa+ViddedxK6bv0TK4SgFVVxcBFYM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r7MKG-001Gvs-PI; Sun, 26 Nov 2023 22:06:00 +0100
Date:   Sun, 26 Nov 2023 22:06:00 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
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
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v8 0/9] Create a binding for the Marvell
 MV88E6xxx DSA switches
Message-ID: <9c1a2484-6631-42e1-a576-10e9d600e8c5@lunn.ch>
References: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
 <0bd7809b-7b99-4f88-9b06-266d566b5c36@lunn.ch>
 <CACRpkdZQj57CjArhcNKVDQ5fC+dsuYWsc6YXjQDC80QiASPB7A@mail.gmail.com>
 <CACRpkdZvMRXHKktM-HPZZRCrV0JgErqDOHmkyKAcB36ObwOX7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZvMRXHKktM-HPZZRCrV0JgErqDOHmkyKAcB36ObwOX7A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Shawn is busy I guess, but looking at the activity in arch/arm/boot/dts/nxp
> iIt seems pretty risk-free to apply.
> 
> An alternative is to simply apply all but patch 4/9 (the NXP patch), because
> the rest is Andrew territory.

Could you split it into two patchsets? Gregory and I can deal with all
the Marvell patches.

    Andrew
