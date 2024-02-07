Return-Path: <linux-kernel+bounces-55765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0265884C172
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DC01C242A4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36369460;
	Wed,  7 Feb 2024 00:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="E/rKhbtw"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5A48F5B;
	Wed,  7 Feb 2024 00:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707266486; cv=none; b=GvYnLcInh0Osf+5oKLF00rNry3Hi6tepun59WFPs8A5E3NseGkRehjXtnjoTcYyO5lItuU159FEmi7P+QSXr5LjYMZZkEweONLZPLG+tUkrG8sN3FuFr5SfEwpogr96kZJQSGGcLDoKpKi6V6DetbjLMs6J30GPfwCFIq8m92fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707266486; c=relaxed/simple;
	bh=xu1OgSfieAmqr6ZB1/qhT/qsNfkCz0aPs5VpDOCSIUs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pUB4xV8FemLztnsD1sZQ/gYcUxaOu9q8uRMVkjW5WLDWtyQFvPXLcxxecSyYYPYjxe5bql5bkk7s04kpb7msQJKGxg6XoqOQNz3KuH55tYEPOF8GWQwii7gCuevNTci4JKiDJwayOEKpS4KjvdJi2NsyPnwKn9IlENWFe/pp4XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=E/rKhbtw; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707266480;
	bh=A6Qs5ml23u4lBTJh/n/0jZCbBZW7uELlezDPWWgN0J8=;
	h=Date:From:To:Cc:Subject:From;
	b=E/rKhbtwWOJc8LiVaynuOO9xIkqGN+aXx12r2Xsi4yauR4r0/PPWDYg0aKPNtcB8P
	 lrQYtwWEyxtCbgIkEiZF1E8UszDCG/J1vJwO/RAJMCtIlw03ro1TZU+8Se8XIWQIGH
	 z+Bu0Nr0dO7OCp+vD06PPD6K8iRXr5US6wWW1fVaKQsu3Cefo7YxjQ6sFab683Y2eT
	 oM/8uWqF4txJAwV7O+cPQtomCJ4gmzAT+TnP5BG/D0QFiPcE4kIUAezl0oLc25er8s
	 GBi8YOpBA17vV+j0DyC/Pd+n33h2/oG+2STyJqRN90RoaPXwNV5sshBVNJP/U0WBHD
	 5FA7BrFppLcCg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TV1Wh0TLyz4wc9;
	Wed,  7 Feb 2024 11:41:20 +1100 (AEDT)
Date: Wed, 7 Feb 2024 11:41:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, NeilBrown <neilb@suse.de>
Subject: linux-next: manual merge of the vfs-brauner tree with the nfsd tree
Message-ID: <20240207114118.23541d8c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DtkOBEOcZdottnUzaMe92L0";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/DtkOBEOcZdottnUzaMe92L0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/nfsd/nfs4layouts.c

between commit:

  b1f1961080c4 ("nfsd: allow layout state to be admin-revoked.")

from the nfsd tree and commit:

  7b8001013d72 ("filelock: don't do security checks on nfsd setlease calls")

from the vfs-brauner tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/nfsd/nfs4layouts.c
index b1e585c1d9a3,4c0d00bdfbb1..4f3072b5979a
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@@ -152,23 -152,6 +152,23 @@@ void nfsd4_setup_layout_type(struct svc
  #endif
  }
 =20
 +void nfsd4_close_layout(struct nfs4_layout_stateid *ls)
 +{
 +	struct nfsd_file *fl;
 +
 +	spin_lock(&ls->ls_stid.sc_file->fi_lock);
 +	fl =3D ls->ls_file;
 +	ls->ls_file =3D NULL;
 +	spin_unlock(&ls->ls_stid.sc_file->fi_lock);
 +
 +	if (fl) {
 +		if (!nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
- 			vfs_setlease(fl->nf_file, F_UNLCK, NULL,
- 				     (void **)&ls);
++			kernel_setlease(fl->nf_file, F_UNLCK, NULL,
++					(void **)&ls);
 +		nfsd_file_put(fl);
 +	}
 +}
 +
  static void
  nfsd4_free_layout_stateid(struct nfs4_stid *stid)
  {

--Sig_/DtkOBEOcZdottnUzaMe92L0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXC0a4ACgkQAVBC80lX
0GxmsQf/eZ3P37ukiU2TR8Uc0lKysFXIwuRyIhT3WLqvodtAXFkd1wmCjJN0Df63
H+SWdzVEJ/PeLcZTBTCI8GyajphrLMcmUILze7lrbqDf59ZjwWwgsNjnAnoE3vn3
RxHrpEm5gv+9rWvr1MTSKtt3ee2PVYCeQnbpMBt4Mr1FD0J+GOtplLYRHXvYrD0I
+GTZDT77zivSSu76SeJ8Qe/04NnNQlIqmScon9NXy4yW8zB828J6K6xeEli+HGiW
hao1dMlw4+iO9k22kwdT+AGw+Arlet8sTVpkCbv20BiQaGN32OMO+Oc8erEVsRW5
xNuMWxFdhNf9eEiWFM14ZD6ugs4XIw==
=+Ohv
-----END PGP SIGNATURE-----

--Sig_/DtkOBEOcZdottnUzaMe92L0--

