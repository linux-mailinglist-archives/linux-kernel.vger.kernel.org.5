Return-Path: <linux-kernel+bounces-128003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 709AE8954D4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC521F26010
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744AD8526E;
	Tue,  2 Apr 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yd/xTT6l"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956047FBB1;
	Tue,  2 Apr 2024 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063296; cv=none; b=RU3Vkuaiz4uFjMw8+w9+/dEK2/Nnvurs4dKayM2WI1200ADugeuYvMJqJOPkacgCkFjz+vkJM736tcKNBpyvsIG8FL4DY7LpMAonLivm/yiCKKzi1hrHLj+QWXB9N50+8klp4UcQeyyHQ3akOeVIlRUV4vGHhGlvdEKBuQqMdQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063296; c=relaxed/simple;
	bh=h/SRFFoQahv/2WTtb3N/Yc2EPcE9jm/wdTxm2fXzcNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwpE8V/gh49pO1CbuO3LQJfsxIQBGilqmpRD2RnmUgQFv9wnRywBHa5tsJJ+bgRJZ4NjTpXs8lTohKYJS9Ohpu0iTklCf5oW8OpKAouPwDbO0FsmXWaA1PWgMkCkv9rH0DDSmxxqd6pBHmFEspcnADzcnc/NH8MU4OhT3BJR8t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yd/xTT6l; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51588f70d2dso6802323e87.3;
        Tue, 02 Apr 2024 06:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712063293; x=1712668093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+qPCFmSJWSkRP3Bq2Sdn0FQYOOLtpoSr9p5xtyWUSwg=;
        b=Yd/xTT6ln0Q5wLs3X6URcPimrFXLFXbUc8aswMrYVDaegyn3Mi3qZJ+RoWrZALcYg4
         wJSdYeu9eWPMFBnlEIOhq+8JsouzeY/W5rvsfHAySiebkJDXzU3NCtfBeFYN+oQ/qM1V
         /e9LK9rH/V4nx24VtPK5HapiUmBIpZ9KRf6thZ3GY+354ogGDzPhO/lPXxzAFrPXSbgR
         xmtFfBb4HDkjMFubFVZMIu3clvQncRifXFeoFPRi1KsGx6JWXcBJeFZDncqFfUOSwkwe
         WoxWDqXQ2slYzOkbQE66E+Oh2nh0BpC99KDRQL3JOGRTDKmZhoElMTPw7UeF9pLH6U13
         FzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712063293; x=1712668093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qPCFmSJWSkRP3Bq2Sdn0FQYOOLtpoSr9p5xtyWUSwg=;
        b=MXNxPXthKvwEZPMu7pyHkv+GgCwfLWctaBO2w5T+h5kBb4Gwy+bJIUNy+Y5fHfPOO3
         Z8e2EaW20jmd3cWStvnmBW57efgdoC4u9qBzDrLQRLABJG00ut2lb2eLZEiL3u+bF+Hb
         ACZ2/QBhp4dtdGfkqqd3LbHCRSi9qfOddqAve3hqW5OVV3X2pFcAIVCBVwlxj5Rn58RN
         YZDcC9hG6VhuPWVpISBpfL/bG+gXEPO0ddg+vOKh2G/WjYmLD/GH86QhmFh8uIHymuso
         R0svgv7S1X9HDIzhFwCWenxkpoPKIhFWAAvNzSZDnVmy0F1rRYNXQo4v7RK/PjsvdR8/
         9J9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUW4xI1LY8TXaKKlosfoLGTgGIZ77FTW2qFCoaExOP4Qt9xioWT+QEt3NCFBEC6aK3hz67Y9ylH857h7yQfQWjNj1Tu+oNQ9gSeuc8AloOvqKpiftnrrl6MjqQa4b4vZvFb9plGKqkR0zTKtvOnb81ydl6lMrhKNSJWc1GF5oYkE+WqQhtlGYlW
X-Gm-Message-State: AOJu0YxgSvh9APqR91xC54F3mexPowX+YCAPjVxc9CRHJ0Q2N/RWCRFS
	lqY18le0wtMjFQOOzgQTof52k5tkcroys+N+UqbDKmnt27FZTKXmT++dKYVT
X-Google-Smtp-Source: AGHT+IE3ezZBDx2wBIqjnF9l9mn5sokOcqKwU3G4yz29XjH/jY/x9aHtp8030qQfry+f0rVY/26ULw==
X-Received: by 2002:a05:6512:6cd:b0:513:5e6b:a191 with SMTP id u13-20020a05651206cd00b005135e6ba191mr9245189lff.50.1712063292439;
        Tue, 02 Apr 2024 06:08:12 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id f25-20020a193819000000b00515a614c6easm1740728lfa.23.2024.04.02.06.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:08:11 -0700 (PDT)
Date: Tue, 2 Apr 2024 16:08:07 +0300
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
Subject: [RFC PATCH 2/6] dt-bindings: mfd: bd96801 PMIC core
Message-ID: <8eeda07847b14438d3dd4e61cbfa3cfbfd51d750.1712058690.git.mazziesaccount@gmail.com>
References: <cover.1712058690.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kn48Aktgc7gzaBgr"
Content-Disposition: inline
In-Reply-To: <cover.1712058690.git.mazziesaccount@gmail.com>


--kn48Aktgc7gzaBgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ROHM BD96801 is a highly configurable automotive grade PMIC. Introduce
DT bindings for the BD96801 core.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 .../bindings/mfd/rohm,bd96801-pmic.yaml       | 155 ++++++++++++++++++
 1 file changed, 155 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic=
=2Eyaml

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml b=
/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
new file mode 100644
index 000000000000..0d512fe19081
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
@@ -0,0 +1,155 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/rohm,bd96801-pmic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD96801 Scalable Power Management Integrated Circuit
+
+maintainers:
+  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+
+description: |
+  BD96801 is an automotive grade single-chip power management IC.
+  It integrates 4 buck converters and 3 LDOs with safety features like
+  over-/under voltage and over current detection and a watchdog.
+
+properties:
+  compatible:
+    const: rohm,bd96801
+
+  reg:
+    description:
+      I2C slave address.
+    maxItems: 1
+
+  interrupts:
+    description:
+      The PMIC provides intb and errb IRQ lines. The errb IRQ line is used
+      for fatal IRQs which will cause the PMIC to shut down power outputs.
+      In many systems this will shut down the SoC contolling the PMIC and
+      connecting/handling the errb can be omitted. However, there are cases
+      where the SoC is not powered by the PMIC. In that case it may be
+      useful to connect the errb and handle errb events.
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - enum: [intb, errb]
+      - const: errb
+
+  regulators:
+    $ref: ../regulator/rohm,bd96801-regulator.yaml
+    description:
+      List of child nodes that specify the regulators.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/leds/common.h>
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+        pmic: pmic@60 {
+            reg =3D <0x60>;
+            compatible =3D "rohm,bd96801";
+            interrupt-parent =3D <&gpio1>;
+            interrupts =3D <29 IRQ_TYPE_LEVEL_LOW>, <6 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-names =3D "intb", "errb";
+
+            regulators {
+                buck1: BUCK1 {
+                    regulator-name =3D "buck1";
+                    regulator-ramp-delay =3D <1250>;
+                    /* 0.5V min INITIAL - 150 mV tune */
+                    regulator-min-microvolt =3D <350000>;
+                    /* 3.3V + 150mV tune */
+                    regulator-max-microvolt =3D <3450000>;
+
+                    /* These can be set only when PMIC is in STBY */
+                    rohm,initial-voltage-microvolt =3D <500000>;
+                    regulator-ov-error-microvolt =3D <230000>;
+                    regulator-uv-error-microvolt =3D <230000>;
+                    regulator-temp-protection-kelvin =3D <1>;
+                    regulator-temp-warn-kelvin =3D <0>;
+                };
+                buck2: BUCK2 {
+                    regulator-name =3D "buck2";
+                    regulator-min-microvolt =3D <350000>;
+                    regulator-max-microvolt =3D <3450000>;
+
+                    rohm,initial-voltage-microvolt =3D <3000000>;
+                    regulator-ov-error-microvolt =3D <18000>;
+                    regulator-uv-error-microvolt =3D <18000>;
+                    regulator-temp-protection-kelvin =3D <1>;
+                    regulator-temp-warn-kelvin =3D <1>;
+                };
+                buck3: BUCK3 {
+                    regulator-name =3D "buck3";
+                    regulator-min-microvolt =3D <350000>;
+                    regulator-max-microvolt =3D <3450000>;
+
+                    rohm,initial-voltage-microvolt =3D <600000>;
+                    regulator-ov-warn-microvolt =3D <18000>;
+                    regulator-uv-warn-microvolt =3D <18000>;
+                    regulator-temp-protection-kelvin =3D <1>;
+                    regulator-temp-error-kelvin =3D <0>;
+                };
+                buck4: BUCK4 {
+                    regulator-name =3D "buck4";
+                    regulator-min-microvolt =3D <350000>;
+                    regulator-max-microvolt =3D <3450000>;
+
+                    rohm,initial-voltage-microvolt =3D <600000>;
+                    regulator-ov-warn-microvolt =3D <18000>;
+                    regulator-uv-warn-microvolt =3D <18000>;
+                    regulator-temp-protection-kelvin =3D <1>;
+                    regulator-temp-error-kelvin =3D <0>;
+                };
+                ldo5: LDO5 {
+                    regulator-name =3D "ldo5";
+                    regulator-min-microvolt =3D <300000>;
+                    regulator-max-microvolt =3D <3300000>;
+
+                    rohm,initial-voltage-microvolt =3D <500000>;
+                    regulator-ov-error-microvolt =3D <36000>;
+                    regulator-uv-error-microvolt =3D <34000>;
+                    regulator-temp-protection-kelvin =3D <1>;
+                    regulator-temp-warn-kelvin =3D <0>;
+                };
+                ldo6: LDO6 {
+                    regulator-name =3D "ldo6";
+                    regulator-min-microvolt =3D <300000>;
+                    regulator-max-microvolt =3D <3300000>;
+
+                    rohm,initial-voltage-microvolt =3D <300000>;
+                    regulator-ov-error-microvolt =3D <36000>;
+                    regulator-uv-error-microvolt =3D <34000>;
+                    regulator-temp-protection-kelvin =3D <1>;
+                    regulator-temp-warn-kelvin =3D <0>;
+                };
+                ldo7: LDO7 {
+                    regulator-name =3D "ldo7";
+                    regulator-min-microvolt =3D <300000>;
+                    regulator-max-microvolt =3D <3300000>;
+
+                    rohm,initial-voltage-microvolt =3D <500000>;
+                    regulator-ov-error-microvolt =3D <36000>;
+                    regulator-uv-error-microvolt =3D <34000>;
+                    regulator-temp-protection-kelvin =3D <1>;
+                    regulator-temp-warn-kelvin =3D <0>;
+                };
+            };
+        };
+    };
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

--kn48Aktgc7gzaBgr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYMAzcACgkQeFA3/03a
ocX3MAf/Qf+vOy42SjIZtY2zn09nxHIaMt0idD6pxSHgciWxUX1dKU/nYHb+tLN9
ImcnW9W7sfzmcNVPSZ6hPuv6e2aAuO6J4LOpvR3pjhtM3SCzDcKCrU2LiB33MyQW
cAh513Nz1JUuuerq3JprSQvnZ0i4iqxyrjqpQnraADDDMM9gd6Cnui6w35Bqm22y
9Hritrs6uoZbU5jc0kl2so1knhYQOnt0IEIvF8+MfgMpGOyuRA5nymVh75LBfllW
a4jcejz3OESMe6c5rLW4RdHY7Bgswi8TTjSrc/7ZODmMui6KnZMMNAhmUmEAkmVU
OKllkvNa5EK221nv5vo0p4T+UWNklA==
=Jnsb
-----END PGP SIGNATURE-----

--kn48Aktgc7gzaBgr--

