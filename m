Return-Path: <linux-kernel+bounces-142562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6A08A2D30
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D51D1C21C49
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E095467B;
	Fri, 12 Apr 2024 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpONXfsa"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D8D42064;
	Fri, 12 Apr 2024 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712920814; cv=none; b=f6TLbleleVu8JbCz3nli8qsXlAxkVZH/AniTePH6vDoLU7WURyKddtdhamq5PoAs4StYxVqDierMXZXkJzDDmX+VKYudqYoVwDRsK4P8Bacv8rl6AagpF1wyrS80/eMNMwJBiXMr4tRdZ9b1yf/mlzm56hEWpjdxNrRcyBQmbnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712920814; c=relaxed/simple;
	bh=NsEj4itARfSaIua1zjLoV9RjS978JVu1/c1b7YaNTAg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GJo/10wCI7Q066xFXjNd72UmPMFJcgWKzg4F2P3Jf4zsIZ7kfbP0AjycqfLM9BkebLwiiRRqOQYUEzzcXGS8Gm1oQcNcrb+NV9GLeJATK4hkUsNhPVZJlcxlmQ/no54q/uDXQTXAFRyHWZe9pAxAWImfrfdzMu1WLr81QljZ5dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpONXfsa; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d8743ecebdso8004031fa.1;
        Fri, 12 Apr 2024 04:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712920811; x=1713525611; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K6llkGzTMtDecfn5lL/x3eZ2VS0QYxokhuUgjTqLIds=;
        b=OpONXfsaV/7DVKZQd5jZIk86hcsxXX7uNbesCcgVgsQAZKyi7VFkHtG1eXJqaQ9eOc
         M5KzKnFsKq848WtYFDc8Y5vPMQpaj2RjTzcXSbQZxSDPRizA3/GgFWXpE2nmz9qFrK7P
         THipi+/O6dgFIoHDOB5XPvFGS/8Oq/BF1P6QwCRa7lThHDZbMXPVdkrERz+11RFpEbrL
         79ntYdgUNQUDvTM46haDSD2velTZyNitBQy/C3RlhfPZONny83WkIBV4uGRPwMKTzfNc
         DNjS7sSvlTlN/Fu8ZhHt69wwJR1nlRudhO7E2YHPn0aayn0ncuOuiRpoqctxUBiGUslG
         iilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712920811; x=1713525611;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K6llkGzTMtDecfn5lL/x3eZ2VS0QYxokhuUgjTqLIds=;
        b=T7faIMegymv3RNM1Y42PoafPVqZZUtL72wWUBnPG9NDSWaOM4DdIEL3R1vBGas/tqj
         ESzYNiEtzeUlKp4/jwgmNg1/9a067g9FH8lkC7qk+/epxnf18up1byoobVVnWYUERyQS
         2wV8FzdqxSKZZdGHZt6WXFVuMqpk84iL8W2rfZL/MUR7e3WFUDMREZzZ9wpkq6lbKM+x
         z0UbLUWLzwLCM8WVbYAA/vqQZ7QWNvabrnWcugiRiPJ4YLqIpjNnCbo0prKw4SusyTxT
         WbO6iDVgTjJMDjsCHfiq0yXbc6EsEAcFe7mZM7Bw5vNd591wv9YWSclLvMmo5fKP/s7P
         OmlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTQCc6eOVNDMFbCPxssCB6x3+7OrlT4Nq7Jgm2YH85fcGNCFBGJZe98E4soqgE7gWMc1C8n94Uc9OprMhxA8UuC/yLyM9LBqkJu8OP/G4Khvx45vxaJ98DSqsNSM7A+3GsuX9E9ARFzSzlvgLM/JCukS67ldNkQ1gIAer4JMf25Ka1Y99Xa2hF
X-Gm-Message-State: AOJu0Yz/JQuxU9thZjWg+hIqLI+5kI3NmZdC5GT7wntlSm/t1rbKyoIf
	eSrV4O7cXmssbyuPLkz8PI+mqnMzEBxcWRvrUB/AJT79QsHerC6O
X-Google-Smtp-Source: AGHT+IG0Ay17+e84Jpncmal/zU9S7d+YchunQ8ETIecjF9tTTfmCwanY2Hb24PMu6UeHLuTOeEQIAQ==
X-Received: by 2002:a2e:8456:0:b0:2d4:99f8:8b9f with SMTP id u22-20020a2e8456000000b002d499f88b9fmr1342547ljh.50.1712920810475;
        Fri, 12 Apr 2024 04:20:10 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id d11-20020a2e330b000000b002d68abf446bsm483910ljc.139.2024.04.12.04.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 04:20:09 -0700 (PDT)
Date: Fri, 12 Apr 2024 14:20:03 +0300
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
Subject: [RFC PATCH v2 0/6] Support ROHM BD96801 scalable PMIC
Message-ID: <cover.1712920132.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+cts3s1576ejsO2H"
Content-Disposition: inline


--+cts3s1576ejsO2H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BD96801 "scalable" PMIC.

The ROHM BD96801 is automotive grade PMIC, intended to be usable in
multiple solutions. The BD96801 can be used as a stand-alone, or together
with separate 'companion PMICs'. This modular approach aims to make this
PMIC suitable for various use-cases.

This is sent as an RFC because of the regulator features which can be
configured only when the PMIC is in STBY state. This is described more
detailed in the regulator patch.

Another "oddity" is that the PMIC has two physical IRQ lines. When using
regmap IRQ to create own IRQ controller instance for both HWIRQs, there
will be a naming collison in debugfs for the IRQ domains. As a
work-around the MFD driver uses
irq_domain_update_bus_token(intb_domain, DOMAIN_BUS_WIRED);
to append '-1' at the end of the domain name.

Rest of the series ought to be business as usual.

Revision history:
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

 .../bindings/mfd/rohm,bd96801-pmic.yaml       |  171 ++
 .../regulator/rohm,bd96801-regulator.yaml     |   69 +
 MAINTAINERS                                   |    4 +
 drivers/mfd/Kconfig                           |   13 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/rohm-bd96801.c                    |  476 ++++
 drivers/regulator/Kconfig                     |   12 +
 drivers/regulator/Makefile                    |    2 +
 drivers/regulator/bd96801-regulator.c         | 2114 +++++++++++++++++
 drivers/watchdog/Kconfig                      |   13 +
 drivers/watchdog/Makefile                     |    1 +
 drivers/watchdog/bd96801_wdt.c                |  389 +++
 include/linux/mfd/rohm-bd96801.h              |  211 ++
 include/linux/mfd/rohm-generic.h              |    1 +
 14 files changed, 3477 insertions(+)
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

--+cts3s1576ejsO2H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYZGN4ACgkQeFA3/03a
ocWYIwgAzLthY1mGUrJltIt+7dpeQeW5Wo09PluWsOgE8R6LFbeW2l+JKQa4d/oW
EcV0LHwayFqavbkzcNkccWQgswv7CH6ujyAGGy+tOPh55JTFRHrF+d8bBEBRZAL6
R3QdWzHToebZQQfUJS3ysMm/Now4v0YxbVRKx9y4fdWxBbDvZhZnxns0/A7wEBKU
tOLO+IvIRXmwrL7hIxMkTJXzMIsGl4gn0XVoY1asEgiJlxiWiNK0xEIiJ5XYS7OD
5LmYPCgCvVhcMa4oZCUqWN7u21TgzxB4smdGDAELJlSrlVIcAhCUJ6Olr0m5HDXx
62nrmlBIKNu2OGaRXri/6OSPyFewww==
=tRI6
-----END PGP SIGNATURE-----

--+cts3s1576ejsO2H--

