Return-Path: <linux-kernel+bounces-19011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A851782666C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 23:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4206C281AA7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1262A12B71;
	Sun,  7 Jan 2024 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uN07giFm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE793125A5;
	Sun,  7 Jan 2024 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704667803;
	bh=qeeLPSRcaG41tQhl/NP0bNXSAdBbnIiIqEBXhjiAZ+k=;
	h=Date:From:To:Cc:Subject:From;
	b=uN07giFmwlOjPs4lBnyOkaC5TA4v5X37vMMIdRMw/Nyp3AEsPSafZnvezRdsTXljI
	 XTVxyR9YXHWPh045csAqjOs7VU9EmUXG5xXXzqvqSDhVfAGMrQvhDqTIBtfOR7RkfJ
	 gk7LS4JKUqMPTp463c9TMciyVvpowKHfNOHW2E2KsTCKn8N5cx/vBdF7rDtK+1tkjn
	 eYhT77SaARarbn509X6ZojxmvNqa6y90AJ6mmX0g0h0FpgiHZKJ/gAgc0An6vwMnGv
	 uqfwAgtuit6OZ/AYRgFg6CAKVBRUaf95jO4jG6eFqhRBu+NpspmfY4241CdUfStb/q
	 +V2nyYld+q81g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T7XT34KFrz4wcc;
	Mon,  8 Jan 2024 09:49:59 +1100 (AEDT)
Date: Mon, 8 Jan 2024 09:49:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>
Subject: linux-next: manual merge of the risc-v tree with Linus' tree
Message-ID: <20240108094957.2cc727e0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qgD8engf.b9+KAHyIK2gWbO";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/qgD8engf.b9+KAHyIK2gWbO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the risc-v tree got a conflict in:

  arch/riscv/kernel/sys_riscv.c

between commit:

  777c0d761be7 ("RISC-V: hwprobe: Always use u64 for extension bits")

from Linus' tree and commit:

  53b2b22850e1 ("RISC-V: Move the hwprobe syscall to its own file")

from the risc-v tree.

I fixed it up (I used the latter version of this file and applied the
following merge fix patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 8 Jan 2024 09:46:10 +1100
Subject: [PATCH] fix up for "RISC-V: Move the hwprobe syscall to its own fi=
le"

interacting with commit

  777c0d761be7 ("RISC-V: hwprobe: Always use u64 for extension bits")

from Linus' tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/riscv/kernel/sys_hwprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprob=
e.c
index ccf61b040536..41f45acb156b 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -136,7 +136,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 	pair->value &=3D ~missing;
 }
=20
-static bool hwprobe_ext0_has(const struct cpumask *cpus, unsigned long ext)
+static bool hwprobe_ext0_has(const struct cpumask *cpus, u64 ext)
 {
 	struct riscv_hwprobe pair;
=20
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/qgD8engf.b9+KAHyIK2gWbO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWbKpUACgkQAVBC80lX
0GyuhAf/V3Iydy1RkyrNTOhogC/nFKraBax2Z1CK0wX9YtbZz0SkPbIbxPv63ogg
o9Uy+HuCt//TwoATGnnVZdCplDCdZkon9ZzYH68QgYlGJuXQjn7YZmDv6K+P6AV+
ySAXjSX41seCWlDcXf3OeNL2tQVWKEFQWd5+1dCanrJJb5sJc9le3dPSg5y4GD6w
DFC9nrd+6FFhyJfuvncA4A9EqIk4QiK05QV+cwqVRyUvRxBalJRvCsKRtcVyq8EL
XePLUsyB6062qGg1qm5IQjWRV2VB/9YAguoA0rzDXd1gqrBFNIrQcHpyU4E/FDaA
9QyLpP56OY4rrrXDia9o7qcv/jorcQ==
=P4Gb
-----END PGP SIGNATURE-----

--Sig_/qgD8engf.b9+KAHyIK2gWbO--

