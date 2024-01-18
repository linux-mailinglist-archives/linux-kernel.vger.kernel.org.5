Return-Path: <linux-kernel+bounces-30190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B31F831B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2B61C22146
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B832125773;
	Thu, 18 Jan 2024 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVs6qz7u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1B624A16
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705587621; cv=none; b=RTBS2n80crn3MEUU964nzu2Vf5xy71NNMfnm/G26rCsO9aXg4JyuV54ekbEhENlCakLlokXXD2ehKuYbbloIBSu512DyeTPLxVJDd4Cc9uCddRdLBZUb8UkaRhbrz3tz6eqqm/0/mDGGEKEvPTJnpT9JoHwokUiDl+WhWOOPubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705587621; c=relaxed/simple;
	bh=CIBsSiu+SMND0CmGNeg8oFCef+pMyAWcopdOdeg35T0=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Cookie; b=h+kMfvMUAnGjxQpIuMKqhmRFtcb8kizLNlR8FHWTGH7amSfnw285jUMlaV/h9iBbgJmGkCtZdcJsnxfoX+cpFKeWPkgrmySpcEorzuGKVBhwe7U8l6anHVxtOUTXJ/rY4GXIQ7+EjoVBSz2MTsfYEkfELm09vDHRTqL3ZU6bjZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVs6qz7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8492DC433F1;
	Thu, 18 Jan 2024 14:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705587620;
	bh=CIBsSiu+SMND0CmGNeg8oFCef+pMyAWcopdOdeg35T0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bVs6qz7u1YsO2xUJsSdzfNFERFWyPhpnmvVy65hfjnGyPAxd0LgE22O401i+chzBI
	 wExs47cQ9yQzLFHu78jbWM0gSwe5Nv716z4iBd9tKh1uaOxlKvRpQjy9f9vC0wqWmm
	 kYl6FMi5UFcor9/MYZmQEVT19aS/Q5P0WeVBWZcAHUtMWr8pIVHKvrrhPe3ibNVSDT
	 n+5x4YqqCoCfsio4jTL942eGsSf1chQdmgB0hlKatmYKLrq6SCyuee9xFL6QhEA9+H
	 +zVFVzFChTlQIyVqH6EScfPGtwSe1XGiNPxYx1L2sam5NLCkUjMkMQMPp7uUBNpIA4
	 WNGOKDIM9qcPg==
Date: Thu, 18 Jan 2024 14:20:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regulator: event: Add netlink command for event mask
Message-ID: <3a39f7a2-d6db-43c6-961c-63ba6c774970@sirena.org.uk>
References: <20240116103131.413205-1-naresh.solanki@9elements.com>
 <e3e16af2-7f8d-4776-9726-f6282128a766@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rEYdBdvZU0R8bSEk"
Content-Disposition: inline
In-Reply-To: <e3e16af2-7f8d-4776-9726-f6282128a766@gmail.com>
X-Cookie: FEELINGS are cascading over me!!!


--rEYdBdvZU0R8bSEk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 02:46:41PM +0200, Matti Vaittinen wrote:
> On 1/16/24 12:31, Naresh Solanki wrote:

> > Add netlink command to enable perticular event(s) broadcasting instead

>=20
> I think this mechanism for limiting events being forwarded to the listener
> is worthy. My original idea was to utilize the netlink multicast groups f=
or
> this so that the regulator core would register multiple multicast groups =
for
> this family. User would then listen only the groups he is interested, and
> multiplexing the messages would be done by netlink/socket code.

> Problem(?) of the approach you propose here is that the event filtering is
> global for all users. If multicast groups were used, this filtering would=
 be
> done per listener socket basis. I'm not sure if that would be needed thou=
gh,
> but somehow I feel it would be more usable for different user-land
> appliactions (cost being the increased complexity though).

Thinking about this some more I do think that global filtering like
the current patch would at least need some sort of permission check,
otherwise just any random process can disrupt everyone's monitoring. =20
Per socket filtering does seem like the way to go.

--rEYdBdvZU0R8bSEk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWpM58ACgkQJNaLcl1U
h9CcTAf/VlL6l130WL+AUzPK/6LSR5HKnMohWlOZLkhEI+ZeM8RTyqaj3lC3GB/k
mrBd54Ip8xfikSWeZjnFXFBHb5o+7J+ypwpAh5QdxMQ5T46yMn/DR3NddrQPBs+x
Pbwbt8IcADrsr3PJ4V33CHYFMu4DgLOrDyTSoUxqNJSG6Njc5fJQZ8mz2Sqx4mi3
3vpITym9+UXEW1elgF1WP08rdKE0uuGvnF8hmPR6iZCMX+bo0hwayI50BFog9V0F
Ll5bITbDCa+RDkBVg67O3wF/vINeVxZNvZFLjLLAe6ZCdCOwR61YAQ0vwy+lRDq8
YkHVaSIvtqVeBGEGbEIQbuktcE2zWw==
=M0mL
-----END PGP SIGNATURE-----

--rEYdBdvZU0R8bSEk--

