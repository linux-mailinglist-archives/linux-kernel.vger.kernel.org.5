Return-Path: <linux-kernel+bounces-48717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF4384602E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986C8286C89
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254B882C9B;
	Thu,  1 Feb 2024 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY+ElGIm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E317E113;
	Thu,  1 Feb 2024 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812985; cv=none; b=r5Uh4xEu3ZYWTRszDUqKrFCo5KEaU6wgap0F8TqAXyu6lpboj8P9A8ALoCuuKx4f01DVnnaoUhpkorgHUAmqeIQ3QB6MTxoUHurbzAAo/ddz2izzVIzV5fHoETux4Mj5C21zcr+JpeBzkjvMd8wXvG0u1ou7pxJa9tHdjp+gNzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812985; c=relaxed/simple;
	bh=08WTJYiiiVSXfDqZA54KHPdrHQAZkWse/35hApk4m4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTE9MnHfEhtJ1n3Q0xTxqHqLeZNPxncOjvqQtHwsyj4hfZtq8TA5HSN6Bwdfa5eLMqjG08qvYOcDyfqzpPQML/YbrDr5kdTr3MjLEPvT1nSOlhVucF+bnZSm/W914wS2q4ppwuI2GfM1UfnOOBmhMnsHsmOMOS0wHckhiyO2keI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eY+ElGIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B8AC433F1;
	Thu,  1 Feb 2024 18:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706812984;
	bh=08WTJYiiiVSXfDqZA54KHPdrHQAZkWse/35hApk4m4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eY+ElGImWlNLu57i4LaQK0R+OxW4C/stUbAV9y9nwzPjQYbVIcDqFKs92YNXyF+qD
	 g+4r2+gyDSgxqJy0rwBLKA7GbIn34H0SExYaOKv2unXJIXQGIOhswlZp+tkE5QcWV/
	 XKrN3PilkyDzGoi5JPc1Gaw53RPhFq2MIAgwD1owOTnR21pyltGjoZcyHqqxXljVne
	 CkYBnGHtWNkF6PfTVegva3fxkqlXfKvjg8MXdGA7jf9M1widO+1SE7M+FiY/uV3kV/
	 2uo/W9+mTgxkRUjqtX8bVl7k6rPHE6otrnC3zJSDAu6QM6KbF4DFlY0MXW8KdgV3Kq
	 hs9fHDDswpw9g==
Date: Thu, 1 Feb 2024 18:42:59 +0000
From: Conor Dooley <conor@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 02/12] dt-bindings: arm: keystone: ti-sci: Add
 reboot-controller child node
Message-ID: <20240201-jester-gleeful-3ac8f035e0a4@spud>
References: <20240131221957.213717-1-afd@ti.com>
 <20240131221957.213717-3-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wEmJWZe8MbdHoMiC"
Content-Disposition: inline
In-Reply-To: <20240131221957.213717-3-afd@ti.com>


--wEmJWZe8MbdHoMiC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 04:19:47PM -0600, Andrew Davis wrote:
> The TI-SCI firmware supports rebooting the system in addition to the
> functions already listed here, document child node for the same.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../devicetree/bindings/arm/keystone/ti,sci.yaml          | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b=
/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> index c24ad0968f3ef..e392175b33c74 100644
> --- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> @@ -83,6 +83,10 @@ properties:
>      type: object
>      $ref: /schemas/reset/ti,sci-reset.yaml#
> =20
> +  reboot-controller:
> +    type: object
> +    $ref: /schemas/power/reset/ti,sci-reboot.yaml#
> +
>  required:
>    - compatible
>    - mbox-names
> @@ -126,4 +130,8 @@ examples:
>          compatible =3D "ti,sci-reset";
>          #reset-cells =3D <2>;
>        };
> +
> +      k3_reboot: reboot-controller {
> +        compatible =3D "ti,sci-reboot";
> +      };
>      };
> --=20
> 2.39.2
>=20

--wEmJWZe8MbdHoMiC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbvmMwAKCRB4tDGHoIJi
0s2aAP9oJwCoaFBP/LiIOI1L9NQnqVEqe8nwLeFFqoCC5wnytQEA0xHtdx7CCHLx
xpLtzML7N+aekuG2qmu4q1raHVY7UgU=
=+A1E
-----END PGP SIGNATURE-----

--wEmJWZe8MbdHoMiC--

