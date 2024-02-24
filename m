Return-Path: <linux-kernel+bounces-79774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE717862680
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08281C21535
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA05482DA;
	Sat, 24 Feb 2024 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfYKydJB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A907D45030;
	Sat, 24 Feb 2024 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708797306; cv=none; b=mSJ96atme+B7kcYTh6PK7E+n9m7Kv4hTYeLWXI4UJkMgthYmEgoIqFEpHJWj2bVO8yDu1voy8xFGF5rAbitlTOOJG+3ZaOXTjg9EqtUa8/KNM4Gh8+wSr7c1ZYipT+ccrlidvPOzbhlUS8b+lxbG0gOUlOMC93aW6nf9d3R/IDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708797306; c=relaxed/simple;
	bh=+U3p6XWhKPzjcH7Ryeh4baGD5MBCZbaDNuBKMlXSTiY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GexZAxFEipFhs8n6i4vnfOjg+YgxPsGzRiOqmiLmhrytfgvxlldKr+KQoaMqQs9eQB42/F9LQ+qooHwZ0IlCmEZCGdQemnm3Rq44FuWA9i1KVZI2jUzZs+SyTReBd5JmEkEl7W/5OkEDdEqkZbyK2cSWwrPxVpP1sJTgKWclSxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfYKydJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DB7C433C7;
	Sat, 24 Feb 2024 17:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708797306;
	bh=+U3p6XWhKPzjcH7Ryeh4baGD5MBCZbaDNuBKMlXSTiY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hfYKydJBIyHctRmSVuD74MPe0Z6ZiutZnZUXuyuAY327y1buIlBjT8cAKXdzXrmYl
	 KCpLlG2ySbaIcRPkgks+h0AjlvmwDWIAzqF1Va879cXgW9Tl4qSXYZwJYpyp2Sv5ls
	 V6fLg4I5UAhjSGvxdhGsl1JfyxDrDBziiF9HwXrJmzXd0JOqG8TQWgpSc2nShKzaiJ
	 PwWrby8wu2SKHAZZ47+OuRR77nMNAK6SQ3/ZinLrkpKC8JuTiVaUIYFxKmkKhWhvVp
	 1zPRshqqJszVHHNUFzmrm3A9mdOToAYP/USWka0v/1OPEHbtrQKQ5ZSX2t+FtGpM9e
	 EiHoZ0g20o/CA==
Date: Sat, 24 Feb 2024 17:54:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ceclan Dumitru <dumitru.ceclan@analog.com>
Subject: Re: [PATCH v5 5/5] iio: amplifiers: hmc425a: add support for
 LTC6373 Instrumentation Amplifier
Message-ID: <20240224175448.484ccd10@jic23-huawei>
In-Reply-To: <c92c4c71f433c7375588e832d3c084a50190a1b5.camel@gmail.com>
References: <20240220153553.2432-1-mitrutzceclan@gmail.com>
	<20240220153553.2432-6-mitrutzceclan@gmail.com>
	<c92c4c71f433c7375588e832d3c084a50190a1b5.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Feb 2024 14:23:51 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2024-02-20 at 17:34 +0200, Dumitru Ceclan wrote:
> > This adds support for LTC6373 36 V Fully-Differential Programmable-Gain
> > Instrumentation Amplifier with 25 pA Input Bias Current.
> > The user can program the gain to one of seven available settings through
> > a 3-bit parallel interface (A2 to A0).
> >=20
> > Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> > --- =20
>=20
> Just one minor comment. With that:
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
> > =C2=A0drivers/iio/amplifiers/hmc425a.c | 124 ++++++++++++++++++++++++++=
++++-
> > =C2=A01 file changed, 120 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/=
hmc425a.c
> > index 77872e2dfdfe..50c86c2d28d7 100644
> > --- a/drivers/iio/amplifiers/hmc425a.c
> > +++ b/drivers/iio/amplifiers/hmc425a.c
> > @@ -2,9 +2,10 @@
> > =C2=A0/*
> > =C2=A0 * HMC425A and similar Gain Amplifiers
> > =C2=A0 *
> > - * Copyright 2020 Analog Devices Inc.
> > + * Copyright 2020, 2024 Analog Devices Inc.
> > =C2=A0 */ =20
>=20
> ...
>=20
> >=20
> > =C2=A0
> > +static ssize_t ltc6373_read_powerdown(struct iio_dev *indio_dev,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uintptr_t private,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *buf)
> > +{
> > +	struct hmc425a_state *st =3D iio_priv(indio_dev);
> > +
> > +	return sysfs_emit(buf, "%d\n", st->powerdown); =20
>=20
> Well, in theory the read should also be protected with the lock...

Only reason I can think of for that is potential read tearing.
If that happens on a bool we are going to be in a mess so I think this
is in practice fine without, though paranoia might suggest locking.

It can race against it being powered down but that effectively happens
even if we do have a lock as we either see the value before or after
a racing power down event and we have no way of knowing which.

Applied rest series to iio.git togreg branch and pushed out as testing.

Duitru, if you can figure out what happened to your message thread before
sending more patches that would be great. The IDs for patches 0-5 go

20240220153553.2432-1-mitrutzceclan@gmail.com
20240220153553.2432-3-mitrutzceclan@gmail.com
20240220153553.2432-5-mitrutzceclan@gmail.com
20240220153553.2432-2-mitrutzceclan@gmail.com
20240220153553.2432-4-mitrutzceclan@gmail.com
20240220153553.2432-6-mitrutzceclan@gmail.com

Which really confuses my email client and patchwork.
https://patchwork.kernel.org/project/linux-iio/list/?series=3D827901



>=20
> - Nuno S=C3=A1
>=20


