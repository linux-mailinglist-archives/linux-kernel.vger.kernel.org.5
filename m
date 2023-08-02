Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2A876DAD3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjHBW3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjHBW3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:29:00 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21663A9C;
        Wed,  2 Aug 2023 15:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IL+akg/WyJm9APr6PCi3HDr0T7a4OwCl1lYqSabVYic=; b=CXw12PqR8w2feUvBQg+WTjFJSW
        566yAMn048oboez1OE974FCEn+bZ3sxdAdw9YA0KEoAurSzI2o2rECIY2V59CzGmmsrchEn/3SNdq
        wPpv5ZJcCHslOGIiZ/32eEGgSDcNU4pqBPBAz4XhHEqse54tTh5ttjL/8riqy3dTNE+KwJYBsvvIx
        9pjK7E+Si2dwpwbpXitRJs2t2r100/jvFORr3knJkeZiArBXKpfG/b9n5PLJunE/pLVzPzaXkjgTM
        IJkIHElhq1f8saxP48Nvxa8n7tobsOQ4n/76fbLq7lzlkEk2AvNXaYGT7uaI28zxuE/BLVAuPv+dP
        RkVIFAuQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46014)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qRKK5-0005yV-2r;
        Wed, 02 Aug 2023 23:28:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qRKK2-0002GD-08; Wed, 02 Aug 2023 23:28:02 +0100
Date:   Wed, 2 Aug 2023 23:28:01 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Michael Walle <mwalle@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 02/11] net: phy: introduce
 phy_has_c45_registers()
Message-ID: <ZMrYcbY65yOZyaxo@shell.armlinux.org.uk>
References: <7be8b305-f287-4e99-bddd-55646285c427@lunn.ch>
 <867ae3cc05439599d63e4712bca79e27@kernel.org>
 <cf999a14e51b7f2001d9830cc5e11016@kernel.org>
 <ZMkddjabRonGe7Eu@shell.armlinux.org.uk>
 <bce942b71db8c4b9bf741db517e7ca5f@kernel.org>
 <ZMkraPZvWWKhY8lT@shell.armlinux.org.uk>
 <b0e5fbe28757d755d814727181c09f32@kernel.org>
 <7c29bfa7-b4a6-49c9-9369-d98bae98f135@lunn.ch>
 <ZMqOA+NblHun1hbo@shell.armlinux.org.uk>
 <cdd97217-d5e5-429b-bcda-2248f0de12ce@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdd97217-d5e5-429b-bcda-2248f0de12ce@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 12:21:03AM +0200, Andrew Lunn wrote:
> On Wed, Aug 02, 2023 at 06:10:27PM +0100, Russell King (Oracle) wrote:
> > On Wed, Aug 02, 2023 at 06:15:19PM +0200, Andrew Lunn wrote:
> > > > I'm confused now. Andrew suggested to split it into four different
> > > > functions:
> > > > 
> > > > phy_has_c22_registers()
> > > > phy_has_c45_registers()
> > > > phy_has_c22_transfers()
> > > > phy_has_c45_transfers()
> > > > 
> > > > Without a functional change. That is, either return phydev->is_c45
> > > > or the inverse.
> > > 
> > > Without a functional change at this step of introducing the four
> > > functions. Then later really implement them to do what the name
> > > implies. Doing it in steps helps with bisect when it breaks something.
> > > 
> > > It could also be that not all four are needed, or not all four are
> > > possible. But the four express the full combinations of transfers and
> > > registers.
> > 
> > I'm left wondering how you think that phy_has_c45_registers() can
> > be implemented in a useful way, because I'm at a total loss...
> 
> get_phy_c22_id() looks at the ID registers, and see if its mostly
> Fs. If so, it says -ENODEV. So phy_has_c22_registers() could be
> get_phy_c22_id() != -ENODEV. And you can extend that with the logic
> you quoted from the standard. get_phy_c45_ids() also returns -ENODEV
> if there are no devices in the package. So phy_has_c45_registers()
> could be get_phy_c45_id() != -ENODEV.

No, this is not correct, because get_phy_c45_id() uses mdiobus c45
reads - if the bus doesn't support c45 transfers, then get_phy_c45_id()
fails.

This doesn't tell us whether the PHY has clause 45 registers at all,
it just tells us that we probed the PHY successfully using clause 45
accesses.

The fact of the matter is that there is no way in the current phylib
code (and probably no way to probe it either) to determine whether a
PHY has clause 45 registers or not. To see why, take for example the
AR8035. This clearly has clause 45 registers, because it has MMDs 3
and 7 implemented. However, these are only accessible through the
indirect access method via clause 22 cycles.

So, does it make sense for AR8035 to return false from
phy_has_c45_registers() ? No it doesn't, because it clearly does have
clause 45 registers!

The same can be said about Marvell 88e151x PHYs. And probably many
other clause 22 PHYs.

Hence why I disagree with your suggestion.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
