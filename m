Return-Path: <linux-kernel+bounces-123190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A22A5890407
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7C72909C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7304A130E31;
	Thu, 28 Mar 2024 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpxlnlux"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E1E12F5B1;
	Thu, 28 Mar 2024 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711641375; cv=none; b=i1GPEV8uYKV5Wo19yU0qajvw2hi+pNh2NQ1OUZDemVNbwrveGjIdeUqXhdjSZQh4rs9LW34HaFY1gReZvJ47rLybAP9hA1VinQEKGwYnu43tNtIwnJoxWkUmxPpdz5wVj8nRVLv1YvFGq+YztJm8DKh8KIO3N4AZx3cs/DzoDnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711641375; c=relaxed/simple;
	bh=seXikRvEBjP5qaE389eJ68xd7Z2LTn4uGme/hevTowY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OmyzipIEmrO0R2EI8m3NYqhK36ombuy+EuzRKtRi0x30duXmgalEPyeJXwys9CzV49SWEEiIvO/iwVCklnmJXjx6hTeofZKbFHLu3WaAg+mJz2wMVXHwZFycVADU9VeY+CgSG6DCbnmrNPdPUNpjI9oKnpUkOH2MplVDKLWtlc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpxlnlux; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a466a27d30aso140564766b.1;
        Thu, 28 Mar 2024 08:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711641372; x=1712246172; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KshGBbPL6p0GxwULrc1CCJEUZDYhml7224xM8Oy7K4U=;
        b=mpxlnlux3nu9joRBp5GeDCxjbjrA9wbUJoLUzRQm+3z+QRIDsK3hX46DEM+fFLDtxF
         Ygw01Kv5dhPe1tAXt4CyOb/yqvdP8jK+Og6g5VG5mF5PqCI6hLAB+dgjwW8ZjcMPudx7
         d47vnCJmPFxtf+gr/CT4UzpMlBiVqRr9aGHmibI29H1OlLOrzB2hUe7sxxeHP9NDJFu+
         KQHRCyPkbnEbS/72vUmyLpbNVxnCX8D5E6O4VciOlFNx6rrx/FcVmp41zsgZt1owj2w8
         1aXzPIJWpvvosK+PlOuoCUArCWxl3iDOV6lOZIxTdiMhG4DKm+STEYgY8NoL0QE89C4A
         NOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711641372; x=1712246172;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KshGBbPL6p0GxwULrc1CCJEUZDYhml7224xM8Oy7K4U=;
        b=NeuVxg6AcXEwazUEaK0uzjbr+J+ffniUJYa4rd8QzVbynyi5iZ7jMu32juXXRzSPLl
         QvmVoQKVgCadnii3N0F7GHD3YIYuP/vYCAPl72E4qyGAh51GBMoaV3YQEXhk/XwzIwot
         tdmoSMtQIz+G12onGjwVUnLo3xEnpnSNb0aGrn/nLWffr35WLsMa1RXwUe1QkCeTHpCE
         eyrd38YcahMemXj+EavSIo1N4Yk9dzvdo3ACPJg1/q+l2ffHVbGip/Kx5lC2sDOdXnMt
         4BE2vTM7pt1IUQE/62L4jkV6+/+i1zWnCypoDFbQivfmqYlCKUH9jFGYSt+V0ZV8Y/jC
         VSnw==
X-Forwarded-Encrypted: i=1; AJvYcCVEkQvU9bqgu8P5PYa/KX4oubNrAsyGV6Hgw6Y0CVVxj4cR1duVnn8hoZiCS2gdXDktXvAWm7WsuNNuko/FzS6QHOQudkuPFrwrI3cWfh/UUkI7B2oyLHVcC9NR7Zx0JZs4HvS7l7PslKv8mfE8BVuaXNrXU7lcRBZq8tKrKig1GJHiyEnlVPT6
X-Gm-Message-State: AOJu0Ywl0BoA0GnyVJud6qvH6A6aIX3KngQBDgs434obVcPQFcRWsXBr
	Oqc0jJnrfMwLp4MV1/V1ZKJpgrOH0WSKFce12TfjA7jKT/Y3iNEy
X-Google-Smtp-Source: AGHT+IENYFr+GThYWba7AW4CeBqrkfiANyudtP4jaUyi7hGkegDBk8QG+vH2LYoijyZ+2BC/9HcW9Q==
X-Received: by 2002:a17:906:da02:b0:a47:4c82:edb2 with SMTP id fi2-20020a170906da0200b00a474c82edb2mr1920932ejb.5.1711641372154;
        Thu, 28 Mar 2024 08:56:12 -0700 (PDT)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id xd2-20020a170907078200b00a4e2e16805bsm63109ejb.11.2024.03.28.08.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 08:56:11 -0700 (PDT)
Message-ID: <4ef9f4d81f126de73e88cb221d6cc51f8bab6baf.camel@gmail.com>
Subject: Re: [PATCH][next] iio: addac: ad74115: remove redundant if statement
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Colin Ian King <colin.i.king@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Cosmin
 Tanislav <cosmin.tanislav@analog.com>, Jonathan Cameron <jic23@kernel.org>,
  linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 28 Mar 2024 16:56:11 +0100
In-Reply-To: <2b3d418d-55ee-4ca4-b6ae-bab441a76adf@moroto.mountain>
References: <20240328112211.761618-1-colin.i.king@gmail.com>
	 <3db9a68c6f71a67d95d25886fdc708de6269adc2.camel@gmail.com>
	 <2b3d418d-55ee-4ca4-b6ae-bab441a76adf@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-28 at 17:14 +0300, Dan Carpenter wrote:
> On Thu, Mar 28, 2024 at 02:52:43PM +0100, Nuno S=C3=A1 wrote:
> > Hi Colin,
> >=20
> > Thanks for your patch...
> >=20
> > On Thu, 2024-03-28 at 11:22 +0000, Colin Ian King wrote:
> > > The if statement is redundant because the variable i being
> > > assigned in the statement is never read afterwards. Remove it.
> > >=20
> > > Cleans up clang scan build warning:
> > > drivers/iio/addac/ad74115.c:570:3: warning: Value stored to 'i'
> > > is never read [deadcode.DeadStores]
> > >=20
> > > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > > ---
> > > =C2=A0drivers/iio/addac/ad74115.c | 3 ---
> > > =C2=A01 file changed, 3 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.=
c
> > > index e6bc5eb3788d..d31d4adb017e 100644
> > > --- a/drivers/iio/addac/ad74115.c
> > > +++ b/drivers/iio/addac/ad74115.c
> > > @@ -566,9 +566,6 @@ static int ad74115_set_comp_debounce(struct ad741=
15_state
> > > *st,
> > > unsigned int val)
> > > =C2=A0		if (val <=3D ad74115_debounce_tbl[i])
> > > =C2=A0			break;
> > > =C2=A0
> > > -	if (i =3D=3D len)
> > > -		i =3D len - 1;
> > > -
> >=20
> > Hmm, this change is clearly good but I think we're actually missing the=
 proper
> > fix in
> > here. I'm being lazy and not checking the datasheet and Cosmin can furt=
her
> > comment.
> > But I'm fairly sure that the intent of the code is actually to use i in=
 the call
> > to
> > regmap_update_bits(). I mean if we look at the mask AD74115_DIN_DEBOUNC=
E_MASK and
> > the
> > possible values of val...
>=20
> Good eye.=C2=A0 I haven't looked at the datasheet either, but logically I
> would think you go until you hit something that is too high and then
> step back to the valid valies.=C2=A0 In other words the <=3D should be < =
and
> the i =3D len - 1 should just be i--.

I'm not sure about the i--. Apparently the intent was to keep the first ind=
ex
with bigger debounce than val and only step back if we go beyond the array =
but I'll
leave that for Cosmin. The most important to me is something else. See belo=
w.
>=20
> (The first element in the ad74115_debounce_tbl[] array is zero btw, so
> it's never going to break with i =3D=3D 0).
>=20
> regards,
> dan carpenter
>=20
> diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
> index e6bc5eb3788d..8d484cefe5ff 100644
> --- a/drivers/iio/addac/ad74115.c
> +++ b/drivers/iio/addac/ad74115.c
> @@ -559,19 +559,16 @@ static void ad74115_gpio_set(struct gpio_chip *gc, =
unsigned
> int offset, int valu
> =C2=A0
> =C2=A0static int ad74115_set_comp_debounce(struct ad74115_state *st, unsi=
gned int val)
> =C2=A0{
> -	unsigned int len =3D ARRAY_SIZE(ad74115_debounce_tbl);
> =C2=A0	unsigned int i;
> =C2=A0
> -	for (i =3D 0; i < len; i++)
> -		if (val <=3D ad74115_debounce_tbl[i])
> +	for (i =3D 0; i < ARRAY_SIZE(ad74115_debounce_tbl); i++)
> +		if (ad74115_debounce_tbl[i] > val)
> =C2=A0			break;
> -
> -	if (i =3D=3D len)
> -		i =3D len - 1;
> +	i--;
> =C2=A0
> =C2=A0	return regmap_update_bits(st->regmap, AD74115_DIN_CONFIG1_REG,
> =C2=A0				=C2=A0 AD74115_DIN_DEBOUNCE_MASK,
> -				=C2=A0 FIELD_PREP(AD74115_DIN_DEBOUNCE_MASK, val));
> +				=C2=A0 FIELD_PREP(AD74115_DIN_DEBOUNCE_MASK,
> ad74115_debounce_tbl[i]));

In here, I think we want FIELD_PREP(AD74115_DIN_DEBOUNCE_MASK, i). If you l=
ook at the
mask and the possible values in the array, you see we can easily go off the=
 mask.

- Nuno S=C3=A1


