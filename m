Return-Path: <linux-kernel+bounces-55234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D4D84B9AA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55DF1B28C40
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FAF138495;
	Tue,  6 Feb 2024 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/7xzrEz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8109C134CCD;
	Tue,  6 Feb 2024 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232954; cv=none; b=dbKM7RGs9vZABkp9ZrpeUk26CTMxrgzKWJ6Yfm9NYGsdiZO39McRopil59/q9MOyox0rnrbGkIqSBefuntXmxHUJfAF9b6NONTUoZxuWlYWJvzxAtrpUcpudm50+XCTS0SvxIv/18J6nd2kwOZbCNLOyoQMi0fdby3qyYbAqWvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232954; c=relaxed/simple;
	bh=w6YilWol0RyiScg93mhzAJ76LclnX6Kz5v3eEK5ZCKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7/Cx4trE7u18YbBKyIUojBbgP/qG3BryLt5Jg5c2QZN2UnrJxXe4EpHWCvniVNZ8WfRBZQRvLKsXqk07pjes40PN+M4+CUSGjtw/cNpVRxjmf53NT1SWfO7z0sHQew9dVx0UflpvVGqnf456aYEaQRQLmAMIvpGH+aD+RXOscs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/7xzrEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE016C433F1;
	Tue,  6 Feb 2024 15:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707232954;
	bh=w6YilWol0RyiScg93mhzAJ76LclnX6Kz5v3eEK5ZCKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/7xzrEzn/xPytAckNgHKh/aH73j0lqZVimb+oMSSWaK1GlzQVLPlGNhcrFY6bae6
	 /+HH4UNoOT5wgpbf4mgacR7ylcIDtDoZ69HkCJ/FI6WiTYfsXGqikq9gWURO6pUqPp
	 Lqzts9uyZetD698i45pmYrWNVroUtK/J5hq5hnHxVXVrJ0k8ix3GFwPZMcYb3D8QzK
	 b27AcK5S+f0UYd9HDomRiinUzXAlj6D3vXS3Fa7GQkcPz2II0JXOHwkU0X1EtMp3iK
	 7zlrhcvKK5d5p2yTakJNNgRx4BFkAHww3emv5JHJ69svUFLxM5ypbznvJEO7e6C/ZQ
	 LpHGu+YMcc2NQ==
Date: Tue, 6 Feb 2024 15:22:29 +0000
From: Conor Dooley <conor@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: iio: afe: voltage-divider: Add
 io-channel-cells
Message-ID: <20240206-washboard-sustained-990e97d86d78@spud>
References: <20240206105502.648255-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SgbKZ4rkUNiF+vzT"
Content-Disposition: inline
In-Reply-To: <20240206105502.648255-1-naresh.solanki@9elements.com>


--SgbKZ4rkUNiF+vzT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 04:25:01PM +0530, Naresh Solanki wrote:
> Enable the voltage divider to both receive and provide measurement
> services by adding #io-channel-cells.
>=20
> This is especially valuable in scenarios where an ADC has an analog
> frontend, like a voltage divider, and obtaining its raw value isn't
> interesting. It is desired to get the real voltage before the voltage
> divider.
>=20
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for adding the example. I have one comment about the wording, cos
the last sentence doesn't really make sense without something referring
back to the scenario you describe.

> ---
>  .../devicetree/bindings/iio/afe/voltage-divider.yaml  | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.ya=
ml b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> index dddf97b50549..fd3c511e1beb 100644
> --- a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> +++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> @@ -39,6 +39,17 @@ properties:
>      description: |
>        Channel node of a voltage io-channel.
> =20
> +  '#io-channel-cells':
> +    description:
> +      In addition to consuming the measurement services of a voltage
> +      output channel, the voltage divider can act as a provider of
> +      measurement services to other devices. This is particularly
> +      useful in scenarios wherein an ADC has an analog frontend,
> +      such as a voltage divider, and then consuming its raw value
> +      isn't interesting.

> It is desired to get the real voltage
> +      before the voltage divider.

"In this case, the voltage before the divider is desired".

Perhaps Jonathan can make that change, provided you are okay with it.

Cheers,
Conor.

> +    const: 1
> +
>    output-ohms:
>      description:
>        Resistance Rout over which the output voltage is measured. See ful=
l-ohms.
>=20
> base-commit: 99bd3cb0d12e85d5114425353552121ec8f93adc
> --=20
> 2.42.0
>=20

--SgbKZ4rkUNiF+vzT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcJOtQAKCRB4tDGHoIJi
0llOAP0ciuD1pKliFSwXDRBcGMgNuwyHn83vlQwgOYL/NjPkwAEAnXub8MSJ/lZo
0XoMa5YMcnNSd5JIIZBCzI7VU/2zDQ0=
=wq45
-----END PGP SIGNATURE-----

--SgbKZ4rkUNiF+vzT--

