Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443D078C7D5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbjH2Om7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbjH2Omg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:42:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E916BCC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:42:25 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qazv2-00055u-JZ; Tue, 29 Aug 2023 16:42:12 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qazuz-0007w2-Bn; Tue, 29 Aug 2023 16:42:09 +0200
Date:   Tue, 29 Aug 2023 16:42:09 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
        Oleksij Rempel <linux@rempel-privat.de>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        f.fainelli@gmail.com, andrew@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, Woojung.Huh@microchip.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <20230829144209.GD31399@pengutronix.de>
References: <BYAPR11MB35583A648E4E44944A0172A0ECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20230825103911.682b3d70@wsk>
 <862e5225-2d8e-8b8f-fc6d-c9b48ac74bfc@gmail.com>
 <BYAPR11MB3558A24A05D30BA93408851EECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20230826104910.voaw3ndvs52yoy2v@skbuf>
 <20230829103533.7966f332@wsk>
 <20230829101851.435pxwwse2mo5fwi@skbuf>
 <20230829132429.529283be@wsk>
 <20230829114739.GC31399@pengutronix.de>
 <20230829143829.68410966@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829143829.68410966@wsk>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 02:38:29PM +0200, Lukasz Majewski wrote:
> Hi Oleksij,

...

> Hence, I would prefer to apply the Errata and then somebody, who would
> like to enable EEE can try if it works for him.

ok.

> IMHO, code to fix erratas shall be added unconditionally, without any
> "freedom of choic

This claim is not consistent with the patch. To make it without ability
to enable EEE, you will need to clear all eee_supported bits.
If this HW is really so broken, then it is the we how it should be
fixed.

> > Beside, are you able to reproduce this issue?
> 
> Yes, I can reproduce the issue. I do use two Microchip's development
> boards (KSZ9477-EVB [1]) connected together to test HSR as well as
> communication with HOST PC.

I use KSZ9477-EVB as well.

> The network on this board without this patch is not usable (continually
> I do encounter link up/downs).

My test setup runs currently about two hours. It had 4 link drops on LAN3 and
none on other ports. Swapping cables connected to LAN2 and LAN3 still let the
LAN3 sometimes drop the connection. So far, for example LAN2 works stable and
this is probably the reason why I have not seen this issue before.
After disabling EEE on LAN3 I start getting drops on LAN2.

> Please be also aware, that this errata fix is (implicitly I think)
> already present in the kernel:
> https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/micrel.c#L1804
> 
> However, the execution order of PHY/DSA functions with newest mainline
> makes it not working any more (I've described it in details in the
> earlier mail to Vladimir).

Ok, since it was already not advertised by default, I have nothing against
having default policy to not advertise EEE for this switch.

On other hand, since this functionality is not listed as supported by the
KSZ9477 datasheet (No word about IEEE 802.3az Energy Efficient Ethernet (EEE))
compared to KSZ8565R datasheet (where EEE support is listed) and it is
confirmed to work not stable enough, then it should be disabled properly.
The phydev->supported_eee should be cleared. See ksz9477_get_features().


Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
