Return-Path: <linux-kernel+bounces-6210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE608195F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0171F267D5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3F523DC;
	Wed, 20 Dec 2023 00:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HRAb610L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F88F79CC;
	Wed, 20 Dec 2023 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703033481;
	bh=OG4CKpftW12C8hWZMEmPvli3ysw9HOAY2jVhYTdUGDk=;
	h=Date:From:To:Cc:Subject:From;
	b=HRAb610LJXF7IKnMu0jS+X0+lF3qLR9UnLnDBIed2rgWXfV/+DdvW4RJiZoWFPMiX
	 eQoMYF+JVQPLEcL8x6e6WsImppE+bbre3GyHMhSN+5GPs7TvlspID8wPKevc3djfxa
	 7PdXbG7jkbbX6TUSSfFFiIGU9KBgzeOGvNm3lqIECPQDDccudEjIjEzbp3qEEwy4BN
	 AsC1DWkWQ7gbJ3VIVPgmI1iga2INwObJtCAmFHWeIEtmqjD8Zglwr7HmdByX9zJWte
	 to9g2uzAovWSoy+20R55yELxnJYy3TI8y0EwLApAQdzdgDUmncqQi7vxr2r2EiDISO
	 QyH+LVedsrveQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Svw3r3Z5dz4wdB;
	Wed, 20 Dec 2023 11:51:20 +1100 (AEDT)
Date: Wed, 20 Dec 2023 11:51:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Liu Jian <liujian56@huawei.com>, Willem de
 Bruijn <willemb@google.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20231220115118.218147ff@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/F0QZ/zY980=Ou7ZKrHIgYyu";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/F0QZ/zY980=Ou7ZKrHIgYyu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  tools/testing/selftests/net/Makefile

between commit:

  2258b666482d ("selftests: add vlan hw filter tests")

from the net tree and commit:

  a0bc96c0cd6e ("selftests: net: verify fq per-band packet limit")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/net/Makefile
index 9e5bf59a20bf,14bd68da7466..000000000000
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@@ -91,7 -91,7 +91,8 @@@ TEST_PROGS +=3D test_bridge_neigh_suppres
  TEST_PROGS +=3D test_vxlan_nolocalbypass.sh
  TEST_PROGS +=3D test_bridge_backup_port.sh
  TEST_PROGS +=3D fdb_flush.sh
 +TEST_PROGS +=3D vlan_hw_filter.sh
+ TEST_PROGS +=3D fq_band_pktlimit.sh
 =20
  TEST_FILES :=3D settings
 =20

--Sig_/F0QZ/zY980=Ou7ZKrHIgYyu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWCOoYACgkQAVBC80lX
0GyWQAf9H6JruRjUS9893bY3LpYu9kD/kjQbBrMz6gjnCN/BXSjZnwU1dyTEmITk
iqibH3mHuSB5zdfjTmt7dMtlNuECAbJAYEtf9EyiwX1Zieo4EAk2/81xqP1DG5Wo
oUe3Z/HsJ/9SE+h8cjXJ3R1dND2kq3zc+oPYtAdRuJKiFDQFW06w8XIgmLxS1ve5
ktVVsOdscxjq5PT1qBYIGtxmAk90ZL0rGCv0/abGK0u1rziKpqsEiLDrN6a3zT9o
y1DP5mdpXWTXIsLFubi1De+vvX+6eS+XwGiZCdcP45OIs9gmtRqvJCpwVbWjWFZE
nmcevg6piOHgXQWWIzOTdz5mzhVxkw==
=LSWa
-----END PGP SIGNATURE-----

--Sig_/F0QZ/zY980=Ou7ZKrHIgYyu--

