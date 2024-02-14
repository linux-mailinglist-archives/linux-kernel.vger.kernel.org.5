Return-Path: <linux-kernel+bounces-65496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CE6854DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93CF1C28147
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E2960256;
	Wed, 14 Feb 2024 16:13:13 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75DC5FF0B;
	Wed, 14 Feb 2024 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927193; cv=none; b=jeWk60HZnB0cTLi4IWF/2VxFYX6gO0uj3z+adoTJ5CZMg3XswmRHY8lSglwZh50XoOELvzPRv9Ruos2RZFpVplnqTTwsSVzU+U67B3Y9kDQOiL4SkGTqti2cXVfZ0TuagFF+MqmWlrl48F1j7/OtCgyakMknhhBGb54NdqRtLio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927193; c=relaxed/simple;
	bh=gKGPpN82UO99dZXmEZzyw8Ch/RLfAFBr6rDbmHC+BAA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGbLdOOFG6NCMxnUZ9+XJ9jCS63s88ZKukY4h6+JgWnzsJ7hkM0ZPR3+JEgrwCY648OhdFq0I6OM9PS8REARGxVphriIlYtZescsKceHvLKgx5O2rzmjAetTk9qd6C5+YQCugPQAb426M2f4XQUdm/U8Ho1WKgW9d2wIl+2HuGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZjng1VVBz6K7rL;
	Thu, 15 Feb 2024 00:09:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 98CB41400CA;
	Thu, 15 Feb 2024 00:13:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 16:13:09 +0000
Date: Wed, 14 Feb 2024 16:13:08 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "Michael
 Hennerich" <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: ad7944: add driver for
 AD7944/AD7985/AD7986
Message-ID: <20240214161308.00003ddb@Huawei.com>
In-Reply-To: <CAMknhBG3J-fW8o6DaAE34GD-_oNk6pnMpV4SnoA26gVmHWJP6g@mail.gmail.com>
References: <20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com>
	<20240206-ad7944-mainline-v1-2-bf115fa9474f@baylibre.com>
	<20240210174729.7c6cb953@jic23-huawei>
	<CAMknhBG3J-fW8o6DaAE34GD-_oNk6pnMpV4SnoA26gVmHWJP6g@mail.gmail.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 11 Feb 2024 11:03:43 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On Sat, Feb 10, 2024 at 11:47=E2=80=AFAM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Tue,  6 Feb 2024 11:26:00 -0600
> > David Lechner <dlechner@baylibre.com> wrote:
> > =20
> > > This adds a driver for the Analog Devices Inc. AD7944, AD7985, and
> > > AD7986 ADCs. These are a family of pin-compatible ADCs that can sample
> > > at rates up to 2.5 MSPS.
> > >
> > > The initial driver adds support for sampling at lower rates using the
> > > usual IIO triggered buffer and can handle all 3 possible reference
> > > voltage configurations.
> > >
> > > Signed-off-by: David Lechner <dlechner@baylibre.com> =20
> >
> >
> > The one thing in here that will probably bite if this gets much use of
> > different boards is the use of non multiple of 8 word sizes.
> >
> > Often we can get away with padding those with trailing clocks.
> > Any idea if that is safe here? =20
>=20
> We can probably get away with it on these chips. The ultimate goal
> here, though, is to get these chips working a max sample rate which
> only has a few 10s of nanoseconds of wiggle room between SPI
> transfers. So I would rather have a bit more play in the timing than
> try to support generic SPI controllers.
>=20
Would just be a case of providing a fallback. If you have a good spi
controller then you get better data rats.

Meh, can be added later when someone needs this. We've done that a few
times before.

Jonathan

