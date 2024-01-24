Return-Path: <linux-kernel+bounces-37311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BDD83AE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8811C223AB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C033B7E572;
	Wed, 24 Jan 2024 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPJfcmIR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9C17CF08;
	Wed, 24 Jan 2024 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112753; cv=none; b=aBSBOK27OKbTDM71E1J9eu1s+GC+UFOTlN+ai4lLh7gGS4FpYpMRNqv2CL8T+8V6eaYCI3Zsxl/yR7NV2T9SibJmwnZjAiSEJnz9dz7cE5MW1P7hQNPwHOcM9CTf7VCUq5ic6nE4EyvRXLD0eZCBh/RhB/ShBuQd86w66+vWd+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112753; c=relaxed/simple;
	bh=vca/IRBT7V4XijVluTRcZtnJHCm0KKGPrd6DmMM9/k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UG14Ox6RUdbSnSs3TOo9tcX1hQK84bQJQQCPNRVL5pgT+m1A9Hp6G8rpPz7MGPd2BdJpGRAzI9tyxWR9vE8HJ6kdS05cmd5ihrWOz4ASj2moIgromDxTSpQ0oosMXQHcT6Kvv0DD6vQRUdzHUNX2FK3suqBNO0uFU6Gy3INwV0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPJfcmIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E75EC433F1;
	Wed, 24 Jan 2024 16:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706112752;
	bh=vca/IRBT7V4XijVluTRcZtnJHCm0KKGPrd6DmMM9/k0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WPJfcmIRZHvIF6wa5nnnp/4zybp+D3zxl/0hmOsJ/dDJzCsS+wesxKAP+x9CGer4+
	 kljq02k20OB6JkV3coKGnkx3uuuEd859haMZ11x8jTan1kn/i+0RxNBhWkZJDy9Zp1
	 n8BLlwT70cH+OebDvTO6EPpggkxw4WNdUWR4HvE0dWdzcDG9Zd58phLrvDDBtA9B5O
	 hoVOtCmZIL5R8XdWybqE/xTh5hDL1pzOKX1Gmv7rNfIvhW/E4+RzxhcoZGJvjAcSja
	 TehE+s8fahZHaHaLWOlVsvo9RuxyXZpzEX4PChz5RlwEyg26PE4W1mbEkkt9om1KYn
	 Jw/vyGhOqeuFg==
Date: Wed, 24 Jan 2024 16:12:27 +0000
From: Conor Dooley <conor@kernel.org>
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	kernel@pengutronix.de, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: net: adin: add recovered clock output
Message-ID: <20240124-thespian-user-e03315490295@spud>
References: <20240122110311.2725036-1-f.pfitzner@pengutronix.de>
 <20240124102554.1327853-1-f.pfitzner@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t3OrvrAsH2Aaal0o"
Content-Disposition: inline
In-Reply-To: <20240124102554.1327853-1-f.pfitzner@pengutronix.de>


--t3OrvrAsH2Aaal0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 11:25:54AM +0100, Fabian Pfitzner wrote:
> The ADIN1300 offers three distinct output clocks which can be accessed
> through the GP_CLK pin. The DT only offers two of the possible options
> and thus the 125MHz-recovered output clock is missing.
>=20
> As there is no other way to configure this pin than through the DT it
> should be possible to do so for all available outputs.
>=20
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/net/adi,adin.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/adi,adin.yaml b/Docume=
ntation/devicetree/bindings/net/adi,adin.yaml
> index 929cf8c0b0fd..04059393b756 100644
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
> +        - free-running 125MHz
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
>=20
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> --=20
> 2.39.2
>=20

--t3OrvrAsH2Aaal0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbE26wAKCRB4tDGHoIJi
0uasAP9k19fNc3ngPfP4KVkRXGmzsNoEaqPZih5IpbjEPe/ixgD9EmYsTcGn3IWJ
8hvoOz5lMTlqOuGoIlB61AKbTVVVXw0=
=mTuk
-----END PGP SIGNATURE-----

--t3OrvrAsH2Aaal0o--

