Return-Path: <linux-kernel+bounces-150538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4338AA0B8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6E81C21FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A92171E57;
	Thu, 18 Apr 2024 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGleHP28"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A708C11CA0;
	Thu, 18 Apr 2024 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459889; cv=none; b=SzVNMpEzsjP80Mff3FuTf+8lL/mHo8/Azj0y3VUk1LZjZmebIcm+kuYeD4DAte6nEdYSBDucJPhw7OE1sfZFvI+qAIJP2DySw+WNkKTctKdBxg2Gsyfv6OfwgYUmcj390PcXY6eu/yUCMyOj+/VsSp3Rt/WWt08jUtlaUMUgGvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459889; c=relaxed/simple;
	bh=tj6AIRIe6qwU39FOGgC+CPwx357epYs8KX3g74wdrKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgBRMJ8mJexgDbpRH2kY7f4ZeJ1u0GDlGd1zk3R0nFR0nN54EH86tvL7q2dXi35c1J3j2n/Gup0rwa+Jn84xXifb+kfnhyGMkNe4yxyu4/flv2qaVdzGXSYE9a7FUdPmiQQsyTyvrw/LLK6Xb0Az1Rd0S6yirYAjah+DhaudQ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGleHP28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1642DC113CC;
	Thu, 18 Apr 2024 17:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713459889;
	bh=tj6AIRIe6qwU39FOGgC+CPwx357epYs8KX3g74wdrKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGleHP28tQFI9oxE4S2djdSrPpmg5HRmFGoyz1Gk4AZTgeq7z9rQCYxVIRlZ1VvdP
	 rkqFiJomK7T6Gn0zUEzid3wisTirv7FdT5t+RsHL+5vgpQ1dqg9OMa2S83AnWXtLtk
	 OmSc5o4iQjCMAKWkIOilNPgkxgxabF0qt3rrKZNLYA52IPvKtJOSFWZuk5bXo5X3Ik
	 Iyp+VtYXetJRlKuDhp3g0YTjxOvBMKKaSiAL5V++QpoSkvbcx/legyf49dn+oaXldg
	 qiPHA5fpJhNCNwvLLBbJ6RMfNvawTiqWvyFWb7z8Tcjj0mtopCqVX6uUJC+M2uWmMO
	 03Yw/4e724uuA==
Date: Thu, 18 Apr 2024 18:04:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, Dragan Simic <dsimic@manjaro.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, amadeus@jmu.edu.cn,
	FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Correct the descriptions
 for Radxa boards
Message-ID: <20240418-attach-tigress-bc2b9f844fc7@spud>
References: <1e148d6cd4486b31b5e7f3824cf6bccf536b74c0.1713457260.git.dsimic@manjaro.org>
 <1888572.CQOukoFCf9@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="02Hs9kTs4IKM6O9B"
Content-Disposition: inline
In-Reply-To: <1888572.CQOukoFCf9@diego>


--02Hs9kTs4IKM6O9B
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 06:59:42PM +0200, Heiko St=FCbner wrote:
> Hi Dragan,
>=20
> Am Donnerstag, 18. April 2024, 18:26:19 CEST schrieb Dragan Simic:
> > Correct the descriptions of a few Radxa boards, according to the up-to-=
date
> > documentation from Radxa and the detailed explanation from Naoki. [1]  =
To sum
> > it up, the short naming, as specified by Radxa, is preferred.
> >=20
> > [1] https://lore.kernel.org/linux-rockchip/B26C732A4DCEA9B3+282b8775-60=
1b-4d4a-a513-4924b7940076@radxa.com/
> >=20
> > Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
> > Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> > ---
> >  Documentation/devicetree/bindings/arm/rockchip.yaml | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Docu=
mentation/devicetree/bindings/arm/rockchip.yaml
> > index fcf7316ecd74..ae58e25c29ec 100644
> > --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > @@ -767,22 +767,22 @@ properties:
> >            - const: radxa,rockpis
> >            - const: rockchip,rk3308
> > =20
> > -      - description: Radxa Rock2 Square
> > +      - description: Radxa Rock 2 Square
>=20
> I may be just blind, but what changed here?

There's now a space before the 2.

--02Hs9kTs4IKM6O9B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiFSrAAKCRB4tDGHoIJi
0pWXAP0c5dYS0BG1OOd6YCj4Ksys4ElwAFMWk3mVbj9mzuMwuQD+KN2njS058lPw
Ivic3pq0puZ4LewezAj1/vcYpV1B+Qk=
=b8Sy
-----END PGP SIGNATURE-----

--02Hs9kTs4IKM6O9B--

