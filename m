Return-Path: <linux-kernel+bounces-152793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7BE8AC44D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07FFA1F21507
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A800D481B7;
	Mon, 22 Apr 2024 06:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBQKCjb0"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AF11391
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767929; cv=none; b=kfzbyq6ga7jzrZ2sFc/ngMlk/h7iMYSXP5nYQWWzIylkXgVFNBg0mhF39jbgs/1r0YeML3Cpw+T5JGJbkqu0spOJbE9F8IJCKI2UJZluImPBjvgqyFTM20qoNlkvA0SJ7MWBYeHccDzEgUOhR9psQ1O+MFH/Jgd1a0jq3VF6BcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767929; c=relaxed/simple;
	bh=3eQW+JNpbvFE+5C8YsW1ZzfW2vusQDIloy15dafy2jw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pBZF4Mu6VpZY4MXQ7SarxttYbxkmdUML76BLQOMWOD724rW6vXEfLNBcDYIw4Es2bUd+orUBs+KJv2hMJab0GHs+vEhm1R1Mnq/xfOBcb9/sg5kXruL6DbvnmWHXMfBg+Jtz/s/cYY/G3dU/rk2k/HcSwkcBWh1Y6admlJCO0gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBQKCjb0; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51b2f105829so817094e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 23:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713767926; x=1714372726; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mdXybib/rsP3+c4KKXP0fc5K/LdPF+bB0Lufl7Ur8Eg=;
        b=kBQKCjb0++sViXNz73TF4huQDPJ5nxeom9DCOcvIVQzZO37QR4NcomvaDPaZ4wKX0E
         pH4vU5BqhNxUdvY4ewKyoq2K5w/tJ55M2JFAWVKxV3TPwYrGOHdTknrKcOwzaJ9txk7d
         qBvBhZ6+RmtsC7T8fA6CT1O9WLWRJ4Q4UGFT9hbiQ6zmdldngM/jbmoxHylkkU4nbvwD
         7P8Ozxc+1NTNdDgl8Ueb+qxwynLgDvuX0m3wzTZ/xciMU+AYRSiadIsmIBYYQc3Me35o
         ioNDLF711iDGEfDjA3w229gryR5E8d+i1BRTowiwx0VeHohFI7DODDM0bu/QH6pEQfDK
         3Www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713767926; x=1714372726;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mdXybib/rsP3+c4KKXP0fc5K/LdPF+bB0Lufl7Ur8Eg=;
        b=ZrjjqKmv2JqmCNcbSEOyM15Nw94w4FP5tOWLtUAi/QPpFiju2mzWS2iyBKX28dhoNY
         zQZHaHWWaX4UfmFJrx55ZC2a/ppTi1zSH3ltgN1T+4DJYUU1wBI6cNIDr6STgGnrXiiA
         GKK8DrvGEC0RkoRXAgDSDFzVYx7I3twGCKlK9wrSXLT2LnYB2p+kIdkmU6Wr66HRRNrU
         Unn6HRCWvQzuMI08lRz6QSWAOM5ohC1gR5zAuCEMpqlvR9MCtH61l+d5ochfuoHL9PTr
         uqKq3n0RtdcqMWabyn+65gDO1Q/rAuZW3nZGKXx4tlaOU45C477NoQjODw0MgpjvMPgM
         ZzFg==
X-Forwarded-Encrypted: i=1; AJvYcCVET132U9vYyiITww8s9m2vSgKSNO8YZIDXOxGSCjA+oANdzLzci79lpvKmbVuOWJQa3qMq9+kDxI4G90GVrHfF3Am8Aq1Uk4J9KQm3
X-Gm-Message-State: AOJu0YzLL0IpOnqCQJWYK3wz0MIo3jOfrsX9ZIywfzVmt+pFkhnFvFAm
	B+ucuByn0rnc+KtS0KwqhXQd7pJ5R0x50Tj+Nqi1xltIuhVMDYt3
X-Google-Smtp-Source: AGHT+IFeviXI2RBoP8XMcYaK4j1Du+RsTExn5h7JLItyBTWhu6sHhs9IklfIzCHiSdd9GX8JgKjEUg==
X-Received: by 2002:a05:6512:159:b0:518:b283:1078 with SMTP id m25-20020a056512015900b00518b2831078mr7445735lfo.26.1713767926068;
        Sun, 21 Apr 2024 23:38:46 -0700 (PDT)
Received: from drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi (drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:7426:df00::2])
        by smtp.gmail.com with ESMTPSA id g11-20020ac24d8b000000b0051b5efe5985sm73646lfe.255.2024.04.21.23.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 23:38:45 -0700 (PDT)
Date: Mon, 22 Apr 2024 09:38:33 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-kernel@vger.kernel.org, Aleksander Mazur <deweloper@wp.pl>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] regulator: change stubbed devm_regulator_get_enable to
 return Ok
Message-ID: <ZiYF6d1V1vSPcsJS@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Rg411aW/xVskvZh1"
Content-Disposition: inline


--Rg411aW/xVskvZh1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The devm_regulator_get_enable() should be a 'call and forget' API,
meaning, when it is used to enable the regulators, the API does not
provide a handle to do any further control of the regulators. It gives
no real benefit to return an error from the stub if CONFIG_REGULATOR is
not set.

On the contrary, returning and error is causing problems to drivers when
hardware is such it works out just fine with no regulator control.
Returning an error forces drivers to specifically handle the case where
CONFIG_REGULATOR is not set, making the mere existence of the stub
questionalble. Furthermore, the stub of the regulator_enable() seems to
be returning Ok.

Change the stub implementation for the devm_regulator_get_enable() to
return Ok so drivers do not separately handle the case where the
CONFIG_REGULATOR is not set.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reported-by: Aleksander Mazur <deweloper@wp.pl>
Suggested-by: Guenter Roeck <linux@roeck-us.net>
Fixes: da279e6965b3 ("regulator: Add devm helpers for get and enable")

---
Please find the report by Aleksander from:
https://lore.kernel.org/all/20240420183427.0d3fda27@mocarz/

This patch has not received testing. It'd be great to hear if this
solves the issue.

I see the regulator_get_exclusive() and devm_regulator_get_optional()
returning errors. I thus leave the
devm_regulator_get_enable_[optional/exclusive]() to do the same while
wondering if this is the right thing to do, and why...

---
 include/linux/regulator/consumer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/c=
onsumer.h
index 4660582a3302..71232fb7dda3 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -320,7 +320,7 @@ devm_regulator_get_exclusive(struct device *dev, const =
char *id)
=20
 static inline int devm_regulator_get_enable(struct device *dev, const char=
 *id)
 {
-	return -ENODEV;
+	return 0;
 }
=20
 static inline int devm_regulator_get_enable_optional(struct device *dev,

base-commit: 68adb581a39ae63a0ed082c47f01fbbe515efa0e
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

--Rg411aW/xVskvZh1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYmBd8ACgkQeFA3/03a
ocUbigf+Or1olindwWniGUvsvKbD2+e/Py0Q8NabGsgw+6C8v9v52h3ljswHSNpD
mUcbz8n3TOYj84NHuj/AF85fERwLZS11KpCZirE8uKEPP4lyegQ9WcS/0ELuku8j
lmT2RyFWQr5Y81fMRiO7/tllHSIWgluBfHDIpEYYkClTyXku4eQgAy6UV0EnMHDR
wo9fL2SX7Okf45y0+XW4CdOHFQpo1BVTXu4SKaotPEcvBQMNArjmWpZzG7lOCnmz
iA9oZxqYGPPVf3p9OFKWFMDJaJ2wZpOIZmJEz0jGGPQU+wwwceTmszI+hhZCF2N1
8kZ6IF0mnNCn7InzsWOdvhxm0P60gw==
=bXwe
-----END PGP SIGNATURE-----

--Rg411aW/xVskvZh1--

