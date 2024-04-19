Return-Path: <linux-kernel+bounces-151554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 491908AB06E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAA67B26A04
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CCF12F5A1;
	Fri, 19 Apr 2024 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOQT4gHK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7342D12DDB0;
	Fri, 19 Apr 2024 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535796; cv=none; b=aYrK+bqJE0xPLNtwlvMtfu01DAsmOd4rgT1d6+OMb51a9cWyqSCACzH2WUyHPVTvcqRQla5Mds7LVeeaAqGwT+FDJiTXdCsc0YpD8NCPiWXawSC2Ly1VFLF2xq03+jmYYiVL1GghojoEjQ+ahCR4m4P7+DNLANRefd7F9ekur9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535796; c=relaxed/simple;
	bh=jehuRMphqfkmVPEQx6BP9BRLXAz3lpdh4pzkarHFts4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0Bj+MZE2XcbWgB1b8Cmqow91WA31fGmRYYqxmQJ3rzLoYTYbSQVualwUny9tWGne4Jf6npUe+sjP2GL7aE+2N2ypugGQXSqXlmqaT0+ZK+MuJV0Zhi9urjg9UKeCyF9s4rCAfZtBbzNebuBuII6Ms9ce9u+TD2VqRQsAZR7Dp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOQT4gHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89E3C072AA;
	Fri, 19 Apr 2024 14:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713535796;
	bh=jehuRMphqfkmVPEQx6BP9BRLXAz3lpdh4pzkarHFts4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOQT4gHKpTFrLdSC660QQWrs1iLZu9MsQ/eKqaGaFCZaS/KrkNRNe9EGDi8hQC5VI
	 6tc6DvjaIo9GW36WK3D+Irw+pFQwsLHBr85C+nZfRNNU82IEOUHIEH8nd1P7GlLsof
	 Hv3oV83Fp09olkZB/fs8cdOppTQGHHvRKePG+k/FcXxTHp3WtllnP2ClZeMrrmkRo6
	 QjWCOcVgjVFlOEeO+npXQzMD3TvBaHAH65SmWK9pMI0tcjGd7sgac6X+s6kT6Tq17k
	 rMxM8Eb6Ve+Gg3ToKz+8JClr7RSvSqf8WQKZvhPua18y61uFyBAYdNcKnS+iJoN3VD
	 mzv5vFbRxyb0w==
Date: Fri, 19 Apr 2024 15:09:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, amadeus@jmu.edu.cn,
	FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Correct the descriptions
 for Radxa boards
Message-ID: <20240419-triumph-cheddar-77fc2f6948b0@spud>
References: <1e148d6cd4486b31b5e7f3824cf6bccf536b74c0.1713457260.git.dsimic@manjaro.org>
 <1888572.CQOukoFCf9@diego>
 <20240418-attach-tigress-bc2b9f844fc7@spud>
 <c3c4a6ad48fbd62b44991c9bfd81570a@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7FkaqVBXtYg+l891"
Content-Disposition: inline
In-Reply-To: <c3c4a6ad48fbd62b44991c9bfd81570a@manjaro.org>


--7FkaqVBXtYg+l891
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 07:12:35PM +0200, Dragan Simic wrote:
> On 2024-04-18 19:04, Conor Dooley wrote:
> > On Thu, Apr 18, 2024 at 06:59:42PM +0200, Heiko St=FCbner wrote:
> > > Am Donnerstag, 18. April 2024, 18:26:19 CEST schrieb Dragan Simic:
> > > > Correct the descriptions of a few Radxa boards, according to the up=
-to-date
> > > > documentation from Radxa and the detailed explanation from Naoki. [=
1]  To sum
> > > > it up, the short naming, as specified by Radxa, is preferred.
> > > >
> > > > [1] https://lore.kernel.org/linux-rockchip/B26C732A4DCEA9B3+282b877=
5-601b-4d4a-a513-4924b7940076@radxa.com/
> > > >
> > > > Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
> > > > Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/rockchip.yaml | 8 ++++----
> > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/=
Documentation/devicetree/bindings/arm/rockchip.yaml
> > > > index fcf7316ecd74..ae58e25c29ec 100644
> > > > --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > > > @@ -767,22 +767,22 @@ properties:
> > > >            - const: radxa,rockpis
> > > >            - const: rockchip,rk3308
> > > >
> > > > -      - description: Radxa Rock2 Square
> > > > +      - description: Radxa Rock 2 Square
> > >=20
> > > I may be just blind, but what changed here?
> >=20
> > There's now a space before the 2.
>=20
> Exactly.  That's part of the Radxa's naming convention, which may be
> seen as somewhat similar to the general rule of spacing out values and
> their associated units, e.g. "2 MB" is in general preferred over "2MB"
> in nearly any kind of a formally correct document.

> As a side note, there's even so-called "half space" as a typographical
> convention for spacing out the values and the associated units.  That
> makes formatted text with such spacing a bit nicer. :)

Let's not introduce half spaces into the bindings though :)

--7FkaqVBXtYg+l891
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiJ7KwAKCRB4tDGHoIJi
0vpdAP9ZWrts28eoF08Ze+LlZQlLraekiKILcD15q9SAIQAwTgD/VjVApPmxTA6L
EaOwHykkUAq7LQocAUirg0/WgMc5pgM=
=gUAd
-----END PGP SIGNATURE-----

--7FkaqVBXtYg+l891--

