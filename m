Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91977811438
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379313AbjLMOHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441835AbjLMOHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:07:14 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4112127;
        Wed, 13 Dec 2023 06:07:17 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1f5cb80a91so778217266b.3;
        Wed, 13 Dec 2023 06:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702476436; x=1703081236; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8VI8rqDadlSJIJg0W7jh9hEmaJd6O99eGe1ZxKtYcvs=;
        b=Gke7aaWhdbcahaV34MM9L5KiC7nljzvVfO/szQlYeoacdLhzyLbSu8HNg5eTtYyLPt
         DbnD6x6RqHND70zWuso0X/ECjz3v2LKrO8JjhOCzdOB4i9BlAyjd5WpBLJyDBOBOzipE
         tM+FN7vyK3vJk3KgwRzuyRIw/CitYPeDmnkkje76TTvskIBMSZYEN9icEaUOlt002b7W
         FN5JZFstd+6xuODuvytbV6go5sBWfeM/PAMwqI/gUGXKhQnyNKui96b4zZdTA6ransiB
         8kqVvNYdDzxCzODOW+OJW3LtHlfG0VMElsLHOU6NS87tEefuqXb39hmyAxd6NjNHon4R
         xhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702476436; x=1703081236;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8VI8rqDadlSJIJg0W7jh9hEmaJd6O99eGe1ZxKtYcvs=;
        b=CUSMETgiqe61AxrVn/aYSRYG6kbkDAzHwcVaTMyCj5RP+8+g12ZxbmBID44A3D9ysh
         A0TV7br5RxAMrad6A17+nHEoVq5/18dXd/iDaKidwORQ3YUFIbHIxYyzNopl/ctD7OwA
         +v0YBXnjvo/7FlGZWOapTXdIYsbTLbibk5/2EjCG6S42DNaxLZf/IcxGQPgCscrBjZ8X
         Wn1Iq4RJ9knTljbjHL++M9NiIiqTufWXtyfARk5lRaCPEcO9obZIpj0C49QkjwazI47e
         34yZ6zQ9WVC5Q8ahhBiiOqHRWRJ3z8xvt3bvNxezw63V3k5XIRdvVVt54U48+3FN+iaV
         BXsg==
X-Gm-Message-State: AOJu0YzvIhoiDPli4J1Dfrx2nXitGFvFgwUt5nobynjvBMg6A5CSOThD
        o4zKNVn1vHkofE95Cq8ouz3AWTEObWogyaVdN5A=
X-Google-Smtp-Source: AGHT+IETAhNOLgbHv4ukGE5OQKuD9686yq6uxet/Qt7Ply1EBdsan1BcpHeHqLmy6OOb6FUFSss8Ag==
X-Received: by 2002:a17:906:dfeb:b0:a19:a19b:4273 with SMTP id lc11-20020a170906dfeb00b00a19a19b4273mr2688830ejc.222.1702476435557;
        Wed, 13 Dec 2023 06:07:15 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id cu1-20020a170906ba8100b00a1f65433d08sm7795814ejd.172.2023.12.13.06.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:07:15 -0800 (PST)
Message-ID: <f71a36f73fc380ab3ba0590beefc0a7742a790ca.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] iio: adc: ad7380: new driver for AD7380 ADCs
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Stefan Popa <stefan.popa@analog.com>
Date:   Wed, 13 Dec 2023 15:07:14 +0100
In-Reply-To: <CAMknhBE6mPepiE=EYBj0ScU8SHXMhpO+D_kKBKFj6W+go_Jrxg@mail.gmail.com>
References: <20231213-ad7380-mainline-v2-0-cd32150d84a3@baylibre.com>
         <20231213-ad7380-mainline-v2-3-cd32150d84a3@baylibre.com>
         <5f7a1c60ccebe13ba6cdfa5d8f9632bc9b838137.camel@gmail.com>
         <CAMknhBE6mPepiE=EYBj0ScU8SHXMhpO+D_kKBKFj6W+go_Jrxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-12-13 at 14:47 +0100, David Lechner wrote:
> On Wed, Dec 13, 2023 at 1:18=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >=20
> > On Wed, 2023-12-13 at 05:21 -0600, David Lechner wrote:
> > > This adds a new driver for the AD7380 family ADCs.
> > >=20
> > > The driver currently implements basic support for the AD7380, AD7381,
> > > AD7383, and AD7384 2-channel differential ADCs. Support for additiona=
l
> > > single-ended and 4-channel chips that use the same register map as we=
ll
> > > as additional features of the chip will be added in future patches.
> > >=20
> > > Co-developed-by: Stefan Popa <stefan.popa@analog.com>
> > > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > >=20
> > > v2 changes:
> > > - Fixed CONFIG_AD7380 in Makefile
> > > - rx_buf =3D st->scan_data.raw instead of rx_buf =3D &st->scan_data
> > > - Moved iio_push_to_buffers_with_timestamp() outside of if statement
> > > - Removed extra blank lines
> > > - Renamed regulator disable function
> > > - Dropped checking of adi,sdo-mode property (regardless of the actual
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wiring, we can always use =
1-wire mode)
> > > - Added available_scan_masks (we always sample two channels at the sa=
me time
> > > =C2=A0 so we need to let userspace know this)
> > > - Added check for missing driver match data
> > >=20
> > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0 16 ++
> > > =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0 1 +
> > > =C2=A0drivers/iio/adc/ad7380.c | 464 ++++++++++++++++++++++++++++++++=
+++++++++++++++
> > > =C2=A04 files changed, 482 insertions(+)
> > >=20
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index e2a998be5879..5a54620a31b8 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -438,6 +438,7 @@ S:=C2=A0 Supported
> > > =C2=A0W:
> > > https://wiki.analog.com/resources/tools-software/linux-drivers/iio-ad=
c/ad738x
> > > =C2=A0W:=C2=A0=C2=A0=C2=A0=C2=A0 https://ez.analog.com/linux-software=
-drivers
> > > =C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0 Documentation/devicetree/bindings/ii=
o/adc/adi,ad7380.yaml
> > > +F:=C2=A0=C2=A0=C2=A0=C2=A0 drivers/iio/adc/ad7380.c
> > >=20
> > > =C2=A0AD7877 TOUCHSCREEN DRIVER
> > > =C2=A0M:=C2=A0=C2=A0=C2=A0=C2=A0 Michael Hennerich <michael.hennerich=
@analog.com>
> > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > index 35f9867da12c..cbfd626712e3 100644
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -122,6 +122,22 @@ config AD7298
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To compile thi=
s driver as a module, choose M here: the
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 module will be=
 called ad7298.
> > >=20
> > > +config AD7380
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "Analog Devices AD7380=
 ADC driver"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on SPI_MASTER
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select IIO_BUFFER
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select IIO_TRIGGER
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select IIO_TRIGGERED_BUFFER
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD7380 is a family =
of simultaneous sampling ADCs that share the same
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPI register map an=
d have similar pinouts.
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Say yes here to bui=
ld support for Analog Devices AD7380 ADC and
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 similar chips.
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To compile this dri=
ver as a module, choose M here: the module will be
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 called ad7380.
> > > +
> > > =C2=A0config AD7476
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "Analog Devices A=
D7476 1-channel ADCs driver and other similar
> > > devices from AD and TI"
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on SPI
> > > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > > index bee11d442af4..9c921c497655 100644
> > > --- a/drivers/iio/adc/Makefile
> > > +++ b/drivers/iio/adc/Makefile
> > > @@ -16,6 +16,7 @@ obj-$(CONFIG_AD7291) +=3D ad7291.o
> > > =C2=A0obj-$(CONFIG_AD7292) +=3D ad7292.o
> > > =C2=A0obj-$(CONFIG_AD7298) +=3D ad7298.o
> > > =C2=A0obj-$(CONFIG_AD7923) +=3D ad7923.o
> > > +obj-$(CONFIG_AD7380) +=3D ad7380.o
> > > =C2=A0obj-$(CONFIG_AD7476) +=3D ad7476.o
> > > =C2=A0obj-$(CONFIG_AD7606_IFACE_PARALLEL) +=3D ad7606_par.o
> > > =C2=A0obj-$(CONFIG_AD7606_IFACE_SPI) +=3D ad7606_spi.o
> > > diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> > > new file mode 100644
> > > index 000000000000..b8025b636b67
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/ad7380.c
> > > @@ -0,0 +1,464 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Analog Devices AD738x Simultaneous Sampling SAR ADCs
> > > + *
> > > + * Copyright 2017 Analog Devices Inc.
> > > + * Copyright 2023 BayLibre, SAS
> > > + */
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/bitops.h>
> > > +#include <linux/cleanup.h>
> > > +#include <linux/device.h>
> > > +#include <linux/err.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/regulator/consumer.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/spi/spi.h>
> > > +#include <linux/sysfs.h>
> > > +
> > > +#include <linux/iio/buffer.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/sysfs.h>
> > > +#include <linux/iio/trigger_consumer.h>
> > > +#include <linux/iio/triggered_buffer.h>
> > > +
> >=20
> > ...
> >=20
> > >=20
> > > +static int ad7380_probe(struct spi_device *spi)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ad7380_state *st;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev =3D devm_iio_device_a=
lloc(&spi->dev, sizeof(*st));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!indio_dev)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -ENOMEM;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st =3D iio_priv(indio_dev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->spi =3D spi;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->chip_info =3D spi_get_devic=
e_match_data(spi);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!st->chip_info)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return dev_err_probe(&spi->dev, -EINVAL, "missing match
> > > data\n");
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->vref =3D devm_regulator_get=
_optional(&spi->dev, "refio");
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(st->vref)) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * If there is no REFIO supply, then it means that =
we are using
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * the internal 2.5V reference.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (PTR_ERR(st->vref) =3D=3D -ENODEV)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->vref=
 =3D NULL;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 else
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return d=
ev_err_probe(&spi->dev, PTR_ERR(st->vref),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get refio
> > > regulator\n");
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (st->vref) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ret =3D regulator_enable(st->vref);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return r=
et;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ret =3D devm_add_action_or_reset(&spi->dev,
> > > ad7380_regulator_disable,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->vref);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return r=
et;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->regmap =3D devm_regmap_init=
(&spi->dev, NULL, st,
> > > &ad7380_regmap_config);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(st->regmap))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "fail=
ed to allocate register map\n");
> >=20
> > Still not using a regmap_bus... You could at least argue in the last ve=
rsion why
> > you're not doing it rather than ignoring the comment :).
> >=20
> > I'm asking for it because it already happened (in IIO) to me and I was =
asked for
> > implementing the bus. You also gain things like regmap core handling en=
dianism
> > and
> > formatting the work buffer for you (eg: regmap_bulk_read() could be mor=
e
> > efficient),
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->channels =3D st->chi=
p_info->channels;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->num_channels =3D st-=
>chip_info->num_channels;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->dev.parent =3D &spi-=
>dev;
> >=20
> > still not addressed...
> >=20
> > With at least the above (for the regmap_bus I'll leave the ultimate dec=
ision to
> > Jonathan - not a deal breaker for me):
> >=20
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> >=20
> >=20
> > - Nuno S=C3=A1
> >=20
>=20
> Sorry, I did not mean to ignore these. I just did a bad job of
> double-checking that I addressed all comments before sending v2. :-(
>=20

no worries (done that and will do it again) :)

> If we need a v3, I will look into regmap_bus but at leas

Well, at least 'indio_dev->dev.parent =3D &spi->dev;' should be removed. Bu=
t yeah, if
the regmap_bus is not to be required then Jonathan might just do it while a=
pplying.

- Nuno S=C3=A1

