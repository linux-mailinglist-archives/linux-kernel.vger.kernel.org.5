Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D9176C70C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjHBHhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjHBHgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:36:45 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04131BD8;
        Wed,  2 Aug 2023 00:36:40 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9cdbf682eso80079951fa.2;
        Wed, 02 Aug 2023 00:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690961798; x=1691566598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ks/KTYo6jSIDV1y3oZOeXYuFFSikXpxViVhw62BI5Fk=;
        b=kg0rjkLilhVj2qjZ7k7MQGECKs+1T9NQ65qC8QARjPbq6sJ5mvdV4S1L7T5UlbthFO
         0diLoFl/9QumjB1i10+h8rWjLsfV2joGSYOYGlyhm0+7lGAr7Mosv0Fn/SdZ0+P9iYFU
         xZboUF0sjwTflOJk5gwb5lIgUWwTtxebYUvE5JJgTQNNqz0MsgFrlc5SdiOZJmWyBN/F
         PFrGZCRBfkVucs81yam3h06Ey4Jl5Fnp8Dt0xETHU7ouzCZotxVbFnSnElsZ9ExGX1U5
         QC+XjnVUv9aQ3B3zBZaVLtyz99MxYx4Tzy3T3hN/xodHb0qLavOCq6HErNTGYc0GDhr1
         RE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690961798; x=1691566598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ks/KTYo6jSIDV1y3oZOeXYuFFSikXpxViVhw62BI5Fk=;
        b=IOxDvTxheDopNOckif62EBdNqSSDUz2qFQpgMt4LMkCoXZVI8GUg9fDDJ5WTpZ3W+M
         FSAAAIIUTauFgqb0z2SmNopDgAkpt1fv7EGHIh0uZGFJAWtUaTgcWXAn/BET2rm6XYJJ
         Re9WQ9/F7Rxl5ZjJXB7wkdwRt7NnfDoSHeyzybE3cdIcKn6ESIRNKPCtArvt9PIdciKX
         KHERKskYGH6hcWkUZZGlUB1TkTRc/H4KrPSmfdjCBS4oCSox65+xWd+hJ+cDmoVr0RCx
         pWT2fqpL9ZfQ1SZSXHt4Wswe6N2hhjGbO07JC7R2lOVYA5rTmPfbAm9ldk5YpyRJwUIF
         qgwA==
X-Gm-Message-State: ABy/qLbmqHun/OEY9OS3AglJ+FA1p+APM/fAWNnCkCNLkEygXBicYm88
        TKcUSHpAf+ckqccNRJJQM+I=
X-Google-Smtp-Source: APBJJlGp99FodpqVg/i9/V0BOSQZ/stkdWR5S1K5GMJqJ+M2Cec52KZfnz4z/1Zayr9qJhw+uMCaXQ==
X-Received: by 2002:a2e:9852:0:b0:2b4:7559:32b0 with SMTP id e18-20020a2e9852000000b002b4755932b0mr4305066ljj.19.1690961798559;
        Wed, 02 Aug 2023 00:36:38 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyyct-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyyct-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::5])
        by smtp.gmail.com with ESMTPSA id z8-20020a2e7e08000000b002b70aff9a97sm3453357ljc.16.2023.08.02.00.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 00:36:37 -0700 (PDT)
Date:   Wed, 2 Aug 2023 10:36:34 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: iio: ROHM BU27010 RGBC + flickering
 sensor
Message-ID: <717d30694ba6864b8c28772d7478bed93ea10138.1690958450.git.mazziesaccount@gmail.com>
References: <cover.1690958450.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wNcjs/jSyb+1CNej"
Content-Disposition: inline
In-Reply-To: <cover.1690958450.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wNcjs/jSyb+1CNej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BU27010 is a sensor with 6 photodiodes (red, green, blue, clear,
IR and flickering detection) with five configurable channels. Red, green
and flickering detection being always available and two out of the rest
three (blue, clear, IR) can be selected to be simultaneously measured.
Typical application is adjusting LCD/OLED backlight of TVs, mobile phones
and tablet PCs.

Add binding document for ROHM BU27010.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---
Revision history:
v1 =3D> v2:
  - Drop trailing blank line
  - Require VDD-supply
  - Fix subject prefix
---
 .../bindings/iio/light/rohm,bu27010.yaml      | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2701=
0.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml =
b/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
new file mode 100644
index 000000000000..8376d64a641a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/rohm,bu27010.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BU27010 color sensor
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description: |
+  The ROHM BU27010 is a sensor with 6 photodiodes (red, green, blue, clear,
+  IR and flickering detection) with five configurable channels. Red, green
+  and flickering detection being always available and two out of the rest
+  three (blue, clear, IR) can be selected to be simultaneously measured.
+  Typical application is adjusting LCD/OLED backlight of TVs, mobile phones
+  and tablet PCs.
+
+properties:
+  compatible:
+    const: rohm,bu27010
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
+    i2c {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+
+      light-sensor@38 {
+        compatible =3D "rohm,bu27010";
+        reg =3D <0x38>;
+      };
+    };
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

--wNcjs/jSyb+1CNej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmTKB4IACgkQeFA3/03a
ocUJ5wf9GH4WGr4GKuwfigzPgkC2ByMzQm0E+AhvPL4IFu1+6nIoq0VRvTFUijcy
GCnj7X0PpygavpYIshUx6HDMW1TDCtJk6+wkwxhw3ZVPzTGg0BoL4Ud+4HS8qgyS
nDOZmZXfPYSBjA6Skk5gpaiPGiCDVkwohPol2Lgmq3J/vNaWTHnCbKZA9Z7ohu94
Zm9Ra+qCj3wbou3bBKmC6VXkf3CMP35zlrm+fW/7CSszMBYusHrR/h2vkB32ZjmL
j02DmhKGHW6NEenoQG+p+oicDAcNQdu+CChDTAxHv178aZ+ybNzk94Bnkra61zHe
k+RM3zhDYirGg4aIOIsH15E04G8Ckg==
=KO4Z
-----END PGP SIGNATURE-----

--wNcjs/jSyb+1CNej--
