Return-Path: <linux-kernel+bounces-67369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E8F856A86
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F2A1F238F8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8888A1369AB;
	Thu, 15 Feb 2024 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDTIumQm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C737C12DD9A;
	Thu, 15 Feb 2024 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016771; cv=none; b=dhTwKbu8Z4/a7O9aMb/p5RGDnvzRMaThsR4hwN6dJoMS/RbIAHIpLoeyeug2mdrwJcnuJgsBKC1Eh/fjAhgi86CsKcrAmK4b1zOiNdo/H7CLREUToWmVQAMUS46vJwHrbWikJvFzUxrmNHhQxQHIDFMlYCXZRlEwQCwY4L63zCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016771; c=relaxed/simple;
	bh=KElkYGBiD4v/kDlWoYsOgMzKDGtsKxpQOCFbAZgDAVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SX9Lj4T8Wzggc9Qfri9F0SWXn0vtJRlApiAmMn/4xhd/vbpd44komN2qUkKeH9rgU9rDs9WoPwhby321hudCTeZhaEc2rGOFjHtOYnPm3GrN8eDayO0Ry+8qmsz7SkamOsUASEt4DW86iedBRNtOr4GmtTx3op2bbzLg/MJGvj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDTIumQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A6FC433C7;
	Thu, 15 Feb 2024 17:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708016771;
	bh=KElkYGBiD4v/kDlWoYsOgMzKDGtsKxpQOCFbAZgDAVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eDTIumQmpuZVkJkzWHyYLh0IuxXqavUkd4qjsMqzWFvyYWz4KeoQ+TwHO9smxpUYI
	 YIC4RqUQj0sxEFYKk9ygbusIsvORwn6Iu5Yj5Sm9ffDC1bt3whW4vUHSyUlaWKbutR
	 l0CM8rWQ3N6I3GITQlC423KdwEoWnVbcDCQCoizqTTqWAXU5o8UUN7Rn63hYNXfv4i
	 3iQUBhPGRSj8Om7WGtuLeI9ouBEN+10/CTzy73L/OyERIEWJOfXUZhBg1mVJw+BY24
	 NnBy1pVp75czHbx8XEp00QMdjeAXYLp58h1zdpeYo+ZKvysjlueBrIAF4IAssTEYK3
	 8CkXtqv+UfKhA==
Date: Thu, 15 Feb 2024 17:06:06 +0000
From: Conor Dooley <conor@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, quentin.schulz@theobroma-systems.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 2/3] dt-bindings: display: ltk500hd1829: add variant
 compatible for ltk101b4029w
Message-ID: <20240215-boat-grid-d50f0eccec67@spud>
References: <20240215090515.3513817-1-heiko@sntech.de>
 <20240215090515.3513817-3-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uAgW2Em0kHJeJUhg"
Content-Disposition: inline
In-Reply-To: <20240215090515.3513817-3-heiko@sntech.de>


--uAgW2Em0kHJeJUhg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:05:14AM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>=20
> Add the compatible for the ltk101b4029w panel, that is really similar
> to the ltk500hd1829.

Please mention what makes the devices incompatible. "really similar" is
vague and could be used for a device that was only cosmetically
different.

With that,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>  .../bindings/display/panel/leadtek,ltk500hd1829.yaml          | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/leadtek,ltk5=
00hd1829.yaml b/Documentation/devicetree/bindings/display/panel/leadtek,ltk=
500hd1829.yaml
> index c5944b4d636c5..d589f16772145 100644
> --- a/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd182=
9.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd182=
9.yaml
> @@ -14,7 +14,9 @@ allOf:
> =20
>  properties:
>    compatible:
> -    const: leadtek,ltk500hd1829
> +    enum:
> +      - leadtek,ltk101b4029w
> +      - leadtek,ltk500hd1829
>    reg: true
>    backlight: true
>    reset-gpios: true
> --=20
> 2.39.2
>=20

--uAgW2Em0kHJeJUhg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc5EfgAKCRB4tDGHoIJi
0mg8AQDnVMCCNnW/BjpK3m7RSYd2PlygPSQcY9KfMc/u+FOnmAD+JfhDWteO5rdB
4I4vgyPxLWbg0qw+KHEZIn4ucWBjmwY=
=AQS2
-----END PGP SIGNATURE-----

--uAgW2Em0kHJeJUhg--

