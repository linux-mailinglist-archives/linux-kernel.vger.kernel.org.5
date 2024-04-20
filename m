Return-Path: <linux-kernel+bounces-152269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823098ABBAB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A5D1F2141F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4161C1E521;
	Sat, 20 Apr 2024 13:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYK0GRP+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7890A625;
	Sat, 20 Apr 2024 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713618412; cv=none; b=I4ftQ8+xB2hojlZKW6bjRBQgmEKflof/hzTmIuE+7eLMYbOId7KfGFuKAyNX474MOpUsrgvFtd+8vWSqKj+ZAeB3q7h7hNXYyH768ZJaMhv1FaGRTqGPag8kCKEmGG0Obo6Th7yVXAXhvTA0m4oNVvcRzDYPhcCbaVKVueoGtuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713618412; c=relaxed/simple;
	bh=N4vN3xcboLIjcxz6Bmykno3uW1Git1Vd/uH85dY0LS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhZRo4qIKXAZbo+hFdGUpig+LvKJh8BMmCp3qwGleuvjgPKbd5540vSpp3Vb+p2/9lG0oJZGFHptpvfRJf5R09ZoAh4fI/mkvjKf+YSpPx9P5LahHK6jkOcV9F2rNpZ21jN1yAUzK8q+xH79MuaT+1xpmdQMlkCPtQtw7+iIe4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYK0GRP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11066C072AA;
	Sat, 20 Apr 2024 13:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713618412;
	bh=N4vN3xcboLIjcxz6Bmykno3uW1Git1Vd/uH85dY0LS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QYK0GRP+m4Cct/mfSzhcXZFYfRmR4F4A+nQncYRYOW4DLMxbJD1BE6SRBD5xV3Ofe
	 2AjUjcCbiirX6iZYY4zEy4l2OUgWpnIsAUJlcPCpiHGaKycKG8VBDlILk9ayDo9A6A
	 KDZWM8ASfUMcg0JPPReGhFT20Gsv2bjRw0Y2FAQbWO4ZAWuxirTDbncjL4DkBDEFDk
	 IdLMFknMJUF1YYTiqY1nxHbmhbGEgFW5SzrbAenic1DgQizC4uHO+BO52ZIYKakqvD
	 0rQeDLmpxu9cMQ5mF/SipssCiD86PA9pQBwYyAIabut3WzfHLti89sxmhG5GLM73FD
	 AXo64nLedJ//A==
Date: Sat, 20 Apr 2024 14:06:35 +0100
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
Subject: Re: [PATCH 3/4] iio: light: stk3310: log error if reading the chip
 id fails
Message-ID: <20240420140635.6dffa2fb@jic23-huawei>
In-Reply-To: <CAHp75Vf_JX1Uv=_cvoiukzSaTVWbmQSW0P_nneP8C-kxX4fBXQ@mail.gmail.com>
References: <20240414175300.956243-1-aren@peacevolution.org>
	<20240414175716.958831-1-aren@peacevolution.org>
	<20240414175716.958831-3-aren@peacevolution.org>
	<CAHp75Vf_JX1Uv=_cvoiukzSaTVWbmQSW0P_nneP8C-kxX4fBXQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Apr 2024 18:05:54 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Apr 14, 2024 at 8:57=E2=80=AFPM Aren Moynihan <aren@peacevolution=
org> wrote:
> >
> > If the chip isn't powered, this call is likely to return an error.
> > Without a log here the driver will silently fail to probe. Common errors
> > are ENXIO (when the chip isn't powered) and ETIMEDOUT (when the i2c bus
> > isn't powered). =20
>=20
> >         ret =3D regmap_read(data->regmap, STK3310_REG_ID, &chipid);
> > -       if (ret < 0)
> > +       if (ret < 0) {
> > +               dev_err(&client->dev, "failed to read chip id: %d", ret=
);
> >                 return ret;
> > +       } =20
>=20
> Briefly looking at the code it seems that this one is strictly part of
> the probe phase, which means we may use
>=20
>   return dev_err_probe(...);
>=20
> pattern. Yet, you may add another patch to clean up all of them:
> _probe(), _init(), _regmap_init() to use the same pattern everywhere.
>=20

Yes, a precursor patch to use dev_err_probe() throughout the probe only
functions in this driver would be excellent.

Jonathan

