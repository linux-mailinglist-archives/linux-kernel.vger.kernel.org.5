Return-Path: <linux-kernel+bounces-2806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DBA816239
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5840D28287C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A3F481DE;
	Sun, 17 Dec 2023 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1IEyH7O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98D5481B7;
	Sun, 17 Dec 2023 20:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1D2C433C7;
	Sun, 17 Dec 2023 20:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702846704;
	bh=dmBWSGVLX9M37oiT1huSLuehN5K3OPoC+1LO7W8F6tY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g1IEyH7OZQ1cnB+nQKyx1BSZYuMienvw8IOun2jYHonpEluyYwv9USbHu2szK+2qL
	 ucwsTdM38FjI/AxRZwWZtyPVeBgkp6wTmMo4zRI9tlc0Ux/Ugozc3OdJRPiKdEr3GL
	 czSpLiaYYNM0D82bztxxwzeCVMGF1fd4qmpZuStPuHLZADNuMXsFqlDo/jRIYaPm0c
	 Zx3SB1xHxn9qngkt+bKIUAKV24IAIvjMjBHBKFwGWNQ+xyyZ6v48lt9WIUV+juQKC0
	 /rg2K86Oz+X8ayR/xFp4y41oqYSBVarau9KenEP3xwGGvRuTEuVvDugUwCtlP9etEI
	 uayy2Ky54TJpA==
Date: Sun, 17 Dec 2023 20:58:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Abdel Alkuor <alkuor@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add AMS AS6200 temperature sensor
Message-ID: <20231217-enlarged-mule-a594e472d007@spud>
References: <149032e99136a9fe47c3533b57a71092646e497d.1702744180.git.alkuor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0Nuw4ocMxTNpMmVV"
Content-Disposition: inline
In-Reply-To: <149032e99136a9fe47c3533b57a71092646e497d.1702744180.git.alkuor@gmail.com>


--0Nuw4ocMxTNpMmVV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 11:39:29AM -0500, Abdel Alkuor wrote:
> as6200 is a temperature sensor with a range between -40=B0C to
> 125=B0C degrees and an accuracy of =B10.4=B0C degree between 0
> and 65=B0C and =B11=B0C for the other ranges.
>=20
> Signed-off-by: Abdel Alkuor <alkuor@gmail.com>

Is this not v3?
Either way,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../devicetree/bindings/hwmon/ams,as6200.yaml | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ams,as6200.ya=
ml
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/ams,as6200.yaml b/Do=
cumentation/devicetree/bindings/hwmon/ams,as6200.yaml
> new file mode 100644
> index 000000000000..01476c1a4c98
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ams,as6200.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/ams,as6200.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMS AS6200 Temperature Sensor
> +
> +maintainers:
> +  - Abdel Alkuor <alkuor@gmail.com>
> +
> +description: |
> +  as6200 is a temperature sensor with a range between -40=B0C to
> +  125=B0C degrees and an accuracy of =B10.4=B0C degree between 0
> +  and 65=B0C and =B11=B0C for the other ranges.
> +  https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
> +
> +properties:
> +  compatible:
> +    const: ams,as6200
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        temperature-sensor@48 {
> +            compatible =3D "ams,as6200";
> +            reg =3D <0x48>;
> +            vdd-supply =3D <&vdd>;
> +            interrupt-parent =3D <&gpio1>;
> +            interrupts =3D <17 IRQ_TYPE_EDGE_BOTH>;
> +        };
> +    };
> +...
> --=20
> 2.34.1
>=20

--0Nuw4ocMxTNpMmVV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZX9g6wAKCRB4tDGHoIJi
0pt1AP9wa3Ox1pAcjn5pj3sf4FDkDATXqM48sSJn49Y6tvjAigEA/oTJrckePXPg
d17KRA0h1rPIryJLMl9jHSEA7Rip2QI=
=970O
-----END PGP SIGNATURE-----

--0Nuw4ocMxTNpMmVV--

