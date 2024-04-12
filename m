Return-Path: <linux-kernel+bounces-142566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9758A2D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8021B22D39
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2340A53818;
	Fri, 12 Apr 2024 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clN27y6b"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB923FBA4;
	Fri, 12 Apr 2024 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712920913; cv=none; b=bqXDGyeAwlIDeU47m6QgaJV5x9pai0hRegY/pDBjlDq68sPXYCqpPv7uXFo98sbFYnuYdd864vnQFg2PA5boPg8U5L68rMFU5e+BTJBAzY1uqPvhh9lMeww7s4fLtbhEUPK2uyaBnY43U2dZRzVeKYDlp32kapHs97Nk0tDflfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712920913; c=relaxed/simple;
	bh=ICjbDnzBp7YpJW5wHpjhB1igpp/jyJ4DlGLkYn0k7D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFCsGcTIqd9xEJKCkOdqr/J7yyg+x7/lXZ10Ar1a3Xf1wbu51jQ51JOy0U5sbYd5Wf/+c08uXl5JRb7CwKJVAg4w8KtKtw7UIBl6iqEsJu/JNTpxDFt35e1MRDBoJvGlHkrB//p+m+EO1h8VSqaqCT0iYXpQgsSUkPyhZqPN7wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clN27y6b; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2da0f8f7b24so3488411fa.1;
        Fri, 12 Apr 2024 04:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712920910; x=1713525710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f0FnZZT+KcP9KEAgIqjqP1/fvPTSQMK3ieIGYRwUR+Q=;
        b=clN27y6bBUUyS8xI3DMhm87GqmAmBb/MjHXpKi0a79DGx0eH2MEk1So80iLxbZVzet
         ORMlNwtCfHiCmpLVwym1uuS8Alkjge2msuy82m3mCQikzAiFNK6zdHKPNmhtL8XEaONw
         KBn49PGuKWaEbVV1gcT0DeXRcOPkWzbCewOm7eGg/7o2qF0wROaNGtetpKtYoV/GVjfh
         1qFQEyOp29fNLcCSdS5uzzjY8PlG2aHr7w11Dw9Uiw6mYk47mpWq0ZOXVWuUjL+rHB61
         XrErxQtf54KYXa1gZ2RSWxjaQDJAXepie5EBPidRh6PWALm0i1krxlbVzWoCeJYGJlNg
         Ld7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712920910; x=1713525710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0FnZZT+KcP9KEAgIqjqP1/fvPTSQMK3ieIGYRwUR+Q=;
        b=dS3ELkrbH+10gug7lVJOEOXejjb6MMEqlK+LATJ//t0o/BWnHbL1uzysaDtiokdPKs
         rVCAvoifQZyQ2h/EAg7XyHU621wWcSWFPkmzqqSay+jUr/DdROH1gJOCKoQKB6o3fVlQ
         PowpklZ6ralu+YUVBgIX/FuTotYIT6GtUOQU5dEWpTBAOriVvBqQB7zCeioqFyokZL+O
         6OXijKOTya2RZMZVdhFhcvn03NO0KoXBd792VT1xm3TAT+lO6tvve+CanIYuL+jt91rF
         cHiq4ZJo2wUVFZE96Rf1dfd5RnHdNPd3pTUR6uanh1Pb3FeIws1jxTX2r8/gHu8WN0pN
         d/bg==
X-Forwarded-Encrypted: i=1; AJvYcCXcxhqYCbxJBuY9UZcR2jmy0O8GYfuGtrVCw64D0anAoTgumvqS8oNWnRtX5sZtCHjKg2tK6xz06F1UHnSiPJXORGWrxmp0W0fdEvUWoaAWPa/gSTLjX65yc8jh4/bzUDGYepPmagDpoU9FmSxOCZLEf7j3fgyf6mBZ3KUnKoyWNIcpi70Y2khO
X-Gm-Message-State: AOJu0YxcTBhyaJWQst8hUpujsLQZq3+bf0kEYZF5Pb2cz6AGD+We2FwV
	68gzv0C2f8j/nO5OZndgVPt8c+M35bhiHGzFo1y92SwpZicdwJTZ
X-Google-Smtp-Source: AGHT+IGAU1wM3iGx1bcc2Bp3RGehHS3EmMJfEuFkOpeIZTEtADx9nAWEEmpZDaqqY15QctMYNO3X7w==
X-Received: by 2002:a2e:be1a:0:b0:2d8:4892:bee2 with SMTP id z26-20020a2ebe1a000000b002d84892bee2mr919183ljq.20.1712920909508;
        Fri, 12 Apr 2024 04:21:49 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id u12-20020a2e2e0c000000b002d9f87402e3sm291732lju.51.2024.04.12.04.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 04:21:48 -0700 (PDT)
Date: Fri, 12 Apr 2024 14:21:44 +0300
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
Subject: [RFC PATCH v2 2/6] dt-bindings: mfd: bd96801 PMIC core
Message-ID: <ea49494429528cf8e60fa984ae1f523ddacd850c.1712920132.git.mazziesaccount@gmail.com>
References: <cover.1712920132.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FddxCH5IwRm71hnx"
Content-Disposition: inline
In-Reply-To: <cover.1712920132.git.mazziesaccount@gmail.com>


--FddxCH5IwRm71hnx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ROHM BD96801 is a highly configurable automotive grade PMIC. Introduce
DT bindings for the BD96801 core.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
RFCv1 =3D> RFCv2:
  - Document rohm,hw-timeout-ms
  - Document rohm,wdg-action
---
 .../bindings/mfd/rohm,bd96801-pmic.yaml       | 171 ++++++++++++++++++
 1 file changed, 171 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic=
=2Eyaml

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml b=
/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
new file mode 100644
index 000000000000..31ef787d6a8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
@@ -0,0 +1,171 @@
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
+  rohm,hw-timeout-ms:
+    description:
+      Watchdog timeout value(s). First walue is timeout limit. Second valu=
e is
+      optional value for 'too early' watchdog ping if window timeout mode =
is
+      to be used.
+    minItems: 1
+    maxItems: 2
+
+  rohm,wdg-action:
+    description:
+      Whether the watchdog failure must turn off the regulator power outpu=
ts or
+      just toggle the INTB line.
+    enum:
+      - prstb
+      - intb-only
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

--FddxCH5IwRm71hnx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYZGUgACgkQeFA3/03a
ocWwEQgAx1At5FCLa0qYwXh4bb2NdqJphOImuCWpRjpt8lk1prqtYLtkPXVi+ZgI
ihQi5vrbdCddYWsJMa1OUfDLF9mEXjVvLa1T2vDTAK4XvcI5zmrtuEMt/lgeCfXy
wi7HWj1juzg/8G6Iulng+aDqGMhAHJygP6XGvGGVuCOGNWvJIpmIbMkulmCn+Ayw
2GQaZLk9qOWXk35gXKkfG9TrIw+QxbkLMaqR4IHyL0S6N7t92qrviF8iWGHbCPrM
bKFDaWM9hHyfPJ1VwB0F05a7MIn9VuVP1cEek3Jc7UHl/pkSuOXDzWDjIcRj7GlD
XC5MDVwmjDmagMIuA+QMg8GOZyce6A==
=brO6
-----END PGP SIGNATURE-----

--FddxCH5IwRm71hnx--

