Return-Path: <linux-kernel+bounces-60883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBFF850A92
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E721C20DDB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C4C5CDF0;
	Sun, 11 Feb 2024 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO/K+rqJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49565A11C;
	Sun, 11 Feb 2024 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707673006; cv=none; b=jOPwjB6aqe7CcBvzw0LNAiblVB4NCtITOl3HOL8OT+dgpZIU4uD/Slc7eHBcUlZofMRRd+MvyCbnb8bm3b2ctfanlet7+bySlpnWJAeyXy87lhKcRwu8VWVf4vlwVe92xJ2Yordh4TSB70sUkhvc5PKcGNcjaY9gQg26wTrhCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707673006; c=relaxed/simple;
	bh=c9VGEH3Oe3xuX6OuU6L8icH1iRHcqV6VJVjAxeBYb6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPoPHnoTzwKOHI58vDkZkO2eRtVACD0G8ansBFnhJPYChdS8KQSPr/aO+d+vzFR8loxW3kizvJXHT42sjiTnzldv1Dmbsy9tG+pePggVp/XPAfj6PXXFZPGbAYko9DzpX4AT3ag2Uvid8DBS1Igo7GNqfIeCfs/8OvUiqP3bP4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO/K+rqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF80C433C7;
	Sun, 11 Feb 2024 17:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707673005;
	bh=c9VGEH3Oe3xuX6OuU6L8icH1iRHcqV6VJVjAxeBYb6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iO/K+rqJLKRy4abh7+0vArChYtijI8Hy5IyVaGZje+bo2N/wclkoQqIq61avdxnfi
	 3s+t915EY1bt+AOg0czRAjgPa6LOzRZP3liOsOYBRa0Hs/qqHounO2IQ/bhkjln5ha
	 OQU2y7pIcLtRX5DGsC0uwkEDSHRFaiFM48VV8r8HYtGsLJv/d/Lh8WvpLx9SXaEuha
	 WF70ULtQCdDkGLkW7bWH9K+zBH63jyPKq3xiCvyr94k2kQl+NnDa4cEqVXXIw8dSR8
	 7Suphydj0QJfqnvBAJbcWyWvjlV2G104b6BjCL08cc8Y4OyBJwCFeIxH7DUkteQwFY
	 nGnxrRxXGL6Uw==
Date: Sun, 11 Feb 2024 17:36:40 +0000
From: Conor Dooley <conor@kernel.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v1 03/10] dt-bindings: phy: add rockchip usbdp combo phy
 document
Message-ID: <20240211-uproot-awoke-b3c70f168e17@spud>
References: <20240209181831.104687-1-sebastian.reichel@collabora.com>
 <20240209181831.104687-4-sebastian.reichel@collabora.com>
 <3267388.oiGErgHkdL@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y3S4+lww4bcgDsY0"
Content-Disposition: inline
In-Reply-To: <3267388.oiGErgHkdL@diego>


--Y3S4+lww4bcgDsY0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 11:17:40PM +0100, Heiko St=FCbner wrote:
> Am Freitag, 9. Februar 2024, 19:17:19 CET schrieb Sebastian Reichel:

> > +  rockchip,dp-lane-mux:

Why "mux" and not "map"?

> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    minItems: 2
> > +    maxItems: 4
> > +    description:
> > +      An array of physical Tyep-C lanes indexes. Position of an entry =
determines
>=20
> nit: Type-C lane indexes
>=20
> > +      the dp lane index, while the value of an entry indicater physica=
l Type-C lane.
>=20
> nit: indicates instead of indicater?

If we are talking nits, the first use of "dp" should be "DisplayPort (DP)"
and s/dp/DP/ elsewhere.

>=20
> > +      The support dp lanes number are 2 or 4. e.g. for 2 lanes dp lane=
s map, we could
>=20
> nit: The supported dp lane numbers ... ?
>=20
>=20
> > +      have "rockchip,dp-lane-mux =3D <2, 3>;", assuming dp lane0 on Ty=
pe-C phy lane2,
> > +      dp lane1 on Type-C phy lane3. For 4 lanes dp lanes map, we could=
 have
> > +      "rockchip,dp-lane-mux =3D <0, 1, 2, 3>;", assuming dp lane0 on T=
ype-C phy lane0,
> > +      dp lane1 on Type-C phy lane1, dp lane2 on Type-C phy lane2, dp l=
ane3 on Type-C
> > +      phy lane3.

And

> If dp lane map by DisplayPort Alt mode, this property is not need.

"If DP lanes are mapped by" "not needed."

Cheers,
Conor.

--Y3S4+lww4bcgDsY0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZckFqAAKCRB4tDGHoIJi
0mdTAQDyQTT+aO5vXfGBJ344i7lWsxRedOFHbKlJ1OGgglszlwEA4pLizuhJUa9l
cE8jarPeJgs3wrqeqmKQwRLTt0f+BgI=
=Fvfu
-----END PGP SIGNATURE-----

--Y3S4+lww4bcgDsY0--

