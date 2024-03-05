Return-Path: <linux-kernel+bounces-92937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ACC872854
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F861C289F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9B8128807;
	Tue,  5 Mar 2024 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkB8x/Ri"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7392D5C5FD;
	Tue,  5 Mar 2024 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709669414; cv=none; b=WKMCi4zg35+UyZATambPRMldUMMhARX9qd+4pRF1xlVHnwZej9UEkjzKbk5FDGfQkRn6wPUZwkEeU0blfBrBYQqZLK2lvZ/BqUeMY8+MWrK2CMOCeai+mWybj8hQdxdG4uS8iT1jWO2aupIVKYV7Cn7XUI5XSLtKGeWCQ8qeIwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709669414; c=relaxed/simple;
	bh=AYi3OAmTLgdEEKDdxYIjpcX/Nqk0mUN9Udva4vaPjAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enk7HdHh+5vIRG9clvJrjDOBFxCCgWqPzvPpFW4L6uIb5axxwQIfegpBke34KlK1fNXWuw7FDMwy30BMZpOL3qjqRZX7AbDpF51gKIzfGnpPah9x6PP0Q0CUqldfYpEVjzaBPZCaoRrSbSCxHhtY0qaqTIKgpeYk8F6gHlib6dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkB8x/Ri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21B0C433F1;
	Tue,  5 Mar 2024 20:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709669414;
	bh=AYi3OAmTLgdEEKDdxYIjpcX/Nqk0mUN9Udva4vaPjAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MkB8x/RiiNjqHLdCWpmsWMLpUeeF5O0OMSeSGeB2lg2Ntk79dAULuRMuFrdR7gNSj
	 JDuXbb+bxTKUistiZWtXc7mGsrzRMwT0C1uVR3yPg1VWIxzeVwujd2NK48KHq3Zw0w
	 LckmIgOMI8qZt2tBSph/6tEYXZ+J5G4Ca9ksFiejZfWfBRsBKDKSfVeMb9nV6l/o6Z
	 UGmD6UEj+oxSFlorbZmTDC37rMWqpO1amK+uax3OgFx/+3SRXZY7yGeezLRoOHqcBS
	 gc15ZnYAWgvWzs6zEPggggcYfTD47IzWoK2IySdQn877TJRdVObGYJejCpa1ntWbFn
	 Sr2JO/G+AO6ww==
Date: Tue, 5 Mar 2024 20:10:08 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?J=E9r=E9mie?= Dautheribes <jeremie.dautheribes@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH RESEND net-next] dt-bindings: net: dp83822: change
 ti,rmii-mode description
Message-ID: <20240305-jawless-lingo-7a4261a2ba89@spud>
References: <20240305141309.127669-1-jeremie.dautheribes@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GEeM/2SHVlkuMks1"
Content-Disposition: inline
In-Reply-To: <20240305141309.127669-1-jeremie.dautheribes@bootlin.com>


--GEeM/2SHVlkuMks1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 03:13:09PM +0100, J=E9r=E9mie Dautheribes wrote:
> Drop reference to the 25MHz clock as it has nothing to do with connecting
> the PHY and the MAC.
> Add info about the reference clock direction between the PHY and the MAC
> as it depends on the selected rmii mode.
>=20
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: J=E9r=E9mie Dautheribes <jeremie.dautheribes@bootlin.com>

This feels like it should have a Fixes: tag.
Otherwise
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheerrs,
Conor.

> ---
> This patch follows on from my previous patch series [1] which has already=
 been=20
> merged into the net-next tree and which added the "ti,rmii-mode" property.
> As suggested by Andrew Lunn, this patch updates the description of this=
=20
> property to make it more consistent with the master/slave relationship it=
=20
> conveys.
>=20
> [1] https://lore.kernel.org/all/20240222103117.526955-1-jeremie.dautherib=
es@bootlin.com/
>=20
> Resending because I previously forgot to include the "net-next" entry in=
=20
> the email subject.
>=20
>  Documentation/devicetree/bindings/net/ti,dp83822.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Docu=
mentation/devicetree/bindings/net/ti,dp83822.yaml
> index 8f23254c0458..784866ea392b 100644
> --- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> @@ -84,10 +84,10 @@ properties:
>      description: |
>         If present, select the RMII operation mode. Two modes are
>         available:
> -         - RMII master, where the PHY operates from a 25MHz clock refere=
nce,
> -         provided by a crystal or a CMOS-level oscillator
> -         - RMII slave, where the PHY operates from a 50MHz clock referen=
ce,
> -         provided by a CMOS-level oscillator
> +         - RMII master, where the PHY outputs a 50MHz reference clock wh=
ich can
> +         be connected to the MAC.
> +         - RMII slave, where the PHY expects a 50MHz reference clock inp=
ut
> +         shared with the MAC.
>         The RMII operation mode can also be configured by its straps.
>         If the strap pin is not set correctly or not set at all, then thi=
s can be
>         used to configure it.
> --=20
> 2.34.1
>=20
>=20

--GEeM/2SHVlkuMks1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZed8IAAKCRB4tDGHoIJi
0n1lAQC/lciR2GVw8GYCLkEiSQmmwwa+9Kmk4x3SGxsDXf90pgEAmN5UV+eCjr+5
3rhpbgfvWocWrxJve288DQcOaYDSKgY=
=4+n1
-----END PGP SIGNATURE-----

--GEeM/2SHVlkuMks1--

