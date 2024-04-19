Return-Path: <linux-kernel+bounces-151657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA2B8AB1A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8DE1C21D03
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37F2136985;
	Fri, 19 Apr 2024 15:18:15 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EF913248F;
	Fri, 19 Apr 2024 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539895; cv=none; b=kVaTA3BicGgJYBb/UDKjWKn0KDLvDCThO7Av/6VG0NKwt4Wxe13D1lajIPFd/LhOlHp7fOJ/Hg5UOdYpYXoDsaXuFxI3nPqO9DNuoKtxL7ozil+VPa0Q4sC/LxzWg9ViHKs7J7LuNyDhXYYza2HE6fODUFu5L7kshLLP0OwNtw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539895; c=relaxed/simple;
	bh=v06x2WSznbdbSphBXwDn6u5OwE4X/omoi3S7OzDA8r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZqIMdGlSyeqMY3l+TcXIefotFEFpUWCmxWFW4c5Z/9TKKaAY8z3m0akc1Jmf4iFYsKNg7IMr0+emnQ5W/0iJ82kicyJzB+WNJsTYTcZRVboryHLtQ1T0U0cMh+xV13J609hsX6y+vmsbYPWrVeuSTK96Wc6jOjwBohqBrUz+Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 445DC1C0080; Fri, 19 Apr 2024 17:18:11 +0200 (CEST)
Date: Fri, 19 Apr 2024 17:18:10 +0200
From: Pavel Machek <pavel@denx.de>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Pavel Machek <pavel@denx.de>, LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [ANNOUNCE] 5.10.214-rt106
Message-ID: <ZiKLMkOZhU6f7YXd@duo.ucw.cz>
References: <ZiF_h-W4jgLiRag5@uudg.org>
 <ZiI4Hq5yfrOUdbHk@duo.ucw.cz>
 <ZiJJeiAjLAk3YMZz@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4VRVcZfQOWi2/2BF"
Content-Disposition: inline
In-Reply-To: <ZiJJeiAjLAk3YMZz@uudg.org>


--4VRVcZfQOWi2/2BF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The tag is there in the repository:
>=20
>     https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.gi=
t/commit/?h=3Dv5.10.214-rt106-rebase
>=20
> When I released 5.10.215-rt107 (and its -rebase counterpart), 5.10.214-rt=
106-rebase
> was no longer pointing to a commit inside that  branch, probably why your=
 git
> update didn't get the tag. You could try a
>=20
>     git fetch --tags <rt-stable-remote-name>

Aha, thanks for the pointer and sorry for the noise.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4VRVcZfQOWi2/2BF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZiKLMgAKCRAw5/Bqldv6
8tbCAKDAvtniYIhg1C/iRVDr6CX7JIEqzACdFYmLVlEV11QqPIXb0nD4IDwZ+b0=
=uV+I
-----END PGP SIGNATURE-----

--4VRVcZfQOWi2/2BF--

