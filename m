Return-Path: <linux-kernel+bounces-32225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9338358D4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F63E1C21882
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 00:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F26A37B;
	Mon, 22 Jan 2024 00:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hNNTIF3V"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3754A161;
	Mon, 22 Jan 2024 00:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705881779; cv=none; b=fr1pbGn2LsPGClnEDWbqGPo7IHkzKU336GdwQ6JHS/Iy18yT5Lhh+XEVpW8d4RpJW52Vt+eWyDfbtkebVn9HoIHXdWc0eswo8nWLcg7X9Dd+ixrYCffC7/JBIiBBew+cVUn64LK09HVc6b1THbDtQnWJObeuS1g4jP7teZ7R9sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705881779; c=relaxed/simple;
	bh=rqcMKeAgbMhwZ3crHRYkkrlt24nu9M2C3C1cYe1BCX4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rE1AWVuNs9nhuKgjAw45yfE9JcBJCEnSGGyTqQTpOG6AX1wEInAzFsRh6JJDsYHO5dRaAbatBFMZq5f1i3stwS/t5QteMUvOX63JGszuXWSVUG1e83PbSxznSRa1Beklt21tPjKyVTOf5NkeTJ9DK9BgEui2degaO+I+G0tuuZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=hNNTIF3V; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705881771;
	bh=8TtaFKTsOl4DrkcENZnMZL+p4TJ3EKqtyAaSNQOEjpc=;
	h=Date:From:To:Cc:Subject:From;
	b=hNNTIF3VNXwT5oQbIsAEjK/RIz+NurVECUt8UVrUU0VXMz2No5BWlzmOJslB3+/cr
	 CpsPlRqsuuhMCqw5gxtkCPZyT8qLCQRJp1C6CsCG1XY7BC1itg8O4WnzG51LDlsEQP
	 L3TVRhbveddsYMA1lk6pSCl6DRowwO5wwjH5jnJVWMf5DqGarw/oNuRHTFMPS6+U9J
	 ocKGDXdbFkP3ws/YInI+pZUurcJJHssriyRhPBfd+LlttiyGuDF3jqxwj6oycN/IUy
	 faAlZkPFBbfn1oC4lusyRCzgdLCpin0jesL9C0RIM/bOLP2Gw7wNbqiv0v1QosMnR3
	 FAan5IgLQtqvg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TJ9Qg0nvlz4wqN;
	Mon, 22 Jan 2024 11:02:51 +1100 (AEDT)
Date: Mon, 22 Jan 2024 11:02:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kees Cook <keescook@chromium.org>
Cc: Askar Safin <safinaskar@zohomail.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the execve tree with Linus' tree
Message-ID: <20240122110249.3209c0f6@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hZ2aOPGhgsIABaJxhpcwnGd";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/hZ2aOPGhgsIABaJxhpcwnGd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the execve tree got a conflict in:

  fs/exec.c

between commit:

  978ffcbf00d8 ("execve: open the executable file before doing anything els=
e")

from Linus' tree and commit:

  38132920f430 ("exec: remove useless comment")

from the execve tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/exec.c
index 8cdd5b2dd09c,d882a6128d4a..000000000000
--- a/fs/exec.c
+++ b/fs/exec.c
@@@ -1826,11 -1804,10 +1826,8 @@@ static int exec_binprm(struct linux_bin
  	return 0;
  }
 =20
- /*
-  * sys_execve() executes a new program.
-  */
 -static int bprm_execve(struct linux_binprm *bprm,
 -		       int fd, struct filename *filename, int flags)
 +static int bprm_execve(struct linux_binprm *bprm)
  {
 -	struct file *file;
  	int retval;
 =20
  	retval =3D prepare_bprm_creds(bprm);

--Sig_/hZ2aOPGhgsIABaJxhpcwnGd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWtsKkACgkQAVBC80lX
0GxGawf/T4aY33IGdVvnk6ie/UbmubkUb9460FmPD/jk1ty08jJtiTJHBYYSchza
dOqvRMfViwWkFKLGayP9YB3QCPYUUCx9SEM+SkPjXDbsUUyxhf9MWQowXrQrxTW4
UPJp5Z8xyLRavx0KUZFCod1plQ7RmMUnwNbhbpBj3P3PxgQdUUoE+PiZf5R+IAvB
yq8n18xvppf0s2bUqk1yc8vldd8U697ulbULhmD27YxA72KopdbT5mDn5xNOPLKj
ygKZ9Vub41hIzskG0iM7qee5Q9izd/XQiLo+4VGEym67bdVo3+qI9D0POA+Gts02
bj4CkIR2aYLTAoLbuxsyQAfqeqd8Dg==
=VMX3
-----END PGP SIGNATURE-----

--Sig_/hZ2aOPGhgsIABaJxhpcwnGd--

