Return-Path: <linux-kernel+bounces-26082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F8282DB39
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89BE1F2285C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C4F17590;
	Mon, 15 Jan 2024 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5VNNzq6"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A898A1758F;
	Mon, 15 Jan 2024 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cd0db24e03so100189151fa.3;
        Mon, 15 Jan 2024 06:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705328745; x=1705933545; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0RfU6JOfdDnbHQgAL85cIE6/MM4qYKPixcL9mD0h00=;
        b=m5VNNzq6gKJGW46oxR1EQbOsXQF3thZFiLcfMl/ce1MRIKg9/2jlBX7e4G6lPRCw6H
         zvnA0DLN2Gpsh/frCRY1aJOimGBjCy0mClWFgH7mGQZnNmBFM+J2OY+uwQtX2nbDvexA
         rD/CeI5TrYXCDX3RdmdS02NyZHesikdnI7XLHL00hErikvyjQy1xDQ/69hgTe0XMqKCx
         r8oOOAoBum1awHss/ZCuMtxBwMJr6HbXV77TMAb1RKc/d40hIcaBwvVwgSWPImhKWZZ7
         rxDh6SrSmhFVU+G9vzxOMwwJDAjnQ6BD/+rXTMyZHPvK72GrEs3Sk0w/ZLqKTMzzNeuC
         kBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705328745; x=1705933545;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0RfU6JOfdDnbHQgAL85cIE6/MM4qYKPixcL9mD0h00=;
        b=tkw8JVLHo9mPTNcrDdd/Odw1ZhQr88w4PB8cItzN4DkMibnyQ3jB8uUKbVICel+lW/
         AAHYEv+du81mA76lZeSV0FtDGf9Hv/JgugcyiWEQZtT6ZOGWx3lihvyKwqwZQqYoh4gE
         DVc4pJAZQCZHK3apzb9wYw/Z1KSgnwporZavm6eAN7CY+haXmvQ81AsEvg2SMRnwMLC9
         YKwXrc46AJSEVuitbg9KqACYB1/KwtN6lSV6y/R2K3cSZjZGw1Ix8yhu10guW9ljvlUe
         eerDxPtQvNU/vkoXqv4klrpx9RqVg7s0ifZ7fGSJI0aACnQ8RyUuCXy1To9lw4eckfEi
         xpiw==
X-Gm-Message-State: AOJu0YyeixGWf5NjuOqM547PPCR56kTf5UjChapYM5gjtjgx6JD177ZS
	mmv7nKyIQSnEfe+vbYnYMlUjZVlIRs3oBw==
X-Google-Smtp-Source: AGHT+IF1bBjhyNde5zHwImYc2Hs7rdEJ5T4h1Qbk5F+F61uyOYYVrQ56eSA+e5kukIEMWxQqdD5ilw==
X-Received: by 2002:a2e:9555:0:b0:2cc:6bbf:ea8c with SMTP id t21-20020a2e9555000000b002cc6bbfea8cmr1281798ljh.176.1705328744086;
        Mon, 15 Jan 2024 06:25:44 -0800 (PST)
Received: from fedora (mobile-access-567347-211.dhcp.inet.fi. [86.115.71.211])
        by smtp.gmail.com with ESMTPSA id m21-20020a2e9115000000b002cd32d4722asm1346087ljg.61.2024.01.15.06.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 06:25:43 -0800 (PST)
Date: Mon, 15 Jan 2024 16:25:24 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2 0/2] KUnit tests for the IIO GTS helpers
Message-ID: <cover.1705328293.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Wq5gS/cld4woueMZ"
Content-Disposition: inline


--Wq5gS/cld4woueMZ
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

Revision history:

v2:
	- Drop already applied division loop fix patch
	- Remove unnecessary empty lines

---

Matti Vaittinen (2):
  iio: test: test gain-time-scale helpers
  MAINTAINERS: add IIO GTS tests

 MAINTAINERS                     |   1 +
 drivers/iio/test/Kconfig        |  14 +
 drivers/iio/test/Makefile       |   1 +
 drivers/iio/test/iio-test-gts.c | 513 ++++++++++++++++++++++++++++++++
 4 files changed, 529 insertions(+)
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

--Wq5gS/cld4woueMZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmWlQE0ACgkQeFA3/03a
ocXb/QgAik8kThXqVlUCuV5frLxNbmgsd7sOcpzl0ywNhH7tunYxCfqQKl5z+gWm
pwlQ7RSsm9QrlT4txj26+jDgIp7vtgZc8sThl7rIITdBDyYSCV2FY+9e33DZDOLv
RB+vu+ZfRqE5v9cC6iWo1nrXzyAT8Zrnz6yyIFVMuC0BNL3ozb/XG4gk/slw43v+
3LG3OTbM7sU2iSaTaH54daC31cFDRulXUYmHex//KTkyodDdM76xKU3+AswSn7Ex
u7+70pLdZezCjh+8A+TsI3eGN1Vi+t83zHjcsMLpugYv5SZK4FJoXJia6hgOevTe
nbei2CZmEY7VMqsP8HrearSww22+dA==
=CwWp
-----END PGP SIGNATURE-----

--Wq5gS/cld4woueMZ--

