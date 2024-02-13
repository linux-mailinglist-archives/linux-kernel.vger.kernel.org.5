Return-Path: <linux-kernel+bounces-63855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F67E85358F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1824B216FB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB52B5F56A;
	Tue, 13 Feb 2024 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LB0hW0F+"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847D5EE87;
	Tue, 13 Feb 2024 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840305; cv=none; b=ReeA1d9UOv9E6Koq8RdwkthL5h24qMNzqIp7YIbasdfdS+LPFIB9ut5ZNAB68djuGVoItK8RuR7KrrYSNHu2aGpFAt9tIR7x4BdHYBJo6kw9Vsie8gX/54qM7XcUBtdilWk61ZKNHkjXsBEznP5ArsRt3NxJb09mWzy871wkRBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840305; c=relaxed/simple;
	bh=rM3rrsxmVIGD8Xdy2RSGGo3eRi8719tCkmvzDLLsESI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W2XWnha/8IAcS7cTni5vVofOWtAS3Nak9zDrJTh8lw6XNDWruylMLFtJSI3VMUqKMX4gJzQhUMr/AKhU1eDqsSSjasDF5vLTidmz0CxvxWO8TXMlbEL6MnFV5bRk8NGI0uWA/0+yp3Ejl5fbe5C2x7F9ahhJAhCVZIgqMSF0WNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LB0hW0F+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3cb228b90bso228537666b.3;
        Tue, 13 Feb 2024 08:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707840301; x=1708445101; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rM3rrsxmVIGD8Xdy2RSGGo3eRi8719tCkmvzDLLsESI=;
        b=LB0hW0F+OUgI0/Gf09U3uTDEdYMPMKeLV2+q9Wd7i1YE6wMqk8aoVuuY51wWU5Ag2e
         Q60o0nn2ZtjuJ1m04Gped8KYpouB80LWrBKX8A82XbMY1fVmpJw7tZHSLoT3AnLBaMsQ
         7k767bYn5N4MtxrGim13m/bPeRX+Rzh3DCep8dBE4haYS4+b9Xx4kPI84s6mm+Q8SHYD
         k0iA8NhNSapo5XlMC1W8ny5xejrrNPd2Zv68LP4qW5KJ2HgUWmcYprApT0SDwsIQn4c6
         dlGCmju52SLJa8McINWRqaEEbLX5FNuH8Cj8QUcfncVDpoxFgPMg16cb6KgT7S9h5KoL
         Vbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707840301; x=1708445101;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rM3rrsxmVIGD8Xdy2RSGGo3eRi8719tCkmvzDLLsESI=;
        b=ULNXLOTdmgpeeGS7P37xpxEzDrhgPeFpZvTn210OIXlVd9dCVjM0hoyLD5ZJu69Y+G
         m38V9tt5MokL1AXWeRX7E8wRleulXU3IUrnxuoGwxa5BbO5mij9acXcnOVi0Wx7itgvO
         8Fo8vz/qIPDusNiWAutRHKdcldiIwiDr6WZ5dAMRdiMphenenUq0krZ4P27eH7WBN8L3
         WnVLNCK/jM12W6aptJl9i0Agc6AdIp1QBf6CRtLC0ZmpOun7aqjQ1lxgDjxIwHcSg2TW
         JvLH5ZOu3e9a81TXAkgKhqaYRVEPksbdgnLS7ueRArvDvFr/BopKFjh7rGAUFBOQj5cc
         u3SA==
X-Forwarded-Encrypted: i=1; AJvYcCV6ayfa7sATYkj7JGnDbds5oJXi/37To3lvOFKSN5+JRTrM1EHs8x/TVbdqfaTEHTm3NBOnKfMkPbp89/h6xTrMuzfcZNaHA1C1b/NeFq3e49jZaco0fwsQKmbWgaUMo9uYNmyg2jF3umG0k3zeFisle3StwOyyTPVrP8ep/eNz2Np7
X-Gm-Message-State: AOJu0Yw93S1Y+Z03A/j7b9aj48WEOSA2fPIg3xmTzIo/a1Gcdqmukr7I
	eC1pzL8UgiuAucrHIJfxhpx4IPraaM2Xz3I/WpNGMulp9SvaqCIz
X-Google-Smtp-Source: AGHT+IF0X1AhH4lpy6+KVf4MfxbDEkJ0MKQzmIDYPCoJ0rkSRG8av0+qslITqO7b5iBHSxehOS9+Lg==
X-Received: by 2002:a17:906:80b:b0:a3c:771:a97a with SMTP id e11-20020a170906080b00b00a3c0771a97amr7821530ejd.73.1707840301135;
        Tue, 13 Feb 2024 08:05:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtLWfPHGLeQOMOCOpurgmOWvVQm0yGHwp2Gp+OpYptWmZush47c4TmCLi5f3fjS7IMNTsyCLXIyD0n9yv8oaWKCMUgXq6MC5CFdl1gPwHyZl7hzAuQG+zUKzQ+yq0jaT4a/012vwpBVcQZq8Z3zGDax35nhIXppxJQv9ed19HY1EdiTr1k0GQCOpxvsAqf1rSoffKNhTXO3VD5NnqAb3ebLPR55bOoYDICJwPMhap9drcriuLaRbX3VqYyZmVIIfLJHX3gmYAmhRWo5pDx5OU7GjCWlAF1+cpgW4Ae25p1arZ7fvXBmr2KFAyp4x+QZkfcxbFWGp8UdM3FexW4FQrhak67rFjsOlfXgJRcXydt6S4b9+0frLP4FptO2Kt40lsHcnnZhVq65PgPmyd+Lsjr6xLkmMZFux5ZH6I53JF0c8fm16Px/d/j9OUDoAqfkWhUrwREwWBEl44ZK+fi+OOKR6PRKs1Z1Dr1WfwZGwRXS8mRWN5LNcvv2QoCTn/galthSzaHJzSkvf0g32eKFSHaz/Ro4wI=
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id ps8-20020a170906bf4800b00a3ca744438csm1407182ejb.213.2024.02.13.08.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 08:05:00 -0800 (PST)
Message-ID: <e03968102b92b3711808eb532685bc9e05fc3c8d.camel@gmail.com>
Subject: Re: [PATCH 5/5] iio: adc: ad7380: use spi_optimize_message()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Martin Sperl <kernel@martin.sperl.org>,
  David Jander <david@protonic.nl>, Jonathan Cameron <jic23@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,  Alain Volmat
 <alain.volmat@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-spi@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Date: Tue, 13 Feb 2024 17:08:19 +0100
In-Reply-To: <CAMknhBEU=iMzpE_P0KePL4cZZktBOGHRXaEox5a7XcVjXDT+Dg@mail.gmail.com>
References: 
	<20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
	 <20240212-mainline-spi-precook-message-v1-5-a2373cd72d36@baylibre.com>
	 <c06dfa1ecf88b07ef467ad7c08667d0cab400613.camel@gmail.com>
	 <CAMknhBEU=iMzpE_P0KePL4cZZktBOGHRXaEox5a7XcVjXDT+Dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-13 at 09:27 -0600, David Lechner wrote:
> On Tue, Feb 13, 2024 at 3:47=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >=20
> > On Mon, 2024-02-12 at 17:26 -0600, David Lechner wrote:
> > > This modifies the ad7380 ADC driver to use spi_optimize_message() to
> > > optimize the SPI message for the buffered read operation. Since buffe=
red
> > > reads reuse the same SPI message for each read, this can improve
> > > performance by reducing the overhead of setting up some parts the SPI
> > > message in each spi_sync() call.
> > >=20
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > > =C2=A0drivers/iio/adc/ad7380.c | 52 +++++++++++++++++++++++++++++++++=
++++++++--
> > > ----
> > > -
> > > =C2=A01 file changed, 45 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> > > index abd746aef868..5c5d2642a474 100644
> > > --- a/drivers/iio/adc/ad7380.c
> > > +++ b/drivers/iio/adc/ad7380.c
> > > @@ -133,6 +133,7 @@ struct ad7380_state {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_device *spi;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct regulator *vref;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct regmap *regmap;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_message *msg;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * DMA (thus cache coherency main=
tenance) requires the
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * transfer buffers to live in th=
eir own cache lines.
> > > @@ -231,19 +232,55 @@ static int ad7380_debugfs_reg_access(struct iio=
_dev
> > > *indio_dev, u32 reg,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > =C2=A0}
> > >=20
> > > +static int ad7380_buffer_preenable(struct iio_dev *indio_dev)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct ad7380_state *st =3D iio_priv(indio_=
dev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_transfer *xfer;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 st->msg =3D spi_message_alloc(1, GFP_KERNEL=
);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!st->msg)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -ENOMEM;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 xfer =3D list_first_entry(&st->msg->transfe=
rs, struct spi_transfer,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 transfer_list);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 xfer->bits_per_word =3D st->chip_info->chan=
nels[0].scan_type.realbits;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 xfer->len =3D 4;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 xfer->rx_buf =3D st->scan_data.raw;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D spi_optimize_message(st->spi, st->m=
sg);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 spi_message_free(st->msg);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ret;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > +}
> > > +
> > > +static int ad7380_buffer_postdisable(struct iio_dev *indio_dev)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct ad7380_state *st =3D iio_priv(indio_=
dev);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 spi_unoptimize_message(st->msg);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 spi_message_free(st->msg);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > +}
> > > +
> >=20
> > Not such a big deal but unless I'm missing something we could have the
> > spi_message (+ the transfer) statically allocated in struct ad7380_stat=
e and
> > do
> > the optimize only once at probe (naturally with proper devm action for
> > unoptimize). Then we would not need to this for every buffer enable +
> > disable. I
> > know in terms of performance it won't matter but it would be less code =
I
> > guess.
> >=20
> > Am I missing something?
>=20
> No, your understanding is correct for the current state of everything
> in this series. So, we could do as you suggest, but I have a feeling
> that future additions to this driver might require that it gets
> changed back this way eventually.

Hmm, not really sure about that as chip_info stuff is always our friend :).=
 And
I'm anyways of the opinion of keeping things simpler and start to evolve wh=
en
really needed (because often we never really need to evolve). But bah, as I
said... this is really not a big deal.

- Nuno S=C3=A1

