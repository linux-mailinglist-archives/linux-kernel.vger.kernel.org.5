Return-Path: <linux-kernel+bounces-149424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990728A90F1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8182821B0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055C44E1BE;
	Thu, 18 Apr 2024 02:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="u2nXTwEo"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BA34AED6;
	Thu, 18 Apr 2024 02:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713405750; cv=none; b=mZ/VbU/HwUHiEwLaxISbV/6EUk78MGen+/FeiRYVTy0BgbD4Uq8g5og7wnkkhcUq1C7N+H0qS9SV9OOOp89AEBiu0m0UZPRGnCR8GIMB3b16+7Zm4kya3ieofmw/B9BFbk5x4rxWYsOe7qrBcPbIAcBS65AzHZARWq5gEhYCLcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713405750; c=relaxed/simple;
	bh=dBnEAgXUMi9S55V8EIauoEJPZbWof3chHTPwvl/9OBY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Y77S/ipkxTek56jmJJBQRUCm/zPU+MdT4ZTRatZDRZ46gGD7O47VjBgxQaGsj5QgNS+4oZ+dgTuk0PaNUg5oTAPC7NeaVqOxYsWTgxVMFXh108VpJ2llvkVio/JoUqrpLwB4pSlukVjHUig8WmHUTSE99x5TiuMvUs+g8/3NvuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=u2nXTwEo; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713405743;
	bh=115XVd+6iunRlQLEtb4+vpJ6TMykVoK4WBVz2uB0HIA=;
	h=Date:From:To:Cc:Subject:From;
	b=u2nXTwEo4MjoEZAaidarVfnSenmbvUYEY9hsyvtxwq43dJ9knBi54qi40OUhk0Pkv
	 BsJFxG7LtdHoQgp206IQygYHVfAiCIk45BJWDWujJUag4wy58ALiIsi9odt4DwpiZh
	 WS3bUMEZCqyIXotBiai2NL3L4GaDOr6OvsnQo4e6o3SZgSCFhyjgcVgYczeiAJ2cGC
	 Eg/tSQqYkBe6LjJSbgzJKXf1OTnoJ6dJ6E5SWa3vSx/0qDK/yCZ2UGG/EryPUpUF3K
	 U7NKyWujUNqJzxn547+voTeoU2K9S9zThnkqvUka+0E3J9YWcAKEGzRAFTmao+Temx
	 j8dPV2wKaO0eQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VKgyR4dVsz4wx6;
	Thu, 18 Apr 2024 12:02:23 +1000 (AEST)
Date: Thu, 18 Apr 2024 12:02:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Huacai Chen <chenhuacai@loongson.cn>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the loongarch tree
Message-ID: <20240418120222.77c2bd2f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Qrl8Xi2s2TysjXv._lgUoz8";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Qrl8Xi2s2TysjXv._lgUoz8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the mm tree as different commits
(but the same patches):

  34248ae447d5 ("LoongArch: Fix Kconfig item and left code related to CRASH=
_CORE")
  ffc3e380b629 ("LoongArch: Fix a build error due to __tlb_remove_tlb_entry=
()")

These are commits

  3d7d0770dda6 ("arch/loongarch: clean up the left code and Kconfig item re=
lated to CRASH_CORE")
  b97004d9fb95 ("LoongArch/tlb: fix "error: parameter 'ptep' set but not us=
ed" due to __tlb_remove_tlb_entry()")

in the mm-nonmm-unstable branch of the mm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Qrl8Xi2s2TysjXv._lgUoz8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYgfy4ACgkQAVBC80lX
0Gx55wgAhXMsxF1SL+T//5PHvj5JtGLLVRu8DioKOwGxZgWFE/R2SgFtmh6INP5C
iR8M5egp+9m3jiFAwSvDYZVGV5dVv2jvjsx5b+mbSm+RGdMCKTcbnGLCPlUH3Vkc
HvHgKGa9EZQOpJUyAozCLC4BD5y5/bjDZcTwZsdeduUoxtdg2rhE72zNrBq4Un4t
E2bQf7iFI07Qduh9smLb7kjqUhQ0+m16DOriErBROdI+Y2OX//SbympmhP+NtJ2U
seIxiEauB8bnFfXEfOaS/BUO9+kNxLguoaJD/lkxRzLtI96jy2P7beWFxr2XqjOj
Hmvr41TnLpf3GJGg2GhePvJzu5y3og==
=nnoM
-----END PGP SIGNATURE-----

--Sig_/Qrl8Xi2s2TysjXv._lgUoz8--

