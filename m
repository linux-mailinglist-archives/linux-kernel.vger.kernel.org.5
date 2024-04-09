Return-Path: <linux-kernel+bounces-136147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C05E89D07D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20921F24F9A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975E454670;
	Tue,  9 Apr 2024 02:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LqqIvbg5"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12665CB8;
	Tue,  9 Apr 2024 02:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712630955; cv=none; b=c7AOLOfat4nRQn4EBgT04yq2Mlvu6z6kRnWrrM+gVwSTOA/HiHUAZJyFUelXr3KN4Z7ioVVr8TguJe0Seeq1mcfr4ApimDv/HM4Svagpj2ZpIIDAm0HOHrrfly53aYsAYOVaOdWwd6zVBrh/l/P69AOtzqdChBbolAoxKyCknEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712630955; c=relaxed/simple;
	bh=+PZ4jR/2BJ9XxrBr7GMAojOZLzi+GDA/AyD9AFNbCSA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bwUV8qXGG67VzZ6lby7OZu1jmaUgv3+yU7ATvtVPLBNYXRqAyPJvZElyY91jedKNZ39j0sQY7mXBOG0kF6YcBGl3hsQAUJNDesNGdIhnTG8LUTNE+2usIkdZGCpzW5CEanfPJc2/eSqkncgLwwksSiMmUuNlT9tQyKZohMIwCEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=LqqIvbg5; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712630949;
	bh=yHzw5mT25hvytC+YyTaCleTf54zFCnzDzIb2I1F1nJQ=;
	h=Date:From:To:Cc:Subject:From;
	b=LqqIvbg5CPZhUFx6/UmcBgvr/lyRtCv8YwoNaJ/4Wdi8aN9S0FoMMYkTVeEXy8zVa
	 c2OeOPEFOD1LXzeXqJ/nmqburL91/+D6pHyJamLFNUijys+azqbUcRrWjvSydpL0hD
	 j0hQiTDDLwwAagDrybdva0NadCHx8r7aSm8c1mMSwsr82r3QGfuvXfW0GDg/9gYo2X
	 ApL2YwNr+xsQmZ8Fx5Kux54gu6VGYj47IMIQYTdtd44a58M5GAFgehptYG40br0MOH
	 8vy1w9dXlVcmhWr3S42nOhlBXM9hk93cXUw5g0qBeRI8sa1sg4lJe7VkMgAW4/lAps
	 FiTE8fGRH8uqA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VD9QX6gDcz4wcC;
	Tue,  9 Apr 2024 12:49:08 +1000 (AEST)
Date: Tue, 9 Apr 2024 12:49:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the tip tree
Message-ID: <20240409124905.6816db37@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FwkJqhkKj31640k9.uYOYpn";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/FwkJqhkKj31640k9.uYOYpn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from <command-line>:
lib/vdso/gettimeofday.c: In function 'vdso_calc_ns':
lib/vdso/gettimeofday.c:11:33: error: 'U64_MAX' undeclared (first use in th=
is function); did you mean 'U64_C'?
   11 | # define VDSO_DELTA_MASK(vd)    U64_MAX
      |                                 ^~~~~~~
lib/vdso/gettimeofday.c:41:49: note: in expansion of macro 'VDSO_DELTA_MASK'
   41 |         u64 delta =3D (cycles - vd->cycle_last) & VDSO_DELTA_MASK(v=
d);
      |                                                 ^~~~~~~~~~~~~~~
lib/vdso/gettimeofday.c:11:33: note: each undeclared identifier is reported=
 only once for each function it appears in
   11 | # define VDSO_DELTA_MASK(vd)    U64_MAX
      |                                 ^~~~~~~
lib/vdso/gettimeofday.c:41:49: note: in expansion of macro 'VDSO_DELTA_MASK'
   41 |         u64 delta =3D (cycles - vd->cycle_last) & VDSO_DELTA_MASK(v=
d);
      |                                                 ^~~~~~~~~~~~~~~

Caused by commit

  c8e3a8b6f2e6 ("vdso: Consolidate vdso_calc_delta()")

I have used the tip tree from next-20240408 for today.



--=20
Cheers,
Stephen Rothwell

--Sig_/FwkJqhkKj31640k9.uYOYpn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYUrKEACgkQAVBC80lX
0GwVWAf/YHdpxwSlC4asPHFj2Qfm/xp6rKeL+lntzfN5Um+68L+RRgb+DnKbt274
7gA1YRr6Mn/MN70EiWhghrrro2HKSLqFWUh0oiZdzg+m3rwrNlWQH29BqfwPlZJo
Ie9kGMWam+VS484ttULEIuOyAaBmag+IO+37tby+mQ50s8pEiOpH62H43xhAD1IC
KAOji4sF22LvGzP7TIDgFgyMSgoKKYkgiBoiUi1ePON9/+7Xwg8hV3i+q4G17Y+W
VopPMlYEQCvnFLUeykGr3xrgYLPOu/xSnPHvnMlv7r/zvzzGHifK2fRTyD+nxPal
bjuF/845s/Jm0QUm0Vjz3SWVUZkmYw==
=6E71
-----END PGP SIGNATURE-----

--Sig_/FwkJqhkKj31640k9.uYOYpn--

