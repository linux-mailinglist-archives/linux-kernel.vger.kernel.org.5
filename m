Return-Path: <linux-kernel+bounces-62201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5BF851CF1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27EF828391A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8A940C1F;
	Mon, 12 Feb 2024 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMUyCia9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04900405D4;
	Mon, 12 Feb 2024 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763105; cv=none; b=kvSiE2YzgjkwZkN1gFyU7fyC2kkLGrf5P9LU0KH2QiTsu0Kw+HoaqcZ2w8lJyyYOBiRJFyfErEXkXbLattIuaWUKQ3R1mCW73i5WP47yIyUYb9nV8aac1tHLqt18+CVEK3H++OucmFYoCX1awyHjtGGx/4bFD1dOAMu0BokFz/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763105; c=relaxed/simple;
	bh=DB+QxJu9d3ZS9rmjqca4J9xEJVvpvRrU2w7NHJpSp2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOy63eNQZht85Gm/xqP11fyK8VUleonPbV799w/2xFKGVCWFpue048PM7IeEhGvqcErtLtHeDC/qpjIY0iYmPs6W2xe7cfTk1RnTjxfWHE0eRYzPJFzCPiSXcX0eDqeQkRcHG/AhVRyF5Lz4QYodLmtpuT6bl4UEcSeY+PdBO/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMUyCia9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B78EC433C7;
	Mon, 12 Feb 2024 18:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707763104;
	bh=DB+QxJu9d3ZS9rmjqca4J9xEJVvpvRrU2w7NHJpSp2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EMUyCia9MG/ccuDFUpmDHiaLgC+igJvueSb2uGUiW+TWBq+vBFJgv8cUhmQuvL+pz
	 5iUT2b3vi+tdzkMXYYrc1B47l5j0QmWiB9PXCy926EZDb90ffrj4N8HGa+6ELm+baa
	 d1O2E1uY04FIGeZwOqJkdmUtPJLY5anr/dqnPnvxGLeRiKmLD0fwaP48UDg+6JQpGI
	 kmvpJ2wegkC+GvoCO932G8UHkEkGm1sJGgCoev1AUcQOsunK5XzdWaUaXPYSOGUYqp
	 p9S5u9N0bEQx6QB8D9+o/mABVRhhIOFXR2yemqFi5EEwnKE1jChO2G6vNh5tKdRLgQ
	 16/DAqRwQIcPg==
Date: Mon, 12 Feb 2024 18:38:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Christophe Kerello <christophe.kerello@foss.st.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 08/12] dt-bindings: mtd: st,stm32: add MP25 support
Message-ID: <20240212-squeak-mortality-5a53a4d1039c@spud>
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
 <20240212174822.77734-9-christophe.kerello@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5x9qetWChxMtvEey"
Content-Disposition: inline
In-Reply-To: <20240212174822.77734-9-christophe.kerello@foss.st.com>


--5x9qetWChxMtvEey
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 06:48:18PM +0100, Christophe Kerello wrote:
> Add 2 new compatible strings to support MP25 SOC.
> MP25 SOC supports up to 4 chip select.

Again, please explain why the new device is not compatible with the
existing ones. Also, please explain why two compatibles are required for
the mp25.

Thanks,
Conor.

>=20
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> ---
>  .../bindings/mtd/st,stm32-fmc2-nand.yaml      | 58 ++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yam=
l b/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
> index e72cb5bacaf0..33a753c8877b 100644
> --- a/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
> @@ -14,10 +14,12 @@ properties:
>      enum:
>        - st,stm32mp15-fmc2
>        - st,stm32mp1-fmc2-nfc
> +      - st,stm32mp25-fmc2
> +      - st,stm32mp25-fmc2-nfc
> =20
>    reg:
>      minItems: 6
> -    maxItems: 7
> +    maxItems: 13
> =20
>    interrupts:
>      maxItems: 1
> @@ -92,6 +94,60 @@ allOf:
>              - description: Chip select 1 command
>              - description: Chip select 1 address space
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: st,stm32mp25-fmc2
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: Registers
> +            - description: Chip select 0 data
> +            - description: Chip select 0 command
> +            - description: Chip select 0 address space
> +            - description: Chip select 1 data
> +            - description: Chip select 1 command
> +            - description: Chip select 1 address space
> +            - description: Chip select 2 data
> +            - description: Chip select 2 command
> +            - description: Chip select 2 address space
> +            - description: Chip select 3 data
> +            - description: Chip select 3 command
> +            - description: Chip select 3 address space
> +
> +        clocks:
> +          maxItems: 1
> +
> +        resets:
> +          maxItems: 1
> +
> +      required:
> +        - clocks
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: st,stm32mp25-fmc2-nfc
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: Chip select 0 data
> +            - description: Chip select 0 command
> +            - description: Chip select 0 address space
> +            - description: Chip select 1 data
> +            - description: Chip select 1 command
> +            - description: Chip select 1 address space
> +            - description: Chip select 2 data
> +            - description: Chip select 2 command
> +            - description: Chip select 2 address space
> +            - description: Chip select 3 data
> +            - description: Chip select 3 command
> +            - description: Chip select 3 address space
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.25.1
>=20

--5x9qetWChxMtvEey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcplmwAKCRB4tDGHoIJi
0qEaAQC6FzMEWUZon7Rbw9b51wIt52mF6FLV+DfSgClzOalRFAEAiDB3FOanV76n
XJT9NErVw/coKCkhHjtRx02Cv9xOtQI=
=9ijQ
-----END PGP SIGNATURE-----

--5x9qetWChxMtvEey--

