Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5E97632E4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjGZJzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjGZJyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:54:31 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA2744BE;
        Wed, 26 Jul 2023 02:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HpnwsxUHu2c9srkMeUmtNCtfxo1OCFWkptP/6JjG/78=; b=nrPQW5o+w3K2H3ti5OtIYRs26E
        jtdVWSK9W7KuwYgsR8zYDUak+SdOW9KWUsMI19lIbhoOCZNgI+2ye8uv+25T4c0KLj9rBVW8PAz0g
        0PkwXxX8ECbXEl5tunDzeoxbLwTyUlnV8ahFXWcJGNHMLbGQG5dhSbwdX1Yyl/HZ/v0/B43DYK82G
        S/EyPOn3IE03haw9HWSAUHWta6zjvC6iSkb9R/kNJuIR599Y7SB0pQwuvin6ef3m2kBcWgpWSECfj
        D/skXp/8bXKyk11cRhGTH0blMSE3fqoakpINAVhq+gH1HI/7Gx2ibxnA4IxUEkfFNrdeQeQgt3BeJ
        sPgpiDrA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39350)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qObCo-0004Gf-0I;
        Wed, 26 Jul 2023 10:53:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qObCn-0002ln-4c; Wed, 26 Jul 2023 10:53:17 +0100
Date:   Wed, 26 Jul 2023 10:53:17 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
        f.fainelli@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        olteanv@gmail.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: Add erratum 3.14 for
 88E6390X and 88E6190X
Message-ID: <ZMDtDXG4Xj94F7vw@shell.armlinux.org.uk>
References: <ZMALH03Fbp3wKkO2@shell.armlinux.org.uk>
 <20230726094935.12629-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726094935.12629-1-ante.knezic@helmholz.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:49:35AM +0200, Ante Knezic wrote:
> On Tue, 25 Jul 2023 18:49:19 +0100 Russell King (Oracle) wrote:
> > Does the errata say that _all_ lanes need this treatment, even when
> > they are not being used as a group (e.g. for XAUI) ?
> 
> No, unfortunatelly errata says very little, I tried applying erratum only on the requested 
> lane of port 9/10 but this did not work out as expected and the issue was still visible.
> I dont have the necessary HW to perform more tests on other lanes unfortunatelly.
> 
> On Tue, 25 Jul 2023 18:49:19 +0100 Russell King (Oracle) wrote:
> > On Tue, Jul 25, 2023 at 08:23:43PM +0300, Vladimir Oltean wrote:
> > > On Fri, Jul 21, 2023 at 12:26:18PM +0200, Ante Knezic wrote:
> > > > diff --git a/drivers/net/dsa/mv88e6xxx/pcs-639x.c b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
> > > > index 98dd49dac421..50b14804c360 100644
> > > > --- a/drivers/net/dsa/mv88e6xxx/pcs-639x.c
> > > > +++ b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
> > > > @@ -20,6 +20,7 @@ struct mv88e639x_pcs {
> > > >  	struct mdio_device mdio;
> > > >  	struct phylink_pcs sgmii_pcs;
> > > >  	struct phylink_pcs xg_pcs;
> > > > +	struct mv88e6xxx_chip *chip;
> > 
> > 	bool erratum_3_14;
> 
> ...
> 
> > > >  static int mv88e639x_sgmii_pcs_post_config(struct phylink_pcs *pcs,
> > > >  					   phy_interface_t interface)
> > > >  {
> > > >  	struct mv88e639x_pcs *mpcs = sgmii_pcs_to_mv88e639x_pcs(pcs);
> > > > +	struct mv88e6xxx_chip *chip = mpcs->chip;
> > > >  
> > > >  	mv88e639x_sgmii_pcs_control_pwr(mpcs, true);
> > > >  
> > > > +	if (chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6190X ||
> > > > +	    chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6390X)
> > > > +		mv88e6390_erratum_3_14(mpcs);
> > 
> > 	int err;
> > ...
> > 	if (mpcs->erratum_3_14) {
> > 		err = mv88e6390_erratum_3_14(mpcs);
> > 		if (err)
> > 			dev_err(mpcs->mdio.dev.parent,
> > 				"failed to apply erratum 3.14: %pe\n",
> > 				ERR_PTR(err));
> > 	}
> > 
> 
> So you propose to ditch the chip ptr from the mpcs and add a bool variable instead. But
> isn't this too general - the errata applies only to 6190X and 6390X, other devices
> might (and probably do) have errata 3.14 as something completely different? Possible new changes
> (new errata, fixes etc) in the pcs-xxx.c might benefit from having a chip ptr more than 
> using a bool variable "just" for one errata found on two device types?

As a longer term goal, I would like to move the pcs drivers out of
mv88e6xxx and into drivers/net/pcs, so I want to minimise the use of
the "chip" pointer in the drivers. That's why I coded them the way I
have, as almost entirely stand-alone implementations that make no use
of the hardware accessors provided by the 88e6xxx core.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
