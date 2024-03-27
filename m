Return-Path: <linux-kernel+bounces-122196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4099488F359
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20AB296B87
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2461552F4;
	Wed, 27 Mar 2024 23:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KINQcA0F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EE6154BF0;
	Wed, 27 Mar 2024 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711583226; cv=none; b=egAdMvEZ7Wlz9ekAqSZgObi46z3Bd+mlM/WCphy3L+gRPx7cGUwXSBNdJz0HvUuUHH2xHI3uh4LNUav6g+G1iToASme9kyYH7QERgVAHN1AuhNGXC05uaQNe536iMRtTWgF19lsyV2RedkdK1REh+Dkoy69LsmM5mFx+S8kS1bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711583226; c=relaxed/simple;
	bh=ulim2V9RofppsFuwyL2tOUnRK5EnhiYx9GfUeWNcMWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKnQbAeb9+xrK0aGnUTYW+2eNvggLMbOlx4j1hOEayeKyPYd68H+j59XC+W6cEw/C3WH1Fstcoah5aSa/USGpWhnSe6R+Lwn7lplYvBOr6D9TO5SXNvYB6M5kpjdP8y0vjHyxcMEz4ZwBlgcKHw8TJpQQbrYq3dItg8Kq6xPHy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KINQcA0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8BAC433F1;
	Wed, 27 Mar 2024 23:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711583225;
	bh=ulim2V9RofppsFuwyL2tOUnRK5EnhiYx9GfUeWNcMWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KINQcA0Fv+nrdZ/xuBERmXwQwdUWzrPDpnkmuJawpjagIp3yF/5WNDYJU9FwWp4CX
	 Zp2SVCx8Vdj86OVEov/hSSekaqYd1kKVcSATyUX2Zxak0fK8fWZRWqQxX7Tdy1qD/h
	 eQMuj1YOfAp5EWzd4faYaOoU1ppYOb1KW5CLHv6b+xmd/HZ5TIcIajPwkyH/E/tIB+
	 26hzWgcVLv5JNRQlo9kgp8+3w7YCOCgLCQe3Uxv49uMH156DKLYknJrqSpgLFAmCP9
	 GcJCsaC4jfuEc5RbSCoq1KXv54ux/76Ld+pagpaN5rTQWW0ZeCPgrGL86/dFYKqdyD
	 GLWjGvLAFZ9bw==
Date: Wed, 27 Mar 2024 23:47:00 +0000
From: Conor Dooley <conor@kernel.org>
To: git@luigi311.com
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH 17/23] dt-bindings: media: imx258: Rename to include
 vendor prefix
Message-ID: <20240327-ninth-tulip-77191ad10fdd@spud>
References: <20240327231710.53188-1-git@luigi311.com>
 <20240327231710.53188-18-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dAXHkG/2gzhVGfL7"
Content-Disposition: inline
In-Reply-To: <20240327231710.53188-18-git@luigi311.com>


--dAXHkG/2gzhVGfL7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 05:17:03PM -0600, git@luigi311.com wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
>=20
> imx258.yaml doesn't include the vendor prefix of sony, so
> rename to add it.
> Update the id entry and MAINTAINERS to match.
>=20
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

This is a v1 with my ack, something has gone awry here. It's also
missing your signoff. Did you pick up someone else's series?

> ---
>  .../bindings/media/i2c/{imx258.yaml =3D> sony,imx258.yaml}        | 2 +-
>  MAINTAINERS                                                     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/media/i2c/{imx258.yaml =3D> son=
y,imx258.yaml} (97%)
>=20
> diff --git a/Documentation/devicetree/bindings/media/i2c/imx258.yaml b/Do=
cumentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> similarity index 97%
> rename from Documentation/devicetree/bindings/media/i2c/imx258.yaml
> rename to Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> index 80d24220baa0..bee61a443b23 100644
> --- a/Documentation/devicetree/bindings/media/i2c/imx258.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/media/i2c/imx258.yaml#
> +$id: http://devicetree.org/schemas/media/i2c/sony,imx258.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: Sony IMX258 13 Mpixel CMOS Digital Image Sensor
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa3b947fb080..1f17f6734bf5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20464,7 +20464,7 @@ M:	Sakari Ailus <sakari.ailus@linux.intel.com>
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
>  T:	git git://linuxtv.org/media_tree.git
> -F:	Documentation/devicetree/bindings/media/i2c/imx258.yaml
> +F:	Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
>  F:	drivers/media/i2c/imx258.c
> =20
>  SONY IMX274 SENSOR DRIVER
> --=20
> 2.42.0
>=20

--dAXHkG/2gzhVGfL7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgSv8wAKCRB4tDGHoIJi
0qLWAQDvAwsiH8DSQ3M5yQeGukAW6vM32LxBgtOLicQuwx8GQQD/VEW8KGVVllHb
LRY9crPXfX98vpdqU3pNFuoskD5IHwA=
=Yq+c
-----END PGP SIGNATURE-----

--dAXHkG/2gzhVGfL7--

