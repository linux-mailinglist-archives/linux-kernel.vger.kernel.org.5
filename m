Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3B27AB06D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjIVLSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjIVLSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:18:47 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2628CAF;
        Fri, 22 Sep 2023 04:18:41 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-502a4f33440so3444190e87.1;
        Fri, 22 Sep 2023 04:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695381519; x=1695986319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zmze11S8ZKQPsA7TXsgSAXZTNdn4AZMA9dhhd+bRC2o=;
        b=Jcp0hbxBrEotXzeZV88NtVkkgYIE1uFh47lDHDzz4hI+6S4zEIHvBhcA53pUYaRwsh
         TOEMOsVXq+Qf8UELIXF4TX1nUrtNnZo2cD+ZmmJBpvMsqQlNmgP5rlaSY1TrdS+WcJpx
         BKVRZ+ioXQgZeZ+yeDzu1u8C/ehJT2B045AfYWlFENfku7mt83K/ZRxBCr7ksdjFy0yR
         82/mQQ38UC/aPn3C1G7bCtRkaxCIRelIcFJX4GPFOUPjL5xZLljDa/aqghJxAskKfhNr
         QFimU82rDqTbSTJ0IRrokXym9CeQGsC+x7vxrvgc7h95p9M8jH+VrFsLfuXSH2lkKOX/
         pg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695381519; x=1695986319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zmze11S8ZKQPsA7TXsgSAXZTNdn4AZMA9dhhd+bRC2o=;
        b=cJnsTJ0xEt2uBOB5XllMf5Df+FELmBJnpVUi7Q3orMZ5KsUReJrzfVAZvV9fm0ecBR
         txgNFgobHRb3XTPVKjNV/pi99NXoJxbwXt8cjCsXKdSGPsX6bQFTeHdZKvNPogHmBPAa
         yGZsrChzp/YF6DN49Z+AjL0lCEIP5iiLmdiPwnrqyzWuq4P15Z5d5fTMNfZRrAjv12Cr
         CvPVnkUlBdlwJLT2VcMNIopnzcrs57iLCqG3MLqi1/BDJ7Jd7Pzoirr2H604M3HAkN2t
         JlYhzHsaJ+dqB6O7C3l+MAkAm7Wx6DypvkdEQYiJbZJgel8FL6MuYOETbnjglGm6rqsk
         WHyQ==
X-Gm-Message-State: AOJu0Yw5+zal9SId3o/X/MXy+5M3Ir7rlvyk2lXapZRH2Zg17XZOo+Yw
        YUlAVwVnY/g3S+imAioWhPM=
X-Google-Smtp-Source: AGHT+IHK5MZ925TFz8RsVg6pa9cvY/c0ggYfVN3OD2VsDC7ocrFlt26e2OVSAou5/29wZrXMbukQ0Q==
X-Received: by 2002:a19:6746:0:b0:500:c348:7efb with SMTP id e6-20020a196746000000b00500c3487efbmr7271924lfj.48.1695381519084;
        Fri, 22 Sep 2023 04:18:39 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id eq25-20020a056512489900b00502e0ea7174sm689598lfb.186.2023.09.22.04.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 04:18:38 -0700 (PDT)
Date:   Fri, 22 Sep 2023 14:18:33 +0300
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
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Benjamin Bara <bbara93@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] dt-bindings: Add ROHM BM1390 pressure sensor
Message-ID: <1a4c0ee68d26f91cf58e12a4dd02b0d1accb79d5.1695380366.git.mazziesaccount@gmail.com>
References: <cover.1695380366.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IL6muAW2kuJQJ472"
Content-Disposition: inline
In-Reply-To: <cover.1695380366.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IL6muAW2kuJQJ472
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

--IL6muAW2kuJQJ472
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUNeAkACgkQeFA3/03a
ocXGPwgAjnFpbjYuKkZd5xDMZJC+pvEvm/QFPMxcxuRMg+73u6HqV3uaroPRd9eU
qhrtOT1sPQ5NyIhbLdaMkUK6fy/1fQkKJhFjBIG5SSxpxekdoD7CVu8wOiTN3ZNi
J9FBFyF7HmkqHgB91WDYqYIpvKNBMre2KIPhWdRFGWr4TMiiS2uXa+z/TkIWcWG5
1URzj55o3BjqeerEp2faxqGkbu33jWBdGXGUypHHIB1MKnsuRKeu2kyyGx+jLdSj
Fg3Kg8Qmps3rlK6d+ikkY6Sg3TMWp7Ca3h/xXQUmZl0sqUuxB8wtyNpgZtSF6wlq
uYGh5cX6ar0RODRtc4NAaC0hVH3HkQ==
=KWyF
-----END PGP SIGNATURE-----

--IL6muAW2kuJQJ472--
