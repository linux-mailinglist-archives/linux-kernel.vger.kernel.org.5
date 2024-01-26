Return-Path: <linux-kernel+bounces-40323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E09EB83DE81
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D48C28738F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F94E1DA24;
	Fri, 26 Jan 2024 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzCEpfep"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13061CD3F;
	Fri, 26 Jan 2024 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286022; cv=none; b=eTiIh4wrGkpX2rUpRk5uHpX5zzel72spq5TuyokKhXReNjZ0usl7bun+G+muna4Nvvge2j1FbgSHSsaQHR9o6cqroTsNJxw0x7N9RDnQH1eKV730YCiJfTXA/KWWgH88Nom7KWMpB/xEHryvigIraQ0a/polVTpUYqSWtw8wzWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286022; c=relaxed/simple;
	bh=Bg4FEqSmu/zlJ81s2vYzsOyYu9m8XO/urPWpfBFydT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUEZH7Cd7GWaAI5LDshobv62bDEdAdLC8bPvbkDIgiyHoj2pz08VgHsxWe8GVGgsjN9AsgRd/O2czdgRth3pbrwtZ/LGsc6fYtzYshVIh1pHPAm300Y98Vy3jib1KN0KyAoGUZmFpYiQDYNfy++YCpvXcRE9Yovwew9S4x9INo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzCEpfep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41235C433F1;
	Fri, 26 Jan 2024 16:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706286022;
	bh=Bg4FEqSmu/zlJ81s2vYzsOyYu9m8XO/urPWpfBFydT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kzCEpfep/SR6iB7ACMgLPn0tku02mUlmxJyoz56wZ0Y+xhSjGKHZkFKpCqh72K3wB
	 g4UOsmdt9Hkscql0kYrcSM9e3YLr8xWCivpLCT+5ILfS7fsJwAkluJSCceLFlnCfO1
	 cBpCODNhi0d9I0CjqHc2IaubUIA7qiZjs4nr/ZQfHahrO3LeKcaIjT+uzR81jYzjw3
	 K2gpat3abPj2AH8x41kr5yha2+xzMgQuXfRShyAQ0CrNBEU86ub8X3yLtmm2ab1vau
	 ME8ZUYuryfj1Zm3Y6cFhPa7XsjSNA/VUE8Bm54ErHvmYOz7315gb5xKx3Hrmj1F3m+
	 QIybEEtcKCRWQ==
Date: Fri, 26 Jan 2024 16:20:18 +0000
From: Conor Dooley <conor@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	mazziesaccount@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: Add regulator-compatible property
Message-ID: <20240126-deflate-ashy-158a91efb25a@spud>
References: <20240126114614.1424592-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lQRYenakLFWQ8EtE"
Content-Disposition: inline
In-Reply-To: <20240126114614.1424592-1-naresh.solanki@9elements.com>


--lQRYenakLFWQ8EtE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 05:16:14PM +0530, Naresh Solanki wrote:
> Add regulator-compatible property.

Why? I can see that this is what you did, but there's no justification
for it.

grepping for this property, the first thing I see is:
rg "regulator-compatible"
drivers/regulator/of_regulator.c
389: * based on either the deprecated property regulator-compatible if pres=
ent,
428:					"regulator-compatible", NULL);
486:		name =3D of_get_property(child, "regulator-compatible", NULL);


The property is deprecated, so you'll need twice as good a justification
for adding it!

> Also update example.
>=20
> TEST=3DRun below command & make sure there is no error
> make DT_CHECKER_FLAGS=3D-m dt_binding_check

Same comment here as my other mail.

Thanks,
Conor.

>=20
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
>  Documentation/devicetree/bindings/mfd/maxim,max5970.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/D=
ocumentation/devicetree/bindings/mfd/maxim,max5970.yaml
> index 0da5cae3852e..75175098cbc2 100644
> --- a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> @@ -74,6 +74,9 @@ properties:
>              description: |
>                The value of current sense resistor in microohms.
> =20
> +          regulator-compatible:
> +            pattern: "^SW[0-1]$"
> +
>          required:
>            - shunt-resistor-micro-ohms
> =20
> @@ -111,6 +114,8 @@ examples:
> =20
>              regulators {
>                  sw0_ref_0: sw0 {
> +                    regulator-compatible =3D "SW0";
> +                    regulator-name =3D "p5v";
>                      shunt-resistor-micro-ohms =3D <12000>;
>                  };
>              };
> @@ -145,9 +150,13 @@ examples:
> =20
>              regulators {
>                  sw0_ref_1: sw0 {
> +                    regulator-compatible =3D "SW0";
> +                    regulator-name =3D "p5v_aux";
>                      shunt-resistor-micro-ohms =3D <12000>;
>                  };
>                  sw1_ref_1: sw1 {
> +                    regulator-compatible =3D "SW1";
> +                    regulator-name =3D "p3v3_aux";
>                      shunt-resistor-micro-ohms =3D <10000>;
>                  };
>              };
>=20
> base-commit: ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7
> --=20
> 2.42.0
>=20

--lQRYenakLFWQ8EtE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbPbwQAKCRB4tDGHoIJi
0mphAP9mNAqgCfGnG2oZT03eR5lo8zVtxGVA3e31U4pT35l3oAEAmSR0t82lnGuR
Ko9mPTkVro5PyNGNvBvn9QwRTqP8qAc=
=FJF6
-----END PGP SIGNATURE-----

--lQRYenakLFWQ8EtE--

