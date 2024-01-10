Return-Path: <linux-kernel+bounces-21723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1C0829354
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8EF2288010
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 05:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0CCDDD4;
	Wed, 10 Jan 2024 05:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZnXy1z0u"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C92CDDA1;
	Wed, 10 Jan 2024 05:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704864780;
	bh=QDG6A3xdwEqqn39w2kNHtqD8vv5vKZsYtvphKyTJK7Y=;
	h=Date:From:To:Cc:Subject:From;
	b=ZnXy1z0uquJ5DSOr3QEwEhngshTLzo01YDK6DecJV67HYwvfq5K05Daj3+qyDiKC3
	 SFjpAAnvAfV92BX4mtyCmGuQG6KurpUA/ZYx4y1HHvdP0I9mtn2yMi3zba8AbKW4z6
	 5w7wLx0DbKgaNIVzq3KcMkrmUcub8kCFWBobpm3+xoQe3yzNwzjoWRi3wwx4p1hxAz
	 XPs8uQ/Zi6MX6OvvVbwUozWjuKN1bN4STidFc+0JmwEyhkKsWD/2PP+kNhlOUWlnfB
	 k9Aqi6KgvQcwHB2WXtqwcovKsa7ojLhcfz2+5LbftxXPA6bICCZabY14Qu7ZYHpj0T
	 RiK56iqu5fgZA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T8xK80kDjz4wcZ;
	Wed, 10 Jan 2024 16:33:00 +1100 (AEDT)
Date: Wed, 10 Jan 2024 16:32:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jan 10
Message-ID: <20240110163258.7539a837@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OIjhBw2W1BbmVd3L7m6S6BH";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/OIjhBw2W1BbmVd3L7m6S6BH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

News: the merge window has opened, so please do not add any material
intended for v6.9 to your linux-next included branches until asfter
v6.8-rc1 has been released.

Changes since 20240109:

A warning in the drm tree build is now a failure (I stopped building
with CONFIG_WERROR=3Dn), so I applied a supplied patch.

Non-merge commits (relative to Linus' tree): 10859
 9890 files changed, 519238 insertions(+), 240327 deletions(-)

----------------------------------------------------------------------------

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There is also the merge.log file in the Next
directory.  Between each merge, the tree was built with a ppc64_defconfig
for powerpc, an allmodconfig for x86_64, a multi_v7_defconfig for arm
and a native build of tools/perf. After the final fixups (if any), I do
an x86_64 modules_install followed by builds for x86_64 allnoconfig,
powerpc allnoconfig (32 and 64 bit), ppc44x_defconfig, allyesconfig
and pseries_le_defconfig and i386, arm64, s390, sparc and sparc64
defconfig and htmldocs. And finally, a simple boot test of the powerpc
pseries_le_defconfig kernel in qemu (with and without kvm enabled).

Below is a summary of the state of the merge.

I am currently merging 371 trees (counting Linus' and 104 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.



--=20
Cheers,
Stephen Rothwell

--Sig_/OIjhBw2W1BbmVd3L7m6S6BH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWeLAoACgkQAVBC80lX
0GySxQf/ThnjLf0oloTSSnt8DoDRdditgNyVXdYzqcFxdTcXg1ysknJ5CF+xNojs
rLIQzseQd5xbhAYD5/BsmL1EZ9sNj/SMaYMIZ8oEToJLTP5AAe9KfFEnkkrWf87e
60yiDoOUsJPwIcz3Kg/cej6dK41D05OnB5mfRTmLPAo6IPp2bGCRsx/4brNtAAWi
fPWyF3KAN/RS/ut4Z+zQoQu1uKmRbJ/228g0qN1alWhSQDkHxds/F1E0Z1sRe56b
k0R9JNu2Q15SLPgQHYu4dZAkulPGd8aN4RxEGh/XSK8xTQklx6FDAKBO/E28hJXf
Y17tyPdU8E/8EM5gZG+o6L/hLNtX4A==
=dfvt
-----END PGP SIGNATURE-----

--Sig_/OIjhBw2W1BbmVd3L7m6S6BH--

