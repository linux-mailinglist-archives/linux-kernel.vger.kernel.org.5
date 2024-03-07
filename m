Return-Path: <linux-kernel+bounces-96094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20946875701
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210FF1C20CA2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B66136675;
	Thu,  7 Mar 2024 19:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RI8mCtQp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56D31CABF;
	Thu,  7 Mar 2024 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839274; cv=none; b=WmuNhnxIqaGRHeCAQl/4jsJM+TBC+iIfnO3l75l44eF7cn0XW40+JESZ/jpVk3dCMN4fc7q0efxZiglsnhWfILQJ02YeTgx54OT8x2w9pDmH6Nwp4EjVOJxy4T/DqWW4V1Bn4mG7mc33Axvf5oRruNoTY6x2B6eeUgxpt3Mmwio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839274; c=relaxed/simple;
	bh=Mq2JzSTskjUBLrBUZ5m2ziau5VssMD3DsfOl4JNEE10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxZ1AFoWvIrMkeuDd7qXdwC5UCLZVcVN6qsmc6hRPw4xvIgF1ITejc7jNKnpBqWWOxdSGP9A9X/db/RIvSqI292/ye3Uh1yD0QMPdxI7HcIifoq+MK6ctHEZPql4z8P2Y4vYhjA2bjL+9ZXScLBx1YjoJfa3l/hc8l4Nh4EJuDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RI8mCtQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41736C433F1;
	Thu,  7 Mar 2024 19:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709839274;
	bh=Mq2JzSTskjUBLrBUZ5m2ziau5VssMD3DsfOl4JNEE10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RI8mCtQpdwHCKMzSm6VBXN3AfskgytGwAI5VUnAcWN+GmEF2lYXHiWyPSZKFskXee
	 8BYN0xU3pR94xMIPzpeyzmvznb/1ZS/APkx0PaFQFCArFLu34aznECxNf1p4yTZfcU
	 J1PRJdujvHO629kLEw+XQHJeZ+82Yx1ecsw4vJ1bpWa8fGiTU63BUbugx5oHjmCZML
	 aIxDkwXVTzwk20LsFCAM3/D9hVwGyhohfclW5V+OJ/oo9wst69oapf6ussNIb0NDYi
	 a9zmxWSI8eHe/59E65Yr3RYTOErH4OJRgBzr6PCJ+AtBvje32CWmP5Z34nZJXAu2PA
	 UGBDrY9GokU5w==
Date: Thu, 7 Mar 2024 19:21:09 +0000
From: Conor Dooley <conor@kernel.org>
To: Julien Massot <julien.massot@collabora.com>
Cc: linux-media@vger.kernel.org, kernel@collabora.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	sakari.ailus@iki.fi
Subject: Re: [PATCH v4 2/4] dt-bindings: media: add Maxim MAX96714 GMSL2
 Deserializer
Message-ID: <20240307-retract-aloof-9ff1fde79a82@spud>
References: <20240305152608.287527-1-julien.massot@collabora.com>
 <20240305152608.287527-3-julien.massot@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YVK4XItZqyyKtGIy"
Content-Disposition: inline
In-Reply-To: <20240305152608.287527-3-julien.massot@collabora.com>


--YVK4XItZqyyKtGIy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 04:26:06PM +0100, Julien Massot wrote:
> Add DT bindings for Maxim MAX96714 GMSL2 Deserializer.
>=20
> Signed-off-by: Julien Massot <julien.massot@collabora.com>
> ---
> Change since v3:
>  - Renamed file to maxim,max96714.yaml dropped the 'f' suffix

Why? The filename should match the compatible, which /does/ have an f.

>  - Removed mention to C-PHY since it's not supported by MAX96714 deserial=
izers
>  - Removed bus-type requirement on CSI endpoint since the device only sup=
port D-PHY
>  - Removed the clock-lanes property in the dt example
>=20
> Change since v2:
>  - remove reg description
>  - rename enable gpio to powerdown
>  - use generic node name: i2c, serializer, deserializer
> ---
> ---
>  .../bindings/media/i2c/maxim,max96714.yaml    | 169 ++++++++++++++++++
>  1 file changed, 169 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max=
96714.yaml

> +properties:
> +  compatible:
> +    const: maxim,max96714f

> +  i2c-gate:
> +    $ref: /schemas/i2c/i2c-controller.yaml

There is an i2c-gate binding, you should reference it here instead.

> +    unevaluatedProperties: false
> +    description: |

This | is not needed, there's no formatting to preserve.

> +      The MAX96714 will pass through and forward the I2C requests from t=
he
> +      incoming I2C bus over the GMSL2 link. Therefore it supports an i2c=
-gate
> +      subnode to configure a serializer.

--YVK4XItZqyyKtGIy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeoTpQAKCRB4tDGHoIJi
0qyuAQDRRcB5+1h8xQVfJkvmV80j6Spgx0pLBnQoqCdZVE8i6QEAzkbOrL2NcpjK
4jetePOWh2/qmjyMGvGJEz9K80bhuAI=
=Z4HV
-----END PGP SIGNATURE-----

--YVK4XItZqyyKtGIy--

