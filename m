Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA3678DB9B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239227AbjH3SkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244120AbjH3Mfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:35:40 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E95E8;
        Wed, 30 Aug 2023 05:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=T2O+sBlbvdpS0hoU5T0fb6i/Wy/HRU/MDJb7UwbbaxA=; b=B0PIR7P723ofepUo8TBm5pvms9
        KEe7g27iq3BAJ9U3a0CfNnS7OlQjbPOEKMiAU70aOdkVCEDLjcN5BweXpJES02hcYS0pwq0WNvzxZ
        8gqk6cXZfGwKc9+FtFSu7gGFeHBpdwzhj5YgMBse325oixL3mWlDXCq25IOK6er4DUwDfQoK70W+w
        LSe0ahEKAdTbEjaIb3IUWeJp2tIm6uXiXkcuddgcHatnxN1e6xhR8giS5/OTpzfJ45DYgcYDokehr
        EcPvt7De5bSDvUF3o6qfryeZgSF/jVmps8IQ2v/lWR6zXqSLc4wkZ1WITD9CPrr/uAn6N4XKxFCfU
        in5L7A/w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56508)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qbKPn-0001bb-1X;
        Wed, 30 Aug 2023 13:35:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qbKPm-0005go-4T; Wed, 30 Aug 2023 13:35:18 +0100
Date:   Wed, 30 Aug 2023 13:35:18 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Lukasz Majewski <lukma@denx.de>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <ZO83htinyfAp4mWw@shell.armlinux.org.uk>
References: <20230830092119.458330-1-lukma@denx.de>
 <20230830092119.458330-2-lukma@denx.de>
 <20230830101813.GG31399@pengutronix.de>
 <20230830125224.1012459f@wsk>
 <20230830105941.GH31399@pengutronix.de>
 <20230830135151.683303db@wsk>
 <20230830121738.GJ31399@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830121738.GJ31399@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 02:17:38PM +0200, Oleksij Rempel wrote:
> On Wed, Aug 30, 2023 at 01:51:51PM +0200, Lukasz Majewski wrote:
> > Hi Oleksij,
> 
> > It looks like the most optimal solution would be the one proposed by
> > Tristam:
> > https://www.spinics.net/lists/netdev/msg932044.html
> 
> In this case, please add the reason why it would work on this HW and
> will not break by any changes in PHYlib or micrel.c driver.
> 
> If I remember it correctly, in KSZ9477 variants, if you write to EEE
> advertisement register, it will affect the state of a EEE capability
> register. Which break IEEE 802.3 specification and the reason why
> ksz9477_get_features() actually exist. But can be used as workaround if
> it is written early enough before PHYlib tried to read EEE capability
> register.
> 
> Please confirm my assumption by applying your workaround and testing it
> with ethtool --show-eee lanX.
> 
> It should be commented in the code with all kind of warnings:
> Don't move!!! We use one bug to workaround another bug!!! If PHYlib
> start scanning PHYs before this code is executed, then thing may break!!

Why would phylib's scanning cause breakage?

phylib's scanning for PHYs is about reading the ID registers etc. It
doesn't do anything until the PHY has been found, and then the first
thing that happens when the phy_device structure is created is an
appropriate driver is located, and the driver's ->probe function
is called.

If that is successful, then the fewatures are read. If the PHY
driver's ->features member is set, then that initialises the
"supported" mask and we read the EEE abilities.

If ->features is not set, then we look to see whether the driver
provides a ->get_features method, and call that.

Otherwise we use the generic genphy_c45_pma_read_abilities() or
genphy_read_abilities() depending whether the PHY's is_c45 is set
or not.

So, if you want to do something very early before features are read,
then either don't set .features, and do it early in .get_features
before calling anything else, or do it in the ->probe function.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
