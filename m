Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3EB76B45B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjHAMEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbjHAMDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:03:11 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772F1A1;
        Tue,  1 Aug 2023 05:02:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe389d6f19so3094235e87.3;
        Tue, 01 Aug 2023 05:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690891335; x=1691496135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dZ24obycD5mrkQpoUsQoswLpJmFabLRX8Q+g0alpa64=;
        b=c/9EB8XkZx4fheyF95mnag4F9DbjGT8wXzwdS4bzQq1QkPLYTiW2v+zHyGKCm9fZq9
         nMLkf7QQNzOdBHs4cICcBMR4v7gXBay+FrfSl5DZp2HyEyEcJSJ66H+AiK1J5J+t2njT
         FURvjTGAmnAiMtuiNsO6FQw6/+Tb9Mr+wihrP4DHHYCLpl5BeB38S4zR37IT8VgKK4sF
         6M6/nNghvI1Tj2w4Gz8VyMShcL9DR/qjnP2eTEajov3OXyxwGhdRgYflB33Ve4/tmiU/
         GHLLiEdN+lEqOV8r9RklwWRvVf7Z++fR7APSOvStAl9kBm7TF95okjyv94oB7yN4U9V+
         m+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690891336; x=1691496136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZ24obycD5mrkQpoUsQoswLpJmFabLRX8Q+g0alpa64=;
        b=Fgt+XGjMnsRtkP81grNGg4x+XcYr2bhMsING/Yr0wj5ieOd4bB4zt2a+EelZj1vpj+
         voFnoZBciJjWXAT11tMrDokN/7NAAaPdOOy+jn4Mx0s2cx+z9/fQ2R1Fxr6eTlaXaxqT
         CLIq30n/sPe4zqdB1a+ur37ku3rHT9m/n2bwgpvPpV6HJs8D6AUFKOzwfCYrcU9RopdA
         /r98Nygq2rdcV8w/KfbQ7R3goeZSz6YruNCB/zo/JlafhLmcuXAu+mIajknkuUKUGuTV
         JfVWR0KA1SSKp1frRtTNSCry++DkHePo3ZwUBc7wnn2S3T10MHlG15ZLrIpZXlXmTXsR
         tyeg==
X-Gm-Message-State: ABy/qLZvokMk2BLIAm4vKiUZhqju3BVRy1PmX21iOblz8CvTimIZ5gor
        k9KaSbkcHfxyQAKmf6cErk0UyoAggRI=
X-Google-Smtp-Source: APBJJlGUbR6qseRbOp06+srd9N+Xvbusf0qVOYUB087O49MuYDLjhZ88NAwGt7XDgRkUnS8zsVijTg==
X-Received: by 2002:a05:6512:3e02:b0:4f9:596d:c803 with SMTP id i2-20020a0565123e0200b004f9596dc803mr2817166lfv.53.1690891335344;
        Tue, 01 Aug 2023 05:02:15 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id j16-20020a19f510000000b004fe15543d31sm2501193lfb.192.2023.08.01.05.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 05:02:14 -0700 (PDT)
Date:   Tue, 1 Aug 2023 15:02:10 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Andreas Klinger <ak@it-klinger.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/8] iio: mb1232: relax return value check for IRQ get
Message-ID: <9e18cf49a8bb581a84c3fa548ea577e2a3eb840d.1690890774.git.mazziesaccount@gmail.com>
References: <cover.1690890774.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J5xUErDDa2yWVVr+"
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


--J5xUErDDa2yWVVr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

fwnode_irq_get() was changed to not return 0 anymore.

Drop check for return value 0.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

---
Revsion history:
v5 =3D>:
- No changes
v4 =3D> v5:
 - drop unnecessary data->irqnr =3D -1 assignment

The patch changing the fwnode_irq_get() got merged during 5.4:
https://lore.kernel.org/all/fb7241d3-d1d1-1c37-919b-488d6d007484@gmail.com/
This is a clean-up as agreed.
---
 drivers/iio/proximity/mb1232.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
index fb1073c8d9f7..614e65cb9d42 100644
--- a/drivers/iio/proximity/mb1232.c
+++ b/drivers/iio/proximity/mb1232.c
@@ -76,7 +76,7 @@ static s16 mb1232_read_distance(struct mb1232_data *data)
 		goto error_unlock;
 	}
=20
-	if (data->irqnr >=3D 0) {
+	if (data->irqnr > 0) {
 		/* it cannot take more than 100 ms */
 		ret =3D wait_for_completion_killable_timeout(&data->ranging,
 									HZ/10);
@@ -212,10 +212,7 @@ static int mb1232_probe(struct i2c_client *client)
 	init_completion(&data->ranging);
=20
 	data->irqnr =3D fwnode_irq_get(dev_fwnode(&client->dev), 0);
-	if (data->irqnr <=3D 0) {
-		/* usage of interrupt is optional */
-		data->irqnr =3D -1;
-	} else {
+	if (data->irqnr > 0) {
 		ret =3D devm_request_irq(dev, data->irqnr, mb1232_handle_irq,
 				IRQF_TRIGGER_FALLING, id->name, indio_dev);
 		if (ret < 0) {
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

--J5xUErDDa2yWVVr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmTI9EIACgkQeFA3/03a
ocXhWwf/Rk+MFZQNNTDcnf9QlGeY61n/OU09YlpNeDS00/n0lNKZTQ/Nrlkpe70u
U5Vqeqr894GPIWZHeZRmAp1b50+IufAHdE1rA/2amOpOrNy9jtZjyPLY496Vparv
PrvD/Mb08ZLYbTEjLBkevdOWJi67t+gVd7NTRz4VvALJL3VqGqocYjgdXoMKUE6R
UxtUavr5FIvOs3HPUuYDF78ibdALFOOXw//T18SopVxytcPyo/TnUW1kYIM9xIzg
DdfBmfLalWZwsBEVM6gX3dblrt79Vq4vkZphKVqwycaks8LBIodvuctEy+DmMx/x
HYU5ERmgvVTa7qNfgesd3ANGuKFCQw==
=OAE+
-----END PGP SIGNATURE-----

--J5xUErDDa2yWVVr+--
