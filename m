Return-Path: <linux-kernel+bounces-17513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9C1824EA6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F731C21D4F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A457134A2;
	Fri,  5 Jan 2024 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hbugIj+T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526847E;
	Fri,  5 Jan 2024 06:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704436434;
	bh=3DRO/eWrKcHpNyAkV5qHqs+s6/dxJLWm4FpUztjVOi4=;
	h=Date:From:To:Cc:Subject:From;
	b=hbugIj+TDNgLHnBNvD1jP9sNAgtGD/F8arh5zM7kwX363J2LWvDVYqMFvTvVPdruE
	 W5CkMxv0T5nMmcL2+X+yLNvG2ksxClidZU4GEML0uAib5EXegcFER3doY8/5pLIy9g
	 qNn8HxnGsoU2s10wKkeHPTtZbDksrPFaTTNo+Bo02LEbvIOpbyUsgyQJo+48+P1gju
	 M/AEv76I5RW5MyV7wD2hn7vkSyWCYakkdxH4wbhBJYwXh39mn+U0lqmw9sqczJKXdA
	 BcWP138hxhBRaDV+tndN/I0nkNWfMeHJkkaSyum8uvMBj8VyCblckD6BgwLPO+APNZ
	 h0yofDqkU0iJg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T5tvk0GG7z4wc3;
	Fri,  5 Jan 2024 17:33:53 +1100 (AEDT)
Date: Fri, 5 Jan 2024 17:33:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lee Jones <lee@kernel.org>
Cc: Florian Eckert <fe@dev.tdt.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the leds-lj tree
Message-ID: <20240105173352.6ce1a546@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W=TnvxnG=4__94fWKuZ2.tS";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/W=TnvxnG=4__94fWKuZ2.tS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the leds-lj tree, today's linux-next build (htmldocs)
produced this warning:

Warning: /sys/class/leds/<led>/rx is defined 2 times:  Documentation/ABI/te=
sting/sysfs-class-led-trigger-tty:7  Documentation/ABI/testing/sysfs-class-=
led-trigger-netdev:49
Warning: /sys/class/leds/<led>/tx is defined 2 times:  Documentation/ABI/te=
sting/sysfs-class-led-trigger-tty:15  Documentation/ABI/testing/sysfs-class=
-led-trigger-netdev:34

Introduced by commit

  5b755ca677db ("leds: ledtrig-tty: Make rx tx activitate configurable")

--=20
Cheers,
Stephen Rothwell

--Sig_/W=TnvxnG=4__94fWKuZ2.tS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWXotAACgkQAVBC80lX
0GyGiAf9E081E7mNspakuMqy8rZ3zfilufgnGGxGU7ZAvJ+siKUXTlfKNeDEoQhK
slTt46HFY0RzHGGhwkVaSQislFzCv3CDU606QQuero+RiiZ+ZCYbX5M0jjawtZvC
mBVvAYaBWyPNp43MeqrZ2GUrwoir/Nj8HHssxjpdUeQ4eUrJTuivJFZ02YddYJa+
1DfzRmM3VcyWqr44+9RhIHe8B/tv4ztazUQJ2mqkCDJn7fnTQ9zB312HDAG9bzrD
8RA+Lu9lPdM6CCVS4/I9vWDfA0WqM+uRbc82ItlSgJV8TqjBWB2eI1UMtXgzGPux
478xWeGZ7ogA6aHOEcXPOYHax5ZomA==
=MNZz
-----END PGP SIGNATURE-----

--Sig_/W=TnvxnG=4__94fWKuZ2.tS--

