Return-Path: <linux-kernel+bounces-155671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1D98AF56F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9616228739E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C215013E3EF;
	Tue, 23 Apr 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+7lX35t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0872713D287;
	Tue, 23 Apr 2024 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893003; cv=none; b=GNQBy6BoygBF+mSVpA35ra3Q8YG3s3vzOHxzb4W5129XQ29g6LcCS2pFYrwNJR4l2eFBe67b5AuwIVPWoIscBBgufNHMDtXANIEppHcVZ4Usp5nTl+WF/LdFKBB6Cq3/1EynMNlxM3127kpLZDjhYlDiQoYC+yG27L+U1DLN0q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893003; c=relaxed/simple;
	bh=LNIkqN117CWF9zanEHE17vB3B3+2CNeQYopVecWmHeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmlwRq9CYnjun7PhdZkpum7kpH5oYTSV4o52Ktj4Jrl1+9g5fR7opMMFUgyKwFWThDxt+sV1CdyL397LjvWzLQCKShCsWylMuqJshDmUYRyEsFh9/99lfRARKOvct1Cx3gjls+drLvRqoOl05977HOUcjAnUT9/gyS6CNfIoVZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+7lX35t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A31C32781;
	Tue, 23 Apr 2024 17:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713893002;
	bh=LNIkqN117CWF9zanEHE17vB3B3+2CNeQYopVecWmHeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+7lX35tQMnGBj2ewu8z9oSTSqQeMf4Seo+ZmZnUCWoxo3+DKcsB53gBYHpLMvwWp
	 1f8cAUpA3BJumfz2r+/t76yvkeczbcgQMKttml0pqszh9gjC6crKVL0yCNE5MvnKzp
	 hpzBvnS+fQ2QH7NOxG0lcJ8/7ei/uXlcqegV6iZly+dnoSD6FnVJHV6ghMAIrFofWo
	 LRfmFT9uzdiD+Vyb8ElaS5D0+SUiIopFBKaaFGJgmczqN0Tn9rwuygOnVQDrquVbUE
	 NnXHoOqegvoiCOYeroGp0zqdUUlyW6zL2D7NuORkLauwS8UXdt9hjqnC6IsTUzL6tk
	 O8ONK1DpjAfuw==
Date: Tue, 23 Apr 2024 18:23:16 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vaishnav Achath <vaishnav.a@ti.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: (subset) [PATCH v3 0/9] spi: cadence-qspi: add Mobileye EyeQ5
 support
Message-ID: <20240423-epidemic-schedule-6fa9869b3e87@spud>
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
 <171283699002.32012.7629247540689477794.b4-ty@kernel.org>
 <D0QT350IJHFH.36EXE1UT9QM10@bootlin.com>
 <ZidAefc0Ejrklopf@finisterre.sirena.org.uk>
 <D0RF1AKWAEAE.44N64GHMV2ZY@bootlin.com>
 <3f891794-0083-4245-bad7-518b1c48bb7c@linaro.org>
 <D0RIXN4JG6ZA.4W4HN68M9U6I@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dLUQzGTCWgy5qnxs"
Content-Disposition: inline
In-Reply-To: <D0RIXN4JG6ZA.4W4HN68M9U6I@bootlin.com>


--dLUQzGTCWgy5qnxs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 03:08:05PM +0200, Th=E9o Lebrun wrote:
> Hello,
>=20
> On Tue Apr 23, 2024 at 12:25 PM CEST, Krzysztof Kozlowski wrote:
> > On 23/04/2024 12:04, Th=E9o Lebrun wrote:
> > > Hello,
> > >=20
> > > On Tue Apr 23, 2024 at 7:00 AM CEST, Mark Brown wrote:
> > >> On Mon, Apr 22, 2024 at 06:52:47PM +0200, Th=E9o Lebrun wrote:
> > >>> All commits tagged "(no commit info)" do not show up in your for-ne=
xt
> > >>> branch. Is that expected and is there anything I can do? There was =
one
> > >>> pending -Wunused-variable compiler warning to be addressed for
> > >>> example, see [0].
> > >>
> > >> Please submit any patches you'd like to see included.  If there were
> > >> outstanding issues that need fixing then fixing those prior to
> > >> submitting would be sensible.
> > >=20
> > > Seeing "Applied" followed by a list of commits, with some of those not
> > > being applied confused me.
> >
> > That's a standard output of b4 and maybe also Patchwork, if some parts
> > are applied.
>=20
> Thanks for the pointer. I've created an issue over at b4 to see what
> people think about this matter. Current behavior is not intuitive as a
> young contributor.

FWIW, given I see `having a more confident comment such as
"(commit not applied)".` there, having (no commit info) doesn't mean
that it wasn't applied always. Sometimes I've found that due to changes
in the patch b4 could not detect that it was applied and reported (no
commit info).

--dLUQzGTCWgy5qnxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZifuhAAKCRB4tDGHoIJi
0l7bAQDnzDqSfwWn/wDBsIvN00NjQAGOFccnLtQcSDf6yj2z1gEA+DyINGJ3YxOM
oaJn81egHe6ayRZEwloZJ8SXlXa8mgI=
=nkkg
-----END PGP SIGNATURE-----

--dLUQzGTCWgy5qnxs--

