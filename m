Return-Path: <linux-kernel+bounces-155005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF758AE43A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F017A1F21657
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947A37FBCF;
	Tue, 23 Apr 2024 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jeo845n8"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D57F7E58A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872320; cv=none; b=RmtS5eDQjsesmvBOAVP3usfOESjFIGrxzp4gvM+BPW0n6UdePR/HpWBcSw/PUBEN88amIagSdPZceEUYU74A2wMoVK6Mz58llX1ast0mNHyVaRye4caOC/3Gt5DcBjjpQL6PvViKHkiPA6yy6wpvKfnDytAMnLMJPUj4PQIgEWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872320; c=relaxed/simple;
	bh=5snos77sT5IKCBiJqYMEMi6rYk+RsVOYEVFpg3CanSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I5ss8EuLs8f75HykBG0OX2czDJ0kODbi7uWhdc4DHcBiiW5DI4Y2jmjA3pbcCkp8UyMm+ovPY/5/v8jsZINvgrY5e6s3dUVl12xdHQkRSIo4UuC9v0NZaQHoNYjH1LwHLpkvBL8RDJAM+FlwtEw/aA/+QAqok+od64E2biN8838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jeo845n8; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51ae315bb20so3956285e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713872317; x=1714477117; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dK2K0Ec0XFCkUmGU77ZbWU+vJ4ynVXyD+Przas6R5LE=;
        b=Jeo845n8KCZHb8QKv81btIbw1Gqy7fbT3mfyBFicLe7EBiby5zzuZF8PKvn0DBFIrY
         TpU1+fGx6p/q7adMJtU5OUvptqJ2NWFYgwEIXtKUugv+SchmoyhXgnzHjwpSL9ItCc2e
         1bbgyk9mee6rIYDNckVC7UJ+MRvEJMeN8TqJxXZ1rpbzYvK4aWVWc662//PyjoiyWy+H
         8JazI4oFDG9PIuc2XQ9RJU+tAD6iL8v1/0nwtwbg41waM7JWrmvJ5dY22WI2WGEH1B6a
         W9W7rBQ4wc4iZivQHdk1WPtgPHaPqFqOyZ5Ce6/V4sXXez9rggVOWUu218V0wnLvOIQv
         PYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713872317; x=1714477117;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dK2K0Ec0XFCkUmGU77ZbWU+vJ4ynVXyD+Przas6R5LE=;
        b=bAZVWvKgr5Ssy0C4jqhfVIvoY9NGGy1ddxtuWwFK6oos+yDERz8yw3sOVUAJFuFlts
         gALqfuGxteZbzxPueDZN6RvTnN0LHwO5Vu5cAGlwOKNX8cGNLzUq/51d6f4IZ6KA7mCS
         2NAv477JfASbNF+y+zI9aUVmZyPXZz76D9kffWNrBJGPNbzver2FQ3wz8Z72RSW1g+GN
         LZGxe/TJBod2+I116Ya3VtnJuEZkyD9orZ55VfvrAJahO9SvXhnDnr4my2NjeoGIYsWo
         xp5Xg/j1XpsFky3D/NvYPVy/Fo9iIln5ybpHTce9vAIsfYU9qg2xh95sOI9vU91JL2WR
         UDiw==
X-Forwarded-Encrypted: i=1; AJvYcCUQwCluZXvWlcrwz/S/BWdjcMYlywCHmFNoIytwUUYx9hwW6g38Q2Azzm9DnaFwpIPUSiGsvjXIVzM3hcnUraxIf+IM7M6AM2tbW34w
X-Gm-Message-State: AOJu0YzpcUbqfC4AdRh6ZQnGaH8DVH9PtmVm33jDuqYTe9/D/l7yqPhT
	yzuehMp7rvU3/7B0RA70R/+F/dxsCBJ7fKFf8MdsXpiaOqeCaV/c
X-Google-Smtp-Source: AGHT+IGhkUDcxwekDLG636CsR5CavWyzPZqFgnF4lngyrbsB/B94L+H89ZjPybXpuNJRTFHw/Xo29A==
X-Received: by 2002:a19:8c5d:0:b0:51b:18a8:4cb1 with SMTP id i29-20020a198c5d000000b0051b18a84cb1mr4959810lfj.27.1713872317044;
        Tue, 23 Apr 2024 04:38:37 -0700 (PDT)
Received: from fedora ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id fc19-20020a056512139300b0051bbb93e7c3sm64393lfb.194.2024.04.23.04.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:38:36 -0700 (PDT)
Date: Tue, 23 Apr 2024 14:38:28 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org, Aleksander Mazur <deweloper@wp.pl>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] regulator: change devm_regulator_get_enable_optional() stub
 to return Ok
Message-ID: <ZiedtOE00Zozd3XO@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a/a7yYptJJkqZKWb"
Content-Disposition: inline


--a/a7yYptJJkqZKWb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The devm_regulator_get_enable_optional() should be a 'call and forget'
API, meaning, when it is used to enable the regulators, the API does not
provide a handle to do any further control of the regulators. It gives
no real benefit to return an error from the stub if CONFIG_REGULATOR is
not set.

On the contrary, returning an error is causing problems to drivers when
hardware is such it works out just fine with no regulator control.
Returning an error forces drivers to specifically handle the case where
CONFIG_REGULATOR is not set, making the mere existence of the stub
questionalble.

Change the stub implementation for the
devm_regulator_get_enable_optional() to return Ok so drivers do not
separately handle the case where the CONFIG_REGULATOR is not set.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: da279e6965b3 ("regulator: Add devm helpers for get and enable")
---
 include/linux/regulator/consumer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/c=
onsumer.h
index 71232fb7dda3..ed180ca419da 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -326,7 +326,7 @@ static inline int devm_regulator_get_enable(struct devi=
ce *dev, const char *id)
 static inline int devm_regulator_get_enable_optional(struct device *dev,
 						     const char *id)
 {
-	return -ENODEV;
+	return 0;
 }
=20
 static inline struct regulator *__must_check

base-commit: f7638784bd0cf2ca9daebd47477983811f832300
--=20
2.43.2


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

--a/a7yYptJJkqZKWb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYnna4ACgkQeFA3/03a
ocX+qAgAiPOBscYJavats98gQBtIV6ZJc5p3lKHXLM8NTeSB5Tc/3RYVPvqzTd1r
0OGpl8SygzCIpGVTshB3PLoH/rieTtMzFsl6D3JqLj06HzeUsHGlBVKsIvDW4CCi
APEPuDdOqnoGTY6j9U4Eo7tSUpa20lF7tTYdj4CabDadEucsve2MehDRA58KHB+O
xYn0JbSTCNybSKFgSxYk27b57cRmQPTfhPhcM1k75Xevkb3GWw3RLTpGqy7IRLRY
OJOaRpVHo31RXaVLtlnS2OPGrazd/W7AMpbObNWmPQ0kopiSfK27ORhwQWTehxEP
1Q+G+SD5CBOyvVJtcr+YYxrCN2evIA==
=Z+IN
-----END PGP SIGNATURE-----

--a/a7yYptJJkqZKWb--

