Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9CB80F15F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377124AbjLLPmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377023AbjLLPml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:42:41 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69D199
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:42:45 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5c1a75a4b6cso2883282a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702395765; x=1703000565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xe9emU3dTotPzaSKtOD5H/ebowKfPPcIQX4pZTF5JbQ=;
        b=ueuacPFnbVPHUmrOW+3kbrQ33rR1JXaDPptpt3kJD/zifGrnG92OesvLz1TBbe7I8o
         F1bVe4LtveIOXoASCQNWxET4ue/3pDqLMPL8WrHz+8Cpqp7LIOaMI+fEv3OWJYvxYfXX
         22MZ0jZoCvFzoIBenQD7EYSp2+htRYhaAAwbNuaiqa5MluhEq2TazCZB+K2iODdFM07Q
         w+mAWQEIHkZTMW1BqqdgeZUe4fdVxBACEVQCS/0WH4hpj0uVLUQtJrFX6z18qUQ0bSWv
         GwtGcGyOyc1vhFChOi1cN8jh/4l5Jp5Ma7eWJQe9h3T7p2l+IuJnWfg5Cus90JP6taOF
         4rOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702395765; x=1703000565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xe9emU3dTotPzaSKtOD5H/ebowKfPPcIQX4pZTF5JbQ=;
        b=v1ehoHCtakix3dWMcD4+Il32QyEgzkXCc3w0A2iQCbyO2S3BCh9LNYJCjeihyoHK3p
         TKmDvLOE3yOKCUUkGQp3ZmJSNz0NiQLNY8MBwb5Pc5YDBozspxzjC/+xJea0Y6Xqq1ZD
         WA/Tnvfs1OLPL+ny/8jEQ6Sq+ivuSmiBKfmIZxgC8O9jaVfYSEGV3/IMAQ7g2ZG0tiW+
         y5urC2tWusq3R80B1zeWkyaUKMPD680rNxsXRUyKbtCrNlvy0VySA0Ibb/DXRKFulreb
         5viUhwJQ+SbY6ZD4YnQ7/GRnBqwnVOtHYxP7uDDcw9oPLorZlzNxnHtlWFcVi0JGiM8O
         J7QQ==
X-Gm-Message-State: AOJu0Yy9/FcGEWUAkvxl4ekObYGK4STkxMx2AB3CfpwM/XLCKscDaVDR
        gUo0MAjRiH2z202RR2uKhpxYYTZv6KFbwial/fzObw==
X-Google-Smtp-Source: AGHT+IH8rufHFyx49wW6nBzVLxeaYhSVx3TE935gPFlLxV6qan8IjfvE6/olC/E6WAWOcz6u2TsmJTlcP9PVkkX3keI=
X-Received: by 2002:a17:90a:3ec1:b0:280:24c7:509 with SMTP id
 k59-20020a17090a3ec100b0028024c70509mr2759366pjc.46.1702395765304; Tue, 12
 Dec 2023 07:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20231208-ad7380-mainline-v1-0-2b33fe2f44ae@baylibre.com>
 <20231208-ad7380-mainline-v1-2-2b33fe2f44ae@baylibre.com> <c21634252fec82dadd27b1bff69b24d3384acf00.camel@gmail.com>
In-Reply-To: <c21634252fec82dadd27b1bff69b24d3384acf00.camel@gmail.com>
From:   David Lechner <dlechner@baylibre.com>
Date:   Tue, 12 Dec 2023 16:42:33 +0100
Message-ID: <CAMknhBHLAhTtvyPN=J5oYRdsPgX_2a7g9-Q+UB_mAs9=gV=sTg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad7380: new driver for AD7380 ADCs
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Stefan Popa <stefan.popa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 4:16=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> Hi David,
>
> minor stuff from me...
>
> On Fri, 2023-12-08 at 09:51 -0600, David Lechner wrote:
> > This adds a new driver for the AD7380 family ADCs.
> >
> > The driver currently implements basic support for the AD7380, AD7381,
> > AD7383, and AD7384 2-channel differential ADCs. Support for additional
> > single-ended and 4-channel chips that use the same register map as well
> > as additional features of the chip will be added in future patches.
> >
> > Co-developed-by: Stefan Popa <stefan.popa@analog.com>
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  MAINTAINERS              |   1 +
> >  drivers/iio/adc/Kconfig  |  16 ++
> >  drivers/iio/adc/Makefile |   1 +
> >  drivers/iio/adc/ad7380.c | 467
> > +++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 485 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e2a998be5879..5a54620a31b8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -438,6 +438,7 @@ S:        Supported
> >  W:
> > https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/=
ad738x
> >  W:   https://ez.analog.com/linux-software-drivers
> >  F:   Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> > +F:   drivers/iio/adc/ad7380.c
> >
> >  AD7877 TOUCHSCREEN DRIVER
> >  M:   Michael Hennerich <michael.hennerich@analog.com>
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 35f9867da12c..cbfd626712e3 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -122,6 +122,22 @@ config AD7298
> >         To compile this driver as a module, choose M here: the
> >         module will be called ad7298.
> >
> > +config AD7380
> > +     tristate "Analog Devices AD7380 ADC driver"
> > +     depends on SPI_MASTER
> > +     select IIO_BUFFER
> > +     select IIO_TRIGGER
> > +     select IIO_TRIGGERED_BUFFER
> > +     help
> > +       AD7380 is a family of simultaneous sampling ADCs that share the
> > same
> > +       SPI register map and have similar pinouts.
> > +
> > +       Say yes here to build support for Analog Devices AD7380 ADC and
> > +       similar chips.
> > +
> > +       To compile this driver as a module, choose M here: the module w=
ill
> > be
> > +       called ad7380.
> > +
> >  config AD7476
> >       tristate "Analog Devices AD7476 1-channel ADCs driver and other
> > similar devices from AD and TI"
> >       depends on SPI
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index bee11d442af4..e046d8004f41 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -16,6 +16,7 @@ obj-$(CONFIG_AD7291) +=3D ad7291.o
> >  obj-$(CONFIG_AD7292) +=3D ad7292.o
> >  obj-$(CONFIG_AD7298) +=3D ad7298.o
> >  obj-$(CONFIG_AD7923) +=3D ad7923.o
> > +obj-$(CONFIG_AD7476) +=3D ad7380.o
> >  obj-$(CONFIG_AD7476) +=3D ad7476.o
> >  obj-$(CONFIG_AD7606_IFACE_PARALLEL) +=3D ad7606_par.o
> >  obj-$(CONFIG_AD7606_IFACE_SPI) +=3D ad7606_spi.o
> > diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> > new file mode 100644
> > index 000000000000..6a5ec59bd1fd
> > --- /dev/null
> > +++ b/drivers/iio/adc/ad7380.c
> > @@ -0,0 +1,467 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Analog Devices AD738x Simultaneous Sampling SAR ADCs
> > + *
> > + * Copyright 2017 Analog Devices Inc.
> > + * Copyright 2023 BayLibre, SAS
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/slab.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/sysfs.h>
> > +
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +
> >
>
> ...
>
> > +
> > +static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 re=
g,
> > +                                  u32 writeval, u32 *readval)
> > +{
> > +     struct ad7380_state *st =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     ret =3D iio_device_claim_direct_mode(indio_dev);
> > +     if (ret)
> > +             return ret;
> > +
>
> potential controversial take: do we really need locking in here? regmap a=
lready
> has it's own lock (I think you're not disabling it) and if someone plays =
with
> registers it shouldn't while buffering, well... This is a debug interface=
 so I
> would probably not worry much. One could anyways for write stuff by going
> directly to regmap :)
>
> That said, fine to be as-is from my side (just wanted to take it out of m=
y
> system :))...

I put it in because we often run `iio_info` which reads register 0 via
debugfs. So even though we "shouldn't" be using debug while buffer is
enabled, it is easy to do unintentionally. (This was particularly
problem while working on offload support.)

>
> > +     if (readval)
> > +             ret =3D regmap_read(st->regmap, reg, readval);
> > +     else
> > +             ret =3D regmap_write(st->regmap, reg, writeval);
> > +
> > +     iio_device_release_direct_mode(indio_dev);
> > +
> > +     return ret;
> > +}
> > +
> > +static irqreturn_t ad7380_trigger_handler(int irq, void *p)
> > +{
> > +     struct iio_poll_func *pf =3D p;
> > +     struct iio_dev *indio_dev =3D pf->indio_dev;
> > +     struct ad7380_state *st =3D iio_priv(indio_dev);
> > +     struct spi_transfer xfer =3D {
> > +             .bits_per_word =3D st->chip_info-
> > >channels[0].scan_type.realbits,
> > +             .len =3D 4,
> > +             .rx_buf =3D &st->scan_data,
> > +     };
> > +     int ret;
> > +
> > +     ret =3D spi_sync_transfer(st->spi, &xfer, 1);
> > +
> > +     if (ret =3D=3D 0)
> > +             iio_push_to_buffers_with_timestamp(indio_dev, &st->scan_d=
ata,
> > +                                                pf->timestamp);
> > +
> > +     iio_trigger_notify_done(indio_dev->trig);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int ad7380_read_direct(struct ad7380_state *st,
> > +                           struct iio_chan_spec const *chan, int *val)
> > +{
> > +     struct spi_transfer xfers[] =3D {
> > +             /* toggle CS (no data xfer) to trigger a conversion */
> > +             {
> > +                     .speed_hz =3D AD7380_REG_WR_SPEED_HZ,
> > +                     .bits_per_word =3D chan->scan_type.realbits,
> > +                     .delay =3D {
> > +                             .value =3D 190, /* t[CONVERT] */
> > +                             .unit =3D SPI_DELAY_UNIT_NSECS,
> > +                     },
> > +                     .cs_change =3D 1,
> > +                     .cs_change_delay =3D {
> > +                             .value =3D 10, /* t[CSH] */
> > +                             .unit =3D SPI_DELAY_UNIT_NSECS,
> > +                     },
> > +             },
> > +             /* then read both channels */
> > +             {
> > +                     .speed_hz =3D AD7380_REG_WR_SPEED_HZ,
> > +                     .bits_per_word =3D chan->scan_type.realbits,
> > +                     .rx_buf =3D &st->rx[0],
> > +                     .len =3D 4,
> > +             },
> > +     };
> > +     int ret;
> > +
> > +     ret =3D spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> > +
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     *val =3D sign_extend32(st->rx[chan->scan_index],
> > +                          chan->scan_type.realbits - 1);
> > +
> > +     return IIO_VAL_INT;
> > +}
> > +
> > +static int ad7380_read_raw(struct iio_dev *indio_dev,
> > +                        struct iio_chan_spec const *chan,
> > +                        int *val, int *val2, long info)
> > +{
> > +     struct ad7380_state *st =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     switch (info) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             ret =3D iio_device_claim_direct_mode(indio_dev);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D ad7380_read_direct(st, chan, val);
> > +             iio_device_release_direct_mode(indio_dev);
> > +
> > +             return ret;
> > +     case IIO_CHAN_INFO_SCALE:
> > +             if (st->vref) {
> > +                     ret =3D regulator_get_voltage(st->vref);
>
> nit: I wonder how likely it is for vref to change at runtime...
>
> > +                     if (ret < 0)
> > +                             return ret;
> > +
> > +                     *val =3D ret / 1000;
> > +             } else {
> > +                     *val =3D AD7380_INTERNAL_REF_MV;
> > +             }
> > +
> > +             *val2 =3D chan->scan_type.realbits;
> > +
> > +             return IIO_VAL_FRACTIONAL_LOG2;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static const struct iio_info ad7380_info =3D {
> > +     .read_raw =3D &ad7380_read_raw,
> > +     .debugfs_reg_access =3D &ad7380_debugfs_reg_access,
> > +};
> > +
> > +static int ad7380_init(struct ad7380_state *st)
> > +{
> > +     int ret;
> > +
> > +     /* perform hard reset */
> > +     ret =3D regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
> > +                              AD7380_CONFIG2_RESET,
> > +                              FIELD_PREP(AD7380_CONFIG2_RESET,
> > +                                         AD7380_CONFIG2_RESET_HARD));
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +
> > +     /* select internal or external reference voltage */
> > +     ret =3D regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
> > +                              AD7380_CONFIG1_REFSEL,
> > +                              FIELD_PREP(AD7380_CONFIG1_REFSEL, !!st-
> > >vref));
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* SPI 1-wire mode */
> > +     return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
> > +                               AD7380_CONFIG2_SDO,
> > +                               FIELD_PREP(AD7380_CONFIG2_SDO, 1));
> > +}
> > +
> > +static void ad7380_release_regulator(void *p)
> > +{
> > +     struct regulator *reg =3D p;
> > +
> > +     regulator_disable(reg);
> > +}
> > +
> > +static int ad7380_probe(struct spi_device *spi)
> > +{
> > +     struct iio_dev *indio_dev;
> > +     struct ad7380_state *st;
> > +     const char *str_val;
> > +     int ret;
> > +
> > +     ret =3D device_property_read_string(&spi->dev, "adi,sdo-mode",
> > &str_val);
> > +     if (ret < 0)
> > +             return dev_err_probe(&spi->dev, ret,
> > +                                  "Failed to read adi,sdo-mode
> > property\n");
> > +
> > +     if (strcmp(str_val, "1-wire"))
> > +             return dev_err_probe(&spi->dev, -EINVAL,
> > +                                  "Only 1-wire SDO is supported\n");
> > +
> > +     indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     st =3D iio_priv(indio_dev);
> > +     st->spi =3D spi;
> > +     st->chip_info =3D spi_get_device_match_data(spi);
> > +
>
> if (!st->chip_info) ?

It looks like quite a few drivers don't check this, but I guess safer
to check anyway.


>
> > +     st->vref =3D devm_regulator_get_optional(&spi->dev, "refio");
> > +     if (IS_ERR(st->vref)) {
> > +             /*
> > +              * If there is no REFIO supply, then it means that we are
> > using
> > +              * the internal 2.5V reference.
> > +              */
> > +             if (PTR_ERR(st->vref) =3D=3D -ENODEV)
> > +                     st->vref =3D NULL;
> > +             else
> > +                     return dev_err_probe(&spi->dev, PTR_ERR(st->vref)=
,
> > +                                          "Failed to get refio
> > regulator\n");
> > +     }
> > +
> > +     if (st->vref) {
> > +             ret =3D regulator_enable(st->vref);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D devm_add_action_or_reset(&spi->dev,
> > ad7380_release_regulator,
> > +                                            st->vref);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     st->regmap =3D devm_regmap_init(&spi->dev, NULL, st,
> > &ad7380_regmap_config);
> > +     if (IS_ERR(st->regmap))
> > +             return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
> > +                                  "failed to allocate register map\n")=
;
> > +
>
> Could we instead have a custom regmap_bus instead of bypass regmap with
> reg_read() and reg_write()?
> > +
> > +     indio_dev->channels =3D st->chip_info->channels;
> > +     indio_dev->num_channels =3D st->chip_info->num_channels;
> > +     indio_dev->dev.parent =3D &spi->dev;
>
> no need to assign parent (the core does it for you)...
>
> - Nuno S=C3=A1
>
