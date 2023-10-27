Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBA67D9708
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345814AbjJ0Lyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345793AbjJ0Lyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:54:47 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF82D9;
        Fri, 27 Oct 2023 04:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9sI0L2/p2wrCRRIQ0ruGQzGrqm10dnyvAFdR93FTrxk=; b=PD5RajVbp3BhCQo9Q+zyJOJFh5
        69SPUkJJfKYkoEX6uJ6INYjXex5RCn1kan7/jKJjZxWz4adEuk6CGiY5EgEUq1F4ZpfS1lCCgn3/4
        +fW5KYDbEpIAh8pZfp7jADUPaoq4tYpcozBNZ834wUQoW7VYr3SfvdJxSt+IHYjKWIgY5xuMbjtj+
        u2hwY1mT1sTunAEPwORvniSDX6ygOXcWVo+Fz2FpebyGZLHUYEleMp7ZzWUdorPug9xf089x/WzHm
        +LgS9C3SNhA2YOZyqKqoiapXp3b9sERVFg1lbCw70K3OX3TW4mG9WBxB3nQrfl7MGn1EBNi2qBu6Z
        bZjqjSTw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54974)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qwLQC-0007m5-1b;
        Fri, 27 Oct 2023 12:54:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qwLQC-0000kP-4J; Fri, 27 Oct 2023 12:54:36 +0100
Date:   Fri, 27 Oct 2023 12:54:36 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch,
        Jose.Abreu@synopsys.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V3] net: pcs: xpcs: Add 2500BASE-X case in get
 state for XPCS drivers
Message-ID: <ZTuk/OF01M24nBeG@shell.armlinux.org.uk>
References: <20231027044306.291250-1-Raju.Lakkaraju@microchip.com>
 <ghpmbmfjps24x7xvojk4gbkl55wjcuufd4v6mz6ws5htv35g2b@ugqsbet7t73p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ghpmbmfjps24x7xvojk4gbkl55wjcuufd4v6mz6ws5htv35g2b@ugqsbet7t73p>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 02:04:15PM +0300, Serge Semin wrote:
> Cc += Russell
> 
> * It's a good practice to add all the reviewers to Cc in the new patch
> * revisions.
> 
> On Fri, Oct 27, 2023 at 10:13:06AM +0530, Raju Lakkaraju wrote:
> > Add DW_2500BASEX case in xpcs_get_state( ) to update speed, duplex and pause
> > 
> > Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> 
> With a nitpick below clarified, feel free to add:
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 
> > ---
> >  drivers/net/pcs/pcs-xpcs.c | 29 +++++++++++++++++++++++++++++
> >  drivers/net/pcs/pcs-xpcs.h |  2 ++
> >  2 files changed, 31 insertions(+)
> > 
> > diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> > index 4dbc21f604f2..31f0beba638a 100644
> > --- a/drivers/net/pcs/pcs-xpcs.c
> > +++ b/drivers/net/pcs/pcs-xpcs.c
> > @@ -1090,6 +1090,28 @@ static int xpcs_get_state_c37_1000basex(struct dw_xpcs *xpcs,
> >  	return 0;
> >  }
> >  
> > +static int xpcs_get_state_2500basex(struct dw_xpcs *xpcs,
> > +				    struct phylink_link_state *state)
> > +{
> > +	int ret;
> > +
> > +	ret = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_STS);
> > +	if (ret < 0) {
> > +		state->link = 0;
> > +		return ret;
> > +	}
> > +
> > +	state->link = !!(ret & DW_VR_MII_MMD_STS_LINK_STS);
> > +	if (!state->link)
> > +		return 0;
> > +
> > +	state->speed = SPEED_2500;
> 
> > +	state->pause |= MLO_PAUSE_TX | MLO_PAUSE_RX;
> 
> Why is it '|=' instead of just '='? Is it possible to have the 'pause'
> field having some additional flags set which would be required to
> preserve?

The code is correct. There are other flags on state->pause other than
these, and phylink initialises state->pause prior to calling the
function. The only flags that should be modified here are these two
bits that the code is setting.

Phylink will initialise it to MLO_PAUSE_NONE if expecting autoneg, or
the configured values if autoneg on the link is disabled.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
