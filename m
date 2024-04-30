Return-Path: <linux-kernel+bounces-163886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A92B8B753D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD421F213F7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF5213D88C;
	Tue, 30 Apr 2024 12:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PP/eEPCw"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C82D13D267;
	Tue, 30 Apr 2024 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478538; cv=none; b=SyQjB4TcRX/WAMfW080fdcOgJ6zhO5S+ETSzzOZeEeq4ptWPyPH076ytBC+jv1VQ2LK9FL3dBJz0WGG0qA3SXaT0keTlDrczwe3sqVqAgJNIuJiRLyA9woBc23cRqFgJV/2kma7thjzb3sSpBrcAZUZ+EGf80dxhDRzXN0nl3vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478538; c=relaxed/simple;
	bh=79UNfhj2pKS3elAdRYb+cWvVDbeO+ck0Bf+XlOj7T44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3JnXU5ynd86evalACIAKB0QPLb3rK5XhP5eyq28Prav1jFyQDNEUcsli18RnzN7ARuv6aDwiPiBUZnmzyglYPBFWmiV9OhqX45QeNsP4GedQOwpx+RLWBPSZQO2bKhPs0hCDOVk9MhbpZGkTqfNkAPDDpEHpEZXo01YccwN9g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PP/eEPCw; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51ca95db667so5240485e87.0;
        Tue, 30 Apr 2024 05:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714478536; x=1715083336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zox/qmaglXo0HD/YN8voWJNp1dns8XrdzThPKzYbfYs=;
        b=PP/eEPCwefkzMAxI3m34BUPZBGkPJX6Esd6qK0EyholXhUf0DGH0zdSNDrRi6hajB6
         NcO8O9wPlhO9O27BtgHItwFrOAn1ybAIgXRza9KypD4gC7nwj/7o40lT08XcBOxJmp0j
         vvxSnhhRzroJ3dvO9qTvXEQnTB6syElH1AB5obgj31cAoCBuT5mFShgw+SNVEnp21Niu
         M/vf5iFluGKmRikvvt/mYwyCzb47CYoLPkqfNOYBsayfKYHW2LkOAxHUBJgT6rwpOdZ6
         V7Z0R5mVGzhttM6fnoRcIiJz341bP5XeG3tAbPgPMvHQt7wdqlHKm+9I1DpcqXevxaRu
         uk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478536; x=1715083336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zox/qmaglXo0HD/YN8voWJNp1dns8XrdzThPKzYbfYs=;
        b=S4t3W07aXMNDyscadSR7Tulf5yaY7LoQp6YEif4f/zmpGQEx1uG7e092WIsJ/X6A0s
         V2Thgovbq8LkrlPZswXrNOVSaddIypANcgYzzifWwT4rW9+YtM7V+UcY4sgPrEdiWR3/
         z848qdrbLC1oQig8UArC9RtoOMPnWwgU6QgjaqpZK746QxaNofwaqY9NXGK/CKo3/gh7
         0KRvRgkNe62C0DigljNq9ziFNHM+e6CSdD3LzQkEZGUsOUK+mG/o6Xl571Rxk5cGJrqX
         MLvSVJfyWVpyd+4okUjyrns0KGJtwtZjxjkzRmQzFT43aisKFNRL8BU2EtRX5U5GpJxn
         subg==
X-Forwarded-Encrypted: i=1; AJvYcCVkrZmOQZBz520hfFDItjCSqrIrpb61Angg3ELZHIp97NtoiI5ZC1p1irT9kr9o4fwBJEnlctkvkv5wmjTDwwqBn+PM/93twcGH9CpxuOLiBh7qJXRAk7G8Q5EmJmCRHZvo5ZGo47rpl7+xRpv4Ncvt/4UM96sgxvCWITuvjwq93p04RdRlihsz
X-Gm-Message-State: AOJu0YyXHY3+nEracrL27qTFk3SNOiykWV0ax3s9+KK/gYun29glGlmH
	Al83RJxXJTN8qFl9APuKuZrlKAyxy8p8zSc2WbmzvACUCy/aWzfw
X-Google-Smtp-Source: AGHT+IEm3BEi0uEfxCxsS46zHZU+iHIkKBDuGFJu0IExFYzQtNGkHdUxuvrOiz7C2B6tfd+FYUZPSA==
X-Received: by 2002:a05:6512:12cb:b0:51d:53fa:6530 with SMTP id p11-20020a05651212cb00b0051d53fa6530mr8597982lfg.28.1714478535490;
        Tue, 30 Apr 2024 05:02:15 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id v4-20020ac258e4000000b00516cba5b4cesm4479734lfo.46.2024.04.30.05.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:02:14 -0700 (PDT)
Date: Tue, 30 Apr 2024 15:02:10 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v1 6/6] MAINTAINERS: Add ROHM BD96801 'scalable PMIC' entries
Message-ID: <e8d27104a7c673c87583557d2e40139f2908eb01.1714478142.git.mazziesaccount@gmail.com>
References: <cover.1714478142.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DwNfJbWB549XTXxk"
Content-Disposition: inline
In-Reply-To: <cover.1714478142.git.mazziesaccount@gmail.com>


--DwNfJbWB549XTXxk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add maintainer entries for ROHM BD96801 a.k.a 'scalable PMIC'
drivers to be reviewed by ROHM people.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..da68144d51ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19111,17 +19111,21 @@ F:	drivers/gpio/gpio-bd71828.c
 F:	drivers/mfd/rohm-bd71828.c
 F:	drivers/mfd/rohm-bd718x7.c
 F:	drivers/mfd/rohm-bd9576.c
+F:	drivers/mfd/rohm-bd96801.c
 F:	drivers/regulator/bd71815-regulator.c
 F:	drivers/regulator/bd71828-regulator.c
 F:	drivers/regulator/bd718x7-regulator.c
 F:	drivers/regulator/bd9576-regulator.c
+F:	drivers/regulator/bd96801-regulator.c
 F:	drivers/regulator/rohm-regulator.c
 F:	drivers/rtc/rtc-bd70528.c
 F:	drivers/watchdog/bd9576_wdt.c
+F:	drivers/watchdog/bd96801_wdt.c
 F:	include/linux/mfd/rohm-bd71815.h
 F:	include/linux/mfd/rohm-bd71828.h
 F:	include/linux/mfd/rohm-bd718x7.h
 F:	include/linux/mfd/rohm-bd957x.h
+F:	include/linux/mfd/rohm-bd96801.h
 F:	include/linux/mfd/rohm-generic.h
 F:	include/linux/mfd/rohm-shared.h
=20
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

--DwNfJbWB549XTXxk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYw3cEACgkQeFA3/03a
ocWPbggA1DOQEhF5jDsmIciK9UdDzwrr+OWE/aRtufuahdexUKICIldB1q4P2GcV
O9S5ws0EikcsPbkE0j0qmSTF3FIj3KhAFSkq5YeyYxHYMxxLhGidoapGcN5mcGOw
99FEDVsWsE28UE/0MrY/y0TSA6clVLw3bQaIqZVpmS5N1eMqZ4z0I/m5UC6vRfkH
faobCFXzEvcxbqv6RJ7pRhCuVll8zmkAKIL5w0GRDuBEuPW9qq7mfsUD0px3YECy
Bdv5r/uyx6sdS+UozfGvk0Mh5uaHlDFucSDV9diICB6P9v2LaHiR6cTyH73JpDBY
TtD9vdoak3cZm6FCEzieay8Lg5Db2Q==
=s5kO
-----END PGP SIGNATURE-----

--DwNfJbWB549XTXxk--

