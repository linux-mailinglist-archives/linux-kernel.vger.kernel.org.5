Return-Path: <linux-kernel+bounces-94628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBC487425E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1E12860F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0F31B968;
	Wed,  6 Mar 2024 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FqOKdVki"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B065E1B941;
	Wed,  6 Mar 2024 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762729; cv=none; b=bIvVn8HSBtOYlsUENdqo1ICedoF5j/rVsmNJKsuHTXLpfnFAm2U/GalD7y9g4/+1ylgQcDlFG+i+lcgQRUi086yqtA2AcnAG5sNXUEbkaCmUOz6yPL2v58uEO4J/7yD4AnbX7KUHoR8WajGMTWvLrjklV+IuIa1mOSJUhVvIIkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762729; c=relaxed/simple;
	bh=sFCrcJfe3GWfAni0vKXs+57THCQF6p5EsjvUzbOtd/c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qqCQ/bGiWcOo8s7l3TYszDPl/Yq3IJ440qHl0RXdmGuWii3wPZVkaBEA1fzeyYG9NTbikVayWti6fjNDnm5vdvOsqw7QiemrbFPAdSEpnxluA3+jjmLzEWsM0AsGKNz6lC/gUe5YOWuDpkSDJxlP4FM4Q92lVmovi58zXTuKCoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=FqOKdVki; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709762726;
	bh=EJGSxR3EOBEByhMkVaJ1i/CBJY8Ts/5WzF5Ku+ZJea8=;
	h=Date:From:To:Cc:Subject:From;
	b=FqOKdVkiJU4Ycpl10e1BFJ7Ez6yBReQScQ1sdJdw6MKvA2PmSATlURXlHBRK++34q
	 7IwF8ZMi+BHjwg1wWfMJcYhP/FAcGk08DBLnGxE8RM01H5go+WnNTXVDEvorRmiH9O
	 HRHb7C7ay8Fu6u84EdR3p+JVA1vxTQq7DifMe3qbPS0/neCkHV0IEKPPE8wpKrk6r5
	 nMDQ1CSfFlcQemha8Ib0fHBNjCU0CAo/D1qyufYJqkVObAaeSQBKT0KdRsPlVjkJgY
	 tEc+gAEuwYoLwj4SW4UIzXEwogH6JBWnllOKlLc/dYUk5DSBHQF5+iSscL+JWXJIKG
	 zISijTxJV7SyQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqmhQ0k7Vz4wb2;
	Thu,  7 Mar 2024 09:05:25 +1100 (AEDT)
Date: Thu, 7 Mar 2024 09:05:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Perry Yuan <perry.yuan@amd.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the pm tree
Message-ID: <20240307090524.6635a4d8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0b4xJs+wRp5HjKj.zGk34Ei";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/0b4xJs+wRp5HjKj.zGk34Ei
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  a51ab63b297c ("ACPI: CPPC: enable AMD CPPC V2 support for family 17h proc=
essors")

Fixes tag

  Fixes: fbd74d1689 ("ACPI: CPPC: Fix enabling CPPC on AMD systems with sha=
red memory")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/0b4xJs+wRp5HjKj.zGk34Ei
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXo6KQACgkQAVBC80lX
0GxNYAf8CDg/3nvoz24HyLl/Zxogs5HK55k8Z1QSxHs1aD4AnBXr41SMwMojsQwM
H67+uq7ynIw8jb5KrT5UKFEOybQtYjihrf+o2y2MbE4ibMXsHpXewvy+QKcDoNgJ
vHKgEAxlteueZMkYb3hcaNq247j1YwE5u8AKoW1LnATqcXJK86e7J/4gYod5cCOv
mBNLQ3p7nyO1cc/S7CgnLP2FIQd00wKBkKGfdHCGVzk2wq1miPHKXi/xG68pN3/T
MJbZK4pEsI54ButGEqzZwkt1RFGeogKmwSgzR68CGbdfhpZoncWJX9yZCsr+iilj
jWAnI78g6U6rCd2/N363HjmXLtlF4g==
=7kid
-----END PGP SIGNATURE-----

--Sig_/0b4xJs+wRp5HjKj.zGk34Ei--

