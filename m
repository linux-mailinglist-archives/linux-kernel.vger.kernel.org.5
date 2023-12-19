Return-Path: <linux-kernel+bounces-5472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704E1818B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9E928B23D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3FE1CA81;
	Tue, 19 Dec 2023 15:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJku28t7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83511C68E;
	Tue, 19 Dec 2023 15:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1A6C433C7;
	Tue, 19 Dec 2023 15:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702999111;
	bh=Cg5b/5tI5hGW7/qm/Gvqq5j7ejZo4mNgei7t5YpHVwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJku28t75geTgwb87nJfm516qgeb03gxGqykx+Ug53UD5+ZnGpYLpNofyeLcoTdxs
	 qNT8X5bjaNvrQQRlkb5gGCDkSfeQHtHKINalhLVEMlI7a/WW9UMlQpuAfZ4zoUlY7M
	 YtB+0wtg4Yozgxokvxy15xmsTcskzZqBpqgW1HqE75D6PRzyRfEHb+cdW0Uuow+z2e
	 kQUy/27RqwLq6paKhlxh+RU6E+nJaSFK7rZwyneQKqb/AlL8Koky++JKGnlnFwe214
	 EbJ/cK07hErgkRAf/jW4mxcicLw1NZmZQ3YRhlPvg/R8EDbnWPVzUk+MY7tnyWiGI2
	 60c5+uH/T51Dw==
Date: Tue, 19 Dec 2023 15:18:24 +0000
From: Conor Dooley <conor@kernel.org>
To: Abdel Alkuor <alkuor@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: (lm75) Add AMS AS6200
 temperature sensor
Message-ID: <20231219-mascot-semester-7d2c492b99bc@spud>
References: <89fb5eec30df734ee8fc58427cf5d94929076514.1702874115.git.alkuor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rMcjOlarOJdLELTJ"
Content-Disposition: inline
In-Reply-To: <89fb5eec30df734ee8fc58427cf5d94929076514.1702874115.git.alkuor@gmail.com>


--rMcjOlarOJdLELTJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 11:52:27PM -0500, Abdel Alkuor wrote:
> as6200 is a temperature sensor with a range between -40=B0C to
> 125=B0C degrees and an accuracy of =B10.4=B0C degree between 0
> and 65=B0C and =B11=B0C for the other ranges.
>=20
> Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> ---
> Changes in v2:
>   - Incorporate as6200 into lm75 bindings
>=20
>  .../devicetree/bindings/hwmon/lm75.yaml        | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Document=
ation/devicetree/bindings/hwmon/lm75.yaml
> index 0b69897f0c63..63b85a83ac18 100644
> --- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
> @@ -14,6 +14,7 @@ properties:
>    compatible:
>      enum:
>        - adi,adt75
> +      - ams,as6200
>        - atmel,at30ts74
>        - dallas,ds1775
>        - dallas,ds75
> @@ -48,6 +49,9 @@ properties:
>    vs-supply:
>      description: phandle to the regulator that provides the +VS supply
> =20
> +  interrupts:
> +    maxItems: 1

Do the other devices here have interrupts? If not, you just allowed
interrupts for them. You, at the very least, need to add something like:

diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentat=
ion/devicetree/bindings/hwmon/lm75.yaml
index 63b85a83ac18..d7ce96606400 100644
--- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
+++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
@@ -56,6 +56,17 @@ required:
   - compatible
   - reg
=20
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: ams,as6200
+    then:
+      properties:
+        interrupts: false
+
 additionalProperties: false
=20
 examples:

I had a brief look at the driver though, but I could not immediately
tell if the interrupt was required on the ams,as6200 or if the driver
continued on without that functionality. It seemed like an additional
feature that the interrupt was required for, but if not you should make
the interrupt required for the as6200.

> +
>  required:
>    - compatible
>    - reg
> @@ -66,3 +70,17 @@ examples:
>          vs-supply =3D <&vs>;
>        };
>      };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        temperature-sensor@48 {
> +            compatible =3D "ams,as6200";
> +            reg =3D <0x48>;
> +            vs-supply =3D <&vs>;
> +            interrupt-parent =3D <&gpio1>;
> +            interrupts =3D <17 IRQ_TYPE_EDGE_BOTH>;
> +        };
> +    };

Can you make the indent here match that in the other example in this
file please?

Thanks,
Conor.

--rMcjOlarOJdLELTJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYG0QAAKCRB4tDGHoIJi
0oE9AP9ycm0+Rys8Qk2t0D9tOjOGpCdtzTvUj/tJa/BAOWIKTgEAwFfN1T6mCAR8
GYZEQa3F2bPm+e607/CqKVAZitrREAw=
=JdZv
-----END PGP SIGNATURE-----

--rMcjOlarOJdLELTJ--

