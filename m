Return-Path: <linux-kernel+bounces-145988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E52398A5DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F531C20EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC1A158A10;
	Mon, 15 Apr 2024 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aeKZyowA"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58B515749B;
	Mon, 15 Apr 2024 22:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713221916; cv=none; b=M1EVYN3Eqs1Z27pSQgfE21jXtfhVbK+akUJ225kjMqw0IdKs9dTfLPIxTv3Ew67tIp2Zfb+QQqF/YUMuhg250EL66GpHDQMkRdf+l2cpchRlaPENk+XLz39K0o+sGgmi0TuZcvNZPc7IvsvjW7bYmki0818bJjC4o8a5oL5Se5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713221916; c=relaxed/simple;
	bh=IpupYfL+nfuZcj28IjJD67wn4hsG9soZoaZIShrcHAs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oazRb89r/uYHyoo8K/nnFfv46C5UrdRYTv8QMzxCptEiAr/d4GTtTa6sIFkozrg4gJOsQSlDKuAShikPFH8Or00v4c8bS413lPvvaCpGBmzvTQZcsULoiDxlCe0seFxvmtRCwDuCRMvcZmG+7jFFT+ARoawaNkXmWedXnP7DPng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=aeKZyowA; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713221912;
	bh=OFQdDAtGK6iSzxTP4mKGX09ugTslZhLrgmSY8Vqx5fA=;
	h=Date:From:To:Cc:Subject:From;
	b=aeKZyowAIMP1yyAOz2Y1+tPUQ/q2HBQGOuYIUvhQ3jqikbZ3cZoCDoyedMiB6kYyc
	 4IdlSIRKaSbb/rW+D4AMusKhGY/cV4sHHERaBp8XjjpoaU5IyzW9bp6xtYP4q7qJvl
	 Gr6Y9u5Zh/bmaPYvTsmGAMK3s21nuwYi04WZGU2JPm9ejCPYvK5TwyVFPSEFSQhT+i
	 9riJJe6IsffQEe3gIYdy7ZXZJlvoS1uI4AdZD0Hye8d+863sKgiRr1weHNrF229GOZ
	 qbvIMpVTPnguyOnW70ERjQHGbtCq7bGvOBo8QGCctuihRxf9/5fqSxzw1nBoaNP9/G
	 SpAgxOtqefjsg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VJMzC4g12z4wcC;
	Tue, 16 Apr 2024 08:58:31 +1000 (AEST)
Date: Tue, 16 Apr 2024 08:58:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
 Joel Granados <j.granados@samsung.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the sysctl tree
Message-ID: <20240416085831.51b372a3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4qbQt+5BPr1N7CM/9M0Z1zz";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/4qbQt+5BPr1N7CM/9M0Z1zz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  693d33b8fc7e ("sysctl: treewide: constify argument ctl_table_root::permis=
sions(table)")
  e423195d7930 ("sysctl: treewide: drop unused argument ctl_table_root::set=
_ownership(table)")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/4qbQt+5BPr1N7CM/9M0Z1zz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYdsRcACgkQAVBC80lX
0GyhRQf/Y6uhuHgY5fsD6ZKa53QzpBxY0yhWYP+Yp1Qp0UXFk58bC+051bEFBGtB
8BfLY0dOP54fq4LzdfePdZYWznQ//i6H2gyL3dbIUGYXpatJg6cjfWB3DqCP1oW6
iq8clQcjC9HU4AO1yKXZNSRwhRUvJ01bS40Y/gKTnVdhCsEDVhaOuD19Mw+Ne5ls
XgcGpve9IZzUT/0P2WE1UNH8WlL67Xnr1lb2Xii0hCFdXkwH52SR1/9/sO0U6PNE
XY8B2oGhSKnfSu3+u+tYzTr+CWNxCcUYMKRXU6+MBsVco83L8R4zSeEhyvC+5e/B
HFNIcwiWmjNOknC2bIdXCCMQb9ZS9A==
=Gx63
-----END PGP SIGNATURE-----

--Sig_/4qbQt+5BPr1N7CM/9M0Z1zz--

