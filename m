Return-Path: <linux-kernel+bounces-22027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBDC829820
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE7028F7FF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D27E41770;
	Wed, 10 Jan 2024 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAUNf7aJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBEA405C3;
	Wed, 10 Jan 2024 10:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CE8C433C7;
	Wed, 10 Jan 2024 10:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704884180;
	bh=xkaWrvfIfP7fZ7XhBOMVv7Q1Juvm5n5GKRa8e8j5ynQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KAUNf7aJLFZZQ90MjJVa5wr0odvvVCP5rWR+DTYfKeWU38ePHYogD6u6vEMzXM+pU
	 PVHcAr3qi6SBD4pN8ssWUab2Ap1A2A/3vMgDMtSQvBVYcVMlMFz9hayZ9r9C6Fdp0q
	 vpLRh4m99k2bMFdc4NkhQijRAkcUeuv4ojSEX8vN2jvk4D7iJAkaFWejbtMIaJW2Cb
	 EfjdbwC9LpctUoW6EoXHkVB0YvfbqF8pNJ12lxbEfcfOVlU5SL/vXc3HqhRWF99Mug
	 4Ne4eKP57irYVyFcgPjgbZ8n3/ZfSXSUQXHx7GuB5C2CHNw231DBMmVFvHZHMWhH+D
	 XE036xOJQDtoQ==
Date: Wed, 10 Jan 2024 10:56:14 +0000
From: Conor Dooley <conor@kernel.org>
To: Chancel Liu <chancel.liu@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
	nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] ASoC: dt-bindings: fsl,micfil: Add compatible string
 for i.MX95 platform
Message-ID: <20240110-petty-tabasco-e8d86a751dea@spud>
References: <20240109075551.870001-1-chancel.liu@nxp.com>
 <20240109075551.870001-4-chancel.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uKeeFUVPvFzJGMuc"
Content-Disposition: inline
In-Reply-To: <20240109075551.870001-4-chancel.liu@nxp.com>


--uKeeFUVPvFzJGMuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 04:55:51PM +0900, Chancel Liu wrote:
> Add compatible string "fsl,imx95-micfil" for i.MX95 platform.
>=20
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,micfil.yaml     | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/fsl,micfil.yaml b/Do=
cumentation/devicetree/bindings/sound/fsl,micfil.yaml
> index b7e605835639..f0d3d11d07d2 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,micfil.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,micfil.yaml
> @@ -15,10 +15,17 @@ description: |
> =20
>  properties:
>    compatible:
> -    enum:
> -      - fsl,imx8mm-micfil
> -      - fsl,imx8mp-micfil
> -      - fsl,imx93-micfil
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,imx95-micfil
> +          - const: fsl,imx93-micfil
> +

> +      - items:

This items is not needed, as the only item in the list is the enum.
You can just do
properties:
  compatible:
    oneOf:
      - items:
          - enum:
              - fsl,imx95-micfil
          - const: fsl,imx93-micfil

      - enum:
          - fsl,imx8mm-micfil
          - fsl,imx8mp-micfil
          - fsl,imx93-micfil

Cheers,
Conor.

> +          - enum:
> +              - fsl,imx8mm-micfil
> +              - fsl,imx8mp-micfil
> +              - fsl,imx93-micfil
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.42.0
>=20

--uKeeFUVPvFzJGMuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ53zgAKCRB4tDGHoIJi
0tn/AP9dcugakMRKRZG/ezh4tXsqNC4Q32/3HPFQMtSa/xVWlwD+JAQQ5q83Q6Xt
RFG9B3BLubQbp2zSeeMNkMv2QI2Hiwg=
=JTpT
-----END PGP SIGNATURE-----

--uKeeFUVPvFzJGMuc--

