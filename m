Return-Path: <linux-kernel+bounces-73468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3817D85C2FD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30901F21B14
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C956377637;
	Tue, 20 Feb 2024 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tr49YR9j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A50E56757;
	Tue, 20 Feb 2024 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451502; cv=none; b=tqMuPLtK0pxtdvLnAF602qtAYdE/XJkDXOQ/d+lAK1YG0b1gpKZUwFUuWjkl1aH3d9h60imxmmznkcwrHqH6+IHFHCI3mPM6qKR7Gcv79fgAqU91Is7A3JVq6I6MCN4nGhn/FfF/U81R51/fxSVmkMIZM21Y52ToVqS1C7iK73c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451502; c=relaxed/simple;
	bh=ipWP10K/HfpSzlfSlOZDuLMC0hDifnL7binX1XavI0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbGi/uqVfznzuewdDfx1NnillmXzOh3+TNaZqmnZbdoZvRkB7OxchPMpDShlwI5g4vVGtiaWeuCCi50fPeIyggfpHyHG/ITyiuW4j0Pce53OFBWd8mGSS+2Gpr9NynLaNuBBJRtDvJcFsRGwoVdv/Alqmgxala0ObOatRw7v9sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tr49YR9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37321C433F1;
	Tue, 20 Feb 2024 17:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708451501;
	bh=ipWP10K/HfpSzlfSlOZDuLMC0hDifnL7binX1XavI0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tr49YR9jVQpw7hn4LgYtdl0jKYVmEpAXdseUslXBDmkRPTa8j0Wm6tPWjZVeB2fkA
	 AATlfsNlVCWZub1gVP1Kx6nTbvM0+crcisFsso9Vfw3YgqhIvPVabJ+/eZeQFQlCcZ
	 Hj3cIXvlZf+qhwKVg4Tn1d7lHY1ZvyCziKeNal9f7OGYvTpjV93Ax+8Ofw/5TrQLi8
	 5O/QPfisrGyw7C47RrVBM4sQidCJsfpuc3hKTYUpKZXFwF+y+By8OXVpEcgmZfwzgV
	 Fy2aRUwWu5g+I0WgZeMw6e4VqxZShzYTr/rVEzAZ8Zk1QEQllIZFZF/L0sPIa3ik8y
	 0jJy6WWWRKWWQ==
Date: Tue, 20 Feb 2024 17:51:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: Add missing prefixes used
 in compatibles
Message-ID: <20240220-colonial-shame-e217e4399184@spud>
References: <20240216025839.902288-1-robh@kernel.org>
 <20240216-percolate-wooing-b5e4f6814d15@wendy>
 <20240220163845.GA3606739-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Op5Lv64OwLhiFXti"
Content-Disposition: inline
In-Reply-To: <20240220163845.GA3606739-robh@kernel.org>


--Op5Lv64OwLhiFXti
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 09:38:45AM -0700, Rob Herring wrote:
> On Fri, Feb 16, 2024 at 08:59:56AM +0000, Conor Dooley wrote:
> > On Thu, Feb 15, 2024 at 08:58:29PM -0600, Rob Herring wrote:
> > > +  "^calao,.*":
> > > +    description: CALAO Systems SAS
> > >    "^calaosystems,.*":
> > >      description: CALAO Systems SAS
> >=20
> > > +  "^IBM,.*":
> > > +    description: International Business Machines (IBM)
> > >    "^ibm,.*":
> > >      description: International Business Machines (IBM)
> >=20
> > These ones add duplicates with no indication of which one is to be used
> > going forward. Why not mark one as deprecated?
>=20
> Because I couldn't decide which... It's a mixture with no clear pattern=
=20
> of on what or when each one is used. Power is kind of special.

 That might be true for ibm, but is it true for calao systems?
 The website appears to now be something to do with Korean gambling, but
 the twitter remains and looks to have produced arm sbcs:
 https://twitter.com/calaosystems?lang=3Den


--Op5Lv64OwLhiFXti
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdTmqQAKCRB4tDGHoIJi
0rK9AP9UPY2lpoQmDV8rySqGu4D55Bl//O7Iy08Nq5mymAk9HwD/ShHiNt3QSh9C
CtkHeVxAhCDsc7v36fa08UvSAk/uOAo=
=VlKx
-----END PGP SIGNATURE-----

--Op5Lv64OwLhiFXti--

