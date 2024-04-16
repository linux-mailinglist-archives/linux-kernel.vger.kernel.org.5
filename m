Return-Path: <linux-kernel+bounces-146172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 173318A61A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 548F7B230E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440FF210FF;
	Tue, 16 Apr 2024 03:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="S08gqgfs"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C3618EAB;
	Tue, 16 Apr 2024 03:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237750; cv=none; b=NSyr4dzYxY5jtzHusc8bi88TA+n331c2YG8ctraxDWBIglrB/yjIb92bDUiz0e+bfHFCMIeVjlbDxP85qR9BvP2xWu+QwBrNRC0w2mL+jn+Wxo4P8W65an577hAUUwSUOyBFKkcyycmKmPnkqu3N8O1vtATWYGwToWxUYTIkYOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237750; c=relaxed/simple;
	bh=/kIuOVQ2OfQ7lom6ijNUtkC2AnMyJG/hfsfg/zG6B9c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jfH38B8KTDxg5hGvCO5t1pCEMC1Ao2VkFaRvIE7BOMM0oxi6NqCmwFthme3FF6navLW+5fv6VkG+gRHGVme82zu13BKbX6wX5ksxrR8xXD9vjqm/ssuWhc/ou7dtpvxsa3Nn/KYRRg5wvjO9zEp30Z6oi2ZcbtCO/ZXNdBECTiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=S08gqgfs; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713237745;
	bh=J+mM5EFk8VTbYECfOfC98Quq+ELkts5dipJhBuxwWBQ=;
	h=Date:From:To:Cc:Subject:From;
	b=S08gqgfsh+t0jeWwwhVlJAhjtzleAkE28PXv8/rBc+PxXL1fv+T9IO3JyMX0GE7mW
	 Tt+PbYPX5x73y2fAgvHtIi4SPM9Xo1qFDUpOiy653olkOnogEPZ3NPgVdbwR8OWyLc
	 k6OM8CKtEF8hXWPuanR446ArRUeUL/BTGyy49xe7+tp9Wx52xpyxdkVzCJPF6bULOS
	 M7Byf2h+TV3kGkH5FbpkbUu6wy1oT0K+4Xe6oqxrNYNqVkq+GPxUwrCH3P8V/9OL/w
	 +8DK6kA6wFIZjGF6Ajn2HUr1tCsGK3wwd1oZv7gp+8Z4kr8WB4DR/A2tLwx8xk4tQo
	 cGv9RUf6j9RNw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VJTqh3Sv2z4wnv;
	Tue, 16 Apr 2024 13:22:23 +1000 (AEST)
Date: Tue, 16 Apr 2024 13:22:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Joerg Roedel <joro@8bytes.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Joerg Roedel <jroedel@suse.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Suren Baghdasaryan <surenb@google.com>
Subject: linux-next: manual merge of the iommu tree with the mm tree
Message-ID: <20240416132223.30cfa738@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Pp21j7jO67/SCbfQcyKW.x7";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Pp21j7jO67/SCbfQcyKW.x7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iommu tree got a conflict in:

  drivers/iommu/amd/amd_iommu.h

between commit:

  b74d58079a28 ("mm: change inlined allocation helpers to account at the ca=
ll site")

from the mm-unstable branch of the mm tree and commit:

  75114cbaa136 ("iommu/amd: use page allocation function provided by iommu-=
pages.h")

from the iommu tree.

I fixed it up (the latter removed the function changed by the former) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Pp21j7jO67/SCbfQcyKW.x7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYd7u8ACgkQAVBC80lX
0GxzQgf+I08KmA7KJLs+X1vVsUvsAE7GzFusRjc6TpEwKVlN21DOJML1UVrBLtPx
iVmybPL5JaGd8cuwROWX5ovbJNMbaI2nR2y0W605FuWcq5jvspiEkazpAurnowiX
3GqrHZ0hiIwYkc2SccfslxxXRgwjGtsZMDe18QYw3Ahwu0oXc+zKUUxjbklHACou
1b43yo+pdg/yLW7/rA/H1QRgE/Ufseh9KkFsOCtJDJqEumH6HCy9AsK+4OfOTArG
QQYlCzVuaa0kcLBMYWFHSCDlCTWv/R/kJwqpzaJpayXLdWR6Dny2N4Odr81dcOoU
qnmbbhzQJXdjYKvTdl2kRh7aT9vcyg==
=FPR+
-----END PGP SIGNATURE-----

--Sig_/Pp21j7jO67/SCbfQcyKW.x7--

