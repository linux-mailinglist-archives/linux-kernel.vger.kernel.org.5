Return-Path: <linux-kernel+bounces-62192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F11CF851CDB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DC91F22057
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ECB3FE36;
	Mon, 12 Feb 2024 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWcM4sGb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E9C3DB91;
	Mon, 12 Feb 2024 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762795; cv=none; b=YX7xkJYmwXVAtk7R3rzoBJgsBZrVMomEX93pf/UKeuBilpuWjLiqz4G364jTza7YOifJOleps2yBOELNVH096nYyM1tgGwRGpBW3KRwJhJZY2ZHtMR1ohJsI2TB7ULng28+BruE3XAkbiNPzJvTG+eb55Qd3UMfmoKUAELueguY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762795; c=relaxed/simple;
	bh=DTRybV3KMIhH9nFsPr7JEPKWMu1YNivRlPVO0kxFIiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhLGF37G8GmRrsIYEVqc7Ys9nafNJDW63d6/wx3Pjbtj1IUGJNF3cNn+Lq8PgP6PFzqqsCAnNHPk9J3wMSdon+7dZ4g8lZLMaaf/Wau167D34sVYC7/5w1jXEAElF2vo5jddK+JAhk1wyyAfpY+s2zbBLz0GncT9M5Xu30htCCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWcM4sGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052C8C433C7;
	Mon, 12 Feb 2024 18:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707762794;
	bh=DTRybV3KMIhH9nFsPr7JEPKWMu1YNivRlPVO0kxFIiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWcM4sGbpiBnCAUBh2PddGbGin4HS+JBNofityp2fupukmpyHsOs7EiAa+B8FaxoX
	 umxolyJDbeqDhf0mToD38sZ/Pof6zsgMByK1YBv5MxdJznwH8T5wGKTbb5ln5TMjgo
	 D0octNIsY6GRkNtS7TFkPdY6NZhiV+nwR+WAtBPmVwOZgm8J5XaNnqE9sxh4JLWgUS
	 m+gNn47PiYAgVwl/gYwF5CIq4OrjuYrgmgtdeqed3+Rm/9aDDrzgNj9tIDj9alXKIJ
	 o35hE/mqajrE7UxjmxYgZ7dPgskafzSutk1vYx7F+sM1QaLRuAp0irh2bA2bSYnH/0
	 StDyTiQv8O6OA==
Date: Mon, 12 Feb 2024 18:33:09 +0000
From: Conor Dooley <conor@kernel.org>
To: Christophe Kerello <christophe.kerello@foss.st.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org,
	Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: Re: [PATCH 02/12] dt-bindings: memory-controller: st,stm32: add
 'power-domains' property
Message-ID: <20240212-chemicals-skinny-18eda1cfe781@spud>
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
 <20240212174822.77734-3-christophe.kerello@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j0T5UxTZF6zrutiv"
Content-Disposition: inline
In-Reply-To: <20240212174822.77734-3-christophe.kerello@foss.st.com>


--j0T5UxTZF6zrutiv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 06:48:12PM +0100, Christophe Kerello wrote:
> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>=20
> On STM32MP25 SOC, STM32 FMC2 memory controller is in a power domain.
> Allow a single 'power-domains' entry for STM32 FMC2.

This should be squashed with patch 1, since they both modify the same
file and this power-domain is part of the addition of mp25 support.

If the mp1 doesn't have power domains, shouldn't you constrain the
property to mp25 only?

Cheers,
Conor.

>=20
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> ---
>  .../bindings/memory-controllers/st,stm32-fmc2-ebi.yaml         | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/memory-controllers/st,stm3=
2-fmc2-ebi.yaml b/Documentation/devicetree/bindings/memory-controllers/st,s=
tm32-fmc2-ebi.yaml
> index 12e6afeceffd..84ac6f50a6fc 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-=
ebi.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-=
ebi.yaml
> @@ -36,6 +36,9 @@ properties:
>    resets:
>      maxItems: 1
> =20
> +  power-domains:
> +    maxItems: 1
> +
>    "#address-cells":
>      const: 2
> =20
> --=20
> 2.25.1
>=20

--j0T5UxTZF6zrutiv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcpkZQAKCRB4tDGHoIJi
0tdKAQDHXMMk62WtYxljI4EYVK5zcDC6VAMJ9PBRjLb5XKG6fAD9FkStE7CE4iEM
IAf7Cd+5U9DpPVQ7o7X7sfH21yTKLAk=
=tk2s
-----END PGP SIGNATURE-----

--j0T5UxTZF6zrutiv--

