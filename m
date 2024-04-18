Return-Path: <linux-kernel+bounces-150475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3848A9FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9994C1F2364E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EC016F910;
	Thu, 18 Apr 2024 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m93AmLSY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DFA16C84E;
	Thu, 18 Apr 2024 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457356; cv=none; b=eaR9Cm1pjV+Mx1nBPvN3cZlLCsyAuaNFJgAoLPD9fdjNpXoc+MrbGPM/tTDgsB25hYuaMuVc8CUzwpPEEDt8WGbUnYMWXvdOf/WTknmxu1JaH/bd4mVACIGMvA0xHBwI/Nge3sKUrH8v4dkUUeh/VPbSgdq/f+mYYA41xFv27a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457356; c=relaxed/simple;
	bh=0muzFtQnoAJk9Z6yIVnXcMgpV+DflGYKCtNkM7BrMrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmdwi+aXVyP9qf1uLSiWCHh3i7M7F3ud0ntjb9OhOj80TCRtaR1dlU964R2SshRtKf0uJZQRYy5iHhpFNWpVXvAJ05a1tvxa8ATdwr8CI6om6DFTu+xNAaCm3PRS8sxcQZOau2uYVP2T1KQAvjWrb3qgcEzMW5dabe2dqSZ9zsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m93AmLSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435D7C113CC;
	Thu, 18 Apr 2024 16:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713457356;
	bh=0muzFtQnoAJk9Z6yIVnXcMgpV+DflGYKCtNkM7BrMrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m93AmLSYGsMb8Wqn4pzerinvUG0K7bnwiamRYA9HjA3hB/dO6CBDaJt+fLrvfDUXx
	 vVB0VPHE6GpvR62IiUm9pw6nxqagyGTSne9D3G8wdQKlwrMyMNklYHRmB7G8jbkYTC
	 Vonm4HTHQhzmzFfhIpBouHfxoZh2gn5m/OXV9JhrSV2qQ1TR+nlp0CPOz92MSyYE0x
	 3I3C2HSGhLaUlyS1qYd6IHWw393/f35W0v/9w9R4/7rSJ1qpsXeJm2y2rWJwENOgNp
	 1Pdgg4Qj7ESbSRJy4aRVW7ZYshgzV+nwqQSegfBLZckDv2PSFo34xHrp3wOOL4daUc
	 4xSyeaCDmKXfg==
Date: Thu, 18 Apr 2024 17:22:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Witold Sadowski <wsadowski@marvell.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, broonie@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	pthombar@cadence.com
Subject: Re: [PATCH v3 2/5] spi: cadence: Add MRVL overlay bindings
 documentation for Cadence XSPI
Message-ID: <20240418-sacrament-cornea-fd6fd569827e@spud>
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240418011353.1764672-1-wsadowski@marvell.com>
 <20240418011353.1764672-3-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XVyK3SXt+IAvH6vB"
Content-Disposition: inline
In-Reply-To: <20240418011353.1764672-3-wsadowski@marvell.com>


--XVyK3SXt+IAvH6vB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 06:13:49PM -0700, Witold Sadowski wrote:
> Add new bindings for v2 Marvell xSPI overlay:
> mrvl,xspi-nor  compatible string
> New compatible string to distinguish between orginal and modified xSPI
> block
>=20
> PHY configuration registers
> Allow to change orginal xSPI PHY configuration values. If not set, and
> Marvell overlay is enabled, safe defaults will be written into xSPI PHY
>=20
> Optional base for xfer register set
> Additional reg field to allocate xSPI Marvell overlay XFER block
>=20
> Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
> ---
>  .../devicetree/bindings/spi/cdns,xspi.yaml    | 92 ++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Docum=
entation/devicetree/bindings/spi/cdns,xspi.yaml
> index eb0f92468185..0e608245b136 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> @@ -20,23 +20,82 @@ allOf:
> =20
>  properties:
>    compatible:
> -    const: cdns,xspi-nor
> +    oneOf:
> +      - description: Vanilla Cadence xSPI controller
> +        items:
> +          - const: cdns,xspi-nor

The "items: isn't required here is it? Can't you just have
    oneOf:
      - description: Vanilla Cadence xSPI controller
        const: cdns,xspi-nor
      - description: Cadence xSPI controller with v2 Marvell overlay
        const: mrvl,xspi-nor
if you don't want to use an enum?

> +      - description: Cadence xSPI controller with v2 Marvell overlay
> +        items:
> +          - const: mrvl,xspi-nor


"mrvl" is deprecated, please use "marvell". You're also missing a
soc-specific compatible here, I doubt there's only going to be one
device from marvell with an xspi controller ever.

>    reg:
> +    minItems: 3
>      items:
>        - description: address and length of the controller register set
>        - description: address and length of the Slave DMA data port
>        - description: address and length of the auxiliary registers
> +      - description: address and length of the xfer registers
> =20
>    reg-names:
> +    minItems: 3
>      items:
>        - const: io
>        - const: sdma
>        - const: aux
> +      - const: xferbase

Please constrain the 4th reg to only the marvell device.

> =20
>    interrupts:
>      maxItems: 1
> =20
> +  cdns,dll-phy-control:
> +    description: |
> +      PHY config register. Valid only for cdns,mrvl-xspi-nor

Under what circumstances do you expect these things to change for a
particular SoC? If it's fixed per SoC, you could deduce it from the
compatible rather than needing properties.

None of these properties explain what they do and all appear to just
set register values directly, which is not generally something that we
permit in DT. Some explanation of how these values vary would help a
lot...

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x707
> +
> +  cdns,rfile-phy-control:
> +    description: |
> +      PHY config register. Valid only for cdns,mrvl-xspi-nor

Please enforce constraints like which compatibles something is valid for
in the binding, not in free-form text.


> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x40000
> +
> +  cdns,rfile-phy-tsel:
> +    description: |
> +      PHY config register. Valid only for cdns,mrvl-xspi-nor
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +
> +  cdns,phy-dq-timing:
> +    description: |
> +      PHY config register. Valid only for cdns,mrvl-xspi-nor
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x101
> +
> +  cdns,phy-dqs-timing:
> +    description: |
> +      PHY config register. Valid only for cdns,mrvl-xspi-nor
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x700404
> +
> +  cdns,phy-gate-lpbk-ctrl:
> +    description: |
> +      PHY config register. Valid only for cdns,mrvl-xspi-nor
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x200030
> +
> +  cdns,phy-dll-master-ctrl:
> +    description: |
> +      PHY config register. Valid only for cdns,mrvl-xspi-nor
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x00800000
> +
> +  cdns,phy-dll-slave-ctrl:
> +    description: |
> +      PHY config register. Valid only for cdns,mrvl-xspi-nor
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x0000ff01
> +
>  required:
>    - compatible
>    - reg
> @@ -68,6 +127,37 @@ examples:
>                  reg =3D <0>;
>              };
> =20
> +            flash@1 {
> +                compatible =3D "jedec,spi-nor";
> +                spi-max-frequency =3D <75000000>;
> +                reg =3D <1>;
> +            };
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    bus {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        mrvl_xspi: spi@d0010000 {

Drop the node label here, nothing ever refers to it.

Thanks,
Conor.

> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +            compatible =3D "mrvl,xspi-nor";
> +            reg =3D <0x0 0xa0010000 0x0 0x1040>,
> +                  <0x0 0xb0000000 0x0 0x1000>,
> +                  <0x0 0xa0020000 0x0 0x100>,
> +                  <0x0 0xa0090000 0x0 0x100>;
> +            reg-names =3D "io", "sdma", "aux", "xferbase";
> +            interrupts =3D <0 90 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-parent =3D <&gic>;
> +
> +            flash@0 {
> +                compatible =3D "jedec,spi-nor";
> +                spi-max-frequency =3D <75000000>;
> +                reg =3D <0>;
> +            };
> +
>              flash@1 {
>                  compatible =3D "jedec,spi-nor";
>                  spi-max-frequency =3D <75000000>;
> --=20
> 2.43.0
>=20

--XVyK3SXt+IAvH6vB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiFIyAAKCRB4tDGHoIJi
0tJZAP4+Wo5Ap1V/w9os6wdB/DaZ3Qtff4EYs8adyJqfhklIpQD9EGfnabm85A2b
zcojEhWfDFR7Xe/s1lgplPYlu6WopgU=
=UzLI
-----END PGP SIGNATURE-----

--XVyK3SXt+IAvH6vB--

