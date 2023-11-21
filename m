Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5557F2A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjKUKWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjKUKW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:22:27 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93B92D59;
        Tue, 21 Nov 2023 02:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=41TdEsYoLDRD7QCMpUE7oCzBIqXCIxjP5nyED47SHKI=; b=h8U/2HO/cq9SLWGR6DgkDHPCVL
        HmgCspiG/gquu7NVNxruR7bu3SYFZtlqOYrxtKV3ki/IldV6S2T7GX4Cwru3bBg6OIGlxdtqb5pDE
        tK8Y/UHV5cJl+6i7Fli8SaT2KDL+Vb3c50zvkvz9WTwRSCmfmFSDgYJKUiPVpF8x4iKZFQmbdKbXI
        75Gva1+x/YXAMW7gF6FKXAaoUAkSDZCLnoclbtQGxDS52bVlpWs6M2RSs5k5jm4E3elS/2aoFn9QQ
        zEpkFWJhpzyug7kuZAXj9/uUqOTawF/Cny2nHfL2ip63bDI+AKeJamxDxVbC9iPZ/N5mCQqsZ2eCO
        1sN5fNvA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48514)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r5Ns2-0006ps-11;
        Tue, 21 Nov 2023 10:20:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r5Ns3-00046L-IX; Tue, 21 Nov 2023 10:20:43 +0000
Date:   Tue, 21 Nov 2023 10:20:43 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Herve Codina <herve.codina@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [RFC PATCH net-next v2 04/10] net: sfp: Add helper to return the
 SFP bus name
Message-ID: <ZVyEe0zH8Zo1NLFO@shell.armlinux.org.uk>
References: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
 <20231117162323.626979-5-maxime.chevallier@bootlin.com>
 <00d26b50-56f1-4eac-a37f-36cf321bd46a@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00d26b50-56f1-4eac-a37f-36cf321bd46a@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 02:00:58AM +0100, Andrew Lunn wrote:
> > +const char *sfp_get_name(struct sfp_bus *bus)
> > +{
> > +	if (bus->sfp_dev)
> > +		return dev_name(bus->sfp_dev);
> > +
> > +	return NULL;
> > +}
> 
> Locking? Do you assume rtnl? Does this function need to take rtnl?

Yes, rtnl needs to be held to safely access bus->sfp_dev, and that
either needs to happen in this function, or be documented as being
requried (and ASSERT_RTNL() added here.)

The reason is that sfp_dev is the SFP socket device which can be
unbound via sfp_unregister_socket(), which will set bus->sfp_dev to
NULL. This could race with the above.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
