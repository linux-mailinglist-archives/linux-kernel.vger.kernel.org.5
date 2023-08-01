Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A0076B93B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbjHAP6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbjHAP6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:58:05 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B6990;
        Tue,  1 Aug 2023 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=StHVChOnfhztrTgRs/qPRxFdOMMZ7GZBHs74HwuauDU=; b=NhxTxwb81AGrvwsULcjm63GlqX
        u+Cj4nq8m6zN66j3X8OFnWBy/1sey8kbunoC+V8Hs2YDz7GhKUsgen3qZ2E6rZM6opfrn02Dp0fUU
        r6RhBeoD8y1ptrCEZr2clRCDwnqQ/ojc4BViVyKmA1pptPLYgjl67CF4yaUZgRAK8tsfnmJ7Yqq6K
        HVfS9sPN7E3I8kkyaf/EgdTWNsN8kLlbS5RyTqCX3Y5QbTif0SQry3qco5ol8jlY4sTaf2dPGOzKh
        IaqUvtmDUEEM0VgrFSeSSNd5EQi3IfOg1JczbYSc86h86uTIOWdunpHA4azKnzcgHUyu3tOjdxpgU
        ISgXjOeQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50694)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qQrkY-0004LR-2y;
        Tue, 01 Aug 2023 16:57:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qQrkW-0000p3-8l; Tue, 01 Aug 2023 16:57:28 +0100
Date:   Tue, 1 Aug 2023 16:57:28 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
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
Message-ID: <ZMkraPZvWWKhY8lT@shell.armlinux.org.uk>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-2-9eb37edf7be0@kernel.org>
 <7be8b305-f287-4e99-bddd-55646285c427@lunn.ch>
 <867ae3cc05439599d63e4712bca79e27@kernel.org>
 <cf999a14e51b7f2001d9830cc5e11016@kernel.org>
 <ZMkddjabRonGe7Eu@shell.armlinux.org.uk>
 <bce942b71db8c4b9bf741db517e7ca5f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bce942b71db8c4b9bf741db517e7ca5f@kernel.org>
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

On Tue, Aug 01, 2023 at 05:20:22PM +0200, Michael Walle wrote:
> > In the case of the above (the code in __phy_read_mmd()), I wouldn't
> > at least initially change the test there.
> > 
> > phydev->is_c45 will only be true if we probed the PHY using clause
> > 45 accesses. Thus, it will be set if "the bus supports clause 45
> > accesses" _and_ "the PHY responds to those accesses".
> > 
> > Changing that to only "the bus supports clause 45 accesses" means
> > that a PHY supporting only clause 22 access with indirect clause
> > 45 access then fails if it's used with a bus that supports both
> > clause 22 and clause 45 accesses.
> 
> Yeah of course. It was more about the naming, but I just realized
> that with mdiobus_supports_c45() you can't access the original
> "is_c45" property of the PHY. So maybe this patch needs to be split
> into two to get rid of .is_c45:
> 
> First a mechanical one:
> phy_has_c45_registers() {
>    return phydev->is_c45;
> }

Andrew's objection was that "phy_has_c45_registers" is a misnomer, and
suggested "_transfers" instead - because a PHY can have C45 registers
that are accessible via the indirect registers in C22 space.

I'd go one further:

static bool phy_supports_c45_transfers(struct phy_device *phydev)
{
	return phydev->is_c45;
}

Since that covers that (a) the bus needs to support C45 transfers and
(b) the PHY also needs to respond to C45 transfers.

If we want to truly know whether a clause 22 PHY has clause 45
registers, that's difficult to answer, because then you're into the
realms of "does this PHY implement the indirect access method" and
we haven't been keeping track of that for the PHYs we have drivers
for - many will do, but it's optional in clause 22. The problem is
that when it's not implemented, the registers could be serving some
other function.

> phy_has_c22_registers() {
>   return !phydev->is_c45;
> }

The reverse is not true, as clause 45 PHYs can also support clause 22
registers - from 802.3:

 "For cases where a single entity combines Clause 45 MMDs with  Clause 22
 registers, then the Clause 22 registers may be accessed using the Clause
 45 electrical interface and the Clause 22 management frame structure."

 "Bit 5.0 is used to indicate that Clause 22 functionality has been
 implemented within a Clause 45 electrical interface device."

Therefore, this would more accurately describe when Clause 22 registers
are present for a PHY:

static bool phy_has_c22_registers(struct phy_device *phydev)
{
	/* If we probed the PHY without clause 45 accesses, then by
	 * definition, clause 22 registers must be present.
	 */
	if (!phydev->is_c45)
		return true;

	/* If we probed the PHY with clause 45 accesses, clause 22
	 * registers may be present if bit 0 in the Devices-in-pacakge
	 * register pair is set.
	 */
	return phydev->c45_ids.devices_in_package & BIT(0);
}

Note that this doesn't take account of whether the bus supports clause
22 register access - there are a number of MDIO buses that do not
support such accesses, and they may be coupled with a PHY that does
support clause 22 registers.

I'm aware of a SFP with a Realtek PHY on that falls into this exact
case, and getting that working is progressing at the moment.

> For all the places Andrew said it's correct. Leave all the
> other uses of .is_c45 as is for now and rework them in a
> later patch to use mdiobus_supports_{c22,c45}().

For the two cases in marvell10g and bcm84881, the test there for
is_c45 is purely to determine "was this ID found on a PHY supporting
clause 45 access" - however, in both cases, a check is made for MMDs
present in devices_in_package which will fail if the PHY wasn't
discovered in clause 45 mode.

Note that 88x3310 does not support clause 22 access. I forget whether
bcm84881 does or not.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
