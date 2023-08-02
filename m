Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88B376DB25
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 01:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjHBXAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 19:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjHBXAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 19:00:34 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4900D1704;
        Wed,  2 Aug 2023 16:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GtHyUyRhmZC/ndCTfFZSi0G5xoy+tfRuoFtXp1YsIVM=; b=JtvkveQpSmLkLcNOVxyh/y4nHb
        eTYMyA6kStyZj5Yy/jFPb2xF7atWrkAKg1yr4gKtF8N8z1KdGkUi36hjqtQvmKvw6ONUqa/oTe+JD
        kt6/EsmDPjRYPCMRIJEGusOt7SGcjY0ijKhia2F2Xyix5ogILECyKSBVNJ10l8l70oMpqbX/LjLH1
        GGp1uZbfwA8mYOp/WHGLLALFPNi1u+TpE5W80l9dyHQzokAsEjgfyZ6lgHuQBp4SrblStNuUiisxc
        D5qs27eB3aem//Yq4F4NcLvBO9yCrJASk7v3KcFR+aJfufpkez0Xb8sXT03tCjiNNDKzMUpiZyAot
        VZVb8eyg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42338)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qRKp8-0005zV-0u;
        Thu, 03 Aug 2023 00:00:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qRKp0-0002HP-CR; Thu, 03 Aug 2023 00:00:02 +0100
Date:   Thu, 3 Aug 2023 00:00:02 +0100
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
Message-ID: <ZMrf8goIsn3PDC2S@shell.armlinux.org.uk>
References: <20230620-feature-c45-over-c22-v3-2-9eb37edf7be0@kernel.org>
 <7be8b305-f287-4e99-bddd-55646285c427@lunn.ch>
 <867ae3cc05439599d63e4712bca79e27@kernel.org>
 <cf999a14e51b7f2001d9830cc5e11016@kernel.org>
 <ZMkddjabRonGe7Eu@shell.armlinux.org.uk>
 <bce942b71db8c4b9bf741db517e7ca5f@kernel.org>
 <ZMkraPZvWWKhY8lT@shell.armlinux.org.uk>
 <b0e5fbe28757d755d814727181c09f32@kernel.org>
 <ZMp/B2U/qaI/VQDN@shell.armlinux.org.uk>
 <3fa8d14f0a989af971d61af01b13fd8b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fa8d14f0a989af971d61af01b13fd8b@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 07:11:27PM +0200, Michael Walle wrote:
> I'm talking about
> 
> 	u32 mmd_mask = MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
> 	if (!phydev->is_c45 ||
> 	    (phydev->c45_ids.devices_in_package & mmd_mask) != mmd_mask)
> 		return -ENODEV;
> 
> How should that look like after this series?

In the case of the marvell10g driver, at least the 88x3310 can be
accessed via clause 45 bus cycles _or_ the clause 45 indirect
register access via clause 22. I'm not sure what the clause 22
registers would contain, whether they contain valid values with
the exception of the clause 45 indirect access registers because
there's not enough information in the documentation, and I can't
access the clause 22 registers on real hardware.

Another issue is this PHY has two different ID values. One is
0x002b 0x09aa, the other is 0x0141 0x0daa. One or other of these
values appears in the MMDs - in other words, they are not
consistently used. This means it's impossible to guess what value
may be in the clause 22 ID registers for this PHY.

However, given the way phylib works, the above effectively ensures
that we detected the PHY using clause 45 accesses, and then goes on
to verify that we do indeed have the PMAPMD MMD and the AN MMD.
Effectively, it ensures that get_phy_c45_ids() was used to detect
the device.

So, in effect, this code is ensuring that we discovered the PHY
using clause 45 accesses, and that at a minimum the PHY also
indicates that the PMAPMD and AN MMDs are implemented.

For the bcm84881 driver, it's a similar situation - that's only
ever been used with a bus that supports _only_ clause 45 accesses.
Even less idea whether the PHY could respond to clause 22 accesses
as there is no information available on the PHY.

So, I'd suggest both of these are the same - returns -ENODEV if
the bus doesn't support clause 45 transfers or if the two MMDs
are not indicated.

That said, it _can_ be simplified down to just testing the
devices_in_package member, because that will only be non-zero if
we successfully probed the PHY via some accessible way to the
clause 45 registers. So:

	if ((phydev->c45_ids.devices_in_package & mmd_mask) != mmd_mask)
		return -ENODEV;

is probably entirely sufficient in both cases.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
