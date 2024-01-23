Return-Path: <linux-kernel+bounces-35878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A26839802
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E2C28A5FB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8D1823AF;
	Tue, 23 Jan 2024 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3CgYeNt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD5E81AAA;
	Tue, 23 Jan 2024 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035328; cv=none; b=Kg0X1Lgms7A/Qfv9pMR3RPZ4aLBhvkzdXW0kLVqZaHcb4WLmLKefDNWR/l3ZYQt24uzkmN3sylOzzrjuAf/H9uXPYugAZH7MFziE4foOwJRnApYHyA1yHfjVN6HbcOLdAFoTkchFDbPvGyGs/AvQgrRu94IZ9mJG3w3zgeRtRmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035328; c=relaxed/simple;
	bh=KuOlsJlAeHgM/ZAB95KCioMPSwl13wrRH6nU16aaT5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfuFzRaQNNix5IsU8CZxIsCyii7bBLInxmMgSCcnJykiSyQQe9PM4xWir7ff44s8fRaGjabGxot4sYDI7kVBCLzwYXO5+mqOPf2hUgZC6Dk3OI1hLreGk4moV3luOIG3UFx6KsKwJ3VAG1HtNFZwP/yoQuLz5xlJn1SD/kLw+rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3CgYeNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72502C433F1;
	Tue, 23 Jan 2024 18:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706035328;
	bh=KuOlsJlAeHgM/ZAB95KCioMPSwl13wrRH6nU16aaT5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E3CgYeNt1ol1Cm2hp5xZ8LQhi5spVR9ci1E4sX9qcE09r+8YEFdrgKTub37hZEho0
	 4mgJy89CIfXvyopnJzosk8xZRE/Ddv1I7ZiFStnAowSKZUDAgfslhIS0zbnKSZWfBU
	 0BdhiYsjqjiWV4/u+MhyXAZX6YrH28qLa8gLm6o2MVK67KcImfdottO+YSMYz3P7tD
	 0UtXqfiXfS9Fd7uiOcR5BHwLfUM1k1nqBC8iKVLrB2/aEUTIqojJCxubmfopFeIorC
	 vbDJLK8+Vq/mJJlZnJaQigV6l3gvHZNVY2E/D2Je665mwwRf8kWGE5J+JyLk4+kIms
	 sMy30evQFvn0g==
Date: Tue, 23 Jan 2024 18:42:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
Subject: Re: [PATCH 3/4] arm64/fp: Clarify effect of setting an unsupported
 system VL
Message-ID: <46571fac-28bf-4c6e-a5a4-38b1182b93a0@sirena.org.uk>
References: <20240122-arm64-sve-sme-doc-v1-0-3d492e45265b@kernel.org>
 <20240122-arm64-sve-sme-doc-v1-3-3d492e45265b@kernel.org>
 <Za/gB3oCNAyiPPnu@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wi8C1+Ocdx9GTbVa"
Content-Disposition: inline
In-Reply-To: <Za/gB3oCNAyiPPnu@e133380.arm.com>
X-Cookie: Stay together, drag each other down.


--Wi8C1+Ocdx9GTbVa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 03:49:27PM +0000, Dave Martin wrote:
> On Mon, Jan 22, 2024 at 08:41:53PM +0000, Mark Brown wrote:

> >  /proc/sys/abi/sme_default_vector_length
> > =20
> >      Writing the text representation of an integer to this file sets th=
e system
> > -    default vector length to the specified value, unless the value is =
greater
> > -    than the maximum vector length supported by the system in which ca=
se the
> > -    default vector length is set to that maximum.
> > +    default vector length to the specified value rounded to a supporte=
d value
> > +    using the same rules as for setting vector length via prctl().

> Do parallel changes need to be made in sve.rst?

They are, in this very patch?

> (There seems to be so much duplication and copy-paste between these
> files that I wonder whether it would make sense to merge them...  but
> that's probably a separate discussion.)

Indeed, thanks for volunteering.  Note that there are differences
resulting from specification differences.

> Nit: is it better to name the prctl here than just to say prctl()?
> That would be easier for the reader to cross-reference.

I guess, though it doesn't seem entirely idiomatic.

--Wi8C1+Ocdx9GTbVa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWwCHoACgkQJNaLcl1U
h9D0Ywf+IsH2g0If00Q6Xk+sM/N4fUnp2hK2AfnBw8nxWQ5Odt/OYSj8MHbBtvSO
1yDO0dHZ9PvXpJNJG3mrrsxZhVg2SEHvoQ6O28G1GGQPciM4/3Qm02F5KNeu0ak9
iJxeljkaWSxQOLKnbnxF2z36xZ/DmdY0mLF2ns8lTijWS14OFy/rsjVY4rVnK742
CDEmB+OyW6oiMrpwOVURKa1gD9pUiHa56ju7qN0E3mNydfNv9SeXljc3Kqsr+Qic
Yt5CFfrUqvBlq50CfErsPZcCjH4GgDDzFTCRmkclu5E14fohiftWeENBEx6yhXYm
9Bu11n7PyA5yEQSgS5GB7V8qQ60eiw==
=apO6
-----END PGP SIGNATURE-----

--Wi8C1+Ocdx9GTbVa--

