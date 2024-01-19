Return-Path: <linux-kernel+bounces-31361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC755832D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBB31C2410A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BAA53E01;
	Fri, 19 Jan 2024 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwNaC6E6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83841DFCE;
	Fri, 19 Jan 2024 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705681964; cv=none; b=B8kTgOyrf8olHPDrsNf7NGqEpkDehISF9jPda9cbjr5KP7xE7DwZlpO/DC+KbHqREDMGZ1kEceBk2Ctcg2xWhBwWRh+wWif1bBG1l0sNXFJn3LEbkdDYmy7vaWOH6dcTuuKMYPKwfR3iMcxwMMWpDIuir0eh3Ei90s+g2JXbvQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705681964; c=relaxed/simple;
	bh=Uyi+TQxKZEL1bmpstEqg5Fp2tSvzVnztn39cu+KNpTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diOZGM9LcIOsQkNgZqMQecMRrLsmjY8kiK2j2pp1SMrZclTAF6OQDNHksvu2gLrzI9xqh8ox9I+xTZ0q11b3kTMobSbCN6OpfxYgSEtiiNmSXnJcxW46/64/78SPOpa4ftmlZ8qe2m7QPAlFtW5j3Og5wNBzgp2rurOXmh3Z/oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwNaC6E6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47119C433C7;
	Fri, 19 Jan 2024 16:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705681963;
	bh=Uyi+TQxKZEL1bmpstEqg5Fp2tSvzVnztn39cu+KNpTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gwNaC6E6Cwo4i9yG9KcL+67C4UHTf8i7iJ8C0KnIHDMYWmRhaRc8kGrPgwnoHaQ3m
	 qoMU8FXzdXnmyVpEs9vIPr1bTtk/NXSzoZvPB06jMm0dBJ7UJ58Hc3eZbmNJ7jCu/P
	 vRo+l6JjPbmG3JEwYHfEH+nV35saGfHcllxorLDiuCoBoWP4lZ+otMvV8OGYXZ8mu4
	 VDpTK2ccBqS27gqC4hZUAOWhH988jlQnWbVirQQBj7+lKfNEdtxiGU4r2EmMgAMU4H
	 CrsmCk6rMRfPr5XVSqMZf1+66Gd4gP7Oz+bVU5qEZX4XVGdQy9qT+ysr1yLS2y3FQ+
	 xOp3qXwSYiidQ==
Date: Fri, 19 Jan 2024 16:32:37 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, linux@roeck-us.net,
	heikki.krogerus@linux.intel.com, cy_huang@richtek.com,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: mt6360-tcpc: Drop
 interrupt-names
Message-ID: <20240119-eldest-discharge-e2d3812be0a9@spud>
References: <20240119094105.98312-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ToI4F3JwM2kTOdm/"
Content-Disposition: inline
In-Reply-To: <20240119094105.98312-1-angelogioacchino.delregno@collabora.com>


--ToI4F3JwM2kTOdm/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 10:41:04AM +0100, AngeloGioacchino Del Regno wrote:
> This IP has only one interrupt, hence interrupt-names is not necessary
> to have.
> Since there is no user yet, simply remove interrupt-names.

I'm a bit confused chief. Patch 2 in this series removes a user of this
property from a driver, so can you explain how this statement is true?

Maybe I need to drink a few cans of Monster and revisit this patchset?

Thanks,
Conor.

> ---
>  .../devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml        | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.y=
aml b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> index 053264e60583..339bc9c00ac0 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> @@ -22,10 +22,6 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> -  interrupt-names:
> -    items:
> -      - const: PD_IRQB
> -
>    connector:
>      type: object
>      $ref: ../connector/usb-connector.yaml#
> @@ -58,7 +54,6 @@ examples:
>          tcpc {
>            compatible =3D "mediatek,mt6360-tcpc";
>            interrupts-extended =3D <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
> -          interrupt-names =3D "PD_IRQB";
> =20
>            connector {
>              compatible =3D "usb-c-connector";
> --=20
> 2.43.0
>=20

--ToI4F3JwM2kTOdm/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaqkJQAKCRB4tDGHoIJi
0re0AP9LNbikp4X8ttFLgxTITUwV8RZsxGtpIStRXArzEiJQtwD+JNTZjIHT5i09
CSekQiT3QUgqZzXuCTtm+oiY2IL76Ak=
=mjGn
-----END PGP SIGNATURE-----

--ToI4F3JwM2kTOdm/--

