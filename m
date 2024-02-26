Return-Path: <linux-kernel+bounces-80598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50273866A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64771F21FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17AD1BDDB;
	Mon, 26 Feb 2024 06:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Krn/xJXK"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3631BDC3;
	Mon, 26 Feb 2024 06:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708929683; cv=none; b=WvKMHnR3M5d6N9ly3OKd86BvG+DN+eZ/Mf+zLXWo+pbGCy0P4qkBfnDu32z6fXqS/E0mSqcf4pFpgdDMdeYF0hc7RDxmkpqDK5sMXhRORNCl15wl3K0o1/mb+4Jg9qZfE0TDBi2MxDt14oVCG4598fvEK6neyikw/8l8am5/k+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708929683; c=relaxed/simple;
	bh=6JgQPYiEY49YWliWb7ebcbnQQDIsh21iCb7c7cBNEV4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=E+oZ/MPy4EGYhH4ZZrbbpbM65vi89CmaeVaS+1AZNSOZOYlUlDnsLOx4Ow/SIaeSa4lYr7ZSBpsHKsBxGTxYkQiyz3k1nX5txkUhilca1hwyy2EEJ0AL68g0tKt0QFW+SCNM2cwrxGnfv+tLikSP5e284rbG0+dyE6e9tnNVW5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Krn/xJXK; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708929679;
	bh=kMZBgLIxhwgj13p2UVX7GqLT6+k14d0VHWN1V87hGGg=;
	h=Date:From:To:Cc:Subject:From;
	b=Krn/xJXKIKW0pjQ1SQJVFBs0Sz0SsxxylhVPEmzX/dYNLAvzfYa5gp8aPveiOWiVL
	 XiTcb7VmBUl5cPXnSjEsmRdKi2dx2bhCPZ4Hil9jCr38kGaUK3p2Rr4qL5znf4eeMU
	 Y6jiI2RNcVPsiJEYjw5rKhiZK9gzplZIP0iRXOLfEJ6jwh8xC043Gm4cM+0Q7wBXu3
	 z7k8pZMWksVJtUChIUv1gYJWxhox9DlH5V+XmdDCE7vaJsgdsHY3FNJEydTEAjEbgj
	 P+hSod7Rg+UN1SbxYy457d3J80CsRrM5U6mYEP5lBcy/YYFppT0Qy4GSx2hxCz7piJ
	 daYhBKF9vQALw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TjrcH12R3z4wcT;
	Mon, 26 Feb 2024 17:41:18 +1100 (AEDT)
Date: Mon, 26 Feb 2024 17:41:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the gpio-brgl tree
Message-ID: <20240226174117.722301b9@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lSd2JHuj5/lMmgQUz1_I_AZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/lSd2JHuj5/lMmgQUz1_I_AZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the mfd tree as A different commit
(but the same patch):

  4a7b0850fc7a ("dt-bindings: cros-ec: Add properties for GPIO controller")

This is commit

  7b79740d42e7 ("dt-bindings: mfd: cros-ec: Add properties for GPIO control=
ler")

in the mfd tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/lSd2JHuj5/lMmgQUz1_I_AZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXcMo0ACgkQAVBC80lX
0GwBfwf/UA699qhXEu+SYO4nrpZL5V5deQt7lCspVF0HYJmboqfrpS9ZHwxM4gLW
8ByuBWTf8POWjCJQBdU4EMqDKEoirPjDtOCCaB0doPJGtVX7SNxQBC2X4H7xqPYK
5Z0t5Oq5f+k8xA/CS+1PYl77SJarZW3qNK4rG2/rl+iVWwHDbS/DPizLKqoh5yha
BqbkGZQ5zW8OdTn2Lw3KLQOMjJbJ2X7AY76yV4LcuL2O1XWsM/ORJiV30+tcEBx4
NaUlSoAJdrvun8i1PWTvqNPijM3A+LciwAQqc1AFqgiVXPKT4NWHjDC+yhCuQAcl
Nd24JbKFJsPAlys0VqwuFCwT/zakDw==
=v6xd
-----END PGP SIGNATURE-----

--Sig_/lSd2JHuj5/lMmgQUz1_I_AZ--

