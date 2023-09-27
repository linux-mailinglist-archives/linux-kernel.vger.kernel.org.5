Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB7F7AFE5D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjI0I22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjI0I2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:28:09 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4321A6;
        Wed, 27 Sep 2023 01:28:04 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c15463ddd4so113029321fa.3;
        Wed, 27 Sep 2023 01:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695803283; x=1696408083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jp/xqOMX+J33+aUureIjJV02KkIU6sGPnf8h+MBVqZQ=;
        b=Pjpl6KZkMs9EU/WmfVgwqkV33km+oq9IhrboPx0BUpTqCy9ssOHHs+vrKMd8vwmpej
         jt6w8j1EOBDXLN4HsX+4dxb5Nd/JDXmkneS5ftqueWCGhp2/x5x4OFc1niJbehJijcDm
         97+iVW+G8jmdctALudLh+yLqtG9cqeYTVNjvIobzU6S4Vp+xYcvxxndIgo1KUDLWqsL4
         F9riIuhsMFv8QQXP3laZvBXUsWdnavSicOonKYslaTtwFIdL5Fpy1pU5JgU2lgXd/PGv
         bHTLHFMTsImj0gp4MH0xbJwnZ9XjgfAdevlBF5mum9d6oXsFPDwhICrm3BvH8tGhx0id
         mZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695803283; x=1696408083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jp/xqOMX+J33+aUureIjJV02KkIU6sGPnf8h+MBVqZQ=;
        b=HR99WUvHLqtpencP5SJPt+AfQE/zWCVYk2P2JoeaKnfz1I1uIYuim4pRsac3G4IHcY
         +UIBR3HKI9Ko2buOd4O1F5dlfx6o2HZK0HoZrOhkvlnBhQp3xKtIRFBq/1dw4dhHW5I3
         l6Lqzrou1bN0FR1DdNL29lJKUpHEMbPCnyj6n7t8WRTEx7lc3JgTWLP4fQdmKBR93Bxb
         8xkwRvm4s21wo7z5Jiuj4g51R12uXzjamR0Unsj3DGJCcVO7ILPSXDurcOMs6+N2uQrR
         0vbZjzFkz67M46qzlirm7V+9J0tL//wgpH189iFpXinMxzBfSz4PUEXWtmXBuMSWC/Ea
         JGnw==
X-Gm-Message-State: AOJu0YwMSxC8k+dlG6GdZE60aHyXZszSyqgA/Ytqdke0ZRZTC+CrKHi2
        G5lsqmYfeQ+KZFsIMqwfwbU=
X-Google-Smtp-Source: AGHT+IFb0PK/+kOqD/LFrtUf7f80rDIVVZNB8NLX2C+RPIULy5PsAtScxDNzw2QGWSHEmqiugJit+g==
X-Received: by 2002:a2e:8010:0:b0:2bd:102c:4161 with SMTP id j16-20020a2e8010000000b002bd102c4161mr1480084ljg.43.1695803283107;
        Wed, 27 Sep 2023 01:28:03 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id b10-20020a2e848a000000b002bf6852d135sm3003306ljh.94.2023.09.27.01.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 01:28:02 -0700 (PDT)
Date:   Wed, 27 Sep 2023 11:27:57 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Benjamin Bara <bbara93@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] dt-bindings: Add ROHM BM1390 pressure sensor
Message-ID: <08796e6b28d2c67933b1a1a5eca0f43da322a597.1695727471.git.mazziesaccount@gmail.com>
References: <cover.1695727471.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TfjuISBGJ0mmRPk2"
Content-Disposition: inline
In-Reply-To: <cover.1695727471.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TfjuISBGJ0mmRPk2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

BM1390GLV-Z is a pressure sensor which performs internal temperature
compensation for the MEMS. Pressure range is from 300 hPa to 1300 hPa
and sample averaging and IIR filtering is built in sensor. Temperature
measurement is also supported.

Add dt-bindings for the sensor.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

---
Revision history:
v1 =3D> v2:
- Improve spelling in description
- Drop unnecessary '|'
- Use correct example (fix compatible)
---
 .../bindings/iio/pressure/rohm,bm1390.yaml    | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/rohm,bm1=
390.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/rohm,bm1390.yam=
l b/Documentation/devicetree/bindings/iio/pressure/rohm,bm1390.yaml
new file mode 100644
index 000000000000..7c4ca6322bf8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/rohm,bm1390.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/rohm,bm1390.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BM1390 pressure sensor
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description:
+  BM1390GLV-Z is a pressure sensor which performs internal temperature
+  compensation for the MEMS. Pressure range is from 300 hPa to 1300 hPa
+  and sample averaging and IIR filtering is built in. Temperature
+  measurement is also supported.
+
+properties:
+  compatible:
+    const: rohm,bm1390glv-z
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+        pressure-sensor@5d {
+            compatible =3D "rohm,bm1390glv-z";
+            reg =3D <0x5d>;
+
+            interrupt-parent =3D <&gpio1>;
+            interrupts =3D <29 IRQ_TYPE_LEVEL_LOW>;
+
+            vdd-supply =3D <&vdd>;
+        };
+    };
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

--TfjuISBGJ0mmRPk2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUT540ACgkQeFA3/03a
ocUzXwgAxR4FUgws79gwtQqbAtk+ZDbawpPVK9+yi03P2fLUzcLhvV0NGle49Nk0
ulmJWzA+nPND7jICXPcEntsBBSCNbOuMnU6fTazPgmPDZmQPr/IYtmqbnLeZDvUr
hhujuVIl5Au+Muj+TWTgVxQAzhukgv5qXmg+TvJwAsdIL79SskybxStO9LB128CO
EvHXF6A7Ym2i+VBiKhGkgtlxXGWyhz9rZ5Pzz+OOgEpI3CJHewTkQHDw11lz8J8v
be/fOITZyrJfwIDhjyJwdqYdOxxA0pC2RasF0SQ3eMwGhXJfQkqBZkXvMW+mAQEV
yevOUXWB6FE/Jtna4POWhn1yppk99g==
=3iyJ
-----END PGP SIGNATURE-----

--TfjuISBGJ0mmRPk2--
