Return-Path: <linux-kernel+bounces-73446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A727085C2A9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460C11F2373D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B8E76C99;
	Tue, 20 Feb 2024 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="RsBYWQFm"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FE9768E7;
	Tue, 20 Feb 2024 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450230; cv=none; b=axT6FTbfrta0nkHHOR5seb/V52lFsSH+OLaaXcWyQlLC65risdFS2C6rIOapozeueJ/UPcjIKz33nW+Sg/YrELryrATRp0gVp7kGAsxHO6erHnhqTAVKkN0Vpwslk3plC5JM3zziJaNUo7LibIlOnfGXqbDD5Qf6V82N2FGA+Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450230; c=relaxed/simple;
	bh=6h5vfjAgCeXYbBUZ5XCBp/nzNrxSqsTFEsdFP92UxL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9GA5tnGp1fxNEPt3kZ2vWOP2q8vbBAJ75lkBuQzwLKireXs6CQ9mLwJ/lKffsF/5hYhWnVoUjJS9qbs44f9SWhsT2THsAPvYCwD60jCgzeR0qb3QV7NAum8810O0eiexhpTNULNpMZqMcHC90GtQtpX0f3z5yHc5PDKZGuxl6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=RsBYWQFm; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 70FC31C0080; Tue, 20 Feb 2024 18:30:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1708450220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YqG2bsKElbhecX39OojR5haoXbZVU9kM89vDnjokXvU=;
	b=RsBYWQFmky+d5tNsbJOc5d99mwYzrN/LNQKMddaZFoYDI2mz98QFRwnHZQMqUomOvKIxMG
	1aGU5tNRIylD59znlh/DW6bGVDslPRoo6zOxiiUnvsiU6edAwUBpF+OrGz04fshwMWv7v6
	GYS/d74uokghQ61Nu7JH5kO+LDLFGtE=
Date: Tue, 20 Feb 2024 18:30:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Lee Jones <lee@kernel.org>
Cc: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux support for a 7 segment LED display
Message-ID: <ZdThq8G/cgHeuI7/@duo.ucw.cz>
References: <1f598a72-dd9f-4c6c-af7f-29751f84bd23@alliedtelesis.co.nz>
 <20240219151332.GC10170@google.com>
 <a70425d3-95be-4360-9828-d5403404e803@alliedtelesis.co.nz>
 <20240220081842.GF10170@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="scxsMsU9D8GBkCKm"
Content-Disposition: inline
In-Reply-To: <20240220081842.GF10170@google.com>


--scxsMsU9D8GBkCKm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > >> I'm looking for something that I figured must exists but maybe it's =
so
> > >> niche that no-one has bothered to upstream a driver for it.
> > >>
> > >> I have a requirement to support a 7-segment LED display[1] (one that=
 can
> > >> display a single digit from 0-9). Hardware wise it's just a bunch of
> > >> individual GPIOs connected to each segment (plus an extra one for a
> > >> dot). I can't see anything obvious in drivers/leds but maybe I'm loo=
king
> > >> in the wrong place. Or maybe it's the kind of thing on PC hardware t=
hat
> > >> is just driven by the BIOS without the operating system knowing abou=
t it.
> > >>
> > >> Is there an existing in-kernel driver for such a thing?
> > > Why would LEDs connected to a bunch of GPIOs in a specific fashion
> > > require a hardware driver?  Doesn't drivers/leds/leds-gpio.c already
> > > provide all the support you need?
> > Yes I could expose the individual segments as gpio-ledsbut it would be=
=20
> > nicer if they worked in a more co-ordinated fashion so I didn't have to=
=20
> > care about the individual segments and could just say "display 7" or=20
> > "display 0".
>=20
> Still not sure this sort of thing should be kernel-side.
>=20
> Sounds more like the role of a library or middle-layer.

We do already have 7-segment support in auxdisplay. We should simply
use that interface. Simply create auxdisplay driver that uses gpios
and provides interface similar to what is already there.

(Of course, just using gpio library for userspace will be easier).

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--scxsMsU9D8GBkCKm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZdThqwAKCRAw5/Bqldv6
8gxrAJ4tqC8nc64FZB7zheh/HrZrHNQIVwCgj4qctDPPkAFQ1pRuMie0lIAC39I=
=nym6
-----END PGP SIGNATURE-----

--scxsMsU9D8GBkCKm--

