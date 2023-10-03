Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391837B65DE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239795AbjJCJuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjJCJuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:50:02 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E64A6;
        Tue,  3 Oct 2023 02:49:59 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50306b2920dso834340e87.0;
        Tue, 03 Oct 2023 02:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696326597; x=1696931397; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PeiBiJEI2N9fhcYpDpgV3rBn3MtISs9Q/BTF3zD9mvU=;
        b=BDiD+2CK57wAOfhJD05q4J36vsQZ/MnegMz1NuA7lx1+6Rx2TP3XIdQZSGd0xQeaRr
         +4UTGSf017405TvWI7mE6tosayrh2mccodwMcl+cTNrhJqBzvJk8jmJEfgUgp/UIBkzc
         JQLiYp1JIV+Min8NEpsADuyYMRXrXVmwRiZyYc4nhdv38H9sCV9Lw8qmooSbZcahXIJE
         dYX7olvcE0ih8HGxWOliqYCqOYKbmrOCwz/BJBaIKAS7p7e482NPP2KNWtgwDr8O7+F1
         XpjB5kWY4qL0TM8Za1w6b47DNpEHX+9PD/WYrK9fiAOh/t3QLb9n0jf5h4t2f14cJP3W
         k7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696326597; x=1696931397;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PeiBiJEI2N9fhcYpDpgV3rBn3MtISs9Q/BTF3zD9mvU=;
        b=Sn6/l7iEW7Lcwtthh2LmszNwza/jehAy2+PyjMLaQlmq79qs1sNjUqm1/zzvVAG8Ll
         +RAVCDKY7RfWyBk2wcgyK6pXDJOE3HEVOWjGDLjXwxxPfJcFa0MSifa+S3B2HPZkI+5i
         MJ5q0BR9GVuA02sQBNtV90QH7zqmcBrlRtmq5BL1tMhf5ZhbeFDo56CxMZHoxXqOomKT
         ppqfZNcnSgyk0akZPldtMqF76AQ/F0lMKaZQ/V9CM97mr97v+2w2MRACLlv8GqQ/qURK
         n8TpHT988ydmLFPgmlin+8ktsibpPSaUVI0Qa0ofjToXUVJHoJ3nWorGA2y7oNCWSqXI
         I4rA==
X-Gm-Message-State: AOJu0YyOxPmnS3zOcNXMMkaF4/wRLHjXQY8gF6i0JMaMJsDX5jC9eMqh
        GxLk/QN+Ee3mvbD+wB3OvIc=
X-Google-Smtp-Source: AGHT+IHtpQ4h7YNXn/oFUjpSiSUAOM968uMTwdcdy9ImujjU3Db1Ea7yuNBHPqtfBzBZBKauD4GEcg==
X-Received: by 2002:a05:6512:3189:b0:504:33cd:ad1 with SMTP id i9-20020a056512318900b0050433cd0ad1mr1542420lfe.27.1696326596437;
        Tue, 03 Oct 2023 02:49:56 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id j9-20020a2e8509000000b002c021b6e82bsm170151lji.80.2023.10.03.02.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:49:55 -0700 (PDT)
Date:   Tue, 3 Oct 2023 12:49:45 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: sanity check available_scan_masks array
Message-ID: <ZRvjuZaQWdZw1U1I@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Xt8lz5EDqjSsd/g8"
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


--Xt8lz5EDqjSsd/g8
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
The change was suggested by Jonathan here:
https://lore.kernel.org/lkml/20230924170726.41443502@jic23-huawei/
---
 drivers/iio/industrialio-core.c | 57 +++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-cor=
e.c
index c77745b594bd..d4f37f4eeec0 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1896,6 +1896,53 @@ static int iio_check_extended_name(const struct iio_=
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
@@ -1934,6 +1981,16 @@ int __iio_device_register(struct iio_dev *indio_dev,=
 struct module *this_mod)
 		goto error_unreg_debugfs;
 	}
=20
+	/*
+	 * In order to not wreck utter havoc we just warn for now. Might want
+	 * to convert this to a failure after people have had time to act upon
+	 * the warning. It'd be nice to check this earlier, but we need the
+	 * iio_buffers_alloc_sysfs_and_mask() to have the masklength set.
+	 */
+	if (indio_dev->available_scan_masks)
+		iio_sanity_check_avail_scan_masks(indio_dev);
+
+
 	ret =3D iio_device_register_sysfs(indio_dev);
 	if (ret) {
 		dev_err(indio_dev->dev.parent,

base-commit: 5e99f692d4e32e3250ab18d511894ca797407aec
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

--Xt8lz5EDqjSsd/g8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUb47QACgkQeFA3/03a
ocXgIQf6A9Djw/SAEiLG/3DWYU0p1hGdcGhu+XZbbg6ISuMkZeieWldgG59OyENe
iyoksQO0RM8h3C+TIF5vw193iEh5EzR4h3Fz1uK1CbG3RWzNbhPwTnWQ5+3VbCrK
c5i+OUUncmXEltSoAbSj1e9J+ft88zr9r6wvxmXLQCLTVHN8QnFupPUA77rl3IAw
qmOKLf6E7EfxEyTzAFoEHcu1VvdQKbR8HNKIiHO/UoEdraIgekwfG8gLf/nwXJzB
RekS65AfP8sWQR2emyYsWuXDarpUXgvgU0S0wggpoREC+OdwuP6/jIBCDsulpxZk
KDwHQnfBAJT0y0LZjwQzNuGvUl5itw==
=sXlv
-----END PGP SIGNATURE-----

--Xt8lz5EDqjSsd/g8--
