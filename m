Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26287AB12C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbjIVLte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIVLtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:49:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E390FB;
        Fri, 22 Sep 2023 04:49:24 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0E814B53;
        Fri, 22 Sep 2023 13:47:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695383265;
        bh=RsEjlGqls7ExAHNWGeGdLiTI5G08Gf1eQy4YrWddtf0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dmtN1uk0cAOHTkjh8sbEJohdGgZhAXZtvZpPJ1WeYYA5/L+9jej0agOPFZdu9I949
         u3HPWqnB/KRV9v6FkSOflvleP+CMrwoy8HfbLywBreZln1ASEZzOqY1GBZGBDjqPBb
         I9GZMbn2zjW/tcADMB/fIbIe/DRJaP/BhqglUyiE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230922080421.35145-4-wsa+renesas@sang-engineering.com>
References: <20230922080421.35145-1-wsa+renesas@sang-engineering.com> <20230922080421.35145-4-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 3/3] media: dvb-frontends: drop check because i2c_unregister_device() is NULL safe
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Date:   Fri, 22 Sep 2023 12:49:19 +0100
Message-ID: <169538335996.2915094.5298425556148305413@ping.linuxembedded.co.uk>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wolfram Sang (2023-09-22 09:04:20)
> No need to check the argument of i2c_unregister_device() because the
> function itself does it.
>=20

Having reviewed the RDACM20 patch, I think I can say this looks accurate
too.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> Build tested only. Please apply to your tree.
>=20
>  drivers/media/dvb-frontends/m88ds3103.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/dvb-frontends/m88ds3103.c b/drivers/media/dvb-=
frontends/m88ds3103.c
> index cf037b61b226..26c67ef05d13 100644
> --- a/drivers/media/dvb-frontends/m88ds3103.c
> +++ b/drivers/media/dvb-frontends/m88ds3103.c
> @@ -1920,8 +1920,7 @@ static void m88ds3103_remove(struct i2c_client *cli=
ent)
> =20
>         dev_dbg(&client->dev, "\n");
> =20
> -       if (dev->dt_client)
> -               i2c_unregister_device(dev->dt_client);
> +       i2c_unregister_device(dev->dt_client);
> =20
>         i2c_mux_del_adapters(dev->muxc);
> =20
> --=20
> 2.30.2
>
