Return-Path: <linux-kernel+bounces-21954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCA182970E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534FC1C2182B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A273FB01;
	Wed, 10 Jan 2024 10:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFd9b6CV"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EA73FB06;
	Wed, 10 Jan 2024 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cd64022164so24629691fa.3;
        Wed, 10 Jan 2024 02:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704881612; x=1705486412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Db9PN58UoI6WZyGL0Ez2Auk2azip+4psO2kqm7nnVX0=;
        b=CFd9b6CVz1/svpddAB8hFneZWgctp5GtYyrxyYztoXk8OFmDvw1HUq/QAVrT2SNfHE
         e5zZbFOfjB9VRzufD2PnCvUM1OB7vXmMr8CzHO3CqmnkDQCBdvajCQ7M0YGVeDBRkwEy
         kjGokFDhigVvZnnt4WnGs4Dq5Sk2MtgU77ateC4dZ88CaRLYaQpOV8vb5isyy1Hu3C85
         FOABzA9Vtzare2plVHmCW/tTmpyLzWxesLqEkkbWJX8osOOyZugzHerm+S6ANh9okdpt
         0paI2sYf71wX2zzNg5jVA6lPhkwv/CybgBvJwzWu/XFQowsjuCR4hyJKnQrHwR6+7aaI
         km/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704881612; x=1705486412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Db9PN58UoI6WZyGL0Ez2Auk2azip+4psO2kqm7nnVX0=;
        b=XJx9udfVVMbNjBfo/ympFKg2cF9tjyl8JoJiC/msGHdOZdKB4rp3NWvAPQN5K6flLl
         dWxz5rYp9KJgSFgum1TkbMIYJjE96CoBWwnKtslQeyHmN5mb4R6Ws3xBXEz8zgd9mKu0
         yLt4pvOGi2uZHok1au0o/G1hxmOpVsBPclWjNdt23zSg4biYXqe1/lSmX/CWT3568JcF
         S/nyn2G6Z9/u5dnenGpy5kJnGbqgSzFXsLKJg8lQ7T+ZkyA3HkmadopUiBCGQFCxgx4b
         NVa7PxR0lC/HGlB01BprClrq4h6FUtUgsTPBHGLYw6FwVWmize3jnHYOUQxdXgZfS702
         xIug==
X-Gm-Message-State: AOJu0Yw9CPtHY7f3cL/yGLma7DMhF4Hy3f/bDMhfvSVAOxsVdiaZaFCf
	TTVnMFaaAj3+kvwGG6dDKRB7STGeEiI=
X-Google-Smtp-Source: AGHT+IH1JweWE5ToIpqcz5Dg9dBBtcPAxeCgUwIz8Ec5Vy6CU+aCiZNM9vmkbvSH+aQhyS8VYzY6gA==
X-Received: by 2002:a2e:7d01:0:b0:2cc:72fc:c903 with SMTP id y1-20020a2e7d01000000b002cc72fcc903mr424185ljc.59.1704881611826;
        Wed, 10 Jan 2024 02:13:31 -0800 (PST)
Received: from drtxq0yyyyyyyyyyyyybt-3.rev.dnainternet.fi (drtxq0yyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:7426:df00::3])
        by smtp.gmail.com with ESMTPSA id t13-20020a2e9d0d000000b002ccb7e51918sm706824lji.45.2024.01.10.02.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:13:30 -0800 (PST)
Date: Wed, 10 Jan 2024 12:13:26 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 3/3] MAINTAINERS: add IIO GTS tests
Message-ID: <974429b2fe03ef872035060ace8710a545d2b714.1704881096.git.mazziesaccount@gmail.com>
References: <cover.1704881096.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k+zTK3BHUD9TpkgS"
Content-Disposition: inline
In-Reply-To: <cover.1704881096.git.mazziesaccount@gmail.com>


--k+zTK3BHUD9TpkgS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for IIO GTS helper's KUnit tests.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
This may or may not conflict with the filename fix here:
https://lore.kernel.org/all/CAO=3DgReFVhp7QK_XZRBO5vbv6fmFb4BdsZeQPSzWvuiz9=
UeQekA@mail.gmail.com/

Conflict should be very trivial so I didn't wait for the above fix to
get in IIO tree. I can rebase and resend if this appears to be a problem
though.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 40c754b4c39c..05c13e0f8c4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10310,6 +10310,7 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/iio/light/gain-time-scale-helper.c
 F:	drivers/iio/light/gain-time-scale-helper.h
+F:	drivers/iio/test/iio-test-gts.c
=20
 IIO MULTIPLEXER
 M:	Peter Rosin <peda@axentia.se>
--=20
2.43.0


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

--k+zTK3BHUD9TpkgS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmWebcYACgkQeFA3/03a
ocUjSwgAu/2WVFDC127do1GVYTS34lCZAYL7XaOVWlOw6k6NSllnCw/VPwZ8eDYV
2A8ZW6YIIXr94q5gt8ztQ91fyN8QTyBibi69Nvij0a0xfWbI0nqnvAVzcliy/Lwy
omCxOq2vC3fHmiUlbWNHWZ1HAS+B5QiEEeRYaUolQPYDWXO9A84TH5A2cMOR/kLO
XeYXhvEOhqObe6f9Y+cg6MmAHt9jlPc2KQVAWsKNkYIeHDeptB0QVOgNLh61GUc7
KPQqF3rOzZxHziN8+YAIoAt8oTq3auGSUAlRJRkRYMiv0h5mUShLyFBYPmd9IRH2
avSQyp5QgwlZJjmbm8OqFqLvXRMChQ==
=rcA+
-----END PGP SIGNATURE-----

--k+zTK3BHUD9TpkgS--

