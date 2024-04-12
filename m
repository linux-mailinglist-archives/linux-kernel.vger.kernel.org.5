Return-Path: <linux-kernel+bounces-142564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5288B8A2D36
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45AA1F23107
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070875490E;
	Fri, 12 Apr 2024 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="la2JI6cn"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3550A6C;
	Fri, 12 Apr 2024 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712920888; cv=none; b=DJsoGgUqDEPGHAw1RjiNYP1C63fiSyju+YXg3AtlKhjc35S6SX7avn/oABTgJTi2XBc8chz4ylTXniC7P3X2HxDc1nxtI7vfjVoRLPeGhgUxy4lQkjK1yBCXkei0HiV6LBp0IaNtMwoyvYcmNuBHSEotcqxa4sL2w3CzSLWh5sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712920888; c=relaxed/simple;
	bh=TrYz9UDqxWjwVJaiIKMAsZXTVaUZhuYJVQblCZVXou0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Winr32qjNPHeT5/gfRSFGytGLSLMjm3faX0NiCCFkgxoMBQSbIWQinpVVS9o7vh9/Zhi/2ETVD+sbbSKmXJP8ZL8BkPP07Kl3MZNMzNj8pk46dEW85BvVuZC404TgvUQMIWrjZmjNBfxujINY/bPsgM+5xoP6dML1OoG8mcY9gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=la2JI6cn; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-518931f8d23so220461e87.3;
        Fri, 12 Apr 2024 04:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712920885; x=1713525685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rC42Iv2fV40TZlZTcwRZ45fA0AdSbCtIhnE2lMAxxcM=;
        b=la2JI6cnsjwLm3uw9pKcg879+AjuPmFkQxS3hlgPdjwP2P1dtksqzcRWA/kIJH2PIP
         vHwZj7w3MT+ol/wDNLvkrp96JdUmen10Qhh7IyQr7LoDZeX2n9wREKdKUL4nSMqiAziB
         A/V5eHr/XhB6v6lh7bV38qRSeSxukv/Zcmk0eTEPQjcSv9mpl31L0N01Mrftdw/kdWe4
         KMjOrJhyk9YIuYHOaXE8D6/CHD4Lu5uSUsKOruTJngR+vbHfZK3HTXGbK9T7KEHTPO1z
         bEJRVF1JznXz5NIbhjwgIvUUKdAvDNTOu1hWqHO4KgUJgSpYuBjwxCquhGgnmUt2jkNU
         xlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712920885; x=1713525685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rC42Iv2fV40TZlZTcwRZ45fA0AdSbCtIhnE2lMAxxcM=;
        b=aRv8Lc/kUt/hdkbxmNOvbjTifcWkwz5u+FLySYkDyIRm+tzu6oZezFYepkMKHZTlT5
         MzDmXNW5o0JggIlM5umDVcLcXtrd5mrYirqXmGsJUJhtLdlXmPGULfHj4g/s7rDHOF9o
         cF/MIPZqXlVXsjVFjp5HW3WPdnDGdM510W2RqQZzRIbLJlOceU9T4ZN7NPfMeLXBfbLe
         NdKdF8kMnvtWlVx66U/IBQw0DQkyx2XfAdrmIkqXnGLQzKTOeuQxpZOgu+PM8olCN5SW
         q8/VbPvr8tAT8ymCIykZymN3sEtW+tgHFgm+mkTlzotYDwzODwdKI756BjG+hsTCh61V
         cpQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTwwv0Nnk6S8bL0C6ctgGmKlzvDnV51ZSk8O7R7dnnxPqG/2wHOJGTP5D5x7U4aAvN+B3u6AxSTaY7hhJcHa6Mwo3X7Ld0glle2vIh9NENFKTblJWSXBzuwuHQMgpE2rLgbDdIOowM9OZZn9h3UTIcSSRuEMz8BN/YNhzCpomyCZbwBrs7YqAZ
X-Gm-Message-State: AOJu0Yx+KRZb/A1iplUm/jhuZO1z3aZ97nfOGs6TvmvYH01mGVSnn/eV
	sZgZoSrOx1ucp+JIRtWi5ndl+rRlFlKH2Wuh92ZIgsV+DiQcxfAV
X-Google-Smtp-Source: AGHT+IEZycmTojkKN9PWrCiQ9xYtYdUa28iY1OYShhXvIFi0fw+RbuwzJnpgvVLWgR4Hsrqe9aLHvg==
X-Received: by 2002:ac2:4182:0:b0:516:d0c2:755 with SMTP id z2-20020ac24182000000b00516d0c20755mr1391618lfh.63.1712920884392;
        Fri, 12 Apr 2024 04:21:24 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id f1-20020a056512360100b00516c5eef5c7sm496404lfs.243.2024.04.12.04.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 04:21:23 -0700 (PDT)
Date: Fri, 12 Apr 2024 14:21:18 +0300
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
Subject: [RFC PATCH v2 1/6] dt-bindings: ROHM BD96801 PMIC regulators
Message-ID: <27a1c489f62e46a80643fe86cca101fb5aadb7f4.1712920132.git.mazziesaccount@gmail.com>
References: <cover.1712920132.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CBMlU3iBsibC+fvd"
Content-Disposition: inline
In-Reply-To: <cover.1712920132.git.mazziesaccount@gmail.com>


--CBMlU3iBsibC+fvd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ROHM BD96801 is a highly configurable automotive grade PMIC. Introduce
DT bindings for the BD96801 regulators.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
- No changes since RFCv1

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

--CBMlU3iBsibC+fvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYZGS4ACgkQeFA3/03a
ocUMhwgAv3OfDjN8vqibNLKzONmxpCc0pyu5mxH7Z6o1iRcyp+PDn51va68nxvPx
hYaDizDr2B/U7xAFD9+h+1D1OqnLmDqKgsZZzuovdnse4yxUxQV7nBrsWYtmSAcH
q9gE9rfAm/c653N7XgCbHEWIGaI5u5dIpubMUAFwwQOgd1YNnMBbVxsSN25QEKiu
ZJDMFlXSpOSuqtpyLnf7KI/99oWarw7t0DDgyGWrVJPCukiughgjkVT7bRyLbTHz
/+tr1P8DsQILJF5AnhedZHtWcg9yNPHpn1XDNqZLC6IOZAq4U96C/zN5mVu7g0ux
UpV0VrJJWkmHd/HZgmhxz66SC62NJw==
=p5Kz
-----END PGP SIGNATURE-----

--CBMlU3iBsibC+fvd--

