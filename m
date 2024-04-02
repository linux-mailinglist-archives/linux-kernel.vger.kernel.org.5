Return-Path: <linux-kernel+bounces-127997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAF689548C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3ABAB26D59
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AC01292CA;
	Tue,  2 Apr 2024 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/4IMe0g"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818357FBBF;
	Tue,  2 Apr 2024 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063251; cv=none; b=kTL+xH9cvd5Ijv8fR2L1TxVoxZN6FZp785weeh6N87e7vSmxRhBVXxwnIfWIkUFGoWC9fn+/qqxqcdz8y8/R/n4d2xTfwmHAevcqX4Ev/q6RNvgPp7e2N3wdw9W+XW1yOY6Tf8AeXnPKa+5YGUT2D9ehVOgvNf1vTORDA3Hyhkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063251; c=relaxed/simple;
	bh=+D1Ro3T40iXb4snfq1uLijK7/Bj8tezfUol7C0P/buc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bQcEKJT8ha0f+GSQmyxJt8rLpV7DmiQx429EI1u1WsdYtbSfZf4fCAZPPuBlS4CbOgqOJQrcrmwVn+8YpKBC+f8o50tIR8BPgZgaoZ/d9nlgWuuCCS6pd+iMJlbpXGFTow6o77+ILYQ3UmcU7svPMGW5OBnVUbRwTCDEiT88AwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/4IMe0g; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-515a81928faso6313107e87.1;
        Tue, 02 Apr 2024 06:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712063247; x=1712668047; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NKU9jx20LVZGBMlMQd/cCeXupmo6LvEXs+isiI8gkiY=;
        b=D/4IMe0g/5wY9yNbpHeEuYpWQFu1C3fpo69K4LYfv4iK2U1HXp2xI62j4D9PmwrneA
         AE4DcOLjkFJsowP8buo45Fq7CBHQc6jkhhIjYu1SBC1vaBBnyd3jvQyMaBEcBUtPN+AU
         nDiZYPuyVA9utfCW8kPxP4Cs6poVvAZTsPWyl9Vu+H5QBozw894DGr4BGxt3uEdpBaMf
         FiKmf16O9Uy3miIKobLMz/yblMdKgq6Y7y3XdYGsCRVYPW7NaRMuDl8OfjVyI8DA1vpH
         H4f0DFsdrjToCBlCTAIC3qFhl/5h5qME6AKiTbGQPC0ZMxrAWYueRU0jRf+w6xmYjU2Y
         2x3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712063247; x=1712668047;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NKU9jx20LVZGBMlMQd/cCeXupmo6LvEXs+isiI8gkiY=;
        b=kmVu7CYsoWvO3SuwlM6Y2kH6tCupTS2ZlSX8YODMMXHv3Qf3ZBxOBjLNJbdPDL5B3n
         Cu2jrx2Mv8YOnktirx7fGftxLKhY1bVlcCXCkIZgLtOc5EB2KyX1ei/dPixZnqZ9vUfv
         jz1xYLOYcbBGYdkBTGVgC7wVNV/RIK6j8NIeqJ8YBPAFAAgojjXgIgml60HvqaES8X9W
         NWc1Stu0ZnxVgl2DQhdi88CrkoW2CX3SNEIrBj9Vzc5McofcUc1/iGSa516M7uoG3fpM
         izwFZKE2FReQYiYwgTIOQ99HZCdmoamyAZASiZ4i3HgskPWdAd4b/5eP7QAsU6EhBUfj
         cMDA==
X-Forwarded-Encrypted: i=1; AJvYcCXlXCY92saJY9WQozmG0itzlZWcgc43J6hDLR04mWm622wvH0DfMIwwqKEqoBa45SkoPsPE2ZuRnyrW/rWhc7n46vG4MdPDYqlpIw1gdWrGPQL2/HYXokon0XJOIxQ1DFW1GamjBmTMQOuqzi17/dxDJ/NArl2uAMizjznDZqkvxE1m6TK0zMH5
X-Gm-Message-State: AOJu0YzMZO27IFGrgelV9W8O0kkU62fVcgETte/M1sE9VmLQLcaIadMg
	PIeF/5fQwqvpvHa3MDKn9RG43Gp+YOx5R6PMfnFdSwD86MwOHmdQ
X-Google-Smtp-Source: AGHT+IFXRtAcfIYkcYjCj1CcDNrWBA3RpHGKgypg6iet93/LvdqOTpHmcVe4ODKD1p4AmLbDRANqJg==
X-Received: by 2002:ac2:58fb:0:b0:515:8159:788d with SMTP id v27-20020ac258fb000000b005158159788dmr7676502lfo.64.1712063247164;
        Tue, 02 Apr 2024 06:07:27 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id bi15-20020a0565120e8f00b00515aa366202sm1706770lfb.274.2024.04.02.06.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:07:26 -0700 (PDT)
Date: Tue, 2 Apr 2024 16:07:18 +0300
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
Subject: [RFC PATCH 0/6] Support ROHM BD96801 scalable PMIC
Message-ID: <cover.1712058690.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WaiMjVoaQWIfNz5i"
Content-Disposition: inline


--WaiMjVoaQWIfNz5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BD96801 "scalable" PMIC.

The ROHM BD96801 is automotive grade PMIC, intended to be usable in
multiple solutions. The BD96801 can be used as a stand-alone, or together
with separate 'companion PMICs'. This modular approach aims to make this
PMIC suitable for various use-cases.

This RFC series is a product of a _long_ process. The product has been
re-designed a few times and this series has been sitting in my git
forgotten for long periods of time, then been re-worked when new design
has been available, after which it has again been forgotten. Last week I
finally received the word that this product should've been stabilized,
digged up my last set of patches (from Nov 2021 - cover letter
reminding me the driver development had been done during 3 years...)

I think this is valid information for reviewers as it's good to keep an
eye on obsoleted practices - even though I tried updating this series.

This is sent as an RFC because of the regulator features which can be
configured only when the PMIC is in STBY state. This is described more
detailed in the regulator patch.

Another "oddity" is that the PMIC has two physical IRQ lines. When I
last wrote this patch in 2021 I had some naming collison in debugfs for
the IRQ domains. Back then I used:
irq_domain_update_bus_token(intb_domain, DOMAIN_BUS_WIRED);
to work-around the issue. Now, when rebasing to v6.9-rc1 the naming
collision was gone and things seemed to work. However, it'd be great if
the IRQ code in MFD driver was reviewed by greater minds :)

Rest of the series ought to be business as usual.

Matti Vaittinen (6):
  dt-bindings: ROHM BD96801 PMIC regulators
  dt-bindings: mfd: bd96801 PMIC core
  mfd: support ROHM BD96801 PMIC core
  regulator: bd96801: ROHM BD96801 PMIC regulators
  watchdog: ROHM BD96801 PMIC WDG driver
  MAINTAINERS: Add ROHM BD96801 'scalable PMIC' entries

 .../bindings/mfd/rohm,bd96801-pmic.yaml       |  155 ++
 .../regulator/rohm,bd96801-regulator.yaml     |   69 +
 MAINTAINERS                                   |    4 +
 drivers/mfd/Kconfig                           |   13 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/rohm-bd96801.c                    |  454 ++++
 drivers/regulator/Kconfig                     |   12 +
 drivers/regulator/Makefile                    |    2 +
 drivers/regulator/bd96801-regulator.c         | 2109 +++++++++++++++++
 drivers/watchdog/Kconfig                      |   13 +
 drivers/watchdog/Makefile                     |    1 +
 drivers/watchdog/bd96801_wdt.c                |  375 +++
 include/linux/mfd/rohm-bd96801.h              |  212 ++
 include/linux/mfd/rohm-generic.h              |    1 +
 14 files changed, 3421 insertions(+)
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

--WaiMjVoaQWIfNz5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYMAwIACgkQeFA3/03a
ocUrcQf8DQhFPJC1Qb61QJNRcbPGRFMvtn7Yv/pHPTaI1DKVZ9dp5plAx9ekzRD9
AYFQkt1K+PyjAMFsdwKPUGMqkD40zsE5S77bXpBL5db1w2++jgDdz432BLggTsDS
EaK779RB0mCuRPwbcnWi0b6WFD89u+8GiSEbOtpT3LfoYsoGhA2ljIsEKDMNK/m4
+SIXf/d3NOhcQcqyqUkQRWMEloVz9X7rpBviVdBhcKdPZsy2x82yhbUq0igkgCOw
N71roCet4uS6MD7QYSb7iHGOqG2E/abymy1mNkTwednH/HmREgxiTWuBpf/Rstgg
EUewKKY1Yd3ieFHg3U/YSYryW2G1fA==
=nQLo
-----END PGP SIGNATURE-----

--WaiMjVoaQWIfNz5i--

