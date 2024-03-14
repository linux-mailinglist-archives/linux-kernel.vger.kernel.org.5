Return-Path: <linux-kernel+bounces-103846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B757287C556
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5000AB21875
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21683F9FE;
	Thu, 14 Mar 2024 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ico5OFea"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74819DDAD;
	Thu, 14 Mar 2024 22:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710456435; cv=none; b=HzBjxwTdukOlmIAU4P2iJo7b0iARG8XhsWGad81hVyEB+JPHt2koqkZ10JHakZJnewl2ucYLQpCXcmdIgJA5lX1MEOyBPzOlQEsd3NGBsmdIp1GSJhabc7r+i9t5zsUKsses6yc06YiDSivO2vNwCVaOQDxpMhMWjLf7FhYyuZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710456435; c=relaxed/simple;
	bh=WjBAPqc1vq76SVrT9NPWgfjORWlj275pVD1YZVe4ta4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=C6rJPOzUetEowfcHRVSesP07l69H7gw69Cryou/dkgyq3LB2U/5V+/3pBRIBRfOCeCkKMtFtb7Ed+e6mvDSRb6EO8WWE1dZv7UGmh4Y0HHboyKE9OHlgdzFjMrGTB7OMVZrmfVWDRZK8588T1RGmAEPfafO+JWEx8EblLZlJ8uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ico5OFea; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710456429;
	bh=vMdM2ltcOpLtm4zZFPIYIVCDdMBMuhhE6c13htgeBrg=;
	h=Date:From:To:Cc:Subject:From;
	b=ico5OFeaBMNme5CaIcWI+0hCJbAafSWT6Yjko391Pm76ijCmtUNCuSt+yQmdyhElY
	 H14N8Qfpk3UGe9ZbPhdyWHMuY+r4bS2OazIFjoaYPSQeuRMWveH88dorseIfN/udIt
	 D3Riulj4X2L5cq5aZpOpcx+bn+JNGiXx5hBJpXZJZO7gZzx2gSzAuVPYWo3dKtc+XB
	 +WXbUFclw8EwMufkZPe761KVf+BiGZzHkeBz/VmYBags6zeLIOFPh/NrDGA5FcT36L
	 6fXOwvlhM6FmP3XucVKPj4TGf6NLcTL+2k8NyETua8/VAvOi0loCuiOmjG8j7W8VoQ
	 bMW2Vbo1MXtdA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TwjDs1v7jz4wc1;
	Fri, 15 Mar 2024 09:47:09 +1100 (AEDT)
Date: Fri, 15 Mar 2024 09:46:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mm-nonmm-stable tree with Linus'
 tree
Message-ID: <20240315094649.7088cf6a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3G0SivKbntfHjNGNO+NVY8G";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/3G0SivKbntfHjNGNO+NVY8G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-nonmm-stable tree got a conflict in:

  fs/ocfs2/super.c

between commit:

  f88c3fb81c4b ("mm, slab: remove last vestiges of SLAB_MEM_SPREAD")

from Linus' tree and commit:

  46bd9449464a ("ocfs2: remove SLAB_MEM_SPREAD flag usage")

from the mm-nonmm-stable tree.

I fixed it up (I just used the former) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/3G0SivKbntfHjNGNO+NVY8G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXzflkACgkQAVBC80lX
0Gw3Rwf+MkEFiSAuflUxYEe+J+7KuR/i7lf/4MWX/dOg7pbd4pV7c2m1okdcGC+o
pHro9JcDDqT8oa0hnLMDBiSKCsnw+3pxlbOQU/LcNL4mZWtS4RoIG5c8rIzM2aLr
BJ9quxdybzsan5i8bKfZd166/nT3bZ3c6U7CdWKI45eIT6nkGl4r6eawLgmHaFzn
KUspAAfPojTe3fuzIsfh+XNMcLRiiJuQDgmi+KgfOhWLPHt6QC2/ino2HJWaK/MF
sA75+0OfCPA8so5N0UUONE2guXiXasw6D2iMzFjEv+F7ubCGrxt8Z2Cx4eyX4pyO
wKMkguK/B8WvnSb/CusyLL9eq8aCkg==
=FwfU
-----END PGP SIGNATURE-----

--Sig_/3G0SivKbntfHjNGNO+NVY8G--

