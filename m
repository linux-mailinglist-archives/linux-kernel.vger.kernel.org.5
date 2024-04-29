Return-Path: <linux-kernel+bounces-162641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 592518B5E76
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5299B23A24
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC93583A18;
	Mon, 29 Apr 2024 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z//pnv/M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B5F8288A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406497; cv=none; b=d3ISCWtkHXH259xfKG3jfRk4biwPHR3mVw8okM2TSrCYAJGfgp/cbS9//DZUiUgpYNk/ZUq5jmYb/Z4Ms7tqtdpYUPQ2mgrRCO6bfji4NpwWLZI5vOhkAnWimWJxgVECuS55R8lXz6/xa4LewFLYTwUQjIpEUAx34cZBt211qYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406497; c=relaxed/simple;
	bh=1vP8H1PgFkZFQ6nz4DIR0J5Ohhr/3GoY+TJ/92tyUzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvXXskH9r57OpVaN4/yyAtWXvM2/PqlLPKkx/nY1Sn3thHrMi2pPfYjxfWazeyeWOcqAPiIkk/rwv1naE1rEmn5RC3SkQasKe1WnyewjR5yfLJiMaqBVFBNA79bbHlrnjMNvF1uFFs6exsXvm7GRyuhf8+VnV+hfGNP63s9VtNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z//pnv/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AA5C116B1;
	Mon, 29 Apr 2024 16:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714406496;
	bh=1vP8H1PgFkZFQ6nz4DIR0J5Ohhr/3GoY+TJ/92tyUzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z//pnv/MoTcjmaEtTbjxlmMqv9hNkx8rB2qaHRrAaAIfktyoHng9iWgmuJ76swoAy
	 oLIz6SmufCP+NCRbZ5Yeuhs6BVN6SH5nAsH2v0mIjZmbTq4hqLCz16eP1o/VmGO/jl
	 rRF2F016fcPSv6EU+xBRzM4lOO4oFzEOaCot7hXa1Nv5xPY/eE26Y7Le58f/btffcV
	 ucdEQlAoc3ORH2g+nLYvZxTWalWW88IMgh86d/hu16El3XL7yQiqaV2opMFQ6M3xSF
	 hmvLMD3DAgp3t941p67bUNApwmL0FFCBsg3sANeInRrHe/0AeQIKZDM2RNkOcyh9jv
	 WdmRXjZO9UbsQ==
Date: Tue, 30 Apr 2024 01:01:28 +0900
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/12] regulator/core: regulator_bulk_get: remove
 redundant NULL stores
Message-ID: <Zi_EWBtMFISQJcHE@finisterre.sirena.org.uk>
References: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
 <1ec1a8090c0e316ee005629c24f2779211e0aebf.1714399603.git.mirq-linux@rere.qmqm.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yP8oxXeM2ea1Is3J"
Content-Disposition: inline
In-Reply-To: <1ec1a8090c0e316ee005629c24f2779211e0aebf.1714399603.git.mirq-linux@rere.qmqm.pl>
X-Cookie: lisp, v.:


--yP8oxXeM2ea1Is3J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 04:45:28PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> On error, callers of regulator_bulk_get() pass the error up and don't
> use the pointers in consumers[]. The function is documented to release
> all regulators if any request fails.

This doesn't seem good from a robustness point of view and should be
nowhere near a fast path.

--yP8oxXeM2ea1Is3J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYvxFgACgkQJNaLcl1U
h9BOfwf9H88K7EcrVQqYM9JQsVepjbUIdocBBvSr/H08ORpBFdc6IT1hm02vBE6T
25E0Ch9eqLp1iWk3KPe/EiiJ/G8HUxw0ju06Xae8sx0iw0KK9+UYuhW1qr5xhErm
pu606qgn9euEEQ8U/UBYUacdpJrB9Ihdr5e9Nql3uKsxnOdUNLK6HBOsTH7uNr1F
OEx0DpwUquidOl5qlMPb49rc8qguw3KZh5a3CbLkso3rd45thU/qeO/nyo9jLKIE
PXm6u5h7serILS7HJWmUpVJkh4qM+UIG02X3chZYL9zY65o6VZmu5qAUcVX7Zv0n
xsp4FIUqLX0k1IUV3BONkLj+5d3RBg==
=q08o
-----END PGP SIGNATURE-----

--yP8oxXeM2ea1Is3J--

