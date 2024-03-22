Return-Path: <linux-kernel+bounces-111961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFDA88734C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91C91F22821
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8446F6A322;
	Fri, 22 Mar 2024 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuUzcYXr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA30969968;
	Fri, 22 Mar 2024 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132837; cv=none; b=gjBgnHrYnLsnh1aRNLiVdJnV+E7Na2CCMOmN/zRFJtZtwzk8fRuPk40EWxwoWyIJpl6E8ggaLd9u6WAEMxbLmWKIc5gSshu9s8vtwhgF110vcoDUZHDT0sTQueQX4O3fo/Wq0eRkm1/e2Am8FRjl7Gr1KDWzp95T86FHmIcDwY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132837; c=relaxed/simple;
	bh=PFmCpdYFBoNDNkiBxaeOECRQbyzGzlmbL4fNvFp854g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEehZFU3+ixZyMCPVPpYkIu/3BiZ71g96DbRiEBMFkCG59aOm5uxsIpleEyjYIVZ4W9BdH3sE9k68A05bKOPs/TsGEZ2omDB20hEfuRfeLTMOPoZy0wuKGemu7HEylidFfptVBBsOmt5QtWHkY7SF9g37Lio4f3Z45wxPYsWsxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuUzcYXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90C3C433F1;
	Fri, 22 Mar 2024 18:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711132837;
	bh=PFmCpdYFBoNDNkiBxaeOECRQbyzGzlmbL4fNvFp854g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iuUzcYXrUKvj8rbH8FgkaDYdGdrObKn7CuRA1a722sjorqjH1IEA5Oz/fpFCyFVh+
	 jP+Rd5+Kzz47fSZf/jplghUbZSeGy2ZTSmmsZAddoebxj72E4mxmG+WoD5woHtu7lU
	 n/A3bHDuLY2rVrFY/pJ6J5RWrnMGJG3R712kKW5okTImGVgMqrDJcyU+SUpj6lWHSj
	 2hYEvdewpJNz9dMBRGDewayuXg+UxaoDryBDqWknN2yMe0O1uv8+lrJF3XgE7wr/4m
	 zHg0WVemO7Q6ZMNqMeitQylvLo7IdzTZtfFLE8dIX30JPHD4AsbE9QGwVrjuuBqjEi
	 D0U1KMhd+skbw==
Date: Fri, 22 Mar 2024 18:40:31 +0000
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
Subject: Re: [PATCH v4 3/5] dt-bindings: serial: renesas,scif: Make
 'interrupt-names' property as required
Message-ID: <20240322-sloppy-comprised-0a1756edadaf@spud>
References: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240322144355.878930-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LEyUA15BYtZCV1OP"
Content-Disposition: inline
In-Reply-To: <20240322144355.878930-4-prabhakar.mahadev-lad.rj@bp.renesas.com>


--LEyUA15BYtZCV1OP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 02:43:53PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> As all the SoCs having multiple interrupts have 'interrupt-names' property
> in their respective DTSIs, make 'interrupt-names' property as required
> so that we can validate them using dtbs_check.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Provided drivers will still work with the old devicetrees that
didn't have names for everything:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
> v3->v4
> - New patch
>=20
> Note, we need patch [0] to be applied or else we might see
> dtbs_check warning.
>=20
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20240318=
174345.46824-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  Documentation/devicetree/bindings/serial/renesas,scif.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b=
/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> index eb2aa5e75e02..c13b31c28049 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> @@ -179,6 +179,9 @@ allOf:
>            maxItems: 1
> =20
>          interrupt-names: false
> +    else:
> +      required:
> +        - interrupt-names
> =20
>    - if:
>        properties:
> --=20
> 2.34.1
>=20

--LEyUA15BYtZCV1OP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZf3QnwAKCRB4tDGHoIJi
0q4eAP93cdPRuoVhWb9Gw0y7IQi2of7MZ1oPHOLyOxGP5pM+GAD/bpEQZq9o7TtT
UvDYat4MRp6BmDsN2duBDrgFLOT+JAc=
=B2Xz
-----END PGP SIGNATURE-----

--LEyUA15BYtZCV1OP--

