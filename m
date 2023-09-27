Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019677B04C9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjI0M4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjI0M4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:56:40 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0640B19A;
        Wed, 27 Sep 2023 05:56:38 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c012232792so187939881fa.0;
        Wed, 27 Sep 2023 05:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695819396; x=1696424196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/STRLEXwyIt6rSvyA0lWIiep8SC45mkNHds5YDZ1SYA=;
        b=Rn9QyNlrhrWkLB7jAM6jmRsXmlbQ5/ak0KBrg7argOsKOAvPlkKnBPWJnY7Uo8udTy
         Wkb7YuwY68ryHlPynVg/eMBFc9Nm8IuG0VHwebtuj9TgN7eXbvf/X/eeH0YjoudCTBHY
         2LGIz9V6KTA7AwhZclirOVZTOJ61UvA+XsjQcs4Zwwq927GzIRzNJafgCmAviEZ/wmGi
         Cg7nbgyFiKujUjK9uYvWE4o1CsYxmSjN/0nsmYWkw/QWvhRXIbKel5v3/krfXIqEUBeo
         LiPFxF8EpAEYqoPfqHxDNnAq8+PzGGdwKnk25swVPruWrbqMO9pF93oVYibz9AiKcfvK
         X9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695819396; x=1696424196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/STRLEXwyIt6rSvyA0lWIiep8SC45mkNHds5YDZ1SYA=;
        b=SOQv5QiKziKvpjRvZZjXsl3sAQ1EMSRZX2EAn6hgLm/vl13GGIVgzwxsxBJ2sy4XPV
         g3WngOgj1QiuFBe20hk1rQy9GxmQgNizNDuuG+dNVbSvf4n42397Ppc1Hs0KfLqy4tbQ
         Y+7WwZo6Bq00lFAZc9c650Ay2URJq2s6t0MPTUED/uobcnAZB7nCOZdoJttoDzyCj490
         Xh/B8UnRYvjVdKPnrPy6yOPrRiOkODR0yXJzYAgdp7711vS9PakWYqrkiMYZaIDL80kp
         CB7cnDJPNKE6nsR6fnWx4EEzOadXHuZP78W2rWXvmUT/tGqQD00mQUrpUOftq0BI2CBp
         O3WA==
X-Gm-Message-State: AOJu0YzlB4zGXv70FcCo13/Pt0p3oz3vUeMNPMq0O8P7cYCVldRgRZ2L
        22ncltSXe00y/Hewrm5oTAA=
X-Google-Smtp-Source: AGHT+IH67VMmt4/1etE9oRhfSXdZIyp8eZNkM9j2AckPHC6ADGBkMV/PB8fvl8SPGrKChjuY3bux9g==
X-Received: by 2002:a2e:be2c:0:b0:2b9:ed84:b2bf with SMTP id z44-20020a2ebe2c000000b002b9ed84b2bfmr2313467ljq.33.1695819396388;
        Wed, 27 Sep 2023 05:56:36 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id x6-20020a2e9c86000000b002ba045496d0sm3124231lji.125.2023.09.27.05.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 05:56:35 -0700 (PDT)
Date:   Wed, 27 Sep 2023 15:56:31 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: kx022a: Support ROHM KX132ACR-LBZ
Message-ID: <3bc7431c7899b166d26b1c8d8f85914a5727b16a.1695819243.git.mazziesaccount@gmail.com>
References: <cover.1695819243.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mVKuIT202DlejtgO"
Content-Disposition: inline
In-Reply-To: <cover.1695819243.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mVKuIT202DlejtgO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

dt-bindings: iio: Add KX132ACR-LBZ accelerometer

ROHM KX132ACR-LBZ is an accelerometer for industrial applications. It
has a subset of KX022A functionalities, dropping support for tap, free
fall and tilt detection engines. Also, the register interface is an exact
subset of what is found on KX022A (except the WHO_AM_I register value).

Add support for KX132ACR-LBZ.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/accel/kionix-kx022a-i2c.c |  4 +++-
 drivers/iio/accel/kionix-kx022a-spi.c |  4 +++-
 drivers/iio/accel/kionix-kx022a.c     | 34 ++++++++++++++++++++++++++-
 drivers/iio/accel/kionix-kx022a.h     |  2 ++
 4 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kion=
ix-kx022a-i2c.c
index fc53e527cae0..8a1d4fc28ddd 100644
--- a/drivers/iio/accel/kionix-kx022a-i2c.c
+++ b/drivers/iio/accel/kionix-kx022a-i2c.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2022 ROHM Semiconductors
  *
- * ROHM/KIONIX KX022A accelerometer driver
+ * ROHM/KIONIX accelerometer driver
  */
=20
 #include <linux/i2c.h>
@@ -38,6 +38,7 @@ static int kx022a_i2c_probe(struct i2c_client *i2c)
 static const struct i2c_device_id kx022a_i2c_id[] =3D {
 	{ .name =3D "kx022a", .driver_data =3D (kernel_ulong_t)&kx022a_chip_info =
},
 	{ .name =3D "kx132-1211", .driver_data =3D (kernel_ulong_t)&kx132_chip_in=
fo },
+	{ .name =3D "kx132acr-lbz", .driver_data =3D (kernel_ulong_t)&kx132acr_ch=
ip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
@@ -45,6 +46,7 @@ MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
 static const struct of_device_id kx022a_of_match[] =3D {
 	{ .compatible =3D "kionix,kx022a", .data =3D &kx022a_chip_info },
 	{ .compatible =3D "kionix,kx132-1211", .data =3D &kx132_chip_info },
+	{ .compatible =3D "rohm,kx132acr-lbz", .data =3D &kx132acr_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, kx022a_of_match);
diff --git a/drivers/iio/accel/kionix-kx022a-spi.c b/drivers/iio/accel/kion=
ix-kx022a-spi.c
index e7878ba67827..f798b964d0b5 100644
--- a/drivers/iio/accel/kionix-kx022a-spi.c
+++ b/drivers/iio/accel/kionix-kx022a-spi.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2022 ROHM Semiconductors
  *
- * ROHM/KIONIX KX022A accelerometer driver
+ * ROHM/KIONIX accelerometer driver
  */
=20
 #include <linux/interrupt.h>
@@ -38,6 +38,7 @@ static int kx022a_spi_probe(struct spi_device *spi)
 static const struct spi_device_id kx022a_id[] =3D {
 	{ .name =3D "kx022a", .driver_data =3D (kernel_ulong_t)&kx022a_chip_info =
},
 	{ .name =3D "kx132-1211", .driver_data =3D (kernel_ulong_t)&kx132_chip_in=
fo },
+	{ .name =3D "kx132acr-lbz", .driver_data =3D (kernel_ulong_t)&kx132acr_ch=
ip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, kx022a_id);
@@ -45,6 +46,7 @@ MODULE_DEVICE_TABLE(spi, kx022a_id);
 static const struct of_device_id kx022a_of_match[] =3D {
 	{ .compatible =3D "kionix,kx022a", .data =3D &kx022a_chip_info },
 	{ .compatible =3D "kionix,kx132-1211", .data =3D &kx132_chip_info },
+	{ .compatible =3D "rohm,kx132acr-lbz", .data =3D &kx132acr_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, kx022a_of_match);
diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-k=
x022a.c
index c5b555094e60..60864be3a667 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2022 ROHM Semiconductors
  *
- * ROHM/KIONIX KX022A accelerometer driver
+ * ROHM/KIONIX accelerometer driver
  */
=20
 #include <linux/delay.h>
@@ -1188,6 +1188,38 @@ const struct kx022a_chip_info kx132_chip_info =3D {
 };
 EXPORT_SYMBOL_NS_GPL(kx132_chip_info, IIO_KX022A);
=20
+/*
+ * Despite the naming, KX132ACR-LBZ is not similar to KX132-1211 but it is
+ * exact subset of KX022A. KX132ACR-LBZ is meant to be used for industrial
+ * applications and the tap/double tap, free fall and tilt engines were
+ * removed. Rest of the registers and functionalities (excluding the ID
+ * register) are exact match to what is found in KX022.
+ */
+const struct kx022a_chip_info kx132acr_chip_info =3D {
+	.name				=3D "kx132acr-lbz",
+	.regmap_config			=3D &kx022a_regmap_config,
+	.channels			=3D kx022a_channels,
+	.num_channels			=3D ARRAY_SIZE(kx022a_channels),
+	.fifo_length			=3D KX022A_FIFO_LENGTH,
+	.who				=3D KX022A_REG_WHO,
+	.id				=3D KX132ACR_LBZ_ID,
+	.cntl				=3D KX022A_REG_CNTL,
+	.cntl2				=3D KX022A_REG_CNTL2,
+	.odcntl				=3D KX022A_REG_ODCNTL,
+	.buf_cntl1			=3D KX022A_REG_BUF_CNTL1,
+	.buf_cntl2			=3D KX022A_REG_BUF_CNTL2,
+	.buf_clear			=3D KX022A_REG_BUF_CLEAR,
+	.buf_status1			=3D KX022A_REG_BUF_STATUS_1,
+	.buf_read			=3D KX022A_REG_BUF_READ,
+	.inc1				=3D KX022A_REG_INC1,
+	.inc4				=3D KX022A_REG_INC4,
+	.inc5				=3D KX022A_REG_INC5,
+	.inc6				=3D KX022A_REG_INC6,
+	.xout_l				=3D KX022A_REG_XOUT_L,
+	.get_fifo_bytes_available	=3D kx022a_get_fifo_bytes_available,
+};
+EXPORT_SYMBOL_NS_GPL(kx132acr_chip_info, IIO_KX022A);
+
 int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_inf=
o *chip_info)
 {
 	static const char * const regulator_names[] =3D {"io-vdd", "vdd"};
diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-k=
x022a.h
index 35c548ae7eff..7060438ad88c 100644
--- a/drivers/iio/accel/kionix-kx022a.h
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -13,6 +13,7 @@
=20
 #define KX022A_REG_WHO		0x0f
 #define KX022A_ID		0xc8
+#define KX132ACR_LBZ_ID		0xd8
=20
 #define KX022A_REG_CNTL2	0x19
 #define KX022A_MASK_SRST	BIT(7)
@@ -186,5 +187,6 @@ int kx022a_probe_internal(struct device *dev, const str=
uct kx022a_chip_info *chi
=20
 extern const struct kx022a_chip_info kx022a_chip_info;
 extern const struct kx022a_chip_info kx132_chip_info;
+extern const struct kx022a_chip_info kx132acr_chip_info;
=20
 #endif
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

--mVKuIT202DlejtgO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUUJn8ACgkQeFA3/03a
ocXzdQf+MHm5d2R3pgvd9C36eoYg7iZ0bV4wE4r6xb0o9gtvkq8d2LaDWSA7ExhJ
Bfd3tvUdoRf7eVk9d+dz0fxmIJZN6opF9zTmQG1YCjAlrPqnOQVfbRQYK271Ixtd
8HN8/XRsvqxDoa/Pio/uIOFykJZLIS04ji9pvx4mv4/JDtiIieY8gP3rsGM3HEyu
03O97tu/icmHAMQfKyLIAZ5O9ORLI4P2W8nlcuPqHsfY004DaJTaNVpgc3cr1b2B
CUdAbc063jeqeZZYCVutrZZ4V8rs4xP0jpRPM7rFHWZc+pCS/MF1K3v4mJjeQm+7
Ryn4r4GMCAgGvqoQFrgs8bnSx3Whsg==
=D1bq
-----END PGP SIGNATURE-----

--mVKuIT202DlejtgO--
