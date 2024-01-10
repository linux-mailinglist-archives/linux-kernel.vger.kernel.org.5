Return-Path: <linux-kernel+bounces-21939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26198296E6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0078A1C24BA9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D28C3F8FB;
	Wed, 10 Jan 2024 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwI3ofdf"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437503F8D1;
	Wed, 10 Jan 2024 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e7abe4be4so5045576e87.2;
        Wed, 10 Jan 2024 02:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704881248; x=1705486048; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SR6M2098v0XZKYvDuASrOI/XGr4kL2jFyhf8PM2BbNw=;
        b=SwI3ofdfwcJ/FDheRATOXy/Jn+zyxHrxdrevkHr9WGTaql9k9DUkbt+n+8Iq1I3XoQ
         F/4QTQFQKdawCQcVenL+TWTpdMj5610LlL0PW1Z1r9cQVWrPl1pwJBlV7J0quoZaIcaN
         Had7a4h5yLn+BcK/31ln1WZrzahLVQ0zYVMhtt/62ii97eY4P2vs1v0rKIt/XAluFjWV
         BnrLLh8VV5CsTw058eJ7I5BcUsGGfH4jAc6wh8eRoDxpcAlka9MT2woi+4UqUe8q9Rw8
         JIxSlz+SDxcJlZCbjwc5O0MQs22JY1RtFIRVsoU1L/bt/OpKNmaCDH2QqaPw7eo7HLam
         GLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704881248; x=1705486048;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SR6M2098v0XZKYvDuASrOI/XGr4kL2jFyhf8PM2BbNw=;
        b=BYNws01s+999Ce0sIoVbk9GsjP2pLGzV5qHaU+ChJpHwZ1rOyK/4S8o+avwimwyonS
         t0gfKcHyydJvitn2u/ixm3otqz4JkxWz3ZlB2Hhmm6mtgEBXwoep3EKKTvSiShT8x7iD
         MMp1ZzX2egvZSEO0QfZtxdXbOE6fOa9oo1CIauWgn91unI2WF7QQxK9dVmUzsEpqWch5
         pIfkwRsD7che01FFTLPWQnx4CUOwgyXfvl8WK4h6J5BnJTTmNxnhFT4bzVwTf7yg3lPT
         lXyypFS8WpcpdFzgxwDpq5jDHAXdrEo/rq2Zt5RjyFF5RWTtFIVHTgvAwwIn9Yyxt1LV
         VczA==
X-Gm-Message-State: AOJu0Yx9UYrDEQiTuvOWBesN5Gow/Et7O4jtXDc9k832dP2vI+efqBdy
	ecueY9mluJs2EMVGMeBkIysHMgiyuPA=
X-Google-Smtp-Source: AGHT+IGRzpOjx7vBzDQr3le3sMnRtt4uyNGxurLvy98yPfdzRhOgihZNG95mn6VhJ5ZTJkdGylDAtw==
X-Received: by 2002:a05:6512:3f16:b0:50e:51fa:1d3b with SMTP id y22-20020a0565123f1600b0050e51fa1d3bmr407331lfa.93.1704881247980;
        Wed, 10 Jan 2024 02:07:27 -0800 (PST)
Received: from drtxq0yyyyyyyyyyyyybt-3.rev.dnainternet.fi (drtxq0yyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:7426:df00::3])
        by smtp.gmail.com with ESMTPSA id h41-20020a0565123ca900b0050e7fe37a29sm614232lfv.200.2024.01.10.02.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:07:26 -0800 (PST)
Date: Wed, 10 Jan 2024 12:07:08 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 0/3] KUnit tests for the IIO GTS helpers
Message-ID: <cover.1704881096.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="doWc2m8A9KjyRIVC"
Content-Disposition: inline


--doWc2m8A9KjyRIVC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add some KUnit tests for the IIO GTS helpers.

These tests were originally part of the BU27034 ALS sensor driver series.
https://lore.kernel.org/all/cover.1679915278.git.mazziesaccount@gmail.com/

Merging the tests was postponed because we lacked of a good generic way
of creating tests devices for testing the devm managed interfaces. Now we
have kunit_device APIs being merged (seems like they'll be part of the
v6.8-rc1) so precondition for merging these tests are (being) met.

The series is based on
commit ab27740f7665 ("Merge tag 'linux_kselftest-next-6.8-rc1' of git://git=
=2Ekernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest")
in Linus' tree.

I can rebase and resend when v6.8-rc1 is out if needed.

Matti Vaittinen (3):
  iio: gts-helper: Fix division loop
  iio: test: test gain-time-scale helpers
  MAINTAINERS: add IIO GTS tests

 MAINTAINERS                           |   1 +
 drivers/iio/industrialio-gts-helper.c |   5 +-
 drivers/iio/test/Kconfig              |  14 +
 drivers/iio/test/Makefile             |   1 +
 drivers/iio/test/iio-test-gts.c       | 517 ++++++++++++++++++++++++++
 5 files changed, 535 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iio/test/iio-test-gts.c


base-commit: ab27740f76654ed58dd32ac0ba0031c18a6dea3b
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

--doWc2m8A9KjyRIVC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmWebEYACgkQeFA3/03a
ocWIsggAvk3U6xNGSi3Nc9yQXaMjcgzBys/Wp55CWVnmB+lZrXkHzdXueRwVuvU9
wDo/vvT3xOCMe8wbgYgqa8lBvDgG5mtHyJPxmiDeshso8kF7jjyGcX8XEk+IQAzJ
wGl53sAXKor43awwkmbm04YffbZPMtsXWVBGzBX1ePb3Qu///sGUu3z4zrl1rs48
o+OeXPxdPSNGuUmd/39LTCk8kFkxtZANuX0aGfTLDfArbrFZVcBkalTtdMF9AzcL
e0myy76JEPKeBLlprM3mMJo7VCShR4fb923VVV1wOvgaU50+QFb3wk86OWiMHniE
2PiXqeSaK0AdPmbYVUHNQrizQT5yBw==
=zMqG
-----END PGP SIGNATURE-----

--doWc2m8A9KjyRIVC--

