Return-Path: <linux-kernel+bounces-65772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F0E85521C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 677E3B2FEBA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45B212CDB6;
	Wed, 14 Feb 2024 18:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o10FIg7E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466D12CD95;
	Wed, 14 Feb 2024 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933864; cv=none; b=IZMiKjECO07raR4s4Qg3dXU34X34yOoDGHOoS4m2X+YXGaGhBNvwTehhOZXMr1gCx3GVLVjFgBgeCn9hOkAXPNuBANlxEDQZG+RHFaIq7PXbOgBc5+yQ1u9Jyyst2eMeVkcJYYS8pqqsAxO9tg8J5Ega23l6jci5D+uI3q3qcdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933864; c=relaxed/simple;
	bh=IDeUiMyZPUnEfKxpDIXHipIIOqaWatBhHTQI+AiVf+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KF3AtYMU68HY2Hnm4Ta2vb4I7iHP9yPzUuKGBeBRv+nNseI6KTudYCcfaLA9xnOiLKXVM705LYYbN3Vi0XeBQvQrSRy8aDmbEYmJ4xE023+lAwTUHmbcaLeyDNuMwl6yBvXtdm41/D14xXCEXDf1yO8c6uMTdUuGkrcyNddvpfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o10FIg7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BBDC43394;
	Wed, 14 Feb 2024 18:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933862;
	bh=IDeUiMyZPUnEfKxpDIXHipIIOqaWatBhHTQI+AiVf+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o10FIg7EJ8HGW+DA+b7COwvaLG9skhdRVdxvVBUwfoHXJyJcPCpun0NVQAw9S0TTq
	 /EEUVEdBeeg3crTDamwO6b24lTxcreqNUYhQDy8zKYZfuOgwzPP2oYJeNzWi/eMP0l
	 uQR7Qy6t4BD7YGwctYT8kQOoy084lAB/h5jugVYXmFAazffTpNdzoooBmgONDZ/LNS
	 Igm9bk6oD/X21OLL0s/XL3MhjbX2ptQROaECd6cR+4yurV+i4qNeR/oEumeAXBOrhQ
	 SZR7/oZ1BCALnNwb57auPvIzVfa28KqGbFWM0FNo9epA1xEHFPDxtTMfxhbKmah8hC
	 p8JvUHvwqC4HQ==
Date: Wed, 14 Feb 2024 18:04:17 +0000
From: Conor Dooley <conor@kernel.org>
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hari Prasath Gujulan Elango <hari.prasathge@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: mfd: Convert atmel-flexcom to json-schema
Message-ID: <20240214-vagueness-voice-15fb82c56bfb@spud>
References: <20240214-sama5d2-flexcom-yaml-v1-1-5dedd0eba08e@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wQNHLYaQdvjLT5wU"
Content-Disposition: inline
In-Reply-To: <20240214-sama5d2-flexcom-yaml-v1-1-5dedd0eba08e@microchip.com>


--wQNHLYaQdvjLT5wU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 11:13:43AM +0530, Balakrishnan Sambath wrote:
> From: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
>=20
> Convert the Atmel flexcom device tree bindings to json schema.
>=20
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> ---
> The yaml DT bindings for the atmel-flexcom driver were submitted
> upstream in a separate patch series in 2022 [1] which was Acked-by
> Krzysztof Kozlowski. However, it has been observed recently that the
> patch has not been merged into the mainline codebase.When attempting to
> apply the patch to the latest upstream kernel,a conflict arose due to a
> recent addition to the original device tree binding in text format. The
> conflict has now been resolved and we are sending a updated version of
> the patch.=20

I don't think you actually resolved this conflict:

> +properties:
> +  compatible:
> +    enum:
> +      - atmel,sama5d2-flexcom

> -- compatible:		Should be "atmel,sama5d2-flexcom"

> -			or "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom"

This line here is the "recent addition", but this is not in the new yaml
binding.

Please fix!

Thanks,
Conor.

--wQNHLYaQdvjLT5wU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc0AoQAKCRB4tDGHoIJi
0tIEAQC/q08UAG37AzdYes9SCpdwGsOdCtlrsF3TYziiNJHCgAD+K3uUQBf7BsKM
ujNCelvDidii75c7qh66+xespxlJuwA=
=DBLx
-----END PGP SIGNATURE-----

--wQNHLYaQdvjLT5wU--

