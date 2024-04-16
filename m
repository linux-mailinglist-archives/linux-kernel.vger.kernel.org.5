Return-Path: <linux-kernel+bounces-147218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B35B8A711A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29EC62864D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAB5131BDB;
	Tue, 16 Apr 2024 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ero06kpB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992911E876;
	Tue, 16 Apr 2024 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284285; cv=none; b=jam70ekaj8f/NqQ25TigG2DFw6nkzrYlwYYJTiiCEddma6ZNFKt+RKOtPa2WutStq2Mq3A7XXkC9Ge9fn8Ol31SMbtA8RUTFQAoMwPB2dn+3JXdwIS0hrU0bytkIYQcu3+0h9VwP01D+9hTtGRVpzElM5qKB1A5ggvpflYmyv/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284285; c=relaxed/simple;
	bh=iBtnbAPRDmW0XRr2SLB4Q6i05KasehqxN88GRgm7s0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzrPEuuF72zwz4dP/9Sug8kZFAzIzOduIM1vn4hVwl8PdSzE6Zqk+4VMrNFky8o5frhqb9uj9qfFoFPYBdTIEAsW6A1lRY5mx1bAhFx90W+L+i5eXmW41Tf3GlNG/xjKAb3L7iJaAuZ1XnORX8+HVHgxTrB+BW/K+r2icttSjx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ero06kpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77303C113CE;
	Tue, 16 Apr 2024 16:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713284285;
	bh=iBtnbAPRDmW0XRr2SLB4Q6i05KasehqxN88GRgm7s0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ero06kpBvZKpeZ9QVxyM7zmiHdJaaP16IGTXGQVSK3FQmCZQu1y0DRXThxgHjEtiE
	 npEaCAOR2WZyt+zO+as+sFMQ9eactR8C4Sl8xa6rLW0asw+noNHPgKo3TB6DXro7Zg
	 22pmRSffNY4qAQcwJ0GGsdWD1LGdmfLkuUjsqyMiQa4JoCuUjS81w1cQJnFNQGZgCE
	 ofnuQ41y3UAsmqNw5zWlc+sCM3g+859rhcgKMx0t0M0hhaXcoypHSEDaStLLO8P+xR
	 z4nNkx31wVKeAC2BPAVQfw5A2GxQvnDzi/cHCgwGV4FHBn9X1Km9BGx58XYqRI6MuN
	 VroeqWBXYT/Pw==
Date: Tue, 16 Apr 2024 17:18:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: renesas,irqc: Add
 r8a779g0 support
Message-ID: <20240416-grader-jukebox-1e64b8a5229b@spud>
References: <264cffccfbb1f92657420f5f869236b06a97d958.1713280616.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L2j+AflHOhg6eBWy"
Content-Disposition: inline
In-Reply-To: <264cffccfbb1f92657420f5f869236b06a97d958.1713280616.git.geert+renesas@glider.be>


--L2j+AflHOhg6eBWy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 05:18:59PM +0200, Geert Uytterhoeven wrote:
> Document support for the Interrupt Controller for External Devices
> (INT-EX) in the Renesas R-Car V4M (R8A779H0) SoC.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../devicetree/bindings/interrupt-controller/renesas,irqc.yaml   | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renes=
as,irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renes=
as,irqc.yaml
> index b417341fc8ae049b..fb3c29e813499e3f 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc=
=2Eyaml
> @@ -39,6 +39,7 @@ properties:
>            - renesas,intc-ex-r8a779a0    # R-Car V3U
>            - renesas,intc-ex-r8a779f0    # R-Car S4-8
>            - renesas,intc-ex-r8a779g0    # R-Car V4H
> +          - renesas,intc-ex-r8a779h0    # R-Car V4M
>        - const: renesas,irqc
> =20
>    '#interrupt-cells':
> --=20
> 2.34.1
>=20

--L2j+AflHOhg6eBWy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh6kuQAKCRB4tDGHoIJi
0udHAPQKG6fABToF4z2Wx1SQaKoZ4TuX36qVGQZ3ivpLmpFjAQCt5kZ4xz9552rF
Cb3PPrprezHFI/XlJrofrWyT6p2MCA==
=3E9z
-----END PGP SIGNATURE-----

--L2j+AflHOhg6eBWy--

