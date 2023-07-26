Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912B87632C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjGZJuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjGZJuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:50:00 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FE6FD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=z/VYs/tG4q/jmWkTELjey7jwXdK/M+A/kvcC69LhECg=; b=nBeqMirnPYjIgzt1dxHLh5U/oI
        EPz6/Gu1wUjbSztxBJg8fXpga1gtvtFGX2G+2ixBUQ0IhIr0biy6TbW5mN3WqYnjD5k5wzfT/URCi
        t0vIPAxChnE1lug5q8QS95bOuzHBKrXgLGOUgU0iH41Fp2m1R8T7qHg5CB+n0lyqiH+VpfN0MEUiA
        A11mWpdnmqbzEUi27lYtquW4lwPXy0LhtXmGDKCwwwxWJ1bjiCcnkKDaTt06D6c41qMV+k+xgeTur
        gyEmSkTsbCOzO5mlKtM5sdzhLrTTAJDQOtxLS7Bw5NxmrrIqnwD0Cl/V/ehvwUprDhJSKGPIEycqV
        TrTk06Ow==;
Received: from [192.168.1.4] (port=36940 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qOb9G-0004Nd-1S;
        Wed, 26 Jul 2023 11:49:38 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Wed, 26 Jul 2023 11:49:38 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <linux@armlinux.org.uk>
CC:     <andrew@lunn.ch>, <ante.knezic@helmholz.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <olteanv@gmail.com>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: Add erratum 3.14 for 88E6390X and 88E6190X
Date:   Wed, 26 Jul 2023 11:49:35 +0200
Message-ID: <20230726094935.12629-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <ZMALH03Fbp3wKkO2@shell.armlinux.org.uk>
References: <ZMALH03Fbp3wKkO2@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 18:49:19 +0100 Russell King (Oracle) wrote:
> Does the errata say that _all_ lanes need this treatment, even when
> they are not being used as a group (e.g. for XAUI) ?

No, unfortunatelly errata says very little, I tried applying erratum only on the requested 
lane of port 9/10 but this did not work out as expected and the issue was still visible.
I dont have the necessary HW to perform more tests on other lanes unfortunatelly.

On Tue, 25 Jul 2023 18:49:19 +0100 Russell King (Oracle) wrote:
> On Tue, Jul 25, 2023 at 08:23:43PM +0300, Vladimir Oltean wrote:
> > On Fri, Jul 21, 2023 at 12:26:18PM +0200, Ante Knezic wrote:
> > > diff --git a/drivers/net/dsa/mv88e6xxx/pcs-639x.c b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
> > > index 98dd49dac421..50b14804c360 100644
> > > --- a/drivers/net/dsa/mv88e6xxx/pcs-639x.c
> > > +++ b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
> > > @@ -20,6 +20,7 @@ struct mv88e639x_pcs {
> > >  	struct mdio_device mdio;
> > >  	struct phylink_pcs sgmii_pcs;
> > >  	struct phylink_pcs xg_pcs;
> > > +	struct mv88e6xxx_chip *chip;
> 
> 	bool erratum_3_14;

...

> > >  static int mv88e639x_sgmii_pcs_post_config(struct phylink_pcs *pcs,
> > >  					   phy_interface_t interface)
> > >  {
> > >  	struct mv88e639x_pcs *mpcs = sgmii_pcs_to_mv88e639x_pcs(pcs);
> > > +	struct mv88e6xxx_chip *chip = mpcs->chip;
> > >  
> > >  	mv88e639x_sgmii_pcs_control_pwr(mpcs, true);
> > >  
> > > +	if (chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6190X ||
> > > +	    chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6390X)
> > > +		mv88e6390_erratum_3_14(mpcs);
> 
> 	int err;
> ...
> 	if (mpcs->erratum_3_14) {
> 		err = mv88e6390_erratum_3_14(mpcs);
> 		if (err)
> 			dev_err(mpcs->mdio.dev.parent,
> 				"failed to apply erratum 3.14: %pe\n",
> 				ERR_PTR(err));
> 	}
> 

So you propose to ditch the chip ptr from the mpcs and add a bool variable instead. But
isn't this too general - the errata applies only to 6190X and 6390X, other devices
might (and probably do) have errata 3.14 as something completely different? Possible new changes
(new errata, fixes etc) in the pcs-xxx.c might benefit from having a chip ptr more than 
using a bool variable "just" for one errata found on two device types?

> > >  
> > >  	err = mv88e639x_pcs_setup_irq(mpcs, chip, port);
> > >  	if (err)
> > > @@ -873,6 +914,7 @@ static int mv88e6393x_pcs_init(struct mv88e6xxx_chip *chip, int port)
> > >  	mpcs->xg_pcs.ops = &mv88e6393x_xg_pcs_ops;
> > >  	mpcs->xg_pcs.neg_mode = true;
> > >  	mpcs->supports_5g = true;
> > > +	mpcs->chip = chip;
> 
> Presumably the 6393x isn't affected by this, so this is not necessary
> with the above changes.

This was done merely for consistency, besides the memory is already reserved, why not point
it to something? In case of bool replacement it will not matter anymore.

Thanks,
	Ante
