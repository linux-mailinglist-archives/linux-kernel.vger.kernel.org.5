Return-Path: <linux-kernel+bounces-163881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0748D8B7519
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17F96B22090
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CC013D2A6;
	Tue, 30 Apr 2024 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGzSZe94"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2819383A5;
	Tue, 30 Apr 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478433; cv=none; b=YglznzN51PT85Y9k7A99hrQUSP8dANM9hJ0H0RG0lDDSN0xork3BxHdjWlSQI62DES75XHBDvfgPoTWCMWRMpzZTKjXtVcwLyqsmItsjYxk4Csc7nvIyGyjvsz+Nren8VPr1rNW95SCaRiHG4jEvuMhJabGvdrFSBoDHMFYsJDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478433; c=relaxed/simple;
	bh=WsVI0PWkDKpF9nx8WkAVWb0p4taRtuJlTv+0+Ey7HC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaW07RlMeQzSW0ij9mRHAWuda/SUKWyNWJ/YV2ee9xxaSf8T8v0VMqnMdYwFt3BP20cZ+FOQeD4ESIivcf5a+1SCS1eD5yksJGS0jdhVurwUQ1ZTxsVroQSYLlAu9aiqgeapjEDLSHaZ5gZSGcVxBxuWRRCDrT5IuX/Sc1eTWc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGzSZe94; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2db13ca0363so89660221fa.3;
        Tue, 30 Apr 2024 05:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714478430; x=1715083230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NZfKSrx+PwursxVEIYsHbSPwNnhFIBwQF840+S2boqw=;
        b=bGzSZe94yZNA1TqLUOtfT8rlxNdibJEo+RUz4zkNCv/C5vXDxhWS+5jcxEZ93zrAc7
         TLO80ldRygDfAjknVX2DRBlVPPt1cS707XSU2hCs+bw45ox1RWxE4I1pAlSEsP8Zwuzn
         d3yISQIBAL2mt1RCJTvZrRELRolRpGAPOGOcMKF4gGzjyYuZ7xivQOStJmBxcwbN8ORe
         7BZauYuvcIBPOy+qNFwlXqBSUG+6KhYxyw8HqG3w3m9TL+PSmCbVJWYWigpXSToLQ6Sx
         4XaecrjjbDHnJS70DrM3Qq3MISusLooAq8KPAYhugZZrH3fRi4HtCZjDcveZzzbbd2NF
         nyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478430; x=1715083230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZfKSrx+PwursxVEIYsHbSPwNnhFIBwQF840+S2boqw=;
        b=en0bdg6N6jnMjcaiImEc404RKWbOJZ+wnr9hcvGA1yz1/hPnXczsmMn0c7AAIyyDFS
         ogTI1sIOBs2dzNCzC03Z6OgpvcucT/M8qjHPPPezXLhBZjWGKaFj+BzSkZsHfWb7dmAc
         4XpZx2G4xa6SmqQbNIowfwR7I7vNnj90omCK1PSALztKpPhritcZWGXSvD0fZ3D2RYmV
         xHDfNlgge2LTpYWrPgXSK1MqBxOjeWYdKgIIrQdmYN9CM3Ym6baYfxs3n/5u3BnKnRRz
         CsEQV5cEptfwfPFjIZqbCh5DOLQjd+5AuqW0fuRCVo9bxfL4HOt4J1oxLyAtBxySM48S
         HTag==
X-Forwarded-Encrypted: i=1; AJvYcCXm0v0cXPh4MsOhdeBqT/LlZIgQ3Uc5sNvuial4q6FhKMH5SAvWjbPxJt5X6JEELBN6MT6zRZ7tSw6ZiHRznbSgbafVd/Q/c6WGWE0zkUGtoRBSLo+sWquK52LmeMqhC3CUZATKbN/ujv9Iih7pez63X1mVO3Y1bZrWzeO/pgGAepwP6LtqDKD2
X-Gm-Message-State: AOJu0YyWt/lYanJQ62XO0dshJj0bIqLW6C0M7QTipQwl7i5n1RYb7vxu
	tnS2wc60MWElef9gln3HgY1Fbcn45yVGDSxcr5EdYRx6fsADZaqp
X-Google-Smtp-Source: AGHT+IH1lxIV8eIVLRottFtZZRGw3SIaT6l+9Ocx7YJtfpO/iOi4VdKc1Lbc89r4kw/K4ziFbncLSg==
X-Received: by 2002:a2e:b714:0:b0:2db:c2e0:c541 with SMTP id j20-20020a2eb714000000b002dbc2e0c541mr9443777ljo.53.1714478429488;
        Tue, 30 Apr 2024 05:00:29 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id w22-20020a2e9996000000b002da2c2fc293sm3863284lji.121.2024.04.30.05.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:00:26 -0700 (PDT)
Date: Tue, 30 Apr 2024 15:00:22 +0300
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
Subject: [PATCH v1 2/6] dt-bindings: mfd: bd96801 PMIC core
Message-ID: <a24dd49567cb9a7de675b0c2ce9f76eb66a8d392.1714478142.git.mazziesaccount@gmail.com>
References: <cover.1714478142.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FoNsMpK+6k4k1QOb"
Content-Disposition: inline
In-Reply-To: <cover.1714478142.git.mazziesaccount@gmail.com>


--FoNsMpK+6k4k1QOb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ROHM BD96801 is a highly configurable automotive grade PMIC. Introduce
DT bindings for the BD96801 core.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
RFCv2 =3D> v1
 - minor cleaning
 - add timeout-sec

RFCv1 =3D> RFCv2:
  - Document rohm,hw-timeout-ms
  - Document rohm,wdg-action
---
 .../bindings/mfd/rohm,bd96801-pmic.yaml       | 172 ++++++++++++++++++
 1 file changed, 172 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic=
=2Eyaml

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml b=
/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
new file mode 100644
index 000000000000..fce338681302
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
@@ -0,0 +1,172 @@
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
+description:
+  BD96801 is an automotive grade single-chip power management IC.
+  It integrates 4 buck converters and 3 LDOs with safety features like
+  over-/under voltage and over current detection and a watchdog.
+
+properties:
+  compatible:
+    const: rohm,bd96801
+
+  reg:
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
+  timeout-sec:
+    maxItems: 2
+
+  regulators:
+    $ref: /schemas/regulator/rohm,bd96801-regulator.yaml
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

--FoNsMpK+6k4k1QOb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYw3VYACgkQeFA3/03a
ocXYfAgAlZnYEpZS5ZUdcyNLSL8LMwDIAr6uvfb2S4pYP7a1ovAvDZx7rWyRI9vh
9DIB1+GX7plyyQIEkhdughyLl6Eb3X+dCoJUx44mJ6RGPiOKgIvbBUP1HUevRVOp
LGpCcHb6P591FyCGKe4dwlZhLB/jr9nS7LeTrKumMwYlOEfSTHDOvPgphNeTjDT1
eRdO4LIfrhAkR3cgXMjte+wMScPzQkmIcAXOXBcZbArfLVSWDxNBlagjsoROs3fR
+/n0lt93jmDPhItlgZ+E6j0D9kolNeUZXACe2/UeK301WP7IzCEVT5sBTFqzPpyt
gO5V52rkQI7EEwZBWnuSp4YbxBqrGA==
=sYLl
-----END PGP SIGNATURE-----

--FoNsMpK+6k4k1QOb--

