Return-Path: <linux-kernel+bounces-3020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81170816633
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168D71F229B6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C066ABA;
	Mon, 18 Dec 2023 06:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Q6lDkcXe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB44263DA;
	Mon, 18 Dec 2023 06:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1702879219;
	bh=S28joTYZtopOn20eOTl3Tj2fGBi4/SWEyMyEYqjDXnc=;
	h=Date:From:To:Cc:Subject:From;
	b=Q6lDkcXe7k0zKGOeqCb66OYrxDxqOfV7jIQRgzHQ150OhYsPrleeOfO+vniejcXId
	 EMeaLfKgxbcyvW8WDbTrvkaqk0bjOIOKrgW5kg331/xLTEEAgl9fHAYROZ5NQe6yEh
	 zzPkADkf3aEdvHutqEv5xIriqPpBmwwrE5UQ18gmhphTF0FNN6Vog4Vdkg82vIDp9K
	 ILm3mEXIJuRkxOY2Ke82FZheTGbRid/fp2znIJ2riiyZsIsl+F6/Nb34PcABRXYxvl
	 +uuRyyxUZA/MF3fBYCoFJZngVoVvyYLmgqK9aqQ/DC0jd0PCLToZaSadL6oHVTJmMi
	 x4AGceY6BGmOA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Stq1D0yCzz4xS0;
	Mon, 18 Dec 2023 17:00:16 +1100 (AEDT)
Date: Mon, 18 Dec 2023 17:00:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Juergen Gross <jgross@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the header_cleanup tree with the tip
 tree
Message-ID: <20231218170015.6018162e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nPPOMwgmSfm/LbKeF6n452q";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/nPPOMwgmSfm/LbKeF6n452q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the header_cleanup tree got a conflict in:

  arch/x86/include/asm/paravirt_types.h

between commit:

  f7af6977621a ("x86/paravirt: Remove no longer needed paravirt patching co=
de")

from the tip tree and commit:

  9483c05522c6 ("arch/x86: fix missing includes/forward declarations")

from the header_cleanup tree.

I fixed it up (I think, see below) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/include/asm/paravirt_types.h
index d8e85d2cf8d5,3cfcd5db083b..000000000000
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@@ -5,6 -5,17 +5,7 @@@
  #ifdef CONFIG_PARAVIRT
 =20
  #ifndef __ASSEMBLY__
++#include <linux/types.h>
 =20
  #include <asm/desc_defs.h>
  #include <asm/pgtable_types.h>

--Sig_/nPPOMwgmSfm/LbKeF6n452q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV/3+8ACgkQAVBC80lX
0Gw8MAf/Xa63Bhoc8aqZn00ZlXzZrxSoDI7pz5CU51atXl7kvUKkMqHJ/6iREtwi
RqMMSJJf+B+IliVb7x17ahfrFGGQvUCFvrSuEMmYtwUxMmGMSTAJo3hQK3xSZiU5
QJs2Qx7qdbyGEQt1F89CckNpgyvgy12/LzRuOf9SPum7hCcSDYhaFw5Bts6X0Ub8
xTjN3eHPWtTV40wvuTprAyvV0JWIcc+KhBooEBdurMeHW7Fber/BupOe5CbMCAlm
DXo0w1dHSZfLdRiy5eSUZSNp16IxvxPkEe8V7OqNbYb7IZ04OpqQ/QBPPxKnbXSk
t0Ql9CiY2McCeQNDx29RNfA3PifUlw==
=H5bB
-----END PGP SIGNATURE-----

--Sig_/nPPOMwgmSfm/LbKeF6n452q--

