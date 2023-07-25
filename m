Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03F4762072
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjGYRt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjGYRt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:49:28 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668351B8;
        Tue, 25 Jul 2023 10:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WVszs+fPV5VJocGPJkqZKe75524bLLu7x9J+uwzPtJU=; b=0PcLQR3XYRdPqWSnrpPNmhk0fz
        IfRZ5L4LfwiHloTc18gvxXessmJlAYjKCTwndg6y05chbPM+LMDEFRfHBcVXuDA4PpJFQ2su0bsCc
        LZEJ0h+0TNOehQHyZqQtZPKA0LX8mU10mYDYXFmN/Yqg6roLzGqom43oH1eJb8O7QMtY9WkJ4KhYA
        y/vhtWnaCuPscOuahc8oPg4AI1/331opk3c8ThOJq5XV8ksEyVhNl8QY0pnWd0Yyd41vA6MslfUMx
        +YMXmyDX/4JaJTev9MalSiDJUKdPgxHr+pStkd/3pEWXSvOH7CRKm5vaG2zAJQHySGu5oddQ57+yX
        IXHzF9vw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52426)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qOM9x-0002PW-07;
        Tue, 25 Jul 2023 18:49:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qOM9v-00022L-G6; Tue, 25 Jul 2023 18:49:19 +0100
Date:   Tue, 25 Jul 2023 18:49:19 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
        andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: Add erratum 3.14 for
 88E6390X and 88E6190X
Message-ID: <ZMALH03Fbp3wKkO2@shell.armlinux.org.uk>
References: <20230721102618.13408-1-ante.knezic@helmholz.de>
 <20230721102618.13408-1-ante.knezic@helmholz.de>
 <20230725172343.qcqmcoygyhcgunmh@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725172343.qcqmcoygyhcgunmh@skbuf>
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

Sorry, I don't have the original email to reply to, and this is the
first which includes most of the patch. This reply is primerily for
Ante Knezic.

On Tue, Jul 25, 2023 at 08:23:43PM +0300, Vladimir Oltean wrote:
> On Fri, Jul 21, 2023 at 12:26:18PM +0200, Ante Knezic wrote:
> > diff --git a/drivers/net/dsa/mv88e6xxx/pcs-639x.c b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
> > index 98dd49dac421..50b14804c360 100644
> > --- a/drivers/net/dsa/mv88e6xxx/pcs-639x.c
> > +++ b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
> > @@ -20,6 +20,7 @@ struct mv88e639x_pcs {
> >  	struct mdio_device mdio;
> >  	struct phylink_pcs sgmii_pcs;
> >  	struct phylink_pcs xg_pcs;
> > +	struct mv88e6xxx_chip *chip;

	bool erratum_3_14;

> >  	bool supports_5g;
> >  	phy_interface_t interface;
> >  	unsigned int irq;
> > @@ -205,13 +206,52 @@ static void mv88e639x_sgmii_pcs_pre_config(struct phylink_pcs *pcs,
> >  	mv88e639x_sgmii_pcs_control_pwr(mpcs, false);
> >  }
> >  
> > +static int mv88e6390_erratum_3_14(struct mv88e639x_pcs *mpcs)
> > +{
> > +	const int lanes[] = { MV88E6390_PORT9_LANE0, MV88E6390_PORT9_LANE1,
> > +		MV88E6390_PORT9_LANE2, MV88E6390_PORT9_LANE3,
> > +		MV88E6390_PORT10_LANE0, MV88E6390_PORT10_LANE1,
> > +		MV88E6390_PORT10_LANE2, MV88E6390_PORT10_LANE3 };
> > +	struct mdio_device mdio;
> > +	int err, i;
> > +
> > +	/* 88e6190x and 88e6390x errata 3.14:
> > +	 * After chip reset, SERDES reconfiguration or SERDES core
> > +	 * Software Reset, the SERDES lanes may not be properly aligned
> > +	 * resulting in CRC errors
> > +	 */

Does the errata say that _all_ lanes need this treatment, even when
they are not being used as a group (e.g. for XAUI) ?

> > +
> > +	mdio.bus = mpcs->mdio.bus;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(lanes); i++) {
> > +		mdio.addr = lanes[i];
> > +
> > +		err = mdiodev_c45_write(&mdio, MDIO_MMD_PHYXS,
> > +					0xf054, 0x400C);
> > +		if (err)
> > +			return err;
> > +
> > +		err = mdiodev_c45_write(&mdio, MDIO_MMD_PHYXS,
> > +					0xf054, 0x4000);
> > +		if (err)
> > +			return err;
> 
> I'm not sure which way is preferred by PHY maintainers, but it seems to
> be a useless complication to simulate that you have a struct mdio_device
> for the other lanes when you don't. It appears more appropriate to just
> use mdiobus_c45_write(mpcs->mdio.bus, lanes[i]).
> 
> There's also the locking question (with the big caveat that we don't
> know what the register writes do!). There's locking at the bus level,
> but the MDIO device isn't locked. So phylink on those other PCSes can
> still do stuff, even in-between the first and the second write to
> undocumented register 0xf054.
> 
> I can speculate that writing 0x400c -> 0x4000 is something like: set
> RX_RESET | TX_RESET followed by clear RX_RESET | TX_RESET. Is it ok if
> stuff happens in between these writes - will it stick, or does this
> logically interact with anything else in any other way? I guess we won't
> know. I might be a bit closer to being okay with it if you could confirm
> that some other (unrelated) register write to the PCS does make it
> through (and can be read back) in between the 2 erratum writes.
> 
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int mv88e639x_sgmii_pcs_post_config(struct phylink_pcs *pcs,
> >  					   phy_interface_t interface)
> >  {
> >  	struct mv88e639x_pcs *mpcs = sgmii_pcs_to_mv88e639x_pcs(pcs);
> > +	struct mv88e6xxx_chip *chip = mpcs->chip;
> >  
> >  	mv88e639x_sgmii_pcs_control_pwr(mpcs, true);
> >  
> > +	if (chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6190X ||
> > +	    chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6390X)
> > +		mv88e6390_erratum_3_14(mpcs);

	int err;
...
	if (mpcs->erratum_3_14) {
		err = mv88e6390_erratum_3_14(mpcs);
		if (err)
			dev_err(mpcs->mdio.dev.parent,
				"failed to apply erratum 3.14: %pe\n",
				ERR_PTR(err));
	}

> 
> You could at least print an error if a write failure occurred, so that
> it doesn't go completely unnoticed.
> 
> > +
> >  	return 0;
> >  }
> >  
> > @@ -523,6 +563,7 @@ static int mv88e6390_pcs_init(struct mv88e6xxx_chip *chip, int port)
> >  	mpcs->sgmii_pcs.neg_mode = true;
> >  	mpcs->xg_pcs.ops = &mv88e6390_xg_pcs_ops;
> >  	mpcs->xg_pcs.neg_mode = true;
> > +	mpcs->chip = chip;

	if (chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6190X ||
	    chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6390X)
		mpcs->erratum_3_14 = true;

> >  
> >  	err = mv88e639x_pcs_setup_irq(mpcs, chip, port);
> >  	if (err)
> > @@ -873,6 +914,7 @@ static int mv88e6393x_pcs_init(struct mv88e6xxx_chip *chip, int port)
> >  	mpcs->xg_pcs.ops = &mv88e6393x_xg_pcs_ops;
> >  	mpcs->xg_pcs.neg_mode = true;
> >  	mpcs->supports_5g = true;
> > +	mpcs->chip = chip;

Presumably the 6393x isn't affected by this, so this is not necessary
with the above changes.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
