Return-Path: <linux-kernel+bounces-3003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0E28165F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A06B21682
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9DC63B1;
	Mon, 18 Dec 2023 05:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="V9AeLEHw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7256131;
	Mon, 18 Dec 2023 05:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1702876359;
	bh=wxxmjytMJ745tnbtEjTL4CFbCPaWb7oQ6PeMMHN57Ec=;
	h=Date:From:To:Cc:Subject:From;
	b=V9AeLEHw7FncjpCn/M01zGV9cJIyu46Ocx8xwYbbYuw3kRRDM1I1cYlDDMp+Ky/U5
	 ADn4UWOgFhMJGdAagxIFBWsju3PvWdewYRFP0IzbgrIJlw3pwjferX7TWFMacwwSaj
	 1tfsbtx6BZ9exlNhaUNH7CRjZ21KEiNu5O8R4CuFZsVrTI8euqFGcmmjyCCXVwVR1G
	 TLiZA/hpsGHGQ5PituWIlRdJTsA4aE0V+Ns0oVreeBqUhsrouiQ+UKk3NnMZOTwEJp
	 eVhO087Lkr6hQYZyrglnmg9ax+CrH4j00BK6lRLHlnGfTwKtj36Fgr3kC5QV1dDOV4
	 ISCKfYGtfkzfw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4StnyH0Zbnz4wc6;
	Mon, 18 Dec 2023 16:12:39 +1100 (AEDT)
Date: Mon, 18 Dec 2023 16:12:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Greg KH
 <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the nvmem tree
Message-ID: <20231218161238.59ce255d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+yuWjtxtLYNTznKmKvqMMiq";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/+yuWjtxtLYNTznKmKvqMMiq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  82c6ba6a7d96 ("nvmem: brcm_nvram: store a copy of NVRAM content")
  a9d68bd9fc7a ("nvmem: stm32: add support for STM32MP25 BSEC to control OT=
P data")
  5bc8339a8af8 ("dt-bindings: nvmem: add new stm32mp25 compatible for stm32=
-romem")
  6deccfa25e3d ("dt-bindings: nvmem: mxs-ocotp: Document fsl,ocotp")
  e15e05ed845a ("nvmem: core: Expose cells through sysfs")
  38ebc72019b9 ("ABI: sysfs-nvmem-cells: Expose cells through sysfs")
  fc334e722496 ("nvmem: core: Rework layouts to become regular devices")
  d5827449f96c ("nvmem: Move and rename ->fixup_cell_info()")
  52be3c1543c4 ("nvmem: Simplify the ->add_cells() hook")
  26378491d343 ("nvmem: Create a header for internal sharing")
  c016e72f9346 ("nvmem: Move of_nvmem_layout_get_container() in another hea=
der")
  0e7ceb1551ee ("of: device: Export of_device_make_bus_id()")

These are commits

  1e37bf84afac ("nvmem: brcm_nvram: store a copy of NVRAM content")
  f0ac5b230396 ("nvmem: stm32: add support for STM32MP25 BSEC to control OT=
P data")
  a729c0f57dc8 ("dt-bindings: nvmem: add new stm32mp25 compatible for stm32=
-romem")
  a2a8aefecbd0 ("dt-bindings: nvmem: mxs-ocotp: Document fsl,ocotp")
  0331c611949f ("nvmem: core: Expose cells through sysfs")
  192048e5a5b6 ("ABI: sysfs-nvmem-cells: Expose cells through sysfs")
  fc29fd821d9a ("nvmem: core: Rework layouts to become regular devices")
  1172460e7167 ("nvmem: Move and rename ->fixup_cell_info()")
  1b7c298a4ecb ("nvmem: Simplify the ->add_cells() hook")
  ec9c08a1cb8d ("nvmem: Create a header for internal sharing")
  4a1a40233b4a ("nvmem: Move of_nvmem_layout_get_container() in another hea=
der")
  7f38b70042fc ("of: device: Export of_device_make_bus_id()")

in the char-misc tree.



--=20
Cheers,
Stephen Rothwell

--Sig_/+yuWjtxtLYNTznKmKvqMMiq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV/1MYACgkQAVBC80lX
0Gx6Qgf/dvZeVhOZjl+niVu4UCXZPjVckrbAgh8MF9mwJJE1rpgaUU7tZH0xh9Lc
UYQFPisIB+zRFm2IO/KITC3oNhZ9ZoHTCab93isLXaNDeKvv0Nzil4UVYNb+yVm/
GkgD98UyGJ5Rgdgh9C9AUEeuo78wo8qL5mhAP0K7PyLefOvMINEmyexwO+xaQy67
GxGY/Tb2sT9OeE8YapT5RSUaTzFN7MPsgtb7HI24zgI54lU+igeWVnhNMnQ5o79y
mc52QAwMtAPTUPBY4G2ONMRx3INV04RNcRYXntIjcOxPvvtK3iyxlXIJQcGvkZLw
IGRltRoixbwVA/BFIukBXUC6PsiTXA==
=Wl2G
-----END PGP SIGNATURE-----

--Sig_/+yuWjtxtLYNTznKmKvqMMiq--

