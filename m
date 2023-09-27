Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359C27B04C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjI0M4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjI0M4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:56:24 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD6D194;
        Wed, 27 Sep 2023 05:56:22 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50482ba2b20so1067158e87.1;
        Wed, 27 Sep 2023 05:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695819380; x=1696424180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0DE0mLNtJsF5eQFGXeJoUeYHt3jhgAAPiZzB3iqa8Xc=;
        b=jXbZOMGnfxsvHaX4PASafK/KkaE21INIUlIr3XlDPulB0FGPF90TNFp902WqieFXSq
         qpxPJ7uOKzhUVr7GdczoR33USwKn+uOHZ2eE+wTogJIYzpCkillAUBcfZX/3SOKoRx1s
         lH/FVbGg3B1Qd0rIETA9/UY1BBBEynT4cmC4piJkHoe/gs5j/PPWfDT+xIZ9yST5hasD
         KkDzRX/ORj5FQGs1yVaJ4D11HSe6D5lw4uQK9kx2WiMXiSJe2r4Fh2Xbr3K24X7Y0wRB
         EyRrQvFZfARjen4p7AavVLE/moIZXgHbtihklBqHsQc2L5UUS7ISF3o7xkMTK2M6IX25
         Gg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695819380; x=1696424180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DE0mLNtJsF5eQFGXeJoUeYHt3jhgAAPiZzB3iqa8Xc=;
        b=jvJ4a3qpg1c5j0mfYQZYf0jWq282SOAMDuKV/kVl4YT+oJkmJOiV3gThQBJ7WYPRn2
         7xN4oxWQz2ixu2J82Y0aqmf5E0sxbNsg6qRAfUZ+3R7JZ2mm/Hzv+arej2S/aa0MrLQr
         IyvtQja/v7nZXb0KxWkxsjb44cBeCtbKwbViY6OJjOGQ1SFVKZVf/Vauu4ViHzgQhJHo
         lfP2ulkjo9RFb52BUj3meLOFIVCKXXJ/av8DMBLPpIxbzO3z6VuZ1dPbrrhwSpKNK6qM
         jbH8uadW/66qyNXGFdI1TC/AdvwaKpenb/F9l6MZaTII/kuncJh5LqlKllIF2cvpzrce
         rDeQ==
X-Gm-Message-State: AOJu0YzCSzmpoznQaA0CUh/zbKOLB8b038dajKxLDCnUoa6OMeenNkXS
        TuvPdSV7yIKenBj1RRVaKvA=
X-Google-Smtp-Source: AGHT+IHLF/ceQR2phD4Q7ymVsxwHgQ+3Arg2p4oysiQlBVXiVH7QYDHUVepdBU9075xxznJcYJJmQg==
X-Received: by 2002:a05:6512:31c8:b0:502:df19:83b3 with SMTP id j8-20020a05651231c800b00502df1983b3mr2265767lfe.10.1695819380151;
        Wed, 27 Sep 2023 05:56:20 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id x20-20020a05651c105400b002c02b36d381sm3169889ljm.88.2023.09.27.05.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 05:56:19 -0700 (PDT)
Date:   Wed, 27 Sep 2023 15:56:14 +0300
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
Subject: [PATCH 1/2] dt-bindings: iio: Add KX132ACR-LBZ accelerometer
Message-ID: <5c9e03ffad5e6e5970d6e71fb02eab4b652e109f.1695819243.git.mazziesaccount@gmail.com>
References: <cover.1695819243.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vKcSQKi0NsG61EPv"
Content-Disposition: inline
In-Reply-To: <cover.1695819243.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vKcSQKi0NsG61EPv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ROHM KX132ACR-LBZ is an accelerometer for industrial applications. It
has a subset of KX022A functionalities, dropping support for tap, free
fall and tilt detection engines. Also, the register interface is an exact
subset of what is found on KX022A.

Extend the kionix,kx022a.yaml file to support the KX132ACR-LBZ device

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 .../devicetree/bindings/iio/accel/kionix,kx022a.yaml   | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml=
 b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
index 034b69614416..66ea894dbe55 100644
--- a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
@@ -4,21 +4,23 @@
 $id: http://devicetree.org/schemas/iio/accel/kionix,kx022a.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: ROHM/Kionix KX022A and KX132-1211 Accelerometers
+title: ROHM/Kionix KX022A, KX132-1211 and KX132ACR-LBZ Accelerometers
=20
 maintainers:
   - Matti Vaittinen <mazziesaccount@gmail.com>
=20
 description: |
-  KX022A and KX132-1211 are 3-axis accelerometers supporting +/- 2G, 4G, 8=
G and
-  16G ranges, variable output data-rates and a hardware-fifo buffering.
-  KX022A and KX132-1211 can be accessed either via I2C or SPI.
+  KX022A, KX132ACR-LBZ and KX132-1211 are 3-axis accelerometers supporting
+  +/- 2G, 4G, 8G and 16G ranges, variable output data-rates and a
+  hardware-fifo buffering. These accelerometers can be accessed either
+  via I2C or SPI.
=20
 properties:
   compatible:
     enum:
       - kionix,kx022a
       - kionix,kx132-1211
+      - rohm,kx132acr-lbz
=20
   reg:
     maxItems: 1
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

--vKcSQKi0NsG61EPv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUUJm4ACgkQeFA3/03a
ocVwUQgAtro0Hwf1L+y3eJ5ohf4R4KoWv7sYOT9lvDobutdyRNYZbUV2NVajrXg2
4pzNT35eNr5FIQ/sMgEUUvNjtTR6UNMwM6iILsqjr03urdbiYxMveW+ouAX9eOOT
/McUK4VqUu8wElPpPR9xIO4t19Eyu0bftqN/ql3X2nKBd7Gi0lXRPjiNc/UP1xm1
8mnH8XYKwYhV4hulMZcc2bsh9CT6H41LVZDf+Nd+hlT4gkjAWzigLKoD6k98a2bu
hpip2MCb3sAUtNYDfqOz3X6OyW/8hOZ7Dbv84bysfEsKnZGxM90Vcw4OssH/4Igp
wTbPnnE6ZM2ZmQPPAkGgqzQOgWvUhw==
=U9oE
-----END PGP SIGNATURE-----

--vKcSQKi0NsG61EPv--
