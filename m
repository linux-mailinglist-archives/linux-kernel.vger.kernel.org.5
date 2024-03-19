Return-Path: <linux-kernel+bounces-108032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C598188050A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793EE1F23D32
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936DC39ACD;
	Tue, 19 Mar 2024 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZU1APWiM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC27B39FD0;
	Tue, 19 Mar 2024 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873856; cv=none; b=aXmsukfo1+uQTIfgKRX4ufiZ4Afb8tGerWF5YEns2H78J5KntuunPRG0qdWVTUT2EikaMfjSliv9Ab8yBSABgUGZuNqNYzTDfwZqOBafX9cjOO2CXK+avrJ92m7r8d3RyM8J8cduScBjTFEksgXTKlEVCWFls4co6Y5paBjVxXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873856; c=relaxed/simple;
	bh=MEj2TCe+Afr28v9FiAw9foAssyihq3NwMW0eBohpgmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JF5AW08BfBEE9fgKMMODoRqfyped1U9AuCix5yH4V69LxiGGWqGNuXQ1oowmLhzNyHCmeI73nQReQPiZAl3Cc5Spoc0FeDMiGYGBjP0gTLTESnm/fsrNrq3AwCQCsIPW2OX8sqZnf26zuIJpmfwhZmdaK+vv+KkizLaencEmqG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZU1APWiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EA1C43394;
	Tue, 19 Mar 2024 18:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710873856;
	bh=MEj2TCe+Afr28v9FiAw9foAssyihq3NwMW0eBohpgmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZU1APWiMn2+qdE2fLrffWhU7vzv/tMI/0KC58QCvghdcc/JXOxa/yaLnu5dvOx9mH
	 JlQaj1bCHOIjGXzS8Z/a6VZAbXhFr8m6umPsCgQnJWw3SptEf/kLMG7nZKyusiAFQK
	 AtdCgwSep/LpUdJ6gc78qR8CS2tsI8Vf0gc1R2je9XrjQmdLa0ycz2JqlbHScKX0e3
	 fHIeG/4jq79OXCGeyOOaVkWHT/QEuhJNthtt665r/yMf0O0+9nAaAXxhyPIk3aTHyv
	 B9T6JmiDovz3eFsFlYAVHh8Fn82jsEL3NCHEUX1+oXyJBcrwQEtuNLSSHkBcGiJgdf
	 +LSV4cBfwgn4g==
Date: Tue, 19 Mar 2024 18:44:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: timer: renesas,tmu: Add RZ/G1 support
Message-ID: <20240319-habitable-broken-cd60208a7396@spud>
References: <cover.1710862701.git.geert+renesas@glider.be>
 <aee943078c91e6c627f33a62c7cd2b73320a1dc5.1710862701.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vjfwEPvneJzuIMH4"
Content-Disposition: inline
In-Reply-To: <aee943078c91e6c627f33a62c7cd2b73320a1dc5.1710862701.git.geert+renesas@glider.be>


--vjfwEPvneJzuIMH4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 04:46:04PM +0100, Geert Uytterhoeven wrote:
> Document support for the Timer Unit (TMU) on RZ/G1 SoCs.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/timer/renesas,tmu.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/D=
ocumentation/devicetree/bindings/timer/renesas,tmu.yaml
> index 8df9d4718cf82a28..7670ec74eabdf4c3 100644
> --- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
> +++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
> @@ -23,6 +23,11 @@ properties:
>        - enum:
>            - renesas,tmu-r8a73a4  # R-Mobile APE6
>            - renesas,tmu-r8a7740  # R-Mobile A1
> +          - renesas,tmu-r8a7742  # RZ/G1H
> +          - renesas,tmu-r8a7743  # RZ/G1M
> +          - renesas,tmu-r8a7744  # RZ/G1N
> +          - renesas,tmu-r8a7745  # RZ/G1E
> +          - renesas,tmu-r8a77470 # RZ/G1C
>            - renesas,tmu-r8a774a1 # RZ/G2M
>            - renesas,tmu-r8a774b1 # RZ/G2N
>            - renesas,tmu-r8a774c0 # RZ/G2E
> --=20
> 2.34.1
>=20

--vjfwEPvneJzuIMH4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfnc/AAKCRB4tDGHoIJi
0nb3AQC8gKPpodlpPrndgvwy5JSQcEpW0uLEB51xG7fgeU8ATAEAxE93Vudw/tdm
DamxMfOwoiSYkbswI1nnciKc2+wt4gQ=
=a9Cl
-----END PGP SIGNATURE-----

--vjfwEPvneJzuIMH4--

