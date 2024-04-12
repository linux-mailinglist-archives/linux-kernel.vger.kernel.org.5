Return-Path: <linux-kernel+bounces-142013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BB58A261A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3820D1C2389A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCDE38DE5;
	Fri, 12 Apr 2024 06:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+MgwwI0"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0862F2D630
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712901797; cv=none; b=Us33+Qs2SG5fiwqPB5T9alSe9qgJSCokY55R+peSmPIA4RdZtRF+I9F1po2QOVXolLx+LGFx0uldpZoOMWMEvIWhS7x/tD813imyib+YMpCApEBdox7nfi+3lP6xS5G2hfozG9IcB0Qf+xGzBQBXwsI5UsG1MpGPG/djbfaA7sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712901797; c=relaxed/simple;
	bh=S5ojHC/u4IqO+4yUwpmbmD+92lJTJvdV2bcH+SXi0Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Wtyte5N18VRnSCqC1ufckPk4bxafwiOGWEP6CC5JTvop3HoMWM+pvLXkUGtH8u777buMeXZ0MvsJOIEjIMEOdUWeeuDHomxc8HjbCwL5KqyfRe7xlz/5R9kcJL0EEBaYjgqyBUM2FsktAFmP7mJ9WJMzjiMsWHw4raeQg49Ci5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+MgwwI0; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-516a01c8490so1150330e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 23:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712901794; x=1713506594; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XXNgtKv1Qd45e+ADyASuNmEsSRfbvwXFEANuAzWEkcA=;
        b=S+MgwwI0HddU6af/Ad/FJeOoI1huWCqVt/ab9JynMJv3IZm7UQa2Bv2jiuPZAiODtd
         CmwCYW0+bB4XGc2d6XGTiLsQifXC2lGkqe2znVQJqCi3xzGEmyrri8N+ZZdFomn0bwNd
         JsWU5c/q5gxWt8vINlH5vVzwzzVQCNTg/MpTok71gl+xIkbs1po14Prb8wjMqIbbIrEX
         9YlVaV1gYebdxEYhr6BOBbpX+FWv11c/3o9QRZAdXWQqmEczteh238kUmGWQQb79F+n2
         QPiqTWWWi+mRumh38eYe606uiUXbZXCjrHktXEoUx78TcReqZgdvpGR3jBGQ8kduvW+J
         pSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712901794; x=1713506594;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXNgtKv1Qd45e+ADyASuNmEsSRfbvwXFEANuAzWEkcA=;
        b=s1RL24vXxt69T82Fvc7j6yuGVsEyVTyGb3A0XIQnkLW3i3z/wtYt8B5nXVkb5WMrac
         JFN+INevoEJu/dZhBiBy3hgONvsf4lsgrQk7O/ltQNMwsxQZ0CjUx3klt3fiE7W7vP2W
         C9sYwOJ8Kzvuc+LlPscyv9qQtrm7e/BQg1K4A5AbcOn4CUiXafc6gsM5rpdQfI+EPg7F
         mWLagIm5Ywvbx35u/UsHekN7hIKF4rvf4iq42SY9l4RvN/Lmk6pB3FoxQGsonMBmaEIc
         F8zopKjpa0mDKSOT+ADeeL1kPQxPEbLA9uQJ0FzzuYiAOXNGPrPJyfIIM1YVzrePreiG
         t/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCU5UEIR4B31ZsGpqYgNoloyAU1GZnWtAWwJMgozElxqwQaq3LRwfc6Wbusvf5mNqU/SIz6gQ7t+9LIIP4cPpIlofc3dVsKRKAiUko1y
X-Gm-Message-State: AOJu0YwNogtGpcusb6qivKpAVT3KSot71+nWasPYDIkMF4NyP2k8W57v
	FsBPsl/TMrz23LlaRag2hP5Ma6WqFeNg0dTS5md5EXucDRIL3cB8
X-Google-Smtp-Source: AGHT+IFDc1o6iJXio5VcZBFVmNzDOQPJYygSxiZt2Z3uwbvQnMPvNcYd18GV2iAW6iEGc2JJjI8cng==
X-Received: by 2002:ac2:4d01:0:b0:513:922a:4334 with SMTP id r1-20020ac24d01000000b00513922a4334mr471352lfi.1.1712901794044;
        Thu, 11 Apr 2024 23:03:14 -0700 (PDT)
Received: from drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi (drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:7426:df00::2])
        by smtp.gmail.com with ESMTPSA id r7-20020ac25f87000000b00516d0029383sm431433lfe.28.2024.04.11.23.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 23:03:13 -0700 (PDT)
Date: Fri, 12 Apr 2024 09:02:55 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: bd71828: Remove commented code lines
Message-ID: <ZhjOj_4AUgC4Iwh_@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kjvtiDMcpqESvsik"
Content-Disposition: inline


--kjvtiDMcpqESvsik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some commented out code was accidentally left in the header.

Clean up commented out macros.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 include/linux/mfd/rohm-bd71828.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/mfd/rohm-bd71828.h b/include/linux/mfd/rohm-bd71=
828.h
index 3b5f3a7db4bd..8410faa38304 100644
--- a/include/linux/mfd/rohm-bd71828.h
+++ b/include/linux/mfd/rohm-bd71828.h
@@ -41,7 +41,6 @@ enum {
 #define BD71828_REG_PS_CTRL_2		0x05
 #define BD71828_REG_PS_CTRL_3		0x06
=20
-//#define BD71828_REG_SWRESET		0x06
 #define BD71828_MASK_RUN_LVL_CTRL	0x30
=20
 /* Regulator control masks */
@@ -133,7 +132,6 @@ enum {
 #define BD71828_REG_LDO5_VOLT		0x43
 #define BD71828_REG_LDO5_VOLT_OPT	0x42
 #define BD71828_REG_LDO6_EN		0x44
-//#define BD71828_REG_LDO6_VOLT		0x4
 #define BD71828_REG_LDO7_EN		0x45
 #define BD71828_REG_LDO7_VOLT		0x46
=20

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

--kjvtiDMcpqESvsik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYYzooACgkQeFA3/03a
ocU/ewf+JZyK4ia5NBo4s13kM7xX/K5nJ7YXpeSWZvz1kSHBLzWJL2+kEqlfwocC
xbGmJdCNOZusx9aARCWaSy9f0OD0Qm/X8N1TZ1rJsXW0x1FbZJegIyb73j6kIEmj
25skdXGv4i7Nt5OvCH1hAMFfxG6L/08i39r+X/yo5BoZ15znOSrS6JtnCHZdsBHS
c5nieP4mcopVbBOoXuxa0q6rlpUF/Yu7HV/vfkfq1fMjJ93HHI9wb+BXGxOpiUYF
yvLz3iUU8fgV/VsBH2uqK4a2oC1EvIkf2yqPGH1bCSw1nK4rrZP4NPjP3pBoVEqc
0+Bm923wN5uGpcwK4Q70mNxvag7r9A==
=UJ/P
-----END PGP SIGNATURE-----

--kjvtiDMcpqESvsik--

