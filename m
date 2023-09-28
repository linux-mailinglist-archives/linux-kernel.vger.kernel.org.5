Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135E37B1649
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjI1Ipd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjI1Ipa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:45:30 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDD9B7;
        Thu, 28 Sep 2023 01:45:28 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9338e4695so210044391fa.2;
        Thu, 28 Sep 2023 01:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695890727; x=1696495527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=77zKk93STlk81KHrQIoBDbggD4+VRxetUhh7PgY+BS0=;
        b=Y+QWWJis7D3ruryAmjCUv5HT8gueIO+MjpPhYZmjNadIrITDLMyB4HuhzxDuQc1ils
         yGjlcR+wQAYToLAVcn14hlwawhFlP5br03JGWrAjZ3uV/J1tXq5Mj0kjwxNCrSnBHHGR
         pKfWl+ThGUHKvoy9R0oeHxEYEeREv96khzvYeEeMsvToO4U7gI8DfT1SuB6KIY/AqnzJ
         d5SWQ6N5JqFOjh7AIwCKDRFdTlcxKpyakeo4oq3s7KuImNR5cr7l/z9GKbIk0Zf22VqW
         c3mtPoDuyK8waqL9yXlnXUxHlrMdYYgUGo+mkzTVd5iukXhrDY8jEcoxqU03Nzkhz2FU
         Z9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695890727; x=1696495527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77zKk93STlk81KHrQIoBDbggD4+VRxetUhh7PgY+BS0=;
        b=Zv1va+Jj4CqOSSQ+wR+u7O5LObC5qD+5Hoc4RCTMRxnqNcAsyAAojK+3foJEF6o0/V
         G8frFzq0v5hXFhT4QfVIHDKaffaZ4nuV4M8IepzhNI+0XTwXCRpuPqPAibSseH1pwEdq
         31KNJqFT3MwTYAMcaFZLXHnjXJVB58Sl2erFC2R+peFHojCAfWafL5IpAdaEQrKlfpUM
         IZ07383BoGWjwPXsVjWmlD6U67RMTYEy9/gg/kH1wpqWW5V3JvzLxuwQbyKbWpun1MQr
         XdscbfKjv+Mh2OZTINATRaCTKk+2hHv63S+K+CAl1Et77ju/VOz8Dyh04N6a34AG5vZ/
         4lKg==
X-Gm-Message-State: AOJu0Yw6oDUpOCXlrpeRXGwPMaO5M4mh3oEnbuqjWE4bIP2Jt3eJ2K4r
        rKiATdkg3eqd/mdnUGE1kTw=
X-Google-Smtp-Source: AGHT+IEQ6aucz+Pp4uVA7/2h11qZdPerexXAaQZmdT907P6jFByyuFP3NQN5XwQCNeIaixTJ/4gn8A==
X-Received: by 2002:a2e:88c8:0:b0:2bc:feb6:6da4 with SMTP id a8-20020a2e88c8000000b002bcfeb66da4mr558168ljk.33.1695890726676;
        Thu, 28 Sep 2023 01:45:26 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id j8-20020a2e8008000000b002bcb89e92dcsm3517445ljg.6.2023.09.28.01.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 01:45:25 -0700 (PDT)
Date:   Thu, 28 Sep 2023 11:45:21 +0300
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
Subject: [PATCH v2 1/2] dt-bindings: iio: Add KX132ACR-LBZ accelerometer
Message-ID: <5c9e03ffad5e6e5970d6e71fb02eab4b652e109f.1695879676.git.mazziesaccount@gmail.com>
References: <cover.1695879676.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Uhpoo4wKidlshSv"
Content-Disposition: inline
In-Reply-To: <cover.1695879676.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Uhpoo4wKidlshSv
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

--4Uhpoo4wKidlshSv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUVPSEACgkQeFA3/03a
ocW1YQf/e5k0Z38zTgR/5OdYBN134vlAZjkRC0W/uPFZQjvPcdNDl1HiwRjtYiY7
cVmefUN9OJzRIXIiJuX1QbtF6bgcQ0jtYxKKc1Oi+EAt8y1F9DgxpDjo96yVnEf4
LM0Yf+gKLNNJl0GxHMji1ZwUlHSecfmlfZgrL0PKzZg3vECn4t8VBctgush8n+L+
Zq1XpX+STjDIOeutl1IKTBrCfS7rYkCnTCStFcbY1MV8eW+Ir+3pqHnBTYxoTYa8
AZY3wzvPU5TEDabhIiHDLIBMUmPAKaV1KW8/YV0J2riCeoZ9I4WZP4iBamhViTbw
fURt4bZtNrJZVr2M4wvDUlC4jt9qgQ==
=LvcT
-----END PGP SIGNATURE-----

--4Uhpoo4wKidlshSv--
