Return-Path: <linux-kernel+bounces-47150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FC88449DD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBFE71F23C87
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCE43A8D5;
	Wed, 31 Jan 2024 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyGU+CrU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5397339FD8;
	Wed, 31 Jan 2024 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735925; cv=none; b=IdGQgsEsy2CGjQLC/qz6cdoAU6b7YLWFiSBtunOlQb7ygRGVOzaPBd/+on0o/h0AzfVTZx3Bd9BD41b+Ld9mPr2njR5ws9VoUSVsBw1NuN8sopeT53sG/CWScD1aYxGoNMLsGQZ/Jym4Up4HGjqOzNgE182sIs3sCbpESdM3hZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735925; c=relaxed/simple;
	bh=KNZ/7kDzDD/sTwVVnY3Wpq22SMn/oeI98uczBPvFYkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqWEt5dt3wCBCqbtJoX6s13qgIjKeIXOsVFnmNp9irQBQJlmnRhLsaRp9zpCfty3nwXxCckO1gWapxfchewKr8ABfwMOf8FGR3ilNgLSjJYJpWwptzCYhSkSnQcMZ+c2HbQwQjb/NzDi8lQFG5ZtxYYuA+1WxmExgrjczyUHJK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyGU+CrU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E882C433F1;
	Wed, 31 Jan 2024 21:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706735924;
	bh=KNZ/7kDzDD/sTwVVnY3Wpq22SMn/oeI98uczBPvFYkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jyGU+CrUPhc0lzWlLeypgIn6oS2ohPZ6zH+zidjFwavbkGHWJOOsbGARIi6N6TDLS
	 xizxR/frpTEEYpzls8NeZytaCL+tN3veZf8A38yCKtV7xb0nfKuQKt6yKL9c4mvtG6
	 Pjq6WvhMRaaeLs9npuBO0nfOJG3iXmsXZpN3ezzuBanibUDwyoh7TUvJl1WK7tAtZZ
	 f5pvw3XawJkJluuf++wzhplHFKSFmFLjEpMIOQmxlT5isIDMZ7dS8iv/K1r1zbOSnq
	 TcFKmkaXXw37A77EPaY/oQEzp/xVmrtg7xZoRfHWwloP9CoaFcd5uNYghPh+Mb99NG
	 qtDFRKCYodKpQ==
Date: Wed, 31 Jan 2024 21:18:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: Add TI DP83640
Message-ID: <20240131-tummy-imperfect-e6d6f0e245e9@spud>
References: <20240130085935.33722-1-bastien.curutchet@bootlin.com>
 <20240130085935.33722-2-bastien.curutchet@bootlin.com>
 <20240130-impulsive-widow-9142a069b7fd@spud>
 <20240131210521.GA2289883-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Bq6+OXQmC9EZt/Z+"
Content-Disposition: inline
In-Reply-To: <20240131210521.GA2289883-robh@kernel.org>


--Bq6+OXQmC9EZt/Z+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 03:05:21PM -0600, Rob Herring wrote:
> On Tue, Jan 30, 2024 at 05:56:37PM +0000, Conor Dooley wrote:
> > On Tue, Jan 30, 2024 at 09:59:34AM +0100, Bastien Curutchet wrote:

> > > +  ti,fiber-mode:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [0, 1]
> > > +    description: |
> > > +      If present, enables or disables the FX Fiber Mode.
> > > +      Fiber mode support can also be strapped. If the strap pin is n=
ot set
> > > +      correctly or not set at all then this can be used to configure=
 it.
> > > +       - 0     =3D FX Fiber Mode disabled
> > > +       - 1     =3D FX Fiber Mode enabled
> > > +       - unset =3D Configured by straps
> >=20
> > I don't like these properties that map meanings onto numbers. We can
> > have enums of strings in bindings that allow you to use something more
> > meaningful than "0" or "1".
>=20
> Tristate properties are fairly common pattern where we need=20
> on/off/default. I've thought about making it a type. I don't think we=20
> need defines for it.

I think a type would be a good idea. I am not at all a fan of any of the
properties people introduce along these lines.

--Bq6+OXQmC9EZt/Z+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbq5LwAKCRB4tDGHoIJi
0lI/AQC3UAgbedwiOpgsa6R6YtOYcSd54lJHs8nkKy0iGJO8BAD+J2aHBvSvPKsi
RA3BCzfTvU1ni4uZu9VFa3MgfCsZzgw=
=GQXc
-----END PGP SIGNATURE-----

--Bq6+OXQmC9EZt/Z+--

