Return-Path: <linux-kernel+bounces-38721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 762B183C4A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164AC1F22587
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070B66341D;
	Thu, 25 Jan 2024 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7L0bqtm"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D20763500;
	Thu, 25 Jan 2024 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192812; cv=none; b=SUo0qWXK/h1BcR0KCN5Nnk8HyH+Mmy4S1wfMAEAYcwcOrQkuv4pAAwLiVIULawSB5S+kNlqjouVZzmxQeXB9K2agVpJjf3YQOxOa+mzX+QH63Eqx+sex84SWvM/ZXVGfjqDTxO0LoJSftC3GEMgwfV2ZtRe4LDQgOCks0Vzdjy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192812; c=relaxed/simple;
	bh=RWLKO/AtH0Uj+yL0MoMxKrixm64mWC7/e4QlFC0ewLg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vz0IgPqhlqfkV7eWmdQ7dr61hcpF3/9f+jj+fUMCZH6D8UTDexqUaLenGFSrwfpTrRNMAiiumMcqhWV87dZ+/WfeW0b/IYBiHQ06zlGB/ZxXVM6rBSXQx5geA5Q0eJC3pc+Moiuc0bHUzttlpTSt2tHbUzu+9irhFyxH6dwFB7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7L0bqtm; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5102188d2aeso299658e87.2;
        Thu, 25 Jan 2024 06:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706192808; x=1706797608; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7uD8uO6W0P3VobMqY6RhL29xNcpRHCUEHzBOg3bakiE=;
        b=C7L0bqtmV3d+mhWj7mIFM5sgLs7tG8VOvbFyZJRmxV1e6hPSMQrufn8UdMJ4Wta2+v
         8wJj+M9xayTOPPJU9rXKeZQuoJKpX1EQvrYWdHtavpRsrDUKdYgq9uhgctqPHjed3eE9
         11a9TtH/frOOasN2ZLZ1+mWrmUyUT7I1p32clSdgdpv+lPGSDA9F8m/dAV/XUP8+pSV4
         o3e1avGPSqmbEBGYBFlsnHdcob8OMxef86Fnek/DrZbXI/wdhHCnPur4vQXTrX9S8wzi
         USN2xIZ8nXW0LNg6oM79T9jk2QdHAnDTT6l5NoH3AaN5p5VnNCjh9WdKJetpLD/inaZ1
         uuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706192808; x=1706797608;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7uD8uO6W0P3VobMqY6RhL29xNcpRHCUEHzBOg3bakiE=;
        b=r2zPA2KNSaT59VcBIEL/ArFNm/+2xVS4QkdgLTMVcKD0RTul4KTDQOWfiHS/QoMuOp
         1QF+WBLIWkM+UX9qmbKdlpzQ3ZAoGScIfpychklaZMZzrpDVqBXAar4Phubx8P3OxhzS
         O1cvHBeMZChGexEk7zqCIRgPM7TMyX5TSkXpmYMXWfduYgYnK+e1C5h1Fvj/iF0KDfzl
         aCF6sIbilbd4IiWOeMnQVH4GSe9Wx02r4IJenkcJtmNwIo0ELhFXff7aN+dff0TvR59O
         Xxz/I/7wOa9m2LBjbbKvopyfsElXQwxb63727plF6KXMaHlc0X1e3C8CatDNKho49F9G
         J0Cg==
X-Gm-Message-State: AOJu0YzPId2B3TBGvYEpcFNV4pCw4U6TT38PDsWB0fIUAZnw+yKnLbrA
	++BNOLwMmohOiAv7bJfM/O7ZaDebD61C45C4OvciBVf9d0h0FUsw
X-Google-Smtp-Source: AGHT+IE70Kr7/28FNumUfqlwgzeLAEsaLtkhNZnxzEEvvYgApYoQ87mL33iHl2Ao38fAlDjKtBXN3A==
X-Received: by 2002:ac2:5202:0:b0:50e:7555:1eb2 with SMTP id a2-20020ac25202000000b0050e75551eb2mr572160lfl.74.1706192808293;
        Thu, 25 Jan 2024 06:26:48 -0800 (PST)
Received: from drtxq0yyyyyyyyyyyyybt-3.rev.dnainternet.fi (drtxq0yyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:7426:df00::3])
        by smtp.gmail.com with ESMTPSA id o1-20020ac24c41000000b0050ea7b615c3sm2871101lfk.230.2024.01.25.06.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:26:47 -0800 (PST)
Date: Thu, 25 Jan 2024 16:26:40 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-kernel@vger.kernel.org,
	David Laight <David.Laight@aculab.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: gts-helper: Fix division loop
Message-ID: <ZbJvoM3NJd_Uh_s6@drtxq0yyyyyyyyyyyyybt-3.rev.dnainternet.fi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="58OujoI1kgFawucR"
Content-Disposition: inline


--58OujoI1kgFawucR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The loop based 64bit division may run for a long time when dividend is a
lot bigger than the divider. Replace the division loop by the
div64_u64() which implementation may be significantly faster.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")

---
This change was earlier applied and reverted as it confusingly lacked of
the removal of the overflow check (which is only needed when we do
looping "while (full > scale * (u64)tmp)". As this loop got removed, the
check got also obsolete and leaving it to the code caused some
confusion.

So, I marked this as a v2, where v1 is the reverted change discussed
here:
https://lore.kernel.org/linux-iio/ZZZ7pJBGkTdFFqiY@dc78bmyyyyyyyyyyyyydt-3.=
rev.dnainternet.fi/

Revision history:
v1 =3D> v2:
 - Drop the obsolete overflow check
 - Rebased on top of the v6.8-rc1

iio: gts: loop fix fix
---
 drivers/iio/industrialio-gts-helper.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrial=
io-gts-helper.c
index 7653261d2dc2..b51eb6cb766f 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -34,24 +34,11 @@
 static int iio_gts_get_gain(const u64 max, const u64 scale)
 {
 	u64 full =3D max;
-	int tmp =3D 1;
=20
 	if (scale > full || !scale)
 		return -EINVAL;
=20
-	if (U64_MAX - full < scale) {
-		/* Risk of overflow */
-		if (full - scale < scale)
-			return 1;
-
-		full -=3D scale;
-		tmp++;
-	}
-
-	while (full > scale * (u64)tmp)
-		tmp++;
-
-	return tmp;
+	return div64_u64(full, scale);
 }
=20
 /**

base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
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

--58OujoI1kgFawucR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmWyb5sACgkQeFA3/03a
ocVdBQf6AmGWHNraNeG7q7msDYkGPGvzuKfJ0PUE8JDxvkfGj+7kjCBWLxTGZ0xP
RuRiI6Rdus7H6qfmwOLVmzW+jGuWoTtpHU7xi4fkESyEwwUZVAzM/3p0EurevOIM
wgbHQIZLkvtQY8uYNXy5bb7QZV2MYFwFUssdHSM+iYM7kWLt8e7xR4X3ZIoQy8cn
8sTzxzz3cQG2ATlUJbFPL15Wsemt51p7C4To0x5UVRtsGNQk/av9jiKy8Rgad0Mf
5yaPvw1UgcADcsA5XuQRu5nX77NZlMPIzySlQ4p62Jvstwu64qpylKzKo25eMGp6
03tEDDohL190qLsnw0KM5q540VYLEA==
=0E+9
-----END PGP SIGNATURE-----

--58OujoI1kgFawucR--

