Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9681A7AD128
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjIYHLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjIYHLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:11:37 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B31DF;
        Mon, 25 Sep 2023 00:11:29 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id ABFB31C0009;
        Mon, 25 Sep 2023 07:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695625888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26b231nqCTW8YDmT+k7imAl/79DNcgXu5bn48KEqLfw=;
        b=YRwCKHNBWwQ1FkvaWVZ/Og+/mmFqwxLmWm2f3iKU1+p1xFst5DGy+XnneU44A9RrjA3rdg
        Azus39eWfnwxy8U2CZv2jAH2XzDpT5cL0cAeatZKCjXfpaHt37LkBNDc6D4y+U0amFOwO+
        Wz3ubnrtPFXFT51WV7uyVWlSZ+CLcKdPiqrR39Tmev8eTSl3cUycwiP21pIHIfKpU5hxAs
        Tlo7aw+7+U3cKugIdfFU1cR697vD7Ymc4/7wNi0ukIWN1L1hg3KDkT+DCd77+hUQD02ZQk
        68yf2yVVFqd5CGFbldFY4WeP+EyBQkg3hbAjHwJvrIZsiyAAJV94buF5YZ22nA==
Date:   Mon, 25 Sep 2023 09:11:25 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 2/6] mtd: parsers: ar7: remove support
Message-ID: <20230925091125.299caa92@xps-13>
In-Reply-To: <52ba27b9-79d5-f9cc-450f-fe831e65769a@linaro.org>
References: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
        <20230922061530.3121-3-wsa+renesas@sang-engineering.com>
        <20230922163903.3f49ea2a@xps-13>
        <ZQ3VA/2pAC3Do1Xd@ninjato>
        <52ba27b9-79d5-f9cc-450f-fe831e65769a@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

philmd@linaro.org wrote on Fri, 22 Sep 2023 20:35:16 +0200:

> On 22/9/23 19:55, Wolfram Sang wrote:
> >  =20
> >> I'm not sure it is wise to merge defconfig changes through mtd. Would
> >> you mind sending this change aside to avoid potential conflicts? Each
> >> patch can live on their own anyway. =20
> >=20
> > Yup, I can send a seperate patch for it.
> >  =20
> >>>   drivers/mtd/parsers/Kconfig    |   5 --
> >>>   drivers/mtd/parsers/Makefile   |   1 -
> >>>   drivers/mtd/parsers/ar7part.c  | 129 ------------------------------=
--- =20
> >>
> >> Do you have other changes related to this file in your tree? It failed
> >> to apply on my side. =20
> >=20
> > No change. Plain v6.6-rc2. I used "--irreversible-delete", though. Maybe
> > this is causing issues? As I stated in the cover-letter, I wonder if all
> > this should go via MIPS. But there hasn't been any discussion about it
> > yet. =20
>=20
> MIPS tree for the whole series certainly makes sense.

Then:

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
