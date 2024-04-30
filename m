Return-Path: <linux-kernel+bounces-163880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B858B7512
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F0A1C22819
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7781813D282;
	Tue, 30 Apr 2024 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKCh36h8"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8DC12D741;
	Tue, 30 Apr 2024 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478398; cv=none; b=H/rajUQK+LfdxnUaQXWrP/rzBMFSEfIXzuAsOYG5NSX4hAaybtINQlSvfXCeHnQdq5ayNAsnewfhbwIAoyfYgnYIGlSEBtHLbr32G0GTlG92L34Etnbl3Qxo1OT7IQMAOkiIp8l/sVZO7n10bznLTayPp1u9t9JhMnFmhipjPuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478398; c=relaxed/simple;
	bh=Rj8/n9aXfCY8FIc0dy4NmHMwKEb9srWY5WbHvYFWdWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEYVyk+4DHDqjac3Jy2KXAyy29xwsKGw6A0ceDeMNtlolTS9YFD2VAbiRdvZWbbBqdHc1cckrBJ4HlVJXaYT0+xTkf8iNpx3NkfXqbjgckSWUUf/7d78Cgv8K2uKjL6J6nInzMHkkzWXvI0ZXhzdU0KQLfWBZgQz3L1ZIHsfWGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKCh36h8; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso8901252e87.2;
        Tue, 30 Apr 2024 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714478395; x=1715083195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xju/arvK0sErvj5pJZGnW9THE1Ws/OZmXsHEsvMZiQ8=;
        b=jKCh36h8ooubt8hRiL52rMz5LPU9B+KTgSGJPz17fyd7iz6oZkZvuZlXcAKr76qVGr
         Pvcief2Pup6QAtPVlZcexY4LHiZGryaZ7EX1iEarQGcAlpsW8B2MCjNQV1bvY52x0DKF
         DXDfr2Bh+jidQXYjYSQJkOH0/smHI7QbfBsiyA2UZ6uFV8ZPsL0DYmKQOa4eZP0YgGXt
         v6As2Mql0lspro0t/zDufE/nttwA4nIkiikZJMOO3tpi6ftdSfx0CRThBa7sNqfKpgMn
         MzC+eOjRQetQmxFREY4dXtl98mJ4fnO9gjPUD1EXXhTsYwFBNabKwOkeFanLSLcVEAas
         uDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478395; x=1715083195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xju/arvK0sErvj5pJZGnW9THE1Ws/OZmXsHEsvMZiQ8=;
        b=jVlFhryCslfrKuBfRwV5tDOzdi3Y/oZJCDUkBpBUlrbnMEmTZn6InV1rAjiK56JZ/y
         rfXxv0u/k8lO3qMH4LU9Lc8XHJoiiQuFENaMpFmfglbn/VuY6G9OS+zAhna1zYviOVca
         D1K+E5q5a6l2DjxUyr8kGRhU3rz7ONjsxbuaN6XoAUB4SUuBO2hsvFs3hx7oo5JfU7xH
         cmBf65RGBnHgugDjDPpNhCVj50y1wz96cMialv99IcKT8R72vfeB5SsdYmZAwhZr8xiN
         0hhIqkgW5wVElzywK+R37Z/x1fRDfugyO/+wjl97x8f0q9+q583vG9qsuPIaeqFce/T+
         pNMA==
X-Forwarded-Encrypted: i=1; AJvYcCVi7lwznMnh+0jxKDMtY9cDR4S18WTGKucEA5cz10vtwztin3zta62dAsbfE1bAEJ20+djW7c8qilZ3YtlNQzeEWhC5koFr/Ho0Z9rH7hM95MLFgiid5VWusMLVP9oaBcwqm54IRjxycx6AXx5tu60+TJnbFGo0wWDOxGWJ2vl6wHA2l4I3YHka
X-Gm-Message-State: AOJu0Yy5Htma1P8ar87xKlhuX74tzYHsILrTXB84wRQbQlwVF4aBqz3O
	lSqy8aNPfuyy5ok6eNQb3IF/mJbRpm1HEwb+TzIWrc0fwWzwgV6B5CGuKg==
X-Google-Smtp-Source: AGHT+IF+YnIQJ4uDvCiCSdCNOSwuMTRHB0O5lT5IswlFSqPFfuvN24lY+l+X3247BbaddvYtHGdpqw==
X-Received: by 2002:ac2:4a70:0:b0:51b:250a:a8fb with SMTP id q16-20020ac24a70000000b0051b250aa8fbmr11433570lfp.48.1714478394809;
        Tue, 30 Apr 2024 04:59:54 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id eo6-20020a056512480600b00518bf12488csm4431140lfb.160.2024.04.30.04.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 04:59:54 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:59:50 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v1 1/6] dt-bindings: ROHM BD96801 PMIC regulators
Message-ID: <c747a3395a52bdb9b9697f814cd781fb0903b894.1714478142.git.mazziesaccount@gmail.com>
References: <cover.1714478142.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1M3QDGLcjhEZiMWA"
Content-Disposition: inline
In-Reply-To: <cover.1714478142.git.mazziesaccount@gmail.com>


--1M3QDGLcjhEZiMWA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ROHM BD96801 is a highly configurable automotive grade PMIC. Introduce
DT bindings for the BD96801 regulators.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
RFCv2 =3D> v1
    - Drop regulator-name pattern requirement
    - do not require regulator-name
---
 .../regulator/rohm,bd96801-regulator.yaml     | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd9680=
1-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd96801-regul=
ator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd96801-regula=
tor.yaml
new file mode 100644
index 000000000000..1b96ae60064d
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd96801-regulator.ya=
ml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/rohm,bd96801-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD96801 Power Management Integrated Circuit regulators
+
+maintainers:
+  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+
+description: |
+  This module is part of the ROHM BD96801 MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml.
+
+  The regulator controller is represented as a sub-node of the PMIC node
+  on the device tree.
+
+  Regulator nodes should be named to BUCK_<number> and LDO_<number>.
+  The valid names for BD96801 regulator nodes are
+  BUCK1, BUCK2, BUCK3, BUCK4, LDO5, LDO6, LDO7
+
+patternProperties:
+  "^LDO[5-7]$":
+    type: object
+    description:
+      Properties for single LDO regulator.
+    $ref: regulator.yaml#
+
+    properties:
+      rohm,initial-voltage-microvolt:
+        description:
+          Initial voltage for regulator. Voltage can be tuned +/-150 mV fr=
om
+          this value. NOTE, This can be modified via I2C only when PMIC is=
 in
+          STBY state.
+        minimum: 300000
+        maximum: 3300000
+
+    unevaluatedProperties: false
+
+  "^BUCK[1-4]$":
+    type: object
+    description:
+      Properties for single BUCK regulator.
+    $ref: regulator.yaml#
+
+    properties:
+      rohm,initial-voltage-microvolt:
+        description:
+          Initial voltage for regulator. Voltage can be tuned +/-150 mV fr=
om
+          this value. NOTE, This can be modified via I2C only when PMIC is=
 in
+          STBY state.
+        minimum: 500000
+        maximum: 3300000
+      rohm,keep-on-stby:
+        description:
+          Keep the regulator powered when PMIC transitions to STBY state.
+        type: boolean
+
+    unevaluatedProperties: false
+
+additionalProperties: false
--=20
2.44.0


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

--1M3QDGLcjhEZiMWA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYw3TYACgkQeFA3/03a
ocWe9AgAjegHNJiHBHDOvjxvK70AtR+WQexUUmH9SE/TaKUyldE9+NawV6ShLCd8
4SIEp3IWvfs3DEIfoZYuiyuEwgVcq3JG8T6Lny+YqUGxixiYtBauzpUrfBrK9aVa
l3J/h/uhYbMDDkcbrhmcL9R2r81d8KnuaqoqeHtqDcOzo2TPZxM4gTcu5OQR/mib
0XWpeVHSwtnQl0fMmQI3euisi1Xyyjh80D3n92YQzUPQE+6UcAM6hPZjqOSpK137
YHWVJgmQQ0zGhW9twW3DwJwJ9U+4raMlz36scPrPdHSnIK+V3bmJMXEdIdG7J0Bf
4PfQSLZJAXHlZcaDV8KhkDWlld8AAg==
=e46u
-----END PGP SIGNATURE-----

--1M3QDGLcjhEZiMWA--

