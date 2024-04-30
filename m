Return-Path: <linux-kernel+bounces-163879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C5E8B750E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E26A1C22207
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E930113D272;
	Tue, 30 Apr 2024 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTCW/av1"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813CC383A5;
	Tue, 30 Apr 2024 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478373; cv=none; b=g6hAC7U1hWuRNo+qG7E0Us+2DEAmo57VQOwYMAH4TFv1nCQ4UaRv+XQu4cV9ag53txNIckO4WF9BACP2GOqI6IVkO64gy5J4t9E8/QUFJrS9Xq8eSyVh9E+Jd1FliNQySkGJGXth48IW6LlcanWkGuJi/9nuGnU+IhKm6GUrbYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478373; c=relaxed/simple;
	bh=O5E+OFHwPyDQM79u7siSM80Go0hq0dHphcFXG6dxOKo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VuzvTawOXoqP8eUwYcWmuVFYsUPGMLadCKoCt0EIeBd82B604nY6MmX/9KtdoG4ftaTklHPOQRSK/FwAbsPs6ykRoeU1GdEzlc6KKQhk+z773kiTuukTVw7BdodLTINzrhVPdUpl0cK4jb730S51fHm4kdD10sgxN83TYaNy6W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTCW/av1; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51ae315bb20so6886617e87.1;
        Tue, 30 Apr 2024 04:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714478369; x=1715083169; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s8tGOSAl/1tF5oYYz2CQ/Rtt4a4nGClsd0EYlRKY4BY=;
        b=PTCW/av1vvrjzewn9ne6Xu/SC3AjelWtuTAN7PijC0g+VYHqTvuWTyYBGFRmHEMKa9
         kFeBdSCWOO4xwe/GKqbYmADSYhPJUZjYp+uZ4r67SWys/4NLwTapinyjnD31aARKTfo7
         YR9RcdZ1Vf+mu0pL6LM78+L1W7YmVbXXEofUzuPJmKMBykb5J1bidoUpxHnK2vXebDuv
         iX7Y7a27EtJzjdnFNdZFUE3AyHYMBdGgWd0rqTJI8YVtj2ujsQ9u4akhmLoS9JKR67LE
         ow3bTcfdNLHsUs/7EKfyH7K0UQ4AOnGGoVOr9xTfdr9MCfHSyZDgPPsH3pU4nPnoV79e
         5EuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478369; x=1715083169;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8tGOSAl/1tF5oYYz2CQ/Rtt4a4nGClsd0EYlRKY4BY=;
        b=ojhRfgG1xjtXiHcTCsxBa1MJuH/IA8ZGwjOD/UMlfHNNZN1G6wUX/XEirAhVT97aa/
         iGfBitKJIPBHqN+xUI78SXhQgbqC0NKtr5RyUfALG30QYR6Ubk7f0MEkByfehZKhKnJC
         RPpjFBy3nush+VzOyudny5kVFtcsznidCgtcez/8FMclUB0IGYmSr3ESB1nGC3MaIXHm
         YZNkU03jKOzkWncAo9rmE0lybhwmobBpBehTnIElIyM4rG/oT8t7zvqQKio9vUDbFlji
         rvxXHcIZoOv2w7y0Ad4zhNfyKCt1eRbyZYWzsZj5HKY3K/0SCPdPArmManNXlsCFo7xz
         3m6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqDOB4ATynpzpfoznG/ID9ztDflLynM1/pGveXXzaiBepUManSHH7tEuVXYf3qYHdl7apyItdAmR2k5Rf+py2l9KSqfOCDf8i4FLH3nO3FaeJKryWcJK6NwcNxN2+kTEx606XT5BgJsLj/p/FUfh297veENNzsFsfLQnp6f59thwWdPq5kEF9A
X-Gm-Message-State: AOJu0Yy16D9IQ8JAe3WPEuvDLNvKmMsUYqq1tTTZAlrbYXHG/TniiJ/1
	3NqvhuLQ4pvlyr9TE2aK7bGk7LgMdAYBtH5UfoLQ+QmvzqqHkvDf
X-Google-Smtp-Source: AGHT+IEbxazFlKpHGNMqErv25svZ1rKH2eopi03XEXJfphoB4IRwKuKJNNTa6GyzO6+pk7CRIzyBCw==
X-Received: by 2002:a05:6512:607:b0:51a:bebb:690c with SMTP id b7-20020a056512060700b0051abebb690cmr1640215lfe.12.1714478368496;
        Tue, 30 Apr 2024 04:59:28 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id t12-20020ac2548c000000b0051da2c1d214sm794104lfk.305.2024.04.30.04.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 04:59:27 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:59:18 +0300
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
Subject: [PATCH v1 0/6] Support ROHM BD96801 scalable PMIC
Message-ID: <cover.1714478142.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dEAgTGpokvAR9IlE"
Content-Disposition: inline


--dEAgTGpokvAR9IlE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BD96801 "scalable" PMIC.

The ROHM BD96801 is automotive grade PMIC, intended to be usable in
multiple solutions. The BD96801 can be used as a stand-alone, or together
with separate 'companion PMICs'. This modular approach aims to make this
PMIC suitable for various use-cases.

This series brings only limited support. The more complete set of
features was sent in the RFC:
https://lore.kernel.org/lkml/cover.1712058690.git.mazziesaccount@gmail.com/

As writing of this there is no known system using the ERRB interrupts,
or doing configurations which require the PMIC to be in STBY state using
Linux driver. Hence it felt natural to upstream only partial support for
now, while leaving a note about the RFC series with more complete
support for those who may need it later.

Revision history still tries to summarize changes from the RFC for the
reviewers.

Revision history:
RFCv2 =3D> v1:
	- Drop ERRB IRQ from drivers (but not DT bindings).
	- Drop configuration which requires STBY - state.
	- Fix the register lock race by moving it from the regulator
	  driver to the MFD driver.
	- Fix watchdog timeout handling

RFCv1 =3D> RFCv2:
	- Tidying code based on feedback form Krzysztof Kozlowski and
	  Lee Jones.
	- Documented undocumented watchdog related DT properties.
	- Added usage of the watchdog IRQ.
	- Use irq_domain_update_bus_token() to work-around debugFS name
	  collision for IRQ domains.

---


Matti Vaittinen (6):
  dt-bindings: ROHM BD96801 PMIC regulators
  dt-bindings: mfd: bd96801 PMIC core
  mfd: support ROHM BD96801 PMIC core
  regulator: bd96801: ROHM BD96801 PMIC regulators
  watchdog: ROHM BD96801 PMIC WDG driver
  MAINTAINERS: Add ROHM BD96801 'scalable PMIC' entries

 .../bindings/mfd/rohm,bd96801-pmic.yaml       | 172 ++++
 .../regulator/rohm,bd96801-regulator.yaml     |  62 ++
 MAINTAINERS                                   |   4 +
 drivers/mfd/Kconfig                           |  13 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/rohm-bd96801.c                    | 278 ++++++
 drivers/regulator/Kconfig                     |  12 +
 drivers/regulator/Makefile                    |   2 +
 drivers/regulator/bd96801-regulator.c         | 896 ++++++++++++++++++
 drivers/watchdog/Kconfig                      |  13 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/bd96801_wdt.c                | 400 ++++++++
 include/linux/mfd/rohm-bd96801.h              | 215 +++++
 include/linux/mfd/rohm-generic.h              |   1 +
 14 files changed, 2070 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic=
=2Eyaml
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd9680=
1-regulator.yaml
 create mode 100644 drivers/mfd/rohm-bd96801.c
 create mode 100644 drivers/regulator/bd96801-regulator.c
 create mode 100644 drivers/watchdog/bd96801_wdt.c
 create mode 100644 include/linux/mfd/rohm-bd96801.h


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

--dEAgTGpokvAR9IlE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYw3RIACgkQeFA3/03a
ocWFTQgAyfX1YTiUQNJ/RsdGuBJRi/8qashGQKb6vNjMhQK5YmEzgpYBesZV7/xW
zaILOkezGcalsJ+fDJ20bcgcxZSFmZVqINZWneJi/RahWMBFw93W6N2LigLZCiRh
JsRTPCyrlrxrtMwu8Rg7Yfs6UfHWlg6ibDD7E9ABdN/X9pJALYYHh7s/eB7QM39Z
c+H6Crs7BzAfOZvODx6IxiSRO70iOPELSSKL5sOuCFu97JDPFObTNR8p1ouH4vha
zXvLtJWefAWIUWUm9dy+LXJQ01/m0IxIbogtZxsisw8QGCmyZZox4D6CnT2B1kW1
a23PCPbZl+sXcB2ADoeRiVFSp8jPTQ==
=sWEv
-----END PGP SIGNATURE-----

--dEAgTGpokvAR9IlE--

