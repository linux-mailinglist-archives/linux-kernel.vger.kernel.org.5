Return-Path: <linux-kernel+bounces-128011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E928954F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346AD1F2289A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFA112BF23;
	Tue,  2 Apr 2024 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls5/sca8"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9620B7F7E2;
	Tue,  2 Apr 2024 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063551; cv=none; b=PG5tIuclzlB7oB/qxus9W8F8PiWb1oIlt4p6hfifDBaNnrhK2VCxo4Wq3c5YQPfy6AbDGEnLDYomcBVf2Uqq4GAW6S7qy3W8k7UH4xiXqMUcQ+Umo9VpOmjmlPr0Zw2Ciow2tloo40ATAvj2MtpoQGzrAUWRS9+IfCFCAxIpWaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063551; c=relaxed/simple;
	bh=rdYQ1tLiYUnvXITLv6FeHGjCDGDhPtd8nFVP31fy3W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5iA4JB8+xnNbpTJazf6PaxnmyN71jLEKCMNO8Uiv4JurvhWQe5afRNhMPk1IB3U9CP1VNkXs39PYQ30cBteDaf2dj6M+CL8cnkDrgyybGUf3kLaU7CMiVlEDo3uq9vsRPwTuHZYEUFVCzmGzOObd9Lcd6lA4IAPOQCCwL31kjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ls5/sca8; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d6eedf3e99so55477261fa.1;
        Tue, 02 Apr 2024 06:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712063548; x=1712668348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GfODrnl3+hV/+cwg0ntzklh446wLZuqf2PwhVeXC5as=;
        b=ls5/sca8YbkdBPRiVAorfSxMUVlq8QiG41LlNzkzPtp9c071LnTGKYd1nyKWhrL/nz
         uoYpcjSMJE5cvKhaj4Go38aft5NPpPlZ51gJyTdhp0+Val0deuQg2A8MPCaG8qVkFr6u
         wbesDAjwGGK1wO+X68cSmvhdnhMJ3L5wFWSK7LNbbM7eBYi5ThsmZpV5NaRK1tJEZZsg
         c0J+Ez/kUbUTTUq9diSJatrjFX8/TDGQUEsVRktKqaOsOyITj3CXfeALKzWvEsI34LH5
         JPK1cU4OQbIkgYuto+DBCpZmW0fcMjQF9sdSc8MnCg8fdcPA1Z4GxRQECMJ16wEpRUY1
         yQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712063548; x=1712668348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfODrnl3+hV/+cwg0ntzklh446wLZuqf2PwhVeXC5as=;
        b=Qz6s5Eqh0yToC8ciz5gcYI4oo21pfInvvXWfq7sY79CP+B7lkP81Id3/+XlpbpWrFj
         S8jU5ycmRs+A9VcDSLQIFPtJv/UdKu0PcI8BFegVRY2QAiH0YQrJfV8N+JcGbMIDH7c7
         yDkMaL8pQ/NZuTapKAT5sclH8ocObziWV7g1wWJnLHlxYY4I+6Pdp/eGt1m+e8gCHWKR
         m9OwQnwKw2ETwjtc5iApPCnIUwaD75HsQvEq7vAoRQpbvmKovkuLoHjZk1dDnimleTb5
         7cBJnfzmqSCOK73ti7+rzo61PsSS20jDV+AAdFGsBRQ87ZaMsnRTnM9PzdubaInnEkHz
         6rSA==
X-Forwarded-Encrypted: i=1; AJvYcCWN0l0lgNDQleNRF6QPzuLQDr+xUWFbDStV3bxWNbEyw6bz8xS8i5YKoDE92/YCraMOb2wpAzcv/KCbcKv24mjWq92hmH7mRBb3fRnPbLy8xw77+Yy6xnfRJ4wSuVl6eiH/0WZd5vViiiaGQNN+KvIW0RpkGDswyWIu+GYK+vFg3x9H+eKQNdVk
X-Gm-Message-State: AOJu0YwMQjK3B5tn1l9gFkDRInNlSGAk9LJ4Tje957h9GUCXkOKQuvP5
	dOvQO8fS3pGhYiGjVf13nGqSyPNQxAcGnvVjTutljbtl91/Wmp0L
X-Google-Smtp-Source: AGHT+IHil5zfXpzDtXZRyO/D7ctaJIo//4eP7a5anXPeHhBTKHdx3X03nNzdahB3/3IZYx8c646WCA==
X-Received: by 2002:a2e:b710:0:b0:2d5:9f6f:1df2 with SMTP id j16-20020a2eb710000000b002d59f6f1df2mr5545712ljo.0.1712063547308;
        Tue, 02 Apr 2024 06:12:27 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id a36-20020a05651c212400b002d8275474f8sm220244ljq.69.2024.04.02.06.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:12:26 -0700 (PDT)
Date: Tue, 2 Apr 2024 16:12:22 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [RFC PATCH 6/6] MAINTAINERS: Add ROHM BD96801 'scalable PMIC' entries
Message-ID: <3169f1d8b1833b8b94650a19aecd3e1f92fb240b.1712058690.git.mazziesaccount@gmail.com>
References: <cover.1712058690.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fzUcmCWvBEGWDcu7"
Content-Disposition: inline
In-Reply-To: <cover.1712058690.git.mazziesaccount@gmail.com>


--fzUcmCWvBEGWDcu7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add maintainer entries for ROHM BD96801 a.k.a 'scalable PMIC'

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

--fzUcmCWvBEGWDcu7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYMBDYACgkQeFA3/03a
ocV6GQgAibZabRDElOaw8UmgO6U17HLGB4QmOyLjsNe4f/n7VykGLs/++Otz9kfE
q3RjmBj6cC8S7ZsF2tVmC2oWOsKPV4rlHYMk9O+QpZI4WfRBt+StrPz8LeqbXLyB
Bz0YD1bXq4Y3q4zPoCuEE6NM16avm65+CQvV9HQ6cVPfqB9KWJKBscUBUbB1wFxS
Ki41/OguvXsdbljrN8b6SyOkw2mLk1dDpwGLWwP/tGj8/TduDUN1on/CyrfjCqB3
O+m9CFaaHaBSZUIjTnuvi0CM+yyQ1TTiV1LjgO/InMUMgbylQ7OfcdHLMVJyxWgd
UBUEZu9eC229IRiQhYaQ5I3Oe3/B1w==
=y4I4
-----END PGP SIGNATURE-----

--fzUcmCWvBEGWDcu7--

