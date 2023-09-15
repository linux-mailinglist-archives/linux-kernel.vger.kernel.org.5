Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023C77A1698
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjIOG4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjIOG4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:56:03 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA022701;
        Thu, 14 Sep 2023 23:55:55 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso27944271fa.1;
        Thu, 14 Sep 2023 23:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694760953; x=1695365753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ish5qvQqrtt+EsYfatPa119gnsO6Mqf1t+AA6jNwww=;
        b=LJq2KqsWf/0ikl4ga6tOCQqnz+IKBKsMKC8aie55DlnE29Lgv3wBLH0YO4TL2gU+3q
         z/LoGMp+zsDu+p/oZbXjwf89RxL7BaKw6/VFsS20p/UBBUCCMrCmLK1u8x6y/BohoBgi
         WxftNzV2wVs3yMiQKuJK1w0OG02Kbea523zycn8TtP/sH1PZckPyA+PZoAkrWYmRmfFf
         WHtycS9TQ0YgPSOMgQZFBCkokjdJuo4B8MpP1MSk0vFuuxPThMWgjz8O0CKXLW7fcuBm
         sXgUW2PG88DxzeTEdxXQNwQAoEkxCGdwhqn2oHcHqnTxidAb0jBk9Hc//U+WmDds+NlV
         VOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694760953; x=1695365753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ish5qvQqrtt+EsYfatPa119gnsO6Mqf1t+AA6jNwww=;
        b=Ey1az5ZlKZbjyUY5uwloiHTPzSZvh+fjUMbNbGI4lOjR+SmUwAZnbhiLkn6lc++gns
         uAeFObzeZ+f+HXbrGX1GbJj9XzipQU/wS12rcwz3bs3eulFPbsknspifVVwd7ivFCfaO
         Qe5oi9yKqELHuW2Sa0y7YfBlmuNNL7runxVVGNdYYwmfqKNxNsKwPxm8GbU2+A+bf+71
         uAvWriFoWmW+TOOcPCW6TEpIQ/mkt9Vc9fzEgywE/4LGlvCPiInT/hpDV+921FpO8XjQ
         XeCjF9zDjdTU8GaavyJmC1zck1RR1QJHFuLevtm+YeuvQS2q+nRgudAW1JPoGp0+6Elh
         981Q==
X-Gm-Message-State: AOJu0Yz1NOQ/Pbtcw23rRhKPluV7kLOJq4LgrBCBCjV18rsFvnfWl5xi
        gr2mfUvNYK91dd0n85RvvkKAFswCMfA=
X-Google-Smtp-Source: AGHT+IF98T2cDoRnGFSgDdVcrK69M+WcBT5gMHu6DvJQpp23bHG7nLxx7K1mn1WwfwZO7CNW+g0mbQ==
X-Received: by 2002:a2e:83c7:0:b0:2bb:997a:493e with SMTP id s7-20020a2e83c7000000b002bb997a493emr667324ljh.35.1694760953100;
        Thu, 14 Sep 2023 23:55:53 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::3])
        by smtp.gmail.com with ESMTPSA id y15-20020a2e320f000000b002b9ef00b10csm592311ljy.2.2023.09.14.23.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 23:55:51 -0700 (PDT)
Date:   Fri, 15 Sep 2023 09:55:47 +0300
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
        Andreas Klinger <ak@it-klinger.de>,
        Benjamin Bara <bbara93@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: Add ROHM BM1390 pressure sensor
Message-ID: <b0815b11c1781ea8ad51f3cc07d10f66e27a8572.1694760170.git.mazziesaccount@gmail.com>
References: <cover.1694760170.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rfTPhwlfdQCx4rUl"
Content-Disposition: inline
In-Reply-To: <cover.1694760170.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rfTPhwlfdQCx4rUl
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

--rfTPhwlfdQCx4rUl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUD//IACgkQeFA3/03a
ocU1QwgArFpwiwsBxRC6MA8BBtuzTnHoV3+luNQAJeyhl94XHXhswPEqILyTiWXZ
uoWQn+QA/T9+3DdtdoutBBouvOB7ImvdjdAh3wze5p9qMaIahkZpL2DSG8nFwpO9
faFU8wfnuOyENJOu6cJAFOC7DizOjF4XoUD321FMC4TqNSlx6HJTQXnhZXEawQZJ
cj5G0enTh+n40PJ9jYvf8CrSs3w/XvsWJTbz7tEDyBNtTqvYls9vxrAnQeDA22Z7
RLXTqQgnxJukF/q4xKEIajtvLontstMaSFtOIiLC5PtG5I/6j7SvAS2ZvmhJ5s1r
asZraY7T6JLlbl+MVTXjF473gLUVsQ==
=aops
-----END PGP SIGNATURE-----

--rfTPhwlfdQCx4rUl--
