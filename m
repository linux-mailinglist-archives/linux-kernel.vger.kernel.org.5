Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A00476B44B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjHAMED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbjHAMDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:03:43 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D61173A;
        Tue,  1 Aug 2023 05:03:18 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9b9f0387dso85806121fa.0;
        Tue, 01 Aug 2023 05:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690891396; x=1691496196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UBlaVyXcRzijB9wVsQtSzeKEzoa3c6OzUppL627hjBw=;
        b=Dp+olNtZ83HKky4tQkPpItoL1j6tF9PvKT3p59x9ZfNBmmu0TfyG3TIuy6hK1f9Rha
         3aiYIsQo7odhJYsCIJkONjN0YUBgZDzXi3LI82N8CaCwO+TGficuuo8GYjvRdf64T37n
         kMwJyJ2Y18lZybPYi/ouE09kSKf2l9iHNyFQvJS9JMhHuRuS74e5vF2Losvm75sd0nqz
         BTsoc5XFbbyRDKrFZSQU+2ouda7GeyKMwgXgGLd7AGqJIkPoFDIaTgIBsgWa5a5MNrXw
         UcQZ3feLzpdqSDo+2WrDVstNwC4P84Kx8A4dq7Pz7aqh6ZJmSSYauIV/y9+bYXbr+fxG
         lB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690891396; x=1691496196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBlaVyXcRzijB9wVsQtSzeKEzoa3c6OzUppL627hjBw=;
        b=jMjylBmoiCjF1zEhTjngoOsgPJ0lPhdhGglsbtjTtz2p01pxi+sBta0yCtgwno43AI
         MUXolZdap3HBVGbH5JhMQMNgJ0fVwIbpb84aQQ7BygJ+iAktJo/+iN2mSPesPhVSGDYm
         ZPSykGpBJs8YCx/VMeJnzVZYxtTiM2rmV4vJrrN+plqrfGe1AvUm+3TbEkL5XiwqAcni
         BqIwk0pkGNlpRigwbYqtga/RliO3bN4IES4S2luGKnqTcG9a0n5BB2HdGouuoDf66p2M
         I60BsMKKANXkdZETkWF9NS7Pw5Kw7cVHT6QY42PUtjqD3KMM2FpBq9sZeqtI7o1mKJcg
         6gqA==
X-Gm-Message-State: ABy/qLaO2Q9hAXyi1lTM6bKrKSzNQBw2ndk93/NbQ3W6Rhf/ndChSDwo
        LyfaCac8O7AzuRDHZB89s4U=
X-Google-Smtp-Source: APBJJlG0gkGSqh8g5VaM+e88ZxtYsK4NH8RkcNysALY4B325PIG1JEBhoW4P89rjsPkzYoSmgZsFgg==
X-Received: by 2002:a2e:3610:0:b0:2b5:974f:385 with SMTP id d16-20020a2e3610000000b002b5974f0385mr2369426lja.9.1690891395968;
        Tue, 01 Aug 2023 05:03:15 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id s23-20020a2e9c17000000b002b6fe751b6esm3048819lji.124.2023.08.01.05.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 05:03:15 -0700 (PDT)
Date:   Tue, 1 Aug 2023 15:03:11 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/8] pinctrl: wpcm450: relax return value check for IRQ get
Message-ID: <143e6d7a1d2b1fb692097f6c855f2553aca93589.1690890774.git.mazziesaccount@gmail.com>
References: <cover.1690890774.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zUmjDOxnj7pSg+hf"
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


--zUmjDOxnj7pSg+hf
Content-Type: text/plain; charset=iso-8859-1
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

Drop the special (no error, just skip the IRQ) handling for DT mapping
failures as these can no longer be separated from other errors at driver
side.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Revision history:
v5 =3D> :
 - No changes
v4 =3D> v5:
Fix typo in subject "elax" =3D> "relax"

Please note, I took Linus' reply to v4 cover-letter as ack && added the
tag. Please let me know if this was not Ok.

The patch changing the fwnode_irq_get() got merged during 5.4:
https://lore.kernel.org/all/fb7241d3-d1d1-1c37-919b-488d6d007484@gmail.com/
This is a clean-up as agreed.
---
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c b/drivers/pinctrl/nu=
voton/pinctrl-wpcm450.c
index 2d1c1652cfd9..f9326210b5eb 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
@@ -1106,8 +1106,6 @@ static int wpcm450_gpio_register(struct platform_devi=
ce *pdev,
 			irq =3D fwnode_irq_get(child, i);
 			if (irq < 0)
 				break;
-			if (!irq)
-				continue;
=20
 			girq->parents[i] =3D irq;
 			girq->num_parents++;
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

--zUmjDOxnj7pSg+hf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmTI9H8ACgkQeFA3/03a
ocVzLgf/YgKMDdpZ4Pk9NHZrrEUe/V5XCiKe2z+FF/mdt9kSKM/6cK/rtvUvOtL2
Eg3PJr2WxGcR0/nRv4cYAjl+z8XCFZgJrhngDcD7tgGiE0FX8FcJWDfFcd5ZyZy6
eK6PawT8eMAQrD91ZWRyeASVBGrNcjb3tB6h8so4txWp7zzKY+7pdZg1OtSTa0ZP
Oa8vhcXb+hR4bd0FQTv5vMZbN7CG+tcEmxXRt5/wOcJEdCvS2gJq1nS3eUQRpqo3
bBAVbG3880paOiPwoSXp/jWjZS1djf2r+bZ69CjxIFA6p2Gpji9AQHK1hP+PdSPk
h2snlOT/ipNxnOlr0xGtOMm6DTfaWw==
=7zsf
-----END PGP SIGNATURE-----

--zUmjDOxnj7pSg+hf--
