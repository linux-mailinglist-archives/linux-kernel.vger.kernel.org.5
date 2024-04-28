Return-Path: <linux-kernel+bounces-161504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCE18B4CE0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42C19B21424
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2615A71B4C;
	Sun, 28 Apr 2024 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lX/FJlg4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9E410F1;
	Sun, 28 Apr 2024 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714322725; cv=none; b=Cqo4Hh+UBJSWmlLnVSkaKRt+gsMKm64O+5jB+QQwsQQuYTjIEqm5sCrjXlEvnPRIkqPlg9Cqq4rrmWRWcR/Y/sImLRwQZZ7qFudwal8SX5Ogoj7oiKeMIBlxaS8fAulNSBo8EPlRaxvfBhF3rYE9O7QG+ml11g0wAiSPMr+QUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714322725; c=relaxed/simple;
	bh=5kYP3pmRZkJtkUEFsEYFM/NTR8a+xkpPppKIoM24f7M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HfztS3GdYLvuNHoHnEw1ka9XA+abUWllWNc8spzYdTbW6A7qGqiOrTwRRAy3t3vJGJZ4Ji8tHjKWB6VWtAOq5ZKRElXIFJYa4XPBkmKYkvMZcvgBZNo6l0nNUjpJuQWOCeGigzb+Ra6zMTeISHSCY+Yo4DrOsOtm1BecVtWGIdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lX/FJlg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4545FC113CC;
	Sun, 28 Apr 2024 16:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714322724;
	bh=5kYP3pmRZkJtkUEFsEYFM/NTR8a+xkpPppKIoM24f7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lX/FJlg4IpPctey9rwJ5G71OlFBAyAGflEF2JWbzPkYVdFa2eAGLCUuxXDzuyC51U
	 EQG48mWWgUpvPUUcNKuKLcrZZNNvkWmZ+4Qhcmtwsgm1dP3AUioxs/vXmCq8CILtD4
	 69ih+C2EZ9BiIeVUbXKJWsmqz6mKaz1TjpCAI745GXZXz0KJBOZQlQFx4eMd7/xxrM
	 tqkO9mx4TM8zJd75bOeoyxxrnTvUQow7vtK1CoSp0Sspl10td6BINSsZ6Z3S5W58kY
	 exKRWup/Hg1PG4eqJ3XMLi82kg53EptCw/8Ey6s8RoZn/YA3KHxBGMsPwkWuhM8waE
	 IXREY/XBX+adg==
Date: Sun, 28 Apr 2024 17:45:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?UTF-8?B?T25kxZllag==?= Jirman <megi@xff.cz>, Aren Moynihan
 <aren@peacevolution.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>,
 linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, Willow
 Barraco <contact@willowbarraco.fr>
Subject: Re: [PATCH v2 2/6] iio: light: stk3310: Implement vdd supply and
 power it off during suspend
Message-ID: <20240428174509.6de97d54@jic23-huawei>
In-Reply-To: <CAHp75VdR9HtWbSif+j8QHX5zG9xPF1GzUFY2s-0OjD3RAWD9-Q@mail.gmail.com>
References: <20240423223309.1468198-2-aren@peacevolution.org>
	<20240423223309.1468198-4-aren@peacevolution.org>
	<CAHp75VeRDSPvpmSbUyZPp0RMoTOE193U2ma18qxv_qZQKLCq8g@mail.gmail.com>
	<5qqil7ltqhdeabml6toqpcy773uhjxgwaz3txpy4kv4sz55o2y@hmar674eey7s>
	<CAHp75VdR9HtWbSif+j8QHX5zG9xPF1GzUFY2s-0OjD3RAWD9-Q@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Apr 2024 18:20:41 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Apr 24, 2024 at 3:59=E2=80=AFPM Ond=C5=99ej Jirman <megi@xff.cz> =
wrote:
> > On Wed, Apr 24, 2024 at 02:16:06AM GMT, Andy Shevchenko wrote: =20
> > > On Wed, Apr 24, 2024 at 1:41=E2=80=AFAM Aren Moynihan <aren@peacevolu=
tion.org> wrote: =20
>=20
> ...
>=20
> > > >         ret =3D stk3310_init(indio_dev);
> > > >         if (ret < 0)
> > > > -               return ret;
> > > > +               goto err_vdd_disable; =20
> > >
> > > This is wrong. You will have the regulator being disabled _before_
> > > IRQ. Note, that the original code likely has a bug which sets states
> > > before disabling IRQ and removing a handler. =20
> >
> > How so? stk3310_init is called before enabling the interrupt. =20
>=20
> Exactly, IRQ is registered with devm and hence the error path and
> remove stages will got it in a wrong order.
>=20
> > Original code has a bug that IRQ is enabled before registering the
> > IIO device, =20
>=20
> Indeed, but this is another bug.

It shouldn't be.  A device that produces interrupts before we have
told it to is a) buggy, b) almost certainly already had it's interrupt
masked due to spurious interrupt detection.

Definitely don't want to do it in the opposite order where userspace
could turn the device on and have it start generating interrupts before
the irq is registered.  I'd rather assume non buggy hardware (and
that if there are bugs, the normal protections kick in) than
introduce a race into the software.=20

>=20
> > so if IRQ is triggered before registration, iio_push_event
> > from IRQ handler may be called on a not yet registered IIO device.
> >
> > Never saw it happen, though. :) =20
>=20
> Because nobody cares enough to enable DEBUG_SHIRQ

In most devices there is a status register and we should be
doing nothing unless that is set.  Interestingly this device either
doesn't have one or the driver doesn't read it - it reads a flag only
and so will always push an event.  Such a register read doesn't require
the IIO device registration to be complete.

There are corner cases where that isn't true that need to manually
mask at the host but they are rare.

There is also a basic level of defense in iio_push_event() against
that being called when the event interface is not registered.

Jonathan


>=20


