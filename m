Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D7B80555D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbjLENCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbjLENCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:02:08 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF90D7;
        Tue,  5 Dec 2023 05:02:14 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9f62447c2so28574411fa.0;
        Tue, 05 Dec 2023 05:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701781333; x=1702386133; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wVkkONZNfkX/iqB+XjK9GHA8D0k5JMrE6DojR60eqaY=;
        b=D6MUHoGgJ/6SI9+AoORI8jqnKO0a7qeRmgw6djvw03qTewZZ4n6syf6F6yZc2Kkf0K
         AU9DiEhaz2/ZCzwpr3QPwiXL7+Jyv/mS393B4nwmrdliTUGODNq2RraufOTe7mVun/9H
         172nG+607I1bXUvPskn027N/IeEeTNBaptb0XR7migdOajUe0A4oh2QNcXmDcz75P29w
         dNGNF3PQPP4lp3RMwOdE25XqK4fC7k6WLOAHs8tl12t8pBV3psbLLNbYYRCVPz74LqtV
         1RS7BI4EY73IkhIuHdgoRedoMoR5bzLw7VCLkd750qZIAwXMdi/YoIcF90oeC8eZfQ20
         5Vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701781333; x=1702386133;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVkkONZNfkX/iqB+XjK9GHA8D0k5JMrE6DojR60eqaY=;
        b=HVzO6HbICG81Cux2KVAf3XYLHSzkJ/fGJqoqG6QSYvllr4BKCL7/CJ3SacdQz/m+p+
         AhDwDPxB0/uKlIJF5AwR0pfuXCcnLKnM8244T0fPZcsG9la/X7GmdpmmkWPD+KTYtIxQ
         IcTbdWiRUMpjptIcDMrW9bAHCb89sws3z9F8BcYhK6Cqr7PqMKRVU1GALg89GbV+nFkq
         zQ3yuzV9cBpibkPtAmkQ+zijtADHM+aUnmJgT7QZwalu1gQc9+GikFp0WmR0BziyYhyg
         Nggjyml9dF535wrmlRjxjRezhXh0oXpAmKlaLisMblrtoSzYFQamzYreK0Wz/hqErwF0
         MZnA==
X-Gm-Message-State: AOJu0Ywr/IaGbVdPE0nZsyVFn3bHuxvIC+7ESWwlKH9f+rt9i+nEb00j
        IKvLNfm9LwZN+ETF0GU2wao=
X-Google-Smtp-Source: AGHT+IFIucVq/Ad+FCHssDPbCMwr4B9Zz+8RCfmeVFjlA7QUKRwCAc/TaISJtgr2H0CzQ9O+7oS1Ow==
X-Received: by 2002:a2e:6a12:0:b0:2c9:e3ad:1f32 with SMTP id f18-20020a2e6a12000000b002c9e3ad1f32mr870027ljc.6.1701781332351;
        Tue, 05 Dec 2023 05:02:12 -0800 (PST)
Received: from dc78bmyyyyyyyyyyyyyby-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a2eb812000000b002ca0090a933sm801384ljo.10.2023.12.05.05.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 05:02:11 -0800 (PST)
Date:   Tue, 5 Dec 2023 15:02:02 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Subject: [PATCH v2] iio: gts-helpers: Round gains and scales
Message-ID: <37d3aa193e69577353d314e94463a08d488ddd8d.1701780964.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uXiljCFbixsG9fSe"
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


--uXiljCFbixsG9fSe
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

Finally, the loop-based implementation of the 64-bit division which is
used by GTS-helpers may be running for a _very long_ time. This patch
does also replace this implementation by a well-known variant of a 64-bit
division div64_u64().

The related discussion can be found from:
https://lore.kernel.org/all/84d7c283-e8e5-4c98-835c-fe3f6ff94f4b@gmail.com/

Do rounding when computing scales and gains.

Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---

Revision history:
v1 =3D> v2:
- fix rounding in iio_gts_get_gain()
  The iio_gts_get_gain() is accidentally doing >> 2 when it attempts to
  divide by 2. Fix this.
- use proper 64bit division div64_u64() instead of a loop and extra 32bit
  function
- Fix iio_gts_total_gain_to_scale() documentation as it's not computing
  gain.
- Add a comment on rounding logic in iio_gts_total_gain_to_scale(). It's
  fair to point out Jonathan questioned the rounding logic and suggested
  using the more of a "de-facto" method of adding divider / 2 to value
  being divided, and checking for overflow. The proper handling of the
  overflow however resulted even more confusing code (in my  subjective
  opinion) than the (more) straightforward approach of checking the size
  of the reminder and adding +1 to result when needed.

Subjahit, is there any chance you test this patch with your driver? Can
you drop the:
	if (val2 % 10)
		val2 +=3D 1;
=66rom scale setting and do you see written and read scales matching?

I did run a few Kunit tests on this change - but I'm still a bit jumpy
on it... Reviewing/testing is highly appreciated!
---
 drivers/iio/industrialio-gts-helper.c | 31 +++++++++++++++++++--------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrial=
io-gts-helper.c
index 7653261d2dc2..19091193e430 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -7,6 +7,7 @@
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/math64.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
@@ -28,28 +29,32 @@
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
-	int tmp =3D 1;
+	u64 full =3D max, half_div;
+	int tmp =3D 0;
=20
 	if (scale > full || !scale)
 		return -EINVAL;
=20
-	if (U64_MAX - full < scale) {
-		/* Risk of overflow */
-		if (full - scale < scale)
+	half_div =3D scale >> 1;
+
+	if (U64_MAX - full < half_div) {
+		/*
+		 * Would overflow when adding half_div to full. Hence we need
+		 * to subtract scale from full if full is big enough.
+		 */
+		if (full - scale <=3D half_div)
 			return 1;
=20
 		full -=3D scale;
 		tmp++;
 	}
=20
-	while (full > scale * (u64)tmp)
-		tmp++;
+	tmp +=3D div64_u64(full + half_div, scale);
=20
 	return tmp;
 }
@@ -140,10 +145,18 @@ int iio_gts_total_gain_to_scale(struct iio_gts *gts, =
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
+
+	/*
+	 * Round up if remainder is equal to or greater than the half of
+	 * the divider.
+	 */
+	if (total_gain > 1 && rem >=3D total_gain / 2)
+		tmp +=3D 1ULL;
=20
 	return iio_gts_delinearize(tmp, NANO, scale_int, scale_nano);
 }
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

--uXiljCFbixsG9fSe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmVvH0QACgkQeFA3/03a
ocX5bAf9Ea3Yt5k5zn+vkUK7WoFgugWa6icJZvdv0LOZPhOzCTJqzX6LAJ2fKlvv
+hZRY/MHXYoXtU9fXwA+lUWqYBSD4TX8ley4DUsoZL2xrwW1OyopXUUFGmMZd05U
UIGjXDtKPV7DILzAIY+RLOP1LrlIWNxqVnRSDiPup4ztVxrParmIIcG1oRee9Dcm
iAAlfdiRbKpoy+TPqUg2+BDCwwHjPyydYcAJY+yVLWUpadJsXrGWREVEXtEEk2c7
Cjt/FaaxN4FErN3sh8rMw9tlrLA3x5+/dKOF2l1RzFB4v/zieYrCeIXCM5ZA9vuE
nZwi5L2qhRpfCSLY8cLxB5byTnH1Cw==
=yk1E
-----END PGP SIGNATURE-----

--uXiljCFbixsG9fSe--
