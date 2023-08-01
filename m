Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9834076B448
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjHAMDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjHAMDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:03:34 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DA21BD3;
        Tue,  1 Aug 2023 05:02:53 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe463420fbso828504e87.3;
        Tue, 01 Aug 2023 05:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690891371; x=1691496171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T9RO8UlUTwn3hEH6HK6IaUASxewRiScP6UARVCA4DwU=;
        b=CbTbEjkuDxtAWmuAnL+js8Un7DPuDyWVGzTLIvCt+LmXDumdE5C361SA3H6RwvCDq5
         9EZq9crd6VtY7h7ZN08wKKdeIo+2jQI4CplVbieLrZwXGJstsKWvoMhwm07IP6HMYH3Y
         3ksD8VpUghrQlGDRFY5t8m3/3+WCGC1yzT5Gc1zFF9Z00Ixn5RjbQp2QI10KldX9Nthy
         vs12jUes6M9QTiGFlpIfSQsw1DAQe4yoxhvdQRzsPBBNZNccwiHXxixQUJV8DqQ6pMqd
         GawK7CF7/pAySWm8Ny8u6sUKy9tgvswndlcGhU66iYdSNUxWb3U4xTatoofjMwZ+OraE
         E1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690891371; x=1691496171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9RO8UlUTwn3hEH6HK6IaUASxewRiScP6UARVCA4DwU=;
        b=Uy7AHi0LxymaXhRmlS2VFRMgRCb9XxlqKZEE28J9YBte7QcKnkDS36naP/GFHPk8nq
         Xsk33BMaJZU6gCZ7cvGpMVPZVT1HikELLv0TO5IiCUEC2m3KU3bNANA7KmrF+5xIYcap
         6mAfSsjR4kzB3pw78YuxtdSP4dDxvI7XX9japHNDUtg+/SdCk8gCiGUexVXMG4K+VoDU
         jPZ1D4JK9MLRhaSVls7kMHVwNEKl5/8ynHuTgGxc6bu/XbeLXdgLUdW4N3inxT5NS8nl
         9qK2ykawn0uMvd++UBgU4OqgFqW1bucn5G59C/1CVHkgQMlT92LLOR13DEjkayiSVsby
         T0mw==
X-Gm-Message-State: ABy/qLZeIH+Mcz0mnkbIZwI204WUrz+RNJ+OXTdZzfrN0mc2sJoUjuwv
        C5D9LFqYUrhipIaOK1fmaOc=
X-Google-Smtp-Source: APBJJlH8k9qQDQnZ1nYtZrLLCdpwDqVmgDOxZJZlv3w36+eJv3zO0GNAVNtA6sXmOPXeQ9WKGgsJkg==
X-Received: by 2002:a05:6512:1141:b0:4fe:4f8:8e75 with SMTP id m1-20020a056512114100b004fe04f88e75mr2039371lfg.68.1690891371256;
        Tue, 01 Aug 2023 05:02:51 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id d12-20020a05651221cc00b004f4b42e2d7dsm2518784lft.230.2023.08.01.05.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 05:02:50 -0700 (PDT)
Date:   Tue, 1 Aug 2023 15:02:47 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/8] iio: cdc: ad7150: relax return value check for IRQ get
Message-ID: <3ad1c6f195ead3dfa8711235e1dead139d27f700.1690890774.git.mazziesaccount@gmail.com>
References: <cover.1690890774.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KY2dqMcsNm14XP28"
Content-Disposition: inline
In-Reply-To: <cover.1690890774.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KY2dqMcsNm14XP28
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

fwnode_irq_get[_byname]() were changed to not return 0 anymore. The
special error case where device-tree based IRQ mapping fails can't no
longer be reliably detected from this return value. This yields a
functional change in the driver where the mapping failure is treated as
an error.

The mapping failure can occur for example when the device-tree IRQ
information translation call-back(s) (xlate) fail, IRQ domain is not
found, IRQ type conflicts, etc. In most cases this indicates an error in
the device-tree and special handling is not really required.

One more thing to note is that ACPI APIs do not return zero for any
failures so this special handling did only apply on device-tree based
systems.

Drop the special handling for DT mapping failures as these can no longer
be separated from other errors at driver side. Change all failures in
IRQ getting to be handled by continuing without the events instead of
aborting the probe upon certain errors.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Revision history:
v5 =3D> v6:
 - Never abort the probe when IRQ getting fails but continue without
   events.

Please note that I don't have the hardware to test this change.
Furthermore, testing this type of device-tree error cases is not
trivial, as the question we probably dive in is "what happens with the
existing users who have errors in the device-tree". Answering to this
question is not simple.

The patch changing the fwnode_irq_get() got merged during 5.4:
https://lore.kernel.org/all/fb7241d3-d1d1-1c37-919b-488d6d007484@gmail.com/
This is a clean-up as agreed.
---
 drivers/iio/cdc/ad7150.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c
index d656d2f12755..4c03b9e834b8 100644
--- a/drivers/iio/cdc/ad7150.c
+++ b/drivers/iio/cdc/ad7150.c
@@ -541,6 +541,7 @@ static int ad7150_probe(struct i2c_client *client)
 	const struct i2c_device_id *id =3D i2c_client_get_device_id(client);
 	struct ad7150_chip_info *chip;
 	struct iio_dev *indio_dev;
+	bool use_irq =3D true;
 	int ret;
=20
 	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*chip));
@@ -561,14 +562,13 @@ static int ad7150_probe(struct i2c_client *client)
=20
 	chip->interrupts[0] =3D fwnode_irq_get(dev_fwnode(&client->dev), 0);
 	if (chip->interrupts[0] < 0)
-		return chip->interrupts[0];
-	if (id->driver_data =3D=3D AD7150) {
+		use_irq =3D false;
+	else if (id->driver_data =3D=3D AD7150) {
 		chip->interrupts[1] =3D fwnode_irq_get(dev_fwnode(&client->dev), 1);
 		if (chip->interrupts[1] < 0)
-			return chip->interrupts[1];
+			use_irq =3D false;
 	}
-	if (chip->interrupts[0] &&
-	    (id->driver_data =3D=3D AD7151 || chip->interrupts[1])) {
+	if (use_irq) {
 		irq_set_status_flags(chip->interrupts[0], IRQ_NOAUTOEN);
 		ret =3D devm_request_threaded_irq(&client->dev,
 						chip->interrupts[0],
--=20
2.40.1


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

--KY2dqMcsNm14XP28
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmTI9GcACgkQeFA3/03a
ocUUjwf8CSetfr27ZZjtC0oqZpp4BdR53XDzoFmfXNXgmIBejxn+1VcyY0VGK86n
4NdI/EVvuTsZuAr36tSBhy+TQzXkIVKQ4rYlyX40YQ1h5IFVSF2l/2hL2izYUTZ2
mRcICjmW5fWGvLbw+Lmk7eCoQVo3RGiwbQe8OsIx7jdp9QJ47luFi8xIL3xcL8bX
109lFBD+7WPSoyOPOrq0kHUsdj8wvIUk2zva8JM9s/cVeYQuAIZHjbV2enMCLeU9
AKvouzXwpHtBE2owtYXgrzCgo2GPHeVf2cLeO5cARQXltZouvFJoIvNouSbqcQdL
WatL9bZEndV12NS6dRRCL6lKfhM2uw==
=hVic
-----END PGP SIGNATURE-----

--KY2dqMcsNm14XP28--
