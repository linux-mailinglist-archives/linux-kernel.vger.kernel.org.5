Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DA47BF48F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442547AbjJJHkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442446AbjJJHkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:40:39 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763B192;
        Tue, 10 Oct 2023 00:40:36 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DD85424000E;
        Tue, 10 Oct 2023 07:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696923634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z5mbSaDFWT4F1pg9/UQXeQubE+UDM5n2XaAROADfaZ8=;
        b=kjM9mNev2AShbfug3CIC1p9m8VPnj9VN7bck6ZwquYIEqgJR4gpvuw2KTym4bvC8IyW+OK
        sDxtdebTx/AyoV75d9kTHd7RSZhDV7SBhI6M4U+0Qx3l36ZpW1PSg22etM0QTtyoWqRNom
        sDrS+jVE/LU8phy9/GEr/0Q/Q1XVyfko1wgpc1AIJ1USRwz1Y5qmNMdOhIL12MC2dFcalb
        +11WLE8TRR/kgj3agsoSyCrRTMRWY4X2/l74Rc6g8nfo91SrYBhWsrYn580bKwXfpEHI3i
        1U4ucR8u+igLPRt+X1CruJfne4fZ8pySUkM133/aiQ75wr1PDOJKLmZ0ZvFTug==
Date:   Tue, 10 Oct 2023 09:40:28 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 05/16] net: Make dev_set_hwtstamp_phylib
 accessible
Message-ID: <20231010094028.74185a50@kmaincent-XPS-13-7390>
In-Reply-To: <57791a7d-04ce-4d02-815d-7f540ea15b89@gmail.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
        <20231009155138.86458-6-kory.maincent@bootlin.com>
        <57791a7d-04ce-4d02-815d-7f540ea15b89@gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2023 14:09:29 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

> > -static int dev_set_hwtstamp_phylib(struct net_device *dev,
> > -				   struct kernel_hwtstamp_config *cfg,
> > -				   struct netlink_ext_ack *extack)
> > +int dev_set_hwtstamp_phylib(struct net_device *dev,
> > +			    struct kernel_hwtstamp_config *cfg,
> > +			    struct netlink_ext_ack *extack)
> >   {
> >   	const struct net_device_ops *ops = dev->netdev_ops;
> >   	bool phy_ts = phy_has_hwtstamp(dev->phydev);  
> 
> Missing EXPORT_SYMBOL_GPL() here?

True. Will be fixed in next version.
