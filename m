Return-Path: <linux-kernel+bounces-58701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8E784EA21
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169782850D7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3514EB4F;
	Thu,  8 Feb 2024 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEEWJJq3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC044C3BB;
	Thu,  8 Feb 2024 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707426675; cv=none; b=sZsXGqZZ8CVGMHaF96Rjic1F8maF039WSWYCT21QKkmUgyI2hJtEV/Jk8KabZ6pWrvByiLUlEYGLk53tLY+Q7KGaRTSqyWIDkxPsGleVYQKMbSsIM1e/HDx8//M/LJI0cn/xGYRyzssWKxpyGr7sAL95K7etV2dtP9RHr7bRpGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707426675; c=relaxed/simple;
	bh=PZdyD0LrD0K6VeVxtDSN2q5d00foFVJLTK20usF3L9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDzjT1jQM7qpUZxq0gMNcSSAl6vrL5gmRxOEScGFC24WNNPsu6MIzXDBwtg4ieDsVCASI0pnccoA35dv79AlFz4BIdzaby+C8CSH+N2+cuQgnP/QkzlS6089gKdWOvv5QBJBfUpddjeMcyfOYQ9+lDsu8QkoL4bW3ROw8XAklIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEEWJJq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E413C433C7;
	Thu,  8 Feb 2024 21:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707426674;
	bh=PZdyD0LrD0K6VeVxtDSN2q5d00foFVJLTK20usF3L9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vEEWJJq3cCGErkhfWDg9g5V4hijQYdVUcVmasjPgUwwsY7Sb1jLzWvYi7LSU7MgCT
	 boQspHdmz4h6dd1VPyUnnWIlUj/SV9rsc0S5xtLVXLb3orhYEtV3r6CSsBozSnHE+K
	 m/RJZFXvjextXsEmH1/+Kjdy8J4EJDMXzS8h5Ave7khd3S4XH3e+Cz56PoK/vvPhGE
	 /vJmTEWkskNFuWe1hNruP8CxYq6O/mzclMa4vm3TdqOm1UWw6WkRdSN4dZAkqbY7+v
	 eqqBsX/R7uwA2pHK/6x4qpgCy0wXuLmh0YDQZVXYC241JDj6GEdCl3y2ac6YhVl3WO
	 hiK7Fh21Swlgw==
Date: Thu, 8 Feb 2024 21:11:10 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 0/2] usb: dwc3: drop 'quirk' suffix at
 snps,host-vbus-glitches-quirk
Message-ID: <20240208-unquote-palace-83edc6220acd@spud>
References: <20240207-vbus-glitch-v1-0-7be87099461d@nxp.com>
 <20240207-settling-drone-90e6f10a3476@spud>
 <ZcQAqVViPHcbgn52@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gFGNovl6LzTY5g9n"
Content-Disposition: inline
In-Reply-To: <ZcQAqVViPHcbgn52@lizhi-Precision-Tower-5810>


--gFGNovl6LzTY5g9n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 05:14:01PM -0500, Frank Li wrote:
> On Wed, Feb 07, 2024 at 10:05:23PM +0000, Conor Dooley wrote:
> > On Wed, Feb 07, 2024 at 05:00:17PM -0500, Frank Li wrote:
> > > Since dt maintainer give comments at old thread
> > > https://lore.kernel.org/linux-usb/20240119213130.3147517-1-Frank.Li@n=
xp.com/
> > >=20
> > > The patch v4 already merged.
> > > https://lore.kernel.org/linux-usb/20240124152525.3910311-1-Frank.Li@n=
xp.com/
> > >=20
> > > So submit new patch to rename snps,host-vbus-glitches-quirk to
> > > snps,host-vbus-glitches to align dt maintainer's comments.
> >=20
> > I thought the last comment left on the v1 was Thinh agreeing that a
> > DT property was not needed here and we should be able to apply this
> > conditionally?
>=20
> I don't think so. This is workaround. We can use this track which chip
> actually need this. If some year later, such chips already end of life.
> We have chance to clear up these code. Otherwise, it will keep there for
> ever.

> And I am not sure that the side effect for other chips. Workaround should
> be applied as less as possible.

I'd rather do it unconditionally if we can, but if you and Thinh think
that we cannot do it unconditionally then sure, keep the property.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--gFGNovl6LzTY5g9n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcVDbgAKCRB4tDGHoIJi
0qt3AP93pO+2o/E4e4mcw2crSVI1VWZ9ULKk/LodlffmniEtPwEA6vo7NqUFkIhi
lbZpkWDt3zzzU2XFUuwB0mOT3A8z2A4=
=xRuh
-----END PGP SIGNATURE-----

--gFGNovl6LzTY5g9n--

