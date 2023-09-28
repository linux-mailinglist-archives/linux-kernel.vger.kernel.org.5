Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B827B164C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjI1Ip4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjI1Ipu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:45:50 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5128AB7;
        Thu, 28 Sep 2023 01:45:46 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c16bc71e4cso108624921fa.0;
        Thu, 28 Sep 2023 01:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695890744; x=1696495544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=50z2MEUhAPtqMgr4yb84Qg2LVyVTcD2ZWZZsvEtxjSs=;
        b=QJF7C+6dBNexSQYn56wTFlp6bGfP9U6D8KJP2RTqa5Rixtq8OTMixFpEaGDGq984h4
         ypThsIKGbKpngEToMI94qa7upDJDHj8KTupGtvk+IM7gl7M0/foe3dQEpvoCmy+GN+Zt
         +8r3RQa6qctd1ilhSidIYukAnGo5tvwn02DtKoLUEbiY3OOx6jhWT3VjYSAeJboJp5Fi
         iWd/wrAU2/M7anPGFbE9v6u1Bmc3/COXKhYRubzM5kbwWDfSoq3Z+R0Wp0i+GrMYBN4O
         3e58qr+/P6py9pz1pzGb4pGZ/5IPI0T6mBD8bB3YZL0KeVhXDPpQx+YE2rAaekaItJ87
         +Ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695890744; x=1696495544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50z2MEUhAPtqMgr4yb84Qg2LVyVTcD2ZWZZsvEtxjSs=;
        b=XZYm+9qcBu9kABuGl4Q2UiJF/0OBT6DYN0AufmtXoVordtLhul2/zkm5CMfEHrbfw8
         1isUXZ5/xq33/8XTUNOT2klNGZr4MNqXt9mg8a3OJwFrTczSYD5LE1wzMk5NRDdtc2b3
         fxR/961nFoFbHzaAj8d6H+C3RAbl71Gniez9JWoA28YrMmK4S/wrrSEbAYn19o2dpeYx
         SNbSaJhjBP4jjZYMCc9v6CxBd7vExRBf8ZeDQSTdP01g8m2+QxQcg73y7E1z18jSOv1d
         XWy2Q5llxKV8rQ/Eb0Em6X0XQzqVxM3yXY/ZN6DinlTFQhiPLXCQlN0XmSAOaxQ6W5h4
         Aeiw==
X-Gm-Message-State: AOJu0YzlFnmuftK5lz/NwCPnF73jOS9J8p/pLYNnN9MKWiyc9hTsyRzi
        NkCJXjjSjNvAyw8v2/PwcHE=
X-Google-Smtp-Source: AGHT+IFTZPq9NKygHXkvsgphakOeGT4miEW5q8OLmo5JY59/YJhaUF0iCR/Q6rWyABv/pCKKzWmU8Q==
X-Received: by 2002:a2e:9698:0:b0:2c0:a0c:120a with SMTP id q24-20020a2e9698000000b002c00a0c120amr661733lji.25.1695890744303;
        Thu, 28 Sep 2023 01:45:44 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id f13-20020a2ea0cd000000b002c029a4b681sm3511917ljm.15.2023.09.28.01.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 01:45:43 -0700 (PDT)
Date:   Thu, 28 Sep 2023 11:45:39 +0300
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
Subject: [PATCH v2 2/2] iio: kx022a: Support ROHM KX132ACR-LBZ
Message-ID: <272065b9f35b817aff86b7760ff1aaaaaaa969f5.1695879676.git.mazziesaccount@gmail.com>
References: <cover.1695879676.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NB2KxAcFsF2+M6hw"
Content-Disposition: inline
In-Reply-To: <cover.1695879676.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NB2KxAcFsF2+M6hw
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

Revision history:
v1 =3D> v2:
 - Added KX132ACR-LBZ as supported IC to Kconfig
---
 drivers/iio/accel/Kconfig             |  4 ++--
 drivers/iio/accel/kionix-kx022a-i2c.c |  4 +++-
 drivers/iio/accel/kionix-kx022a-spi.c |  4 +++-
 drivers/iio/accel/kionix-kx022a.c     | 34 ++++++++++++++++++++++++++-
 drivers/iio/accel/kionix-kx022a.h     |  2 ++
 5 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 373257d64a7e..f113dae59048 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -420,7 +420,7 @@ config IIO_KX022A_SPI
 	help
 	  Enable support for the Kionix digital tri-axis accelerometers
 	  connected to SPI interface. Supported devices are:
-	    KX022A, KX132-1211
+	    KX022A, KX132-1211, KX132ACR-LBZ
=20
 config IIO_KX022A_I2C
 	tristate "Kionix KX022A tri-axis digital accelerometer I2C interface"
@@ -430,7 +430,7 @@ config IIO_KX022A_I2C
 	help
 	  Enable support for the Kionix digital tri-axis accelerometers
 	  connected to I2C interface. Supported devices are:
-	    KX022A, KX132-1211
+	    KX022A, KX132-1211, KX132ACR-LBZ
=20
 config KXSD9
 	tristate "Kionix KXSD9 Accelerometer Driver"
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

--NB2KxAcFsF2+M6hw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUVPTMACgkQeFA3/03a
ocVelQf/am1Mg0p5ijdZIcuiKiVy/FRRhuZtlRyrte1DGTmjl3h1nKl7/SazDRXL
dcZebkLbtnZdZDNnjbiFNTrNOfPPtJpqx2WULYXAHwpulp0RdLnJRVU8NX87iVPN
LDNfGd/LR0O+jEzzNDJkJc4CsKxFmX0ZOaxc8yAfTmAsd6rjIauRP17iS3sUeFmh
v2ZsShOf0glny2qf2aTVMAcbGB0d9A83HjGL9waiCZX7YsRgqawhvIswNCQfhuzt
hNZU6B5iFQCy4SNfgB3FMqjV3mcg83xIBK49Xcw9jwmgf6AXiUPQDPKUm/UfOxbm
rekC8QvK+Ovzv2ZaK2jGKEkLxdQeYQ==
=6f9/
-----END PGP SIGNATURE-----

--NB2KxAcFsF2+M6hw--
