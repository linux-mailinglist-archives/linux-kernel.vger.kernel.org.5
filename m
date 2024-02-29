Return-Path: <linux-kernel+bounces-87295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130EA86D250
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B15288CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6402405F9;
	Thu, 29 Feb 2024 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ni84BdSM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046F1383BC;
	Thu, 29 Feb 2024 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231415; cv=none; b=arkLhTQ8mrC3lWLsFENfMcIoYU5T7QdEMuKE/wzfosz4kEwMJ8ZWOktk5I9nGnuLT8hJ6MhpMjDTMbZInQQmj4beacZDBPjslUNgIwyttLbdd0lYmcIv0WlL+umTc78wotmQKPKFRWpY+R/DYzthDafXCZ1wddy8X6aL2xfzeas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231415; c=relaxed/simple;
	bh=2HgWWLtX9NUghm/JjXanG4wu76srdSHYfyF5THzKR88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+91HoVhuwcySb2gQoqKzbG8uPF/i2H9TuVv4KsmulLd6WOnylfwjphte/MHkDh9bz1sXQeesZYZYa5SNo62MvEtxFSGimx7P+nZz2md9In/lBSPqphZwDlNB7GZLgo0MAmlWizuK2BhLlgi9tavKFJSXKr/uWBywMXCzs2Oldo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ni84BdSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC719C433F1;
	Thu, 29 Feb 2024 18:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709231414;
	bh=2HgWWLtX9NUghm/JjXanG4wu76srdSHYfyF5THzKR88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ni84BdSM7Em3xnOJzG6vi0AKZYqeNW7xAwZ5Us57psuqfBpI4UveM8rnKCRxxlS2h
	 VlQ80j+REd4wrXfVuNNNLx22ew0i4roVR7r5j35knJUrf5ZtrE7rZiUlhL4zrXLn2e
	 3MAwsvG+s3myp+TYpk0LLThNRVxEgai4HsbzQ79ulyOYh6SEjn9pPgcqu1iJytUC0Q
	 cKYwYNl1mMm49OHc0WiK3WHAGHwOkfvBGiI1RrL7op5eLtMRAn1dM4tXZnEQ4lC4We
	 rNaCRRkY3kx0Ah14xmQgM228rVzhXRR3tx6cliaKsWsSoZqetYk9+l4CT/v44ALhlt
	 TNFlaVoEQobdQ==
Date: Thu, 29 Feb 2024 18:30:10 +0000
From: Conor Dooley <conor@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: samuel.holland@sifive.com, ajones@ventanamicro.com,
	linux-kernel@vger.kernel.org, alex@ghiti.fr,
	linux-riscv@lists.infradead.org, sorear@fastmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH -fixes v4 2/3] riscv: Add a custom ISA extension for the
 [ms]envcfg CSR
Message-ID: <20240229-establish-itinerary-5d08f6c3ee43@spud>
References: <20240228-goldsmith-shrine-97fc4610e0bc@spud>
 <mhng-94e8034f-eda3-45df-bcf0-1bd5bd9cb869@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ch+3PeRyra/9QFRf"
Content-Disposition: inline
In-Reply-To: <mhng-94e8034f-eda3-45df-bcf0-1bd5bd9cb869@palmer-ri-x1c9a>


--ch+3PeRyra/9QFRf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 10:23:39AM -0800, Palmer Dabbelt wrote:
> On Wed, 28 Feb 2024 02:12:14 PST (-0800), Conor Dooley wrote:
> > On Tue, Feb 27, 2024 at 10:55:34PM -0800, Samuel Holland wrote:
> > > The [ms]envcfg CSR was added in version 1.12 of the RISC-V privileged
> > > ISA (aka S[ms]1p12). However, bits in this CSR are defined by several
> > > other extensions which may be implemented separately from any particu=
lar
> > > version of the privileged ISA (for example, some unrelated errata may
> > > prevent an implementation from claiming conformance with Ss1p12). As a
> > > result, Linux cannot simply use the privileged ISA version to determi=
ne
> > > if the CSR is present. It must also check if any of these other
> > > extensions are implemented. It also cannot probe the existence of the
> > > CSR at runtime, because Linux does not require Sstrict, so (in the
> > > absence of additional information) it cannot know if a CSR at that
> > > address is [ms]envcfg or part of some non-conforming vendor extension.
> > >=20
> > > Since there are several standard extensions that imply the existence =
of
> > > the [ms]envcfg CSR, it becomes unwieldy to check for all of them
> > > wherever the CSR is accessed. Instead, define a custom Xlinuxenvcfg I=
SA
> > > extension bit that is implied by the other extensions and denotes that
> > > the CSR exists as defined in the privileged ISA, containing at least =
one
> > > of the fields common between menvcfg and senvcfg.
> >=20
> > > This extension does not need to be parsed from the devicetree or ISA
> > > string because it can only be implemented as a subset of some other
> > > standard extension.
> >=20
> > NGL, every time I look at the superset stuff I question whether or not
> > it is a good implementation, but it is nice to see that it at least
> > makes the creation of quasi-extension flags like this straightforward.
>=20
> We can always add it to the DT list as a proper extension, but I think for
> this sort of stuff it's good enough for now

Perhaps good enough forever. I was not advocating for adding it as a
permitted DT property - I was just saying that I didn't the complexity
that you mention below, but I was pleasantly surprised that the stuff
?Evan? and I came up with allows for this kind of inferred "extension"
without any changes.

> -- we've already got a bunch of
> complexity for the proper ISA-defined extension dependencies, so it's not
> like we could really get away from it entirely.

--ch+3PeRyra/9QFRf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeDNMgAKCRB4tDGHoIJi
0phyAPkBd+aPNH1/saAdNEh6ILJZUG6mCtcyhkUgdb1752vlrAD/RIO8+81FcJN+
11exmk/RMWj7ZuE4xehnYEvsq43w5w4=
=t2I+
-----END PGP SIGNATURE-----

--ch+3PeRyra/9QFRf--

