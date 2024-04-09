Return-Path: <linux-kernel+bounces-137510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F5F89E314
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE1F1C20CB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F25C158A14;
	Tue,  9 Apr 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnlQmmQC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C294158A06;
	Tue,  9 Apr 2024 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689769; cv=none; b=ec1k3Do5bHdIFEknhE323HPsoJQgxkDzWAuoVMwQo57uHhtlCngLf9rAL/u2LIODili/xzUbDSFmzZUnUtScI/xkP/V3Ii6ZeSG94DXyyDjzf9v2rnv0xcP04zz3Ma1JGwkM3O1S0gzNsBpMXz8yA0gP4EpXesvFqyzlCiKLaGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689769; c=relaxed/simple;
	bh=uK/g3z0UXgcBV0TMzjwb41q+mX0RX+rzuFNb8X03ea8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEkM8KNPOX6EZwARJkiKDq+D8Q62aLDd8/UiHxD/r0kFOmivVQa7p6sYG65OmtMda3aFoijQUsCqWQdSJsytRJxXIIx3tkuEf53WzYYMk1aYSKxaLhPj6aL9BuLCZ8TVlK5hnVzD7BkNwxYJzbTLRwQyDerExKAvYpiRLIVWlBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnlQmmQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10CFC433C7;
	Tue,  9 Apr 2024 19:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712689768;
	bh=uK/g3z0UXgcBV0TMzjwb41q+mX0RX+rzuFNb8X03ea8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZnlQmmQCrd2VTu8MwIVcsiUHzECbqm2BLbX3XOyF/mLruYS7HM5x3TRmKlcCn1hAh
	 WI97stv+lDSJHaBIv0Me05yzPq353ARF0vOqP/zGps6IfvzyAvCKeXG4GXmKzfIktF
	 e/xNUfvjzFyhfeDIXcPHLOPipDNZF1PjrCDBcjWcVynudOrhiMrER1t5bG0oMrnvUz
	 apZusqcn7Uc22V1FZqmyq4keZCeWL4kDCFFQxWRdBLdq+j64PqPJFu+GWY7Vs6fXTv
	 Nr9VAQec4hs87D0lItFPPy/yFK1g/4KYI3Oi3XrVdf0GcpXhznLmf1ziTid5BD85G9
	 T9Cr5xu16sm6w==
Date: Tue, 9 Apr 2024 20:09:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Ruben Wauters <rubenru09@aol.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] spi: Add documentation for last_cs_index_mask
Message-ID: <1ec0fe6c-6af0-4cee-98ba-25fb2c67ef1d@sirena.org.uk>
References: <20240409184106.22715-1-rubenru09.ref@aol.com>
 <20240409184106.22715-1-rubenru09@aol.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HPlUWP5Ja3od6VbS"
Content-Disposition: inline
In-Reply-To: <20240409184106.22715-1-rubenru09@aol.com>
X-Cookie: Everything you know is wrong!


--HPlUWP5Ja3od6VbS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 07:41:05PM +0100, Ruben Wauters wrote:

> This is my first patch, so I hope I did everything right, please let
> me know if I need to change something, and I shall endevour to do it
> properly.

Everything looks good, only issue I can see is that this question (which
is adminstrative stuff rather than part of the changelog) should have
gone after the --- below:

>=20
> Signed-off-by: Ruben Wauters <rubenru09@aol.com>
> ---

so that tooling can automatically remove it when applying.

However a patch for this issue has already been applied but not yet
merged into Linus' tree.

--HPlUWP5Ja3od6VbS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYVkmQACgkQJNaLcl1U
h9AAUQf/eUxe0KKXZ5sarYJLYfRMjT5Zb6KzM3vAQbWIMGEDVQbzTGGFiHNGjsET
E2quP77MW0ndkVbgexUMbLeuUko4X5mEsNlu1mCBfOvsb0MzFmn/Oddc236U9ota
r9ymXI0xE26GB2ZmmWgItb8SWMSd/bv5iDsEom4FKTXydGydrWGTAr+odQB7RwwA
uVfcLrS6x7Ty0L3t6uJVS9Moat54ER39JNyzTTOAuzFbtlEyWYb0Xxp2Ypx+2Mi8
xVw4J/U4JOHnv50kyH0P4abOIJNmiV88FYCXnUqOCksIVw7T+B43zPgS8CwGoxoi
4SRgsgl8frJd0FfTxHVfF318TGg9Ag==
=9dCy
-----END PGP SIGNATURE-----

--HPlUWP5Ja3od6VbS--

