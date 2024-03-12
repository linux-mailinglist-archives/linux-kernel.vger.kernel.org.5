Return-Path: <linux-kernel+bounces-99918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00029878F2F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA61281A09
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A62F6996F;
	Tue, 12 Mar 2024 07:47:54 +0000 (UTC)
Received: from pokefinder.org (pokefinder.org [135.181.139.117])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963AFBA28;
	Tue, 12 Mar 2024 07:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710229673; cv=none; b=nvdHRRMJnb7a44kcRwteezwr6L+h6LjY7XJJATdsGR3K3jNlRvUUCQ3HqpUPLh/BykwVEG+GqZj0TZctdObtteRIWDJVZ7mxc0uesE6YGGQX2cQUDXD0A044Cvc6xwlkJCIOrRD5vbjj+ZBK5iYQqd9ygz9/CGpdjbZpn+7aEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710229673; c=relaxed/simple;
	bh=oIqiDPiPQjAOu+2nWRzhyZ8eSXBMKofBJu3J/+vtOow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncVhynmxqDt699nJ/PL99xWwQM+JfLcjmQiDYRSAN4qk4L/YwzJl24nkxY+YMkEwq4cudAETewi/yi+IzqXr6hn+OU09IWK1F312Mf9eN51j0IPdBwIRrTS2rz0tDz635vq3vwM0p962fSW0C0HXNuPA3OvGzkBBAO1JefSKwRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de; spf=pass smtp.mailfrom=the-dreams.de; arc=none smtp.client-ip=135.181.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=the-dreams.de
Received: from localhost (p5486c5e3.dip0.t-ipconnect.de [84.134.197.227])
	by pokefinder.org (Postfix) with ESMTPSA id CF67EA40475;
	Tue, 12 Mar 2024 08:40:09 +0100 (CET)
Date: Tue, 12 Mar 2024 08:40:09 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the i2c tree
Message-ID: <ZfAG2RFkL5dDZLKz@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@the-dreams.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240312081933.64de63c0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="otwQC4KmlFK+GLut"
Content-Disposition: inline
In-Reply-To: <20240312081933.64de63c0@canb.auug.org.au>


--otwQC4KmlFK+GLut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


>   f58418edf0cf ("i2c: aspeed: Fix the dummy irq expected print")
>=20
> is missing a Signed-off-by from its committer.

Hmmm, looks like I overlooked something in my scripts when merging
Andi's new branches. I will have a look today. Thanks for the report!


--otwQC4KmlFK+GLut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmXwBtUACgkQFA3kzBSg
KbYx8A//dl6uMUQ7ox9b/tNWvAWY1azIXaPU1ck7q8vMbZp/aRwVmH4gbB6W3V8C
3AzdomUwDXecr89HPE623e7Z6fsrFozwGgt4VKf7xfA4DA2mdsC3qu7xaUsfJLuC
N6y0AYDAk8QLns++qZ0dQiiUF1FgHGNCgbJoNAg8w1z+HbmIqVLDI+Dhu23l1Bdq
K7eG187w+pG6X275U/5kZaGP8tJLTIWKt2AZOqy6seOYJYGy/EfLiY++tmLL22l9
kMnEn2CXykip/gF4prSRx2QuUxSZnWlySidU8GgJrIaE40k7EJ7cfO1gZb1Jaxgo
nURdS4RLY7gnnwpdh2372POi/CoMCZqUgVJ+3CO/8EqJm8E7O6p/DjaHbhTT1h9d
eB5kSpSVWqyE3uPDVUaGzpCZsot0Y5INHprW2Z0kWUvUTVjan6oUyb/g3a+cL5/j
rcNotj7wgSG15LpTFqqPtB++mb08lgzn4Niooy3bh4cgkECcbYlRWd5HlRKNxaYi
YIw79eCIAeUAc33qcx7nNK6LHjHd43qkIQ5PVxuGzbniYcXvPY4N3kxNipsa+cMO
xC4rNoh+Moy/0GAkDNFDh3gqCc3AMB9ueqk6+YubJ2sJ3/6dqAqYj91r4dyiBD0h
JphTrwhXA3PphAWgHOK6fyMaQNWAmrqZ2KJQXhUe6GE4Hg8UcvU=
=EF6O
-----END PGP SIGNATURE-----

--otwQC4KmlFK+GLut--

