Return-Path: <linux-kernel+bounces-95997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F90F8755D2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A09C284EA1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5967F131E2F;
	Thu,  7 Mar 2024 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rtgi5Y/T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE6E161;
	Thu,  7 Mar 2024 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834999; cv=none; b=dNZzekNWEoSl8bMnRpV3RlNbD4bu9919lvVU6g+GeMRZItwVQssmbnDg4tsx285Lzkhb6v+i7ykOA8Wt3q8VAqlb/ppAZcsWjI6pj5xWCWZo9hVOsvcTwa86Q7MC+VtGoWpp4qciI+oazo6zpdS58rMS4qAqEM/ffEG2t0nm0wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834999; c=relaxed/simple;
	bh=kbVZqvLa1aqlyB3vVu8jRk+f0oMHO8cw/P5eYurNs08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYOAkS05o3IUCrtmNfhbS9tFjRnpa4NJQNym1BkRaJ8K3tKqcAPJO5E4hOhGRFpx9P+WtZte6p6MoN8n551kuPl/0xuscZq/pty6QDpKyV08m/9jgTe+f8z7DiA3l4QykJyuOBlMUg8Aa473fuI7HBLIEgU+kSux58s+HgkAQpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rtgi5Y/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D219C433F1;
	Thu,  7 Mar 2024 18:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709834999;
	bh=kbVZqvLa1aqlyB3vVu8jRk+f0oMHO8cw/P5eYurNs08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rtgi5Y/TTHBALriEjOpaxqLTfiGFJpriaiBh9q6KG7N4sl2eDnKIQYwp/KIusV4kh
	 OxNUpzMTKwVvou90Kd5Ub5QfJkRl/6HNtzX+lSUHLbdDa2/zhy/2WPjHyp6vbNieNS
	 ds0ZrHO+9x5Xl9hsTOowG1N5UUNQgIBTQ2D3RpwqtKTcJx0HX0wEewnI1djUeVKkK9
	 CgxOb58kMyJgEtip4eE0SsfxHxLn48sa/jS+kxnVOhyc1NF4KhllClXOm9UKHY55mS
	 OZpPfvxo6u7hmPYhe1EbRicjRmHN2FgytTqUSoHtlcT+DqU8e+I7o+6+/hM0avoyGp
	 E+qftcapZ5mfA==
Date: Thu, 7 Mar 2024 18:09:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2] dt-bindings: serial: renesas,scif: Document R9A09G057
 support
Message-ID: <20240307-unaired-pawing-7e5183a89c97@spud>
References: <20240307114731.34953-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kqshKBrZL8ASvBWS"
Content-Disposition: inline
In-Reply-To: <20240307114731.34953-1-prabhakar.mahadev-lad.rj@bp.renesas.com>


--kqshKBrZL8ASvBWS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 11:47:31AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Document support for the Serial Communication Interface with FIFO (SCIF)
> available in the Renesas RZ/V2H(P) (R9A09G057) SoC. The SCIF interface in
> the Renesas RZ/V2H(P) is similar to that available in the RZ/G2L
> (R9A07G044) SoC, with the only difference being that the RZ/V2H(P) SoC has
> three additional interrupts: one for Tx end/Rx ready and the other two for
> Rx and Tx buffer full, which are edge-triggered.
>=20
> No driver changes are required as generic compatible string
> "renesas,scif-r9a07g044" will be used as a fallback on RZ/V2H(P) SoC.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
> v1->v2
> * Added validation to check interrupts and interrupt-names count
>=20
> Note, this patch applies on top of series [0].
>=20
> [0] https://patchwork.ozlabs.org/project/devicetree-bindings/cover/202403=
07114217.34784-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  .../bindings/serial/renesas,scif.yaml         | 31 ++++++++++++++++---
>  1 file changed, 27 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b=
/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> index 6ba6b6d52208..a9c60334d702 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> @@ -77,6 +77,7 @@ properties:
>                - renesas,scif-r9a07g043      # RZ/G2UL and RZ/Five
>                - renesas,scif-r9a07g054      # RZ/V2L
>                - renesas,scif-r9a08g045      # RZ/G3S
> +              - renesas,scif-r9a09g057      # RZ/V2H(P)
>            - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
> =20
>    reg:
> @@ -91,6 +92,9 @@ properties:
>        - description: Break interrupt
>        - description: Data Ready interrupt
>        - description: Transmit End interrupt
> +      - description: Transmit End/Data Ready interrupt
> +      - description: Receive buffer full interrupt (EDGE trigger)
> +      - description: Transmit buffer empty interrupt (EDGE trigger)
> =20
>    interrupt-names:
>      minItems: 4
> @@ -101,6 +105,9 @@ properties:
>        - const: bri
>        - const: dri
>        - const: tei
> +      - const: teidri
> +      - const: rxi-edge
> +      - const: txi-edge
> =20
>    clocks:
>      minItems: 1
> @@ -197,15 +204,31 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - renesas,scif-r7s9210
> -              - renesas,scif-r9a07g044
> +              - renesas,scif-r9a09g057
>      then:
>        properties:
>          interrupts:
> -          minItems: 6
> +          minItems: 9
> =20
>          interrupt-names:
> -          minItems: 6
> +          minItems: 9
> +    else:
> +      if:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - renesas,scif-r7s9210
> +                - renesas,scif-r9a07g044
> +      then:
> +        properties:
> +          interrupts:
> +            minItems: 6
> +            maxItems: 6
> +
> +          interrupt-names:
> +            minItems: 6
> +            maxItems: 6
> =20
>  unevaluatedProperties: false
> =20
> --=20
> 2.34.1
>=20

--kqshKBrZL8ASvBWS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeoC8QAKCRB4tDGHoIJi
0r/5APwKFTZsYs6kP59xEaj+Cj1JP9q4vyRIEmkRiuEDlPR3gQD/eC44HjW8j8Yp
Cbx1d+0Ow5bozd4yQTk1H9WgMNJo8QY=
=2N9o
-----END PGP SIGNATURE-----

--kqshKBrZL8ASvBWS--

