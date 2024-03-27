Return-Path: <linux-kernel+bounces-121646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE96F88EB8F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79DE01F2890E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB5E14D2AA;
	Wed, 27 Mar 2024 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wbsn3sbd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D99814D28C;
	Wed, 27 Mar 2024 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711557960; cv=none; b=XnrbvSdDjyOzLzmmyM3Viq3kice60vzUlEpzmEehhqutxYH8yoxYpdckl4o1TmBEzM6Gmzkgp9sKshmwc77sWbXZeIUqnqm28B62DJwnKbmveUbAa6sc9IQ3jKdrgOUHPhw8UpaWAbiW53VDjnDvqBosNCFxnkprsTiKVOIxFg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711557960; c=relaxed/simple;
	bh=G07WywINU3Bzv6JM2n7rRsZvGgJbHkLoaNbCahhkI/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTnpaEik8yprintlHbREK/7Q2sAIEL+aREZhuY9E0ppqPRFfEs4MouZLReGI6Q8R6Z6xwLk1l0BAGdhThlBUU+/IPFUuGfIoFfpJT9yzEt6j5Yyck/vtHbLxjAvlE2/KMBQzQBlmuPeZ5Ov7nv5HOQVtzkvGqLpHAb54qbuWcJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wbsn3sbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3364CC43390;
	Wed, 27 Mar 2024 16:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711557960;
	bh=G07WywINU3Bzv6JM2n7rRsZvGgJbHkLoaNbCahhkI/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wbsn3sbdlX2LXVgkJeZJJ2ABx2V0W2oFmdxr93mmulY4UB+sU3g3FSm3VtIoOOFBI
	 TbbPw0fDL9ABdDD+5XxXbCalIC+cgESESC/1TCWnMPH+CpyLg5g1P5IDuPufLSH8a4
	 Vbfgz2KRAwhnsjZoxGu2ipzFk5dLqlNAZduttVxYqPwbuaR+53v5Z6dBYnL09k+c/L
	 CXNN/bYBKNTQRNW2f6rnnJcSZs6AsMhFj6IZFGun2O4Ztb/+v7RWlJ5jjgq+kNNu2X
	 3F4s3DLfluaMCvLuJMpxAI13zfOS+/02fGTuu17+YQBlAnVPm89XHLXG2MLr2Ttlxk
	 wV13xIUXsJMgg==
Date: Wed, 27 Mar 2024 16:45:56 +0000
From: Conor Dooley <conor@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: ata: ahci-da850: Convert to dtschema
Message-ID: <20240327-dumpster-capital-fcb7d205b294@spud>
References: <20240327064354.17384-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VU9LhsKx0E9NZ6tS"
Content-Disposition: inline
In-Reply-To: <20240327064354.17384-1-animeshagarwal28@gmail.com>


--VU9LhsKx0E9NZ6tS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 12:13:51PM +0530, Animesh Agarwal wrote:
> Convert the ahci-da850 bindings to DT schema.
>=20
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
>=20
> ---
> Changes in v3:
> - Fixed line length issue on line 20
> - Removed unneccessary '|' character

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> Changes in v2:
> - Added description for reg property items.
> ---
>  .../devicetree/bindings/ata/ahci-da850.txt    | 18 ---------
>  .../bindings/ata/ti,da850-ahci.yaml           | 39 +++++++++++++++++++
>  2 files changed, 39 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/ti,da850-ahci.y=
aml
>=20
> diff --git a/Documentation/devicetree/bindings/ata/ahci-da850.txt b/Docum=
entation/devicetree/bindings/ata/ahci-da850.txt
> deleted file mode 100644
> index 5f8193417725..000000000000
> --- a/Documentation/devicetree/bindings/ata/ahci-da850.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -Device tree binding for the TI DA850 AHCI SATA Controller
> ----------------------------------------------------------
> -
> -Required properties:
> -  - compatible: must be "ti,da850-ahci"
> -  - reg: physical base addresses and sizes of the two register regions
> -         used by the controller: the register map as defined by the
> -         AHCI 1.1 standard and the Power Down Control Register (PWRDN)
> -         for enabling/disabling the SATA clock receiver
> -  - interrupts: interrupt specifier (refer to the interrupt binding)
> -
> -Example:
> -
> -	sata: sata@218000 {
> -		compatible =3D "ti,da850-ahci";
> -		reg =3D <0x218000 0x2000>, <0x22c018 0x4>;
> -		interrupts =3D <67>;
> -	};
> diff --git a/Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml b/D=
ocumentation/devicetree/bindings/ata/ti,da850-ahci.yaml
> new file mode 100644
> index 000000000000..ce13c76bdffb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/ti,da850-ahci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI DA850 AHCI SATA Controller
> +
> +maintainers:
> +  - Animesh Agarwal <animeshagarwal28@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: ti,da850-ahci
> +
> +  reg:
> +    items:
> +      - description: Address and size of the register map as defined by =
the AHCI 1.1 standard.
> +      - description:
> +          Address and size of Power Down Control Register (PWRDN) for en=
abling/disabling the SATA clock
> +          receiver.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sata@218000 {
> +        compatible =3D "ti,da850-ahci";
> +        reg =3D <0x218000 0x2000>, <0x22c018 0x4>;
> +        interrupts =3D <67>;
> +    };
> --=20
> 2.44.0
>=20

--VU9LhsKx0E9NZ6tS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgRNQwAKCRB4tDGHoIJi
0jkWAQCSSLpUzexLRjqLIKY2mVH4S1mYreX+yuIXE/k7/qbSdAD6Aw0jdUN0qVr+
7PdP3mgYcHF9msvjCUyaFVIC2MedoAQ=
=rjer
-----END PGP SIGNATURE-----

--VU9LhsKx0E9NZ6tS--

