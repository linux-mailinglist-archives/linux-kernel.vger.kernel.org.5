Return-Path: <linux-kernel+bounces-16449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 220B9823EBC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3241F23F81
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ECD208D8;
	Thu,  4 Jan 2024 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLr3iUu+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2729208D5;
	Thu,  4 Jan 2024 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cca5d81826so4127461fa.2;
        Thu, 04 Jan 2024 01:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704360888; x=1704965688; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wwPJBvFUuJ82VNrrULxCE0KnzFUUxsKXN3QUl2P63Vk=;
        b=MLr3iUu+IgjnqFmbzwK5uEGRvNfetWt0CuYJr9CWkqdMqovJWeXUE+gtki7wX9BGPm
         acxrPA+PLfJ+av/T/IY7BU/2TSHq0Ow+z82JZWtDooN82A7weX0vywDqs7Y11BYMFQkh
         EjrTz6+dy95sC1uHbJibAKaJDCyWEmFQN0enauZVJEPCta8jLgtQDKRzKggTm+6DOPOD
         d7hNVnxe74jH5BhxYrH12atBMxzdGfusHfL7T4DlQvUxrOdE4Q+3YqwbKdts6GwwQp1q
         7aGG9ps7iCQz8maXBQEFGDWarjMKBkXQTQhUgqA+iSWuRZORt0mkhbiQC8W+JhQjnFHW
         Ro0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704360888; x=1704965688;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwPJBvFUuJ82VNrrULxCE0KnzFUUxsKXN3QUl2P63Vk=;
        b=A2HnVciNDJwywSQEbvcK2eiQ3UR4S8rTGhihCMP9hIB7DAWl9jy+RSiryd53iy3Akm
         EG6N4hCRkx4PcsTTt/r1J8Jb6EIYNu+87QMONHM8+ZcSRzUsIZP9sY3HnnqlpwMQbV5o
         DOMaQq53xuuAugAqZ7v3OjxMhCJqTXfmJ5q/J2cSIJbBXJKo7RAsCcQLyMRfaWmp4Y35
         R9ttZVlsn9gG/BK7UqNCCBa/pvLD260iUObdjMzNM04HROzQsykl/5rgaYNDmFT6mlCq
         3YsU0ZzAwXvnwxKF17MOYG6ojGogF8EkQC3+Htolytc6L9mjtKPTeOAg4TgWwQ8uIL0f
         EPGQ==
X-Gm-Message-State: AOJu0YwtTUAcVbuUfeM2bLOvwZyhKE03fblodKbuGIVNaisJIxriBXHv
	Uy5Vo4MY7NS0PdSuhr4oFKM=
X-Google-Smtp-Source: AGHT+IG+EjNeEQH8XAZ58l6P7Y1N2m9ZQ6s2V/eWis8olnOxfoxwbrN3hnVFPLdz1HHGTZ8CWByd7w==
X-Received: by 2002:a2e:a405:0:b0:2cc:a253:a4a4 with SMTP id p5-20020a2ea405000000b002cca253a4a4mr201837ljn.21.1704360887340;
        Thu, 04 Jan 2024 01:34:47 -0800 (PST)
Received: from dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id g14-20020a2e9cce000000b002ccbc2a0d43sm4998488ljj.47.2024.01.04.01.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 01:34:46 -0800 (PST)
Date: Thu, 4 Jan 2024 11:34:28 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: gts-helper: Fix division loop
Message-ID: <ZZZ7pJBGkTdFFqiY@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZBhXKsBwY+mTdV5C"
Content-Disposition: inline


--ZBhXKsBwY+mTdV5C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The loop based 64bit division may run for a long time when dividend is a
lot bigger than the divider. Replace the division loop by the
div64_u64() which implementation may be significantly faster.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
---

I've implemented also a fixup series for supporting rounding of
gains/scales:
https://lore.kernel.org/lkml/37d3aa193e69577353d314e94463a08d488ddd8d.17017=
80964.git.mazziesaccount@gmail.com/

That series does also remove the offending loop.

We don't currently have any in-tree users of GTS helpers which would
need the rounding support so pushing the rounding is not urgent (and I
haven't heard of Subjahit whose driver required the rounding). Hence, we
may want to only take this loop fix in for now (?) and reconsider
rounding when someone need that.

Jonathan, what's your take on this?

 drivers/iio/industrialio-gts-helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrial=
io-gts-helper.c
index 7653261d2dc2..abcab2d38589 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -34,7 +34,7 @@
 static int iio_gts_get_gain(const u64 max, const u64 scale)
 {
 	u64 full =3D max;
-	int tmp =3D 1;
+	int tmp =3D 0;
=20
 	if (scale > full || !scale)
 		return -EINVAL;
@@ -48,8 +48,7 @@ static int iio_gts_get_gain(const u64 max, const u64 scal=
e)
 		tmp++;
 	}
=20
-	while (full > scale * (u64)tmp)
-		tmp++;
+	tmp +=3D div64_u64(full, scale);
=20
 	return tmp;
 }

base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
--=20
2.41.0


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

--ZBhXKsBwY+mTdV5C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmWWe5QACgkQeFA3/03a
ocVoKwf+JqwM+uOPd3l+ECkvm1GhHX2OsknGaOa2lMTHeXBlDRKhYvR5694Z7eSj
XLsmOLS1WIwmrffFpprksh7DXTXfQp9pwLIjmh8BFjP/dCkBowBMw/O8E74Cpe3b
gHU77BC09IAYlKNeS2fQBbrVlVSzkb8mma1MmISvs4pNaV+4DmdTWSoYn2n1mqcS
s0DCjDOW3dXOrU57TtfJma9M3SGIalXLhj8DUqZji4zHTO+u7w0aPF7iJuiHnYUF
tWNS5f6rZ+JGa4Fph/T0LFXblQ85v7yGdubrU5cITRf8vvSFP+wQlBusWTd+oqMx
Fwh+rKlRQnhMo7P6SuZCau3HW+kSDA==
=4zw1
-----END PGP SIGNATURE-----

--ZBhXKsBwY+mTdV5C--

