Return-Path: <linux-kernel+bounces-25316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E66682CD68
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 16:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10D83B229EF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 15:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32B8184F;
	Sat, 13 Jan 2024 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmdoQlEK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8911C16;
	Sat, 13 Jan 2024 15:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B005C433F1;
	Sat, 13 Jan 2024 15:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705158677;
	bh=joL09y98Yuho3mT9jFHr5tNy5WAX/PzaUDujGrJCA8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QmdoQlEKM1T20vEDqhDCpJS+fPk6muzu1JhrvPGslJVrWEF8yv08sfHXz9+XbxybC
	 1jsapgfryR6Dhl9s4rSGOgT7c+c2dd+xv0O/FENvRSfp5htUeqV4gPPX9ySeCij9c7
	 UX/iD+Xyo7CD2yvWYTsM5X8vsxgqVJXeQJzWsw2C3+Jx9QW/51gQNn+6YKt8XMedMJ
	 qV/YGMhrhGpPWRolUGFVwRqa0yDKlY+Tl2369ePD5qiE2SxGxbHg/JelitmZXPbOen
	 jwsp7NbSvAIdIetW9w05u6rv2vJ+e/m5w35qfsBmUTMhKVHdtiv90cJzC6go/9+dOU
	 ZrsAHL4d0KAbQ==
Date: Sat, 13 Jan 2024 15:11:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Colin Ian King <colin.i.king@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] iio: invensense: remove redundant initialization
 of variable period
Message-ID: <20240113151113.44bef633@jic23-huawei>
In-Reply-To: <FR3P281MB17572C4F651951596882B5DACE642@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240106153202.54861-1-colin.i.king@gmail.com>
	<20240107160736.14f3ae1d@jic23-huawei>
	<FR3P281MB17572C4F651951596882B5DACE642@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 7 Jan 2024 20:18:03 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello Colin & Jonathan,
>=20
> this is OK for me, thanks for the patch.
> The initialization is certainly coming from first development and is not =
needed.
>=20
> Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Applied to the togreg branch of iio.git and pushed out as testing.
I'll be rebasing that tree on rc1 once available.

Thanks,

Jonathan

>=20
> Thanks,
> JB
>=20
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, January 7, 2024 17:07
> To: Colin Ian King <colin.i.king@gmail.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Jean-Baptiste Maneyrol <Jean-Ba=
ptiste.Maneyrol@tdk.com>; Andy Shevchenko <andy.shevchenko@gmail.com>; linu=
x-iio@vger.kernel.org <linux-iio@vger.kernel.org>; kernel-janitors@vger.ker=
nel.org <kernel-janitors@vger.kernel.org>; linux-kernel@vger.kernel.org <li=
nux-kernel@vger.kernel.org>
> Subject: Re: [PATCH][next] iio: invensense: remove redundant initializati=
on of variable period=20
> =C2=A0
> On Sat, 6 Jan 2024 15:=E2=80=8A32:=E2=80=8A02 +0000 Colin Ian King <colin=
=E2=80=8Ai.=E2=80=8Aking@=E2=80=8Agmail.=E2=80=8Acom> wrote: > The variabl=
e period is being initialized with a value that is never > read, it is bein=
g re-assigned a new value later on before it is read. >=20
> ZjQcmQRYFpfptBannerStart
> This Message Is From an External Sender=20
> This message came from outside your organization.=20
> =C2=A0
> ZjQcmQRYFpfptBannerEnd
> On Sat,  6 Jan 2024 15:32:02 +0000
> Colin Ian King <colin.i.king@gmail.com> wrote:
>=20
> > The variable period is being initialized with a value that is never
> > read, it is being re-assigned a new value later on before it is read.
> > The initialization is redundant and can be removed.
> >=20
> > Cleans up clang scan build warning:
> > Value stored to 'period' during its initialization is never
> > read [deadcode.DeadStores]
> >=20
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com> =20
> Hi Colin,
>=20
> I definitely want input from someone who can test this.
> There is direct use of ts->period as well as the local
> variable that is indeed overwritten as you've noted.
> Feels like naming needs some work and perhaps reduce the scope of
> the period local variable so it's obvious it was only intended
> for more local use than it currently looks like.
>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> >  drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/d=
rivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> > index 03823ee57f59..3b0f9598a7c7 100644
> > --- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> > +++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> > @@ -126,7 +126,7 @@ void inv_sensors_timestamp_interrupt(struct inv_sen=
sors_timestamp *ts,
> >  	struct inv_sensors_timestamp_interval *it;
> >  	int64_t delta, interval;
> >  	const uint32_t fifo_mult =3D fifo_period / ts->chip.clock_period;
> > -	uint32_t period =3D ts->period;
> > +	uint32_t period;
> >  	bool valid =3D false;
> > =20
> >  	if (fifo_nb =3D=3D 0) =20
>=20
>=20


