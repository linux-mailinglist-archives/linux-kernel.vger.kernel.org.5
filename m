Return-Path: <linux-kernel+bounces-153657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C908AD13B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5CB2864BA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D289A15381B;
	Mon, 22 Apr 2024 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgjCnklg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20753153593;
	Mon, 22 Apr 2024 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800904; cv=none; b=NhVkRQGbQLSA1dZbqnN+2f1AzGFWhTjs0b5Sx29voVmohjB4wW+zMNHLTky5QGigVrogn+TWPXc61+6s/lHJ87XbVrzqDPwAYvnu6G3vdOQ4l4EFJKEM4Ffj1NyzMto6mucVSb9d4BPoWEQJ/+ESD28VJoYil3w5GsTYQf3NP9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800904; c=relaxed/simple;
	bh=yS3et5KtSE2K7X6n3Q2wjbu/zRQrV/F4KQrzw6b31u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxD63a0lvugATnjwKm/CmTOSNllYP4jTBIqvoeyIDzv51X42DEJt741kZHMQT+Bj6mhSNDZrrHL2Nh340aSLy4jl7QgJJO7rUizjdbYCzocp4+xg1ISqjupBs0/Kjv6FZVCkbz8f+dFZhVIwLWqhrpib1H7e7tTYYZ28510WClQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgjCnklg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B62FC32781;
	Mon, 22 Apr 2024 15:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713800904;
	bh=yS3et5KtSE2K7X6n3Q2wjbu/zRQrV/F4KQrzw6b31u4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RgjCnklgYaSbKbvGcc2cCK8DHnWlqiPeF1QeUNGG3vwTDEk/UafMgGpR35Bx7w7QQ
	 52Wza4+zfYqKmLEKpArYD9tN0zIUyZwLGSa1eyidcgaLa4MmbxIhET0T2yeZ92Lt3d
	 BFXg3PpotmcFegtlYeIoX1jthUKSeYT86LIu0ZDny+MsQ+R0wvjb6o7VLu/HZ0/3Zg
	 IC/xX5mLxXDPOYzuyrsx2MqDN6g1mKdtk687dSxBlW63aC+0sqf7itPPWCjG/PgcJo
	 jsy0vZq3bi6rGClbCxjDjJPWY/xxT/omeYWt3FGoe6FWPfO/OsZxyGeBCW7pXgaMrT
	 EolRNmoAjBbaQ==
Date: Mon, 22 Apr 2024 16:48:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/1] dt-bindings: interrupt-controller: fsl,irqsteer:
 Add imx8qxp support
Message-ID: <20240422-channel-emission-d485dee6ae48@spud>
References: <20240422064949.70778-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cwoDUL3Q+X8/OOYa"
Content-Disposition: inline
In-Reply-To: <20240422064949.70778-1-alexander.stein@ew.tq-group.com>


--cwoDUL3Q+X8/OOYa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 08:49:49AM +0200, Alexander Stein wrote:
> Some SoC like i.MX8QXP use a power-domain for this IP. Add a SoC-specific
> compatible, which also requires a power-domain.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Thanks for the feedback.
>=20
> Changes in v3:
> * Move 'allOf' before 'additionalProperties'
> * Remove superfluous 'minItems: 1'
>=20
>  .../interrupt-controller/fsl,irqsteer.yaml      | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,i=
rqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,i=
rqsteer.yaml
> index 20ad4ad82ad64..3d33b75d6ecfa 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer=
=2Eyaml
> @@ -14,7 +14,9 @@ properties:
>      oneOf:
>        - const: fsl,imx-irqsteer
>        - items:
> -          - const: fsl,imx8m-irqsteer
> +          - enum:
> +              - fsl,imx8m-irqsteer
> +              - fsl,imx8qxp-irqsteer
>            - const: fsl,imx-irqsteer
> =20
>    reg:
> @@ -42,6 +44,9 @@ properties:
>    clock-names:
>      const: ipg
> =20
> +  power-domains:
> +    maxItems: 1
> +
>    interrupt-controller: true
> =20
>    "#interrupt-cells":
> @@ -70,6 +75,16 @@ required:
>    - fsl,channel
>    - fsl,num-irqs
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8qxp-irqsteer
> +    then:
> +      required:
> +        - power-domains

Provided the power domains are optional on the existing platforms,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
otherwise,
else:
  properties:
    power-domains: false

Cheers,
Conor.

> +
>  additionalProperties: false
> =20
>  examples:
> --=20
> 2.34.1
>=20

--cwoDUL3Q+X8/OOYa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiaGxAAKCRB4tDGHoIJi
0ljpAQCpp9Iw3VLIDdfXFjPlSOS7/ujkW6weU98urQDmwD9FZwD/Q9aTwbKunV32
4LDLeaO+00Gg4CG//YU92oFBHMiXaA4=
=4im4
-----END PGP SIGNATURE-----

--cwoDUL3Q+X8/OOYa--

