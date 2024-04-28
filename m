Return-Path: <linux-kernel+bounces-161493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E388B4CB8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFCAFB21270
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DA671B27;
	Sun, 28 Apr 2024 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKnGjU7D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E642A10F1;
	Sun, 28 Apr 2024 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714322075; cv=none; b=MFz3LchyMXqHwn6gapW5c/5ThN2nMf5ZAIGIPuMkIQefCgieAj+uNTaOXfLS+dAisAG9kWFVU2yVjwFn7m0wsaEhnXPjcgq/ACC5XnhuhP6xw2RP2Wvhlc7i6+ZarnKpLzcKUw95Oq441VrQn8gK1I3hMehrZZJLzJ2ZOZsZ8og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714322075; c=relaxed/simple;
	bh=/ZnkzW7mgNGMkQEi2367jg8Z87SujBjczjx+Ing/UQY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgGVk3/JnKbdYfHoqBD5cG5xgEMXyZ+IWgNkQXFrv4nEALwpDce/rYp//l8bDjKNjnZHzLoVu9evgLKHSa/2n0AEPb+mMJh+erJRlQPLSD1c54gAPxa568kN7e9xmdbmeWY0++h5hJJBTUsYNOOpZDouG7yEPAVLBUa73Mp2uGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKnGjU7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD75FC113CC;
	Sun, 28 Apr 2024 16:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714322074;
	bh=/ZnkzW7mgNGMkQEi2367jg8Z87SujBjczjx+Ing/UQY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tKnGjU7DWR6jT6vZ3c9NEvLAOdJ+s4gzSvSfuvVpF96zgCj/+y5dj+3U6JMAjj8cI
	 yMiKUyUFH1PJN0yDqxsE1t5Qlt2iusd6aNWE23PM8ZPlvFtkEi755TryAKfOjcgyMD
	 Hoekex1uxqA27b3r39Yxjz8AAWsnDyiszKe+bZOvbUD416nbDi+zA6j8THL/ACsVSr
	 1AYrtje6/73VYuFpios3t8ZwpVnaS56sRKvIPI7chDd8TREcgX/1amK/Uz3gzbPhZL
	 KJwE157MOzWPjZbEqG4j2+zqRSCAI9ZskqkrGzsZ7CahmxLRkQIUCTXI4/nUSccZ3h
	 9cAVhbLqTj/XA==
Date: Sun, 28 Apr 2024 17:34:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Aren Moynihan <aren@peacevolution.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Ondrej Jirman <megi@xff.cz>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>,
 linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, Willow
 Barraco <contact@willowbarraco.fr>
Subject: Re: [PATCH v2 2/6] iio: light: stk3310: Implement vdd supply and
 power it off during suspend
Message-ID: <20240428173422.7c0f44cf@jic23-huawei>
In-Reply-To: <CAHp75VeRDSPvpmSbUyZPp0RMoTOE193U2ma18qxv_qZQKLCq8g@mail.gmail.com>
References: <20240423223309.1468198-2-aren@peacevolution.org>
	<20240423223309.1468198-4-aren@peacevolution.org>
	<CAHp75VeRDSPvpmSbUyZPp0RMoTOE193U2ma18qxv_qZQKLCq8g@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Apr 2024 02:16:06 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Apr 24, 2024 at 1:41=E2=80=AFAM Aren Moynihan <aren@peacevolution=
org> wrote:
> >
> > From: Ondrej Jirman <megi@xff.cz>
> >
> > VDD power input can be used to completely power off the chip during
> > system suspend. Do so if available. =20
>=20
> ...
>=20
> >         ret =3D stk3310_init(indio_dev);
> >         if (ret < 0)
> > -               return ret;
> > +               goto err_vdd_disable; =20
>=20
> This is wrong. You will have the regulator being disabled _before_
> IRQ. Note, that the original code likely has a bug which sets states
> before disabling IRQ and removing a handler.
>=20
> Side note, you may make the driver neater with help of
>=20
>   struct device *dev =3D &client->dev;
>=20
> defined in this patch.
>=20
> ...
>=20
> >  static int stk3310_suspend(struct device *dev)
> >  {
> >         struct stk3310_data *data; =20
>=20
> >         data =3D iio_priv(i2c_get_clientdata(to_i2c_client(dev))); =20
>=20
> Side note: This may be updated (in a separate change) to use
> dev_get_drvdata() directly.
>=20
> Jonathan, do we have something like iio_priv_from_drvdata(struct
> device *dev)? Seems many drivers may utilise it.

Not yet, but I'm not sure it's a good idea as there is no inherent
reason to assume the drvdata is a struct iio_dev.  It often is but
adding a function that assumes that is a path to subtle bugs.

Jonathan

>=20
> >  } =20
>=20
> ...
>=20
> >  static int stk3310_resume(struct device *dev) =20
>=20
> Ditto.
>=20
> --
> With Best Regards,
> Andy Shevchenko


