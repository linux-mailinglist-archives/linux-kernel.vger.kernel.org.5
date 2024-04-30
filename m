Return-Path: <linux-kernel+bounces-164775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C216A8B82B2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE221F2413A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17A11E86E;
	Tue, 30 Apr 2024 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="X3NwAcyT"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A346D518;
	Tue, 30 Apr 2024 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714516699; cv=none; b=p6eRVIk6ZXcNXAtpqvbR7IG+lLE/gNEtfcW61m66NmAYf4SVD/IabZX+tlBwmYFNhs0SeBrRrDBB7dhDF/s7cQQweFw2oZpIGT6D1iO4vKmrKQaDq4l2TcDPVqOmIfU0G+Gd1Vh3MvikDYOoCUfBLj4QeUzkQGr5sKWMxUypkw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714516699; c=relaxed/simple;
	bh=csOoGmAfntY21DBypBODKsbOQpLhizP4aBW+BO070yU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YzqwXbfyBVAyI7046mkCGVqQlb0Q98h8ECRalfzOk89zQiteHidNN9RwQqlz+Lbul/lrhDUkOkBGeHSnt5C2DJXGT8CJsf9T5LV3hE3yd5r8b0Mwg+o2k54E/FQTULKiQcjAW8sVg2xjRcao4rP2lLYCIL3RedEK47krtoHAfa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=X3NwAcyT; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714516689;
	bh=lCLxfsMlPBoiPmZZeynvw5FpSOeZ67s9YOCt1JlEqV8=;
	h=Date:From:To:Cc:Subject:From;
	b=X3NwAcyT7lXtul0O9VwUDkrzGauj0DUWzfVlrlM4Rf2ShI3qrG5vs2WDXDG9C4Rr0
	 zouZfV8VLxQNwCWGU2iIYgS6kVQpgqEOU8T87xqoQsYIqaFTuL4ITKV6cEVz7Ne7wn
	 YOjiXa4XqiXwKSehO1+lpOHwAUBGZ0dqlvTYMqELCItGu4szJZwY0IcoW/EOKaxKk4
	 fEvgPOXsyp8stVUb0OYi0C0+3+8rjoWu+nl0eDvqvGIG/EcsZwGknrP7tn08akdjiY
	 EgLgrM0Cn2R+9AygHDkzS7+GqO2Qzsj7PAmkBbQH18wPsk0olFbOmvuaj038S4NFzM
	 PiaCVX87zNU8Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VTZpl5rcvz4x0v;
	Wed,  1 May 2024 08:38:06 +1000 (AEST)
Date: Wed, 1 May 2024 08:38:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Wu Hao
 <hao.wu@intel.com>, Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the fpga-fixes tree
Message-ID: <20240501083805.76e87698@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/otmDCSYlh0gcg8pw6rP508o";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/otmDCSYlh0gcg8pw6rP508o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the char-misc.current tree as a different
commit (but the same patch):

  54435d1f21b3 ("fpga: dfl-pci: add PCI subdevice ID for Intel D5005 card")

This is commit

  bb1dbeceb1c2 ("fpga: dfl-pci: add PCI subdevice ID for Intel D5005 card")

in the char-misc.current tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/otmDCSYlh0gcg8pw6rP508o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYxcs0ACgkQAVBC80lX
0GztJwf9GeNKSLwoaTY/PxLBi5EAUZ2JWD3f8n93sjgT3jQKPjNv4/v70sxHrwQt
Z++ZzjOGCaYD8AwClRAiqY1DZ9SzAzIoMc6e5xFNtF9YFJ+P2owletx7CHFd+pio
R9jSvw4/hxDwuPqyUkCbMl21jhxc9ySRSFIvE4AbwThVdEkb6Eh2h3l8bYgCpKfT
EISOo5uSvJJrPPuHRNhcpnAdMcfsD3hBo2wJvMcjDVmdbZbY0GbvYthrrKRwfIjd
oVJBOwdXPI238000wRUdXUKsVH0PRtoV5Y5fU4XlMEKH971UP6nzJCG6BB+jzcKA
RF3Zeej1TZRMdR+ASCt5oDBdBidlTQ==
=lCR/
-----END PGP SIGNATURE-----

--Sig_/otmDCSYlh0gcg8pw6rP508o--

