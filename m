Return-Path: <linux-kernel+bounces-161798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAF48B5168
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A568B208F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C741118D;
	Mon, 29 Apr 2024 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euCws1If"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA17DDB1;
	Mon, 29 Apr 2024 06:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372126; cv=none; b=INP7PmjU0bPK/OgI8bU3H1BhPyIXLqPcfkVirWBSsSnXbe0rHRghLzslLwheCC1ELu6fE26OlFWBO9DzG/mEVHDzknglxHuI7z6hwy5YXeMPUL7UEuBSBO5P22m/VVsKSXU2uM8Ofxh9KKqnGiZsO5f12+jfH/EZ13uZ2Sm5p68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372126; c=relaxed/simple;
	bh=GhblGzVwMzSy5lYYypt9N7dRxE1muQv62kltZ45Z3Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BzKO8gHXB3JRS17weFBL1+jcWF81MZLK8y1+qOmJa0QrRgx50h/gcmnKE+v1la04HXjxxT4gAa2oMaSe8S1IIYFSzrH4N0sUkJ9GGIIS9I2EDclfZqDiXIcgbrBf5WMd98BzaG+18+w10KpJab0E0Hjdor1VECA10jW7eBrz2jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euCws1If; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2db17e8767cso47255261fa.3;
        Sun, 28 Apr 2024 23:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714372123; x=1714976923; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IPXCFMgawvoFaFj5V+mW05ffN61IMr3Jv0hvwUZQ34E=;
        b=euCws1IfKsr1SpVYpVM2WsFV4cxKSlA0KguaHHNQQcgLaixmdlbT7RBpYPGitdyZuu
         LUoU44TUqkHwzBlUYiwm2pWodtlgpE1wrnBcSMMWo5j8wdfRliEIc3Bd3zMUOxbOow5J
         MLa2sYsSRfsstHmTWKv2Tpv9OsTbi+P00b7jwWGgYfZwlxkXF9AwxgPeeTvX8v675/bV
         hUnR9ALUKG3hs+bYo7JbDJhdkNjIbPax2w9n0g6vb/kiKbhhifxe5FvYmNEgM3Lq7/Lv
         mA7Ta3eth3FxzqNt5mUy7p5xS2dDjLiUDYzZPZuenyms/Grj/pSwyJy3MG+fQKlWIcGZ
         Ylgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714372123; x=1714976923;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPXCFMgawvoFaFj5V+mW05ffN61IMr3Jv0hvwUZQ34E=;
        b=ECCfxyz5HQee9X75xWGoh25V50XVsgVABpU5i6lyaQgAGMO7eqVj0cVCafH8SbKe6q
         rLuzyVTVVR2+41vTTzaP+qZq46MonBWekP4YrFs0WHKTKh8aQ8r8W3J4kwuCpUJr/lXF
         94p/eXJlY5ryEmG1TZWVVobetvaO8p8//UWIOm7zjbDByf23B+tHfEKDIqYF9v1DU0gE
         EQGMpqTceZHIKP3x+wrH8C59/36+uvyZu3k/Kyy0AAJsXEkbrwE/3nj+xw9+Re8i4gsa
         n0DbOijRIbKvrQ9gZhAdfcBiZ6vsek1o7LgYavcS3Ab28WV4DFHyypzsQmaM+51nSxOj
         XNhA==
X-Forwarded-Encrypted: i=1; AJvYcCUuOAIADvfp9tw3gZJOgKEkah8oJzZEig67ueln5rNNeXY27tz1Tyykrq6SvnVzEGmEPUipqE4e7BmwAIY4KCzDYvsukPk/sQFvt2Z8th+OQLn29HynhEF77Z8kWmJXiMtB6cE4U+pV
X-Gm-Message-State: AOJu0Yyu1AaxII+OCAjIq6axGxtiaMiZtMj6Kc/AH5KvTLeDPPp/lxkP
	mB0L9hx5WE5WuumyC8UEWClhH+KS5mbe9alQbm270XYMUcW2UUeQ
X-Google-Smtp-Source: AGHT+IHJkPeg18uGdeyz1/LCKV9FwiAq4Mz6p61ww2VLmRsSHjuoDwgDS/6zwpJRYfeyeXP/c5LiOA==
X-Received: by 2002:a2e:a4cd:0:b0:2db:cd5:8f41 with SMTP id p13-20020a2ea4cd000000b002db0cd58f41mr4963278ljm.53.1714372122240;
        Sun, 28 Apr 2024 23:28:42 -0700 (PDT)
Received: from fedora ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id c3-20020a2ea783000000b002e05324fd8bsm300192ljf.34.2024.04.28.23.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 23:28:41 -0700 (PDT)
Date: Mon, 29 Apr 2024 09:28:31 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH 0/2] Fix the iio-gts-helpers available times table sorting
Message-ID: <cover.1714371936.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l2DBEd9gl9Q56KeP"
Content-Disposition: inline


--l2DBEd9gl9Q56KeP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix the available times table sorting in iio-gts-helpers

This series contains a fix and test for the sorting of the available times =
in
IIO-gts helpers. Fix was originally developed and posted by Chenyuan Yang.

Chenyuan Yang (1):
  iio: Fix the sorting functionality in iio_gts_build_avail_time_table

Matti Vaittinen (1):
  iio: test: gts: test available times and gains sorting

 drivers/iio/industrialio-gts-helper.c | 7 +++++--
 drivers/iio/test/iio-test-gts.c       | 8 +++++---
 2 files changed, 10 insertions(+), 5 deletions(-)


base-commit: 4cece764965020c22cff7665b18a012006359095
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

--l2DBEd9gl9Q56KeP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYvPgoACgkQeFA3/03a
ocUfGQf7BfIq8yJH/28tHilhT2Z/KXAbHFoLR/waM0q88Rs78tzG3GZ0+CfeE+1d
4tAapuYx8p24/kL0mwb/RQFeDZMQbmOzFjmJECiyCVGsnAIay12+fPFcJn3vsXos
AgEk9k17H8xUuDULSp3U7+TbzRopgWSZNCoxd3B+42yPCll69n9Kp96xAbdLDWyO
a35P6GCz3YRXfc0KPosv5D14cVZf3E4Wr17o1k9wZNDBfxAGKRd1RejOmnMLy/X/
FtzwrD3UGHETYJa8H6AT5wc7Nb8CUOQhIED/sqda092K+ZprT2RqL2z4U/HVo6e1
pxRoXq2CQ/AXcpMGlpm4bC9NzF0jbA==
=d6ar
-----END PGP SIGNATURE-----

--l2DBEd9gl9Q56KeP--

