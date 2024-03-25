Return-Path: <linux-kernel+bounces-117287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB67388A9A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EDAD28AB62
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2721013D88E;
	Mon, 25 Mar 2024 14:49:05 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1224113CC56;
	Mon, 25 Mar 2024 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378144; cv=none; b=MJEpVelmxaUPz6Mj7pwPDixvQEDqG/0QvGE5l2E9I/Gk6BowJCNrdz9Gqt5u9+wbCBfhcI7xHQ/IQuZR7e2j6a8NEETKhq0NejLyjCmaW79Fr/XfIEajbMR1VKXDSrznBc1x15TbowuogvIJ+6cb+grQgl5r+Pro6eQR3mfvxIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378144; c=relaxed/simple;
	bh=IuU2/7ewmGvoGLx3m/MQEnHlk5Ob0Q4OW6aJ2yIFh0A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6vDj6POIfsak6lRRimul1mJ66kLpfOETsdgXkhQ29orD6MaWNe+6OzIIsd6aewTxOum4DP+1ydt4r3W4S9gLkhiXOIn0VhQ3AFqfeVMcJPvW802+j1sqTCr5yFIE0r4zTZY58nb7U46WpfkM+84Qf1RXBTk9ntxsMEbQnAat54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V3G565Bc4z6K6Xy;
	Mon, 25 Mar 2024 22:48:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 574001400D5;
	Mon, 25 Mar 2024 22:48:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 25 Mar
 2024 14:48:57 +0000
Date: Mon, 25 Mar 2024 14:48:57 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <lars@metafoo.de>,
	<Michael.Hennerich@analog.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eraretuya@gmail.com>
Subject: Re: [PATCH v3 4/6] iio: accel: adxl345: Remove single info
 instances
Message-ID: <20240325144857.000017fb@Huawei.com>
In-Reply-To: <CAFXKEHZWArvErzeoaO+jMrrA7AuQ4izJioNW_wWTza-bLXV22A@mail.gmail.com>
References: <20240323122030.21800-1-l.rubusch@gmail.com>
	<20240323122030.21800-5-l.rubusch@gmail.com>
	<20240324133536.01067770@jic23-huawei>
	<CAFXKEHZWArvErzeoaO+jMrrA7AuQ4izJioNW_wWTza-bLXV22A@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 24 Mar 2024 20:06:51 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Sun, Mar 24, 2024 at 2:35=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Sat, 23 Mar 2024 12:20:28 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Add a common array adxl3x5_chip_info and an enum for
> > > indexing. This allows to remove local redundantly
> > > initialized code in the bus specific modules.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > ---
> > >  drivers/iio/accel/adxl345.h      |  7 +++++++
> > >  drivers/iio/accel/adxl345_core.c | 12 ++++++++++++
> > >  drivers/iio/accel/adxl345_i2c.c  | 20 +++++---------------
> > >  drivers/iio/accel/adxl345_spi.c  | 20 +++++---------------
> > >  4 files changed, 29 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> > > index 6b84a2cee..de6b1767d 100644
> > > --- a/drivers/iio/accel/adxl345.h
> > > +++ b/drivers/iio/accel/adxl345.h
> > > @@ -26,11 +26,18 @@
> > >   */
> > >  #define ADXL375_USCALE       480000
> > >
> > > +enum adxl345_device_type {
> > > +     ADXL345,
> > > +     ADXL375,
> > > +};
> > > +
> > >  struct adxl345_chip_info {
> > >       const char *name;
> > >       int uscale;
> > >  };
> > >
> > > +extern const struct adxl345_chip_info adxl3x5_chip_info[];
> > > +
> > >  int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> > >                      int (*setup)(struct device*, struct regmap*));
> > >
> > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adx=
l345_core.c
> > > index 33424edca..e3718d0dd 100644
> > > --- a/drivers/iio/accel/adxl345_core.c
> > > +++ b/drivers/iio/accel/adxl345_core.c
> > > @@ -62,6 +62,18 @@ struct adxl345_data {
> > >               BIT(IIO_CHAN_INFO_SAMP_FREQ),                          =
 \
> > >  }
> > >
> > > +const struct adxl345_chip_info adxl3x5_chip_info[] =3D {
> > > +     [ADXL345] =3D {
> > > +             .name =3D "adxl345",
> > > +             .uscale =3D ADXL345_USCALE,
> > > +     },
> > > +     [ADXL375] =3D {
> > > +             .name =3D "adxl375",
> > > +             .uscale =3D ADXL375_USCALE,
> > > +     },
> > > +};
> > > +EXPORT_SYMBOL_NS_GPL(adxl3x5_chip_info, IIO_ADXL345); =20
> >
> > There is little advantage here form using an array.  I'd just have
> > two exported structures.   Then the name alone is enough in the
> > id tables.  And probably no need for the enum definition.
> >
> > This use of arrays is an old pattern that makes little sense if the
> > IDs have no actual meaning and you aren't supporting lots of different
> > parts.  For 2 parts I'd argue definitely not worth it.
> > =20
>=20
> Agree. I see your point. I drop the info array enum patch.
>=20
> (...)
>=20
> Btw. may I ask another question: The adxl345/75 driver is doing the
> configuration
> inside the probe(). Other Analog drivers moved that out into a
> xxx_setup() and call
> this function in the probe(). In general, is it better to keep all
> inside  the probe() or
> separate? I mean, the probe is still quite short, and reading through
> severl call
> hierarchies feels a bit "sparghetti". On the other side I can see a
> certain idea of
> separation of functionality: dedicated chip configuration. Would you
> mind to give
> me a small statement/opinion on this please?

I'd based it on code complexity.
If it's one call (and error handling) to do it then inline makes sense.

If it's  lots of lines, a separate function make sense.

Where the boundary between the two lies is subjective so I tend to
just go with whatever an author prefers.  Note that I'm not keen
to see the noise of refactors if the code lies in this gray area?

Jonathan


>=20


