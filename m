Return-Path: <linux-kernel+bounces-33842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50298836F62
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0841DB250CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC35840C1D;
	Mon, 22 Jan 2024 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuAFpTO4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E3840C1F;
	Mon, 22 Jan 2024 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945128; cv=none; b=N2IFC2oYOJvdh94RYFJ/uAx4IlIwoAjL/QfoWG/Uq14A+GAaUSfAwIZHsNtns2W1Nh2HHcmZI8A6wTKJb7j5uCO0SRGLchVY53Imn0t4OZfX1scVgnrqcJYGk0xsnW06l/G0x5a4byeQLWdoD+iVxWswjZQCd9nRqR/y/jLicmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945128; c=relaxed/simple;
	bh=s97P5ad8CGWrxO21PQ5C9STKmQGTWqhS9e/Fu2B5J0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYMYf0ogDwc647h236n7JNy+77E/2ByhhmQrsPcnawoBFIqGgHyDdxiK09quHAMbtV93tjfKuIvqni+W+AL/s8XoPN0noUmKkJS+EyCGPiqva+bKbvqxmFGHds0H/P/8OcZFG1bkmQGbOF7LItEwUbZSk/fPN3XOhMlkTsSvPe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuAFpTO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403CEC433F1;
	Mon, 22 Jan 2024 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705945127;
	bh=s97P5ad8CGWrxO21PQ5C9STKmQGTWqhS9e/Fu2B5J0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JuAFpTO4VI3Yr4fOiCfZbAQwdKFYU0AdHcap5+Mw/07qi6v4lEN5DqbTuANk5L8T4
	 p78ZfIu8Px2GzvoOs7wS8eJzYm8uvjG8a8Hy34ZdqeQTNql/1IgU7x4NOKsn0zKsr/
	 AHBeD0wSAyGNpBlD3gvQA1NUOvCexaf+iJtE/QXoenL1fJeZKy6Cqo1O3qc9/6cX4K
	 uwR1QNG9JkmcfCBBcgcS2cPrD84OBWA9WS1VymOkHxjEtmav9WQp86tb9N2lrSAdwF
	 xH2dQsn0F/PFUAJRCGcYYq6ZiCmS7WECdJ/0vOBFLIhATa3VdOW/VyJfb1r9xVAyAi
	 8gB9oXA1UeUDg==
Date: Mon, 22 Jan 2024 17:38:41 +0000
From: Conor Dooley <conor@kernel.org>
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	kernel@pengutronix.de, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: adin: add missing clock option
Message-ID: <20240122-referable-unpainted-e17146ad8c7a@spud>
References: <20240122110311.2725036-1-f.pfitzner@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T9OLXLfc2/3CNTTe"
Content-Disposition: inline
In-Reply-To: <20240122110311.2725036-1-f.pfitzner@pengutronix.de>


--T9OLXLfc2/3CNTTe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 12:03:12PM +0100, Fabian Pfitzner wrote:
> The GP_CLK pin on Adin1300 PHY's offers three different output clocks.
> This patch adds the missing 125MHz recovered clock option which is not
> yet availible in the driver.
>=20
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/net/adi,adin.yaml | 7 +++++--

Binding patches should be split out from drivers please.

Thanks,
Conor.

>  drivers/net/phy/adin.c                              | 2 ++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/adi,adin.yaml b/Docume=
ntation/devicetree/bindings/net/adi,adin.yaml
> index 929cf8c0b0fd..cd1b4efa692b 100644
> --- a/Documentation/devicetree/bindings/net/adi,adin.yaml
> +++ b/Documentation/devicetree/bindings/net/adi,adin.yaml
> @@ -38,14 +38,17 @@ properties:
> =20
>    adi,phy-output-clock:
>      description: |
> -      Select clock output on GP_CLK pin. Two clocks are available:
> -      A 25MHz reference and a free-running 125MHz.
> +      Select clock output on GP_CLK pin. Three clocks are available:
> +        - 25MHz reference
> +        - free-running 125MHz=20
> +        - recovered 125MHz
>        The phy can alternatively automatically switch between the referen=
ce and
>        the 125MHz clocks based on its internal state.
>      $ref: /schemas/types.yaml#/definitions/string
>      enum:
>        - 25mhz-reference
>        - 125mhz-free-running
> +      - 125mhz-recovered
>        - adaptive-free-running
> =20
>    adi,phy-output-reference-clock:
> diff --git a/drivers/net/phy/adin.c b/drivers/net/phy/adin.c
> index 2e1a46e121d9..b1ed6fd24763 100644
> --- a/drivers/net/phy/adin.c
> +++ b/drivers/net/phy/adin.c
> @@ -508,6 +508,8 @@ static int adin_config_clk_out(struct phy_device *phy=
dev)
>  		sel |=3D ADIN1300_GE_CLK_CFG_25;
>  	} else if (strcmp(val, "125mhz-free-running") =3D=3D 0) {
>  		sel |=3D ADIN1300_GE_CLK_CFG_FREE_125;
> +	} else if (strcmp(val, "125mhz-recovered") =3D=3D 0) {
> +		sel |=3D ADIN1300_GE_CLK_CFG_RCVR_125;
>  	} else if (strcmp(val, "adaptive-free-running") =3D=3D 0) {
>  		sel |=3D ADIN1300_GE_CLK_CFG_HRT_FREE;
>  	} else {
>=20
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> --=20
> 2.39.2
>=20

--T9OLXLfc2/3CNTTe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa6oIQAKCRB4tDGHoIJi
0jbYAP49mdKtvg7unND1j8aBN/hxnTyY3WvZ5HQqpXL7NlTl6QD+MSD66DKsii7j
HvCpLEZMFmLKxjcK1iYDb5IdOtDR2gQ=
=rSP9
-----END PGP SIGNATURE-----

--T9OLXLfc2/3CNTTe--

