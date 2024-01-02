Return-Path: <linux-kernel+bounces-13973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B706082163D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E390281AF3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B538EC9;
	Tue,  2 Jan 2024 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XrGzfJQP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB7AA4A;
	Tue,  2 Jan 2024 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704160806;
	bh=Wr0LixTHtpYPMPZfVd/YrIozZpV85aL/yHY16ImIZ0w=;
	h=Date:From:To:Cc:Subject:From;
	b=XrGzfJQPvWY30qVguv2ZmV1+znofAt5kO/saEeJTuPXcwj6oC/3A/a/p4kFzk6huQ
	 KLZwJiQN5zRBf8hAO+Tb4r19KXX+J+xGOieFI+YPqBmc5WAT+NdDD62pIvyT3b+4ss
	 hn1L0q8NVSlz4Irp+79iTk9Wg3uwcCd5LsOMh1CHVENRr6v4EnDdpb/o9AgR+ZNerE
	 Smh9bRU+8Tp1IgrXBbtmA8MgIqt4H144W3muJB03OLTvPeD76Yd8Z8aj+Z7j1snTrK
	 4BNfkFeMV5sxQCwLPH+B4elDOLk7SDY2xNoZfzMz70hHU4OM/ZYk25ZHT7xvfflPDz
	 wq5VOlpYXQ6EQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T3wz94HjMz4wx8;
	Tue,  2 Jan 2024 13:00:05 +1100 (AEDT)
Date: Tue, 2 Jan 2024 13:00:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anup Patel <anup@brainfault.org>
Cc: Andrew Jones <ajones@ventanamicro.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Subject: linux-next: manual merge of the kvm-riscv tree with the rcu tree
Message-ID: <20240102130003.09d52290@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dyg0UfZdeGhEY2A+kyZH/IV";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/dyg0UfZdeGhEY2A+kyZH/IV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

FIXME: Add owner of second tree to To:
       Add author(s)/SOB of conflicting commits.

Today's linux-next merge of the kvm-riscv tree got a conflict in:

  Documentation/admin-guide/kernel-parameters.txt

between commit:

  801f246637ed ("doc: Add EARLY flag to early-parsed kernel boot parameters=
")

from the rcu tree and commit:

  323925ed6dbb ("RISC-V: paravirt: Add skeleton for pv-time support")

from the kvm-riscv tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/admin-guide/kernel-parameters.txt
index cfeea158a4c6,a0d9259e4857..000000000000
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@@ -4000,15 -3980,14 +4000,15 @@@
  			(bounds check bypass). With this option data leaks are
  			possible in the system.
 =20
 -	nospectre_v2	[X86,PPC_E500,ARM64] Disable all mitigations for
 -			the Spectre variant 2 (indirect branch prediction)
 -			vulnerability. System may allow data leaks with this
 -			option.
 +	nospectre_v2	[X86,PPC_E500,ARM64,EARLY] Disable all mitigations
 +			for the Spectre variant 2 (indirect branch
 +			prediction) vulnerability. System may allow data
 +			leaks with this option.
 =20
- 	no-steal-acc	[X86,PV_OPS,ARM64,PPC/PSERIES,EARLY] Disable
 -	no-steal-acc	[X86,PV_OPS,ARM64,PPC/PSERIES,RISCV] Disable
 -			paravirtualized steal time accounting. steal time is
 -			computed, but won't influence scheduler behaviour
++	no-steal-acc	[X86,PV_OPS,ARM64,PPC/PSERIES,RISCV,EARLY] Disable
 +			paravirtualized steal time accounting. steal
 +			time is computed, but won't influence scheduler
 +			behaviour
 =20
  	nosync		[HW,M68K] Disables sync negotiation for all devices.
 =20

--Sig_/dyg0UfZdeGhEY2A+kyZH/IV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWTbiMACgkQAVBC80lX
0GyzLAgAi6+RTCnBgDWiBV21hyLu5jfsEDCOlbDnttME50/1OEL890nrnjcZdmOG
1imqG2KKR9mpxzkbQPjzrXlnl+FivHm3DAYAM6UmZBPZjIVHhOoM3OX5W2ZZKnEV
M63e7tcahietx44/DA63oAAszMdqUASd0clAZfEaPmbSR4T7z9evzH4+cUmeaBSU
5XTvVlfaoEE9lEAXZ85hRjaXylnxxjCz8wdBk+03Nq9a+Q+LE25xG8Y7tUPib57C
7neo0/xU2YvuPWd82ZztvzlPpi52B3S9hnd0JUx6SNCG1bghjaZNUrUwRW/tPySN
xkHRdaNqzuJkK1wfEnz0Iql5O69T8A==
=NXL0
-----END PGP SIGNATURE-----

--Sig_/dyg0UfZdeGhEY2A+kyZH/IV--

