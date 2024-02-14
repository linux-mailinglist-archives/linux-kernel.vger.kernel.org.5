Return-Path: <linux-kernel+bounces-65385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03885854C35
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3533C1C26F44
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7C05C05F;
	Wed, 14 Feb 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsFUGwyG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D42A5B67A;
	Wed, 14 Feb 2024 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923425; cv=none; b=dCxowx62pSMQnhjVFlEiAb6JhT/Kvc1p5S9fLk8ccp3NWwKbL8r/UaF0u1FtQHimA6Y3exYjdhF7FF0GR5dzfvfTtW8x3piGh/P2soPXIIEqZlyFErn4BU7ILsHYTQ3bqKgQO7Y77ZnG3QyYnPyA3wlszyhsoSUvO7OLXcSL0tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923425; c=relaxed/simple;
	bh=GS4eSHaDiEsFeMPQ2s8gW0MM1LndD3K1GsMp2uxE/28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZbk9JwhItjsDRv4BYm5D16Q1gh/C8gBgI9ZquLpVbMAsOUL1FEqB2Ack9r7m6XAwbiMjcydKSo6aULA2yYUZotbHIyYkKFIN+b+pkoIjaT0iRn0/EnvavylNxFZAISpPRwRI7xnQVSjnsXCp+lscaYeK48oCLi8eg9wghnMfzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsFUGwyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3777BC433F1;
	Wed, 14 Feb 2024 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707923425;
	bh=GS4eSHaDiEsFeMPQ2s8gW0MM1LndD3K1GsMp2uxE/28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fsFUGwyGH3kALXBm25gWqtFT3QTDs7epAdoZRtSmdulitCQmGSKgYezOsCdsNYMJ9
	 a1CoBElpkxGALBxYgT3j416u8ST43b3WZ+ogEez7CRhd1+Pg23QkEIvtSgKZMnLaU2
	 3QIvv7VR9vLT5ClAi89uTAs+ixfmEyW33SCMxHb0AGTcwOcFj+tcGPKIiJwwDWsn3C
	 mrwAjrbToEiDPx+otZwMqAzVFkFZusy7VTTq9A+jrUs74eLw+ZPx62/8fpwcmh4X87
	 n5y22X39ogjhxFHmOLCB14NVGY+BGEU5cyXJ+Ebvp2bxkgQrFmpU5kKIZ5Y71EaSZY
	 Ggwk6iE4tMzVA==
Date: Wed, 14 Feb 2024 15:10:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, corbet@lwn.net,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <fb5f7cf4-6541-4d91-afbb-5514cec3ca47@sirena.org.uk>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <nycvar.YFH.7.76.2402141433560.21798@cbobk.fhfr.pm>
 <7c177ba2-6b0a-4203-9ee6-113e75c6bb13@sirena.org.uk>
 <nycvar.YFH.7.76.2402141539180.21798@cbobk.fhfr.pm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BG5O0liRLurZHdWB"
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2402141539180.21798@cbobk.fhfr.pm>
X-Cookie: Available while quantities last.


--BG5O0liRLurZHdWB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 03:46:12PM +0100, Jiri Kosina wrote:
> On Wed, 14 Feb 2024, Mark Brown wrote:

> > There's an argument for many headphone volume related fixes too since
> > excessively large volumes can cause substantial distress and potential
> > injury to users (I can't remember if that fix would be relevant to that
> > issue).

> Something being too loud, causing distress ... that's really a grey zone=
=20
> (to put it mildly) for me. How about e.g. a bug in GPU driver, leading to=
=20
> a flickering screen? Many people are very sensitive to that (both=20
> physically and mentally) for various reasons.

> Bug worth fixing? Absolutely, as soon as possible. Security-relevant? Not=
=20
> in my book.

To be clear, most headphone drivers can easily generate output levels
which will cause temporary or permanent hearing loss after very brief
exposure.  The distress is the urgent and instinctive need to remove the
headphones as fast as possible that tends to result, much as it would
for any other ongoing source of injury.

--BG5O0liRLurZHdWB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXM19sACgkQJNaLcl1U
h9Awvgf9Gu8FSKxDu0eWu7eEILO1aW6n3afgdS4SSJxYcmqNDCJzBT2VDTi/N6hA
aeDLNw9G94HI23Mabmi664LWHZrCcrfo1sWSMOdFsFREZWK5t1vKyauVDeGJTsuM
5U4PcoX14VMUbnhGLXu9oTWWw/Tx/jda0ac7ZcU1IflxuMV/s0rtHH8qmyjlScnP
KP4wSoIK+Cmmlx1o+0Z1UrMPc5XjqTbLHzKOS99ZgS6GLMxYFMO+AX0lAObj8XJ7
MXLRSyMgoVHUAxTPPknTmNbeE67zrQ6Ml1osozMYdRACtOYEoW+gQWo8b/qMbhJW
brCB0Xw7JhUqKjcdyCrrgpK73uWocg==
=ulVa
-----END PGP SIGNATURE-----

--BG5O0liRLurZHdWB--

