Return-Path: <linux-kernel+bounces-142570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C8D8A2D46
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3B51C21633
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F5754909;
	Fri, 12 Apr 2024 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EykO4KXX"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A96553818;
	Fri, 12 Apr 2024 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712920994; cv=none; b=spU5JWoXz2ncYB0KqofRT5Q0lVYyCyUPpAgFWpRCFgTu6LFq2pzAQ5Ng8ApIBDPtCKKpnPzKDh6PPFVtJyyBafF/WIyu2PEuU7cPV7bBDrGaBpgMpXbBfBPZAp+Fbof8ZzdMeS+UCfVVsO/tFFygZCLdZd0qI9jj4nQo8FdlAL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712920994; c=relaxed/simple;
	bh=a9M/gu3pAy2n5mcrasvQkpNFynhe8TKuVL9zcive9Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sg41PMCL5wvPKGKjFQJorgH63maWuhGOMC67KVsCZ+9GnXS2yONe1ZK/KdFVr5/3Ojc/4ebqdRTzBpgflZxZPU1KoU2SV7pt729mK0/JbV/0HSPWTUSiK0Z90YKwZAG1JrwJkA/D8nH8SQ46OZZBfd18SYdmdWbZ7rSjpsG0yEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EykO4KXX; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516c403cc46so1790856e87.3;
        Fri, 12 Apr 2024 04:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712920991; x=1713525791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0jicUK9LkpQaLVtzXkAJ5ok5FiGG2jpVgJdbfYQvVc=;
        b=EykO4KXXqq8oWIqu3ME/Gx5KWGjfWbG5njtmGn72/Ds4a6dTGo75c5HJZ4ruEvbe7N
         jJBoGwQ9Lr0pBDE//yygS0DlfBJ+VhCKHas5XOmS6ahBpV8dzuh/pVIrz4HPU6MHNJH0
         XJG4NDgUxbekxIhq8T2Rj5qBL6fBjdD/gNprtBkaGrzqxeou4et8DuREcdfV8s8mUId3
         GylEM7GccPbxQ9n7wqTOIHpu2AvZO6UXBxX8H6SHGgtdWfAkt9uLplZVNqF9sOpAAsOV
         wrskUin4ACUk7V4ZNfiFp3FHw6Qo133m5Emp6hJ4dyOsYwcDWbPzs8fiK94Ha6oZxnrp
         ApQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712920991; x=1713525791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0jicUK9LkpQaLVtzXkAJ5ok5FiGG2jpVgJdbfYQvVc=;
        b=D1bEPCSTmKktCm90BBXa3y79SXiSZ5yJrO6hXsmCTWMO5IAIs1AxzjjaXzZd/054cW
         YKWqv3QpYtMHt3yMiiVcbC57w37AZXz7m5jZnmD9i3cB+d3AZHO21MkumdVlciODVoxA
         paZ5Hm22JjBFWGOVZmBARe9PprBzHq3u6Q0vIBMhbUbcBAObcKe24+g6i1vIdNxgbSGM
         7Yo8PqT9eSrrZ5wl/M2nFcVL4PJ9Vvu9H+1HtGSHz70tfxqcrdufIKmukDAt5eK31C9V
         OC4baXYG54ENeFymRqQ7p0Gvl5rueuAHradV1K0mhLnxgzl3vPvdlpeBX35+vBlF26Q1
         juoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWI0Uppu2W2C9640FV27TZOts5gY4pMDNDdCCeqGMOIqIjah1zJdQT6DslHlZYf2dxbn/KNYjNsfa0xph/5Yp904t6TvxfBTOKV/uzzEIKl0wZZORoTOXIlbv9f4T3hPvXhDX+tuznmrKnBm878/BHG0TBeeJWxYkl83r8xiHBEywEwJjo8XQY
X-Gm-Message-State: AOJu0Yyv5bI/MYwo/aSB9k5Aj02dwQg2422r7f2/Oceo+0kcxYUut0lH
	YCEtNrmDvNh1rKZV8i0eMsGYDO/pdyVT1lExzgy5t/rQa5XTVXwV
X-Google-Smtp-Source: AGHT+IH3hk6YI71a+b5QKkkFagxhgPvY8E1Ck13o3Ae/ZFEkucEOWbrkXOIcHZzgfu9zNbyarGkErg==
X-Received: by 2002:a05:6512:b94:b0:518:902d:8b98 with SMTP id b20-20020a0565120b9400b00518902d8b98mr936829lfv.18.1712920990628;
        Fri, 12 Apr 2024 04:23:10 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id o5-20020a05651205c500b005159fb35a9fsm503595lfo.38.2024.04.12.04.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 04:23:10 -0700 (PDT)
Date: Fri, 12 Apr 2024 14:23:05 +0300
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
Subject: [RFC PATCH v2 6/6] MAINTAINERS: Add ROHM BD96801 'scalable PMIC'
 entries
Message-ID: <19eb66e110b3cb52953772635d2985dbd52cacce.1712920132.git.mazziesaccount@gmail.com>
References: <cover.1712920132.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zcUGbzVjlD3upp5s"
Content-Disposition: inline
In-Reply-To: <cover.1712920132.git.mazziesaccount@gmail.com>


--zcUGbzVjlD3upp5s
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

--zcUGbzVjlD3upp5s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYZGZkACgkQeFA3/03a
ocWiSggAqP9OSkx90CQJyBT0kLNpd1RYnvYAIwTHH/boyFdEruKfkQ3SwdQRFDXm
1G42rEQ9DpvATIaNbz15nyD1j2swWxrXZ8wK+Vo6X/DWPXKbWfQbEPgPs0SytWwS
gRLgAxHyc8L2Tcgsy2CUurHIhL2XG7L2IOiUINdj1aBS7PmewUQDwrkpe+y1gUtA
VeK7ObeU9eRZfBpLXpXbazs2xxbaqxwvKaHHShf122BNaa2t/rLs61OjjhSQs/N0
uGuLJsUaQ1cTGR6GV3GGfLdDHIv056WPOXGyayGcnx7D3V+uB8KZEgh12VoCSBiO
jborjCSmw72/flhRsFPPvM+LjglHmg==
=8Ahc
-----END PGP SIGNATURE-----

--zcUGbzVjlD3upp5s--

