Return-Path: <linux-kernel+bounces-133984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B05A089ABBD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21461C20CF5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC0F3D576;
	Sat,  6 Apr 2024 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwL/r5Bb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31893BBF5;
	Sat,  6 Apr 2024 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712418261; cv=none; b=OP8iGGEdwwrkAK6xmNGl4vUalQeT8thENeDgB13tZU9IzOMKStx19mtk3xLQginyenBr/p1OFvAtEeyTU3YnjhoTTwe9r33+/RdVaeXCXFT49R1D2GxAD+LgSUipYEzx02covP/AroLj6bqqhrsdAQudJ5KBW90Q920QF8uqh+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712418261; c=relaxed/simple;
	bh=cfPeK7Hp3R/3MenKywmHbxce7oG/DzlPi6ojjQ+pcEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOvcSSPKT7QfNjW5gz+jjey39KM1pmL4M8syj/3YNycvoU2v54mxaVKQyiueYEfpG/Imo+HJlZj3gXxkF9MWlMw8T7f0clFOHJy1yaPLaf/0HJ1Cod2f72eAYa8J7i74r/tE8ejnyfU+/Pd7fLN3sCPHcR4Jz5mWIw0aTB86IHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwL/r5Bb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA39C433C7;
	Sat,  6 Apr 2024 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712418261;
	bh=cfPeK7Hp3R/3MenKywmHbxce7oG/DzlPi6ojjQ+pcEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CwL/r5Bb93jve8UcA/FUGBf9XmlwiC1us46J4tJEvRIVT9NNcgaScCTMhCXfjcC20
	 CGrqByZ3V9uLFkFIcwSw1XrPFo54JxHE4dTQ0A4Zch6wasaFXEk0e+iks6ALcUP4wc
	 U7NYNKQVl92wRO8oi9S44fAmS9bvyogfVv03eQSpsjuHMwqoGmeQToE6Z1OJn/WnLc
	 jDSp2d5oSQSNd8UoDnhXC0K+n/FVbvBxesRzNjyUH/DdqEnad82l/F4RTHyGK+Y2R5
	 8pve9eANWz4Kn55Gj4QHpvWWfd5hMKrDdOgkLd7rRwtuVKgrVzHKkpqZxrJSuy3w9O
	 VdwgPFAQfOibA==
Date: Sat, 6 Apr 2024 16:44:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Dumitru Ceclan 
 <mitrutzceclan@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Michael Walle <michael@walle.cc>,
 Andy Shevchenko <andy@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7173: Fix ! vs ~ typo in ad7173_sel_clk()
Message-ID: <20240406164407.48785a0f@jic23-huawei>
In-Reply-To: <8faeeb203456ceb8c07c5f2a46f8a7b367f574e4.camel@gmail.com>
References: <5401c681-c4aa-4fab-8c8c-8f0a379e2687@moroto.mountain>
	<8faeeb203456ceb8c07c5f2a46f8a7b367f574e4.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 04 Apr 2024 11:03:29 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2024-04-04 at 10:31 +0300, Dan Carpenter wrote:
> > This was obviously supposed to be a bitwise negate instead of logical.
> >=20
> > Fixes: 76a1e6a42802 ("iio: adc: ad7173: add AD7173 driver")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
Applied.

Thanks,

> > =C2=A0drivers/iio/adc/ad7173.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> > index 4ff6ce46b02c..b1d6ea17ced3 100644
> > --- a/drivers/iio/adc/ad7173.c
> > +++ b/drivers/iio/adc/ad7173.c
> > @@ -835,7 +835,7 @@ static unsigned long ad7173_sel_clk(struct ad7173_s=
tate
> > *st,
> > =C2=A0{
> > =C2=A0	int ret;
> > =C2=A0
> > -	st->adc_mode &=3D !AD7173_ADC_MODE_CLOCKSEL_MASK;
> > +	st->adc_mode &=3D ~AD7173_ADC_MODE_CLOCKSEL_MASK;
> > =C2=A0	st->adc_mode |=3D FIELD_PREP(AD7173_ADC_MODE_CLOCKSEL_MASK, clk_=
sel);
> > =C2=A0	ret =3D ad_sd_write_reg(&st->sd, AD7173_REG_ADC_MODE, 0x2, st- =
=20
> > >adc_mode); =20
> > =C2=A0 =20
>=20


