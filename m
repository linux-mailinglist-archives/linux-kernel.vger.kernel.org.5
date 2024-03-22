Return-Path: <linux-kernel+bounces-111962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF53887350
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B752887EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47326A8B2;
	Fri, 22 Mar 2024 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5Lyk2Yf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255895FDC9;
	Fri, 22 Mar 2024 18:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132919; cv=none; b=ItNRL1mOhwKYuEwJn01UxR9tUtECG/nksPq0E4hjhiyrgN8+3k+jWSIWZkbFRXTr+zvAZZWwry6IJIGbawNVPUAElYVTm83MF7B5YcmXoc2AK2zECqsKneDuKiaVCrFJomLrtsXVYquREbw762Lwgleh1p585PKqIVA7t21CU1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132919; c=relaxed/simple;
	bh=F11k4iI02tzCqpoumpy2ptLTRb5nTvwahbpqwzebvKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ran5rZ3i0LV1/MAm6j3JTwmYymznbdPpofdRWGUYhtcp2nXMuSg/fKLpgZ3JohiUd46ahtbVg6DgwrsTLzGbtT2qsvJwQatYJywtcoQPAuu95LUc+gxOV8/DSsXu51OVat8TwVH6DDiIIlx6LonBlDyAq7+xyabL61b7TEODOok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5Lyk2Yf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A0CC433C7;
	Fri, 22 Mar 2024 18:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711132918;
	bh=F11k4iI02tzCqpoumpy2ptLTRb5nTvwahbpqwzebvKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j5Lyk2YftVMKaJ9QA+oLv/BWSAsGEYXT/O9U4taywknWePLo6uZDQrL9JZFfaSKAl
	 St2bIrbsE2P75d5lEvYCbAMsUd83jvz8Ik4D5YG3gyIDVWV7Emg37kuj66NxkAJUdO
	 4VmTUaHFu2M8uIjc+GpRoqPjrRi83HfotABCghV4jB0UOoAI2EjUX2ZuR0ztatKBD1
	 jHdB+8oh3zCTjQI1nWlWjXi4GcEEs330XBMKVW6+IYnJKEeRdtYmlYKcDtZc8gAcj0
	 PvNUx+kPXQ0c0ZGJOxzOUHa6Bmrjy+wDte0n7McFiCOsTytCPtc1jF5zRdHbrO9ToQ
	 brsM9GWBU5FEw==
Date: Fri, 22 Mar 2024 18:41:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: serial: Add documentation for
 Renesas RZ/V2H(P) (R9A09G057) SCIF support
Message-ID: <20240322-donor-undying-d941fc3db445@spud>
References: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240322144355.878930-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kbZNjUf7uTigHDC3"
Content-Disposition: inline
In-Reply-To: <20240322144355.878930-5-prabhakar.mahadev-lad.rj@bp.renesas.com>


--kbZNjUf7uTigHDC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 02:43:54PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Document support for the Serial Communication Interface with FIFO (SCIF)
> available in the Renesas RZ/V2H(P) (R9A09G057) SoC. The SCIF interface in
> the Renesas RZ/V2H(P) is similar to that available in the RZ/G2L
> (R9A07G044) SoC, with the following differences:
>=20
> - RZ/V2H(P) SoC has three additional interrupts: one for Tx end/Rx ready
>   and two for Rx and Tx buffer full, all of which are edge-triggered.
> - RZ/V2H(P) supports asynchronous mode, whereas RZ/G2L supports both
>   synchronous and asynchronous modes.
> - There are differences in the configuration of certain registers such
>   as SCSMR, SCFCR, and SCSPTR between the two SoCs.
>=20
> To handle these differences in the driver, a new SoC-specific compatible
> string is added, ensuring proper handling of the unique features and
> register configurations of the RZ/V2H(P) SoC.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
> v3->v4
> - Appended the interrupts instead of adding SoC specific
> - Added restriction for clocks and reset
>=20
> v2->v3
> - Added SoC specific compat string
> ---
>  .../bindings/serial/renesas,scif.yaml         | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b=
/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> index c13b31c28049..93fc7b75e2e5 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> @@ -79,6 +79,8 @@ properties:
>                - renesas,scif-r9a08g045      # RZ/G3S
>            - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
> =20
> +      - const: renesas,scif-r9a09g057       # RZ/V2H(P)
> +
>    reg:
>      maxItems: 1
> =20
> @@ -93,6 +95,9 @@ properties:
>            - description: Break interrupt
>            - description: Data Ready interrupt
>            - description: Transmit End interrupt
> +          - description: Transmit End/Data Ready interrupt
> +          - description: Receive buffer full interrupt (EDGE trigger)
> +          - description: Transmit buffer empty interrupt (EDGE trigger)
>          minItems: 4
> =20
>    interrupt-names:
> @@ -104,6 +109,9 @@ properties:
>        - const: bri
>        - const: dri
>        - const: tei
> +      - const: tei-dri
> +      - const: rxi-edge
> +      - const: txi-edge
> =20
>    clocks:
>      minItems: 1
> @@ -160,6 +168,7 @@ allOf:
>                - renesas,rcar-gen3-scif
>                - renesas,rcar-gen4-scif
>                - renesas,scif-r9a07g044
> +              - renesas,scif-r9a09g057
>      then:
>        required:
>          - resets
> @@ -209,9 +218,30 @@ allOf:
>        properties:
>          interrupts:
>            minItems: 6
> +          maxItems: 6
> =20
>          interrupt-names:
>            minItems: 6
> +          maxItems: 6
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,scif-r9a09g057
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +
> +        clock-names:
> +          maxItems: 1
> +
> +        interrupts:
> +          minItems: 9
> +
> +        interrupt-names:
> +          minItems: 9
> =20
>  unevaluatedProperties: false
> =20
> --=20
> 2.34.1
>=20

--kbZNjUf7uTigHDC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZf3Q8AAKCRB4tDGHoIJi
0rSuAQDQBPGUs8icPLxwGsWSeXy4khapO+KonhR3hhzZarFPagEA+J5rYERXAPIm
ZqcsXcmdvvFPcibF6kTToxC6lUyChgs=
=JU55
-----END PGP SIGNATURE-----

--kbZNjUf7uTigHDC3--

