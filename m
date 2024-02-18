Return-Path: <linux-kernel+bounces-70624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BE4859A35
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 00:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1471C209A2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A325F7428C;
	Sun, 18 Feb 2024 23:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ad6yUwTs"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFE4568A;
	Sun, 18 Feb 2024 23:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708299898; cv=none; b=W2+/8dpm2vOMiG0oUbHyEnwu1wnv/QlbupheHLgAhOPf7PD1x+tPubqJzWzgoluVs+/snmSZAtwUUN/nrif9XcJszQbXTm+rn4Uitn6CHR4sdDBLI79WTNLN87rcdBUf86T1L2BQu/u/9NhFXyajgrYTNUPJiCygGZplXVgNnTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708299898; c=relaxed/simple;
	bh=LhCl34C9hj/Y8w39M4PNhKCSJEojxdK1Ro+Y8hrc2Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ihgLQf1CKq27/a49R5evAD8/Z2dP3oyOZ1b69adFRJu4NcyFc36uCuSCTC+sxWDbfr+SlWXvvgN/74KUZMsPu5g1YSeDUYqMyTExHp9O81XlOpY2IKQimgatOhGChTzTFCx1ASZ5FvAK/QRiHbb5H6zQzIbAXF8598Di2NwSZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Ad6yUwTs; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708299892;
	bh=WFT8QfbCVr4EX+FVsMZB/8KLZUlyEl2vXdvcq9T3a2U=;
	h=Date:From:To:Cc:Subject:From;
	b=Ad6yUwTsiYgGVOn7U4f5/phoBJOG+1+j/OwIDdhD2eqBrQdDKsIeW8u/L3GMpH2XX
	 Rz0O0imp0UHz5wnELKXCdsOp4ajcOKTX3vOZ/hVOvF31Q8QzdbWSg+1JGPzj680MHt
	 G3jzFt6D+EFOCHvUuOsAcM4jaq4ZcZXXqy/dz54M9vYkeLaBnNCRWP51P3oCAJf2ES
	 1h1AZMzR8Lw8+TXz6oaIQvume8W0VaP3yazEOT7fUiVDfHJfO9XnKTYcz7CPqIrA8y
	 XSj+aqVaKGEKTjI/XfdUnZIExywE3z9s7QD/NG1w0hGjSGaLafLT/BP5ORImpwl4oc
	 b6op0e2WH+TJw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TdMj02pbXz4wc7;
	Mon, 19 Feb 2024 10:44:52 +1100 (AEDT)
Date: Mon, 19 Feb 2024 10:44:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <dai.ngo@oracle.com>, Jeff
 Layton <jlayton@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20240219104450.4d258995@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1Cq8K.VyR_cYtpA2rtC1AAV";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/1Cq8K.VyR_cYtpA2rtC1AAV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-brauner tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

fs/nfsd/nfs4state.c: In function 'nfsd4_deleg_getattr_conflict':
fs/nfsd/nfs4state.c:8845:32: error: 'struct file_lease' has no member named=
 'fl_owner'
 8845 |                         dp =3D fl->fl_owner;
      |                                ^~

Caused by commits

  a69ce85ec9af ("filelock: split common fields into struct file_lock_core")
  282c30f320ba ("filelock: remove temporary compatibility macros")

interacting with commit

  b9b89fb3e0b6 ("NFSD: handle GETATTR conflict with write delegation")

from the nfsd tree.

I have applied the following merge resolution patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 19 Feb 2024 10:38:26 +1100
Subject: [PATCH] fixup for "filelock: split common fields into struct
 file_lock_core"

interacting with "NFSD: handle GETATTR conflict with write delegation"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3545125c8b73..71bb0ee57cf8 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8842,7 +8842,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, =
struct inode *inode,
 			}
 break_lease:
 			nfsd_stats_wdeleg_getattr_inc(nn);
-			dp =3D fl->fl_owner;
+			dp =3D fl->c.flc_owner;
 			ncf =3D &dp->dl_cb_fattr;
 			nfs4_cb_getattr(&dp->dl_cb_fattr);
 			spin_unlock(&ctx->flc_lock);
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/1Cq8K.VyR_cYtpA2rtC1AAV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXSlnIACgkQAVBC80lX
0GwNGAf/Rwy5pN54PVBC7Npq/Yn+Sp60o4LwqP/7EvqgbU4QW8Di0G76K4iLOnAN
o0Mhrfkir35BE43xhN794Ugj9wniGzBVS6denihoF2zdD22WI4D53EluPSa5ivSH
oKt6IPwe6P+JXj+Pueuz7ihyI+V6dAwsUSKVKhAn6vTrylaJ9QRQgtOAUGEuvA9n
E3+Omo4LMjn7zhOY4VQPu8J7Hx3nA+DtcxqkQUaU7b6N3ZmBZMhoX9VEl1Dj/Gp1
DeEF1MX/dEvfE3z8SclZyiXZdQSr9UAZtPYeDj4CfY92WT0AfobBVgb+LIhvGCk3
eHhjM+v229GK/usHXNGh9G9c9bO4Pw==
=WMsd
-----END PGP SIGNATURE-----

--Sig_/1Cq8K.VyR_cYtpA2rtC1AAV--

