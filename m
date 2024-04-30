Return-Path: <linux-kernel+bounces-163930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B568B760A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF39E283FC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4AF171646;
	Tue, 30 Apr 2024 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp3Es5A+"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFFA171088;
	Tue, 30 Apr 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481135; cv=none; b=hZOUjcpxjSC9EHDeJ3jlFZqwvZxvesiPf+a62AjN7Fdo+XyI1WdwlPKo48RhkuxRSeMUTiqr0f7SujMgeuRl1AwFJ939xFVDKFTddb1vpr6L8Q+Sf+ySc/S556fchdKLDBB0At1aNiEHMZPkbIy3rWoQPZ/61otRrkJa5hIz3HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481135; c=relaxed/simple;
	bh=KSqsEM/ELNKUOxxne+/cC9lsGDSIHr6Ga7Be3GqcqW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nab2UDDu1uRt2Xvjy1eG/8WABX8bCWiK9luo1hmmuyDyT/IH+M/rL3RXxyuVWSpCcVRFz2In7wmtEnpZQUHo5pg5kfLRe73MwexAEepcFEvW86ES/iNOl1pA3POPUMmxMwseCkIT1o3ranCuyxh/rNYrpdK1oD5seHYhqoJIkWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jp3Es5A+; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e0a2870bceso25786301fa.2;
        Tue, 30 Apr 2024 05:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714481131; x=1715085931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=819KSoS21UAhzQAUss6vDrKjXlCt6LuTDp8QhzT3swc=;
        b=jp3Es5A+/vJDIURGue7PP9MTzfWFVwgtMtfsuZZked2rR09bkdVWUjJkdq6BtixFrg
         k56zWfn8/qF6aWUaiiD3aA1vBMjMI/JZowmGzaSFSAInmDaVGEsMhsmUqX6bG0MhfwyG
         nUkhpJl+L3qgDO2GIhhXngC3EiCyUu/T8Aev04/TL1g+zo+XCS0+VaGTSsZE8C4kf5ts
         1QXfGF91+a9mJ0ciBGFCLQRK+SJNT4Z2LXqmkx7M9fwbhdykfNVfCuMMMvrh6uwddvJY
         cTgAg1egb5INbpS5iJSJ5Os5BqLpzPZ1Sfa097CHl3br2TS73mtFC09a2U5xZBr+AaHm
         E7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481131; x=1715085931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=819KSoS21UAhzQAUss6vDrKjXlCt6LuTDp8QhzT3swc=;
        b=QHXngc5PFFFgH0txHDO/4T4gLbqNx9YfjE9rmeWl0UuoNP1qcPPK6CnEIF9aUdYtHy
         uwHISPXq3qxfu15Ukd/V8xVhYiYsMgG8A6AknNdbWIWyVbFzugoHtD9ciUxzFo87WFpo
         EnZnmXcLMNynYlkxaJYmubn+m8n86bpuvIxf/FqWkNz9lfNyO9/ks5OokyJOZs9vX8Q7
         nMMlEDf7jLks94P6bOURcLLHAQZuryjOKVOY/o9u6gQPstDA6s7oor1Ug/s3xcQn3Hc7
         82ylt6UHTmIlU57W7UW+E4NgXDqTT6byQJsWuiOmHNI30SFhya5A9CHSQtgBS0zr0GRu
         Jz/w==
X-Forwarded-Encrypted: i=1; AJvYcCVp4Zqm5Dx5M9CfRDknCzQua7fApPs/QeiqOxDxfxBMnv7rTdJY3tkwRfkWAwFiYzeKA6m0dlWi/TsKG9vY89AsyDX/fR5JiY/YD0jU8iWYkE1A0QLc2iyPClvh9OWi0nyArL+bS578
X-Gm-Message-State: AOJu0YyHUcivpO/vfsxLRibfAjOXfPap5ZDpYDDQ7QjOi0U4KOzly0rR
	0JnyXh7XCVoHVOuESJZDktJp+2LjXWtqqz/dD7FA89sqnhplKGs3
X-Google-Smtp-Source: AGHT+IEwGHyM4P0p+YnR0uTivBpNct05kOjmg38WblTfBy+HqnoPf2fkC8vVcVkW86SOVRRm4tcjOA==
X-Received: by 2002:a2e:8608:0:b0:2d2:f5fa:f37e with SMTP id a8-20020a2e8608000000b002d2f5faf37emr6038466lji.51.1714481126553;
        Tue, 30 Apr 2024 05:45:26 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id a8-20020a2e9808000000b002d9f8183e0esm3888502ljj.81.2024.04.30.05.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:45:25 -0700 (PDT)
Date: Tue, 30 Apr 2024 15:45:21 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH v2 2/2] iio: test: gts: test available times and gains sorting
Message-ID: <365cc6de3c17a457db738f5fdf8dd3bd6f50d5f2.1714480171.git.mazziesaccount@gmail.com>
References: <cover.1714480171.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0YpC9mXh8AXYq7V2"
Content-Disposition: inline
In-Reply-To: <cover.1714480171.git.mazziesaccount@gmail.com>


--0YpC9mXh8AXYq7V2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The iio_gts helpers build available times and scales tables based on the
times and gains arrays given from the driver. The driver should be able
to list all valid register values so that conversion from register valu
to correct gain/time works for all supported register values.

It might be more convenient for drivers to list these times and gains in
the order where they're listed in the data-sheet than ascending order.

However, for user who requests the supported scales / times it is more
convenient to get the results in asscending order. Also, listing
duplicated values is not meaning for the user.

Hence the GTS heler should do sorting and deduplication of the scales
and times when it builds the tables listing the available times/scales.
Note, currently duplicated gain values aren't handled by GTS-helpers.

Unsort the gain and time arrays in the test code, and add duplicates to
time array in order to test the sorting and deduplicating works.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
 - No changes

 drivers/iio/test/iio-test-gts.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/test/iio-test-gts.c b/drivers/iio/test/iio-test-gt=
s.c
index cf7ab773ea0b..5f16a7b5e6d4 100644
--- a/drivers/iio/test/iio-test-gts.c
+++ b/drivers/iio/test/iio-test-gts.c
@@ -70,6 +70,7 @@
  */
 static struct iio_gts gts;
=20
+/* Keep the gain and time tables unsorted to test the sorting */
 static const struct iio_gain_sel_pair gts_test_gains[] =3D {
 	GAIN_SCALE_GAIN(1, TEST_GSEL_1),
 	GAIN_SCALE_GAIN(4, TEST_GSEL_4),
@@ -79,16 +80,17 @@ static const struct iio_gain_sel_pair gts_test_gains[] =
=3D {
 	GAIN_SCALE_GAIN(256, TEST_GSEL_256),
 	GAIN_SCALE_GAIN(512, TEST_GSEL_512),
 	GAIN_SCALE_GAIN(1024, TEST_GSEL_1024),
-	GAIN_SCALE_GAIN(2048, TEST_GSEL_2048),
 	GAIN_SCALE_GAIN(4096, TEST_GSEL_4096),
+	GAIN_SCALE_GAIN(2048, TEST_GSEL_2048),
 #define HWGAIN_MAX 4096
 };
=20
 static const struct iio_itime_sel_mul gts_test_itimes[] =3D {
-	GAIN_SCALE_ITIME_US(400 * 1000, TEST_TSEL_400, 8),
-	GAIN_SCALE_ITIME_US(200 * 1000, TEST_TSEL_200, 4),
 	GAIN_SCALE_ITIME_US(100 * 1000, TEST_TSEL_100, 2),
+	GAIN_SCALE_ITIME_US(400 * 1000, TEST_TSEL_400, 8),
+	GAIN_SCALE_ITIME_US(400 * 1000, TEST_TSEL_400, 8),
 	GAIN_SCALE_ITIME_US(50 * 1000, TEST_TSEL_50, 1),
+	GAIN_SCALE_ITIME_US(200 * 1000, TEST_TSEL_200, 4),
 #define TIMEGAIN_MAX 8
 };
 #define TOTAL_GAIN_MAX	(HWGAIN_MAX * TIMEGAIN_MAX)
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

--0YpC9mXh8AXYq7V2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYw5+EACgkQeFA3/03a
ocXwfwf/TRbZas13dxDTosr7AkuDttD0tQM5XhO0e/d9jiuV34VYhsG+SPBDk//d
7o2ldfHBtVrcC0G/a+k1PW8jBDZ5D2+RzVHG0jnzXG3WwbIgZqJWHj+sIFZenAjj
NaUIhgAZvd1bCyHBvIkZ3aVXDJPL/4oPGrphi84y7MvwDRk8Y4Igw9Uj29V43m/W
8fCRaaaUegNfQySLKrcO7Y2UdCkJT4WLupVDGaePeDgjWiAjYrNrs1D2pBB8f2y9
jKUkg3bSyvQtb2A4xo5Oxb6fMWjmQVsWfGLnORELQZe+nIE3bXu/ondXoIRZ86pn
B0OkdUPTXX3Gy0chFB0qgFp03HGlBg==
=604L
-----END PGP SIGNATURE-----

--0YpC9mXh8AXYq7V2--

