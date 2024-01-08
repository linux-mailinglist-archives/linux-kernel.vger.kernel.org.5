Return-Path: <linux-kernel+bounces-19047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C167F826731
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 02:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F413B1C21839
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89769461;
	Mon,  8 Jan 2024 01:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FBYJFMab"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7753A7F;
	Mon,  8 Jan 2024 01:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704678564;
	bh=Lf53kHBVwbitP7k47OPxiji8oPEUlYg9H+eTQgsaYEI=;
	h=Date:From:To:Cc:Subject:From;
	b=FBYJFMabJvocXp/zMaN/XvQQpocHjMm9B3K+lCfmlgvzeC4uC0YQXawKi8LCL6k87
	 ZpAlrK1+WJssR59IdKUHavJo9Q9wtBl7w+xEnfbevpQ3hHU4l3VLJt0fsDR+6TqTO7
	 I17e+jDNMTlSqKdcLRhCPvxcDW/5wHZQpD8FkvI+t+cJ5ST+wBTpQsSgBaDPD/dl0J
	 VxI5BP7ngcWSw33M6AgobSj6cfGRxsRY3lJEZtmV0FMSPuLc9PYivn5RPmHxeoJCwH
	 wCPS0EHorcbUhrf7px/p/tMsw8nIqkST1C+MMzVc/N0/oCbkVrRP7qE30oHjLctuuu
	 CLmz7yD4XNg9A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T7cS32zMPz4wx5;
	Mon,  8 Jan 2024 12:49:23 +1100 (AEDT)
Date: Mon, 8 Jan 2024 12:49:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the ftrace tree with the vfs tree
Message-ID: <20240108124922.37bd7fe3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/x+fIwksRk+Kxf4h2ScQydzQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/x+fIwksRk+Kxf4h2ScQydzQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ftrace tree got a conflict in:

  fs/tracefs/inode.c

between commit:

  da549bdd15c2 ("dentry: switch the lists of children to hlist")

from the vfs tree and commit:

  8186fff7ab64 ("tracefs/eventfs: Use root and instance inodes as default o=
wnership")

from the ftrace tree.

I fixed it up (the latter removed the code modified by the former, so
I just did that) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/x+fIwksRk+Kxf4h2ScQydzQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWbVKIACgkQAVBC80lX
0Gx/qgf8CIlnK9gkNc0lxCD8t2z0dljFVw/iVj1F96iBZ/FHXPnErhceK36SzzOU
zc+Smwz4tfrP730btCvE2P4cUzK4ifRBM0KBJGzeseqIbcOShqdQmp9W5cB1dh53
iP9xGMEQZwR6lQ1KiyAQUOdymDQS4q+e0FuWArwUJBbR0nX161NxUq85bIPTD2Y1
7xGrgTzBL/5MBH8Ql8wM7NfBjZrOND/yFYQuXTtfbPlxAM2F6pIpMfeLky5fcxhP
zgUlEN5gyk5KzUGmYqewXC54wVGX2cEHtvoahtIIyaobDOGAt4LIKWJqaxJyA4+0
B2ITAuDyrNKcHOPfn/qaErzXqPMK0Q==
=SVM+
-----END PGP SIGNATURE-----

--Sig_/x+fIwksRk+Kxf4h2ScQydzQ--

