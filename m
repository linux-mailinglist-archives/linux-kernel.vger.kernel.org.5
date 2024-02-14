Return-Path: <linux-kernel+bounces-65473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D49C854D81
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF421F252B2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7B65FDDE;
	Wed, 14 Feb 2024 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpaHQ+hM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A92F5C906;
	Wed, 14 Feb 2024 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926312; cv=none; b=cZiyFgFgX02BBJviCN0HtnoK+SPPEoB8aGclJhcaMT19kK9u9VSqr96XDFiWvaxfFnIkNjjQZ4XUuFH0Fie7sY1mK5ft6V+mNke7bEfZj6L5GzQMiiABKqI80+aySAEQOBqFpEUKd8P+p+GDmk+XKwgu6w3Shs0QDM9MCBLuqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926312; c=relaxed/simple;
	bh=oB7y26cHY18BFwgZZYSp49BaRjDmeMewAnXDzdUPdTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFeXwlZcmNqKU3httILwdiFPqtPUk2h4Ux+0JMzhw0otiwIkzA5wHBLQK9jp+uTnwZPFVjJLcwdf2LWmSJ681HfW3Mvdwlmo4a9rChGnT/JM6gzK4yXxw/B5acHblLy3GRV5CiRslvq3AMeEe0g//mCJNN1Ll1osbItD8UMaqQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpaHQ+hM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E9AC43399;
	Wed, 14 Feb 2024 15:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707926311;
	bh=oB7y26cHY18BFwgZZYSp49BaRjDmeMewAnXDzdUPdTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FpaHQ+hM3RyU71YtYb3zG+Iy0dU0hLDJhcN31jc3o7Z0ulTmns1wxJoJ7dmiPzR2S
	 r7U2vTqHBkhTXOO7SnHsXdZixs/BZXuQqdiggP7yL/o8QvSWV6Yb1n6iRTvANTRVzj
	 2N+pD9miPRBsxvz9RJvqtJf6kX5ExqkVB3wlyDMpKwOlZp45E5ZsZlKeS+fZ7N5GUg
	 nel46MQoIfCX8K8DR4xXUbKOyh0NC4pvssM0Qt75YuvXeGfbHSrxo/9PLugiRhDSyo
	 rMYJH6okEofdyKOF5vuGyIFUVZ6i0d1kJR4tVE53jtkqC4NLbGHQvLQkf0ofUbH0NW
	 bMqXcc8vjmLnA==
Date: Wed, 14 Feb 2024 15:58:27 +0000
From: Conor Dooley <conor@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Support Opensource <support.opensource@diasemi.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Steve Twiss <stwiss.opensource@diasemi.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: dlg,da9063: Make #interrupt-cells
 required
Message-ID: <20240214-divorcee-backside-3a3767d054e9@spud>
References: <2212567f4c17251011e5e0bfa4ea0126d9815d39.1707922672.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DGn9G3gGimok5V3Z"
Content-Disposition: inline
In-Reply-To: <2212567f4c17251011e5e0bfa4ea0126d9815d39.1707922672.git.geert+renesas@glider.be>


--DGn9G3gGimok5V3Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Feb 14, 2024 at 04:03:42PM +0100, Geert Uytterhoeven wrote:
> '#interrupt-cells' is a required property for interrupt providers, hence
> make it required.

I actually meant to send this patch yesterday but I forgot, thanks for
doing it - the only riscv violation of what Rob reported was also a
da9063..

> While at it, move '#interrupt-cells' in the example to match common sort
> order.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I think:
Fixes: 361104b05684 ("dt-bindings: mfd: Convert da9063 to yaml")

and
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/mfd/dlg,da9063.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml b/Docu=
mentation/devicetree/bindings/mfd/dlg,da9063.yaml
> index c5a7e10d7d80e8d7..e5ccc2708f0bb0f8 100644
> --- a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
> +++ b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
> @@ -87,6 +87,7 @@ required:
>    - reg
>    - interrupts
>    - interrupt-controller
> +  - '#interrupt-cells'
> =20
>  additionalProperties: false
> =20
> @@ -99,10 +100,10 @@ examples:
>        pmic@58 {
>          compatible =3D "dlg,da9063";
>          reg =3D <0x58>;
> -        #interrupt-cells =3D <2>;
>          interrupt-parent =3D <&gpio6>;
>          interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
>          interrupt-controller;
> +        #interrupt-cells =3D <2>;
> =20
>          rtc {
>            compatible =3D "dlg,da9063-rtc";
> --=20
> 2.34.1
>=20

--DGn9G3gGimok5V3Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZczjIwAKCRB4tDGHoIJi
0ls2AP9kHzeiP4ColiDDTjA9ec9ni5ouN6qt1khCu44ICoTLAwD/RZ8bWYVG4fFL
TJb0YDw6dvhg1LWXJ9QRXE7GUtt6zgM=
=7Kaf
-----END PGP SIGNATURE-----

--DGn9G3gGimok5V3Z--

