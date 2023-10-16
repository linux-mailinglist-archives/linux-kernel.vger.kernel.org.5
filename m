Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838857CA016
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjJPHF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJPHF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:05:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F77597;
        Mon, 16 Oct 2023 00:05:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9c2a0725825so136795366b.2;
        Mon, 16 Oct 2023 00:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697439924; x=1698044724; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U8lOOx6lw4m+aRKaeUWAOB1OulRqzjm45E6yYZ18Ztk=;
        b=OECJfPRzJJVUB5vkKD2y2pvMSfKox4bsT3ywBe1Ef6vs/wQ2A54QacmimTW2lAr1Qq
         +hxhmAHjHc4d2IKWlfymtBPq+QDvz11UOxtcIzYKs4TyTFDpvU1cVBVnS3LS32sr0Pgc
         a+5bcTBQBmmCYQHm4PZUz80aqxM7sYLBP/OQELO9IJmynDB7U4dx/8bVsM3tMrTfPzg1
         EISWK1GON2ix+7jodro8iTRRz62dVH3V+Aygmzouk9pnslh8/7QmS1NnwoAtOWeL5CEN
         pmpHWpQ2f2rdQFlYTljqph2nUvjkveg6q15MZ4gqe3b2u0XC0CZWqU66P06kYQqLyrd3
         YgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697439924; x=1698044724;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U8lOOx6lw4m+aRKaeUWAOB1OulRqzjm45E6yYZ18Ztk=;
        b=p1MtFS/D+78GRAjLidVUNd57VCsrz4cbS85+iFq5AOhC9dmhEW309/t1ID1yHkxR3Z
         RTcTHRhCEVbkFJOlYHKT0ErOKDmI6qSbD3/joVzuAviehVeo6umJlob/dn4M50FEwjI/
         EJahr4k0zyMSoVms/xFInUV95LY4JXaG0Li24CyaifsSe+lxpPgAs3XuKSxBi3yYLQzg
         JxFBBTBGWcfK5eNdIAKRhRCvqc/Xx5TZlPcCHfmY8Mk9KXNdcTFsavree3PqJ3EygYCk
         APp2zMxAxy/WU61DhDcN4ClpXXE8PN5lwJfT6W1bes2521WgWiygQmE3BSeE4/J9Uzt+
         yyKQ==
X-Gm-Message-State: AOJu0YxjO9BBGvFvYpd8esnoawYzj5j3SzmfHgtZYuoFyKCei5DnO6lD
        Guz6GyeJrf5PhmWvC3ndLJA=
X-Google-Smtp-Source: AGHT+IHHRLF5Ivh3NvleYOiiteKfQHg3q37c1oAU2s5AZ1beCmOTCl2v+sPRDptu8zqRPCiH9pD5Tg==
X-Received: by 2002:a17:907:7ea0:b0:9a5:9038:b1e7 with SMTP id qb32-20020a1709077ea000b009a59038b1e7mr36618516ejc.36.1697439923569;
        Mon, 16 Oct 2023 00:05:23 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:361b:8f29:1cbf:5e69? (p200300f6ef1b2000361b8f291cbf5e69.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:361b:8f29:1cbf:5e69])
        by smtp.gmail.com with ESMTPSA id v14-20020a1709061dce00b009828e26e519sm3394724ejh.122.2023.10.16.00.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 00:05:22 -0700 (PDT)
Message-ID: <c4790cd83c75a887a336e47fc3dc8aa7f4faf78b.camel@gmail.com>
Subject: Re: [PATCH] iio: resolver: ad2s1210: add support for adi,fixed-mode
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        nuno.sa@analog.com, linux-kernel@vger.kernel.org
Date:   Mon, 16 Oct 2023 09:08:12 +0200
In-Reply-To: <CAMknhBGdfdm8VpzXs1qh0N8F-CmkZk+1KM5+1WCz1D70Cmm_=A@mail.gmail.com>
References: <20231012204509.3095010-1-dlechner@baylibre.com>
         <56e2d1cbe6671bc6709926771602b3aa412c1656.camel@gmail.com>
         <CAMknhBGdfdm8VpzXs1qh0N8F-CmkZk+1KM5+1WCz1D70Cmm_=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-13 at 09:27 -0500, David Lechner wrote:
> On Fri, Oct 13, 2023 at 2:50=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >=20
> > Hi David,
> >=20
> > Couple of minor things...
> >=20
> > On Thu, 2023-10-12 at 15:45 -0500, David Lechner wrote:
> > > It is possible to use the AD2S1210 with hardwired mode pins (A0 and A=
1).
> > > According to the devicetree bindings, in this case the adi,fixed-mode
> > > property will specify which of the 3 possible modes the mode pins are
> > > hardwired for and the gpio-modes property is not allowed.
> > >=20
> > > This adds support for the case where the mode pins are hardwired for
> > > config mode. In this configuration, the position and velocity must be=
 read
> > > from the config register.
> > >=20
> > > The cases of hardwired position or velocity modes is not supported as
> > > there would be no way to configure the device.
> > >=20
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > > =C2=A0drivers/iio/resolver/ad2s1210.c | 193 +++++++++++++++++++++++++=
++-----
> > > =C2=A01 file changed, 162 insertions(+), 31 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/resolver/ad2s1210.c
> > > b/drivers/iio/resolver/ad2s1210.c
> > > index 1bd1b950e7cc..e6d3f31d529f 100644
> > > --- a/drivers/iio/resolver/ad2s1210.c
> > > +++ b/drivers/iio/resolver/ad2s1210.c
> > > @@ -141,7 +141,7 @@ struct ad2s1210_state {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_device *sdev;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /** GPIO pin connected to SAMPLE line.=
 */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gpio_desc *sample_gpio;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 /** GPIO pins connected to A0 and A1 lines.=
 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 /** GPIO pins connected to A0 and A1 lines =
(optional). */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gpio_descs *mode_gpios;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /** Used to access config registers. *=
/
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct regmap *regmap;
> > > @@ -149,6 +149,8 @@ struct ad2s1210_state {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long clkin_hz;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /** Available raw hysteresis values ba=
sed on resolution. */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int hysteresis_available[2];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 /* adi,fixed-mode property - only valid whe=
n mode_gpios =3D=3D NULL. */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 enum ad2s1210_mode fixed_mode;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /** The selected resolution */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum ad2s1210_resolution resolution;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /** Copy of fault register from the pr=
evious read. */
> > > @@ -175,6 +177,9 @@ static int ad2s1210_set_mode(struct ad2s1210_stat=
e
> > > *st,
> > > enum ad2s1210_mode mode)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gpio_descs *gpios =3D st->mode_=
gpios;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DECLARE_BITMAP(bitmap, 2);
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!gpios)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return mode =3D=3D st->fixed_mode ? 0 : -EOPNOTSUPP;
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap[0] =3D mode;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return gpiod_set_array_value(gpios->nd=
escs, gpios->desc, gpios-
> > > >info,
> > > @@ -276,7 +281,8 @@ static int ad2s1210_regmap_reg_read(void *context=
,
> > > unsigned int reg,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * parity error. The fault regist=
er is read-only and the D7 bit
> > > means
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * something else there.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (reg !=3D AD2S1210_REG_FAULT && st->rx[1=
] & AD2S1210_ADDRESS_DATA)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if ((reg > AD2S1210_REG_VELOCITY_LSB && reg=
 !=3D AD2S1210_REG_FAULT)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 && st->rx[1] =
& AD2S1210_ADDRESS_DATA)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -EBADMSG;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D st->rx[1];
> > > @@ -437,6 +443,40 @@ static void ad2s1210_push_events(struct iio_dev
> > > *indio_dev,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->prev_fault_flags =3D flags;
> > > =C2=A0}
> > >=20
> > > +/**
> > > + * Reads position or velocity from the config registers.
> > > + *
> > > + * This is used when the mode gpios are not available.
> > > + *
> > > + * Must be called with the lock held.
> > > + *
> > > + * @param st The device state.
> > > + * @param val Pointer to hold the value read.
> > > + * @param msb_reg The register address of the MSB register.
> > > + * @param lsb_reg The register address of the LSB register.
> > > + * @return 0 on success, negative error code otherwise.
> > > + */
> > > +static int ad2s1210_read_val_from_config(struct ad2s1210_state *st,
> > > __be16
> > > *val,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 u8 msb_reg, u8 lsb_reg)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int reg_val;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_read(st->regmap, msb_reg, &r=
eg_val);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 ((u8 *)val)[0] =3D reg_val;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_read(st->regmap, lsb_reg, &r=
eg_val);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 ((u8 *)val)[1] =3D reg_val;
> >=20
> > These casts are not that nice... Is sparse even ok with this without
> > __force?
> > I didn't looked at the datasheet so I have no idea but is regmap_bulk_r=
ead()
> > an
> > option? It would simplify things.
>=20
> regmap_bulk_read() does work, thanks for the suggestion.
>=20
> >=20
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > +}
> >=20
> > ...
> >=20
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad2s1210_push_events(indio_dev, st->sa=
mple.fault, pf->timestamp);
> > > @@ -1299,9 +1397,33 @@ static const struct iio_info ad2s1210_info =3D=
 {
> > > =C2=A0static int ad2s1210_setup_properties(struct ad2s1210_state *st)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D &st->sdev->dev;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 const char *str_val;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 val;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D device_property_read_string(dev, "a=
di,fixed-mode", &str_val);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D -EINVAL)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 st->fixed_mode =3D -1;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 else if (ret < 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return dev_err_probe(dev, ret,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "failed to read adi,=
fixed-mode property\n");
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 else {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (strcmp(str_val, "position") =3D=3D 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->fixed_mode =3D M=
OD_POS;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 else if (strcmp(str_val, "velocity") =3D=3D 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->fixed_mode =3D M=
OD_VEL;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 else if (strcmp(str_val, "config") =3D=3D 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->fixed_mode =3D M=
OD_CONFIG;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 else
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev_err_probe=
(dev, -EINVAL,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "invalid adi,fixed-mode property value:
> > > %s\n",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 str_val);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (st->fixed_mode !=3D MOD_CONFIG)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev_err_probe=
(dev, -EINVAL,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "only adi,fixed-mode=3D\"config\" is
> > > supported\n");
> >=20
> > Why not?
> >=20
> > if (strcmp(str_val, "config"))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev_err_probe();
> >=20
> > st->fixed_mode =3D MOD_CONFIG;
> >=20
> > Am I missing something obvious?
>=20
> I made different error messages to differentiate between values not
> allowed by the device tree vs. not supported by the driver. I don't
> have a problem with simplifying it though.
>=20
> >=20
Yeah, I also don't feel too strong about it but, personally, I would just g=
o to
the simpler form. For example, the message "only adi,fixed-mode=3D\"config\=
" is
supported" should already be sufficient and explicit about the error... Bah=
, up
to you :)

- Nuno S=C3=A1
>=20

>=20
