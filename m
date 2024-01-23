Return-Path: <linux-kernel+bounces-35313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CF2838F65
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791E31C278BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8305F558;
	Tue, 23 Jan 2024 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZdjJEUc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69A2B9C0;
	Tue, 23 Jan 2024 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015211; cv=none; b=Kl5nBkl8Lp8JHxzA0FhTYuvDxfP5wF6jPHKib0MpIhtDGJbL9bmXPneAoVlpNMxQcOOVDaHISf2I/34RxSjs1OdGYLQfwsG6n8rdfNlWyBauOc7TaDaLSSw6hifJTIILPgbGi/Braz7GnAKQygGYLWK/dsi69JOXSvi3sPtAfHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015211; c=relaxed/simple;
	bh=K7kvBmJeqF04W+pnqptclIFdMZFoZ8/xaXv5/7yq+fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sr6xts+LXTYEGnIBDOOJOFGEG94+Uc2LXGwyROlaKFu4vSSYK0/nWV+Dm6ZPz+43/dKB6OnsOg8LT0lN/CU9ODKFEinHm4ZT2LOX6MIStMjC+hZQ8UMVSG/hB39WoAC+1G0bcUJSDHrkGVyopS9KL+u38CcWx/0efF3jxm6ESX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZdjJEUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B05C433F1;
	Tue, 23 Jan 2024 13:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706015211;
	bh=K7kvBmJeqF04W+pnqptclIFdMZFoZ8/xaXv5/7yq+fM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZdjJEUcxItY39hyskeZ1+Qqa/LKxZY8GzUZsJxDYd5jhDQOfDo7brPjstF6JgRjJ
	 AGoG3Y+acaaBe72R9CC+4xnSPcl+knTEoqw7a736iAl86UzkqXp8T7N0FO8v4VdA5y
	 aUhr/v7/mBNZfULQb0EWmaFjT6jf3s6CR1lt7MFz6BQFu2H0sA0rl471J336NJgo1B
	 XtATZfktBdJ9uT/tos66H299y/ihBOFJPmlQUMtn1l5P/TZtV5NA3yq2Qyc4jMmkFw
	 +KpOIgFNrZulgANWG4b/Sc980/CwIJ9WTW/2BgZ2HPnUCJH7Tt4kZsxwLFc5cl+P4K
	 ws+8sDuzkfEUg==
Date: Tue, 23 Jan 2024 13:06:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Seven Lee <wtli@nuvoton.com>, lgirdwood@gmail.com,
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh+dt@kernel.org,
	conor+dt@kernel.org, YHCHuang@nuvoton.com, KCHSU0@nuvoton.com,
	CTLIN0@nuvoton.com, SJLIN0@nuvoton.com, scott6986@gmail.com,
	supercraig0719@gmail.com, dardar923@gmail.com
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Added schema for "nuvoton,nau8325"
Message-ID: <185f3912-5a92-4ef2-aac4-0df8363d8727@sirena.org.uk>
References: <20240122095650.60523-1-wtli@nuvoton.com>
 <20240122-daunting-woof-19fac5689bb2@spud>
 <04945799-eded-42f9-b8fa-8907be44c400@sirena.org.uk>
 <20240123-bottle-elevating-9fbba5424014@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o44Jj4pPrxHSXHhI"
Content-Disposition: inline
In-Reply-To: <20240123-bottle-elevating-9fbba5424014@spud>
X-Cookie: Stay together, drag each other down.


--o44Jj4pPrxHSXHhI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 23, 2024 at 08:34:03AM +0000, Conor Dooley wrote:
> On Mon, Jan 22, 2024 at 07:40:51PM +0000, Mark Brown wrote:
> > On Mon, Jan 22, 2024 at 06:00:14PM +0000, Conor Dooley wrote:
> > > On Mon, Jan 22, 2024 at 05:56:49PM +0800, Seven Lee wrote:

> > > > +    enum:
> > > > +      - 0 # VDDA
> > > > +      - 1 # VDDA*1.5/1.8V
> > > > +      - 2 # VDDA*1.6/1.8V
> > > > +      - 3 # VDDA*1.7/1.8V

> > > I would also rather than this enum was used to have sensible values for
> > > the enum itself (which I suppose means strings here), rather than the
> > > register values. Seeing "nuvoton,dac-vref = <2>" in a devicetree is not
> > > very meaningful IMO.

> > Do you have a concrete suggestion for how to more clearly write these
> > directly?

> I would use what's been given as the explanation comments for each of
> the current enum values in the patch.

Given that none of *, / nor . are usable in defines that's going to need
a bit of massaging...

--o44Jj4pPrxHSXHhI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWvueQACgkQJNaLcl1U
h9AZZQf/ao209hI/MDFLL8V01uYpIbpZZJHJhmCnoIqQZI9Zf1saVE9CfUT01pBI
HeitK8MA1WM/3YMh0JT57EQ2XMFSYCHmv8clDtVnqqVun+zD5xXS6PFHIzzqlWJZ
uZwcjyxs1vssOWrJUOeHyZHSoV6QIuEY5HfOSFo98n3QG40P88AoCFNafMKgbk3I
8uoAB5TIpDVbLMF+c/ETEi5zxzcYjEQ4B2s7rCxEFPuvQu32ErAsYW3PCpRbzun9
adZUG89VeomjC/gs1Vp+0nqm5jFC3fJfTXrHFrK+ty5HgGUUGPxlUgolFxljV69a
d4bjft12qN7vACIxCZYBBPRYmq1MXA==
=Vsnr
-----END PGP SIGNATURE-----

--o44Jj4pPrxHSXHhI--

