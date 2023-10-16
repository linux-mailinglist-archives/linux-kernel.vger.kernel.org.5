Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4807CAB49
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjJPOWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjJPOWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:22:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923489B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 07:22:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC45AC433CA;
        Mon, 16 Oct 2023 14:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697466127;
        bh=7ut8R7I0LgKdNiZkpraTHOG9TpuCMcSaL//bQFLc0+U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P/dLmVoN+A5AiY1dRBROyri1XWhaV/Hcm+Z04t5juYnZZzo2EdMz5yGoR/+rwwx0U
         TeJl8eC84R5YV9yv6hPFVuTqkkpzCBmXNWzFGsngFLwtZbaQa/4kcSG+7gjhwU5rp3
         38/vvsqRLyjeOc/SyNuR1s08buoz6TH2BkBEpbvER09fIFdJYWTLVLZNPCFUvYsHxe
         MHYXQt2Rc2hk6v9UAlA/g2VYNtIkfMaX800ZqPzHYuXQ7YAxr2kVe5EYnzPUgQCmLa
         fQClp9+LXcqZfb/ooCAKhyE9yapeGu0aTSvp7mcL3OMpyuLy5kBKz2+g5cmAgI7Gmd
         iLjpua0OQCEQg==
Date:   Mon, 16 Oct 2023 07:22:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 08/16] net: ethtool: Add a command to expose
 current time stamping layer
Message-ID: <20231016072204.1cb41eab@kernel.org>
In-Reply-To: <20231016124134.6b271f07@kmaincent-XPS-13-7390>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
        <20231009155138.86458-9-kory.maincent@bootlin.com>
        <2fbde275-e60b-473d-8488-8f0aa637c294@broadcom.com>
        <20231010102343.3529e4a7@kmaincent-XPS-13-7390>
        <20231013090020.34e9f125@kernel.org>
        <6ef6418d-6e63-49bd-bcc1-cdc6eb0da2d5@lunn.ch>
        <20231016124134.6b271f07@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 12:41:34 +0200 K=C3=B6ry Maincent wrote:
> > Netdev vs phylib is an implementation detail of Linux.
> > I'm also surprised that you changed this. =20
>=20
> This is the main reason I changed this. This is Linux implementation purp=
ose to
> know whether it should go through netdev or phylib, and then each of these
> drivers could use other timestamps which are hardware related.

For an integrated design there's 90% chance the stamping is done=20
by the MAC. Even if it isn't there's no difference between PHY
and MAC in terms of quality.

But there is a big difference between MAC/PHY and DMA which would
both fall under NETDEV?
