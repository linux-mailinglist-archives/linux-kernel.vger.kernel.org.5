Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C8276B450
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjHAMES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjHAMD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:03:57 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB221990;
        Tue,  1 Aug 2023 05:03:56 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe0c566788so9199398e87.0;
        Tue, 01 Aug 2023 05:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690891435; x=1691496235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aE2psrYzSQU8So7H2lqtVFtbvK/aQHA4jm0AH9xBQUo=;
        b=Kt2466pEvz8QaUHjluSm/1dxuyp5VUaPGYzBbsiHrWYAi28e53FJAF2TG6wXZjkoRq
         4K3o/fh0Ey5kPHKhL83Qgt+m1uJ3DigTwKl4ZtFQv8D2Fw+OzaF6FNbFQwjvw1ARdSII
         Qre33ysDCX60hrAa80VBLKIUGbdDo+uGWUnw5/ff4fpn/P5pcE1yzA4DFl5O7MedHNFQ
         c1vEj04FMU/DDpJmuS6vmT1GDdc2LyKc4r6tvsy6ioK83tVpwJ4V6hbKT36OKP4Il5BF
         towKWW6NwstJ9TTE7D2IZPQyIGxhaqh3AGE/G3G1myGVKCBsZfMIu6Kwq5+qEQOY8IDx
         qJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690891435; x=1691496235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aE2psrYzSQU8So7H2lqtVFtbvK/aQHA4jm0AH9xBQUo=;
        b=PQvcKgGgmwkARU0g8KUQZNpdQAkDtdWm2lBK+yG0Nd39F0J4u/oS7DwRqMrWtRYDFw
         egMF82wpeSps7gYcAWNeCmw3os8ReUDD7wnXbUqfGtL1ApA2AvOxkxCG42bjoLarVcSA
         JotjkamadjYhi5NA8iwNKFEps284vewq1w2slEk8cs9NQh+OtIo3Z0Yi4P6HegkI99LG
         tsyw1G8oRK25h8HH3nZET8zeeOmpdORGbzRpW+m7rzUp0UHBhKLZE0L6FqT0vbZGtPQ2
         EHPkvcllhZM+wWULeAW/DuvjgruyJ83ERmGzcT/2/qgDQXFE/Q+iZkUzlpWIfmkSwLih
         ClWw==
X-Gm-Message-State: ABy/qLZSTl1Pcy1guhwqykWGJIta82ToDlDil/xTNd8cXH//DiMN2XGX
        HeWGSIyab1LoLRlNr4A5raqdywzkIe4=
X-Google-Smtp-Source: APBJJlG/vaA70Oy4b5vd7KmQuDtolMU4Sk6ht7mghTudw2X9PvGItUQ0DzoVxhgLpnub52sLgPS18g==
X-Received: by 2002:a19:7b12:0:b0:4fe:958:88ac with SMTP id w18-20020a197b12000000b004fe095888acmr2062862lfc.6.1690891434702;
        Tue, 01 Aug 2023 05:03:54 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id b21-20020ac25635000000b004fe0ec5596bsm2542136lff.54.2023.08.01.05.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 05:03:54 -0700 (PDT)
Date:   Tue, 1 Aug 2023 15:03:50 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 5/8] pinctrl: pistachio: relax return value check for IRQ
 get
Message-ID: <5077c4df68da920ab1119d6332878d0d31dc6d1b.1690890774.git.mazziesaccount@gmail.com>
References: <cover.1690890774.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EcOrXqBb1q4t+H8h"
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


--EcOrXqBb1q4t+H8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

fwnode_irq_get[_byname]() were changed to not return 0 anymore.

Drop check for return value 0.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Revision history:
 - No changes

Please note, I took Linus' reply to v4 cover-letter as ack && added the
tag. Please let me know if this was not Ok.

The patch changing the fwnode_irq_get() got merged during 5.4:
https://lore.kernel.org/all/fb7241d3-d1d1-1c37-919b-488d6d007484@gmail.com/
This is a clean-up as agreed.
---
 drivers/pinctrl/pinctrl-pistachio.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-pistachio.c b/drivers/pinctrl/pinctrl-=
pistachio.c
index 53408344927a..8c50e0091b32 100644
--- a/drivers/pinctrl/pinctrl-pistachio.c
+++ b/drivers/pinctrl/pinctrl-pistachio.c
@@ -1393,12 +1393,6 @@ static int pistachio_gpio_register(struct pistachio_=
pinctrl *pctl)
 			dev_err(pctl->dev, "Failed to retrieve IRQ for bank %u\n", i);
 			goto err;
 		}
-		if (!ret) {
-			fwnode_handle_put(child);
-			dev_err(pctl->dev, "No IRQ for bank %u\n", i);
-			ret =3D -EINVAL;
-			goto err;
-		}
 		irq =3D ret;
=20
 		bank =3D &pctl->gpio_banks[i];
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

--EcOrXqBb1q4t+H8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmTI9KYACgkQeFA3/03a
ocXp3Af/dbshHL9gw7UQfzj41PPmapFb61j6WsVWG5ToE4fmmhBeL4x4uTa0I7q+
WmPQbd3h9xarup2OvyJyYqJcSUaI1Hr+lahqjClJ+w/3R8DLvn6loMCB2nqUN7RN
FSeLXKsYEKzvi+YhO7oFT1DXGVSmRN23UMsFewQpoSAputPZw1SAmsJrHMMFVZ9+
qzwVMiYyVp+RGl/NBKclTyHrgzpsO/Rkw0HHHFBRBHjGqvhcoZMi4LaI8DUI5uW7
nuFJFH+gzv/g8C9keHpF6FvCDPaepQlMobKcIe6hPFKK/MfDgrEDKfbnN5zwWDR/
wZI21+vRp0q69fmPX65+xAgnOU7sTw==
=zKCo
-----END PGP SIGNATURE-----

--EcOrXqBb1q4t+H8h--
