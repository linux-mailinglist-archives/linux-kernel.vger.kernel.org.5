Return-Path: <linux-kernel+bounces-30366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D59831DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B3A1C251FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B59D2C6A8;
	Thu, 18 Jan 2024 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3vXm7SF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA78B25639;
	Thu, 18 Jan 2024 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596588; cv=none; b=HtrsdFgE+0I6csVIrVW+nztq7GNatJfjnRqSnmuTICstGq4hgfB2loOhgPCY+m4mAQ0FeBlFNmFqA7NWuzYsdmwDI7UNWw1nlrSVqXsb/Xup5ftpluQowHkF7Fi+7ET26FCln8d97uB50hKeWWOKGgWatvn5wHlWEK+3zSpNqZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596588; c=relaxed/simple;
	bh=MmpcWhyIPObWHmbC8YPoipa9VKgkAwrIBlWa7uylkp0=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=STJlGlffjpB1v0m+13O9QIQOQsVOW3LiIJ+S36paXYzW+Jt3arw3TSjqGTd8POgsIfRbp2MVhqtZRhA9nZR5RIUmb9x6j1dYaGjMeRhLTP37v42VxlpPKLFAW5v+6cSWDfEXhIP7buwodXhSsfLQ0mbo1FOjhjIMfESQbkcCAOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3vXm7SF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEFBC433F1;
	Thu, 18 Jan 2024 16:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705596588;
	bh=MmpcWhyIPObWHmbC8YPoipa9VKgkAwrIBlWa7uylkp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q3vXm7SFr0bHK742KROSU3mZNu/ipoJkrRUYZdE9v/B8A4eQcxj0bH+2NZ7yu0gka
	 CtFjOo46awOM97n1UuvP2HR0bcIlcIAb0+OfUyqouaIS4rAtE4AUZV+t/ULg8xJmg4
	 agjSDcxmcQBkk3gcy+l8fzQOWNBfAwKg8rEBMIGFgyWlbl73CFFj2dwfia/83Kqe1p
	 9+sRB6ZtYQQnzmPfHlQPpeRBylbD0LFtMgaonEk3ALiQ6RbZgnFl7t1yQUI4q3DoR+
	 k6ttFX4k6EnGjZwyfOkZaZJQwzgm43hN2PB4J7lwqqIySUdFuZFIHQFkbq6qyCS0Er
	 U0DZKz3IqLltg==
Date: Thu, 18 Jan 2024 16:49:42 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	Sam Shih <sam.shih@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: reset: mediatek: add MT7988 reset IDs
Message-ID: <20240118-calcium-krypton-3c787b8d1912@spud>
References: <20240117184111.62371-1-linux@fw-web.de>
 <20240117184111.62371-2-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yEppIa8A0Tn1qUHg"
Content-Disposition: inline
In-Reply-To: <20240117184111.62371-2-linux@fw-web.de>


--yEppIa8A0Tn1qUHg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 07:41:10PM +0100, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
>=20
> Add reset constants for using as index in driver and dts.
>=20
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v3:
> - add pcie reset id as suggested by angelo
>=20
> v2:
>  - add missing commit message and SoB
>  - change value of infrareset to 0
> ---
>  include/dt-bindings/reset/mediatek,mt7988-resets.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/include/dt-bindings/reset/mediatek,mt7988-resets.h b/include=
/dt-bindings/reset/mediatek,mt7988-resets.h
> index 493301971367..0eb152889a89 100644
> --- a/include/dt-bindings/reset/mediatek,mt7988-resets.h
> +++ b/include/dt-bindings/reset/mediatek,mt7988-resets.h
> @@ -10,4 +10,10 @@
>  /* ETHWARP resets */
>  #define MT7988_ETHWARP_RST_SWITCH		0
> =20
> +/* INFRA resets */
> +#define MT7988_INFRA_RST0_PEXTP_MAC_SWRST	0
> +#define MT7988_INFRA_RST1_THERM_CTRL_SWRST	1

These are just "random" numbers, why not continue the numbering from the
ETHWARP?

> +
> +
>  #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT7988 */
> +
> --=20
> 2.34.1
>=20

--yEppIa8A0Tn1qUHg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZalWpgAKCRB4tDGHoIJi
0sGUAPsEUtGzFKYVgmTkwZMghZncVYo5cXy3chdsCl1amnypDwEA8ABvcU3y0QS+
LMESXclQSuODjX0VsQAx1cAjuWDNawE=
=092l
-----END PGP SIGNATURE-----

--yEppIa8A0Tn1qUHg--

