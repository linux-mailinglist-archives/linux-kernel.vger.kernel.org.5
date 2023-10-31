Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1680E7DCA2C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbjJaJw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjJaJwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:52:03 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E647710F2;
        Tue, 31 Oct 2023 02:50:58 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c5071165d5so29954241fa.0;
        Tue, 31 Oct 2023 02:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698745856; x=1699350656; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pm0E+qHfJ96Z5WGc1StxiY8bt/dlGJYxdkUl7eJLbGA=;
        b=WeLLHKRZqlFsRTWn8NSO7ls0efZ1CGhoeDRxZHhDJVkeyyQmhD/+3zl8RwJYEbIuwm
         g3m2L89otpss7EUQ0halGAQmu6Uj8F6TRrdMBResVshDG1RP1Awu7A1XoEin0idy9cmc
         Z2ac6Rn2OSJsZo5i/WQU4Ms41Rskwo0WmzaUkCI7O2BxL8bmdhIJHyHqarPrm89MYbfi
         FJh+cTIVuiPAkfCe/6LfUgQHkqmRIK3/uMcTeY5nmbfWoJuOYBO7bC7wD/8i+Ib0VVa9
         FvXIoeBjjVcA4aShsrI7GZuY184XrWtkxW2D65dfmRlmcKNq9BTrkDtvU7p6kUKbMEWB
         /bwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698745856; x=1699350656;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pm0E+qHfJ96Z5WGc1StxiY8bt/dlGJYxdkUl7eJLbGA=;
        b=ZwB/TG9O+cTbcq4J7TJKWQRM21l/L6qXERXkC6jd5ZoiMAzEUsAMSPA1Jeyt2d90fo
         3peSccMg5UkiovCPef5kg7sQnzqiOcXi52JwnfsTYICVmKVgwF1GY7vevdPZZuo7ExnY
         4e72jtvXiNkZcSZFKMxNkix5M6yXGW9WAilYU2elP83Y4ph3Q+zFJJEzFqavckVBaETX
         zKFbUOobZgNcZ5Qlum/IZd8T+PPIs3jEu8IpdftZjtl9+nS270ivzVy6buuR5V5zeCH3
         RiovQU7o74ebSw0zS3ouo7Y1rA1ISbVm03KDtfSMQcXg0TCyJ+tB5B68tHkRVXAVt4Wd
         O3dw==
X-Gm-Message-State: AOJu0YyVtbHz5LuPx6uLaXM/jpXIiFEB+MUM63+7+Vm2gh0TMr8pSf8W
        TTIASQK/pw9HimN6PtkyXnc=
X-Google-Smtp-Source: AGHT+IGRGUjLyn0PT8ojXQEGfSIlSLsjn3Syra41p+ZC2HcYufiZeONeBDnQ7P4FA/PvyhwDtGStsg==
X-Received: by 2002:a2e:bb86:0:b0:2b6:ea3b:f082 with SMTP id y6-20020a2ebb86000000b002b6ea3bf082mr7634854lje.38.1698745856331;
        Tue, 31 Oct 2023 02:50:56 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id s25-20020a2e2c19000000b002b70a8478ddsm143509ljs.44.2023.10.31.02.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 02:50:55 -0700 (PDT)
Date:   Tue, 31 Oct 2023 11:50:46 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: gts-helpers: Round gains and scales
Message-ID: <ZUDN9n8iXoNwzifQ@dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZJOGLzL4y7uQJBvg"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZJOGLzL4y7uQJBvg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The GTS helpers do flooring of scale when calculating available scales.
This results available-scales to be reported smaller than they should
when the division in scale computation resulted remainder greater than
half of the divider. (decimal part of result > 0.5)

Furthermore, when gains are computed based on scale, the gain resulting
=66rom the scale computation is also floored. As a consequence the
floored scales reported by available scales may not match the gains that
can be set.

The related discussion can be found from:
https://lore.kernel.org/all/84d7c283-e8e5-4c98-835c-fe3f6ff94f4b@gmail.com/

Do rounding when computing scales and gains.

Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Subjahit, is there any chance you test this patch with your driver? Can
you drop the:
	if (val2 % 10)
		val2 +=3D 1;
=66rom scale setting and do you see written and read scales matching?

I did run a few Kunit tests on this change - but I'm still a bit jumpy
on it... Reviewing/testing is highly appreciated!

Just in case someone is interested in seeing the Kunit tests, they're
somewhat unpolished & crude and can emit noisy debug prints - but can
anyways be found from:
https://github.com/M-Vaittinen/linux/commits/iio-gts-helpers-test-v6.6

---
 drivers/iio/industrialio-gts-helper.c | 58 +++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrial=
io-gts-helper.c
index 7653261d2dc2..7dc144ac10c8 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -18,6 +18,32 @@
 #include <linux/iio/iio-gts-helper.h>
 #include <linux/iio/types.h>
=20
+static int iio_gts_get_gain_32(u64 full, unsigned int scale)
+{
+	unsigned int full32 =3D (unsigned int) full;
+	unsigned int rem;
+	int result;
+
+	if (full =3D=3D (u64)full32) {
+		unsigned int rem;
+
+		result =3D full32 / scale;
+		rem =3D full32 - scale * result;
+		if (rem >=3D scale / 2)
+			result++;
+
+		return result;
+	}
+
+	rem =3D do_div(full, scale);
+	if ((u64)rem >=3D scale / 2)
+		result =3D full + 1;
+	else
+		result =3D full;
+
+	return result;
+}
+
 /**
  * iio_gts_get_gain - Convert scale to total gain
  *
@@ -28,30 +54,42 @@
  *		scale is 64 100 000 000.
  * @scale:	Linearized scale to compute the gain for.
  *
- * Return:	(floored) gain corresponding to the scale. -EINVAL if scale
+ * Return:	(rounded) gain corresponding to the scale. -EINVAL if scale
  *		is invalid.
  */
 static int iio_gts_get_gain(const u64 max, const u64 scale)
 {
-	u64 full =3D max;
+	u64 full =3D max, half_div;
+	unsigned int scale32 =3D (unsigned int) scale;
 	int tmp =3D 1;
=20
-	if (scale > full || !scale)
+	if (scale / 2 > full || !scale)
 		return -EINVAL;
=20
+	/*
+	 * The loop-based implementation below will potentially run _long_
+	 * if we have a small scale and large 'max' - which may be needed when
+	 * GTS is used for channels returning specific units. Luckily we can
+	 * avoid the loop when scale is small and fits in 32 bits.
+	 */
+	if ((u64)scale32 =3D=3D scale)
+		return iio_gts_get_gain_32(full, scale32);
+
 	if (U64_MAX - full < scale) {
 		/* Risk of overflow */
-		if (full - scale < scale)
+		if (full - scale / 2 < scale)
 			return 1;
=20
 		full -=3D scale;
 		tmp++;
 	}
=20
-	while (full > scale * (u64)tmp)
+	half_div =3D scale >> 2;
+
+	while (full + half_div >=3D scale * (u64)tmp)
 		tmp++;
=20
-	return tmp;
+	return tmp - 1;
 }
=20
 /**
@@ -133,6 +171,7 @@ static int iio_gts_linearize(int scale_whole, int scale=
_nano,
  * Convert the total gain value to scale. NOTE: This does not separate gain
  * generated by HW-gain or integration time. It is up to caller to decide =
what
  * part of the total gain is due to integration time and what due to HW-ga=
in.
+ * Computed gain is rounded to nearest integer.
  *
  * Return: 0 on success. Negative errno on failure.
  */
@@ -140,10 +179,13 @@ int iio_gts_total_gain_to_scale(struct iio_gts *gts, =
int total_gain,
 				int *scale_int, int *scale_nano)
 {
 	u64 tmp;
+	int rem;
=20
 	tmp =3D gts->max_scale;
=20
-	do_div(tmp, total_gain);
+	rem =3D do_div(tmp, total_gain);
+	if (total_gain > 1 && rem >=3D total_gain / 2)
+		tmp +=3D 1ULL;
=20
 	return iio_gts_delinearize(tmp, NANO, scale_int, scale_nano);
 }
@@ -192,7 +234,7 @@ static int gain_to_scaletables(struct iio_gts *gts, int=
 **gains, int **scales)
 		sort(gains[i], gts->num_hwgain, sizeof(int), iio_gts_gain_cmp,
 		     NULL);
=20
-		/* Convert gains to scales */
+		/* Convert gains to scales. */
 		for (j =3D 0; j < gts->num_hwgain; j++) {
 			ret =3D iio_gts_total_gain_to_scale(gts, gains[i][j],
 							  &scales[i][2 * j],

base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
--=20
2.41.0


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

--ZJOGLzL4y7uQJBvg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmVAzfIACgkQeFA3/03a
ocXy0gf/ergLr28VxrsP+6FGMyLa4L+x7QFUWLVljoPVTq2v/FoT4GOmBizTlQiY
QxrHuz0W1R4UF0iGzYEm+T/rR4byTYLv6hEG7vKAg40bQ834lnhg/SF381lwNTWx
w/3RlT4kTQiiO1f8QA0///dPxdVmHlgFJ8HyCHTyE5kc66a6L3NtmpOsHwUAY5g6
aj13rPnRu+mhrENkfC2gHgdfSZ2kHJsZlvrChcSiBULGN3O2S8TMXCWyUrjwCdT0
W56C6cUruSh4PzLHeBEUkiZCP2czGObvjHZ8m1dxeEDTYm7UveJ/HvWsjqQtOmgQ
WR3Euj+3O6UPivay2+qqpoh7qVq1Hw==
=WlvL
-----END PGP SIGNATURE-----

--ZJOGLzL4y7uQJBvg--
