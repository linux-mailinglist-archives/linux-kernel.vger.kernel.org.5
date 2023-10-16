Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFE57CA63B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjJPLEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjJPLEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:04:48 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AC083;
        Mon, 16 Oct 2023 04:04:45 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9338e4695so56404741fa.2;
        Mon, 16 Oct 2023 04:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697454283; x=1698059083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ObaxegcvjsoLKomQ1Ky2UBtwCdZ2TFoAamPpr5FM/xc=;
        b=GvSIQKBRwcxDTg8KI7Ak0YCJR8s+xyBkq/Oq6xAt2oteibvRKDgYucMzxP82iodYX2
         2HOJNNMS2wZCWvzWAoD1z3VxULDHNETbUn9RrTOnQpAfC2OkXzqczOjGxgVbUyGXpHfB
         sglr0IfZAr+bYXF4drKy19gQQxSYbPpuiouuyeJ8zQ8z19AMWE4kEd2M5GkW4Z/Jdr+I
         lOULbSl6JQXp4SFfn3voNsE/XFYZP+0dwkhj6dELhnuKWGbpMbfGMeo9OsnRPwNMlCzE
         sbmTWLojvJO6nm+S0b8ZFd3TfjylgfO4uUAg7z7q1T2kn/gT7HYiMdl9GTYArw8iyOIr
         ukmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697454283; x=1698059083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObaxegcvjsoLKomQ1Ky2UBtwCdZ2TFoAamPpr5FM/xc=;
        b=rv/0EiBvXLd+7vo23NAJKiYcTzfwVC/3N/1nKvgoEOz4a+/gn3BbFHPm4Iru/msHnN
         c8N+STWUd/anCuugSg0aFNewlry0TnSAskDsbdqkNWXaYbKY2MwBEouXvryRSlk71mP4
         7uvJCHsnWTxgQUS/y+4qrrJzdCVwFb9+Ixyu1Ljl3lK/SsvtQZf+gvbSWiD0+vtsRNTh
         823tbiTUjfj5mz92cQ5tFha6lkjoda+hzeJlsWcaI0SyZVU8qLYjrfuFRZAwz7eS60mY
         fHwFAky7/gGqEhCT++OerFpARdKoErRnJNjK1cHDK0lgskmhUtl8+rBcSWv4tVuWiK8c
         DNPg==
X-Gm-Message-State: AOJu0Yzwk0CgLGBiSiBCXm/ItUNFCGj+X3MSFp9PEnijSDcK4Nytr537
        g++soCWoNQVYGPcrZJDtHvY=
X-Google-Smtp-Source: AGHT+IFCkrIRiAWjfbalE3brfGOaKtbBei1dfBcUlLWku+Ie1BCX1DNv3w86cJlE4VM3AL5oa0YWSg==
X-Received: by 2002:a2e:3817:0:b0:2c5:2d16:6d94 with SMTP id f23-20020a2e3817000000b002c52d166d94mr829670lja.47.1697454283467;
        Mon, 16 Oct 2023 04:04:43 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id q3-20020a2e2a03000000b002c5050d6c75sm1264224ljq.90.2023.10.16.04.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 04:04:42 -0700 (PDT)
Date:   Mon, 16 Oct 2023 14:04:39 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] iio: sanity check available_scan_masks array
Message-ID: <e55ef0b26a6d3b323bab24920c131c79a01ba08e.1697452986.git.mazziesaccount@gmail.com>
References: <cover.1697452986.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8bxqBeB/gWSXMIrc"
Content-Disposition: inline
In-Reply-To: <cover.1697452986.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8bxqBeB/gWSXMIrc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When IIO goes through the available scan masks in order to select the
best suiting one, it will just accept the first listed subset of channels
which meets the user's requirements. If driver lists a mask which is a
subset of some of the masks previously in the array of
avaliable_scan_masks, then the latter one will never be selected.

Add a warning if driver registers masks which can't be used due to the
available_scan_masks-array ordering.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision History:
v1 =3D> v2:
 - warn if masklength of available_scan_masks is wider than a long
 - drop unnecessary comment and extra blank line

NOTE: the v2 was compile-tested only.

The change was suggested by Jonathan here:
https://lore.kernel.org/lkml/20230924170726.41443502@jic23-huawei/
---
 drivers/iio/industrialio-core.c | 63 +++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-cor=
e.c
index c77745b594bd..34e1f8d0071c 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1896,6 +1896,66 @@ static int iio_check_extended_name(const struct iio_=
dev *indio_dev)
=20
 static const struct iio_buffer_setup_ops noop_ring_setup_ops;
=20
+static void iio_sanity_check_avail_scan_masks(struct iio_dev *indio_dev)
+{
+	unsigned int num_masks, masklength, longs_per_mask;
+	const unsigned long *av_masks;
+	int i;
+
+	av_masks =3D indio_dev->available_scan_masks;
+	masklength =3D indio_dev->masklength;
+	longs_per_mask =3D BITS_TO_LONGS(masklength);
+
+	/*
+	 * The code determining how many available_scan_masks is in the array
+	 * will be assuming the end of masks when first long with all bits
+	 * zeroed is encountered. This is incorrect for masks where mask
+	 * consists of more than one long, and where some of the available masks
+	 * has long worth of bits zeroed (but has subsequent bit(s) set). This
+	 * is a safety measure against bug where array of masks is terminated by
+	 * a single zero while mask width is greater than width of a long.
+	 */
+	if (longs_per_mask > 1)
+		dev_warn(indio_dev->dev.parent,
+			 "multi long available scan masks not fully supported\n");
+
+	if (bitmap_empty(av_masks, masklength))
+		dev_warn(indio_dev->dev.parent, "empty scan mask\n");
+
+	for (num_masks =3D 0; *av_masks; num_masks++)
+		av_masks +=3D longs_per_mask;
+
+	if (num_masks < 2)
+		return;
+
+	av_masks =3D indio_dev->available_scan_masks;
+
+	/*
+	 * Go through all the masks from first to one before the last, and see
+	 * that no mask found later from the available_scan_masks array is a
+	 * subset of mask found earlier. If this happens, then the mask found
+	 * later will never get used because scanning the array is stopped when
+	 * the first suitable mask is found. Drivers should order the array of
+	 * available masks in the order of preference (presumably the least
+	 * costy to access masks first).
+	 */
+	for (i =3D 0; i < num_masks - 1; i++) {
+		const unsigned long *mask1;
+		int j;
+
+		mask1 =3D av_masks + i * longs_per_mask;
+		for (j =3D i + 1; j < num_masks; j++) {
+			const unsigned long *mask2;
+
+			mask2 =3D av_masks + j * longs_per_mask;
+			if (bitmap_subset(mask2, mask1, masklength))
+				dev_warn(indio_dev->dev.parent,
+					 "available_scan_mask %d subset of %d. Never used\n",
+					 j, i);
+		}
+	}
+}
+
 int __iio_device_register(struct iio_dev *indio_dev, struct module *this_m=
od)
 {
 	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
@@ -1934,6 +1994,9 @@ int __iio_device_register(struct iio_dev *indio_dev, =
struct module *this_mod)
 		goto error_unreg_debugfs;
 	}
=20
+	if (indio_dev->available_scan_masks)
+		iio_sanity_check_avail_scan_masks(indio_dev);
+
 	ret =3D iio_device_register_sysfs(indio_dev);
 	if (ret) {
 		dev_err(indio_dev->dev.parent,
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

--8bxqBeB/gWSXMIrc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUtGMcACgkQeFA3/03a
ocWc6ggAgsgG4iYLDuDEr6eVvTcqjvuBAQ1SouEEuOLN/HmdNDa0th1UGMnx0MNj
WPtWwUzttg//iFcRGnlcT2m6ayyQYnCS/wMA/9vWO9TemlqgMCDKweoMLEEFK9kS
KlKpRbsgCloCje1I0PCNMoXsBgjtuUgIugZ5Q4vjW3v5OHiuypIsWqndfW4kvnCc
EAYiWODXyEc5kAAKDaTb23qCHS9WwboxYlbulIPEFakjM57frOCI/VPIdH7TP3jd
b6cTry+lEgl9p3wzJ4coTW5ooIbixRYjweVba2gC4cZdKU4jIqQ6kY6zDhs9H/Mw
U0O7OLKpugO50ydZR4ayXnVumd0rIA==
=X4L6
-----END PGP SIGNATURE-----

--8bxqBeB/gWSXMIrc--
