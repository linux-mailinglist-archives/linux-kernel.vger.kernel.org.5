Return-Path: <linux-kernel+bounces-75346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE3785E6F7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09145288B77
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D67285959;
	Wed, 21 Feb 2024 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzOGdq3y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA49D1097B;
	Wed, 21 Feb 2024 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708542645; cv=none; b=j/miPX/O60sh3smPAKEcvF3mvhHGaz3Arg56hjh9xvOslBHVcV1F++lvkDf6TdSHiJDe4vbCybw+FIUVcx/jMFRT6KxMHM2i6dR+k2I+DoAjPYP+Bc2o0ZtT0zc2wiqKmB8TdHhZIiyCqgiz5mz6Z0fBLZ+WUz9QzSpeAEdND7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708542645; c=relaxed/simple;
	bh=/M7TPMT/PgzbB4ehLxeVyg29RzS0Guc+B3bAov1XaN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfcIrvZdUCbVgYHZrcAoB34Y/PbvGQPhlUpzeO42zHuXDatqwD7zg7ss+FSQ6VQzNb7ndYdL5OJd1YR1bm1NNObmMtH5QAYL74wyjttBLwS8R8h+fkccMrHQiOQ0kSj75y//5T8/jRl5ru+2qV9MGUlWWeKBswMPUBuE1unVZkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzOGdq3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8A9C433C7;
	Wed, 21 Feb 2024 19:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708542645;
	bh=/M7TPMT/PgzbB4ehLxeVyg29RzS0Guc+B3bAov1XaN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FzOGdq3yQkkvKtdfcFu6MiRtvxRkTX7itvbAUFURCQepGqZeMmM5vk5yKd5o0GlKF
	 HEy/+L77sz1vzn43++e/6qOYr+iTIb2GB7D4dJRYKcNfWidxNkcAi3TDz32wHGGMY1
	 QtMMQbsQcF5ieVK4WdgDgztmQNTHBjeY8GK1LHwG3w8WQ3eqthhLJY4Rb8hT5i29H9
	 mI54gdvdlucrwANISzOjA0zTfV8YBHx+GgdLv59Q8Lq+gJ1SeJM3OYHYh4OKr05Fwt
	 aL0VFb9Xth4FpuSRDdk3qLZuSb5fQsa1d21Hwjs+Mx7HW12Y4CRSG4J0/hDQbI+RCQ
	 hgTpf8SgghpPQ==
Date: Wed, 21 Feb 2024 19:10:40 +0000
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: Add missing prefixes used
 in compatibles
Message-ID: <20240221-haphazard-nerd-e12e45f9495c@spud>
References: <20240216025839.902288-1-robh@kernel.org>
 <20240216-percolate-wooing-b5e4f6814d15@wendy>
 <20240220163845.GA3606739-robh@kernel.org>
 <20240220-colonial-shame-e217e4399184@spud>
 <20240221150303.GA2792906-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ky3yF72IJF/c8h0h"
Content-Disposition: inline
In-Reply-To: <20240221150303.GA2792906-robh@kernel.org>


--Ky3yF72IJF/c8h0h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 08:03:03AM -0700, Rob Herring wrote:
> On Tue, Feb 20, 2024 at 05:51:37PM +0000, Conor Dooley wrote:
> > On Tue, Feb 20, 2024 at 09:38:45AM -0700, Rob Herring wrote:
> > > On Fri, Feb 16, 2024 at 08:59:56AM +0000, Conor Dooley wrote:
> > > > On Thu, Feb 15, 2024 at 08:58:29PM -0600, Rob Herring wrote:
> > > > > +  "^calao,.*":
> > > > > +    description: CALAO Systems SAS
> > > > >    "^calaosystems,.*":
> > > > >      description: CALAO Systems SAS
> > > >=20
> > > > > +  "^IBM,.*":
> > > > > +    description: International Business Machines (IBM)
> > > > >    "^ibm,.*":
> > > > >      description: International Business Machines (IBM)
> > > >=20
> > > > These ones add duplicates with no indication of which one is to be =
used
> > > > going forward. Why not mark one as deprecated?
> > >=20
> > > Because I couldn't decide which... It's a mixture with no clear patte=
rn=20
> > > of on what or when each one is used. Power is kind of special.
> >=20
> >  That might be true for ibm, but is it true for calao systems?
> >  The website appears to now be something to do with Korean gambling, but
> >  the twitter remains and looks to have produced arm sbcs:
> >  https://twitter.com/calaosystems?lang=3Den
>=20
> I used this:
>=20
> https://en.wikipedia.org/wiki/Calao_Systems
>=20
> The company went bankrupt in 2016.

Yah. I found the twitter to provide more info about the type of chips
they used than wikipedia though, since I was trying to confirm whether
or not they were power.

> ST based systems used one prefix and=20
> Atmel based systems used the other. Which do I pick to deprecate? I'm=20
> not expecting any new boards either.=20

I guess, if nothing new will show up since the company itself got
deprecated, it doesn;t really matter.

--Ky3yF72IJF/c8h0h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdZKsAAKCRB4tDGHoIJi
0jMhAQDEDXZsA/69hMcZwPFP2BQQgEwLnp61XZn4VQTeZdtgxgEAvbhJz+IpWQG4
cX1FnrKgy+mvhWcJT1tDe9If7Vtj8AA=
=K318
-----END PGP SIGNATURE-----

--Ky3yF72IJF/c8h0h--

