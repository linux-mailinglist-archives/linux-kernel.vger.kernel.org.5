Return-Path: <linux-kernel+bounces-19881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE01827614
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357261C2217C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E29154670;
	Mon,  8 Jan 2024 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPgEkzgW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FD05465B;
	Mon,  8 Jan 2024 17:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5890CC433C7;
	Mon,  8 Jan 2024 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704734108;
	bh=HEI/TgbmAB3XO9r4zOP4cLNTWp/NOOlSP9F0hf12S38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPgEkzgW/zBMGUa0n4Q6jtHO8IKGD2oUymWfB9qYdt06Oy6Fm3Ncm03hDwsuzUaN9
	 5TkDtcamE2KiWi4keS0bBAGYyyxJNCJhcYSNl8nTd6Tu5b2QyZuUqfAUvBYn5K8vMm
	 K3rM7mhiXE96OUnD2b0DYW4YWTFLLAQhgcYZIe8ZBRKCfpW6CTd51TgUGgR7i3vOUx
	 insiXIN4rVHNMhI3Bg1/I/lGaWurBK00GN+CQSCb993g4VHPOdvZGnUxWutjkuA83w
	 BCMAogMGCdaS0eWvNybThbXdWB/uUQyr6jWfSnrzVKH1karglCmy7GtquJyL7zWxzw
	 f1hhdi6rhCR/A==
Date: Mon, 8 Jan 2024 17:15:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Elad Nachman <enachman@marvell.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: Add Marvell ac5
Message-ID: <20240108-zoning-tactical-20501dccfac1@spud>
References: <20240107152557.3561341-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6iyG8MMvMc6OIxx2"
Content-Disposition: inline
In-Reply-To: <20240107152557.3561341-1-enachman@marvell.com>


--6iyG8MMvMc6OIxx2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 07, 2024 at 05:25:57PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
>=20
> Add Marvell ac5 device tree bindings to generic EHCI.
> This compatible enables the Marvell Orion platform code
> to properly configure the DMA mask for the Marvell AC5 SOC.
>=20
> Signed-off-by: Elad Nachman <enachman@marvell.com>

Maybe I am dumb, but I don't understand how this does what the commit
message says. There's no fallback to generic-ehci or any other
compatible that is already understood by the driver.

What am I missing?

> ---
>  Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Do=
cumentation/devicetree/bindings/usb/generic-ehci.yaml
> index 87986c45be88..2ed178f16a78 100644
> --- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> +++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> @@ -77,6 +77,7 @@ properties:
>            - const: usb-ehci
>        - enum:
>            - generic-ehci
> +          - marvell,ac5-ehci
>            - marvell,armada-3700-ehci
>            - marvell,orion-ehci
>            - nuvoton,npcm750-ehci
> --=20
> 2.25.1
>=20

--6iyG8MMvMc6OIxx2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZwtlwAKCRB4tDGHoIJi
0nBJAP4o/0qhPq4HtmdsxfHorOUEO80CKUFL3HXLYzUxlZHosAD8DiDNiPaTSdiS
O5zbOzfcM8wJIj8Ig6kekoZkw0HTgg8=
=ikmD
-----END PGP SIGNATURE-----

--6iyG8MMvMc6OIxx2--

