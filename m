Return-Path: <linux-kernel+bounces-105424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6718287DDB0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961361C20A23
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FB41C6AE;
	Sun, 17 Mar 2024 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWpzGW0q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5541C69A;
	Sun, 17 Mar 2024 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710687519; cv=none; b=Dp9SZp67KDvstooFCRYWS+ADWWOKDClFi6PsJ4cJ8BNn1MPX5OFa+w6wHeWjqa1yMa5jXl6ixdwHz4jffvVz/OfmJJh2vz4NWzXz15LteWWj+ofL/hAvIeagwrZwSFCH3TzGH5laMAR83/Isocjd7N59f8b/bjybm+/MMJTUPN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710687519; c=relaxed/simple;
	bh=4hYK4NSlZ7J/yp23ZsRuOVuH209yZtPKW8QX6ctpQxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toqra8ASpWfAkeJEEIDcdZvCSggIugR+J6JTC1ULk4TiYO6bjJjV4YE/5FA04swUzAe171ubdieEo3jSnFvuUji09E2nDilAYhGSaB/RMNcDp8ADPqoELO5jfrI1DkbVyKT4+UPXqtWgKlCy7Zws+LMxoVrMBesTJGvg9slB7/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWpzGW0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153AEC433C7;
	Sun, 17 Mar 2024 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710687519;
	bh=4hYK4NSlZ7J/yp23ZsRuOVuH209yZtPKW8QX6ctpQxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nWpzGW0qxekZ3lAxNLpO/SIgfvn5xmjyPr185A7bawaZCsKJAqLQf9d7sjp1cEK1F
	 +2rzc8lY9gAUi5bL9YW87gk0Ydz/UabfDGPLZVQZbkJe1y+OVziUVx26zRRg4OTGL9
	 IqTTTYmIMKqoS8dYkmjRODl1sTglw5SMUCLCrGw1IqNDozkuWCAZH11JGHYZSKzbOk
	 P/O1Phy8y/yWEuoX0kAhauro/Qk7u2zwFTg9IPDwGa+Vrs7A6Prn3hL2Ulh3oNRk7X
	 likDZxaO0xJVLA8XoPPKJLr4i7YBZsLdRVi7n7CUxnLjoEmcfuNtQTnOsJRSkIpH2Z
	 zZkART3XN/36A==
Date: Sun, 17 Mar 2024 14:58:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Joshua Yeong <joshua.yeong@starfivetech.com>, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com, conor.dooley@microchip.com,
	alexghiti@rivosinc.com, evan@rivosinc.com, ajones@ventanamicro.com,
	heiko@sntech.de, guoren@kernel.org, uwu@icenowy.me,
	jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, leyfoon.tan@starfivetech.com,
	jeeheng.sia@starfivetech.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: cache: Add docs for StarFive
 StarLink-500 cache controller
Message-ID: <20240317-snide-pounce-4a82ee1704ad@spud>
References: <20240314061205.26143-1-joshua.yeong@starfivetech.com>
 <20240314061205.26143-5-joshua.yeong@starfivetech.com>
 <20240315163607.GA1444248-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JkNPYk6d8cks6SMP"
Content-Disposition: inline
In-Reply-To: <20240315163607.GA1444248-robh@kernel.org>


--JkNPYk6d8cks6SMP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 10:36:07AM -0600, Rob Herring wrote:
> On Thu, Mar 14, 2024 at 02:12:05PM +0800, Joshua Yeong wrote:
> > Add DT binding documentation used by StarFive's
> > Starlink-500 cache controller.
> >=20
> > Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> > ---
> >  .../cache/starfive,starlink-500-cache.yaml    | 62 +++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cache/starfive,st=
arlink-500-cache.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/cache/starfive,starlink-=
500-cache.yaml b/Documentation/devicetree/bindings/cache/starfive,starlink-=
500-cache.yaml
> > new file mode 100644
> > index 000000000000..97ddf7db39e9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cache/starfive,starlink-500-cac=
he.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/cache/starfive,starlink-500-cache.y=
aml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: StarFive StarLink-500 Cache Controller
> > +
> > +maintainers:
> > +  - Joshua Yeong <joshua.yeong@starfivetech.com>
> > +
> > +description:
> > +  StarFive's StarLink-500 controller manages cache shared between clus=
ters of
> > +  CPU cores. The cache driver provides mechanism to perform invalidate=
 and write
> > +  back functionality to the shared memory.
>=20
> What a driver does is not relevant to the binding. You could describe=20
> what the registers control though.
>=20
> > +
> > +allOf:
> > +  - $ref: /schemas/cache-controller.yaml#
> > +
> > +# We need a select here so we don't match all nodes with 'cache'
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - starfive,starlink-500-cache
> > +
> > +  required:
> > +    - compatible
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: starfive,starlink-500-cache
> > +      - const: cache

You're also missing a soc-specific compatible here as far as I can tell,
as one of the other patches in this series specifically calls out the
JH8100 as where this cache controller is. AFAICT, "starlink-500" is the
name of the IP or of the coreplex - it's not the name of the SoC.

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  cache-size: true
> > +  cache-sets: true
> > +  cache-block-size: true
> > +  cache-level: true
> > +  cache-unified: true
>=20
> Drop these and...
>=20
> > +
> > +additionalProperties: false
>=20
> ... use 'unevaluatedProperties' instead.
>=20
> > +
> > +required:
> > +  - compatible
> > +  - reg
>=20
> cache-unified should be required as I imagine the cache is always=20
> unified. Perhaps other properties too (cache-level already is)?

And I also suspect that a load of the values can be restricted to
specific values for that jh8100 compatible.

>=20
> > +
> > +examples:
> > +  - |
> > +      cache-controller@15000000 {
> > +        compatible =3D "starfive,starlink-500-cache", "cache";
> > +        reg =3D <0x15000000 0x278>;
> > +        cache-block-size =3D <64>;
> > +        cache-level =3D <3>;
> > +        cache-sets =3D <8192>;
> > +        cache-size =3D <0x400000>;
> > +        cache-unified;
> > +      };
> > --=20
> > 2.25.1
> >=20

--JkNPYk6d8cks6SMP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfcFGAAKCRB4tDGHoIJi
0pWNAQCbqLMU21tC41TsMzHu7Npk2WPeIA2cuSEU4dz0i7iOpQEAm+9ZG7QgRTsq
WKL2v/DB2ZR5kbqHYAQjQk3cx8aStAY=
=zEPf
-----END PGP SIGNATURE-----

--JkNPYk6d8cks6SMP--

