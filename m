Return-Path: <linux-kernel+bounces-151229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 382398AAB6A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D4A1C21B57
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A08978285;
	Fri, 19 Apr 2024 09:23:47 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1486071B3D;
	Fri, 19 Apr 2024 09:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713518626; cv=none; b=PuLnaDNY7RujgGxAWK26FEk6POC0dfDA6ygMXvj6z/of3+LwDW3dKBKUq1TcFT15gZ3Olg9JytS/njKw5QX0qf+prA3FVeWwHU65AF2gaPmPFJ4G0DsTelySo4Y2TTQ/1rSHZnXshCfTiLf5ckmGngVTzQiEeBJi0AqWB259HrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713518626; c=relaxed/simple;
	bh=7oQgKasaiIXrFSLE1vnpg0WTtEvKFBCHkYPfaaZWzyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TI3O4jAVQYj2IIlDkxpZ69AmNnACiFODc5navQQUIWGR5WP763+YbE+ewyTqxfpFzz+G+0fccs2uv77NFnmBp2cbFv4x7h2GncDbMJ8SnzZs2ogcSUXj5r0gREbcD6yw73jCqArO0TYm+QWuOHxgdZDYXJzwoMJm4lcPFa6RCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 14EB11C0080; Fri, 19 Apr 2024 11:23:43 +0200 (CEST)
Date: Fri, 19 Apr 2024 11:23:42 +0200
From: Pavel Machek <pavel@denx.de>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [ANNOUNCE] 5.10.214-rt106
Message-ID: <ZiI4Hq5yfrOUdbHk@duo.ucw.cz>
References: <ZiF_h-W4jgLiRag5@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qtP2tI/r2sfiYRz4"
Content-Disposition: inline
In-Reply-To: <ZiF_h-W4jgLiRag5@uudg.org>


--qtP2tI/r2sfiYRz4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm pleased to announce the 5.10.214-rt106 stable release.
>=20
> This release is simply an update to the new stable 5.10.214 version and no
> RT-specific changes have been performed.
>=20
> You can get this release via the git tree at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>=20
>   branch: v5.10-rt
>   Head SHA1: 3d208061796d4addeb543c78e0a4ec769b6ce6b2

Thank you.

Could you also push v5.10.214-rt106-rebase tag to the repository for
consistency?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qtP2tI/r2sfiYRz4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZiI4HgAKCRAw5/Bqldv6
8lvlAJ9lMHOrYl60oSK3PfbbjPJMuNEfxwCfV79bK4bZ2FxSjBgFGjLNF4bUDGc=
=qwcK
-----END PGP SIGNATURE-----

--qtP2tI/r2sfiYRz4--

