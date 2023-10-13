Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445CA7C87D6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjJMO1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjJMO1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:27:47 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48F095
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:27:44 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c15463ddd4so26076621fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697207263; x=1697812063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrTbq6l4vJ/ozH4YXSFIVlz5uNA4zxMvtoWBLcKvON0=;
        b=eBU5488fE0r/QyCwW13LkSA6B79bL1HH5gtSKR1iqs6wdutZisTkw/C7ArhOIGbhHj
         Mb3erGUUgwqvMn/C0ukoCQmVrCtYtPnIYlkUQ1p3SNl+SEYkKsscSbFLn5lH1BwMSSJi
         rfojaDAGNAvddtJTw5iOCgt5EMfapYAgnmpT46spbH3hoUNW1wBbbeUVpxCOP3y5UhPw
         pUyaBB/iRazj5hbhJ2lp5N04mp53MZDpGQwKGAttZI4VH+P6RJmWpqq7Tzf9OXjCZ/sW
         yVZKDPmM9fEDFH8lrZC+nt8I34yYkQsSnqhD0MtNrz47pYe8b/R9JugLXvvHJ4NguQdn
         h2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697207263; x=1697812063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrTbq6l4vJ/ozH4YXSFIVlz5uNA4zxMvtoWBLcKvON0=;
        b=i9eCpLvfMn1n1u094JoPduuyhneNCU33Jo27lzvcmcJVKGUzqRg8aKQQAYAB/bjXa9
         HKX79ceONpX/hIhWRm8f9UltaGrv0723WXixIsN01ahvttE/A7Lw5qYtQyHU272ocx/N
         3oAIGcobT+IMbZNLzH9w7c9tJ29S+/SH7J2e6iqFlss+TDmeO4ZCn7yXILgpsyQTLfJp
         eXA8XYKUqvdheTYUcnCWb4f74CmYNJRgQVzzuDWUjL7Jh6UX4wqNjH8T8n1qYp4Fk6I8
         8a+0tDINkZEMfYgqbLLMyf5O+4ysRn4IPGayIhfSqMcJNls+RZt0vAtlsTfTkg4dunJJ
         Xyfg==
X-Gm-Message-State: AOJu0YxZX3nVOp/bcO4Tou7pIXsV52/Uk45bajxjmgClwYHaaJtHS40S
        zK7b1gOoXiRUva/w/Cz9QuUZBqQCEM78TpkUuB3Imw==
X-Google-Smtp-Source: AGHT+IE4eiUmsANlY3d/dxY0iEZjlTkOUetIaZ78hfjOEopvNkHH3FOMB9rHnm6XoBcEp2hdELOl9b26kywoz5Z7rYU=
X-Received: by 2002:a2e:91da:0:b0:2bf:e65d:e815 with SMTP id
 u26-20020a2e91da000000b002bfe65de815mr26608297ljg.38.1697207262865; Fri, 13
 Oct 2023 07:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231012204509.3095010-1-dlechner@baylibre.com> <56e2d1cbe6671bc6709926771602b3aa412c1656.camel@gmail.com>
In-Reply-To: <56e2d1cbe6671bc6709926771602b3aa412c1656.camel@gmail.com>
From:   David Lechner <dlechner@baylibre.com>
Date:   Fri, 13 Oct 2023 09:27:31 -0500
Message-ID: <CAMknhBGdfdm8VpzXs1qh0N8F-CmkZk+1KM5+1WCz1D70Cmm_=A@mail.gmail.com>
Subject: Re: [PATCH] iio: resolver: ad2s1210: add support for adi,fixed-mode
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        nuno.sa@analog.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 2:50=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> Hi David,
>
> Couple of minor things...
>
> On Thu, 2023-10-12 at 15:45 -0500, David Lechner wrote:
> > It is possible to use the AD2S1210 with hardwired mode pins (A0 and A1)=
.
> > According to the devicetree bindings, in this case the adi,fixed-mode
> > property will specify which of the 3 possible modes the mode pins are
> > hardwired for and the gpio-modes property is not allowed.
> >
> > This adds support for the case where the mode pins are hardwired for
> > config mode. In this configuration, the position and velocity must be r=
ead
> > from the config register.
> >
> > The cases of hardwired position or velocity modes is not supported as
> > there would be no way to configure the device.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  drivers/iio/resolver/ad2s1210.c | 193 +++++++++++++++++++++++++++-----
> >  1 file changed, 162 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2=
s1210.c
> > index 1bd1b950e7cc..e6d3f31d529f 100644
> > --- a/drivers/iio/resolver/ad2s1210.c
> > +++ b/drivers/iio/resolver/ad2s1210.c
> > @@ -141,7 +141,7 @@ struct ad2s1210_state {
> >       struct spi_device *sdev;
> >       /** GPIO pin connected to SAMPLE line. */
> >       struct gpio_desc *sample_gpio;
> > -     /** GPIO pins connected to A0 and A1 lines. */
> > +     /** GPIO pins connected to A0 and A1 lines (optional). */
> >       struct gpio_descs *mode_gpios;
> >       /** Used to access config registers. */
> >       struct regmap *regmap;
> > @@ -149,6 +149,8 @@ struct ad2s1210_state {
> >       unsigned long clkin_hz;
> >       /** Available raw hysteresis values based on resolution. */
> >       int hysteresis_available[2];
> > +     /* adi,fixed-mode property - only valid when mode_gpios =3D=3D NU=
LL. */
> > +     enum ad2s1210_mode fixed_mode;
> >       /** The selected resolution */
> >       enum ad2s1210_resolution resolution;
> >       /** Copy of fault register from the previous read. */
> > @@ -175,6 +177,9 @@ static int ad2s1210_set_mode(struct ad2s1210_state =
*st,
> > enum ad2s1210_mode mode)
> >       struct gpio_descs *gpios =3D st->mode_gpios;
> >       DECLARE_BITMAP(bitmap, 2);
> >
> > +     if (!gpios)
> > +             return mode =3D=3D st->fixed_mode ? 0 : -EOPNOTSUPP;
> > +
> >       bitmap[0] =3D mode;
> >
> >       return gpiod_set_array_value(gpios->ndescs, gpios->desc, gpios->i=
nfo,
> > @@ -276,7 +281,8 @@ static int ad2s1210_regmap_reg_read(void *context,
> > unsigned int reg,
> >        * parity error. The fault register is read-only and the D7 bit m=
eans
> >        * something else there.
> >        */
> > -     if (reg !=3D AD2S1210_REG_FAULT && st->rx[1] & AD2S1210_ADDRESS_D=
ATA)
> > +     if ((reg > AD2S1210_REG_VELOCITY_LSB && reg !=3D AD2S1210_REG_FAU=
LT)
> > +          && st->rx[1] & AD2S1210_ADDRESS_DATA)
> >               return -EBADMSG;
> >
> >       *val =3D st->rx[1];
> > @@ -437,6 +443,40 @@ static void ad2s1210_push_events(struct iio_dev
> > *indio_dev,
> >       st->prev_fault_flags =3D flags;
> >  }
> >
> > +/**
> > + * Reads position or velocity from the config registers.
> > + *
> > + * This is used when the mode gpios are not available.
> > + *
> > + * Must be called with the lock held.
> > + *
> > + * @param st The device state.
> > + * @param val Pointer to hold the value read.
> > + * @param msb_reg The register address of the MSB register.
> > + * @param lsb_reg The register address of the LSB register.
> > + * @return 0 on success, negative error code otherwise.
> > + */
> > +static int ad2s1210_read_val_from_config(struct ad2s1210_state *st, __=
be16
> > *val,
> > +                                      u8 msb_reg, u8 lsb_reg)
> > +{
> > +     unsigned int reg_val;
> > +     int ret;
> > +
> > +     ret =3D regmap_read(st->regmap, msb_reg, &reg_val);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ((u8 *)val)[0] =3D reg_val;
> > +
> > +     ret =3D regmap_read(st->regmap, lsb_reg, &reg_val);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ((u8 *)val)[1] =3D reg_val;
>
> These casts are not that nice... Is sparse even ok with this without __fo=
rce?
> I didn't looked at the datasheet so I have no idea but is regmap_bulk_rea=
d() an
> option? It would simplify things.

regmap_bulk_read() does work, thanks for the suggestion.

>
> > +
> > +     return 0;
> > +}
>
> ...
>
> >
> >       ad2s1210_push_events(indio_dev, st->sample.fault, pf->timestamp);
> > @@ -1299,9 +1397,33 @@ static const struct iio_info ad2s1210_info =3D {
> >  static int ad2s1210_setup_properties(struct ad2s1210_state *st)
> >  {
> >       struct device *dev =3D &st->sdev->dev;
> > +     const char *str_val;
> >       u32 val;
> >       int ret;
> >
> > +     ret =3D device_property_read_string(dev, "adi,fixed-mode", &str_v=
al);
> > +     if (ret =3D=3D -EINVAL)
> > +             st->fixed_mode =3D -1;
> > +     else if (ret < 0)
> > +             return dev_err_probe(dev, ret,
> > +                     "failed to read adi,fixed-mode property\n");
> > +     else {
> > +             if (strcmp(str_val, "position") =3D=3D 0)
> > +                     st->fixed_mode =3D MOD_POS;
> > +             else if (strcmp(str_val, "velocity") =3D=3D 0)
> > +                     st->fixed_mode =3D MOD_VEL;
> > +             else if (strcmp(str_val, "config") =3D=3D 0)
> > +                     st->fixed_mode =3D MOD_CONFIG;
> > +             else
> > +                     return dev_err_probe(dev, -EINVAL,
> > +                             "invalid adi,fixed-mode property value:
> > %s\n",
> > +                             str_val);
> > +
> > +             if (st->fixed_mode !=3D MOD_CONFIG)
> > +                     return dev_err_probe(dev, -EINVAL,
> > +                             "only adi,fixed-mode=3D\"config\" is
> > supported\n");
>
> Why not?
>
> if (strcmp(str_val, "config"))
>         return dev_err_probe();
>
> st->fixed_mode =3D MOD_CONFIG;
>
> Am I missing something obvious?

I made different error messages to differentiate between values not
allowed by the device tree vs. not supported by the driver. I don't
have a problem with simplifying it though.

>
> - Nuno S=C3=A1
