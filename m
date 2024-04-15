Return-Path: <linux-kernel+bounces-145482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFBA8A56BC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63EAF1F219FB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD7A7EF09;
	Mon, 15 Apr 2024 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ei46RFry"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0749D4BA94;
	Mon, 15 Apr 2024 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196029; cv=none; b=QSj4ZCi1vHzSB0Ll9Dz8ESSS4jMJQYXmvtu7zSNWDpAGI8DZZFHuHztP/YuHUxNSrOlwXCCg01U6L7k50QYRe41kjAkH2c/xm6gJ4ubJSctBXIO1dtykmVsuD5zEjES9DANQY9wrF6STu5ZcMHTfnDBfVriH0J3Y8h4VrX/jh24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196029; c=relaxed/simple;
	bh=JR5kOuhn6j79YvltFsCGif42+l9e5TDJ19o8bOjza9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLC/hOdQ4ioieE4cTP/2eDaE7Se/9zhVOZxeIQRsF7IeHFPc43f0s4QzHOLYwuNYwpUgB/DPQQyMyHIqXOLjOfoA4dpU1/+imJwxvs+oic0l2ohipkWu4o1LjL/QZdsmolqaVyRRx1MvhYGY7LpHIl3lrIP4PCJOPzZZ2DwLnbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ei46RFry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD380C113CC;
	Mon, 15 Apr 2024 15:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713196028;
	bh=JR5kOuhn6j79YvltFsCGif42+l9e5TDJ19o8bOjza9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ei46RFryurSS2OgOCf8TMAKsirP/Th368+PpU0bWrT274mzvek1tUGigEqinCXXJ7
	 3zSG/+jJKDp+ZflJl0EKSubDAz1I43jffwKxCOrnqJ1GmXhEl4hR+rjSYQHFA+DH/1
	 SOPCz/cXh1el9yxbPlZ2yD/SRjZ16yKVO88b+MA7ALR9AWYmKnaGcdtECDt4E7ylKn
	 gh/ZGj5hq8R/Hprkj1Z5bTaEZkR4FADe0ypxqMhO4i1ZnupT26x0rKzm39sw1MzkzG
	 mXMfR+hkt5Rn/YQQEcNboQekCLPn5Z42UKOMolFTPueirRMVdTM1YHXLd9W9sSTIDp
	 aUjM1wniH/wIA==
Date: Mon, 15 Apr 2024 16:47:02 +0100
From: Conor Dooley <conor@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, xiaoning.wang@nxp.com,
	linux-imx@nxp.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] dt-bindings: net: nxp,dwmac-imx: allow nvmem cells
 property
Message-ID: <20240415-limes-chasing-dbc111fa9cf2@spud>
References: <20240415103621.1644735-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pK2WP0nOkwBGBj1a"
Content-Disposition: inline
In-Reply-To: <20240415103621.1644735-1-peng.fan@oss.nxp.com>


--pK2WP0nOkwBGBj1a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 06:36:21PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Allow nvmem-cells and nvmem-cell-names to get mac_address from onchip
> fuse.

Is this valid for all 3 devices in this binding?

>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml b/D=
ocumentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
> index 4c01cae7c93a..87bc4416eadf 100644
> --- a/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
> +++ b/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
> @@ -66,6 +66,10 @@ properties:
>        Should be phandle/offset pair. The phandle to the syscon node which
>        encompases the GPR register, and the offset of the GPR register.
> =20
> +  nvmem-cells: true
> +
> +  nvmem-cell-names: true
> +
>    snps,rmii_refclk_ext:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
> --=20
> 2.37.1
>=20

--pK2WP0nOkwBGBj1a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh1L9gAKCRB4tDGHoIJi
0jExAQCZWUccqyXVLzL9kdshYI62g/bxsBiJ4y9eArAObwLwnwD7BFR2QeVnNjXE
c7qRz/eFlRTk4Tk6RzO2NmVZECf+AQw=
=PktI
-----END PGP SIGNATURE-----

--pK2WP0nOkwBGBj1a--

