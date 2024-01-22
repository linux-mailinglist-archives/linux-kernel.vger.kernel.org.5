Return-Path: <linux-kernel+bounces-34126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDD9837400
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8705728DCDC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E0D4779C;
	Mon, 22 Jan 2024 20:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CtculEr4"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460CC3FB3D;
	Mon, 22 Jan 2024 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955953; cv=none; b=rLRqyRpz9ZuHR1/km/7sWQSbiDU4KzgzcfSuK7tQaCIFu/GVOEHLKgJ/JOQcdsMglsm0rjp0A5JKaQQH9iTBvBEUXELw78jSUnLONLpV8Lt5cOdIlIOsQ9Eoz2I07oc4V0ZrQL5Tij9VIUu0yke3Im7nfGqPkR9MdEOmIKvTHSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955953; c=relaxed/simple;
	bh=Tu4VrZDY7EI4nayK8NLWcr7vdYA/pNCCWSTBO/UZBxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BShl0r2UOJLAzJ18njEsuZdoY2plecCc5beKt/VEw1JGnMsgk9vh7vhxdguzf7y9KvaMtDC2/lIdwKAx/dzNlt9NlylWgjfbtAbHCPvnrR9PvwGK5ShvtfdHtqUnINUfTsPI+YisNKku6xBk9aHbwbP6CpkgCWlA5Xo0qobQjSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=CtculEr4; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705955949;
	bh=BCEd7w/4X/G8T7MnawwU202rAIPdkECpqauMjfgff80=;
	h=Date:From:To:Cc:Subject:From;
	b=CtculEr461b+Km9LduKUAt6Cb7FsYHMpqtCs171kBGPpfP39iCGGzbu7hkNel++j/
	 zS3e5CefRMHyH27DiqTh/2uJZwS6m2MpqZrgMWqTpUHLnulUuLp6mvlzKc8AxphOu1
	 7UUcNAEWE0+/xgvqCkhZjo/LxnkzoYMUP5D5BWviKr2DtRj5E2PGj0HHRpGVtTB+MR
	 W/fzLq3lZw9F98k4b2HgqprSrnsKN68DUuaHLEtHVxqNtnuaayl1umoDXoi0x+f9+o
	 dwd3jHJNoUZ47mRGixJGuZwfnnAA0rKAOVau7UeGHw+tYYJOeZ6HIR9G552NTwR3m8
	 tOBzYU1qjSwGg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TJhs94dzkz4wcH;
	Tue, 23 Jan 2024 07:39:09 +1100 (AEDT)
Date: Tue, 23 Jan 2024 07:39:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Conor Dooley <Conor.Dooley@microchip.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the riscv-dt tree
Message-ID: <20240123073908.0580509b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/f0katS1ah5M53pMH4m2EWNh";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/f0katS1ah5M53pMH4m2EWNh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  89e69872b909 ("fixup! riscv: dts: starfive: jh7100: Add PWM node and pins=
 configuration")

is missing a Signed-off-by from its author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/f0katS1ah5M53pMH4m2EWNh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWu0mwACgkQAVBC80lX
0GzVFwf/TGZ3b9t77BcXHxpazfM/GAFyCvaPc7taC//n6TL2KJLCoETQUXfmtrHD
ofkbDJVPb3VdE7x3mRVrXWK6UxSf9eB4udyo+TAP+jzoAqOYvwtAVQk6e3bjUzCx
qrlzfRAVNeR7SQEGvS6Mf0yWToFloKRQT/pk5eZKd3yV+ahko6osUKreBdPTUMwM
O60QXIlqswYWMOGM7DvZN9LGLgu81bAnEjLJNim6RqXzlBPZNPTi5skoQkGIuDxD
rm4KnE1/UnPSvCJMd/ou18efQGJH/L1Laz+YCTwLFRhEfO4bTGQzIoAEMJa5s7mJ
4nk26kjqAftbgnUcWry/GSuNhBp2/A==
=hpeO
-----END PGP SIGNATURE-----

--Sig_/f0katS1ah5M53pMH4m2EWNh--

