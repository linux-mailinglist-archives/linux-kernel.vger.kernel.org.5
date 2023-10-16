Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C9E7CA63D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjJPLFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjJPLFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:05:03 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22BEB4;
        Mon, 16 Oct 2023 04:05:01 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so45180711fa.3;
        Mon, 16 Oct 2023 04:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697454300; x=1698059100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N6dSXg+vWqlViQZ7pvaQOjS16WN6O2z0EqZFtWA/VVw=;
        b=X2KZusCIS/61L3auZBDPnqazMPYQlgWOr4h3RnvEFF0rjHiDH0gKK49E06eWLAsJI7
         fvyqjn42ZJczR7lHxlxJvMeRTzA6YRuqldAhMOeAbn9sQu5zKa7vMsgbeCwtYx4HbYY+
         uGY6JrxfkUSIxPIndoqekbQjiREHUxBuohH661vfKQgsM6hEw1y1/dzeCD2Ak6+Qj57Q
         X92y0tGjxhe+rM6Yq9FWgu2hoJCxhK4ORqyUula07zQZ0ZTxMgcdV5meXyZCWRjz+aE/
         nBifCFEer+6m/Y4BBEk28CFpy5g0LazYr7sF2T1not3aYw9jcUpIcjkIbWEAK37dbG4Z
         yprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697454300; x=1698059100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6dSXg+vWqlViQZ7pvaQOjS16WN6O2z0EqZFtWA/VVw=;
        b=E9hbj05H8ImFtdT/3J6NN2uuMxN1Chnm/bSQ50D91Q/poiANUrAZ2kYVfmMh1RGdqc
         wfLGGLu6AYFD3Z2QuIn597fRruXLxikM7icr2O1p4bBqAVZasZEcMXb4Z1+ADbfW+k7M
         SGOLIiVJCvwuuFBEvP2ZW5NQnTLoX7fcKDEQreHoRA/i0LJlDNoSkZPD/s8CDMJOuMkw
         XqKrjUf8WRDWAwELNt8uNpgfCffuT2+TH2/7tKZVSj+RCCcF48/v9gN1B8itQ1xpHBHt
         OHXii11twrV2Iihb2H8X4LmW16XHist7rUCL1/MxuU3ITtNCVo3G/DUU/Q5FZue8N5CU
         sADQ==
X-Gm-Message-State: AOJu0YxAyayV+f/RTXLNFngBx66Rboccp+FncrOaBeOL5REpcUGLJQky
        lIb/v7e1pMIuDpJV9zO9Ye2rRSHJBiIDEQ==
X-Google-Smtp-Source: AGHT+IE5WXbg3xeYYdwJOB/JSElE8Ux/VtDghmt9oxK+zws1wRbx2GGjHCCFwAt4t8qFpcOxxDIIiQ==
X-Received: by 2002:ac2:4247:0:b0:507:ab66:f118 with SMTP id m7-20020ac24247000000b00507ab66f118mr2549170lfl.68.1697454299865;
        Mon, 16 Oct 2023 04:04:59 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id b22-20020ac247f6000000b0050363f87c64sm4519363lfp.36.2023.10.16.04.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 04:04:58 -0700 (PDT)
Date:   Mon, 16 Oct 2023 14:04:55 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: buffer: document known issue
Message-ID: <ef61c2c1e9a1c5e9f713f656871fdcb1652afdc2.1697452986.git.mazziesaccount@gmail.com>
References: <cover.1697452986.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AmYoofSM0ro6sMkn"
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


--AmYoofSM0ro6sMkn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add documentation explaining why the code which scans all available scan
masks is checking only a single long worth of bits even though the code
was intended to be supporting masks wider than single long.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/industrialio-buffer.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-b=
uffer.c
index 176d31d9f9d8..09c41e9ccf87 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -413,6 +413,22 @@ static const unsigned long *iio_scan_mask_match(const =
unsigned long *av_masks,
 {
 	if (bitmap_empty(mask, masklength))
 		return NULL;
+	/*
+	 * The condition here do not handle multi-long masks correctly.
+	 * It only checks the first long to be zero, and will use such mask
+	 * as a terminator even if there was bits set after the first long.
+	 *
+	 * Correct check would require using:
+	 * while (!bitmap_empty(av_masks, masklength))
+	 * instead. This is potentially hazardous because the
+	 * avaliable_scan_masks is a zero terminated array of longs - and
+	 * using the proper bitmap_empty() check for multi-long wide masks
+	 * would require the array to be terminated with multiple zero longs -
+	 * which is not such an usual pattern.
+	 *
+	 * As writing of this no multi-long wide masks were found in-tree, so
+	 * the simple while (*av_masks) check is working.
+	 */
 	while (*av_masks) {
 		if (strict) {
 			if (bitmap_equal(mask, av_masks, masklength))
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

--AmYoofSM0ro6sMkn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUtGNcACgkQeFA3/03a
ocWMqggAh3OkVyVf1/GokE7MDORJJyRrq+HheDQj17woZx7SToxe3ne6m13rPfvj
5/RFOdTzCd3l8LwqKKd5Dg/1LHqLNwkmSMnxuriGRDRRmA0woHJeJfI8C2jd2DtL
pdx0cQ+k6zfgjFczu8vvrnwad1i6qZwv/5zH8XYuHDps0LfMoU7N4DasTmevLA56
3rRj0+f/AMq1npJ+cS5Uak59dgVHFm6brqCptoIMC1ZRRcWL2ym6K9dXS0Yx3BGz
I4GbC2B7rWIEs/XFVM9wWZDSi+bTAzgk2A4AUIuW9QfJ8eyEADQB2J7b87u3d+/9
TVMRW9XSRs8DE4QzzCxGzNajyPG1Hg==
=2yU6
-----END PGP SIGNATURE-----

--AmYoofSM0ro6sMkn--
