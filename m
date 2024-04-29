Return-Path: <linux-kernel+bounces-161800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0275C8B516D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E321C212B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E038E11702;
	Mon, 29 Apr 2024 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4V42H1Q"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A8E10A09;
	Mon, 29 Apr 2024 06:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372161; cv=none; b=KDJf8zwdYTZwHRsQjYMqG2Bd6a7A11LP2BbT14fYxrt7y/vYHkILTkYl2mBGnqbG/JycrZ8tjPJVbJTuMK+GX7bL12+Y9OuE3TWACYVJ9Ot28SRUct7VZbJvjV8XfRyjSghikhUNbPjxVMuL0porvoYXRS44S5RU2Au2L+/Gr7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372161; c=relaxed/simple;
	bh=qq4zDsNMoafHzLBMnQy+bZzMVXKw6q3iKUZ/m8FXZuY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGXr2JWsr74YMnRvfYzp9r39YBoWd13UxV2M4sk1Yx4xyK5oNgWQIHinjOh0d/wPLvnLKfeennUp9TMRXj6+cVeSGkTklrIBDE1aQ0fHnjksSHjdb6gijvhR1uMWka1Lf/XH23z1BLOb1Rn16N5FFx3hrz2AqVAR4coU3JOyGaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4V42H1Q; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51c66cc680aso3045640e87.1;
        Sun, 28 Apr 2024 23:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714372157; x=1714976957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2apcWppYghC3wMcLJm6etARiKxq/wkL7Dh8Q+umWcuU=;
        b=c4V42H1QlSf695S/YMPNTqSa0GvZwz3hj2VaVDqN17Av3yfj9Lxvg0J6yT75I1nLEJ
         gjvmGGtK5MCF3zk6ToTyzqKWwAvC9lJIHKjmNMdsh6VuT7lXHWl6Gn6b8mkMEGJ6r3oW
         g03RBysCwUQ69sflBLShNTimTrYrSh/mlf+QL1S0YR54GlYbGHPVZgnF0kU1RQyYIXQ5
         YKVC29SAIuEGKbEwcR2yQnXxSNJZk4oOfJGY94IfiUbU1M9emqaieT2/j3xNAeYyn13g
         v0zYQ2y5MKg7xwOQN2qMmq4gtbPEsex9/AUXEN6EvPROAh4M2WxtcnE272dhIrfTyyT9
         WBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714372157; x=1714976957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2apcWppYghC3wMcLJm6etARiKxq/wkL7Dh8Q+umWcuU=;
        b=vHjaMM+wWtXtyMSBqHlOXKGZwisPAvoRJSsQmV7fzC1NsMobUkXICvWOOYHW0H3gt8
         FOhBHhsEsEwXvVvrv7P1HknQWAkiR1br0x12WCsNAcdJ3+PY1ZUZFbEbJ2WMbSLEr5nn
         eZJU/nTNZYZhkJ+RdG1NT0pYjoXcyM8Wx/4YZj3QzE+ahX8KnL48wKqy9MglW/Igd2Ib
         I1Psmxf6XlZlztMnE1V+X6QTUCnq+kneVb9DfSyzrsA7sCYi1g8SurppAwcvzA0dCAuD
         +0z/yn8iu825MN+FOUQy+cg7K+zv+Pp7XxBQ/3l2gqfQEsxL24SXUYqxOguQskXpE4aN
         cLcw==
X-Forwarded-Encrypted: i=1; AJvYcCXo2vZoZs/QqVWmlyt8jH/Epn2PbKkuPA0ySPrl11IOq6TNRY5BEJncqGRMqgVBzVbc2AgzJOOz/pqh7vwXl/ltbr7pvcOxUc5F6VbTueRwgYB0ACVqA7f1x3pmwYSlhLrzacEUutqz
X-Gm-Message-State: AOJu0YzG6ELEer5nWlv8gqsxkh6JkidT66RS6O+lUxRTxrqObWtTpdp/
	64wThYMr41o341RIJWkiHVXSTQDiydVE9jUcoVWuh0/sWVMd4ShM
X-Google-Smtp-Source: AGHT+IFPZC9KwcGLEJ/J+ll04ZrbcxZaE1JGA2imPpwVOD6gUpTDxJj5ksdjoVkx4i8z+D+TfV/yZw==
X-Received: by 2002:a19:7002:0:b0:51a:c4fe:3397 with SMTP id h2-20020a197002000000b0051ac4fe3397mr2829589lfc.23.1714372157225;
        Sun, 28 Apr 2024 23:29:17 -0700 (PDT)
Received: from fedora ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id z19-20020a195e53000000b0051dcb9de247sm198375lfi.40.2024.04.28.23.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 23:29:16 -0700 (PDT)
From: Chenyuan Yang <mazziesaccount@gmail.com>
X-Google-Original-From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Mon, 29 Apr 2024 09:29:12 +0300
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH 1/2] iio: Fix the sorting functionality in
 iio_gts_build_avail_time_table
Message-ID: <3d98589455726e812cf2ad2610f7351ee2b93b07.1714371936.git.mazziesaccount@gmail.com>
References: <cover.1714371936.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BlEnUVAr9c0MIo47"
Content-Disposition: inline
In-Reply-To: <cover.1714371936.git.mazziesaccount@gmail.com>


--BlEnUVAr9c0MIo47
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The sorting in iio_gts_build_avail_time_table is not working as intended.
It could result in an out-of-bounds access when the time is zero.

Here are more details:

1. When the gts->itime_table[i].time_us is zero, e.g., the time
sequence is `3, 0, 1`, the inner for-loop will not terminate and do
out-of-bound writes. This is because once `times[j] > new`, the value
`new` will be added in the current position and the `times[j]` will be
moved to `j+1` position, which makes the if-condition always hold.
Meanwhile, idx will be added one, making the loop keep running without
termination and out-of-bound write.
2. If none of the gts->itime_table[i].time_us is zero, the elements
will just be copied without being sorted as described in the comment
"Sort times from all tables to one and remove duplicates".

For more details, please refer to
https://lore.kernel.org/all/6dd0d822-046c-4dd2-9532-79d7ab96ec05@gmail.com.

Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
Co-developed-by: Chenyuan Yang <chenyuan0y@gmail.com>
Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Co-developed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---

Original commit (by Chenyuan Yang) was amended by me to remove duplicates
so that the user-space callers do not get multiple instances of same time
as was discussed here:
https://lore.kernel.org/all/a59061f8-5caa-43d4-bd4f-5ac4c39515ba@gmail.com/
---
 drivers/iio/industrialio-gts-helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrial=
io-gts-helper.c
index b51eb6cb766f..59d7615c0f56 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -362,17 +362,20 @@ static int iio_gts_build_avail_time_table(struct iio_=
gts *gts)
 	for (i =3D gts->num_itime - 1; i >=3D 0; i--) {
 		int new =3D gts->itime_table[i].time_us;
=20
-		if (times[idx] < new) {
+		if (idx =3D=3D 0 || times[idx - 1] < new) {
 			times[idx++] =3D new;
 			continue;
 		}
=20
-		for (j =3D 0; j <=3D idx; j++) {
+		for (j =3D 0; j < idx; j++) {
+			if (times[j] =3D=3D new)
+				break;
 			if (times[j] > new) {
 				memmove(&times[j + 1], &times[j],
 					(idx - j) * sizeof(int));
 				times[j] =3D new;
 				idx++;
+				break;
 			}
 		}
 	}
--=20
2.44.0


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--BlEnUVAr9c0MIo47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYvPjgACgkQeFA3/03a
ocUawQf/UU2ML0v2BeFGp3sbndG7E/MMMuiE1rTXVw8vSQrrOqbT3vHMCHeLBbQy
KYBHgUnJVUImckd84Pw6VGOHSdeZ/o4L6OfZ6t1wN4vmEUNM2gYDwLilcQVdXLcl
AdNTIwog42J94kYhS3T2Ubt0ZLgEK8GJXgi5+kB1DYPkOmBrdT4autNr35KzJxDc
OIcqCl2EFeOrVi8Eib3WT+QmkGleeFEMh5549Hbmzr4oiGK2wse/keRGq9aoJvtb
t5zyyoOFryR/RR8IaInzj01Fk1N1XtvxNVf6SeCg6vb65oiTz9Wf6yJi8BZHollE
KPzimDt0QgccyVy+0bL+CJlfRXo4Lg==
=mnzx
-----END PGP SIGNATURE-----

--BlEnUVAr9c0MIo47--

