Return-Path: <linux-kernel+bounces-105197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D97F87DA6A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 15:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9081C20C72
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1571B28D;
	Sat, 16 Mar 2024 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jysqc5wx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8C218C36;
	Sat, 16 Mar 2024 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710597991; cv=none; b=L6YuOe97uwvzpgED48Xk3GFNXkZ9V1Zo+GSc87+hcdU2VoibZsTxqhhk+49HFuXZzb5UqAVsnpjquD5ukHHhYDJPtbMR3sS6QzxE18I0u7xncbDATqHQiTKzQGYTtx25PX4lJ1ZdT3ubSeFFyCNPi16PHiDcKXd8zyo3L1G/A7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710597991; c=relaxed/simple;
	bh=QKLuZWkkygYcB6WBv1qdecfbnnJIK9dRYC9Tpk4yfRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGfXt7C7rvRgDrnipSNQaYKWlBLsVqqKvDEFbHk6dXtKwoOpwPnNS9CR265WiMlRm63+zGeJ5hcOS7vh/6/7QQVVVGFiw4SLO9sGWHIAKWoX/7jvxugIrtKAIbu+6AV+ktY+fRsMw7GHECqG7N4lwRKpf2cWt0kBnY1YQ2VnUbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jysqc5wx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D24C433C7;
	Sat, 16 Mar 2024 14:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710597991;
	bh=QKLuZWkkygYcB6WBv1qdecfbnnJIK9dRYC9Tpk4yfRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jysqc5wxajcRPLEwBcjYSgMy0/WGvTlUCo1KvJm4lv+uZCbD593hbnXWZnn8TQs3X
	 B54etI8pwPYhwD/QSfGL3gbo9l+pT6BIj2h+3Lwqxi5C5LyImhg01dUrkxMoO1ETwk
	 wmdO9Qe0DceAfn4AOfIkj9rUF5/SR7f+LJy+npQkYEkAgCnoBkTkzAhnSnRut/4erV
	 Na20PIq1YW4I9MZlLxSQAwtdWw9hgZ+YcUGQcro7pTkYrUnEDWmD0w8WMzLSdUvJ57
	 dh1gsqWEivN9sIoCFn4gkc8lbpIxP5CxAOixjV3gL/Rz3V6cNE2Umq7KJwGtLF7EGo
	 OL/zpkojGABYQ==
Date: Sat, 16 Mar 2024 14:06:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Colin Ian King <colin.i.king@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Cosmin
 Tanislav <cosmin.tanislav@analog.com>, linux-iio@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: accel: adxl367: Remove second semicolon
Message-ID: <20240316140616.09301073@jic23-huawei>
In-Reply-To: <717ad48efa7ffc6cc1960be05558e9cbf0b6c4c8.camel@gmail.com>
References: <20240315091436.2430227-1-colin.i.king@gmail.com>
	<717ad48efa7ffc6cc1960be05558e9cbf0b6c4c8.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Mar 2024 12:51:07 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2024-03-15 at 09:14 +0000, Colin Ian King wrote:
> > There is a statement with two semicolons. Remove the second one, it
> > is redundant.
> >=20
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Thanks Colin.

oops.

Applied to the togreg-normal branch of iio.git, but note I'll not rush
this in, so will be the 6.10 merge window now.

Jonathan


>=20
> > =C2=A0drivers/iio/accel/adxl367.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> > index 210228affb80..5cf4828a5eb5 100644
> > --- a/drivers/iio/accel/adxl367.c
> > +++ b/drivers/iio/accel/adxl367.c
> > @@ -621,7 +621,7 @@ static int _adxl367_set_odr(struct adxl367_state *s=
t, enum
> > adxl367_odr odr)
> > =C2=A0static int adxl367_set_odr(struct iio_dev *indio_dev, enum adxl36=
7_odr odr)
> > =C2=A0{
> > =C2=A0	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> > -		struct adxl367_state *st =3D iio_priv(indio_dev);;
> > +		struct adxl367_state *st =3D iio_priv(indio_dev);
> > =C2=A0		int ret;
> > =C2=A0
> > =C2=A0		guard(mutex)(&st->lock); =20
>=20


