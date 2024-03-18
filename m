Return-Path: <linux-kernel+bounces-106222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D76D87EAF2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0CDC28131A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2114CDEB;
	Mon, 18 Mar 2024 14:29:31 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A432F25740;
	Mon, 18 Mar 2024 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710772171; cv=none; b=KhRKeAMO8iDSSxaeUHggp5OepRrOdv7OaHzHiqokXy/s9rtbyFKpEr960nY4YxvH091mxgmqhfwKVz9SXvFiknjxZvNZ9yprrq6nu2Ew11mpuNqry60sAa4YKYUhihWAbVyrjuBGdr4WGZo1uPamp8LETW8lKIvCwjbfJshb0dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710772171; c=relaxed/simple;
	bh=+GIqwxv5fTwkaqVfplcuJmTziIweZkhHUrQQkNTEUJY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6cMW9uocObeglBQfJ0JRy8XSLPZD7zxNQYwvD9uJNe37c2AebiLm/8IjXf3OQlm06F25ADobanG+6tq7ft6oKBDrOLEtn62SbpwdbnJqjXAVJyT2ePvQyziL2DKlkTOYefRZsacktC0yqv0608lmVzEt3UPsukzwVfd+lcEuo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tyxvp1kf0z6K9Y5;
	Mon, 18 Mar 2024 22:25:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 25C971408FF;
	Mon, 18 Mar 2024 22:29:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Mar
 2024 14:29:24 +0000
Date: Mon, 18 Mar 2024 14:29:23 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
	<jic23@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: ad7944: Add support for "3-wire mode"
Message-ID: <20240318142923.000042f4@Huawei.com>
In-Reply-To: <CAHp75VeQcvuEy4V6-+3PeWTZJ9=Qae0AiiNB93OOw3wuc-uh3A@mail.gmail.com>
References: <20240314-mainline-ad7944-3-wire-mode-v2-1-d469da0705d2@baylibre.com>
	<ZfX5jynjW4M9pvw1@surfacebook.localdomain>
	<20240318124041.0000032d@Huawei.com>
	<CAHp75VeQcvuEy4V6-+3PeWTZJ9=Qae0AiiNB93OOw3wuc-uh3A@mail.gmail.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 18 Mar 2024 15:09:32 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Mar 18, 2024 at 2:41=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > > >  struct ad7944_adc {
> > > >     struct spi_device *spi;
> > > > +   enum ad7944_spi_mode spi_mode;
> > > >     /* Chip-specific timing specifications. */
> > > >     const struct ad7944_timing_spec *timing_spec;
> > > >     /* GPIO connected to CNV pin. */
> > > > @@ -58,6 +75,9 @@ struct ad7944_adc {
> > > >      } sample __aligned(IIO_DMA_MINALIGN);
> > > >  }; =20
> > >
> > > Have you run `pahole` to see if there is a better place for a new mem=
ber? =20
> >
> > I know this matters for structures where we see lots of them, but do we=
 actually
> > care for one offs?  Whilst it doesn't matter here I'd focus much more
> > on readability and like parameter grouping for cases like this than was=
ting
> > a few bytes. =20
>=20
> This is _also_ true, but think more about cache line contamination.
> Even not-so-important bytes may decrease the performance. In some
> cases it's tolerable, in some it is not (high-speed ADC). In general I
> assume that the developer has to understand many aspects of the
> software and cache line contamination may be last but definitely not
> least.
>=20

Not totally sure what you are covering with contamination as many aspects
around caches and that's not really a standard term for any of them (as
far as I know).

It's part of a multi cacheline allocation anyway (because it's tacked on the
end of the iio device struct, so fairly unlikely to share with other alloca=
tions
and definitely not on ARM because of the trailing __aligned(IIO_DMA_MINALIG=
N)
elements.

If it matters more locally, then pahole is more likely to push you to pack
things together in a fashion that makes false sharing and similar perf issu=
es
more likely if you are grouping things for packing purposes rather than
logical groups.

If you just mean cache pressure then fair enough if we squeeze everything i=
nto
one cacheline and that doesn't cause false sharing.
'Maybe' this will fit on x86. On Arm64 it's not going to
make any difference, just moving the padding around a bit within the line.

So I'd argue premature optimization for a small, one off, structure.

Jonathan



