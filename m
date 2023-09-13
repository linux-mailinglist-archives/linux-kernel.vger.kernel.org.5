Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2D979EDD2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjIMP75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjIMP7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:59:55 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B78290;
        Wed, 13 Sep 2023 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EQBLv7nFccJn5zoRcB5FmmGXNiMfTDOB0wvhQT662Yk=; b=wa8tUgwCXx/5nwWXkjpYZeCr7+
        2rXQpHQGk+0OgzNyLR6Ki9dRQ/aOpRdz4jG9h5CvmTM8npAtvujTfUKvcAerqumAxTDc2ZJtvmmyR
        U4QicgJgTaXJmPsmFZ4ppAsFpRhoH+WBm0mwO82SlT8IpoHdwAuRX/0+JGtXiPvc67tKB6Muktv/N
        hfdp5y3C0chBGp0UhvB3I1nbpy3ADiazuIYyXICdKa8Fra+vDznxuY/rb5ps7XQpujoY6QM1Gvs21
        H/37pPtOrT0Brj1+/VscA74+LE4G6hfe7rybZcbo1VM335EBV9mMZomeiTKWt9RQx5mj6dbxkWYAq
        Wa4k7+Aw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51146)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qgSGx-0002ix-1q;
        Wed, 13 Sep 2023 16:59:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qgSGt-0003rK-4Z; Wed, 13 Sep 2023 16:59:19 +0100
Date:   Wed, 13 Sep 2023 16:59:19 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Andrew Lunn <andrew@lunn.ch>,
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
Message-ID: <ZQHcV5DUfcCYkkTi@shell.armlinux.org.uk>
References: <20230814143601.mnpxtcm2zybnbvoh@skbuf>
 <0cee0928-74c9-4048-8cd8-70bfbfafd9b2@arinc9.com>
 <20230827121235.zog4c3ehu2cyd3jy@skbuf>
 <676d1a2b-6ffa-4aff-8bed-a749c373f5b3@arinc9.com>
 <87325ce9-595a-4dda-a6a1-b5927d25719b@arinc9.com>
 <20230911225126.rk23g3u3bzo3agby@skbuf>
 <036c0763-f1b2-49ff-bc82-1ff16eec27ab@arinc9.com>
 <20230912193450.h5s6miubag46z623@skbuf>
 <6cec079e-991e-4222-a76d-d6156de0daca@arinc9.com>
 <20230913074231.5azwxqjuv2wp5nik@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230913074231.5azwxqjuv2wp5nik@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 10:42:31AM +0300, Vladimir Oltean wrote:
> On Wed, Sep 13, 2023 at 08:52:37AM +0300, Arınç ÜNAL wrote:
> > On 12.09.2023 22:34, Vladimir Oltean wrote:
> > > On Tue, Sep 12, 2023 at 10:23:51PM +0300, Arınç ÜNAL wrote:
> > > > The phylink bindings for user ports I ended up making by looking up the
> > > > existing devicetrees are different than the phylink bindings for the shared
> > > > (CPU and DSA) ports currently enforced on all switches.
> > > > 
> > > > My phylink bindings for user ports:
> > > > 
> > > >              allOf:
> > > >                - anyOf:
> > > >                    - required: [ fixed-link ]
> > > >                    - required: [ phy-handle ]
> > > >                    - required: [ managed ]
> > > > 
> > > >                - if:
> > > >                    required: [ fixed-link ]
> > > >                  then:
> > > >                    not:
> > > >                      required: [ managed ]
> > > 
> > > Right, it should have been anyOf and not oneOf.. my mistake. It is a bug
> > > which should be fixed. It's the same phylink that gets used in both cases,
> > > user ports and shared ports :)
> > 
> > One more thing, I don't recall phy-mode being required to be defined for
> > user ports as it will default to GMII. I don't believe this is the same
> > case for shared ports so phy-mode is required only for them?
> 
> phy-mode is not strictly required, but I think there is a strong
> preference to set it. IIRC, when looking at the DSA device trees, there
> was no case where phy-mode would be absent on CPU/DSA ports if the other
> link properties were also present, so we required it too. There were no
> complaints in 1 year since dsa_shared_port_validate_of() is there. The
> requirement can be relaxed to just a warning and no error in the kernel,
> and the removal of "required" in the schema, if it helps making it
> common with user ports.

However, phylink pretty much requires phy-mode to be specified to be
something sane for shared ports, so I wouldn't be in favour of relaxing
the checkinng in dsa_shared_port_validate_of()... not unless you're
now going to accept the approach I originally proposed to have DSA
drivers tell the core (and thus phylink) what phy-mode and other link
parameters should be used when they are missing from DT.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
