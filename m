Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883F77CFAE9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345938AbjJSNYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345858AbjJSNYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:24:10 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C863112;
        Thu, 19 Oct 2023 06:24:08 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507c50b7c36so3350522e87.3;
        Thu, 19 Oct 2023 06:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697721846; x=1698326646; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6XTlMS7+GX23qRM9fgW0oBkKi4/d88mo4TG26yVCQlU=;
        b=MVRxRbVeDptSZdxE499zyIqIDCoR66BglmR1rlG0rlBuoUxEdWWg3OOTm5Jh1KgMnj
         PZ7T1uCBoBVzpOdvx52lyDlwKcx2hD2kPwJ+KTkb8uuL6JkDEJyfIFxaTuBG6JCE3DSN
         dpEwZ1Qu1edWFO7b/stBhXfLNV3W4Wj2uydGnZDYqbTc4ROHCrMsehlfZc235DJxVJoE
         9QX0fRTxa6DURqYfA1OoeCYGjSCKM4te2J+0gTG/S9kTW0Ukt+tXO763QZppis5f6UBq
         gEUi7hOduMWzzbXMbC3pfrzOv3UEIMxYVULdEe8VKeOq/EzU349bfkZMVFhI7MN/9WfK
         J5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697721846; x=1698326646;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6XTlMS7+GX23qRM9fgW0oBkKi4/d88mo4TG26yVCQlU=;
        b=q/263Jx7uqD3FZ/Tua/1IO4KwOlCzupYB5Q24vacqbG8/3dHTR+C8qIiDzdFK+niLC
         0+FNXu8DW6W1aGwwA6duflsePXJGJ72EwM3O4njg+HIBrjtOGmyV1uwwII2gdO4AG9Qu
         JgKb4oAK+BL71jVVITrtb4TgnQZpkPRbKRVPfX8Xux1IgJgXC998kMx/z8p6Arja2HpA
         W/FTrIoFbcKgIATGXFx9K6a/sYFa5W/7/Pz4cennCrNl2+cU8WDUcxpBFUsRq7D14Ncb
         8tIL0ClfaOoWmddGrpm00MBpbUHTnGG1/ww+GYDr214B7qN0XED9nreU8N9vpg1pMJfF
         7ZOw==
X-Gm-Message-State: AOJu0YzSCr5a+pS+59o9/vSvufSITAV1ntscOUCBLTZzYOPJ/Soqde9V
        ZysXJzfZwwOgPO3xu6aV87U=
X-Google-Smtp-Source: AGHT+IFIy7ju57cvz9D/tYYiVheOKr1pHbTihQJxulDADgNu0cX04cPb68kvrRu29Ihr8dExZgjYdQ==
X-Received: by 2002:ac2:5a1e:0:b0:507:9701:2700 with SMTP id q30-20020ac25a1e000000b0050797012700mr1399666lfn.20.1697721846098;
        Thu, 19 Oct 2023 06:24:06 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id h9-20020a197009000000b005030cef433esm1088538lfc.94.2023.10.19.06.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 06:24:05 -0700 (PDT)
Date:   Thu, 19 Oct 2023 16:23:56 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: kx022a: Fix acceleration value scaling
Message-ID: <ZTEt7NqfDHPOkm8j@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BRC617NORhFtqw3Q"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BRC617NORhFtqw3Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The IIO ABI mandates acceleration values from accelerometer to be
emitted in m/s^2. The KX022A was emitting values in micro m/s^2.

Fix driver to report the correct scale values.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reported-by: Jagath Jog J <jagathjog1996@gmail.com>
Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")

---
The fix is somewhat crude and just crops the last 3 digits (rounds) of the
scale while using IIO_VAL_INT_PLUS_NANO. I played with a thought of using
IIO_VAL_FRACTIONAL, which could have modelled the computation
G_range * g * scaling / (2^16 * scaling) - where scaling 10000 would
have allowed using g value 980665.

This would have worked fine for reporting scale and available scales -
but would be somewhat tricky when converting the user-supplied scale to
register values in write_raw().

Well, the g varies from 9.832 (poles) to 9.780 (equator) according to
some website - no proper source check done but this sounds about right -
so maybe the loss of accuracy is acceptable.

I did only very quick testing on KX022A and iio_generic_buffer. After
the patch the values seemed to be correct order of magnitude. Further
testing is appreciated :)

---
 drivers/iio/accel/kionix-kx022a.c | 37 ++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-k=
x022a.c
index 4ea3c6718ed4..971fc60efef0 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -273,17 +273,17 @@ static const unsigned int kx022a_odrs[] =3D {
  *	(range / 2^bits) * g =3D (range / 2^bits) * 9.80665 m/s^2
  *	=3D> KX022A uses 16 bit (HiRes mode - assume the low 8 bits are zeroed
  *	in low-power mode(?) )
- *	=3D> +/-2G  =3D> 4 / 2^16 * 9,80665 * 10^6 (to scale to micro)
- *	=3D> +/-2G  - 598.550415
- *	   +/-4G  - 1197.10083
- *	   +/-8G  - 2394.20166
- *	   +/-16G - 4788.40332
+ *	=3D> +/-2G  =3D> 4 / 2^16 * 9,80665
+ *	=3D> +/-2G  - 0.000598550415
+ *	   +/-4G  - 0.00119710083
+ *	   +/-8G  - 0.00239420166
+ *	   +/-16G - 0.00478840332
  */
 static const int kx022a_scale_table[][2] =3D {
-	{ 598, 550415 },
-	{ 1197, 100830 },
-	{ 2394, 201660 },
-	{ 4788, 403320 },
+	{ 0, 598550 },
+	{ 0, 1197101 },
+	{ 0, 2394202 },
+	{ 0, 4788403 },
 };
=20
 static int kx022a_read_avail(struct iio_dev *indio_dev,
@@ -302,7 +302,7 @@ static int kx022a_read_avail(struct iio_dev *indio_dev,
 		*vals =3D (const int *)kx022a_scale_table;
 		*length =3D ARRAY_SIZE(kx022a_scale_table) *
 			  ARRAY_SIZE(kx022a_scale_table[0]);
-		*type =3D IIO_VAL_INT_PLUS_MICRO;
+		*type =3D IIO_VAL_INT_PLUS_NANO;
 		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
@@ -366,6 +366,20 @@ static int kx022a_turn_on_unlock(struct kx022a_data *d=
ata)
 	return ret;
 }
=20
+static int kx022a_write_raw_get_fmt(struct iio_dev *idev,
+				    struct iio_chan_spec const *chan,
+				    long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int kx022a_write_raw(struct iio_dev *idev,
 			    struct iio_chan_spec const *chan,
 			    int val, int val2, long mask)
@@ -510,7 +524,7 @@ static int kx022a_read_raw(struct iio_dev *idev,
=20
 		kx022a_reg2scale(regval, val, val2);
=20
-		return IIO_VAL_INT_PLUS_MICRO;
+		return IIO_VAL_INT_PLUS_NANO;
 	}
=20
 	return -EINVAL;
@@ -712,6 +726,7 @@ static int kx022a_fifo_flush(struct iio_dev *idev, unsi=
gned int samples)
 static const struct iio_info kx022a_info =3D {
 	.read_raw =3D &kx022a_read_raw,
 	.write_raw =3D &kx022a_write_raw,
+	.write_raw_get_fmt =3D &kx022a_write_raw_get_fmt,
 	.read_avail =3D &kx022a_read_avail,
=20
 	.validate_trigger	=3D iio_validate_own_trigger,
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

--BRC617NORhFtqw3Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUxLecACgkQeFA3/03a
ocVJvwf9HKVfeU6NszWIyfoQdxF8uhuKnpuDaRHsUF/SY2XwL8Kwk0PeZKM9jfbc
KWw47J6bC0CQZOYbxT/rgCmckiobiDXCzJAqsyI33HN+r966FST6IsY2LUDRJiFO
1mXmv5mzXN8gv0Dow4fUDJchWq6zl8+XzXn621qttbsDsENWAxYgpfnOmf2I3XRn
2Xz46DV4XkUg3sauniWyJG5kZ3zlqazL4HpHHogrNolRgu4tJI1qjoEW+4OoNqSj
+IMHBZB0t1QWb8anqXECzvYVzEV60wwHHwHgUtchm8vfiRnsnxv5C26VmUADrMDU
MKtj4xun2ZowPCk0Lhv/uIa+8LkqBQ==
=1jdQ
-----END PGP SIGNATURE-----

--BRC617NORhFtqw3Q--
