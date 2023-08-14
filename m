Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9E677BE52
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjHNQoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjHNQny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:43:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18337E65;
        Mon, 14 Aug 2023 09:43:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3197b461bb5so702642f8f.3;
        Mon, 14 Aug 2023 09:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692031431; x=1692636231;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QcV/Qi3bNqSTHWoo2wyHtkP3GXOLBpyAawkkekXtGoc=;
        b=ohDZd8D3k7q+R7Wgv6pDh8mZ2FWd0cDL11F3vtkm9UUjOQSaBr090DAGbIxRJAp6Ko
         ItmA6+oE/3eZrYmuNE4/0Vkf2C1KR38vZoSdU32lLK3jwf4FnDRd1dUI3lqNfFL3sD0v
         PlvRqqliYF54tgEFu5SwFVpU+VrRUUjRA9NTcE5pwGaIsZNbiuvRS2KP0nV5XIjEi096
         yhK5+PwYc65h2wEEfz2MkiHyIm+WnraRj358y0m4Dsb2tqsyHvJfvNZQW+qE6iEMIhCa
         CO4y+433Fo8tP/5u8+S2VwTcrqf5RmRLY6WVwev+LXvJcw9J7zmfmg4b8a2UHP6O3f66
         dDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692031431; x=1692636231;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QcV/Qi3bNqSTHWoo2wyHtkP3GXOLBpyAawkkekXtGoc=;
        b=Rk8no7mKWpeCAKzQO1fBm7EcqnRlbPpzP1MtYCzkruIlKSGG4vNt4N2F/XIES1uiNb
         qyOYmVzJW+/zR/SoAtyDblR737qk9b0dh1Nk/b6C965H68xPVwKn3lyV9kDuQk2BooDO
         f1mTJF/GKOCWLQPJ5Zh1WLPt6j3CmsDDaAgYpV4bNaWFXu/aFjLCKg+vMKG5KnNK24eG
         KpNU4MLW9erfU+f+zwlEEt5jBX8vHTGzF9rc+vOabix/RG/qzhWIvbqrSl8iWICG+iW4
         Q1SEz6G/qHC9/RzgKdE5P+OpG9CWKIuzUqkwbl6X5KfZDz0SNHJ0uLi+OxSHuXstXpKw
         1jhQ==
X-Gm-Message-State: AOJu0Yzhvc+6vK2kElYI8JirmHJTmN/k3V6lxjYMkDMAJaSL17envYuM
        9REtS0085t7U6V5opvuaqbWnYtT4040=
X-Google-Smtp-Source: AGHT+IG8uA+jP2upULXvv/RXRMZgq30oshgUhmW73T0YKn9CPSZ15Ec4dguH5H7MM9lPXPbf7BWh1w==
X-Received: by 2002:a5d:6809:0:b0:314:1ca4:dbd9 with SMTP id w9-20020a5d6809000000b003141ca4dbd9mr6962731wru.27.1692031431265;
        Mon, 14 Aug 2023 09:43:51 -0700 (PDT)
Received: from DreamMachine2.lan (35.red-83-35-63.dynamicip.rima-tde.net. [83.35.63.35])
        by smtp.gmail.com with ESMTPSA id k3-20020a056000004300b003177074f830sm14990946wrx.59.2023.08.14.09.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:43:50 -0700 (PDT)
Message-ID: <a83bde5079b769950220c0f1f3b8d374db39cfc7.camel@gmail.com>
Subject: Re: [PATCH v2 2/3] iio: pressure: bmp280: Use i2c_get_match_data
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Mon, 14 Aug 2023 18:43:49 +0200
In-Reply-To: <OS0PR01MB5922EDF7759069CD4993FA468617A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <cover.1691952005.git.ang.iglesiasg@gmail.com>
         <55f8dc02de16a353f0449bc1c7cb487bd776dfaf.1691952005.git.ang.iglesiasg@gmail.com>
         <954c859835aed6c41a356fdd999a8be51469eb9e.camel@gmail.com>
         <OS0PR01MB5922EDF7759069CD4993FA468617A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-08-14 at 06:57 +0000, Biju Das wrote:
> Hi Angel Iglesias,
>=20
>=20
> > Subject: Re: [PATCH v2 2/3] iio: pressure: bmp280: Use i2c_get_match_da=
ta
> >=20
> > On Sun, 2023-08-13 at 21:03 +0200, Angel Iglesias wrote:
> > > Replaces device_get_match_data() and fallback match_id logic by new
> > > unified helper function i2c_get_match_data().
> > >=20
> > > Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> > >=20
> > > diff --git a/drivers/iio/pressure/bmp280-i2c.c
> > > b/drivers/iio/pressure/bmp280- i2c.c index 693eb1975fdc..34e3bc758493
> > > 100644
> > > --- a/drivers/iio/pressure/bmp280-i2c.c
> > > +++ b/drivers/iio/pressure/bmp280-i2c.c
> > > @@ -11,9 +11,7 @@ static int bmp280_i2c_probe(struct i2c_client
> > > *client)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct bmp280_c=
hip_info *chip_info;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct regmap *regmap=
;
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chip_info =3D device_get_m=
atch_data(&client->dev);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!chip_info)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0chip_info =3D (const struct bmp280_chip_info *)
> > > id->driver_data;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chip_info =3D i2c_get_matc=
h_data(client);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap =3D devm_regma=
p_init_i2c(client,
> > > chip_info->regmap_config);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(regmap)) {
> >=20
> > Hi,
> >=20
> > I noticed I submitted this change that was also submitted by Biju Das o=
n
> > another
> > patch:
>=20
> > Should I drop this patch from the series?
>=20
> I think it is ok. Andy is suggesting to use unified table for SPI/I2C
>=20
> Is it something do able and testable in your environment? see [1],
> If yes, please create another patch for using unified table for both i2c =
and
> spi.

I have around a BMP390 with the SPI pins available to test it out. In the c=
ase
of the bmp280 we could unify the of_match table as they're almost the same.=
 In
the case of the spi_device_id and i2c_device_id tables, as they're differen=
t
structs I'm not sure if they can be unified.

Regarding Andy's comment, I think he's referring to the duplicated chip inf=
os.
In the case of the bmp280, the chip_infos are defined on the common driver =
code
and used for both SPI and I2C match tables.

>=20
> https://lore.kernel.org/linux-renesas-soc/CAHp75VeX+T=3DhAN+PgtHTdv4b6UtD=
VgveUUww1b1kuOngzDinFw@mail.gmail.com/T/#t
>=20
> Cheers,
> Biju

Kind regards,
Angel

