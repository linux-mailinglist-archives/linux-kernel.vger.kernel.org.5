Return-Path: <linux-kernel+bounces-161505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2A68B4CE2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3087B20D68
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8F071B48;
	Sun, 28 Apr 2024 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhKgVz/U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D914D10F1;
	Sun, 28 Apr 2024 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714322904; cv=none; b=ql4GeSjnkqNv3cT32WBx1iAzYVVXtbfhsiF7NOnYflTIbQkHA9YfBQwceZ8BB6RChUIvUU3ZMOz9+FM0rjtriPLO6C5RJNnYNGBckJySNTVb6dWKQSOi/E0LLnTuyBA/FVHwf5WIxlXaA8gozAEZ2eqj6XLkcDBYVtU6FoSHHqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714322904; c=relaxed/simple;
	bh=vjrv+tAkFZGoJUrrfpa1wEGP6TnRwKqI9YwAXU/aiEM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i42NvYkLm4kI1mD+RRwov4LudqnAYGF25ZTsxS+sLqa3seillyl6oXnCw5ng/78jqKIQTXLKolgyNHVK2+uRqEUBNKdkbEJtsGefHwKKoLpFrys77Uo/r+BqzL5jPUx8JMAsnG+rpfMr7JHC+1Jm3uIwDLtKl2kkCDDwfUSO0Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhKgVz/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADFEC113CC;
	Sun, 28 Apr 2024 16:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714322904;
	bh=vjrv+tAkFZGoJUrrfpa1wEGP6TnRwKqI9YwAXU/aiEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mhKgVz/UDd1zYcdZT6Nh99drtuVXhfTTKe7N4DikRul3MZ7IB7wRNln+ykGIuLWHb
	 N5iyGKBEd3aA9iq/6kHKWNffjWMe5bQ0gTRN0C2azbXkWVgLZHd0aorswx7e12pDi6
	 Qdy/8PmfwMZdkKWpcWqdjraFgSB/CQJQpNp0/BXssWA/CNlhycXwMSJoTKf/tyQ9BF
	 7Z+F56YnPH+q+wNddaRJHEU7u4e5IyWfC63x4ik5EBBVCDogOXaIBhQYmVa4h1NWaL
	 uiVh11VSR1mxQfszccsI/Xvd3zs2I6gp0TWHYMOyEo/UpS+iYGSvIyRqU4qYPVeKyT
	 5wWiXVsxLepCg==
Date: Sun, 28 Apr 2024 17:48:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?T25kxZllag==?= Jirman <megi@xff.cz>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Aren Moynihan
 <aren@peacevolution.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, Willow
 Barraco <contact@willowbarraco.fr>
Subject: Re: [PATCH v2 2/6] iio: light: stk3310: Implement vdd supply and
 power it off during suspend
Message-ID: <20240428174807.2051e3cd@jic23-huawei>
In-Reply-To: <yl4b23gclij2jqyxlqkmfmct4vlz6gotwfgbpkisgz2fuuh7uv@rbynxmitzjog>
References: <20240423223309.1468198-2-aren@peacevolution.org>
	<20240423223309.1468198-4-aren@peacevolution.org>
	<CAHp75VeRDSPvpmSbUyZPp0RMoTOE193U2ma18qxv_qZQKLCq8g@mail.gmail.com>
	<5qqil7ltqhdeabml6toqpcy773uhjxgwaz3txpy4kv4sz55o2y@hmar674eey7s>
	<CAHp75VdR9HtWbSif+j8QHX5zG9xPF1GzUFY2s-0OjD3RAWD9-Q@mail.gmail.com>
	<xxbwdl6ebvut3u7qhzfy65e4eheixghqe7yn4qemyuowxyxj5a@r2wa2b7bhw2x>
	<CAHp75VejwJ7h5jaNL+VL7FE4UMbTEP3QA1E=_y-1PSrz99zBKQ@mail.gmail.com>
	<yl4b23gclij2jqyxlqkmfmct4vlz6gotwfgbpkisgz2fuuh7uv@rbynxmitzjog>
Followup-To: linux-iio@vger.kernel.org,phone-devel@vger.kernel.org
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Apr 2024 22:00:46 +0200
Ond=C5=99ej Jirman <megi@xff.cz> wrote:

> On Wed, Apr 24, 2024 at 08:31:27PM GMT, Andy Shevchenko wrote:
> > On Wed, Apr 24, 2024 at 7:14=E2=80=AFPM Ond=C5=99ej Jirman <megi@xff.cz=
> wrote: =20
> > > On Wed, Apr 24, 2024 at 06:20:41PM GMT, Andy Shevchenko wrote: =20
> > > > On Wed, Apr 24, 2024 at 3:59=E2=80=AFPM Ond=C5=99ej Jirman <megi@xf=
f.cz> wrote: =20
> > > > > On Wed, Apr 24, 2024 at 02:16:06AM GMT, Andy Shevchenko wrote: =20
> > > > > > On Wed, Apr 24, 2024 at 1:41=E2=80=AFAM Aren Moynihan <aren@pea=
cevolution.org> wrote: =20
> >=20
> > ...
> >  =20
> > > > > > >         ret =3D stk3310_init(indio_dev);
> > > > > > >         if (ret < 0)
> > > > > > > -               return ret;
> > > > > > > +               goto err_vdd_disable; =20
> > > > > >
> > > > > > This is wrong. You will have the regulator being disabled _befo=
re_
> > > > > > IRQ. Note, that the original code likely has a bug which sets s=
tates
> > > > > > before disabling IRQ and removing a handler. =20
> > > > >
> > > > > How so? stk3310_init is called before enabling the interrupt. =20
> > > >
> > > > Exactly, IRQ is registered with devm and hence the error path and
> > > > remove stages will got it in a wrong order. =20
> > >
> > > Makes no sense. =20
> >=20
> > Huh?!
> >  =20
> > > IRQ is not enabled here, yet. So in error path, the code will
> > > just disable the regulator and devm will unref it later on. IRQ doesn=
't enter
> > > the picture here at all in the error path. =20
> >=20
> > Error path _after_ IRQ handler has been _successfully_ installed.
> > And complete ->remove() stage. =20
>=20
> Allright. So fixing the other issue I mentioned will fix this one too, be=
cause
> there will be no error path after IRQ enable, then.

Don't do reorder stuff past iio_device_register.
It generates a bunch of it's own issues wrt to functionality.
The iio_device_register() call is the last one because the device must be i=
n a
state to correctly deal with all userspace actions by the time they are made
available.

Harden the driver to not call IIO core functions for false events if that
is easy to do, but there shouldn't be an issue if you do (if there is we sh=
ould
address that in the IIO core).

Jonathan



>=20
> kind regards,
> 	o.
>=20
> > > > > Original code has a bug that IRQ is enabled before registering the
> > > > > IIO device, =20
> > > >
> > > > Indeed, but this is another bug.
> > > > =20
> > > > > so if IRQ is triggered before registration, iio_push_event
> > > > > from IRQ handler may be called on a not yet registered IIO device.
> > > > >
> > > > > Never saw it happen, though. :) =20
> > > >
> > > > Because nobody cares enough to enable DEBUG_SHIRQ. =20
> > >
> > > Nice debug tool. I bet it makes quite a mess when enabled. :) =20
> >=20
> > FWIW, I have had it enabled for ages, but I have only a few devices,
> > so I fixed a few cases in the past WRT shared IRQ issues.
> >=20
> > --=20
> > With Best Regards,
> > Andy Shevchenko =20


