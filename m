Return-Path: <linux-kernel+bounces-17355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4905824C35
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F181F23176
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1031FB2;
	Fri,  5 Jan 2024 00:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XBO/jfZD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40971FA3;
	Fri,  5 Jan 2024 00:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704415398;
	bh=B3VvRKT7Vpp6a+w7wdq1LM7SVAhg25085ZnjiGYLjME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XBO/jfZDMMdczDta5F2TtDDEGnMS8VSwwDXQ+STl7oI85E35l5CS7Nrf7T4koPrqq
	 KgoXBgJZy0W5JKPFgyOrtcJqU0r6F+gVBks5RnZMZ4RqWGC1fHrKHxg+ckr8u45yxG
	 hcRXP8HRzz1NChJqfUzsMBv4QRIW0mkl0UdU/0VfEorev0FatDNLeLBcCNlkEv2bMz
	 CjUH2+kcUdFQJ030BfR2v3XtLdpOI+sNX/toLQjlgs/Z+7FAUmW4ihc7KrWzssT6OP
	 70/XyAkvBBWD4yiY6HkU8iZUDaa0adU1op9Y/jPA4yvmqqwytXEd49ATux/t0B6K25
	 DvcBvXOp2HV4g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T5l7B0p1kz4wcg;
	Fri,  5 Jan 2024 11:43:17 +1100 (AEDT)
Date: Fri, 5 Jan 2024 11:43:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Linux Next
 Mailing List" <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the cxl-fixes tree
Message-ID: <20240105114316.03aa2a8b@canb.auug.org.au>
In-Reply-To: <65972daf5c889_8dc68294d2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240102023218.3cd3e4ea@canb.auug.org.au>
	<20240105085306.60979082@canb.auug.org.au>
	<65972daf5c889_8dc68294d2@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//JOj3WKCn6vCSF+63sDrcPI";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_//JOj3WKCn6vCSF+63sDrcPI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Thu, 4 Jan 2024 14:14:07 -0800 Dan Williams <dan.j.williams@intel.com> w=
rote:
>
> Now fixed, but the divergence is just odd. Most of the commits were
> identical but below ones were different (trimmed git range-diff
> cef295b57778...5459e186a5c9). Not even sure where I would pick up a
> bunch of commits with edited changelogs.
>=20
>   7:  6eb467e165fc !   7:  f40f939917b2 platform/x86: hp-bioscfg: Fix err=
or handling in hp_add_other_attributes()
>     @@ Commit message
>          used by all the error paths after kobject_init_and_add().
>     =20
>          Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
>     -    Cc: stable@vger.kernel.org # 6.6.x: acfff1760745: platform/x86: =
hp-bioscfg: Simplify return check in hp_add_other_attributes()
>     -    Cc: stable@vger.kernel.org # 6.6.x: 9950a86160a1: platform/x86: =
hp-bioscfg: move mutex_lock() down in hp_add_other_attributes()
>     +    Cc: stable@vger.kernel.org # 6.6.x: c5dbf0416000: platform/x86: =
hp-bioscfg: Simplify return check in hp_add_other_attributes()
>     +    Cc: stable@vger.kernel.org # 6.6.x: 5736aa9537c9: platform/x86: =
hp-bioscfg: move mutex_lock() down in hp_add_other_attributes()
>          Reported-by: kernel test robot <lkp@intel.com>
>          Reported-by: Dan Carpenter <error27@gmail.com>
>          Closes: https://lore.kernel.org/r/202309201412.on0VXJGo-lkp@inte=
l.com/

yeah, very weird.

--=20
Cheers,
Stephen Rothwell

--Sig_//JOj3WKCn6vCSF+63sDrcPI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWXUKQACgkQAVBC80lX
0GzNzQf7BJeP18IqLxHeh0R+Bj4x2t3AQaTEjqsiQJbeHAMBtBhQzmu4/+K5iTIJ
6FEn0jLRIIgr//QB6fUufqP49OpvV3QH97I00pbRDdsraN4564LL+Te4yPzO9aSo
a9JeTv5D1f58u+FK0GtOdgqtoF2cct8Wa9WaER7NhGM/pb0CbILxSsAsuYpxKyBL
ojgetNMHRqVRuOZviGX6joK+x136GnQZYTiNeJmAO3iPj/+mJmXIrqFH1By8bteD
nPa5vK8SpnORarQam6UhHUEdTnD1+2JTD5Eb1nYDodTL3kj9k+x6KdaggjI7n6ZM
YxQsdGWwNry59XUyw47ZtuNJjxiiww==
=UVNz
-----END PGP SIGNATURE-----

--Sig_//JOj3WKCn6vCSF+63sDrcPI--

