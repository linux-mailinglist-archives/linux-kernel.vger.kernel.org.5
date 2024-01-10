Return-Path: <linux-kernel+bounces-22813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B465382A339
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528AD1F2358D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B13B4F5F4;
	Wed, 10 Jan 2024 21:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Hm4X6wg0"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADF64F21E;
	Wed, 10 Jan 2024 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704921834;
	bh=nH3UDLEXR1ENTZXRgFi9gQ5VgD8ebMpEI9fewN4PaHM=;
	h=Date:From:To:Cc:Subject:From;
	b=Hm4X6wg0wmdXPNdz4lmtiaJO90IH+JJfRuXW1J91DlXCa/3uuy95pcUJRiMdlvQCQ
	 mK5oNFMrToBMGU2kjH2hlPr5woyaWB/i+nZnmVdtbA2urdqSXGbZ36xHSjU2d4dLHz
	 QgLP2bivvbT1+WYXZ5V3QDeLayTUI6g7xbJbGQxzKRbwdZjQlBdt7cM8gilaWDRaoy
	 fM/YUrjcHkM1HKP/yqLBgN2PFyQFr25cQkGm/rMenAWRN55hv50Khenp+wE3oJj8NA
	 diUOfDS5aySx1enNojjwsMqr89CErphIQlte19udyZUh70rbAe2Bs8Zv3ZNThT9l9x
	 b3kYWIs4treSA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T9LQK0f6Xz4wc8;
	Thu, 11 Jan 2024 08:23:52 +1100 (AEDT)
Date: Thu, 11 Jan 2024 08:23:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the kspp-gustavo tree
Message-ID: <20240111082350.5aca9bef@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/N2hljuN5wcFoyfRt11JFnry";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/N2hljuN5wcFoyfRt11JFnry
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  e5c35432f91c ("powerpc/crypto: Avoid -Wstringop-overflow warnings")

This is commit

  aaa03fdb56c7 ("crypto: p10-aes-gcm - Avoid -Wstringop-overflow warnings")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/N2hljuN5wcFoyfRt11JFnry
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWfCuYACgkQAVBC80lX
0GxRuwf/UMCjQcmDeMSfonGNBfuGEaTMTE7mjy7VsWbmXuuipatRzo68bxjPnmW3
XobeE0tOsmTBCeFDww+msz8+O4e6lsPPVEjjqa1LQ3e5He4HW5kKU//aXtrhIiWG
eo8WybKyZyHoXSgQceIZu62TGjgsfxiw6FrTsl+N/W5ea8Ov1/QAQCIUABoAsa1F
lr/uXG7J2QMckjsG85Tks5nFUfKGs5QXfT+LQeBEViPcmfngFJ8THjFGqnWFXkwl
aDNjCeszMNv5ZpPWWrC+VnnKeAEuV1k5Uuhu3ajRfP40ES6JCjC1Z1nnLqjSxSKD
KxaHv2E/wKhEcm3ZaJ4XfaOVkSo3mQ==
=HcBj
-----END PGP SIGNATURE-----

--Sig_/N2hljuN5wcFoyfRt11JFnry--

