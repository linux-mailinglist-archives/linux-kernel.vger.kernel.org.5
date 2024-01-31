Return-Path: <linux-kernel+bounces-46752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FAD84439C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646EC1C21BDC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6777712AAC5;
	Wed, 31 Jan 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XY2j0Cy8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E76863C7;
	Wed, 31 Jan 2024 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716956; cv=none; b=SHAHM1YdI90WQMEWOaKfY6aWqiSbxY+7jSE8S/+URqxJxp5w/HTdgLJe+UC/bYgAdwKVrjYar6GnEGwS5787jJtbWTNnQmmrgtG44AYUx8lIWoDaAP8ScqaMqDCpgmI8R/12oprM8/+q7hA+JG7sbnQINq9I/cNEgQwZZpzt2cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716956; c=relaxed/simple;
	bh=HmXW4tGQocf1z+ydcJUxWRzbrwia64r2xWQAI38E4vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unTXxF+4p3PwCGob45aY/lpVR65t8tM0Cwfff9fK6/nJ+QdFGf+hnJJNnOC5l6orFYzornovREtNu2d26k2PkvjUyrzaT9I7TqGUEA2rvyEls0vFgbEgmxYYtoZaodXX1SDGhqyrMxR3SQGf059qTS98K6/gRYP1RznwjYGiDxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XY2j0Cy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A746FC433F1;
	Wed, 31 Jan 2024 16:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706716956;
	bh=HmXW4tGQocf1z+ydcJUxWRzbrwia64r2xWQAI38E4vA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XY2j0Cy8fFRjX4VNcB1dYJVAZw1NFpBjebGKyKBOb5pVTmI9GSD/BE70NRtQ3A6a6
	 noR4e9EZxMrKUXIS4TgFuYqk+fpmB4VLVnTWmGjmCNvjTGOGPcKuWmuYD9yfrvvT3W
	 LrlTnOm9bEjTZDVnJR/RdgCKUawTvJ+fvMrQ9U+5H549fkMsYhzC1mzZNDOdTcGsUB
	 jMa77pCZiPSqV4Ndipg6z6ECmpXZXhdH9ttgtDvlcx1nQyESn6pl5mSXyog5RY3u4k
	 +WjmIujHY73OWo7bGz5y+cg3fl+vfNf9J3czHSHM/92zBVZ3BW94qUNe0L51jF1Fbz
	 0hRLElfSeSzNg==
Date: Wed, 31 Jan 2024 16:02:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Svyatoslav <clamor95@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	Maxim Schwalm <maxim.schwalm@gmail.com>, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: vendor-prefixes: add LG Electronics,
 Inc. prefix
Message-ID: <20240131-tractor-roundish-f6f90b5bd640@spud>
References: <20240131105153.8070-1-clamor95@gmail.com>
 <20240131105153.8070-2-clamor95@gmail.com>
 <20240131-elderly-passover-341b89f65189@spud>
 <656FDD69-D7B1-4910-B848-108CB985AAAC@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3SIj/8VFafT1NS0u"
Content-Disposition: inline
In-Reply-To: <656FDD69-D7B1-4910-B848-108CB985AAAC@gmail.com>


--3SIj/8VFafT1NS0u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 05:30:58PM +0200, Svyatoslav wrote:
>=20
>=20
> 31 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80. 17:28:49 GMT+02:00=
, Conor Dooley <conor@kernel.org> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=B2(-=D0=BB=D0=B0):
> >On Wed, Jan 31, 2024 at 12:51:50PM +0200, Svyatoslav Ryhel wrote:
> >> Add missing LG Electronics, Inc. prefix used by some older devices.
> >
> >Is it? You're only adding these devices now as far as I can see.
> >
>=20
> Hammerhead (LG Nexus 5)

I have absolutely no idea what this means. Please link me the in-tree
devicetree of the user (or the patchset adding it).

Thanks,
Conor

>=20
> >>=20
> >> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >> ---
> >>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>=20
> >> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/=
Documentation/devicetree/bindings/vendor-prefixes.yaml
> >> index 309b94c328c8..b94ac977acb5 100644
> >> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> >> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> >> @@ -767,6 +767,8 @@ patternProperties:
> >>      description: LG Corporation
> >>    "^lgphilips,.*":
> >>      description: LG Display
> >> +  "^lge,.*":
> >> +    description: LG Electronics, Inc.
> >>    "^libretech,.*":
> >>      description: Shenzhen Libre Technology Co., Ltd
> >>    "^licheepi,.*":
> >> --=20
> >> 2.40.1
> >>=20

--3SIj/8VFafT1NS0u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbpvFwAKCRB4tDGHoIJi
0io6AQDUUiS28tI1AtCx1BRJ24LA3U0tyfW03dp4JBpSketEIQEAoDIZ6BXXNO5z
6cV9vyWKy+veCB6BmMWNgQ/aXswWQAM=
=dD8z
-----END PGP SIGNATURE-----

--3SIj/8VFafT1NS0u--

