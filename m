Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F7E793CC9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbjIFMhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjIFMhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:37:37 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8571980;
        Wed,  6 Sep 2023 05:37:26 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-501cef42bc9so103200e87.0;
        Wed, 06 Sep 2023 05:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694003844; x=1694608644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T2g5u3WZ/dzAYIt8bCxzawSyy4sLXVIraI5R0WKnlUU=;
        b=ArL+jlsz8RCDOJi8GKUy3bRc45WMyUOBsKccgld55zpXJ29pssYFRcCqx8Mw7MrGpb
         VXIXfPeXaYCcw25usoyXhZzHbxCZatHcAjX+dH1J4AIPunL7I02HFLSApUB4oEqpu9DL
         i807lxNv49o5/667UYNKtm8HxZqcJTS7SlBTixXwDxgeFqcQiApyPeIbXf54WYXL7sHJ
         96B0599Ra9Frkcpq8EBCcppOpf2v0B0QH5bGT6mQQHJOTXWJqMioLmHBszTc0t3xosfa
         wokop2wU2T1unw3Zs5FJQe2tYvp6zYn8FNNh57vaJj6ziDI/r4b11sGny6Ep0znc6B5J
         1wVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694003844; x=1694608644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2g5u3WZ/dzAYIt8bCxzawSyy4sLXVIraI5R0WKnlUU=;
        b=ZLiRgDpxOkJMChzXE3ahTOMKDQO7mjQD01GAtcF11EDfCs50+U0WqY0hfSqtSuSSxX
         WfWIujoC9zY2LeDjaS1KnS2C4D3tsgwywe4DDFSU1NtDGZlNEMz48QpueuuzxrOoYo8g
         iOf21zPmZzhFHzkQl8E5LU9iNb97L3YVb4Jl1uYVdI9U10S0iEAHuRKBQTT9Ks451ZBC
         VmA5GvPiQJrRdzDuGbLqGdnHDl7nmgHEtRpnI/76lcykFcOoABRWmN4yd729N2m924Dz
         n8H1J1eNlvsKEXx6ALHaHLIpASlcLYcDObi7trsBJd4/KvDwmzifbk2jHFGNwjBH927Y
         /aIg==
X-Gm-Message-State: AOJu0YykVycJwG4ZtI3MRpupyOd/GFbnULsh/cthotqY+X0eD/Cg/Ckp
        CAStsk50RG8XdYT1GUURBwU=
X-Google-Smtp-Source: AGHT+IHM0yBHZFaBrm3wLxPrWls75mrOKsFK+auQXASNPKjvQCdRwelbyyE+xiEPWiOLOQVEZDPSJw==
X-Received: by 2002:a19:6457:0:b0:4ff:8f45:ab86 with SMTP id b23-20020a196457000000b004ff8f45ab86mr1872262lfj.25.1694003844555;
        Wed, 06 Sep 2023 05:37:24 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::3])
        by smtp.gmail.com with ESMTPSA id a21-20020ac25215000000b005009b979e3dsm2742541lfl.303.2023.09.06.05.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 05:37:23 -0700 (PDT)
Date:   Wed, 6 Sep 2023 15:37:19 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: Add ROHM BM1390 pressure sensor
Message-ID: <55e59e66824f75ce8ffe58d3463a9cbca56e25ac.1694001462.git.mazziesaccount@gmail.com>
References: <cover.1694001462.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+JRbDbfd3cWLWAtL"
Content-Disposition: inline
In-Reply-To: <cover.1694001462.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+JRbDbfd3cWLWAtL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

BM1390GLV-Z is a pressure sensor which performs internal temperature
compensation for the MEMS. Pressure range is from 300 hPa to 1300 hPa
and sample averaging and IIR filtering is built in sensor. Temperature
measurement is also supported.

Add dt-bindings for the sensor.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 .../bindings/iio/pressure/rohm,bm1390.yaml    | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/rohm,bm1=
390.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/rohm,bm1390.yam=
l b/Documentation/devicetree/bindings/iio/pressure/rohm,bm1390.yaml
new file mode 100644
index 000000000000..d681fdd0f5ea
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
+description: |
+  BM1390GLV-Z is a pressure sensor which performs internal temperature
+  compensation for the MEMS. Pressure range is from 300 hPa to 1300 hPa
+  and sample averaging and IIR filtering is built in sensor. Temperature
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
+            compatible =3D "kionix,kx022a";
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

--+JRbDbfd3cWLWAtL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmT4cn8ACgkQeFA3/03a
ocULKAf/eWGZ40ehcKIzeZRGpqb7OWYn4MA4dhpCwLuX5y20k1s7MgQ8DCeWnmZg
jw1d9SqO5JJB3FMR8r4Sm7+kjd3x+v9RUuIqueI+gidEtSJ7vPeoM9asBcnTzOp9
RUFKiz+SITYPsmHBRtYt3Sm1XrjZNfdlw2sxVGEGw9mh2f9Ggv5uLtLi8cjsBj1T
XbyAAMakjX8kkflpAUp+NSULSsrQokLaFOmvZ8QHlxQHj+CwyYQBZBkLLR6sKnPw
mqmw/Zt0uOJw7YzX8+pPFvoUr8yp4E4wGRA04y793tKFAoSZ89OPUSQYBeQLk3TJ
nJbmbYk6FO6AmjRIqcbTmxqcJ0Ac+g==
=cLEN
-----END PGP SIGNATURE-----

--+JRbDbfd3cWLWAtL--
