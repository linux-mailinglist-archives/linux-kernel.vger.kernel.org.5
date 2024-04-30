Return-Path: <linux-kernel+bounces-163928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13928B7606
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30721C20880
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C859E17109A;
	Tue, 30 Apr 2024 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bv1MIeo5"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2417605D;
	Tue, 30 Apr 2024 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481075; cv=none; b=CBdL02DoIm0ZL58+JLn2dhL+zaL4sfZaml3Mn0bD4cM11Fay32yDUFI9dpg+XZaroHiHhDvu/6/YN9ZEY1qcYHkXXScs9Cdwm2wkKG4P4P239EoJUW34+/8dSrSNFtV/DD1AabP332y12F5BaebnqagIWYVtqUNLYbFnlqIAPk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481075; c=relaxed/simple;
	bh=/Yvt03kHdz4fltxWLtTL3vYA0LWtKZdULcGIpv78q48=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VbVgpd7s61UsnoXBjmdFupH6+1x6aDUQzqjC12H05I6Bo37pd1Jaq6EQ/Smcyhi5rFILVFz5zc1P/WBGITSQqpBSYJ5qChqeMvSu0nPkxrprpzZgcEJRLbgLZ4r035T1B+N5UODwQneOzCNNLkXK+qB5dPvgXN6UE1ME50DtCls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bv1MIeo5; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51abd9fcbf6so9429076e87.1;
        Tue, 30 Apr 2024 05:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714481072; x=1715085872; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tTSdWqmsEMuSirKG9b5C6k9DmPC8k9s523s5s2x2S+s=;
        b=Bv1MIeo550qRDFmtSY4FRVWEhwO8buxcn5XH+WQhuILBNtCRf8WRqAJVd3OZzlhV8H
         dPKXqyeqUpj8xXIZtyL+4YP+IGwglBE4jnjRaYEzIFEAUlwwYgZMy2cEL9waKSotNPUn
         BGirBbyFf73r4mges6eWfg9awB+AE3DT49I6zVxDOXf/gsQSgPieh5Rih357HXEeGani
         yGiG/ivpF7GbRMEEDjC+Edwc8CJFJCSlEBGsqF4F4BHtNCFyrnKv27/3JnTxnuUjYhEi
         vX1o1rGNHYM08TLuAg10kEbEV2jgDdTLhM5h8Ewv6FpaYWCoc2/ISlAOXCD8qBJjzY0f
         sbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481072; x=1715085872;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tTSdWqmsEMuSirKG9b5C6k9DmPC8k9s523s5s2x2S+s=;
        b=QvTMJuUi9u9GhuXvxdEO7lhf2qjttK6xPA/UJuwzu+M494fbzFRcwZ0+zp9KZB81OV
         4CJ4IC/mj/QL2kjUtVBMyZOFPzpS6naSzCOOwnWiN49IRpcnomXzqcKQtNpxD3Tyf8zj
         irCrVdfoiU4uVnQ40bAtnp3BgtYUFZ5zeVK5dpVGcBn/i+mjxfL1g3BDXEeFQqAdkv5h
         JEQGkGkT+1ViC1U65SOAE5x33rXBg9KoWo9jg/KoGJM+Kp1zhDnxLY8s39LwQYlSbY6R
         +en88TutC4oqNY8GaexiHLASchmfHlPHSCikc8nxLuKUJOPWle0ayJQpjUdNyhgU/Fs9
         bibg==
X-Forwarded-Encrypted: i=1; AJvYcCVIhZjWMtbqqW0p2P3xEQYwSSMEHxVPPNkDA5LeeU4rw8GM59vODWkYXVWCgc15slkHjMTdMd0S1+Y0v0oyzAd86ScURd96hnDTqnn4liEYwtaPmWbh7+YbxOClLUI//rdG0SwwwJwM
X-Gm-Message-State: AOJu0YzryFrTxPYwcvNq9qx3oE3up/vNigH/9LpLBXDsQ2WhZcm2zeyt
	XBta16newhjHuOvQLYIWAHG1ulR1j/NGwqhlLNnLoYFw3tmZ21fw
X-Google-Smtp-Source: AGHT+IFUSz2MKXUvBgYxQ7TS54gzoecJ2/E53DIUXWfY1h6FHzk/cKCarGGGajSLxrJlcjLky3D7MQ==
X-Received: by 2002:a19:3855:0:b0:51b:9254:91e7 with SMTP id d21-20020a193855000000b0051b925491e7mr9687250lfj.61.1714481071503;
        Tue, 30 Apr 2024 05:44:31 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id g29-20020a0565123b9d00b0051d807addd7sm924835lfv.60.2024.04.30.05.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:44:30 -0700 (PDT)
Date: Tue, 30 Apr 2024 15:44:26 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH v2 0/2] Fix the iio-gts-helpers available times table sorting
Message-ID: <cover.1714480171.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NpeaS0ulSzfWY1q6"
Content-Disposition: inline


--NpeaS0ulSzfWY1q6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix the available times table sorting in iio-gts-helpers

This series contains a fix and test for the sorting of the available times =
in
IIO-gts helpers. Fix was originally developed and posted by Chenyuan Yang.

Revision history:
	v1 =3D> v2:
	  - Fix the sender for patch 1/2 (Sic!)
	  - Fix Co-Developed-by tag (drop this from Chenyuan who
	    is the original author)
	  - Fix the From: tag as instructed in:
	    https://www.kernel.org/doc/html/latest/process/submitting-patches.html

---

Chenyuan Yang (1):
  iio: Fix the sorting functionality in iio_gts_build_avail_time_table

Matti Vaittinen (1):
  iio: test: gts: test available times and gains sorting


Chenyuan Yang (1):
  iio: Fix the sorting functionality in iio_gts_build_avail_time_table

Matti Vaittinen (1):
  iio: test: gts: test available times and gains sorting

 drivers/iio/industrialio-gts-helper.c | 7 +++++--
 drivers/iio/test/iio-test-gts.c       | 8 +++++---
 2 files changed, 10 insertions(+), 5 deletions(-)


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

--NpeaS0ulSzfWY1q6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYw55oACgkQeFA3/03a
ocWF5ggAuByumeygBiPFzwl0SZ4N4Ej22D4G9diTtx7GbbXwccwmSGONRLEGB5PQ
7mbHeoZRBP1d37K3/F+GZddZW6L0r7vENiHmVeSpJ4fA2R+ZTaU5DWlob4vwQmHL
1onSQvhxkplJC+04Bsjg3L40S2lJtPsB7j+szaaJPqVMQrRXoJgAIawsmbqXq0Lv
0zwRX91+hXuDRIRJo0AY6zR17cdnSA6FOxYZ7lZNYFIv/pMAg/AYMi0zrirWPGGc
V/NpR6aUidgEe7txlJ5Zeh4EpxBkGomRc8jIbxy+fp1j1Bua8v9atW3VhjTp92i5
ZifZvQ16KCqM0Z+KNAw2tel8986ecA==
=j9P7
-----END PGP SIGNATURE-----

--NpeaS0ulSzfWY1q6--

