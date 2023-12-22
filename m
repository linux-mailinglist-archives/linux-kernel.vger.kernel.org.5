Return-Path: <linux-kernel+bounces-9283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F3E81C364
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65D1287EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEFF6111;
	Fri, 22 Dec 2023 03:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WrYFKhHW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FB65390;
	Fri, 22 Dec 2023 03:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703215250;
	bh=G9TXpmNKFKLIUns+8NwaoYpBd9ZtZAQPwkvxTt9wCtM=;
	h=Date:From:To:Cc:Subject:From;
	b=WrYFKhHWsi3WZdZTFoTxdXgezf6PoX9UveWE/Q2xGLcjiCLLg0XFcSvD3soF9iPBx
	 CV68q4gaojMC7Ec/50ire5bmXkamNfqQDIK7zx4CEuNphtfmQ5o48X9wXc2VjAaOnJ
	 e+nvTYWr1lNhOoZ2apRhYRCe/6tPr9v2TZbxQ+IYJoi7d4tw3f6mHoL7abM0FU+7lB
	 8yeIVrqIFSsxxpcY2iM/Ptr9gx73nul8h1CyyUvp8IFvwgSfk2oq/dXWb+DJbMCyBK
	 +7/pi3y6i/aKkwZDou+2YVsr6CNiAOMPFuxkdeNOC2Rajx//YEodcYMmRySUCS6Mg8
	 11RQhVTTAulUg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SxCHP6Mkyz4wby;
	Fri, 22 Dec 2023 14:20:49 +1100 (AEDT)
Date: Fri, 22 Dec 2023 14:20:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tejun Heo <tj@kernel.org>, Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patchs in the cgroup tree
Message-ID: <20231222142049.397619e5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OJADucNWvGw_tPz_/tAIriZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/OJADucNWvGw_tPz_/tAIriZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the driver-core tree as a different commit
(but the same patchs):

  2bf46683842b ("kernel/cgroup: use kernfs_create_dir_ns()")

This is commit

  fe3de0102bc8 ("kernel/cgroup: use kernfs_create_dir_ns()")

in the driver-core tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/OJADucNWvGw_tPz_/tAIriZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWFAJEACgkQAVBC80lX
0GzbTwf7B/aa0Q0mbQ/bNvPCXeECAFFHIFBtKatNcOWEQrzOcMi8dC/wPbxtvwB7
U1kIWF4gob14pJtjs87pUydNKZJ1EVBZ2eNetS3G3tqf8OCG9Vbh1KhDy9203exX
fI8AgPZD7jhoG/UIBFjx6eRfAOnFAnPPLyt9S5sqXIuQbh2ipkUuuCCAaM1Mgkhy
4dmqEUF2Gh1YWJwtPMRu9ROZOX6ZtqHuMRByw51cV45BV3ttWjxEHKDjBAf46r2O
yX/VRiM7DUMzyJ9asLwgUOpxjbGXK8luItUYycgB5JLCUaSzQBi46SqN5wxE1A3k
hbcen2A6bOH7bhV+eRDuSDE67V19zA==
=4fE+
-----END PGP SIGNATURE-----

--Sig_/OJADucNWvGw_tPz_/tAIriZ--

