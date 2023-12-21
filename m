Return-Path: <linux-kernel+bounces-8117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0990D81B256
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7451F253A1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A7B4C608;
	Thu, 21 Dec 2023 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TP4HLqo7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20054C3CE;
	Thu, 21 Dec 2023 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2343c31c4bso64574966b.1;
        Thu, 21 Dec 2023 01:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703150709; x=1703755509; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=318Hwb+NUs47iOlM3PJU3kXLhvOZfDlGLt+SH+g0hdw=;
        b=TP4HLqo7+RwFG2KClbI9l8Mqq8n0oVGq8g8TvP6BFWg9lT9QTwSbTo3tynUhKD0L54
         tP0y1z0DblnwSGlRw5NGrKxlfjMj+jzo3O7G+PsD/0M1qDkABfHmz/0T9oCQEW4hj/Ha
         DgWmjDQUqBiJYDyMeNXJAYQrZJArX0Nkzfzg/DD2Yrp8R+g9QFtudPXAyNY5ZVUsNY1S
         CthhEn2pO60enUpUgpCWNFCoZbYIqzMKWYm5Ct/AixRAkb8DxyoL/dbDQKDKcbmacqff
         WEilo0mGX936glwgE3UW/MVutxiE2MZX+ggYc9wnrwPMxYOgxd7G6YKpmX5aDpmJqa94
         7kHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703150709; x=1703755509;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=318Hwb+NUs47iOlM3PJU3kXLhvOZfDlGLt+SH+g0hdw=;
        b=MQqLqOGHyXdx3TIb+YHcaebhmZl5MYm+f7U592nhAPf18IANuLZrUr6e0zfn0n0q9k
         VnAKCHEpMweeBSYPhTkz1M6f0RyJcA0dE28OhGWYgwMm3UgBZs+qPQ8C+VoLZDYgQe/u
         R+1a939EvmxZS7f5ro1/Y6xUIbPpVXcam5avAcBuvwbvvwOA2OqFPM7+1vxCsyS28LJD
         j1u8jPu0Ns2qXjYCGQZyAZw31fUC7ACXMmmAXjx778atg+mgQMVe9BRqeQl+wtxsZ66b
         5dzpZyouZltVGSO0u9+5CywqNhncNCaHDAst9Ifo+XvR9eX1S5XTvouu3ru9mfKUtc2s
         mwsw==
X-Gm-Message-State: AOJu0YzxAPDc9jnzJqcsvKNPoUqVVZD0TaAWkuSG7oGar/9dny96Gv9b
	yTnZltAeqokDkOE593mSa0rJW4EwLys=
X-Google-Smtp-Source: AGHT+IGjP79JDVHIs1i54YJ69+2fSyPnPub8zWqBSUddOD16MhDxtVwDgymQMy0hHtUn3VQUpGj+4g==
X-Received: by 2002:a17:906:7390:b0:a26:983b:969b with SMTP id f16-20020a170906739000b00a26983b969bmr732337ejl.64.1703150708759;
        Thu, 21 Dec 2023 01:25:08 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id w6-20020a170906480600b00a2693a66d03sm736312ejq.160.2023.12.21.01.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 01:25:08 -0800 (PST)
Date: Thu, 21 Dec 2023 10:25:06 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Sean Young <sean@mess.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Flavio Suligoi <f.suligoi@asem.it>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pwm tree
Message-ID: <ZYQEcg0-SEFEeuN6@orome.fritz.box>
References: <20231221165805.0c4771c1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0Q/Ht7HQv8P8dMbf"
Content-Disposition: inline
In-Reply-To: <20231221165805.0c4771c1@canb.auug.org.au>
User-Agent: Mutt/2.2.12 (2023-09-09)


--0Q/Ht7HQv8P8dMbf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 04:58:05PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the backlight tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/video/backlight/mp3309c.c: In function 'mp3309c_bl_update_status':
> drivers/video/backlight/mp3309c.c:134:23: error: implicit declaration of =
function 'pwm_apply_state'; did you mean 'pwm_apply_args'? [-Werror=3Dimpli=
cit-function-declaration]
>   134 |                 ret =3D pwm_apply_state(chip->pwmd, &pwmstate);
>       |                       ^~~~~~~~~~~~~~~
>       |                       pwm_apply_args
>=20
> Caused by commit
>=20
>   c748a6d77c06 ("pwm: Rename pwm_apply_state() to pwm_apply_might_sleep()=
")
>=20
> interacting with commit
>=20
>   2e914516a58c ("backlight: mp3309c: Add support for MPS MP3309C")
>=20
> from the backlight tree.
>=20
> I have appplied the following merge fix patch.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 21 Dec 2023 16:13:37 +1100
> Subject: [PATCH] fix up for "backlight: mp3309c: Add support for MPS MP33=
09C"
>=20
> from the backlight tree interacting with commit
>=20
>   c748a6d77c06 ("pwm: Rename pwm_apply_state() to pwm_apply_might_sleep()=
")
>=20
> from the pwm tree.
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/video/backlight/mp3309c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/=
mp3309c.c
> index 34d71259fac1..b0d9aef6942b 100644
> --- a/drivers/video/backlight/mp3309c.c
> +++ b/drivers/video/backlight/mp3309c.c
> @@ -131,7 +131,7 @@ static int mp3309c_bl_update_status(struct backlight_=
device *bl)
>  					    chip->pdata->levels[brightness],
>  					    chip->pdata->levels[chip->pdata->max_brightness]);
>  		pwmstate.enabled =3D true;
> -		ret =3D pwm_apply_state(chip->pwmd, &pwmstate);
> +		ret =3D pwm_apply_might_sleep(chip->pwmd, &pwmstate);
>  		if (ret)
>  			return ret;
> =20
> @@ -393,7 +393,7 @@ static int mp3309c_probe(struct i2c_client *client)
>  					    chip->pdata->default_brightness,
>  					    chip->pdata->max_brightness);
>  		pwmstate.enabled =3D true;
> -		ret =3D pwm_apply_state(chip->pwmd, &pwmstate);
> +		ret =3D pwm_apply_might_sleep(chip->pwmd, &pwmstate);
>  		if (ret)
>  			return dev_err_probe(chip->dev, ret,
>  					     "error setting pwm device\n");

Hi Lee,

We could exchange stable tags to make this work, but given that people
(myself included) are getting into holiday mode I'm inclined to just add
a pwm_apply_state() compatibility inline for now and then we can address
this in the new year or for the next cycle. What do you think?

Thierry

--0Q/Ht7HQv8P8dMbf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmWEBHIACgkQ3SOs138+
s6GBoQ/8CDWjDCw4kMybF0fuITOSwjywIj3s25B5D+0/fKrhrPYUlX8n/2k/x5Ue
SOSMI/8uYJGxYucxPme3p5Cd594BrtUT9sMDUqa+BUyl6PGgXdW6sElXmaXd+rRG
bI3F2zDZf/DymmnAYQixuuS5NnJaJGQIrhG74OINI5J3wq2p9nFyDH7aGroId9KS
9KCFHnBXqfn3Etw/rSyXPh4aB/F4KQEy2iz8sQi+medqJNiD5zXMLzgWTto8sYdM
qZAU9YichkvYf2U45MbIppBHeU0egvAty+YXgJHuuBEUTuZh4y+e2tNv9VtNcN1O
T8jyCUdTYBLOz+V/CmJCm8aRng4a07QN/+bBWJXnuG2iVf/Mu8RvtQBiOVysenoL
5b9EMXBzXXpL4IzjT+BB83oKl4ca4mEAO+O5EmUOHFPgMk7Wd8zbrBJmRj2OxzLI
My0+C+5voAkdM2IPer6TE41YQCnw8c50s5mZ6lJwhAi3W4h0shHOCDLoM28dEXFF
R0t4r/hMM4IGaUzmAV5kcWBTByTlP5VCU+Zu1NSvdqp03orHhaaLNhylhiYh2q9t
vLklmmolE6BZDuF/17tWegZkqLtTIQs2QuCkkaD0NWAab87pnXjdEg/vOSJsJ+38
w/Ysa/q++LyCFVcByaQ0UkyTuZ3qT94o7XZshfhK2iAJE2PxmT0=
=Q5Hq
-----END PGP SIGNATURE-----

--0Q/Ht7HQv8P8dMbf--

