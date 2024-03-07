Return-Path: <linux-kernel+bounces-96237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AF9875914
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494BD1F25175
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F9C13A871;
	Thu,  7 Mar 2024 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="W3ldtZQ7"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D89C24B33;
	Thu,  7 Mar 2024 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845816; cv=none; b=c+bjHdWA4//Lk2ivz6O8mi/2OpS5tKYH2dJikPz28UMCrFgwVDgMtthiV9pMf0EH8Xako2A7MdkIk0HS71POxf0Kc/+gCYOyjopCK/0Xf0FF8+4Ez/jvnJSOru36iEuT+PAr+TflNfzCJx0vDsPHyPuWWGMJTdrrvTlW4+q/HLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845816; c=relaxed/simple;
	bh=n7ZPAEB1dZvHDu6WJsouZl5c+u9Qw0zlF94qU5Cjkzo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Vca9fne0UyCEKnqoREz7Urn0uy+k8QL20co+5H3jjnCdA7KB3sudYF8TF5L3reNbiCWmsRoR47hElhX794zlxnBUBDACeB/9OkqLuR70lVT4yOm1YP2/wDrsaH5dQs6VwSlKOrgIAmG8uHzaZEkk0o7ghxhBrjySCpz/klnQc+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=W3ldtZQ7; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709845808;
	bh=HJI9tF6FIkF6n8qrUGTmQmO2iIl1wcZEqvCMKy+tnAk=;
	h=Date:From:To:Cc:Subject:From;
	b=W3ldtZQ7dk2Bj4KjtkobcEOthOCEJ8zZA2Bbt6ipH84xFsvGDqOGZ+uq9/qWFPZ/Z
	 24ic1CJsC3DPHibkJq0R+7xRd73/CSpx13LRYGCawbEAKvkJpsdp+N+RGjJe6ReRf8
	 gPwiFFfkSUwVk/9A5iDIERTF8eXMyF5ULRWVAACvjLwB4Fp08jFCs5SSIiBbt4BkpJ
	 vcmvDlvoJjtmopzyEkE+pO3SSFQhPIz316ldzVSFMxk0/3vQ9xdbxh/UVv6jjptU9H
	 ldCf7flsI7yNI/5lFbRNFZrCseFS9v9wx8hOBawEqYKP+YI2NZDqqQdmVKBFbzrgM/
	 6Fu3sTjBXctYQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TrMQ84WRxz4wbh;
	Fri,  8 Mar 2024 08:10:08 +1100 (AEDT)
Date: Fri, 8 Mar 2024 08:10:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the devfreq tree
Message-ID: <20240308081006.71f649bd@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lFgNFA=qnojv9B1H3Hw/y1z";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/lFgNFA=qnojv9B1H3Hw/y1z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  82d49b84535a ("PM / devfreq: mtk-cci: Convert to platform remove callback=
 returning void")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/lFgNFA=qnojv9B1H3Hw/y1z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXqLS4ACgkQAVBC80lX
0GwVfAf+MtMArAdj/8FvircPg9jrWf7WYi5+Sa1HD6O42vyolbcEwO3OC+1tfIvr
rSoi0nHHNEmI/lVkg+QJWJWDxIxE9aCXUwE813xr0vR1gLNf9hAD5QEPzGkcc1ab
xaH1KXAd4tzwe3adtt4MgvmqdKWaEYNHeml5yoGN4Rv0bB2GXN2tZQ4UMG39+yjx
kZ7p/CtPN3b8TVRXcJNPp9JO2ofun5TpCCTHgzEVqz7XAlcFFB5tCBbXKXLEi5zP
y3a6XmVWBkn9+7Ox2OK0wDMhyYWtRirI9bT2XZA3EHWJfzvfEew76gCnOuFo6ikB
PDkbZn2RbzbQwA/LzeUQ66II1RDTbQ==
=vcfk
-----END PGP SIGNATURE-----

--Sig_/lFgNFA=qnojv9B1H3Hw/y1z--

