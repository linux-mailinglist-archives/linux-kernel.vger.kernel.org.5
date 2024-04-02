Return-Path: <linux-kernel+bounces-128000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8B78954BC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6545288D12
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C491332A6;
	Tue,  2 Apr 2024 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOhdeQlT"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CC7131744;
	Tue,  2 Apr 2024 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063276; cv=none; b=UY3HfnaYgsfJUGl1NTuVbzooB3on4lJRjFlBRFkyorzYr+iEc1SFE8NtLkiykiLW7J7icPES4fQ3DUqwnlbYs5hRmZbiSHh4URSLoJYlEknkLS0BWnRZZrmWK8jjjdVF/jYI2P348xJi8ZBut+ZNSDvcIUuLh4xUsVrfCwNzIAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063276; c=relaxed/simple;
	bh=jSExc+bfhwvc3TVACAWci39MQQHyOqSgQzVhowlTL1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESPnCiNWk0qWs8TZslEyy4wznON8f1xtNqrYz0MNw6LbDKf9XeeJ8zg0tIiWr6qpmc8QM2+kc5O1CiVIbK0quvjlUL+41fAs5eckZGbDHnKDiXG2XO0ibyMKytlk5ECJR05nT2oDYBmFYUVWMjNbBgXLIM522neCxvunToGahqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOhdeQlT; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513e134f73aso6645024e87.2;
        Tue, 02 Apr 2024 06:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712063273; x=1712668073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rDgivGpeRN3oqnhK6lo1QGQ9bOAakNzOyMutrOBIkVQ=;
        b=kOhdeQlTkFqNYlYnP2k/97pycdcwCoeVQJ3qMZua4PiPsrZ78FuF7IZ4yP/LxrXRR8
         YjFBtl1ZqSJ0byoQNTLX5MH0U+4/xNxqlJf3IkzL9uPrvgSQ5fnsbYbKiEBwtfgDxwua
         Hh+tx9LJheKi+7Un+lGcSLCHdqzXbTsti3GqaxtR2yzYqmeFM/m85UtGx1yQ/2B8i9rl
         T1THwJDzG5nceBpVoW8OuM/pzEMMMqihnGTE3VX+dxh2kqIJVc3lMJaru4TdckSUsqpI
         GDHcs1FBnf02xSpWj5b6i9pzVCu1XmrBitZtzps/IwLl4IdsLn3tw53maOw8Ef5ynT9p
         JHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712063273; x=1712668073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDgivGpeRN3oqnhK6lo1QGQ9bOAakNzOyMutrOBIkVQ=;
        b=BbVpUFFu73DeWuCmQ0TQdjSNvXFCjYIdET20hw7mlN2yLqFi7ySixOjeIVVCe7GWg3
         8WL0dMpp0izpPr2nQQ/J937Gnu8XI7FOn0kTfl42ZO2KqaEVdyDV8WVBQkqBR8Vra2/b
         n2319eD81JtR6hQwpsOKWQdLTsDfRHd2rWV05ozNdhMFy7XLw9eOsMpP3hlrKtZtxf/2
         8Z3OdWUJbdkIOjNazDlbKmxgASUbJJbMFBmkQJL5nTZ2vrLEb6ZsputizZDIy4vlUfJ8
         YzR7Rnou9AyYrDX6S9N38BJz81/OaL9+5zW8IYmc7KB9uvynaHk8oA8iCaiQ1TM/nVq3
         UfEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+V3qC++ieQFTr7Yd4/Pu5oSkdeHj0cpYSD0adsBuL7Uzz4CLliH3vskYouInO0Q+Bj/ns+Lvk8+f6YM5zmeSakKhs+aN8eqIDf7cL9l3GzZb5SiJcScIaoA/TFOxBFQZz4rgLWyUYU0G78lH3RS0r/a2qEr8XotFVDlKeBf8uvCN6abxFjWuc
X-Gm-Message-State: AOJu0Yy0dlD3iXyoJgvgHNdSOUUzQfl79FGDx0/J6mnC/8cptXr417kf
	JWZys4BzokvxyPW0ldnj04rcscs7r8ZnH7b9Jdh+1FcN6xiHbgd9
X-Google-Smtp-Source: AGHT+IGMEPGj2cIdFSZx3F7l0nPa4xyjP/mdcUh76FVWdqfna8LOCIYLXNM660MLXRwUKYLZyzRolA==
X-Received: by 2002:ac2:4570:0:b0:515:d5dc:8fad with SMTP id k16-20020ac24570000000b00515d5dc8fadmr6363968lfm.9.1712063272672;
        Tue, 02 Apr 2024 06:07:52 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id a22-20020a19ca16000000b00515ac4ead56sm1742183lfg.271.2024.04.02.06.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:07:52 -0700 (PDT)
Date: Tue, 2 Apr 2024 16:07:48 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [RFC PATCH 1/6] dt-bindings: ROHM BD96801 PMIC regulators
Message-ID: <293f0dabaa9fb3c070d72617c59a4f69e4e2d5cb.1712058690.git.mazziesaccount@gmail.com>
References: <cover.1712058690.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3q8f6Dnc4ryHwvkZ"
Content-Disposition: inline
In-Reply-To: <cover.1712058690.git.mazziesaccount@gmail.com>


--3q8f6Dnc4ryHwvkZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ROHM BD96801 is a highly configurable automotive grade PMIC. Introduce
DT bindings for the BD96801 regulators.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 .../regulator/rohm,bd96801-regulator.yaml     | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd9680=
1-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd96801-regul=
ator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd96801-regula=
tor.yaml
new file mode 100644
index 000000000000..4015802a3d84
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd96801-regulator.ya=
ml
@@ -0,0 +1,69 @@
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
+      regulator-name:
+        pattern: "^ldo[5-7]$"
+        description:
+          Name of the regulator. Should be "ldo5", ..., "ldo7"
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
+  "^BUCK[1-4]$":
+    type: object
+    description:
+      Properties for single BUCK regulator.
+    $ref: regulator.yaml#
+
+    properties:
+      regulator-name:
+        pattern: "^buck[1-4]$"
+        description:
+          should be "buck1", ..., "buck4"
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
+    required:
+      - regulator-name
+  additionalProperties: false
+additionalProperties: false
--=20
2.43.2


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

--3q8f6Dnc4ryHwvkZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYMAyQACgkQeFA3/03a
ocX5IAgA0G/xEPK9GYFejv8vqqLDdtdfrzj9EWcdT9+AUEosuzhCmFJcmw5hRSwN
04hPbvKJw1/zLmQWR3jUBvRfyVtlNxQyjz67VCTPElmUu/ZeOMrA+iwz/D9WhGf4
Sqr6dMCkXHNTPxkE270VcSP9pkihb/lT5sYrWnUNEjjpxrQcp4yT8u82OmhVmM9j
mz9AQHP9XpqdKdBh3WGa0X4/aP5yUaNYEWSKri9bVrEPgLJbeYbnDbIOI1c1XpId
5f3AyGY7CITkWE1vHgAH4Fdb0o+IRUTK1618xKqxbF5CdmrF0xw+h+UQ1IQi71+s
o2HEQVNM2ns9Vm6q4wjUm/rueSANMA==
=0uvN
-----END PGP SIGNATURE-----

--3q8f6Dnc4ryHwvkZ--

